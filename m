From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/4] sched/fair: add util_est on top of PELT
Date: Wed, 13 Dec 2017 17:16:24 +0100
Message-ID: <20171213161624.oiwdwgitzzwkc35k@hirez.programming.kicks-ass.net>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
 <20171205171018.9203-3-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171205171018.9203-3-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 05, 2017 at 05:10:16PM +0000, Patrick Bellasi wrote:
> +static inline void util_est_dequeue(struct task_struct *p, int flags)
> +{
> +	struct cfs_rq *cfs_rq = &task_rq(p)->cfs;
> +	unsigned long util_last = task_util(p);
> +	bool sleep = flags & DEQUEUE_SLEEP;
> +	unsigned long ewma;
> +	long util_est;
> +
> +	if (!sched_feat(UTIL_EST))
> +		return;
> +
> +	/*
> +	 * Update root cfs_rq's estimated utilization
> +	 *
> +	 * If *p is the last task then the root cfs_rq's estimated utilization
> +	 * of a CPU is 0 by definition.
> +	 *
> +	 * Otherwise, in removing *p's util_est from its cfs_rq's
> +	 * util_est_runnable we should account for cases where this last
> +	 * activation of *p was longer then the previous ones.
> +	 * Also in these cases we need to set 0 the estimated utilization for
> +	 * the CPU.
> +	 */
> +	if (cfs_rq->nr_running > 0) {
> +		util_est  = cfs_rq->util_est_runnable;
> +		util_est -= task_util_est(p);
> +		if (util_est < 0)
> +			util_est = 0;
> +		cfs_rq->util_est_runnable = util_est;
> +	} else {
> +		cfs_rq->util_est_runnable = 0;
> +	}
> +
> +	/*
> +	 * Skip update of task's estimated utilization when the task has not
> +	 * yet completed an activation, e.g. being migrated.
> +	 */
> +	if (!sleep)
> +		return;
> +
> +	/*
> +	 * Skip update of task's estimated utilization when its EWMA is already
> +	 * ~1% close to its last activation value.
> +	 */
> +	util_est = p->util_est.ewma;
> +	if (abs(util_est - util_last) <= (SCHED_CAPACITY_SCALE / 100))
> +		return;

Isn't that computation almost as expensive as the stuff you're trying to
avoid?

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
> +	p->util_est.last = util_last;
> +	ewma = p->util_est.ewma;
> +	if (likely(ewma != 0)) {

Why special case 0? Yes it helps with the initial ramp-on, but would not
an asymmetric IIR (with a consistent upward bias) be better?

> +		ewma   = util_last + (ewma << UTIL_EST_WEIGHT_SHIFT) - ewma;
> +		ewma >>= UTIL_EST_WEIGHT_SHIFT;
> +	} else {
> +		ewma = util_last;
> +	}
> +	p->util_est.ewma = ewma;
> +}
