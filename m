From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/4] sched / idle: Call default_idle_call() from cpuidle_enter_state()
Date: Mon, 04 May 2015 17:04:08 +0200
Message-ID: <55478A68.8060902@linaro.org>
References: <3084951.QaIkFrZ3VU@vostro.rjw.lan> <3809765.j45t3RE71A@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:32896 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbbEDPEM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 11:04:12 -0400
Received: by wgin8 with SMTP id n8so152984230wgi.0
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2015 08:04:11 -0700 (PDT)
In-Reply-To: <3809765.j45t3RE71A@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 05/04/2015 03:58 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The check of the cpuidle_enter() return value against -EBUSY
> made in call_cpuidle() will not be necessary any more if
> cpuidle_enter_state() calls default_idle_call() directly when it
> is about to return -EBUSY, so make that happen and eliminate the
> check.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 >
> ---
>   drivers/cpuidle/cpuidle.c |    4 +++-
>   drivers/cpuidle/cpuidle.h |    2 ++
>   kernel/sched/idle.c       |   14 ++++++--------
>   3 files changed, 11 insertions(+), 9 deletions(-)
>
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -167,8 +167,10 @@ int cpuidle_enter_state(struct cpuidle_d
>   	 * local timer will be shut down.  If a local timer is used from a=
nother
>   	 * CPU as a broadcast timer, this call may fail if it is not avail=
able.
>   	 */
> -	if (broadcast && tick_broadcast_enter())
> +	if (broadcast && tick_broadcast_enter()) {
> +		default_idle_call();
>   		return -EBUSY;
> +	}
>
>   	trace_cpu_idle_rcuidle(index, dev->cpu);
>   	time_start =3D ktime_get();
> Index: linux-pm/drivers/cpuidle/cpuidle.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpuidle/cpuidle.h
> +++ linux-pm/drivers/cpuidle/cpuidle.h
> @@ -18,6 +18,8 @@ extern int cpuidle_enter_state(struct cp
>   /* idle loop */
>   extern void cpuidle_install_idle_handler(void);
>   extern void cpuidle_uninstall_idle_handler(void);
> +/* kernel/sched/idle.c */
> +extern void default_idle_call(void);

There is a cyclic dependency introduced with this function.

idle.c <=3D> cpuidle.c

Are we sure we want them to be mutually dependent ?

>   /* governors */
>   extern int cpuidle_switch_governor(struct cpuidle_governor *gov);
> Index: linux-pm/kernel/sched/idle.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -67,11 +67,12 @@ void __weak arch_cpu_idle(void)
>   	local_irq_enable();
>   }
>
> -static void default_idle_call(void) {
> -	/*
> -	 * We can't use the cpuidle framework, let's use the default idle
> -	 * routine.
> -	 */
> +/**
> + * default_idle_call - Default CPU idle routine.
> + *
> + * To use when the cpuidle framework cannot be used.
> + */
> +void default_idle_call(void) {

Same comment as Peter on the patch 1/4.

>   	if (current_clr_polling_and_test())
>   		local_irq_enable();
>   	else
> @@ -112,9 +113,6 @@ static int call_cpuidle(struct cpuidle_d
>   	/* The cpu is no longer idle or about to enter idle. */
>   	idle_set_state(this_rq(), NULL);
>
> -	if (entered_state =3D=3D -EBUSY)
> -		default_idle_call();
> -
>   	return entered_state;
>   }
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

