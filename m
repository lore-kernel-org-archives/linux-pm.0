From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/6] cpufreq: intel_p_state: Fix limiting turbo sub states
Date: Tue, 06 Oct 2015 00:56:43 +0200
Message-ID: <1962931.XZqpddDuF8@vostro.rjw.lan>
References: <1443567248-27134-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1443567248-27134-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57093 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751279AbbJEW2P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2015 18:28:15 -0400
In-Reply-To: <1443567248-27134-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com, linux-pm@vger.kernel.org

On Tuesday, September 29, 2015 03:54:03 PM Srinivas Pandruvada wrote:
> Although the max_perf_pct reflects sub states in turbo range, we can't
> really restrict to those states. This gives wrong impression that the
> performance is reduced.
> This can be achieved by restricting turbo ratio limits (MSR 0x1AD),
> when bit 28 of platform info MSR allows (MSR 0xCE) is 1.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 92 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 3af9dd7..576d9e8 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -80,6 +80,7 @@ struct pstate_data {
>  	int	max_pstate;
>  	int	scaling;
>  	int	turbo_pstate;
> +	u64	turbo_ratio_limit;

Why does it have to be u64?

>  };
>  
>  struct vid_data {
> @@ -132,6 +133,8 @@ struct pstate_funcs {
>  	int (*get_scaling)(void);
>  	void (*set)(struct cpudata*, int pstate);
>  	void (*get_vid)(struct cpudata *);
> +	u64 (*get_turbo_ratio_limit)(struct cpudata *);
> +	int (*set_turbo_ratio_limit)(struct cpudata *, u64, u64);

An int is always passed as the last arg to this, so why is the arg u64?

>  };
>  
>  struct cpu_defaults {
> @@ -434,6 +437,23 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
>  	limits.max_perf_pct = max(limits.min_perf_pct, limits.max_perf_pct);
>  	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
>  
> +	if (pstate_funcs.set_turbo_ratio_limit) {
> +		int max_perf_adj;
> +		struct cpudata *cpu = all_cpu_data[0];
> +
> +		if (limits.max_sysfs_pct == 100)
> +			max_perf_adj = cpu->pstate.turbo_ratio_limit;

This will cast the u64 to int anyway.

Also this is going to be the value read from the register at init which is
likely to be greater than 255 ->

> +		else
> +			max_perf_adj = fp_toint(mul_fp(int_tofp(
> +					cpu->pstate.turbo_ratio_limit & 0xff),
> +					limits.max_perf));

-> but this will never be greater than 255 if I'm not mistaken (limits.max_perf
is a representation of a fraction between 0 and 1 and the first value is
bounded by 255).

How are these two values related to each other?

> +
> +		if (max_perf_adj > cpu->pstate.max_pstate)
> +			pstate_funcs.set_turbo_ratio_limit(cpu,
> +						cpu->pstate.turbo_ratio_limit,
> +						max_perf_adj);

I'm not really sure what this is supposed to achieve.  Care to explain a bit?

[BTW, the first arg of core_set/get_turbo_ratio_limit(() is never used, so why
bother with passing it at all?]

> +	}
> +
>  	if (hwp_active)
>  		intel_pstate_hwp_set();
>  	return count;
> @@ -628,6 +648,55 @@ static void core_set_pstate(struct cpudata *cpudata, int pstate)
>  	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
>  }
>  
> +static u64 core_get_turbo_ratio_limit(struct cpudata *cpudata)
> +{
> +	u64 value;
> +
> +	rdmsrl(MSR_NHM_TURBO_RATIO_LIMIT, value);
> +
> +	return value;
> +}
> +
> +static int core_set_turbo_ratio_limit(struct cpudata *cpudata, u64 def_ratio,
> +			       u64 new_ratio)
> +{
> +	u64 value;
> +

What should happen if def_ratio and new_ratio are the same?

> +	rdmsrl(MSR_PLATFORM_INFO, value);
> +	if (value & BIT(28)) {
> +		u64 ratio = 0;
> +		u64 out_ratio = 0;
> +		u8 max_ratio = new_ratio & 0xff;

Why u8?

> +		int i;
> +		/*
> +		 * If caller provided reduced max ratio (one core active)
> +		 * then use this for all other ratios, which are more
> +		 * than the default ratio for those many cores active
> +		 * for example if default ratio is 0x1a1b1c1d and new ratio
> +		 * is 0x1b, then resultant ratio will be 0x1a1b1b1b
> +		 */

This is a bit messy IMO.  Instead of shifting def_ratio and new_ratio in each
step, I'd shift max_ratio and the mask:

	u64 mask = 0xff;
	u64 max_ratio = new_ratio & mask;

	while (mask) {
		if (def_ratio & mask) {
			u64 ratio;

			if (new_ratio & mask) {
				ratio = new_ratio & mask;
			} else {
				ratio = def_ratio & mask;
				if (ratio > max_ratio)
					ratio = max_ratio;
			}
			out_ratio |= ratio;
		}
		max_ratio <<= 8;
		mask <<= 8;
	}

[I'm not sure why the least significant byte of new_ratio is special, though.]

> +		for (i = 0; i < sizeof(def_ratio); ++i) {
> +			if (def_ratio & 0xff) {
> +				if (new_ratio & 0xff)
> +					ratio = new_ratio & 0xff;
> +				else {
> +					if ((def_ratio & 0xff) > max_ratio)
> +						ratio = max_ratio;
> +					else
> +						ratio = def_ratio & 0xff;
> +				}
> +				out_ratio |= (ratio << (i * 8));
> +			}
> +			def_ratio >>= 8;
> +			new_ratio >>= 8;
> +		}
> +		wrmsrl(MSR_NHM_TURBO_RATIO_LIMIT, out_ratio);
> +		return 0;
> +	}
> +
> +	return -EPERM;

Why -EPERM?

That's not because the user has no permission to carry out the opreration, but
because there is no capability, right?

> +}
> +
>  static int knl_get_turbo_pstate(void)
>  {
>  	u64 value;
> @@ -656,6 +725,8 @@ static struct cpu_defaults core_params = {
>  		.get_turbo = core_get_turbo_pstate,
>  		.get_scaling = core_get_scaling,
>  		.set = core_set_pstate,
> +		.get_turbo_ratio_limit = core_get_turbo_ratio_limit,
> +		.set_turbo_ratio_limit = core_set_turbo_ratio_limit,
>  	},
>  };
>  
> @@ -745,7 +816,10 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>  	cpu->pstate.max_pstate = pstate_funcs.get_max();
>  	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
>  	cpu->pstate.scaling = pstate_funcs.get_scaling();
> -
> +	if (pstate_funcs.get_turbo_ratio_limit &&
> +	    !cpu->pstate.turbo_ratio_limit)
> +		cpu->pstate.turbo_ratio_limit =
> +			pstate_funcs.get_turbo_ratio_limit(cpu);

So we read MSR_NHM_TURBO_RATIO_LIMIT and store it into pstate.turbo_ratio_limit
unless alread populated.  This means we do it only once during initialization.

What if the value we have in there is stale after, say, system suspend-resume?

Don't we need to re-adjust then?

>  	if (pstate_funcs.get_vid)
>  		pstate_funcs.get_vid(cpu);
>  	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate, false);
> @@ -949,6 +1023,20 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
>  		intel_pstate_hwp_enable(cpu);
>  
>  	intel_pstate_get_cpu_pstates(cpu);
> +	/* readjust turbo limit ratio after resume or hotplug */
> +	if (limits.max_sysfs_pct != 100 &&
> +	    pstate_funcs.set_turbo_ratio_limit) {
> +		int max_perf_adj;
> +
> +		max_perf_adj = fp_toint(mul_fp(int_tofp(
> +					cpu->pstate.turbo_ratio_limit & 0xff),
> +					limits.max_perf));
> +
> +		if (max_perf_adj > cpu->pstate.max_pstate)
> +			pstate_funcs.set_turbo_ratio_limit(cpu,
> +						cpu->pstate.turbo_ratio_limit,
> +						max_perf_adj);
> +	}
>  
>  	init_timer_deferrable(&cpu->timer);
>  	cpu->timer.data = (unsigned long)cpu;
> @@ -1118,6 +1206,8 @@ static void copy_cpu_funcs(struct pstate_funcs *funcs)
>  	pstate_funcs.get_scaling = funcs->get_scaling;
>  	pstate_funcs.set       = funcs->set;
>  	pstate_funcs.get_vid   = funcs->get_vid;
> +	pstate_funcs.set_turbo_ratio_limit = funcs->set_turbo_ratio_limit;
> +	pstate_funcs.get_turbo_ratio_limit = funcs->get_turbo_ratio_limit;

These are defined for Core only, right?  Might be good to write about that in
the changelog.

>  }
>  
>  #if IS_ENABLED(CONFIG_ACPI)
> 

Thanks,
Rafael

