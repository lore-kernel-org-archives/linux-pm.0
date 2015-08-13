From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 22/46] sched: Calculate energy consumption of
 sched_group
Date: Thu, 13 Aug 2015 17:34:17 +0200
Message-ID: <20150813153417.GY19282@twins.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-23-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43353 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbbHMPe1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 11:34:27 -0400
Content-Disposition: inline
In-Reply-To: <1436293469-25707-23-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:24:05PM +0100, Morten Rasmussen wrote:
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

So here its not really 'new' capacity is it, most like the current
capacity?

So in the case of coupled P states, you look for the CPU with highest
utilization, as that is the on that determines the required P state.

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
