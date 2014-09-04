From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] sched: Add new API wake_up_if_idle() to wake up the
 idle cpu
Date: Thu, 04 Sep 2014 14:53:00 +0200
Message-ID: <540860AC.3030905@linaro.org>
References: <1409815075-4180-1-git-send-email-chuansheng.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:60293 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbaIDMxG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:53:06 -0400
Received: by mail-we0-f170.google.com with SMTP id p10so10219511wes.29
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:53:04 -0700 (PDT)
In-Reply-To: <1409815075-4180-1-git-send-email-chuansheng.liu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>, peterz@infradead.org, luto@amacapital.net, rjw@rjwysocki.net, mingo@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, changcheng.liu@intel.com, xiaoming.wang@intel.com, souvik.k.chakravarty@intel.com

On 09/04/2014 09:17 AM, Chuansheng Liu wrote:
> Implementing one new API wake_up_if_idle(), which is used to
> wake up the idle CPU.
>
> Suggested-by: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>

Hi Chuanseng,

in the future, please prefix the patches with the version number and a=20
changelog.

Thanks

   -- Daniel

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   include/linux/sched.h |    1 +
>   kernel/sched/core.c   |   19 +++++++++++++++++++
>   2 files changed, 20 insertions(+)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 857ba40..3f89ac1 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1024,6 +1024,7 @@ struct sched_domain_topology_level {
>   extern struct sched_domain_topology_level *sched_domain_topology;
>
>   extern void set_sched_topology(struct sched_domain_topology_level *=
tl);
> +extern void wake_up_if_idle(int cpu);
>
>   #ifdef CONFIG_SCHED_DEBUG
>   # define SD_INIT_NAME(type)		.name =3D #type
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1211575..b818548 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1620,6 +1620,25 @@ static void ttwu_queue_remote(struct task_stru=
ct *p, int cpu)
>   	}
>   }
>
> +void wake_up_if_idle(int cpu)
> +{
> +	struct rq *rq =3D cpu_rq(cpu);
> +	unsigned long flags;
> +
> +	if (!is_idle_task(rq->curr))
> +		return;
> +
> +	if (set_nr_if_polling(rq->idle)) {
> +		trace_sched_wake_idle_without_ipi(cpu);
> +	} else {
> +		raw_spin_lock_irqsave(&rq->lock, flags);
> +		if (is_idle_task(rq->curr))
> +			smp_send_reschedule(cpu);
> +		/* Else cpu is not in idle, do nothing here */
> +		raw_spin_unlock_irqrestore(&rq->lock, flags);
> +	}
> +}
> +
>   bool cpus_share_cache(int this_cpu, int that_cpu)
>   {
>   	return per_cpu(sd_llc_id, this_cpu) =3D=3D per_cpu(sd_llc_id, that=
_cpu);
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

