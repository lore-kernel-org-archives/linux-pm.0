From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 8/8] cpufreq: intel_pstate: Use CPPC to get max
 performance
Date: Sat, 10 Sep 2016 18:22:55 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609101654160.2804@nanos>
References: <1473373615-51427-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1473373615-51427-9-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:51328 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754821AbcIJQZZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2016 12:25:25 -0400
In-Reply-To: <1473373615-51427-9-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, tim.c.chen@linux.intel.com

On Thu, 8 Sep 2016, Srinivas Pandruvada wrote:
> +
> +/* Call set_sched_itmt from a work function to be able to use hotplug locks */

And why can't the function below not do that? Is the reader required to
figure that out himslf?

> +static void intel_pstste_sched_itmt_work_fn(struct work_struct *work)
> +{
> +	set_sched_itmt(true);
> +}
> +
> +static DECLARE_WORK(sched_itmt_work, intel_pstste_sched_itmt_work_fn);
>  
>  static bool intel_pstate_get_ppc_enable_status(void)
>  {
> @@ -377,14 +391,63 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
>  	int ret;
>  	int i;
>  
> -	if (hwp_active)
> +	cpu = all_cpu_data[policy->cpu];
> +
> +	if (hwp_active) {

Please split this out into a seperate function.

> +		struct cppc_perf_caps *perf_caps;
> +
> +		cpu->cppc_data = kzalloc(sizeof(struct cppc_cpudata),
> +					 GFP_KERNEL);
> +		if (!cpu->cppc_data)
> +			return;
> +
> +		perf_caps = &cpu->cppc_data->perf_caps;
> +		ret = cppc_get_perf_caps(policy->cpu, perf_caps);
> +		if (ret) {
> +			kfree(cpu->cppc_data);
> +			return;
> +		}
> +
> +		cpu->valid_cppc_table = true;
> +		pr_debug("cpu:%d H:0x%x N:0x%x L:0x%x\n", policy->cpu,
> +			 perf_caps->highest_perf, perf_caps->nominal_perf,
> +			 perf_caps->lowest_perf);
> +
> +		cpumask_set_cpu(policy->cpu, &cppc_rd_cpu_mask);
> +		if (cpumask_subset(topology_core_cpumask(policy->cpu),
> +				   &cppc_rd_cpu_mask)) {
> +			int cpu_index;
> +			int max_prio;
> +			bool itmt_support = false;
> +
> +			cpu = all_cpu_data[0];
> +			max_prio = cpu->cppc_data->perf_caps.highest_perf;
> +			for_each_cpu(cpu_index, &cppc_rd_cpu_mask) {
> +				cpu = all_cpu_data[cpu_index];
> +				perf_caps = &cpu->cppc_data->perf_caps;
> +				if (max_prio != perf_caps->highest_perf) {
> +					itmt_support = true;
> +					break;
> +				}
> +			}

20 lines of magic logic w/o a userful comment. Darn, you yourself will have
forgotten the magic within 3 month ....

Thanks,

	tglx
