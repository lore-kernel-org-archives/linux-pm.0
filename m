From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: Re: [RFCv5 PATCH 32/46] sched: Energy-aware wake-up task placement
Date: Thu, 16 Jul 2015 17:10:52 -0700
Message-ID: <55A8480C.6080806@nvidia.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-33-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17516 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149AbbGQAML (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2015 20:12:11 -0400
In-Reply-To: <1436293469-25707-33-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>, peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pboonstoppel@nvidia.com

Hi Morten,

On 07/07/2015 11:24 AM, Morten Rasmussen wrote:
> ---

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

Should be capacity_orig_of(max_cap_cpu) right? Might select a suboptimal
sg_target if max_cap_cpu has a significant amount of IRQ/RT activity.

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

Is this supposed to be capacity_of(i) instead?

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

-Sai
