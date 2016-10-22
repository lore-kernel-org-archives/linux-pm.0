From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/4] cpufreq: intel_pstate: Per CPU P-State limits
Date: Sat, 22 Oct 2016 03:11:36 +0200
Message-ID: <4007089.zBpLmzYFrq@vostro.rjw.lan>
References: <1477066466-22367-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1477066466-22367-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47159 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1755410AbcJVBEi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2016 21:04:38 -0400
In-Reply-To: <1477066466-22367-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Friday, October 21, 2016 09:14:23 AM Srinivas Pandruvada wrote:
> Intel P-State offers two interface to set performance limits:
> - Intel P-State sysfs
> 	/sys/devices/system/cpu/intel_pstate/max_perf_pct
> 	/sys/devices/system/cpu/intel_pstate/min_perf_pct
> - cpufreq
> 	/sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
> 	/sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
> 
> In the current implementation both of the above methods, change limits
> to every CPU in the system. Moreover the limits placed using cpufreq
> policy interface also presented in the Intel P-State sysfs via modified
> max_perf_pct and min_per_pct during sysfs reads. This allows to check
> percent of reduced/increased performance, irrespective of method used to
> limit.
> 
> There are some new generations of processors, where it is possible to
> have limits placed on individual CPU cores. Using cpufreq interface it
> is possible to set limits on each CPU. But the current processing will
> use last limits placed on all CPUs. So the per core limit feature of
> CPUs can't be used.
> 
> This change brings in capability to set P-States limits for each CPU,
> with some limitations. In this case what should be the read of
> max_perf_pct and min_perf_pct? It can be most restrictive limits placed
> on any CPU or max possible performance on any given CPU on which no
> limits are placed. In either case someone will have issue.
> 
> So the consensus is, we can't have both sysfs controls present when user
> wants to use limit per core limits.
> - By default per-core-control feature is not enabled. So no one will
> notice any difference.
> - The way to enable is by kernel command line
> intel_pstate=per_cpu_perf_limits
> - When the per-core-controls are enabled there is no display of for both
> read and write on
> 	/sys/devices/system/cpu/intel_pstate/max_perf_pct
> 	/sys/devices/system/cpu/intel_pstate/min_perf_pct
> - User can change limits using
> 	/sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
> 	/sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
> 	/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> - User can still observe turbo percent and number of P-States from
> 	/sys/devices/system/cpu/intel_pstate/turbo_pct
> 	/sys/devices/system/cpu/intel_pstate/num_pstates
> - User can read write system wide turbo status
> 	/sys/devices/system/cpu/no_turbo
> 
> While changing this BUG_ON is changed to WARN_ON, as they are not fatal
> errors for the system.

Please see a couple of minor nits below.

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 246 +++++++++++++++++++++++++++--------------
>  1 file changed, 165 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 5725b85..98db507 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -177,6 +177,48 @@ struct _pid {
>  };
>  
>  /**
> + * struct perf_limits - Store user and policy limits
> + * @no_turbo:		User requested turbo state from intel_pstate sysfs
> + * @turbo_disabled:	Platform turbo status either from msr
> + *			MSR_IA32_MISC_ENABLE or when maximum available pstate
> + *			matches the maximum turbo pstate
> + * @max_perf_pct:	Effective maximum performance limit in percentage, this
> + *			is minimum of either limits enforced by cpufreq policy
> + *			or limits from user set limits via intel_pstate sysfs
> + * @min_perf_pct:	Effective minimum performance limit in percentage, this
> + *			is maximum of either limits enforced by cpufreq policy
> + *			or limits from user set limits via intel_pstate sysfs
> + * @max_perf:		This is a scaled value between 0 to 255 for max_perf_pct
> + *			This value is used to limit max pstate
> + * @min_perf:		This is a scaled value between 0 to 255 for min_perf_pct
> + *			This value is used to limit min pstate
> + * @max_policy_pct:	The maximum performance in percentage enforced by
> + *			cpufreq setpolicy interface
> + * @max_sysfs_pct:	The maximum performance in percentage enforced by
> + *			intel pstate sysfs interface, unused when per cpu
> + *			controls are enforced
> + * @min_policy_pct:	The minimum performance in percentage enforced by
> + *			cpufreq setpolicy interface
> + * @min_sysfs_pct:	The minimum performance in percentage enforced by
> + *			intel pstate sysfs interface, unused when per cpu
> + *			controls are enforced
> + *
> + * Storage for user and policy defined limits.
> + */
> +struct perf_limits {
> +	int no_turbo;
> +	int turbo_disabled;
> +	int max_perf_pct;
> +	int min_perf_pct;
> +	int32_t max_perf;
> +	int32_t min_perf;
> +	int max_policy_pct;
> +	int max_sysfs_pct;
> +	int min_policy_pct;
> +	int min_sysfs_pct;
> +};
> +
> +/**
>   * struct cpudata -	Per CPU instance data storage
>   * @cpu:		CPU number for this instance data
>   * @update_util:	CPUFreq utility callback information
> @@ -193,6 +235,9 @@ struct _pid {
>   * @prev_cummulative_iowait: IO Wait time difference from last and
>   *			current sample
>   * @sample:		Storage for storing last Sample data
> + * @perf_limits:	Pointer to perf_limit unique to this CPU
> + *			Not all field in the structure are applicable
> + *			when per cpu controls are enforced
>   * @acpi_perf_data:	Stores ACPI perf information read from _PSS
>   * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
>   *
> @@ -215,6 +260,7 @@ struct cpudata {
>  	u64	prev_tsc;
>  	u64	prev_cummulative_iowait;
>  	struct sample sample;
> +	struct perf_limits *perf_limits;
>  #ifdef CONFIG_ACPI
>  	struct acpi_processor_performance acpi_perf_data;
>  	bool valid_pss_table;
> @@ -287,51 +333,12 @@ static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu);
>  static struct pstate_adjust_policy pid_params __read_mostly;
>  static struct pstate_funcs pstate_funcs __read_mostly;
>  static int hwp_active __read_mostly;
> +static bool per_cpu_limits __read_mostly;
>  
>  #ifdef CONFIG_ACPI
>  static bool acpi_ppc;
>  #endif
>  
> -/**
> - * struct perf_limits - Store user and policy limits
> - * @no_turbo:		User requested turbo state from intel_pstate sysfs
> - * @turbo_disabled:	Platform turbo status either from msr
> - *			MSR_IA32_MISC_ENABLE or when maximum available pstate
> - *			matches the maximum turbo pstate
> - * @max_perf_pct:	Effective maximum performance limit in percentage, this
> - *			is minimum of either limits enforced by cpufreq policy
> - *			or limits from user set limits via intel_pstate sysfs
> - * @min_perf_pct:	Effective minimum performance limit in percentage, this
> - *			is maximum of either limits enforced by cpufreq policy
> - *			or limits from user set limits via intel_pstate sysfs
> - * @max_perf:		This is a scaled value between 0 to 255 for max_perf_pct
> - *			This value is used to limit max pstate
> - * @min_perf:		This is a scaled value between 0 to 255 for min_perf_pct
> - *			This value is used to limit min pstate
> - * @max_policy_pct:	The maximum performance in percentage enforced by
> - *			cpufreq setpolicy interface
> - * @max_sysfs_pct:	The maximum performance in percentage enforced by
> - *			intel pstate sysfs interface
> - * @min_policy_pct:	The minimum performance in percentage enforced by
> - *			cpufreq setpolicy interface
> - * @min_sysfs_pct:	The minimum performance in percentage enforced by
> - *			intel pstate sysfs interface
> - *
> - * Storage for user and policy defined limits.
> - */
> -struct perf_limits {
> -	int no_turbo;
> -	int turbo_disabled;
> -	int max_perf_pct;
> -	int min_perf_pct;
> -	int32_t max_perf;
> -	int32_t min_perf;
> -	int max_policy_pct;
> -	int max_sysfs_pct;
> -	int min_policy_pct;
> -	int min_sysfs_pct;
> -};
> -
>  static struct perf_limits performance_limits = {
>  	.no_turbo = 0,
>  	.turbo_disabled = 0,
> @@ -559,6 +566,7 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
>  {
>  	int min, hw_min, max, hw_max, cpu, range, adj_range;
>  	u64 value, cap;
> +	int max_perf_pct, min_perf_pct;

Move these definitions into the loop?

And say we have

	struct perf_limits *perf_limits = limits;

->

>  
>  	for_each_cpu(cpu, cpumask) {

-> and here

		if (per_cpu_limits)
			perf_limits = all_cpu_data[cpu]->perf_limits;

-->

>  		rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
> @@ -566,13 +574,23 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
>  		hw_max = HWP_HIGHEST_PERF(cap);
>  		range = hw_max - hw_min;
>  
> +		if (per_cpu_limits) {
> +			max_perf_pct =
> +				all_cpu_data[cpu]->perf_limits->max_perf_pct;
> +			min_perf_pct =
> +				all_cpu_data[cpu]->perf_limits->min_perf_pct;
> +		} else {
> +			max_perf_pct = limits->max_perf_pct;
> +			min_perf_pct = limits->min_perf_pct;
> +		}

--> so the above becomes

		max_perf_pct = perf_limits->max_perf_pct;
		min_perf_pct = perf_limits->min_perf_pct;

Looks better to me.

> +
>  		rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
> -		adj_range = limits->min_perf_pct * range / 100;
> +		adj_range = min_perf_pct * range / 100;
>  		min = hw_min + adj_range;
>  		value &= ~HWP_MIN_PERF(~0L);
>  		value |= HWP_MIN_PERF(min);
>  
> -		adj_range = limits->max_perf_pct * range / 100;
> +		adj_range = max_perf_pct * range / 100;
>  		max = hw_min + adj_range;
>  		if (limits->no_turbo) {
>  			hw_max = HWP_GUARANTEED_PERF(cap);
> @@ -783,8 +801,6 @@ define_one_global_ro(num_pstates);
>  
>  static struct attribute *intel_pstate_attributes[] = {
>  	&no_turbo.attr,
> -	&max_perf_pct.attr,
> -	&min_perf_pct.attr,
>  	&turbo_pct.attr,
>  	&num_pstates.attr,
>  	NULL
> @@ -801,9 +817,28 @@ static void __init intel_pstate_sysfs_expose_params(void)
>  
>  	intel_pstate_kobject = kobject_create_and_add("intel_pstate",
>  						&cpu_subsys.dev_root->kobj);
> -	BUG_ON(!intel_pstate_kobject);
> +	WARN_ON(!intel_pstate_kobject);
> +	if (!intel_pstate_kobject)
> +		return;

That can be written as

	if (WARN_ON(!intel_pstate_kobject))
		return

and analogously below.

> +
>  	rc = sysfs_create_group(intel_pstate_kobject, &intel_pstate_attr_group);
> -	BUG_ON(rc);
> +	WARN_ON(rc);
> +	if (rc)
> +		return;
> +
> +	/*
> +	 * If per cpu limits are enforced there are no global limits, so
> +	 * return without creating max/min_perf_pct attributes
> +	 */
> +	if (per_cpu_limits)
> +		return;
> +
> +	rc = sysfs_create_file(intel_pstate_kobject, &max_perf_pct.attr);
> +	WARN_ON(rc);
> +
> +	rc = sysfs_create_file(intel_pstate_kobject, &min_perf_pct.attr);
> +	WARN_ON(rc);
> +
>  }
>  /************************** sysfs end ************************/
>  
> @@ -1117,24 +1152,32 @@ static const struct cpu_defaults bxt_params = {
>  
>  static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
>  {
> -	int max_perf = cpu->pstate.turbo_pstate;
> +	int max_perf_pstate = cpu->pstate.turbo_pstate;
>  	int max_perf_adj;
> -	int min_perf;
> +	int min_perf, max_perf;

I'd do like above, ie.

	struct perf_limits *perf_limits = limits;

	if (per_cpu_limits)
		perf_limits = cpu->perf_limits;

and replace "limits" with "perf_limits" below.

Then you don't need the new min_perf, max_perf and the changes below.

>  
>  	if (limits->no_turbo || limits->turbo_disabled)
> -		max_perf = cpu->pstate.max_pstate;
> +		max_perf_pstate = cpu->pstate.max_pstate;
> +
> +	if (per_cpu_limits) {
> +		max_perf = cpu->perf_limits->max_perf;
> +		min_perf = cpu->perf_limits->min_perf;
> +	} else {
> +		max_perf = limits->max_perf;
> +		min_perf = limits->min_perf;
> +	}
>  
>  	/*
>  	 * performance can be limited by user through sysfs, by cpufreq
>  	 * policy, or by cpu specific default values determined through
>  	 * experimentation.
>  	 */
> -	max_perf_adj = fp_toint(max_perf * limits->max_perf);
> +	max_perf_adj = fp_toint(max_perf_pstate * max_perf);
>  	*max = clamp_t(int, max_perf_adj,
>  			cpu->pstate.min_pstate, cpu->pstate.turbo_pstate);
>  
> -	min_perf = fp_toint(max_perf * limits->min_perf);
> -	*min = clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
> +	min_perf = fp_toint(max_perf_pstate * min_perf);
> +	*min = clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf_pstate);
>  }
>  
>  static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
> @@ -1416,11 +1459,23 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
>  {
>  	struct cpudata *cpu;
>  
> -	if (!all_cpu_data[cpunum])
> +	if (!all_cpu_data[cpunum]) {
>  		all_cpu_data[cpunum] = kzalloc(sizeof(struct cpudata),
>  					       GFP_KERNEL);
> -	if (!all_cpu_data[cpunum])
> -		return -ENOMEM;
> +		if (!all_cpu_data[cpunum])
> +			return -ENOMEM;
> +
> +		/* for per_cpu_limits every cpu has its own perf_ctl values */
> +		if (per_cpu_limits) {
> +			all_cpu_data[cpunum]->perf_limits =
> +				kzalloc(sizeof(struct perf_limits),
> +					GFP_KERNEL);
> +			if (!all_cpu_data[cpunum]->perf_limits) {
> +				kfree(all_cpu_data[cpunum]);
> +				return -ENOMEM;
> +			}
> +		}
> +	}
>  
>  	cpu = all_cpu_data[cpunum];

I would write it differently:

	cpu = all_cpu_data[cpunum];

	if (!cpu) {
		unsigned int size = sizeof(struct cpudata);

		if (per_cpu_limits)
			size += sizeof(struct perf_limits);

		cpu = kzalloc(size, GFP_KERNEL);
		if (!cpu)
			return -ENOMEM;

		all_cpu_data[cpunum] = cpu;
		if (per_cpu_limits)
			cpu->perf_limits = (struct perf_limits *)(cpu + 1);
	}

One memory allocation instead of two, no need to free on errors ...

>  
> @@ -1488,9 +1543,40 @@ static void intel_pstate_set_performance_limits(struct perf_limits *limits)
>  	limits->min_sysfs_pct = 0;
>  }
>  
> +static void intel_pstate_update_perf_limits(struct cpufreq_policy *policy,
> +					    struct perf_limits *limits)
> +{
> +	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
> +	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0, 100);
> +	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
> +					      policy->cpuinfo.max_freq);
> +	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0, 100);
> +
> +	/* Normalize user input to [min_policy_pct, max_policy_pct] */
> +	limits->min_perf_pct = max(limits->min_policy_pct,
> +				   limits->min_sysfs_pct);
> +	limits->min_perf_pct = min(limits->max_policy_pct,
> +				   limits->min_perf_pct);
> +	limits->max_perf_pct = min(limits->max_policy_pct,
> +				   limits->max_sysfs_pct);
> +	limits->max_perf_pct = max(limits->min_policy_pct,
> +				   limits->max_perf_pct);
> +
> +	/* Make sure min_perf_pct <= max_perf_pct */
> +	limits->min_perf_pct = min(limits->max_perf_pct, limits->min_perf_pct);
> +
> +	limits->min_perf = div_fp(limits->min_perf_pct, 100);
> +	limits->max_perf = div_fp(limits->max_perf_pct, 100);
> +	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
> +
> +	pr_debug("cpu:%d max_perf_pct:%d min_perf_pct:%d\n", policy->cpu,
> +		 limits->max_perf_pct, limits->min_perf_pct);
> +}
> +
>  static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  {
>  	struct cpudata *cpu;
> +	struct perf_limits *perf_limits = NULL;
>  
>  	if (!policy->cpuinfo.max_freq)
>  		return -ENODEV;
> @@ -1506,41 +1592,29 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  		policy->max = policy->cpuinfo.max_freq;
>  	}
>  
> +	if (per_cpu_limits)
> +		perf_limits = cpu->perf_limits;
> +
>  	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
> -		limits = &performance_limits;
> +		if (!perf_limits) {
> +			limits = &performance_limits;
> +			perf_limits = limits;
> +		}
>  		if (policy->max >= policy->cpuinfo.max_freq) {
>  			pr_debug("set performance\n");
> -			intel_pstate_set_performance_limits(limits);
> +			intel_pstate_set_performance_limits(perf_limits);
>  			goto out;
>  		}
>  	} else {
>  		pr_debug("set powersave\n");
> -		limits = &powersave_limits;
> -	}
> -
> -	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
> -	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 , 100);
> -	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
> -					      policy->cpuinfo.max_freq);
> -	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);
> -
> -	/* Normalize user input to [min_policy_pct, max_policy_pct] */
> -	limits->min_perf_pct = max(limits->min_policy_pct,
> -				   limits->min_sysfs_pct);
> -	limits->min_perf_pct = min(limits->max_policy_pct,
> -				   limits->min_perf_pct);
> -	limits->max_perf_pct = min(limits->max_policy_pct,
> -				   limits->max_sysfs_pct);
> -	limits->max_perf_pct = max(limits->min_policy_pct,
> -				   limits->max_perf_pct);
> -
> -	/* Make sure min_perf_pct <= max_perf_pct */
> -	limits->min_perf_pct = min(limits->max_perf_pct, limits->min_perf_pct);
> +		if (!perf_limits) {
> +			limits = &powersave_limits;
> +			perf_limits = limits;
> +		}
>  
> -	limits->min_perf = div_fp(limits->min_perf_pct, 100);
> -	limits->max_perf = div_fp(limits->max_perf_pct, 100);
> -	limits->max_perf = round_up(limits->max_perf, FRAC_BITS);
> +	}
>  
> +	intel_pstate_update_perf_limits(policy, perf_limits);
>   out:
>  	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
>  		/*
> @@ -1600,6 +1674,14 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
>  	else
>  		policy->policy = CPUFREQ_POLICY_POWERSAVE;
>  
> +	/*
> +	 * We need sane value in the cpu->perf_limits, so inherit from global
> +	 * perf_limits limits, which are seeded with values based on the
> +	 * CONFIG_CPU_FREQ_DEFAULT_GOV_*, during boot up.
> +	 */
> +	if (per_cpu_limits)
> +		memcpy(cpu->perf_limits, limits, sizeof(struct perf_limits));
> +
>  	policy->min = cpu->pstate.min_pstate * cpu->pstate.scaling;
>  	policy->max = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
>  
> @@ -1883,6 +1965,8 @@ static int __init intel_pstate_setup(char *str)
>  		force_load = 1;
>  	if (!strcmp(str, "hwp_only"))
>  		hwp_only = 1;
> +	if (!strcmp(str, "per_cpu_perf_limits"))
> +		per_cpu_limits = true;
>  
>  #ifdef CONFIG_ACPI
>  	if (!strcmp(str, "support_acpi_ppc"))
> 

The rest looks OK to me.

Thanks,
Rafael

