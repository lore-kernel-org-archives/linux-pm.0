From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 11/46] sched: Remove blocked load and utilization
 contributions of dying tasks
Date: Tue, 11 Aug 2015 13:39:27 +0200
Message-ID: <20150811113927.GT19282@twins.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-12-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58105 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934028AbbHKLjj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 07:39:39 -0400
Content-Disposition: inline
In-Reply-To: <1436293469-25707-12-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:23:54PM +0100, Morten Rasmussen wrote:
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
>  	dequeue_entity_load_avg(cfs_rq, se, flags & DEQUEUE_SLEEP);
>  
>  	update_stats_dequeue(cfs_rq, se);

I know this is entirely redundant at this point (we took Yuyang's
patches), but this is the wrong way to go about doing this.

You add extra code the hot dequeue path for something that 'never'
happens. We have the sched_class::task_dead call for that.
