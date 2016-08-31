From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] sched: cpufreq: ignore SMT when determining max cpu capacity
Date: Wed, 31 Aug 2016 03:27:30 +0200
Message-ID: <2411837.FJm8ec21FH@vostro.rjw.lan>
References: <1472236848-17038-1-git-send-email-smuckle@linaro.org> <1472236848-17038-2-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58915 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751154AbcHaB2V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2016 21:28:21 -0400
In-Reply-To: <1472236848-17038-2-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>

On Friday, August 26, 2016 11:40:47 AM Steve Muckle wrote:
> PELT does not consider SMT when scaling its utilization values via
> arch_scale_cpu_capacity(). The value in rq->cpu_capacity_orig does
> take SMT into consideration though and therefore may be smaller than
> the utilization reported by PELT.
> 
> On an Intel i7-3630QM for example rq->cpu_capacity_orig is 589 but
> util_avg scales up to 1024. This means that a 50% utilized CPU will show
> up in schedutil as ~86% busy.
> 
> Fix this by using the same CPU scaling value in schedutil as that which
> is used by PELT.
> 
> Signed-off-by: Steve Muckle <smuckle@linaro.org>

This is fine by me.

Peter, any objections?

> ---
>  kernel/sched/cpufreq_schedutil.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 60d985f4dc47..cb8a77b1ef1b 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -147,7 +147,9 @@ static unsigned int get_next_freq(struct sugov_cpu *sg_cpu, unsigned long util,
>  static void sugov_get_util(unsigned long *util, unsigned long *max)
>  {
>  	struct rq *rq = this_rq();
> -	unsigned long cfs_max = rq->cpu_capacity_orig;
> +	unsigned long cfs_max;
> +
> +	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
>  
>  	*util = min(rq->cfs.avg.util_avg, cfs_max);
>  	*max = cfs_max;
> 

Thanks,
Rafael

