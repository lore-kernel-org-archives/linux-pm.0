From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 03/14] sched/core: uclamp: add CPU's clamp groups
 accounting
Date: Tue, 14 Aug 2018 17:44:15 +0200
Message-ID: <a24def9b-57bb-d072-5064-0421076d2e43@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-4-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806163946.28380-4-patrick.bellasi@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 08/06/2018 06:39 PM, Patrick Bellasi wrote:

[...]

> +/**
> + * uclamp_cpu_put_id(): decrease reference count for a clamp group on a CPU
> + * @p: the task being dequeued from a CPU
> + * @cpu: the CPU from where the clamp group has to be released
> + * @clamp_id: the utilization clamp (e.g. min or max utilization) to release
> + *
> + * When a task is dequeued from a CPU's RQ, the CPU's clamp group reference
> + * counted by the task is decreased.
> + * If this was the last task defining the current max clamp group, then the
> + * CPU clamping is updated to find the new max for the specified clamp
> + * index.
> + */
> +static inline void uclamp_cpu_put_id(struct task_struct *p,
> +				     struct rq *rq, int clamp_id)
> +{
> +	struct uclamp_group *uc_grp;
> +	struct uclamp_cpu *uc_cpu;
> +	unsigned int clamp_value;
> +	int group_id;
> +
> +	/* No task specific clamp values: nothing to do */
> +	group_id = p->uclamp[clamp_id].group_id;
> +	if (group_id == UCLAMP_NOT_VALID)
> +		return;
> +
> +	/* Decrement the task's reference counted group index */
> +	uc_grp = &rq->uclamp.group[clamp_id][0];
> +#ifdef SCHED_DEBUG
> +	if (unlikely(uc_grp[group_id].tasks == 0)) {
> +		WARN(1, "invalid CPU[%d] clamp group [%d:%d] refcount\n",
> +		     cpu_of(rq), clamp_id, group_id);
> +		uc_grp[group_id].tasks = 1;
> +	}
> +#endif

This one indicates that there are some holes in your ref-counting. It's 
probably easier to debug that there is still a task but the 
uc_grp[group_id].tasks value == 0 (A). I assume the other problem exists 
as well, i.e. last task and uc_grp[group_id].tasks > 1 (B)?

You have uclamp_cpu_[get/put](_id)() in [enqueue/dequeue]_task.

Patch 04/14 introduces its use in uclamp_task_update_active().

Do you know why (A) (and (B)) are happening?

> +	uc_grp[group_id].tasks -= 1;
> +
> +	/* If this is not the last task, no updates are required */
> +	if (uc_grp[group_id].tasks > 0)
> +		return;
> +
> +	/*
> +	 * Update the CPU only if this was the last task of the group
> +	 * defining the current clamp value.
> +	 */
> +	uc_cpu = &rq->uclamp;
> +	clamp_value = uc_grp[group_id].value;
> +	if (clamp_value >= uc_cpu->value[clamp_id])

'clamp_value > uc_cpu->value[clamp_id]' should indicate another 
inconsistency in the uclamp machinery, right?

[...]
