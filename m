From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] cpufreq, intel_pstate, Fix intel_pstate powersave
 min_perf_pct value
Date: Wed, 14 Oct 2015 14:09:57 -0700
Message-ID: <20151014140957.36523ea9@kcaccard-desk.amr.corp.intel.com>
References: <1444822919-14650-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444822919-14650-1-git-send-email-prarit@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 14 Oct 2015 07:41:59 -0400
Prarit Bhargava <prarit@redhat.com> wrote:

> On systems that initialize the intel_pstate driver with the performance
> governor, and then switch to the powersave governor will not transition to
> lower cpu frequencies until /sys/devices/system/cpu/intel_pstate/min_perf_pct
> is set to a low value.
> 
> The behavior of governor switching changed after commit a04759924e25
> ("[cpufreq] intel_pstate: honor user space min_perf_pct override on
>  resume").  The commit introduced tracking of performance percentage
> changes via sysfs in order to restore userspace changes during
> suspend/resume.  The problem occurs because the global values of the newly
> introduced max_sysfs_pct and min_sysfs_pct are not lowered on the governor
> change and this causes the powersave governor to inherit the performance
> governor's settings.
> 
> A simple change would have been to reset max_sysfs_pct to 100 and
> min_sysfs_pct to 0 on a governor change, which fixes the problem with
> governor switching.  However, since we cannot break userspace[1] the fix
> is now to give each governor its own limits storage area so that governor
> specific changes are tracked.
> 
> I successfully tested this by booting with both the performance governor
> and the powersave governor by default, and switching between the two
> governors (while monitoring /sys/devices/system/cpu/intel_pstate/ values,
> and looking at the output of cpupower frequency-info).  Suspend/Resume
> testing was performed by Doug Smythies.
> 
> [1] Systems which suspend/resume using the unmaintained pm-utils package
> will always transition to the performance governor before the suspend and
> after the resume.  This means a system using the powersave governor will
> go from powersave to performance, then suspend/resume, performance to
> powersave.  The simple change during governor changes would have been
> overwritten when the governor changed before and after the suspend/resume.
> I have submitted https://bugzilla.redhat.com/show_bug.cgi?id=1271225
> against Fedora to remove the 94cpufreq file that causes the problem.  It
> should be noted that pm-utils is obsoleted with newer versions of systemd.
> 
> Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Doug Smythies <dsmythies@telus.net>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Acked-by: Kristen Carlson Accardi <kristen@linux.intel.com>

BTW - I think I can see an issue here with HWP enabled systems.  It
looks to me like the hwp settings will not be programmed correctly
during a governor switch.  This probably needs to be addressed in a
separate patch.

> ---
>  drivers/cpufreq/intel_pstate.c |  120 +++++++++++++++++++++++++---------------
>  1 file changed, 75 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 3af9dd7..78b4be5 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -156,7 +156,20 @@ struct perf_limits {
>  	int min_sysfs_pct;
>  };
>  
> -static struct perf_limits limits = {
> +static struct perf_limits performance_limits = {
> +	.no_turbo = 0,
> +	.turbo_disabled = 0,
> +	.max_perf_pct = 100,
> +	.max_perf = int_tofp(1),
> +	.min_perf_pct = 100,
> +	.min_perf = int_tofp(1),
> +	.max_policy_pct = 100,
> +	.max_sysfs_pct = 100,
> +	.min_policy_pct = 0,
> +	.min_sysfs_pct = 0,
> +};
> +
> +static struct perf_limits powersave_limits = {
>  	.no_turbo = 0,
>  	.turbo_disabled = 0,
>  	.max_perf_pct = 100,
> @@ -169,6 +182,12 @@ static struct perf_limits limits = {
>  	.min_sysfs_pct = 0,
>  };
>  
> +#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
> +static struct perf_limits *limits = &performance_limits;
> +#else
> +static struct perf_limits *limits = &powersave_limits;
> +#endif
> +
>  static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
>  			     int deadband, int integral) {
>  	pid->setpoint = setpoint;
> @@ -255,7 +274,7 @@ static inline void update_turbo_state(void)
>  
>  	cpu = all_cpu_data[0];
>  	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
> -	limits.turbo_disabled =
> +	limits->turbo_disabled =
>  		(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ||
>  		 cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
>  }
> @@ -274,14 +293,14 @@ static void intel_pstate_hwp_set(void)
>  
>  	for_each_online_cpu(cpu) {
>  		rdmsrl_on_cpu(cpu, MSR_HWP_REQUEST, &value);
> -		adj_range = limits.min_perf_pct * range / 100;
> +		adj_range = limits->min_perf_pct * range / 100;
>  		min = hw_min + adj_range;
>  		value &= ~HWP_MIN_PERF(~0L);
>  		value |= HWP_MIN_PERF(min);
>  
> -		adj_range = limits.max_perf_pct * range / 100;
> +		adj_range = limits->max_perf_pct * range / 100;
>  		max = hw_min + adj_range;
> -		if (limits.no_turbo) {
> +		if (limits->no_turbo) {
>  			hw_max = HWP_GUARANTEED_PERF(cap);
>  			if (hw_max < max)
>  				max = hw_max;
> @@ -350,7 +369,7 @@ static void __init intel_pstate_debug_expose_params(void)
>  	static ssize_t show_##file_name					\
>  	(struct kobject *kobj, struct attribute *attr, char *buf)	\
>  	{								\
> -		return sprintf(buf, "%u\n", limits.object);		\
> +		return sprintf(buf, "%u\n", limits->object);		\
>  	}
>  
>  static ssize_t show_turbo_pct(struct kobject *kobj,
> @@ -386,10 +405,10 @@ static ssize_t show_no_turbo(struct kobject *kobj,
>  	ssize_t ret;
>  
>  	update_turbo_state();
> -	if (limits.turbo_disabled)
> -		ret = sprintf(buf, "%u\n", limits.turbo_disabled);
> +	if (limits->turbo_disabled)
> +		ret = sprintf(buf, "%u\n", limits->turbo_disabled);
>  	else
> -		ret = sprintf(buf, "%u\n", limits.no_turbo);
> +		ret = sprintf(buf, "%u\n", limits->no_turbo);
>  
>  	return ret;
>  }
> @@ -405,12 +424,12 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
>  		return -EINVAL;
>  
>  	update_turbo_state();
> -	if (limits.turbo_disabled) {
> +	if (limits->turbo_disabled) {
>  		pr_warn("intel_pstate: Turbo disabled by BIOS or unavailable on processor\n");
>  		return -EPERM;
>  	}
>  
> -	limits.no_turbo = clamp_t(int, input, 0, 1);
> +	limits->no_turbo = clamp_t(int, input, 0, 1);
>  
>  	if (hwp_active)
>  		intel_pstate_hwp_set();
> @@ -428,11 +447,15 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	limits.max_sysfs_pct = clamp_t(int, input, 0 , 100);
> -	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
> -	limits.max_perf_pct = max(limits.min_policy_pct, limits.max_perf_pct);
> -	limits.max_perf_pct = max(limits.min_perf_pct, limits.max_perf_pct);
> -	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
> +	limits->max_sysfs_pct = clamp_t(int, input, 0 , 100);
> +	limits->max_perf_pct = min(limits->max_policy_pct,
> +				   limits->max_sysfs_pct);
> +	limits->max_perf_pct = max(limits->min_policy_pct,
> +				   limits->max_perf_pct);
> +	limits->max_perf_pct = max(limits->min_perf_pct,
> +				   limits->max_perf_pct);
> +	limits->max_perf = div_fp(int_tofp(limits->max_perf_pct),
> +				  int_tofp(100));
>  
>  	if (hwp_active)
>  		intel_pstate_hwp_set();
> @@ -449,11 +472,15 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
>  	if (ret != 1)
>  		return -EINVAL;
>  
> -	limits.min_sysfs_pct = clamp_t(int, input, 0 , 100);
> -	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
> -	limits.min_perf_pct = min(limits.max_policy_pct, limits.min_perf_pct);
> -	limits.min_perf_pct = min(limits.max_perf_pct, limits.min_perf_pct);
> -	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
> +	limits->min_sysfs_pct = clamp_t(int, input, 0 , 100);
> +	limits->min_perf_pct = max(limits->min_policy_pct,
> +				   limits->min_sysfs_pct);
> +	limits->min_perf_pct = min(limits->max_policy_pct,
> +				   limits->min_perf_pct);
> +	limits->min_perf_pct = min(limits->max_perf_pct,
> +				   limits->min_perf_pct);
> +	limits->min_perf = div_fp(int_tofp(limits->min_perf_pct),
> +				  int_tofp(100));
>  
>  	if (hwp_active)
>  		intel_pstate_hwp_set();
> @@ -533,7 +560,7 @@ static void byt_set_pstate(struct cpudata *cpudata, int pstate)
>  	u32 vid;
>  
>  	val = (u64)pstate << 8;
> -	if (limits.no_turbo && !limits.turbo_disabled)
> +	if (limits->no_turbo && !limits->turbo_disabled)
>  		val |= (u64)1 << 32;
>  
>  	vid_fp = cpudata->vid.min + mul_fp(
> @@ -622,7 +649,7 @@ static void core_set_pstate(struct cpudata *cpudata, int pstate)
>  	u64 val;
>  
>  	val = (u64)pstate << 8;
> -	if (limits.no_turbo && !limits.turbo_disabled)
> +	if (limits->no_turbo && !limits->turbo_disabled)
>  		val |= (u64)1 << 32;
>  
>  	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
> @@ -702,7 +729,7 @@ static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
>  	int max_perf_adj;
>  	int min_perf;
>  
> -	if (limits.no_turbo || limits.turbo_disabled)
> +	if (limits->no_turbo || limits->turbo_disabled)
>  		max_perf = cpu->pstate.max_pstate;
>  
>  	/*
> @@ -710,11 +737,11 @@ static void intel_pstate_get_min_max(struct cpudata *cpu, int *min, int *max)
>  	 * policy, or by cpu specific default values determined through
>  	 * experimentation.
>  	 */
> -	max_perf_adj = fp_toint(mul_fp(int_tofp(max_perf), limits.max_perf));
> +	max_perf_adj = fp_toint(mul_fp(int_tofp(max_perf), limits->max_perf));
>  	*max = clamp_t(int, max_perf_adj,
>  			cpu->pstate.min_pstate, cpu->pstate.turbo_pstate);
>  
> -	min_perf = fp_toint(mul_fp(int_tofp(max_perf), limits.min_perf));
> +	min_perf = fp_toint(mul_fp(int_tofp(max_perf), limits->min_perf));
>  	*min = clamp_t(int, min_perf, cpu->pstate.min_pstate, max_perf);
>  }
>  
> @@ -988,32 +1015,35 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  
>  	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE &&
>  	    policy->max >= policy->cpuinfo.max_freq) {
> -		limits.min_policy_pct = 100;
> -		limits.min_perf_pct = 100;
> -		limits.min_perf = int_tofp(1);
> -		limits.max_policy_pct = 100;
> -		limits.max_perf_pct = 100;
> -		limits.max_perf = int_tofp(1);
> -		limits.no_turbo = 0;
> +		pr_debug("intel_pstate: set performance\n");
> +		limits = &performance_limits;
>  		return 0;
>  	}
>  
> -	limits.min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
> -	limits.min_policy_pct = clamp_t(int, limits.min_policy_pct, 0 , 100);
> -	limits.max_policy_pct = (policy->max * 100) / policy->cpuinfo.max_freq;
> -	limits.max_policy_pct = clamp_t(int, limits.max_policy_pct, 0 , 100);
> +	pr_debug("intel_pstate: set powersave\n");
> +	limits = &powersave_limits;
> +	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
> +	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 , 100);
> +	limits->max_policy_pct = (policy->max * 100) / policy->cpuinfo.max_freq;
> +	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);
>  
>  	/* Normalize user input to [min_policy_pct, max_policy_pct] */
> -	limits.min_perf_pct = max(limits.min_policy_pct, limits.min_sysfs_pct);
> -	limits.min_perf_pct = min(limits.max_policy_pct, limits.min_perf_pct);
> -	limits.max_perf_pct = min(limits.max_policy_pct, limits.max_sysfs_pct);
> -	limits.max_perf_pct = max(limits.min_policy_pct, limits.max_perf_pct);
> +	limits->min_perf_pct = max(limits->min_policy_pct,
> +				   limits->min_sysfs_pct);
> +	limits->min_perf_pct = min(limits->max_policy_pct,
> +				   limits->min_perf_pct);
> +	limits->max_perf_pct = min(limits->max_policy_pct,
> +				   limits->max_sysfs_pct);
> +	limits->max_perf_pct = max(limits->min_policy_pct,
> +				   limits->max_perf_pct);
>  
>  	/* Make sure min_perf_pct <= max_perf_pct */
> -	limits.min_perf_pct = min(limits.max_perf_pct, limits.min_perf_pct);
> +	limits->min_perf_pct = min(limits->max_perf_pct, limits->min_perf_pct);
>  
> -	limits.min_perf = div_fp(int_tofp(limits.min_perf_pct), int_tofp(100));
> -	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
> +	limits->min_perf = div_fp(int_tofp(limits->min_perf_pct),
> +				  int_tofp(100));
> +	limits->max_perf = div_fp(int_tofp(limits->max_perf_pct),
> +				  int_tofp(100));
>  
>  	if (hwp_active)
>  		intel_pstate_hwp_set();
> @@ -1057,7 +1087,7 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  	cpu = all_cpu_data[policy->cpu];
>  
> -	if (limits.min_perf_pct == 100 && limits.max_perf_pct == 100)
> +	if (limits->min_perf_pct == 100 && limits->max_perf_pct == 100)
>  		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
>  	else
>  		policy->policy = CPUFREQ_POLICY_POWERSAVE;
