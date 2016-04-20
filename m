From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Enforce _PPC limits
Date: Wed, 20 Apr 2016 13:11:36 -0700
Message-ID: <1461183096.8946.169.camel@linux.intel.com>
References: <1459812150-9111-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1586030.5a1IISzElq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35032 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbcDTULM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Apr 2016 16:11:12 -0400
In-Reply-To: <1586030.5a1IISzElq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

On Wed, 2016-04-20 at 03:20 +0200, Rafael J. Wysocki wrote:
> On Monday, April 04, 2016 04:22:30 PM Srinivas Pandruvada wrote:
> >=20
> > Use ACPI _PPC notification to limit max P state driver will
> > request.

[...]

> > +		acpi_ppc
> > +			Enforce ACPI _PPC performance limits.
> I'd call it support_acpi_ppc or similar.
OK.

>=20
> >=20
> > =C2=A0
> > =C2=A0	intremap=3D	[X86-64, Intel-IOMMU]
> > =C2=A0			on	enable Interrupt Remapping
> > (default)
> > diff --git a/drivers/cpufreq/Kconfig.x86
> > b/drivers/cpufreq/Kconfig.x86
> > index c59bdcb..adbd1de 100644
> > --- a/drivers/cpufreq/Kconfig.x86
> > +++ b/drivers/cpufreq/Kconfig.x86
> > @@ -5,6 +5,7 @@
> > =C2=A0config X86_INTEL_PSTATE
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Intel P state=
 control"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on X86
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select ACPI_PROCESSOR if=
 ACPI
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0T=
his driver provides a P state for Intel core
> > processors.
> > =C2=A0	=C2=A0=C2=A0The driver implements an internal governor and w=
ill
> > become
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 8b5a415..b10ea73 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -39,6 +39,10 @@
> > =C2=A0#define ATOM_TURBO_RATIOS	0x66c
> > =C2=A0#define ATOM_TURBO_VIDS		0x66d
> > =C2=A0
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +#include <acpi/processor.h>
> > +#endif
> I'd prefer #ifdef (and below).
>=20
OK.

> >=20
> > +
> > =C2=A0#define FRAC_BITS 8
> > =C2=A0#define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
> > =C2=A0#define fp_toint(X) ((X) >> FRAC_BITS)
> > @@ -190,6 +194,10 @@ struct cpudata {
> > =C2=A0	u64	prev_tsc;
> > =C2=A0	u64	prev_cummulative_iowait;
> > =C2=A0	struct sample sample;
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +	struct acpi_processor_performance acpi_perf_data;
> > +	bool valid_pss_table;
> > +#endif
> > =C2=A0};
> > =C2=A0
> > =C2=A0static struct cpudata **all_cpu_data;
> > @@ -257,7 +265,7 @@ static inline int32_t
> > get_target_pstate_use_cpu_load(struct cpudata *cpu);
> > =C2=A0static struct pstate_adjust_policy pid_params;
> > =C2=A0static struct pstate_funcs pstate_funcs;
> > =C2=A0static int hwp_active;
> > -
> > +static int acpi_ppc;
> Is this needed for !CONFIG_ACPI?
>=20
If I keep this outside then I can avoid !CONFIG_ACPI check at couple of
places.

> >=20
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * struct perf_limits - Store user and policy limits
> > @@ -331,6 +339,117 @@ static struct perf_limits *limits =3D
> > &performance_limits;
> > =C2=A0static struct perf_limits *limits =3D &powersave_limits;
> > =C2=A0#endif
> > =C2=A0
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +/*
> > + * The max target pstate ratio is a 8 bit value in both
> > PLATFORM_INFO MSR and
> > + * in TURBO_RATIO_LIMIT MSR, which pstate driver stores in
> > max_pstate and
> > + * max_turbo_pstate fields. The PERF_CTL MSR contains 16 bit value
> > for P state
> > + * ratio, out of it only high 8 bits are used. For example 0x1700
> > is setting
> > + * target ratio 0x17. The _PSS control value stores in a format
> > which can be
> > + * directly written to PERF_CTL MSR. But in intel_pstate driver
> > this shift
> > + * occurs during write to PERF_CTL (E.g. for cores
> > core_set_pstate()).
> > + * This function converts the _PSS control value to intel pstate
> > driver format
> > + * for comparison and assignment.
> > + */
> > +static int convert_to_native_pstate_format(struct cpudata *cpu,
> > int index)
> > +{
> > +	return cpu->acpi_perf_data.states[index].control >> 8;
> > +}
> > +
> > +static int intel_pstate_init_perf_limits(struct cpufreq_policy
> > *policy)
> > +{
> > +	struct cpudata *cpu;
> > +	int turbo_pss_ctl;
> > +	int ret;
> > +	int i;
> > +
> > +	cpu =3D all_cpu_data[policy->cpu];
> > +
> > +	if (!cpu->acpi_perf_data.shared_cpu_map &&
> > +	=C2=A0=C2=A0=C2=A0=C2=A0zalloc_cpumask_var_node(&cpu-
> > >acpi_perf_data.shared_cpu_map,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0GFP_KERNEL,
> > cpu_to_node(policy->cpu))) {
> > +		return -ENOMEM;
> > +	}
> Why exactly is the thing above needed?
>=20
Just for safety. shared_cpu_map element is used during evaluating _PSD.
But this evaluation happens
during=C2=A0=C2=A0acpi_processor_preregister_performance. But someone m=
oves this
processing then we will be impacted.
I can remove this.

> >=20
> > +
> > +	ret =3D acpi_processor_register_performance(&cpu-
> > >acpi_perf_data,
> > +						=C2=A0=C2=A0policy->cpu);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	=C2=A0* Check if the control value in _PSS is for PERF_CTL MSR,
> > which should
> > +	=C2=A0* guarantee that the states returned by it map to the
> > states in our
> > +	=C2=A0* list directly.
> > +	=C2=A0*/
> > +	if (cpu->acpi_perf_data.control_register.space_id !=3D
> > +						ACPI_ADR_SPACE_FIX
> > ED_HARDWARE)
> > +		goto unreg_perf;
> > +
> > +	/*
> > +	=C2=A0* If there is only one entry _PSS, simply ignore _PSS and
> > continue as
> > +	=C2=A0* usual without taking _PSS into account
> > +	=C2=A0*/
> > +	if (cpu->acpi_perf_data.state_count < 2)
> > +		goto unreg_perf;
> I'd call the label err or similar.
>=20
OK

> >=20
> > +
> > +	pr_debug("intel_pstate: CPU%u - ACPI _PSS perf data\n",
> > policy->cpu);
> Don't we have a pr_fmt() there now?
>=20
Yes. I need to rebase and send update for this.

> >=20
> > +	for (i =3D 0; i < cpu->acpi_perf_data.state_count; i++) {
> > +		pr_debug("=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0%cP%d: %u MHz, %u mW, 0x=
%x\n",
> > +			=C2=A0(i =3D=3D cpu->acpi_perf_data.state ? '*' : '
> > '), i,
> > +			=C2=A0(u32) cpu-
> > >acpi_perf_data.states[i].core_frequency,
> > +			=C2=A0(u32) cpu-
> > >acpi_perf_data.states[i].power,
> > +			=C2=A0(u32) cpu-
> > >acpi_perf_data.states[i].control);
> > +	}
> > +
> > +	/*
> > +	=C2=A0* The _PSS table doesn't contain whole turbo frequency
> > range.
> > +	=C2=A0* This just contains +1 MHZ above the max non turbo
> > frequency,
> > +	=C2=A0* with control value corresponding to max turbo ratio.
> > But
> > +	=C2=A0* when cpufreq set policy is called, it will call with
> > this
> > +	=C2=A0* max frequency, which will cause a reduced performance
> > as
> > +	=C2=A0* this driver uses real max turbo frequency as the max
> > +	=C2=A0* frequeny. So correct this frequency in _PSS table to
> frequency
>=20
> >=20
> > +	=C2=A0* correct max turbo frequency based on the turbo ratio.
> > +	=C2=A0* Also need to convert to MHz as _PSS freq is in MHz.
> > +	=C2=A0*/
> > +	turbo_pss_ctl =3D convert_to_native_pstate_format(cpu, 0);
> > +	if (turbo_pss_ctl > cpu->pstate.max_pstate)
> > +		cpu->acpi_perf_data.states[0].core_frequency =3D
> > +					policy->cpuinfo.max_freq /
> > 1000;
> > +	cpu->valid_pss_table =3D true;
> > +	pr_info("intel_pstate: _PPC limits will be enforced\n");
> > +
> > +	return 0;
> > +unreg_perf:
> > +	cpu->valid_pss_table =3D false;
> > +	acpi_processor_unregister_performance(policy->cpu);
> > +	return -EINVAL;
> > +}
> > +
> > +static int intel_pstate_exit_perf_limits(struct cpufreq_policy
> > *policy)
> > +{
> > +	struct cpudata *cpu;
> > +
> > +	cpu =3D all_cpu_data[policy->cpu];
> > +	if (!acpi_ppc || !cpu->valid_pss_table)
> > +		return 0;
> It should not be necessary to check acpi_ppc here as cpu-
> >valid_pss_table
> should never be set if acpi_ppc is unset.
>=20
Yes.

> >=20
> > +
> > +	acpi_processor_unregister_performance(policy->cpu);
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
> > =C2=A0static inline void pid_reset(struct _pid *pid, int setpoint, =
int
> > busy,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int deadband, int integral) =
{
> > =C2=A0	pid->setpoint =3D int_tofp(setpoint);
> > @@ -1297,6 +1416,30 @@ static int intel_pstate_set_policy(struct
> > cpufreq_policy *policy)
> > =C2=A0
> > =C2=A0	intel_pstate_clear_update_util_hook(policy->cpu);
> > =C2=A0
> > +	if (acpi_ppc) {
> > +		struct cpudata *cpu;
> > +
> > +		/*
> > +		=C2=A0* If the platform has config TDP feature, then to
> > indicate
> > +		=C2=A0* start of turbo range _PPC is set to one more
> > than the turbo
> > +		=C2=A0* activation ratio, which is cpu-
> > >pstate.max_pstate. Here the
> > +		=C2=A0* updated frequency corresponding to _PPC is
> > reflected in
> > +		=C2=A0* policy->max. This=C2=A0=C2=A0means that this _PPC settin=
g
> > still
> But ->set_policy may be called on updates of policy->max from sysfs
> which
> then may not reflect the _PPC value if I'm not mistaken, may it not?
>=20
Yes, it will be called from sysfs path also. But if user sets a
frequency above max non turbo, then it will be in turbo range anyway.
But, I should add a check to support only for config tdp platforms
here.

If the _PPC limits sets above user set limits
then=C2=A0cpufreq_verify_within_limits should pick the lower value.

> >=20
> > +		=C2=A0* allowing system to reach policy-
> > >cpuinfo.max_freq anyway as
> > +		=C2=A0* this is turbo range.
> > +		=C2=A0* In this case showing restricted limits in
> > intel_pstate
> > +		=C2=A0* sysfs or setting limits->max_perf to a lower
> > value has
> > +		=C2=A0* no meaning.
> > +		=C2=A0*/
> > +		cpu =3D all_cpu_data[0];
> > +		if (policy->max < policy->cpuinfo.max_freq &&
> > +		=C2=A0=C2=A0=C2=A0=C2=A0policy->max > (cpu->pstate.max_pstate *
> > +					cpu->pstate.scaling)) {
> > +			pr_info("intel_pstate: _PPC > Max non
> > Turbo P_state\n");
> > +			policy->max =3D policy->cpuinfo.max_freq;
> > +		}
> > +	}
> > +
> > =C2=A0	if (policy->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE) {
> > =C2=A0		limits =3D &performance_limits;
> > =C2=A0		if (policy->max >=3D policy->cpuinfo.max_freq) {
> > @@ -1392,18 +1535,30 @@ static int intel_pstate_cpu_init(struct
> > cpufreq_policy *policy)
> > =C2=A0	policy->cpuinfo.min_freq =3D cpu->pstate.min_pstate * cpu-
> > >pstate.scaling;
> > =C2=A0	policy->cpuinfo.max_freq =3D
> > =C2=A0		cpu->pstate.turbo_pstate * cpu->pstate.scaling;
> > +	if (acpi_ppc)
> > +		intel_pstate_init_perf_limits(policy);
> Why don't you check acpi_ppc in intel_pstate_init_perf_limits()?
OK

> >=20
> > +	/*
> > +	=C2=A0* If there is no acpi perf data or error, we ignore and
> > use Intel P
> > +	=C2=A0* state calculated limits, So this is not fatal error.
> > +	=C2=A0*/
> > =C2=A0	policy->cpuinfo.transition_latency =3D CPUFREQ_ETERNAL;
> > =C2=A0	cpumask_set_cpu(policy->cpu, policy->cpus);
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
> > +{
> > +	return intel_pstate_exit_perf_limits(policy);
> > +}
> > +
> > =C2=A0static struct cpufreq_driver intel_pstate_driver =3D {
> > =C2=A0	.flags		=3D CPUFREQ_CONST_LOOPS,
> > =C2=A0	.verify		=3D intel_pstate_verify_policy,
> > =C2=A0	.setpolicy	=3D intel_pstate_set_policy,
> > =C2=A0	.get		=3D intel_pstate_get,
> > =C2=A0	.init		=3D intel_pstate_cpu_init,
> > +	.exit		=3D intel_pstate_cpu_exit,
> > =C2=A0	.stop_cpu	=3D intel_pstate_stop_cpu,
> > =C2=A0	.name		=3D "intel_pstate",
> > =C2=A0};
> > @@ -1448,7 +1603,6 @@ static void copy_cpu_funcs(struct
> > pstate_funcs *funcs)
> > =C2=A0}
> > =C2=A0
> > =C2=A0#if IS_ENABLED(CONFIG_ACPI)
> > -#include <acpi/processor.h>
> > =C2=A0
> > =C2=A0static bool intel_pstate_no_acpi_pss(void)
> > =C2=A0{
> > @@ -1654,6 +1808,9 @@ static int __init intel_pstate_setup(char
> > *str)
> > =C2=A0		force_load =3D 1;
> > =C2=A0	if (!strcmp(str, "hwp_only"))
> > =C2=A0		hwp_only =3D 1;
> > +	if (!strcmp(str, "acpi_ppc"))
> > +		acpi_ppc =3D 1;
> > +
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0early_param("intel_pstate", intel_pstate_setup);
> >=20
I will submit version 2 of the patch soon.

Thanks,
Srinivas

> Thanks,
> Rafael
>=20
