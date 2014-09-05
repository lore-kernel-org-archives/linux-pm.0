From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 2/2] sched/fair: leverage the idle state info when
 choosing the "idlest" cpu
Date: Fri, 05 Sep 2014 09:52:53 +0200
Message-ID: <54096BD5.4030803@linaro.org>
References: <1409844730-12273-1-git-send-email-nicolas.pitre@linaro.org> <1409844730-12273-3-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:63936 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbaIEHw5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 03:52:57 -0400
Received: by mail-wi0-f171.google.com with SMTP id hi2so332359wib.16
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2014 00:52:56 -0700 (PDT)
In-Reply-To: <1409844730-12273-3-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org

On 09/04/2014 05:32 PM, Nicolas Pitre wrote:
> The code in find_idlest_cpu() looks for the CPU with the smallest loa=
d.
> However, if multiple CPUs are idle, the first idle CPU is selected
> irrespective of the depth of its idle state.
>
> Among the idle CPUs we should pick the one with with the shallowest i=
dle
> state, or the latest to have gone idle if all idle CPUs are in the sa=
me
> state.  The later applies even when cpuidle is configured out.
>
> This patch doesn't cover the following issues:
>
> - The idle exit latency of a CPU might be larger than the time needed
>    to migrate the waking task to an already running CPU with sufficie=
nt
>    capacity, and therefore performance would benefit from task packin=
g
>    in such case (in most cases task packing is about power saving).
>
> - Some idle states have a non negligible and non abortable entry late=
ncy
>    which needs to run to completion before the exit latency can start=
=2E
>    A concurrent patch series is making this info available to the cpu=
idle
>    core.  Once available, the entry latency with the idle timestamp c=
ould
>    determine when the exit latency may be effective.
>
> Those issues will be handled in due course.  In the mean time, what
> is implemented here should improve things already compared to the cur=
rent
> state of affairs.
>
> Based on an initial patch from Daniel Lezcano.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Sounds good for me.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   kernel/sched/fair.c | 43 ++++++++++++++++++++++++++++++++++++------=
-
>   1 file changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bfa3c86d0d..416329e1a6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -23,6 +23,7 @@
>   #include <linux/latencytop.h>
>   #include <linux/sched.h>
>   #include <linux/cpumask.h>
> +#include <linux/cpuidle.h>
>   #include <linux/slab.h>
>   #include <linux/profile.h>
>   #include <linux/interrupt.h>
> @@ -4428,20 +4429,48 @@ static int
>   find_idlest_cpu(struct sched_group *group, struct task_struct *p, i=
nt this_cpu)
>   {
>   	unsigned long load, min_load =3D ULONG_MAX;
> -	int idlest =3D -1;
> +	unsigned int min_exit_latency =3D UINT_MAX;
> +	u64 latest_idle_timestamp =3D 0;
> +	int least_loaded_cpu =3D this_cpu;
> +	int shallowest_idle_cpu =3D -1;
>   	int i;
>
>   	/* Traverse only the allowed CPUs */
>   	for_each_cpu_and(i, sched_group_cpus(group), tsk_cpus_allowed(p)) =
{
> -		load =3D weighted_cpuload(i);
> -
> -		if (load < min_load || (load =3D=3D min_load && i =3D=3D this_cpu)=
) {
> -			min_load =3D load;
> -			idlest =3D i;
> +		if (idle_cpu(i)) {
> +			struct rq *rq =3D cpu_rq(i);
> +			struct cpuidle_state *idle =3D idle_get_state(rq);
> +			if (idle && idle->exit_latency < min_exit_latency) {
> +				/*
> +				 * We give priority to a CPU whose idle state
> +				 * has the smallest exit latency irrespective
> +				 * of any idle timestamp.
> +				 */
> +				min_exit_latency =3D idle->exit_latency;
> +				latest_idle_timestamp =3D rq->idle_stamp;
> +				shallowest_idle_cpu =3D i;
> +			} else if ((!idle || idle->exit_latency =3D=3D min_exit_latency) =
&&
> +				   rq->idle_stamp > latest_idle_timestamp) {
> +				/*
> +				 * If equal or no active idle state, then
> +				 * the most recently idled CPU might have
> +				 * a warmer cache.
> +				 */
> +				latest_idle_timestamp =3D rq->idle_stamp;
> +				shallowest_idle_cpu =3D i;
> +			}
> +			cpuidle_put_state(rq);
> +		} else {
> +			load =3D weighted_cpuload(i);
> +			if (load < min_load ||
> +			    (load =3D=3D min_load && i =3D=3D this_cpu)) {
> +				min_load =3D load;
> +				least_loaded_cpu =3D i;
> +			}
>   		}
>   	}
>
> -	return idlest;
> +	return shallowest_idle_cpu !=3D -1 ? shallowest_idle_cpu : least_lo=
aded_cpu;
>   }
>
>   /*
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

