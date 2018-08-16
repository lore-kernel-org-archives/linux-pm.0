From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [PATCH v3 09/14] sched/core: uclamp: propagate parent clamps
Date: Thu, 16 Aug 2018 14:39:06 +0530
Message-ID: <20180816090906.GC2661@codeaurora.org>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-10-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180806163946.28380-10-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 06, 2018 at 05:39:41PM +0100, Patrick Bellasi wrote:
> In order to properly support hierarchical resources control, the cgroup
> delegation model requires that attribute writes from a child group never
> fail but still are (potentially) constrained based on parent's assigned
> resources. This requires to properly propagate and aggregate parent
> attributes down to its descendants.
> 
> Let's implement this mechanism by adding a new "effective" clamp value
> for each task group. The effective clamp value is defined as the smaller
> value between the clamp value of a group and the effective clamp value
> of its parent. This represent also the clamp value which is actually
> used to clamp tasks in each task group.
> 
> Since it can be interesting for tasks in a cgroup to know exactly what
> is the currently propagated/enforced configuration, the effective clamp
> values are exposed to user-space by means of a new pair of read-only
> attributes: cpu.util.{min,max}.effective.
> 
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
>  

<snip>

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8f48e64fb8a6..3fac2d098084 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -589,6 +589,11 @@ struct uclamp_se {
>  	unsigned int value;
>  	/* Utilization clamp group for this constraint */
>  	unsigned int group_id;
> +	/* Effective clamp  for tasks in this group */
> +	struct {
> +		unsigned int value;
> +		unsigned int group_id;
> +	} effective;
>  };

Are these needed when CONFIG_UCLAMP_TASK_GROUP is disabled?

>  
>  union rcu_special {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2ba55a4afffb..f692df3787bd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1237,6 +1237,8 @@ static inline void init_uclamp_sched_group(void)
>  		uc_se = &root_task_group.uclamp[clamp_id];
>  		uc_se->value = uclamp_none(clamp_id);
>  		uc_se->group_id = group_id;
> +		uc_se->effective.value = uclamp_none(clamp_id);
> +		uc_se->effective.group_id = group_id;
>  
>  		/* Attach root TG's clamp group */
>  		uc_map[group_id].se_count = 1;
>  

<snip>

> @@ -7622,11 +7687,19 @@ static struct cftype cpu_legacy_files[] = {
>  		.read_u64 = cpu_util_min_read_u64,
>  		.write_u64 = cpu_util_min_write_u64,
>  	},
> +	{
> +		.name = "util.min.effective",
> +		.read_u64 = cpu_util_min_effective_read_u64,
> +	},
>  	{
>  		.name = "util.max",
>  		.read_u64 = cpu_util_max_read_u64,
>  		.write_u64 = cpu_util_max_write_u64,
>  	},
> +	{
> +		.name = "util.max.effective",
> +		.read_u64 = cpu_util_max_effective_read_u64,
> +	},
>  #endif
>  	{ }	/* Terminate */
>  };

Is there any reason why these are not added for the default hierarchy?

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
