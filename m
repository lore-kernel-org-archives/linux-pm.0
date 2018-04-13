From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/7] sched/core: uclamp: add CPU clamp groups accounting
Date: Fri, 13 Apr 2018 11:30:05 +0200
Message-ID: <20180413093005.GS4043@hirez.programming.kicks-ass.net>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-2-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409165615.2326-2-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 09, 2018 at 05:56:09PM +0100, Patrick Bellasi wrote:
> +struct uclamp_group {
> +	/* Utilization clamp value for tasks on this clamp group */
> +	int value;
> +	/* Number of RUNNABLE tasks on this clamp group */
> +	int tasks;
> +};

> +struct uclamp_cpu {
> +	/* Utilization clamp value for a CPU */
> +	int value;
> +	/* Utilization clamp groups affecting this CPU */
> +	struct uclamp_group group[CONFIG_UCLAMP_GROUPS_COUNT + 1];
> +};

> @@ -811,6 +885,11 @@ struct rq {
>  	unsigned long		cpu_capacity;
>  	unsigned long		cpu_capacity_orig;
>  
> +#ifdef CONFIG_UCLAMP_TASK
> +	/* util_{min,max} clamp values based on CPU's active tasks */
> +	struct uclamp_cpu uclamp[UCLAMP_CNT];
> +#endif
> +
>  	struct callback_head	*balance_callback;
>  
>  	unsigned char		idle_balance;

So that is:

struct rq {

	struct uclamp_cpu {
		int value;

		/* 4 byte hole */

		struct uclamp_group {
			int value;
			int tasks;
		} [COUNT + 1];	// size: COUNT+2 * 8 [bytes]

	} [2]; // size: 2 * COUNT+2 * 8 [bytes]

};

Which for the default (4) ends up being 96 bytes, or at least 2 lines.
Do you want some alignment such that we don't span more lines?

Which touch extra on enqueue/dequeue, at least it's only for tasks that
have a clamp set.
