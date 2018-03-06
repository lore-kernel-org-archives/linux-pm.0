From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 1/4] sched/fair: add util_est on top of PELT
Date: Tue, 6 Mar 2018 19:58:51 +0100
Message-ID: <20180306185851.GG25201@hirez.programming.kicks-ass.net>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-2-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180222170153.673-2-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 22, 2018 at 05:01:50PM +0000, Patrick Bellasi wrote:
> +static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
> +				    struct task_struct *p)
> +{
> +	unsigned int enqueued;
> +
> +	if (!sched_feat(UTIL_EST))
> +		return;
> +
> +	/* Update root cfs_rq's estimated utilization */
> +	enqueued  = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> +	enqueued += _task_util_est(p);
> +	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
> +}

> +static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
> +				    struct task_struct *p,
> +				    bool task_sleep)
> +{
> +	long last_ewma_diff;
> +	struct util_est ue;
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
> +	ue.enqueued = 0;
> +	if (cfs_rq->nr_running) {
> +		ue.enqueued  = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> +		ue.enqueued -= min_t(unsigned int, ue.enqueued,
> +				     _task_util_est(p));
> +	}
> +	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);

It appears to me this isn't a stable situation and completely relies on
the !nr_running case to recalibrate. If we ensure that doesn't happen
for a significant while the sum can run-away, right?

Should we put a max in enqueue to avoid this?
