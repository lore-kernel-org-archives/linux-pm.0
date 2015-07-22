From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC PATCH] cpufreq: intel_pstate: Use ACPI perf configuration
Date: Wed, 22 Jul 2015 10:46:30 -0700
Message-ID: <1437587190.2377.218.camel@spandruv-DESK3.jf.intel.com>
References: <1437542867-32559-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <55AF6BC2.4010407@yandex-team.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53303 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848AbbGVRsx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 Jul 2015 13:48:53 -0400
In-Reply-To: <55AF6BC2.4010407@yandex-team.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com, linux-pm@vger.kernel.org

On Wed, 2015-07-22 at 13:09 +0300, Konstantin Khlebnikov wrote:
> On 22.07.2015 08:27, Srinivas Pandruvada wrote:
> > Use ACPI _PSS to limit the Intel P State turbo, max and min ratios. This driver
> > uses acpi processor perf lib calls to register performance. The following
> > logic is used to adjust Intel P state driver limits:
> > - If there is no turbo entry in _PSS, then disable Intel P state turbo and limit
> > to non turbo max
> > - If the non turbo max ratio is more than _PSS max non turbo value, then
> > set the max non turbo ratio to _PSS non turbo max
> > - If the min ratio is less than _PSS min then change the min ratio matching
> > _PSS min
> > - Scale the _PSS turbo frequency to max turbo frequency based on control value.
> 
> Well. This patch does exactly the same thing as mine so
> this should  work for my case too. Some notes below.
More than that this is not only using _PPC but also _PSS (there are
users who don't want BIOS to limit hence you have command line option
"ignore_ppc", may be some users improved cooling capability). It will
set the internal limits matching _PSS. Intel P state also has its own
sysfs other than cpufreq, which needs to show and act correctly. For
example if the number of p states reduced by _PSS, then it should show
them correctly. There are thermal control program relies on them.
I don't mind if you want to resubmit your change taking care of these.
There are still gapes if you want to fill. We are not skipping the
ratios which are not in _PSS. Also the _PSS allows to go lower than LFM
which may be used on some atom platforms. 
> 
> >
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> >   drivers/cpufreq/intel_pstate.c | 115 +++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 115 insertions(+)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index 6414661..576aec0 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -33,6 +33,8 @@
> >   #include <asm/cpu_device_id.h>
> >   #include <asm/cpufeature.h>
> >
> > +#include <acpi/processor.h>
> > +
> >   #define BYT_RATIOS		0x66a
> >   #define BYT_VIDS		0x66b
> >   #define BYT_TURBO_RATIOS	0x66c
> > @@ -110,6 +112,9 @@ struct cpudata {
> >   	u64	prev_aperf;
> >   	u64	prev_mperf;
> >   	struct sample sample;
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +	struct acpi_processor_performance acpi_perf_data;
> > +#endif
> >   };
> >
> >   static struct cpudata **all_cpu_data;
> > @@ -166,6 +171,109 @@ static struct perf_limits limits = {
> >   	.min_sysfs_pct = 0,
> >   };
> >
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +static int intel_pstate_init_perf_limits(struct cpufreq_policy *policy)
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
> > +	    zalloc_cpumask_var_node(&cpu->acpi_perf_data.shared_cpu_map,
> > +				    GFP_KERNEL, cpu_to_node(policy->cpu))) {
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ret = acpi_processor_register_performance(&cpu->acpi_perf_data,
> > +						  policy->cpu);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pr_debug("CPU%u - ACPI _PSS perf data\n", policy->cpu);
> > +	for (i = 0; i < cpu->acpi_perf_data.state_count; i++)
> > +		pr_debug("     %cP%d: %d MHz, %d mW, 0x%x\n",
> > +			 (i == cpu->acpi_perf_data.state ? '*' : ' '), i,
> > +			 (u32) cpu->acpi_perf_data.states[i].core_frequency,
> > +			 (u32) cpu->acpi_perf_data.states[i].power,
> > +			 (u32) cpu->acpi_perf_data.states[i].control);
> > +
> > +	if (cpu->acpi_perf_data.state_count < 2)
> > +		return 0;
> > +
> > +	/* Check if there is a turbo freq in _PSS */
> > +	if ((cpu->acpi_perf_data.states[0].core_frequency % 2) == 0) {
> 
> _PSS state with odd frequency is a turbo state?
> This is empirical fact or this's documented somewhere?
In BIOS writer guides.
> 
> > +		pr_debug("no turbo range exists in _PSS\n");
> > +		limits.no_turbo = limits.turbo_disabled = 1;
> 
> Disabled once turbo ever returns back automatically?
> 
> > +		cpu->pstate.turbo_pstate = cpu->pstate.max_pstate;
> > +		turbo_absent = true;
> > +	}
> 
> This is really required?
> If bios disables turbo then it also clears turbo bit in 
> MSR_IA32_MISC_ENABLE. No? Checking it there is much easier.
You can have still opportunistic performance enabled but not let it
selectable by user by displaying. The BIOS may change the turbo
activation to any value in the recent processors. The driver I/F is not
available in Linux yet.
> 
> > +
> > +	/* Check if the max non turbo p state < Intel P state max */
> > +	for (i = 0; i < cpu->acpi_perf_data.state_count; i++) {
> > +		if ((cpu->acpi_perf_data.states[i].core_frequency % 2) == 0) {
> > +			int perf_max_ctl =
> > +				cpu->acpi_perf_data.states[i].control >> 8;
> > +			if (cpu->pstate.max_pstate > perf_max_ctl)
> > +				cpu->pstate.max_pstate = perf_max_ctl;
> > +			break;
> > +		}
> > +	}
> 
> I think you should first verify that ACPI control_register really
> points to MSR_IA32_PERF_CTL before doing that magic with opaque
> control value. Also format of pstate bits in control register is
> cpu-model specific.
> 
Good idea. We should do this, before start of this function and skip the
rest.
> > +
> > +	/* check If min perf > Intel P State min */
> > +	min_perf = cpu->acpi_perf_data.states[
> > +			cpu->acpi_perf_data.state_count - 1].control >> 8;
> > +	if (min_perf > cpu->pstate.min_pstate) {
> > +		cpu->pstate.min_pstate = min_perf;
> > +		policy->cpuinfo.min_freq = cpu->pstate.min_pstate *
> > +						cpu->pstate.scaling;
> > +	}
> > +
> > +	if (turbo_absent)
> > +		policy->cpuinfo.max_freq =
> > +			cpu->pstate.max_pstate * cpu->pstate.scaling;
> > +	else {
> > +		policy->cpuinfo.max_freq =
> > +			cpu->pstate.turbo_pstate * cpu->pstate.scaling;
> > +		/* scale freq to intel pstate turbo scale */
> > +		cpu->acpi_perf_data.states[0].core_frequency =
> > +				cpu->pstate.scaling *
> > +				(cpu->acpi_perf_data.states[0].control >> 8);
> 
> So, you hack _PSS top frequency instead of just ignoring it.
> This should work but max_freq might be still out of sync with
> _PSS[0] frequency
It won't because there is no real processor frequency with +1 MHZ added
to top non turbo _PSS entry. This is just symbolic to say that anything
above the top _PSS is turbo. The magic control value is set the a ratio
in the turbo range.
> : pstate in states[0].control could be lower than
> cpu->pstate.turbo_pstate.
Yes this is possible, then policy setting will force a lower valid turbo
frequency, anyway anything in this range is not guaranteed.
> 
> > +	}
> > +
> > +	pr_debug("Updated limits 0x%x 0x%x 0x %x\n", cpu->pstate.min_pstate,
> > +		 cpu->pstate.max_pstate, cpu->pstate.turbo_pstate);
> > +	pr_debug("policy max_freq=%d Mhz min_freq = %d MHz\n",
> > +		 policy->cpuinfo.max_freq, policy->cpuinfo.min_freq);
> > +
> > +	return 0;
> > +}
> > +
> > +static int intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
> > +{
> > +	struct cpudata *cpu;
> > +
> > +	cpu = all_cpu_data[policy->cpu];
> > +	acpi_processor_unregister_performance(&cpu->acpi_perf_data,
> > +						      policy->cpu);
> > +	return 0;
> > +}
> > +
> > +#else
> > +static int intel_pstate_init_perf_limits(struct cpufreq_policy *policy)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >   static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
> >   			     int deadband, int integral) {
> >   	pid->setpoint = setpoint;
> > @@ -1033,18 +1141,25 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
> >   	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
> >   	policy->cpuinfo.max_freq =
> >   		cpu->pstate.turbo_pstate * cpu->pstate.scaling;
> > +	intel_pstate_init_perf_limits(policy);
> 
> Here you silently ignore possible errors.
> 
Good question. Only possibility is memory alloc error. In that case we
don't care _PSS and let it run as before.
There is a camp still believe that we should not use any ACPI limits in
Intel P state driver, that is why this was never a priority. Intel P
state works well even on platform with broken ACPI config. So if you
have any suggestions on detecting broken config and avoid it will be
great.
> >   	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
> >   	cpumask_set_cpu(policy->cpu, policy->cpus);
> >
> >   	return 0;
> >   }
> >
> > +static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> > +{
> > +	return intel_pstate_exit_perf_limits(policy);
> > +}
> > +
> >   static struct cpufreq_driver intel_pstate_driver = {
> >   	.flags		= CPUFREQ_CONST_LOOPS,
> >   	.verify		= intel_pstate_verify_policy,
> >   	.setpolicy	= intel_pstate_set_policy,
> >   	.get		= intel_pstate_get,
> >   	.init		= intel_pstate_cpu_init,
> > +	.exit		= intel_pstate_cpu_exit,
> >   	.stop_cpu	= intel_pstate_stop_cpu,
> >   	.name		= "intel_pstate",
> >   };
> >
> 
> 


