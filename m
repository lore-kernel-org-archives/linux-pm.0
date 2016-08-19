From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH] sched: fix incorrect PELT values on SMT
Date: Fri, 19 Aug 2016 10:30:36 +0800
Message-ID: <CANRm+CwDNDNEDjtgooFVvdDfzBwC+akopOss9J0nhmT8Vt94Mg@mail.gmail.com>
References: <1471571741-19504-1-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33967 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932393AbcHSCao (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Aug 2016 22:30:44 -0400
In-Reply-To: <1471571741-19504-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>

2016-08-19 9:55 GMT+08:00 Steve Muckle <steve.muckle@linaro.org>:
> PELT scales its util_sum and util_avg values via
> arch_scale_cpu_capacity(). If that function is passed the CPU's sched
> domain then it will reduce the scaling capacity if SD_SHARE_CPUCAPACITY
> is set. PELT does not pass in the sd however. The other caller of
> arch_scale_cpu_capacity, update_cpu_capacity(), does. This means
> util_sum and util_avg scale beyond the CPU capacity on SMT.
>
> On an Intel i7-3630QM for example rq->cpu_capacity_orig is 589 but
> util_avg scales up to 1024.
>
> Fix this by passing in the sd in __update_load_avg() as well.

I believe we notice this at least several months ago.
https://lkml.org/lkml/2016/5/25/228

>
> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 61d485421bed..95d34b337152 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2731,7 +2731,7 @@ __update_load_avg(u64 now, int cpu, struct sched_avg *sa,
>         sa->last_update_time = now;
>
>         scale_freq = arch_scale_freq_capacity(NULL, cpu);
> -       scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
> +       scale_cpu = arch_scale_cpu_capacity(cpu_rq(cpu)->sd, cpu);
>
>         /* delta_w is the amount already accumulated against our next period */
>         delta_w = sa->period_contrib;
> --
> 2.7.3
>



-- 
Regards,
Wanpeng Li
