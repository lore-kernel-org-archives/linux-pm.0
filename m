From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 2/4] sched/fair: add util_est on top of PELT
Date: Fri, 15 Dec 2017 12:14:17 +0000
Message-ID: <20171215121417.GB19821@e110439-lin>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
 <20171205171018.9203-3-patrick.bellasi@arm.com>
 <20171213161624.oiwdwgitzzwkc35k@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55052 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755024AbdLOMOW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Dec 2017 07:14:22 -0500
Content-Disposition: inline
In-Reply-To: <20171213161624.oiwdwgitzzwkc35k@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 13-Dec 17:16, Peter Zijlstra wrote:
> On Tue, Dec 05, 2017 at 05:10:16PM +0000, Patrick Bellasi wrote:
> > +static inline void util_est_dequeue(struct task_struct *p, int flags)
> > +{
> > +	struct cfs_rq *cfs_rq = &task_rq(p)->cfs;
> > +	unsigned long util_last = task_util(p);
> > +	bool sleep = flags & DEQUEUE_SLEEP;
> > +	unsigned long ewma;
> > +	long util_est;
> > +
> > +	if (!sched_feat(UTIL_EST))
> > +		return;
> > +
> > +	/*
> > +	 * Update root cfs_rq's estimated utilization
> > +	 *
> > +	 * If *p is the last task then the root cfs_rq's estimated utilization
> > +	 * of a CPU is 0 by definition.
> > +	 *
> > +	 * Otherwise, in removing *p's util_est from its cfs_rq's
> > +	 * util_est_runnable we should account for cases where this last
> > +	 * activation of *p was longer then the previous ones.
> > +	 * Also in these cases we need to set 0 the estimated utilization for
> > +	 * the CPU.
> > +	 */
> > +	if (cfs_rq->nr_running > 0) {
> > +		util_est  = cfs_rq->util_est_runnable;
> > +		util_est -= task_util_est(p);
> > +		if (util_est < 0)
> > +			util_est = 0;
> > +		cfs_rq->util_est_runnable = util_est;
> > +	} else {
> > +		cfs_rq->util_est_runnable = 0;
> > +	}
> > +
> > +	/*
> > +	 * Skip update of task's estimated utilization when the task has not
> > +	 * yet completed an activation, e.g. being migrated.
> > +	 */
> > +	if (!sleep)
> > +		return;
> > +
> > +	/*
> > +	 * Skip update of task's estimated utilization when its EWMA is already
> > +	 * ~1% close to its last activation value.
> > +	 */
> > +	util_est = p->util_est.ewma;
> > +	if (abs(util_est - util_last) <= (SCHED_CAPACITY_SCALE / 100))
> > +		return;
> 
> Isn't that computation almost as expensive as the stuff you're trying to
> avoid?

Mmm... maybe slightly simpler. I'll profile it again but I remember
I've added it because it was slightly better on backbench.

This code at the end it's just a "sub" and a "compare to constant" and
it's likely to bail early for all "almost regular" tasks.

Are you worried about the branch overhead?

> > +	/*
> > +	 * Update Task's estimated utilization
> > +	 *
> > +	 * When *p completes an activation we can consolidate another sample
> > +	 * about the task size. This is done by storing the last PELT value
> > +	 * for this task and using this value to load another sample in the
> > +	 * exponential weighted moving average:
> > +	 *
> > +	 *      ewma(t) = w *  task_util(p) + (1 - w) ewma(t-1)
> > +	 *              = w *  task_util(p) + ewma(t-1) - w * ewma(t-1)
> > +	 *              = w * (task_util(p) + ewma(t-1) / w - ewma(t-1))
> > +	 *
> > +	 * Where 'w' is the weight of new samples, which is configured to be
> > +	 * 0.25, thus making w=1/4
> > +	 */
> > +	p->util_est.last = util_last;
> > +	ewma = p->util_est.ewma;
> > +	if (likely(ewma != 0)) {
> 
> Why special case 0? Yes it helps with the initial ramp-on, but would not
> an asymmetric IIR (with a consistent upward bias) be better?

Yes, maybe the fast ramp-up is not really necessary... I'll test it
without on some real use-cases and see if we really get any noticiable
benefit, otheriwse I'll remove it.

Thanks for pointing this out.

> > +		ewma   = util_last + (ewma << UTIL_EST_WEIGHT_SHIFT) - ewma;
> > +		ewma >>= UTIL_EST_WEIGHT_SHIFT;
> > +	} else {
> > +		ewma = util_last;
> > +	}
> > +	p->util_est.ewma = ewma;
> > +}

-- 
#include <best/regards.h>

Patrick Bellasi
