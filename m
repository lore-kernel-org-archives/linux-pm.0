From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 04/15] sched/core: uclamp: add CPU's clamp groups
 refcounting
Date: Sun, 11 Nov 2018 17:47:54 +0100
Message-ID: <20181111164754.GA3038@worktop>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-6-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181029183311.29175-6-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 29, 2018 at 06:32:59PM +0000, Patrick Bellasi wrote:
> +static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id)
> +{
> +	unsigned int group_id;
> +	int max_value = 0;
> +
> +	for (group_id = 0; group_id < UCLAMP_GROUPS; ++group_id) {
> +		if (!rq->uclamp.group[clamp_id][group_id].tasks)
> +			continue;
> +		/* Both min and max clamps are MAX aggregated */
> +		if (max_value < rq->uclamp.group[clamp_id][group_id].value)
> +			max_value = rq->uclamp.group[clamp_id][group_id].value;

		max_value = max(max_value, rq->uclamp.group[clamp_id][group_id].value);

> +		if (max_value >= SCHED_CAPACITY_SCALE)
> +			break;
> +	}
> +	rq->uclamp.value[clamp_id] = max_value;
> +}
> +
> +/**
> + * uclamp_cpu_get_id(): increase reference count for a clamp group on a CPU
> + * @p: the task being enqueued on a CPU
> + * @rq: the CPU's rq where the clamp group has to be reference counted
> + * @clamp_id: the clamp index to update
> + *
> + * Once a task is enqueued on a CPU's rq, the clamp group currently defined by
> + * the task's uclamp::group_id is reference counted on that CPU.
> + */
> +static inline void uclamp_cpu_get_id(struct task_struct *p, struct rq *rq,
> +				     unsigned int clamp_id)
> +{
> +	unsigned int group_id;
> +
> +	if (unlikely(!p->uclamp[clamp_id].mapped))
> +		return;
> +
> +	group_id = p->uclamp[clamp_id].group_id;
> +	p->uclamp[clamp_id].active = true;
> +
> +	rq->uclamp.group[clamp_id][group_id].tasks += 1;

	++
> +
> +	if (rq->uclamp.value[clamp_id] < p->uclamp[clamp_id].value)
> +		rq->uclamp.value[clamp_id] = p->uclamp[clamp_id].value;

	rq->uclamp.value[clamp_id] = max(rq->uclamp.value[clamp_id],
					 p->uclamp[clamp_id].value);

> +}
> +
> +/**
> + * uclamp_cpu_put_id(): decrease reference count for a clamp group on a CPU
> + * @p: the task being dequeued from a CPU
> + * @rq: the CPU's rq from where the clamp group has to be released
> + * @clamp_id: the clamp index to update
> + *
> + * When a task is dequeued from a CPU's rq, the CPU's clamp group reference
> + * counted by the task is released.
> + * If this was the last task reference coutning the current max clamp group,
> + * then the CPU clamping is updated to find the new max for the specified
> + * clamp index.
> + */
> +static inline void uclamp_cpu_put_id(struct task_struct *p, struct rq *rq,
> +				     unsigned int clamp_id)
> +{
> +	unsigned int clamp_value;
> +	unsigned int group_id;
> +
> +	if (unlikely(!p->uclamp[clamp_id].mapped))
> +		return;
> +
> +	group_id = p->uclamp[clamp_id].group_id;
> +	p->uclamp[clamp_id].active = false;
> +
	SCHED_WARN_ON(!rq->uclamp.group[clamp_id][group_id].tasks);

> +	if (likely(rq->uclamp.group[clamp_id][group_id].tasks))
> +		rq->uclamp.group[clamp_id][group_id].tasks -= 1;

	--

> +#ifdef CONFIG_SCHED_DEBUG
> +	else {
> +		WARN(1, "invalid CPU[%d] clamp group [%u:%u] refcount\n",
> +		     cpu_of(rq), clamp_id, group_id);
> +	}
> +#endif

> +
> +	if (likely(rq->uclamp.group[clamp_id][group_id].tasks))
> +		return;
> +
> +	clamp_value = rq->uclamp.group[clamp_id][group_id].value;
> +#ifdef CONFIG_SCHED_DEBUG
> +	if (unlikely(clamp_value > rq->uclamp.value[clamp_id])) {
> +		WARN(1, "invalid CPU[%d] clamp group [%u:%u] value\n",
> +		     cpu_of(rq), clamp_id, group_id);
> +	}
> +#endif

	SCHED_WARN_ON(clamp_value > rq->uclamp.value[clamp_id]);

> +	if (clamp_value >= rq->uclamp.value[clamp_id])
> +		uclamp_cpu_update(rq, clamp_id);
> +}

> @@ -866,6 +1020,28 @@ static void uclamp_group_get(struct uclamp_se *uc_se, unsigned int clamp_id,
>  	if (res != uc_map_old.data)
>  		goto retry;
>  
> +	/* Ensure each CPU tracks the correct value for this clamp group */
> +	if (likely(uc_map_new.se_count > 1))
> +		goto done;
> +	for_each_possible_cpu(cpu) {

yuck yuck yuck.. why!?

> +		struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp;
> +
> +		/* Refcounting is expected to be always 0 for free groups */
> +		if (unlikely(uc_cpu->group[clamp_id][group_id].tasks)) {
> +			uc_cpu->group[clamp_id][group_id].tasks = 0;
> +#ifdef CONFIG_SCHED_DEBUG
> +			WARN(1, "invalid CPU[%d] clamp group [%u:%u] refcount\n",
> +			     cpu, clamp_id, group_id);
> +#endif

		SCHED_WARN_ON();

> +		}
> +
> +		if (uc_cpu->group[clamp_id][group_id].value == clamp_value)
> +			continue;
> +		uc_cpu->group[clamp_id][group_id].value = clamp_value;
> +	}
> +
> +done:
> +
>  	/* Update SE's clamp values and attach it to new clamp group */
>  	uc_se->value = clamp_value;
>  	uc_se->group_id = group_id;
