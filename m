From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/3] sched/fair: add util_est on top of PELT
Date: Mon, 29 Jan 2018 17:36:42 +0100
Message-ID: <20180129163642.GF2228@hirez.programming.kicks-ass.net>
References: <20180123180847.4477-1-patrick.bellasi@arm.com>
 <20180123180847.4477-2-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:43409 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbeA2Qgt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jan 2018 11:36:49 -0500
Content-Disposition: inline
In-Reply-To: <20180123180847.4477-2-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>

On Tue, Jan 23, 2018 at 06:08:45PM +0000, Patrick Bellasi wrote:
> +static inline void util_est_dequeue(struct task_struct *p, int flags)
> +{
> +	struct cfs_rq *cfs_rq = &task_rq(p)->cfs;
> +	unsigned long util_last = task_util(p);
> +	bool sleep = flags & DEQUEUE_SLEEP;
> +	unsigned long ewma;
> +	long util_est = 0;
> +
> +	if (!sched_feat(UTIL_EST))
> +		return;
> +
> +	/*
> +	 * Update root cfs_rq's estimated utilization
> +	 *
> +	 * If *p is the last task then the root cfs_rq's estimated utilization
> +	 * of a CPU is 0 by definition.
> +	 */
> +	if (cfs_rq->nr_running) {
> +		util_est  = READ_ONCE(cfs_rq->util_est_runnable);
> +		util_est -= min_t(long, util_est, task_util_est(p));
> +	}
> +	WRITE_ONCE(cfs_rq->util_est_runnable, util_est);
> +
> +	/*
> +	 * Skip update of task's estimated utilization when the task has not
> +	 * yet completed an activation, e.g. being migrated.
> +	 */
> +	if (!sleep)
> +		return;
> +

Since you only use sleep once, you might as well write it out there.

Also, does GCC lower the task_util() eval to here?

> +        /*
> +         * Skip update of task's estimated utilization when its EWMA is already
> +         * ~1% close to its last activation value.
> +         */
> +        util_est = p->util_est.ewma;
> +        if (abs(util_est - util_last) <= (SCHED_CAPACITY_SCALE / 100))
> +                return;

Aside from that being whitespace challenged, did you also try:

	if ((unsigned)((util_est - util_last) + LIM - 1) < (2 * LIM - 1))

Also, since we only care about the absolute value; we could use:

	util_last - ewma

here (note the above also forgets to use READ_ONCE), and reuse the result:

> +
> +	/*
> +	 * Update Task's estimated utilization
> +	 *
> +	 * When *p completes an activation we can consolidate another sample
> +	 * about the task size. This is done by storing the last PELT value
> +	 * for this task and using this value to load another sample in the
> +	 * exponential weighted moving average:
> +	 *
> +	 *      ewma(t) = w *  task_util(p) + (1 - w) ewma(t-1)
> +	 *              = w *  task_util(p) + ewma(t-1) - w * ewma(t-1)
> +	 *              = w * (task_util(p) + ewma(t-1) / w - ewma(t-1))
> +	 *
> +	 * Where 'w' is the weight of new samples, which is configured to be
> +	 * 0.25, thus making w=1/4
> +	 */
> +	p->se.avg.util_est.last = util_last;
> +	ewma = READ_ONCE(p->se.avg.util_est.ewma);
> +	ewma   = util_last + (ewma << UTIL_EST_WEIGHT_SHIFT) - ewma;

here.

> +	ewma >>= UTIL_EST_WEIGHT_SHIFT;
> +	WRITE_ONCE(p->se.avg.util_est.ewma, ewma);
> +}


So something along these lines:

	ewma = READ_ONCE(p->se.avg.util_est.ewma);
	diff = util_last - ewma;
	if ((unsigned)(diff + LIM - 1) < (2 * LIM - 1))
		return;

	p->se.avg.util_est.last = util_last;
	ewma = (diff + (ewma << EWMA_SHIFT)) >> EWMA_SHIFT;
	WRITE_ONCE(p->se.avg.util_est.ewma, ewma);

Make sense?
