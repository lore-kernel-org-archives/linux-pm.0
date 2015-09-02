From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [RFCv5 PATCH 22/46] sched: Calculate energy consumption of
 sched_group
Date: Thu, 3 Sep 2015 01:19:23 +0800
Message-ID: <20150902171923.GB12510@leoy-linaro>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-23-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32895 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892AbbIBRTb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 13:19:31 -0400
Received: by pacex6 with SMTP id ex6so12684922pac.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2015 10:19:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436293469-25707-23-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:24:05PM +0100, Morten Rasmussen wrote:
> For energy-aware load-balancing decisions it is necessary to know the
> energy consumption estimates of groups of cpus. This patch introduces a
> basic function, sched_group_energy(), which estimates the energy
> consumption of the cpus in the group and any resources shared by the
> members of the group.
> 
> NOTE: The function has five levels of identation and breaks the 80
> character limit. Refactoring is necessary.
> 
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> 
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> ---
>  kernel/sched/fair.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 146 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 78d3081..bd0be9d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4846,6 +4846,152 @@ static inline bool energy_aware(void)
>  	return sched_feat(ENERGY_AWARE);
>  }
>  
> +/*
> + * cpu_norm_usage() returns the cpu usage relative to a specific capacity,
> + * i.e. it's busy ratio, in the range [0..SCHED_LOAD_SCALE] which is useful for
> + * energy calculations. Using the scale-invariant usage returned by
> + * get_cpu_usage() and approximating scale-invariant usage by:
> + *
> + *   usage ~ (curr_freq/max_freq)*1024 * capacity_orig/1024 * running_time/time
> + *
> + * the normalized usage can be found using the specific capacity.
> + *
> + *   capacity = capacity_orig * curr_freq/max_freq
> + *
> + *   norm_usage = running_time/time ~ usage/capacity
> + */
> +static unsigned long cpu_norm_usage(int cpu, unsigned long capacity)
> +{
> +	int usage = __get_cpu_usage(cpu);
> +
> +	if (usage >= capacity)
> +		return SCHED_CAPACITY_SCALE;
> +
> +	return (usage << SCHED_CAPACITY_SHIFT)/capacity;
> +}
> +
> +static unsigned long group_max_usage(struct sched_group *sg)
> +{
> +	int i;
> +	unsigned long max_usage = 0;
> +
> +	for_each_cpu(i, sched_group_cpus(sg))
> +		max_usage = max(max_usage, get_cpu_usage(i));
> +
> +	return max_usage;
> +}
> +
> +/*
> + * group_norm_usage() returns the approximated group usage relative to it's
> + * current capacity (busy ratio) in the range [0..SCHED_LOAD_SCALE] for use in
> + * energy calculations. Since task executions may or may not overlap in time in
> + * the group the true normalized usage is between max(cpu_norm_usage(i)) and
> + * sum(cpu_norm_usage(i)) when iterating over all cpus in the group, i. The
> + * latter is used as the estimate as it leads to a more pessimistic energy
> + * estimate (more busy).
> + */
> +static unsigned long group_norm_usage(struct sched_group *sg, int cap_idx)
> +{
> +	int i;
> +	unsigned long usage_sum = 0;
> +	unsigned long capacity = sg->sge->cap_states[cap_idx].cap;
> +
> +	for_each_cpu(i, sched_group_cpus(sg))
> +		usage_sum += cpu_norm_usage(i, capacity);
> +
> +	if (usage_sum > SCHED_CAPACITY_SCALE)
> +		return SCHED_CAPACITY_SCALE;
> +	return usage_sum;
> +}
> +
> +static int find_new_capacity(struct sched_group *sg,
> +		struct sched_group_energy *sge)
> +{
> +	int idx;
> +	unsigned long util = group_max_usage(sg);
> +
> +	for (idx = 0; idx < sge->nr_cap_states; idx++) {
> +		if (sge->cap_states[idx].cap >= util)
> +			return idx;
> +	}
> +
> +	return idx;
> +}
> +
> +/*
> + * sched_group_energy(): Returns absolute energy consumption of cpus belonging
> + * to the sched_group including shared resources shared only by members of the
> + * group. Iterates over all cpus in the hierarchy below the sched_group starting
> + * from the bottom working it's way up before going to the next cpu until all
> + * cpus are covered at all levels. The current implementation is likely to
> + * gather the same usage statistics multiple times. This can probably be done in
> + * a faster but more complex way.
> + */
> +static unsigned int sched_group_energy(struct sched_group *sg_top)
> +{
> +	struct sched_domain *sd;
> +	int cpu, total_energy = 0;
> +	struct cpumask visit_cpus;
> +	struct sched_group *sg;
> +
> +	WARN_ON(!sg_top->sge);
> +
> +	cpumask_copy(&visit_cpus, sched_group_cpus(sg_top));
> +
> +	while (!cpumask_empty(&visit_cpus)) {
> +		struct sched_group *sg_shared_cap = NULL;
> +
> +		cpu = cpumask_first(&visit_cpus);
> +
> +		/*
> +		 * Is the group utilization affected by cpus outside this
> +		 * sched_group?
> +		 */
> +		sd = highest_flag_domain(cpu, SD_SHARE_CAP_STATES);
> +		if (sd && sd->parent)
> +			sg_shared_cap = sd->parent->groups;

If the sched domain is already the highest level, should directly use
its group to calculate shared capacity? so the code like below:

                if (sd && sd->parent)
                        sg_shared_cap = sd->parent->groups;
                else if (sd && !sd->parent)
                        sg_shared_cap = sd->groups;

> +
> +		for_each_domain(cpu, sd) {
> +			sg = sd->groups;
> +
> +			/* Has this sched_domain already been visited? */
> +			if (sd->child && group_first_cpu(sg) != cpu)
> +				break;
> +
> +			do {
> +				struct sched_group *sg_cap_util;
> +				unsigned long group_util;
> +				int sg_busy_energy, sg_idle_energy, cap_idx;
> +
> +				if (sg_shared_cap && sg_shared_cap->group_weight >= sg->group_weight)
> +					sg_cap_util = sg_shared_cap;
> +				else
> +					sg_cap_util = sg;
> +
> +				cap_idx = find_new_capacity(sg_cap_util, sg->sge);
> +				group_util = group_norm_usage(sg, cap_idx);
> +				sg_busy_energy = (group_util * sg->sge->cap_states[cap_idx].power)
> +										>> SCHED_CAPACITY_SHIFT;
> +				sg_idle_energy = ((SCHED_LOAD_SCALE-group_util) * sg->sge->idle_states[0].power)
> +										>> SCHED_CAPACITY_SHIFT;
> +
> +				total_energy += sg_busy_energy + sg_idle_energy;
> +
> +				if (!sd->child)
> +					cpumask_xor(&visit_cpus, &visit_cpus, sched_group_cpus(sg));
> +
> +				if (cpumask_equal(sched_group_cpus(sg), sched_group_cpus(sg_top)))
> +					goto next_cpu;
> +
> +			} while (sg = sg->next, sg != sd->groups);
> +		}
> +next_cpu:
> +		continue;
> +	}
> +
> +	return total_energy;
> +}
> +
>  static int wake_wide(struct task_struct *p)
>  {
>  	int factor = this_cpu_read(sd_llc_size);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
