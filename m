From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [RFCv5 PATCH 32/46] sched: Energy-aware wake-up task placement
Date: Tue, 18 Aug 2015 00:23:51 +0800
Message-ID: <20150817162351.GC31366@leoy-linaro>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-33-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35174 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbbHQQYB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2015 12:24:01 -0400
Received: by pacgr6 with SMTP id gr6so111667851pac.2
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2015 09:24:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436293469-25707-33-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi Morten,

On Tue, Jul 07, 2015 at 07:24:15PM +0100, Morten Rasmussen wrote:
> Let available compute capacity and estimated energy impact select
> wake-up target cpu when energy-aware scheduling is enabled and the
> system in not over-utilized (above the tipping point).
> 
> energy_aware_wake_cpu() attempts to find group of cpus with sufficient
> compute capacity to accommodate the task and find a cpu with enough spare
> capacity to handle the task within that group. Preference is given to
> cpus with enough spare capacity at the current OPP. Finally, the energy
> impact of the new target and the previous task cpu is compared to select
> the wake-up target cpu.
> 
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> 
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> ---
>  kernel/sched/fair.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0f7dbda4..01f7337 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5427,6 +5427,86 @@ static int select_idle_sibling(struct task_struct *p, int target)
>  	return target;
>  }
>  
> +static int energy_aware_wake_cpu(struct task_struct *p, int target)
> +{
> +	struct sched_domain *sd;
> +	struct sched_group *sg, *sg_target;
> +	int target_max_cap = INT_MAX;
> +	int target_cpu = task_cpu(p);
> +	int i;
> +
> +	sd = rcu_dereference(per_cpu(sd_ea, task_cpu(p)));
> +
> +	if (!sd)
> +		return target;
> +
> +	sg = sd->groups;
> +	sg_target = sg;
> +
> +	/*
> +	 * Find group with sufficient capacity. We only get here if no cpu is
> +	 * overutilized. We may end up overutilizing a cpu by adding the task,
> +	 * but that should not be any worse than select_idle_sibling().
> +	 * load_balance() should sort it out later as we get above the tipping
> +	 * point.
> +	 */
> +	do {
> +		/* Assuming all cpus are the same in group */
> +		int max_cap_cpu = group_first_cpu(sg);
> +
> +		/*
> +		 * Assume smaller max capacity means more energy-efficient.
> +		 * Ideally we should query the energy model for the right
> +		 * answer but it easily ends up in an exhaustive search.
> +		 */
> +		if (capacity_of(max_cap_cpu) < target_max_cap &&
> +		    task_fits_capacity(p, max_cap_cpu)) {
> +			sg_target = sg;
> +			target_max_cap = capacity_of(max_cap_cpu);
> +		}
> +	} while (sg = sg->next, sg != sd->groups);
> +
> +	/* Find cpu with sufficient capacity */
> +	for_each_cpu_and(i, tsk_cpus_allowed(p), sched_group_cpus(sg_target)) {
> +		/*
> +		 * p's blocked utilization is still accounted for on prev_cpu
> +		 * so prev_cpu will receive a negative bias due the double
> +		 * accouting. However, the blocked utilization may be zero.
> +		 */
> +		int new_usage = get_cpu_usage(i) + task_utilization(p);
> +
> +		if (new_usage >	capacity_orig_of(i))
> +			continue;
> +
> +		if (new_usage <	capacity_curr_of(i)) {
> +			target_cpu = i;
> +			if (cpu_rq(i)->nr_running)
> +				break;
> +		}
> +
> +		/* cpu has capacity at higher OPP, keep it as fallback */
> +		if (target_cpu == task_cpu(p))
> +			target_cpu = i;

If CPU's current capacity cannot meet requirement, why not stay
task on prev CPU so have chance to use hot cache? Or the purpose
is to place tasks on the first CPU in schedule group as possible?

> +	}
> +
> +	if (target_cpu != task_cpu(p)) {
> +		struct energy_env eenv = {
> +			.usage_delta	= task_utilization(p),
> +			.src_cpu	= task_cpu(p),
> +			.dst_cpu	= target_cpu,
> +		};
> +
> +		/* Not enough spare capacity on previous cpu */
> +		if (cpu_overutilized(task_cpu(p)))
> +			return target_cpu;
> +
> +		if (energy_diff(&eenv) >= 0)
> +			return task_cpu(p);
> +	}
> +
> +	return target_cpu;
> +}
> +
>  /*
>   * select_task_rq_fair: Select target runqueue for the waking task in domains
>   * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
> @@ -5479,7 +5559,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>  		prev_cpu = cpu;
>  
>  	if (sd_flag & SD_BALANCE_WAKE && want_sibling) {
> -		new_cpu = select_idle_sibling(p, prev_cpu);
> +		if (energy_aware() && !cpu_rq(cpu)->rd->overutilized)
> +			new_cpu = energy_aware_wake_cpu(p, prev_cpu);
> +		else
> +			new_cpu = select_idle_sibling(p, prev_cpu);
>  		goto unlock;
>  	}
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
