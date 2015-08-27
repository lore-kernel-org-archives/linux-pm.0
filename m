From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 4/5] cpufreq: intel_pstate: Use ACPI perf configuration
Date: Thu, 27 Aug 2015 05:08:27 -0700
Message-ID: <1440677307.3108.25.camel@linux.intel.com>
References: <1440621161-2732-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1440621161-2732-5-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <2384688.3xSebA7DaU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39231 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597AbbH0MLo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Aug 2015 08:11:44 -0400
In-Reply-To: <2384688.3xSebA7DaU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com, linux-pm@vger.kernel.org

On Thu, 2015-08-27 at 03:11 +0200, Rafael J. Wysocki wrote:
> On Wednesday, August 26, 2015 01:32:40 PM Srinivas Pandruvada wrote:
> > Use ACPI _PSS to limit the Intel P State turbo, max and min ratios.
> > This driver uses acpi processor perf lib calls to register 
> > performance.
> > The following logic is used to adjust Intel P state driver limits:
> > - If there is no turbo entry in _PSS, then disable Intel P state 
> > turbo
> > and limit to non turbo max
> > - If the non turbo max ratio is more than _PSS max non turbo value, 
> > then
> > set the max non turbo ratio to _PSS non turbo max
> > - If the min ratio is less than _PSS min then change the min ratio
> > matching _PSS min
> > - Scale the _PSS turbo frequency to max turbo frequency based on 
> > control
> > value.
> 
> The new command line switch should be mentioned in the changelog too.
Missed it. Also need to update the kernel command line document.
> 
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/cpufreq/Kconfig.x86    |   1 +
> >  drivers/cpufreq/intel_pstate.c | 130 
> > +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 131 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/Kconfig.x86 
> > b/drivers/cpufreq/Kconfig.x86
> > index c59bdcb..1c6affd 100644
> > --- a/drivers/cpufreq/Kconfig.x86
> > +++ b/drivers/cpufreq/Kconfig.x86
> > @@ -5,6 +5,7 @@
> >  config X86_INTEL_PSTATE
> >         bool "Intel P state control"
> >         depends on X86
> > +       select ACPI_PROCESSOR
> 
> 	select ACPI_PROCESSOR if ACPI
> 
> or there will be a broken dependency if ACPI is not selected.
I will fix this in next patchset.
> 
> >         help
> >            This driver provides a P state for Intel core 
> > processors.
> >  	  The driver implements an internal governor and will 
> > become
> > diff --git a/drivers/cpufreq/intel_pstate.c 
> > b/drivers/cpufreq/intel_pstate.c
> > index a349462..6eafb55 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -34,6 +34,8 @@
> >  #include <asm/cpu_device_id.h>
> >  #include <asm/cpufeature.h>
> >  
> > +#include <acpi/processor.h>
> > +
> >  #define BYT_RATIOS		0x66a
> >  #define BYT_VIDS		0x66b
> >  #define BYT_TURBO_RATIOS	0x66c
> > @@ -114,6 +116,9 @@ struct cpudata {
> >  	u64	prev_mperf;
> >  	u64	prev_tsc;
> >  	struct sample sample;
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +	struct acpi_processor_performance acpi_perf_data;
> > +#endif
> >  };
> >  
> >  static struct cpudata **all_cpu_data;
> > @@ -146,6 +151,7 @@ struct cpu_defaults {
> >  static struct pstate_adjust_policy pid_params;
> >  static struct pstate_funcs pstate_funcs;
> >  static int hwp_active;
> > +static int no_acpi_perf;
> 
> Why don't you call it "no_acpi"?  The "perf" part seems to be 
> redundant.
> 
OK. I will change this.
> >  
> >  struct perf_limits {
> >  	int no_turbo;
> > @@ -173,6 +179,116 @@ static struct perf_limits limits = {
> >  	.min_sysfs_pct = 0,
> >  };
> >  
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +static int intel_pstate_init_perf_limits(struct cpufreq_policy 
> > *policy)
> > +{
> > +	struct cpudata *cpu;
> > +	int ret;
> > +	int min_perf;
> > +	bool turbo_absent = false;
> > +	int i;
> > +
> > +	cpu = all_cpu_data[policy->cpu];
> > +
> > +	if (!cpu->acpi_perf_data.shared_cpu_map &&
> > +	    zalloc_cpumask_var_node(&cpu
> > ->acpi_perf_data.shared_cpu_map,
> > +				    GFP_KERNEL, cpu_to_node(policy
> > ->cpu))) {
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ret = acpi_processor_register_performance(&cpu
> > ->acpi_perf_data,
> > +						  policy->cpu);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (cpu->acpi_perf_data.control_register.space_id !=
> > +						ACPI_ADR_SPACE_FIX
> > ED_HARDWARE)
> > +		return -EIO;
> > +
> > +	pr_debug("CPU%u - ACPI _PSS perf data\n", policy->cpu);
> > +	for (i = 0; i < cpu->acpi_perf_data.state_count; i++)
> > +		pr_debug("     %cP%d: %u MHz, %u mW, 0x%x\n",
> > +			 (i == cpu->acpi_perf_data.state ? '*' : ' 
> > '), i,
> > +			 (u32) cpu
> > ->acpi_perf_data.states[i].core_frequency,
> > +			 (u32) cpu
> > ->acpi_perf_data.states[i].power,
> > +			 (u32) cpu
> > ->acpi_perf_data.states[i].control);
> > +
> > +	if (cpu->acpi_perf_data.state_count < 2)
> > +		return 0;
> 
> So what happens if we do that?  We'll not use ACPI limits, right?
> 
Yes, we will continue as before with Intel P state calculated limits
based on MSRs.
> > +
> > +	/* Check if there is a turbo freq in _PSS */
> > +	if ((cpu->acpi_perf_data.states[0].core_frequency % 2) == 
> > 0) {
> 
> Where does this check come from?
Isn't general convention to specify turbo frequency (max non turbo freq
+ 1 MHz)? Usually these are specified by BIOS writer guides.
> 
> > +		pr_debug("no turbo range exists in _PSS\n");
> > +		limits.no_turbo = limits.turbo_disabled = 1;
> > +		cpu->pstate.turbo_pstate = cpu->pstate.max_pstate;
> > +		turbo_absent = true;
> > +	}
> > +
> > +	/* Check if the max non turbo p state < Intel P state max 
> > */
> > +	for (i = 0; i < cpu->acpi_perf_data.state_count; i++) {
> > +		if ((cpu->acpi_perf_data.states[i].core_frequency 
> > % 2) == 0) {
> 
> And this?
> 
> Generally, this reads "if core_frequency of state i is even", but 
> this is
> a number from the firmware, so I'm not sure why it being even or odd 
> has
> to be meaningful in any way?
> 
The first even frequency will be max non turbo. There can't be a
frequncy 2301 Mhz in Intel Processors (which is indicating a turbo
frequency). For example:
[    1.233597]      *P0: 2301 MHz, 15000 mW, 0x1d00
[    1.233598]       P1: 2300 MHz, 15000 mW, 0x1700
[    1.233599]       P2: 2200 MHz, 14088 mW, 0x1600
[    1.233600]       P3: 2000 MHz, 12462 mW, 0x1400
[    1.233601]       P4: 1900 MHz, 11745 mW, 0x1300
[    1.233602]       P5: 1800 MHz, 11042 mW, 0x1200
[    1.233603]       P6: 1700 MHz, 10215 mW, 0x1100
[    1.233604]       P7: 1500 MHz, 8882 mW, 0xf00
[    1.233605]       P8: 1400 MHz, 8101 mW, 0xe00
[    1.233606]       P9: 1300 MHz, 7471 mW, 0xd00
[    1.233607]       P10: 1100 MHz, 6121 mW, 0xb00
[    1.233608]       P11: 1000 MHz, 5531 mW, 0xa00
[    1.233610]       P12: 900 MHz, 4955 mW, 0x900
[    1.233611]       P13: 800 MHz, 4267 mW, 0x800
[    1.233612]       P14: 600 MHz, 3182 mW, 0x600
[    1.233613]       P15: 500 MHz, 2538 mW, 0x500

Let me think if I can use control values (the last column in the above
log) instead of using odd/even.

> > +			int perf_max_ctl =
> > +				cpu
> > ->acpi_perf_data.states[i].control >> 8;
> > +			if (cpu->pstate.max_pstate > perf_max_ctl)
> > +				cpu->pstate.max_pstate = 
> > perf_max_ctl;
> > +			break;
> > +		}
> > +	}
> > +
> > +	/* check If min perf > Intel P State min */
> > +	min_perf = cpu->acpi_perf_data.states[
> > +			cpu->acpi_perf_data.state_count - 
> > 1].control >> 8;
> > +	if (min_perf > cpu->pstate.min_pstate) {
> > +		cpu->pstate.min_pstate = min_perf;
> 
> What's the guarantee that min_perf can be used as min_pstate?
Intel P state min is the lowest possible P state from the processor
platform info MSR. So if the ACPI specified min_perf is more, then it
should work. It is possible that ACPI is setting floor for P states.
> > +		policy->cpuinfo.min_freq = cpu->pstate.min_pstate 
> > *
> > +						cpu
> > ->pstate.scaling;
> > +	}
> > +
> > +	if (turbo_absent)
> > +		policy->cpuinfo.max_freq =
> > +			cpu->pstate.max_pstate * cpu
> > ->pstate.scaling;
> > +	else {
> > +		policy->cpuinfo.max_freq =
> > +			cpu->pstate.turbo_pstate * cpu
> > ->pstate.scaling;
> > +		/* scale freq to intel pstate turbo scale */
> > +		cpu->acpi_perf_data.states[0].core_frequency =
> > +				cpu->pstate.scaling *
> > +				(cpu
> > ->acpi_perf_data.states[0].control >> 8);
> > +	}
> > +
> > +	pr_debug("Updated limits 0x%x 0x%x 0x %x\n", cpu
> > ->pstate.min_pstate,
> > +		 cpu->pstate.max_pstate, cpu
> > ->pstate.turbo_pstate);
> > +	pr_debug("policy max_freq=%d Khz min_freq = %d KHz\n",
> > +		 policy->cpuinfo.max_freq, policy
> > ->cpuinfo.min_freq);
> > +
> > +	return 0;
> > +}
> > +
> > +static int intel_pstate_exit_perf_limits(struct cpufreq_policy 
> > *policy)
> > +{
> > +	struct cpudata *cpu;
> > +
> > +	if (!no_acpi_perf)
> > +		return 0;
> > +
> > +	cpu = all_cpu_data[policy->cpu];
> > +	acpi_processor_unregister_performance(&cpu
> > ->acpi_perf_data,
> > +					      policy->cpu);
> > +	return 0;
> > +}
> > +
> > +#else
> > +static int intel_pstate_init_perf_limits(struct cpufreq_policy 
> > *policy)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int intel_pstate_exit_perf_limits(struct cpufreq_policy 
> > *policy)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >  static inline void pid_reset(struct _pid *pid, int setpoint, int 
> > busy,
> >  			     int deadband, int integral) {
> >  	pid->setpoint = setpoint;
> > @@ -1186,18 +1302,29 @@ static int intel_pstate_cpu_init(struct 
> > cpufreq_policy *policy)
> >  	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu
> > ->pstate.scaling;
> >  	policy->cpuinfo.max_freq =
> >  		cpu->pstate.turbo_pstate * cpu->pstate.scaling;
> > +	if (!no_acpi_perf)
> > +		intel_pstate_init_perf_limits(policy);
> > +	/* If there is no acpi perf data or error, we ignore and 
> > use Intel P
> > +	 * state calculated limits
> > +	 */
> >  	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
> >  	cpumask_set_cpu(policy->cpu, policy->cpus);
> >  
> >  	return 0;
> >  }
> >  
> > +static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> > +{
> > +	return intel_pstate_exit_perf_limits(policy);
> > +}
> > +
> >  static struct cpufreq_driver intel_pstate_driver = {
> >  	.flags		= CPUFREQ_CONST_LOOPS,
> >  	.verify		= intel_pstate_verify_policy,
> >  	.setpolicy	= intel_pstate_set_policy,
> >  	.get		= intel_pstate_get,
> >  	.init		= intel_pstate_cpu_init,
> > +	.exit		= intel_pstate_cpu_exit,
> >  	.stop_cpu	= intel_pstate_stop_cpu,
> >  	.name		= "intel_pstate",
> >  };
> > @@ -1429,6 +1556,9 @@ static int __init intel_pstate_setup(char 
> > *str)
> >  		force_load = 1;
> >  	if (!strcmp(str, "hwp_only"))
> >  		hwp_only = 1;
> > +	if (!strcmp(str, "no_acpi_perf"))
> > +		no_acpi_perf = 1;
> > +
> >  	return 0;
> >  }
> >  early_param("intel_pstate", intel_pstate_setup);
> > 
> 
