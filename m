From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [RFCv5 PATCH 25/46] sched: Add over-utilization/tipping point
 indicator
Date: Mon, 17 Aug 2015 21:10:42 +0800
Message-ID: <20150817131042.GB31366@leoy-linaro>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-26-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36186 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbbHQNKx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2015 09:10:53 -0400
Received: by pawq9 with SMTP id q9so10819228paw.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2015 06:10:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436293469-25707-26-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:24:08PM +0100, Morten Rasmussen wrote:
> Energy-aware scheduling is only meant to be active while the system is
> _not_ over-utilized. That is, there are spare cycles available to shift
> tasks around based on their actual utilization to get a more
> energy-efficient task distribution without depriving any tasks. When
> above the tipping point task placement is done the traditional way,
> spreading the tasks across as many cpus as possible based on priority
> scaled load to preserve smp_nice.
> 
> The over-utilization condition is conservatively chosen to indicate
> over-utilization as soon as one cpu is fully utilized at it's highest
> frequency. We don't consider groups as lumping usage and capacity
> together for a group of cpus may hide the fact that one or more cpus in
> the group are over-utilized while group-siblings are partially idle. The
> tasks could be served better if moved to another group with completely
> idle cpus. This is particularly problematic if some cpus have a
> significantly reduced capacity due to RT/IRQ pressure or if the system
> has cpus of different capacity (e.g. ARM big.LITTLE).
> 
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> 
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> ---
>  kernel/sched/fair.c  | 35 +++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h |  3 +++
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bf1d34c..99e43ee 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4281,6 +4281,8 @@ static inline void hrtick_update(struct rq *rq)
>  }
>  #endif
>  
> +static bool cpu_overutilized(int cpu);
> +
>  /*
>   * The enqueue_task method is called before nr_running is
>   * increased. Here we update the fair scheduling stats and
> @@ -4291,6 +4293,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  {
>  	struct cfs_rq *cfs_rq;
>  	struct sched_entity *se = &p->se;
> +	int task_new = !(flags & ENQUEUE_WAKEUP);
>  
>  	for_each_sched_entity(se) {
>  		if (se->on_rq)
> @@ -4325,6 +4328,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	if (!se) {
>  		update_rq_runnable_avg(rq, rq->nr_running);
>  		add_nr_running(rq, 1);
> +		if (!task_new && !rq->rd->overutilized &&
> +		    cpu_overutilized(rq->cpu))
> +			rq->rd->overutilized = true;

Maybe this is a stupid question, the root domain's overutilized value is
shared by all CPUs; so just curious if need lock to protect this
variable or use atmomic type for it?

[...]

Thanks,
Leo Yan
