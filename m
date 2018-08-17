From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 03/14] sched/core: uclamp: add CPU's clamp groups
 accounting
Date: Fri, 17 Aug 2018 12:04:21 +0100
Message-ID: <20180817110421.GJ2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-4-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180806163946.28380-4-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 06-Aug 17:39, Patrick Bellasi wrote:

[...]

> +/**
> + * uclamp_cpu_get_id(): increase reference count for a clamp group on a CPU
> + * @p: the task being enqueued on a CPU
> + * @rq: the CPU's rq where the clamp group has to be reference counted
> + * @clamp_id: the utilization clamp (e.g. min or max utilization) to reference
> + *
> + * Once a task is enqueued on a CPU's RQ, the clamp group currently defined by
> + * the task's uclamp.group_id is reference counted on that CPU.
> + */
> +static inline void uclamp_cpu_get_id(struct task_struct *p,
> +				     struct rq *rq, int clamp_id)
> +{
> +	struct uclamp_group *uc_grp;
> +	struct uclamp_cpu *uc_cpu;
> +	int clamp_value;
> +	int group_id;
> +
> +	/* No task specific clamp values: nothing to do */
> +	group_id = p->uclamp[clamp_id].group_id;
> +	if (group_id == UCLAMP_NOT_VALID)
> +		return;

This is broken for util_max aggression.

By not refcounting tasks without a task specific clamp value, we end
up enforcing a max_util to these tasks when they are co-scheduled with
another max clamped task.

I need to fix this by removing this "optimization" (working just for
util_min) and refcount all the tasks.

> +
> +	/* Reference count the task into its current group_id */
> +	uc_grp = &rq->uclamp.group[clamp_id][0];
> +	uc_grp[group_id].tasks += 1;
> +
> +	/*
> +	 * If this is the new max utilization clamp value, then we can update
> +	 * straight away the CPU clamp value. Otherwise, the current CPU clamp
> +	 * value is still valid and we are done.
> +	 */
> +	uc_cpu = &rq->uclamp;
> +	clamp_value = p->uclamp[clamp_id].value;
> +	if (uc_cpu->value[clamp_id] < clamp_value)
> +		uc_cpu->value[clamp_id] = clamp_value;
> +}
> +

-- 
#include <best/regards.h>

Patrick Bellasi
