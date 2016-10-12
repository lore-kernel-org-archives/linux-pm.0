From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Update][PATCH 1/2] cpufreq: intel_pstate: Per CPU P-State limits
Date: Thu, 13 Oct 2016 00:26:15 +0200
Message-ID: <3832699.WyNH3AWCH1@vostro.rjw.lan>
References: <1476299241-87924-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62312 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S932937AbcJLWTa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2016 18:19:30 -0400
In-Reply-To: <1476299241-87924-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org

Hi,

On Wednesday, October 12, 2016 12:07:21 PM Srinivas Pandruvada wrote:
> Intel P-State offers two interface to set performance limits:
> - Intel P-State sysfs
> 	/sys/devices/system/cpu/intel_pstate/max_perf_pct
> 	/sys/devices/system/cpu/intel_pstate/min_perf_pct
> - cpufreq
> 	/sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
> 	/sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
> 
> In the current implementation both of the above methods, change limits to
> every CPU in the system, even if cpufreq interface offers per CPU controls.
> 
> This change gives some clarity to these interfaces and fixes cpufreq sysfs
> interface to only impact the CPU on which operation is done (When possible
> by the CPU architecture and also need to consider hyperthreading)
> 
> To be precise:
> - Intel P-State sysfs is for placing global limits for all CPUs
> - The cpufreq sysfs for individual CPU is to place limits on each CPU,
> which are constrained by global limits. So If the global limit is
> to reduce max_perf_pct to 80%, the individual CPU can't exceed 80%
> of performance, but each CPU can add more restrictive limit
> (E.g. say 60% here). Same rule applies to min_perf_pct. Each CPU
> can request more than min_perf_pct as a limit value.

I have a couple of comments to the details, but let me start with a high-level view.

I would do this quite differently.  There is quite a bit of a headache with
keeping the global settings (intel_pstate/max(min)_perf_pct) and the per-policy
scaling_max(min)_freq in sync and I'm not sure this really is necessary.  
Moreover, all of these updates are asynchronous with respect to the scheduler
callback anyway, so there are races this synchronization between the settings
doesn't cover.  IMO, it would be sufficient to combine the two in
intel_pstate_get_min_max() only where the limits to apply for the given CPU are
computed.

So if limits->max_sysfs_perf is there (in addition to or even instead of
limits->max_sysfs_pct), intel_pstate_get_min_max() can be something like:

static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
{
	int max_pstate = cpu->pstate.turbo_pstate;
	int32_t min_perf, max_perf;

	max_pstate = limits->no_turbo || limits->turbo_disabled ?
		cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;

	min_perf = max(limits->min_sysfs_perf, cpu->min_perf);
	max_perf = min(limits->max_sysfs_perf, cpu->max_perf);
	
	/*
	 * performance can be limited by user through sysfs, by cpufreq
	 * policy, or by cpu specific default values determined through
	 * experimentation.
	 */
	*max = clamp_t(int, fp_toint(max_pstate * max_perf),
			cpu->pstate.min_pstate, cpu->pstate.turbo_pstate);

	*min = clamp_t(int, fp_toint(max_pstate * limits->min_perf),
			cpu->pstate.min_pstate, max_pstate);
}

and there's no reason why different CPUs (cpufreq policies) should affect each
other.

All of the code will become much simpler then AFAICS.

> 
>  drivers/cpufreq/intel_pstate.c | 361 +++++++++++++++++++++++++++++------------
>  1 file changed, 257 insertions(+), 104 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 1c7b91c..d49fe21 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -193,6 +193,24 @@ struct _pid {
>   * @prev_cummulative_iowait: IO Wait time difference from last and
>   *			current sample
>   * @sample:		Storage for storing last Sample data
> + * @max_perf:		This is a scaled value between 0 to 255 for
> + *			max_perf_pct. This value is used to limit
> + *			max pstate for this CPU
> + * @min_perf:		This is a scaled value between 0 to 255 for
> + *			min_perf_pct. This value is used to limit
> + *			min pstate for this CPU
> + * @prev_max_perf:	Last max_perf value
> + * @prev_min_perf:	Last min perf value
> + * @max_policy_pct:	The maximum performance in percentage enforced by
> + *			cpufreq setpolicy interface for this CPU
> + * @max_policy_pct:	The minimum performance in percentage enforced by
> + *			cpufreq setpolicy interface for this CPU

@min_policy_pct:

> + * @max_perf_pct:	Effective maximum performance limit in percentage, this
> + *			is minimum of either limits enforced by cpufreq policy
> + *			or limits from user set limits via intel_pstate sysfs
> + * @min_perf_pct:	Effective minimum performance limit in percentage, this
> + *			is maximum of either limits enforced by cpufreq policy
> + *			or limits from user set limits via intel_pstate sysfs
>   * @acpi_perf_data:	Stores ACPI perf information read from _PSS
>   * @valid_pss_table:	Set to true for valid ACPI _PSS entries found
>   *
> @@ -215,6 +233,14 @@ struct cpudata {
>  	u64	prev_tsc;
>  	u64	prev_cummulative_iowait;
>  	struct sample sample;
> +	int32_t max_perf;
> +	int32_t min_perf;
> +	int32_t prev_max_perf;
> +	int32_t prev_min_perf;
> +	int max_policy_pct;
> +	int min_policy_pct;
> +	int max_perf_pct;
> +	int min_perf_pct;
>  #ifdef CONFIG_ACPI
>  	struct acpi_processor_performance acpi_perf_data;
>  	bool valid_pss_table;
> @@ -289,6 +315,9 @@ static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu);
>  static struct pstate_adjust_policy pid_params __read_mostly;
>  static struct pstate_funcs pstate_funcs __read_mostly;
>  static int hwp_active __read_mostly;
> +static DEFINE_MUTEX(perf_limits_lock);
> +static int system_policy_max_perf;
> +static int system_policy_min_perf;
>  
>  #ifdef CONFIG_ACPI
>  static bool acpi_ppc;
> @@ -300,63 +329,31 @@ static bool acpi_ppc;
>   * @turbo_disabled:	Platform turbo status either from msr
>   *			MSR_IA32_MISC_ENABLE or when maximum available pstate
>   *			matches the maximum turbo pstate
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
>   * @max_sysfs_pct:	The maximum performance in percentage enforced by
> - *			intel pstate sysfs interface
> - * @min_policy_pct:	The minimum performance in percentage enforced by
> - *			cpufreq setpolicy interface
> + *			intel pstate sysfs interface for all CPUs
>   * @min_sysfs_pct:	The minimum performance in percentage enforced by
> - *			intel pstate sysfs interface
> + *			intel pstate sysfs interface for all CPUs
>   *
>   * Storage for user and policy defined limits.
>   */
>  struct perf_limits {
>  	int no_turbo;
>  	int turbo_disabled;
> -	int max_perf_pct;
> -	int min_perf_pct;
> -	int32_t max_perf;
> -	int32_t min_perf;
> -	int max_policy_pct;
>  	int max_sysfs_pct;
> -	int min_policy_pct;
>  	int min_sysfs_pct;
>  };
>  
>  static struct perf_limits performance_limits = {
>  	.no_turbo = 0,
>  	.turbo_disabled = 0,
> -	.max_perf_pct = 100,
> -	.max_perf = int_tofp(1),
> -	.min_perf_pct = 100,
> -	.min_perf = int_tofp(1),
> -	.max_policy_pct = 100,
>  	.max_sysfs_pct = 100,
> -	.min_policy_pct = 0,
>  	.min_sysfs_pct = 0,
>  };
>  
>  static struct perf_limits powersave_limits = {
>  	.no_turbo = 0,
>  	.turbo_disabled = 0,
> -	.max_perf_pct = 100,
> -	.max_perf = int_tofp(1),
> -	.min_perf_pct = 0,
> -	.min_perf = 0,
> -	.max_policy_pct = 100,
>  	.max_sysfs_pct = 100,
> -	.min_policy_pct = 0,
>  	.min_sysfs_pct = 0,
>  };
>  
> @@ -569,12 +566,12 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
>  		range = hw_max - hw_min;
>  
>  		rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
> -		adj_range = limits->min_perf_pct * range / 100;
> +		adj_range = all_cpu_data[cpu]->min_perf_pct * range / 100;
>  		min = hw_min + adj_range;
>  		value &= ~HWP_MIN_PERF(~0L);
>  		value |= HWP_MIN_PERF(min);
>  
> -		adj_range = limits->max_perf_pct * range / 100;
> +		adj_range = all_cpu_data[cpu]->max_perf_pct * range / 100;
>  		max = hw_min + adj_range;
>  		if (limits->no_turbo) {
>  			hw_max = HWP_GUARANTEED_PERF(cap);

I'd change this as I said in the beginning.

> @@ -654,12 +651,6 @@ static void __init intel_pstate_debug_expose_params(void)
>  /************************** debugfs end ************************/
>  
>  /************************** sysfs begin ************************/
> -#define show_one(file_name, object)					\
> -	static ssize_t show_##file_name					\
> -	(struct kobject *kobj, struct attribute *attr, char *buf)	\
> -	{								\
> -		return sprintf(buf, "%u\n", limits->object);		\
> -	}
>  

And then this can stay as is I think.

>  static ssize_t show_turbo_pct(struct kobject *kobj,
>  				struct attribute *attr, char *buf)
> @@ -726,27 +717,126 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
>  	return count;
>  }
>  
> +/*
> + * Find the maximum and minimum performance as a percentage based
> + * on limits placed on individual CPUs. Since threads can migrate
> + * to different CPUs, the ground rules are:
> + * - The max performance is the CPU with least performance, since that
> + * is what can be be most constrained max performance limit.
> + * - The min performance is the CPU with the max limit on performance,
> + * since that is what can be be most constrained min performance limit.
> + */

Generally, if you add a comment to a function, there's no reason why it should
not be a proper kerneldoc.

> +static void get_max_min_perf(int *max_perf, int *min_perf)
> +{
> +	int cpu_index;
> +
> +	mutex_lock(&perf_limits_lock);
> +
> +	/*
> +	 * If there is no set_policy() or offline cpu called after last
> +	 * calculation, don't need to calculate min/max
> +	 */
> +	if (system_policy_max_perf && system_policy_min_perf)
> +		goto set_perf_val;
> +
> +	system_policy_max_perf = limits->max_sysfs_pct;
> +	system_policy_min_perf = limits->min_sysfs_pct;
> +
> +	for_each_online_cpu(cpu_index) {

Iterating over online CPUs generally requires CPU online/offline to be locked.

Otherwise the CPU you are dealing with at the moment may go away from under you.

> +		struct cpudata *cpu = all_cpu_data[cpu_index];
> +
> +		if (system_policy_max_perf > cpu->max_perf_pct)
> +			system_policy_max_perf = cpu->max_perf_pct;
> +
> +		if (system_policy_min_perf < cpu->min_perf_pct)
> +			system_policy_min_perf = cpu->min_perf_pct;
> +	}
> +
> +set_perf_val:
> +	*min_perf = system_policy_min_perf;
> +	*max_perf = system_policy_max_perf;
> +
> +	mutex_unlock(&perf_limits_lock);
> +}
> +
> +/*
> + * Invalidate max/min sysfs limits: this will force recalculation during next
> + * sysfs [max|min]perf_pct read/writes. Must be called with perf_limit_lock
> + * mutex held.
> + */
> +static void invalidate_policy_perf_limits(void)
> +{
> +	system_policy_max_perf = 0;
> +	system_policy_min_perf = 0;
> +}
> +
> +static ssize_t show_max_perf_pct(struct kobject *kobj,
> +				 struct attribute *attr, char *buf)
> +{
> +	int max_perf, min_perf;
> +
> +	get_max_min_perf(&max_perf, &min_perf);
> +
> +	return sprintf(buf, "%d\n", max_perf);
> +}
> +
> +static ssize_t show_min_perf_pct(struct kobject *kobj,
> +				 struct attribute *attr, char *buf)
> +{
> +	int max_perf, min_perf;
> +
> +	get_max_min_perf(&max_perf, &min_perf);
> +
> +	return sprintf(buf, "%d\n", min_perf);
> +}

>From the above two we can simply return the last value written to them IMO.

That would be less confusing to users than returning some effective value
depending on the per-policy settings.

Thanks,
Rafael

