From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 03/15] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Wed, 7 Nov 2018 14:44:14 +0100
Message-ID: <20181107134414.GR9781@hirez.programming.kicks-ass.net>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181029183311.29175-4-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 29, 2018 at 06:32:57PM +0000, Patrick Bellasi wrote:
> +/**
> + * uclamp_group_get: increase the reference count for a clamp group
> + * @uc_se: the utilization clamp data for the task
> + * @clamp_id: the clamp index affected by the task
> + * @clamp_value: the new clamp value for the task
> + *
> + * Each time a task changes its utilization clamp value, for a specified clamp
> + * index, we need to find an available clamp group which can be used to track
> + * this new clamp value. The corresponding clamp group index will be used to
> + * reference count the corresponding clamp value while the task is enqueued on
> + * a CPU.
> + */
> +static void uclamp_group_get(struct uclamp_se *uc_se, unsigned int clamp_id,
> +			     unsigned int clamp_value)
> +{
> +	union uclamp_map *uc_maps = &uclamp_maps[clamp_id][0];
> +	unsigned int prev_group_id = uc_se->group_id;
> +	union uclamp_map uc_map_old, uc_map_new;
> +	unsigned int free_group_id;
> +	unsigned int group_id;
> +	unsigned long res;
> +
> +retry:
> +
> +	free_group_id = UCLAMP_GROUPS;
> +	for (group_id = 0; group_id < UCLAMP_GROUPS; ++group_id) {
> +		uc_map_old.data = atomic_long_read(&uc_maps[group_id].adata);
> +		if (free_group_id == UCLAMP_GROUPS && !uc_map_old.se_count)
> +			free_group_id = group_id;
> +		if (uc_map_old.value == clamp_value)
> +			break;
> +	}
> +	if (group_id >= UCLAMP_GROUPS) {
> +#ifdef CONFIG_SCHED_DEBUG
> +#define UCLAMP_MAPERR "clamp value [%u] mapping to clamp group failed\n"
> +		if (unlikely(free_group_id == UCLAMP_GROUPS)) {
> +			pr_err_ratelimited(UCLAMP_MAPERR, clamp_value);
> +			return;
> +		}
> +#endif

Can you please put in a comment, either here or on top, on why this can
not in fact happen? And we're always guaranteed a free group.

> +		group_id = free_group_id;
> +		uc_map_old.data = atomic_long_read(&uc_maps[group_id].adata);
> +	}
> +
> +	uc_map_new.se_count = uc_map_old.se_count + 1;
> +	uc_map_new.value = clamp_value;
> +	res = atomic_long_cmpxchg(&uc_maps[group_id].adata,
> +				  uc_map_old.data, uc_map_new.data);
> +	if (res != uc_map_old.data)
> +		goto retry;
> +
> +	/* Update SE's clamp values and attach it to new clamp group */
> +	uc_se->value = clamp_value;
> +	uc_se->group_id = group_id;
> +
> +	/* Release the previous clamp group */
> +	if (uc_se->mapped)
> +		uclamp_group_put(clamp_id, prev_group_id);
> +	uc_se->mapped = true;
> +}
