From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/7] sched/core: uclamp: add CPU clamp groups accounting
Date: Fri, 13 Apr 2018 11:46:15 +0200
Message-ID: <20180413094615.GT4043@hirez.programming.kicks-ass.net>
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
> +static inline void uclamp_cpu_get(struct task_struct *p, int cpu, int clamp_id)
> +{
> +	struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
> +	int clamp_value;
> +	int group_id;
> +
> +	/* Get task's specific clamp value */
> +	clamp_value = p->uclamp[clamp_id].value;
> +	group_id = p->uclamp[clamp_id].group_id;
> +
> +	/* No task specific clamp values: nothing to do */
> +	if (group_id == UCLAMP_NONE)
> +		return;
> +
> +	/* Increment the current group_id */

That I think qualifies being called a bad comment.

> +	uc_cpu->group[group_id].tasks += 1;
> +
> +	/* Mark task as enqueued for this clamp index */
> +	p->uclamp_group_id[clamp_id] = group_id;

Why exactly do we need this? we got group_id from @p in the first place.

I suspect this is because when we update p->uclamp[], we don't update
this active value (when needed), is that worth it?

> +	/*
> +	 * If this is the new max utilization clamp value, then we can update
> +	 * straight away the CPU clamp value. Otherwise, the current CPU clamp
> +	 * value is still valid and we are done.
> +	 */
> +	if (uc_cpu->value < clamp_value)
> +		uc_cpu->value = clamp_value;
> +}
