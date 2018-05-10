From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] sched/fair: schedutil: explicit update only when
 required
Date: Thu, 10 May 2018 18:15:15 +0200
Message-ID: <20180510161515.GH12217@hirez.programming.kicks-ass.net>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-4-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180510150553.28122-4-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 10, 2018 at 04:05:53PM +0100, Patrick Bellasi wrote:
> All the above considered, let's make schedutil updates more explicit in
> fair.c by removing the cfs_rq_util_change() wrapper function in favour
> of the existing cpufreq_update_util() public API.
> This can be done by calling cpufreq_update_util() explicitly in the few
> call sites where it really makes sense and when all the (potentially)
> required cfs_rq's information have been updated.

Aside from having to redraw my ever stale diagrams _again_ I don't think
I object too much here. As you write tracking the exact point where we
did do the update was fairly tedious.

> @@ -5397,9 +5366,27 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		update_cfs_group(se);
>  	}
>  
> +	/* The task is visible from the root cfs_rq */
> +	if (!se) {
> +		unsigned int flags = 0;

That one shadows the @flags argument. Some checker is bound to complain
about it.

> +
>  		add_nr_running(rq, 1);
>  
> +		if (p->in_iowait)
> +			flags |= SCHED_CPUFREQ_IOWAIT;
> +
> +		/*
> +		 * !last_update_time means we've passed through
> +		 * migrate_task_rq_fair() indicating we migrated.
> +		 *
> +		 * IOW we're enqueueing a task on a new CPU.
> +		 */
> +		if (!p->se.avg.last_update_time)
> +			flags |= SCHED_CPUFREQ_MIGRATION;
> +
> +		cpufreq_update_util(rq, flags);
> +	}
> +
>  	hrtick_update(rq);
>  }
