From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [RFCv5 PATCH 11/46] sched: Remove blocked load and utilization
 contributions of dying tasks
Date: Wed, 22 Jul 2015 14:51:01 +0800
Message-ID: <20150722065101.GA719@leoy-linaro>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-12-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33229 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754701AbbGVGvL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 02:51:11 -0400
Received: by pdbnt7 with SMTP id nt7so62851034pdb.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2015 23:51:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436293469-25707-12-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:23:54PM +0100, Morten Rasmussen wrote:
> Tasks being dequeued for the last time (state == TASK_DEAD) are dequeued
> with the DEQUEUE_SLEEP flag which causes their load and utilization
> contributions to be added to the runqueue blocked load and utilization.
> Hence they will contain load or utilization that is gone away. The issue
> only exists for the root cfs_rq as cgroup_exit() doesn't set
> DEQUEUE_SLEEP for task group exits.
> 
> If runnable+blocked load is to be used as a better estimate for cpu
> load the dead task contributions need to be removed to prevent
> load_balance() (idle_balance() in particular) from over-estimating the
> cpu load.
> 
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> 
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> ---
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 775b0c7..fa12ce5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3217,6 +3217,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	 * Update run-time statistics of the 'current'.
>  	 */
>  	update_curr(cfs_rq);
> +	if (entity_is_task(se) && task_of(se)->state == TASK_DEAD)
> +		flags &= !DEQUEUE_SLEEP;

So flags will be set to zero? Could be replaced by "flags &= ~DEQUEUE_SLEEP"?

>  	dequeue_entity_load_avg(cfs_rq, se, flags & DEQUEUE_SLEEP);
>  
>  	update_stats_dequeue(cfs_rq, se);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
