From: Jacob Shin <jacob.shin@amd.com>
Subject: Re: [PATCH V3 2/2] cpufreq: AMD "frequency sensitivity feedback"
 powersave bias for ondemand governor
Date: Tue, 2 Apr 2013 15:03:37 -0500
Message-ID: <20130402200337.GA17919@jshin-Toonie>
References: <1364926304-1799-1-git-send-email-jacob.shin@amd.com>
 <1364926304-1799-3-git-send-email-jacob.shin@amd.com>
 <20130402192352.GC17675@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130402192352.GC17675@pd.tnic>
Sender: cpufreq-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Renninger <trenn@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 02, 2013 at 09:23:52PM +0200, Borislav Petkov wrote:
> On Tue, Apr 02, 2013 at 01:11:44PM -0500, Jacob Shin wrote:
> > Future AMD processors, starting with Family 16h, can provide softwa=
re
> > with feedback on how the workload may respond to frequency change -=
-
> > memory-bound workloads will not benefit from higher frequency, wher=
e
> > as compute-bound workloads will. This patch enables this "frequency
> > sensitivity feedback" to aid the ondemand governor to make better
> > frequency change decisions by hooking into the powersave bias.
> >=20
> > Signed-off-by: Jacob Shin <jacob.shin@amd.com>
> > ---
>=20
> [ =E2=80=A6 ]
>=20
> > --- a/drivers/cpufreq/Kconfig.x86
> > +++ b/drivers/cpufreq/Kconfig.x86
> > @@ -129,6 +129,23 @@ config X86_POWERNOW_K8
> > =20
> >  	  For details, take a look at <file:Documentation/cpu-freq/>.
> > =20
> > +config X86_AMD_FREQ_SENSITIVITY
>=20
> /me is turning on his spell checker...

Yikes, sorry about that (*ashamed*), will remeber to run spellcheck=20
next time.

>=20
> > +	tristate "AMD frequency sensitivity feedback powersave bias"
> > +	depends on CPU_FREQ_GOV_ONDEMAND && X86_ACPI_CPUFREQ && CPU_SUP_A=
MD
> > +	help
> > +	  This adds AMD specific powersave bias function to the ondemand
>=20
> 		    AMD-specific
>=20
> > +	  governor; which can be used to help ondemand governor make more=
 power
>=20
> 	  "... governor, which allows it to make more power-conscious freque=
ncy
> 	  change decisions based on ..."
>=20
> > +	  conscious frequency change decisions based on feedback from har=
dware
> > +	  (availble on AMD Family 16h and above).
>=20
> s/availble/available/
>=20
> > +
> > +	  Hardware feedback tells software how "sensitive" to frequency c=
hanges
> > +	  the CPUs' workloads are. CPU-bound workloads will be more sensi=
tive
> > +	  -- they will perform better as frequency increases. Memory/IO-b=
ound
> > +	  workloads will be less sensitive -- they will not necessarily p=
erform
> > +	  better as frequnecy increases.
>=20
> s/frequnecy/frequency/
>=20
> > +
> > +	  If in doubt, say N.
> > +
> >  config X86_GX_SUSPMOD
> >  	tristate "Cyrix MediaGX/NatSemi Geode Suspend Modulation"
> >  	depends on X86_32 && PCI
> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > index 863fd18..01dfdaf 100644
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> > @@ -41,6 +41,7 @@ obj-$(CONFIG_X86_SPEEDSTEP_CENTRINO)	+=3D speedst=
ep-centrino.o
> >  obj-$(CONFIG_X86_P4_CLOCKMOD)		+=3D p4-clockmod.o
> >  obj-$(CONFIG_X86_CPUFREQ_NFORCE2)	+=3D cpufreq-nforce2.o
> >  obj-$(CONFIG_X86_INTEL_PSTATE)		+=3D intel_pstate.o
> > +obj-$(CONFIG_X86_AMD_FREQ_SENSITIVITY)	+=3D amd_freq_sensitivity.o
> > =20
> >  ##################################################################=
################
> >  # ARM SoC drivers
> > diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufr=
eq/amd_freq_sensitivity.c
> > new file mode 100644
> > index 0000000..e3e62d2
> > --- /dev/null
> > +++ b/drivers/cpufreq/amd_freq_sensitivity.c
> > @@ -0,0 +1,150 @@
> > +/*
> > + * amd_freq_sensitivity.c: AMD frequency sensitivity feedback powe=
rsave bias
> > + *                         for the ondemand governor.
> > + *
> > + * Copyright (C) 2013 Advanced Micro Devices, Inc.
> > + *
> > + * Author: Jacob Shin <jacob.shin@amd.com>
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License version 2 =
as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/types.h>
> > +#include <linux/percpu-defs.h>
> > +#include <linux/init.h>
> > +#include <linux/mod_devicetable.h>
> > +
> > +#include <asm/msr.h>
> > +#include <asm/cpufeature.h>
> > +
> > +#include "cpufreq_governor.h"
> > +
> > +#define MSR_AMD64_FREQ_SENSITIVITY_ACTUAL	0xc0010080
> > +#define MSR_AMD64_FREQ_SENSITIVITY_REFERENCE	0xc0010081
> > +#define CLASS_CODE_SHIFT			56
> > +#define CLASS_CODE_CORE_FREQ_SENSITIVITY	0x01
> > +#define POWERSAVE_BIAS_MAX			1000
> > +
> > +struct cpu_data_t {
> > +	u64 actual;
> > +	u64 reference;
> > +	unsigned int freq_prev;
> > +};
> > +
> > +static DEFINE_PER_CPU(struct cpu_data_t, cpu_data);
> > +
> > +static unsigned int amd_powersave_bias_target(struct cpufreq_polic=
y *policy,
> > +					      unsigned int freq_next,
> > +					      unsigned int relation)
> > +{
> > +	int sensitivity;
> > +	long d_actual, d_reference;
> > +	struct msr actual, reference;
> > +	struct cpu_data_t *data =3D &per_cpu(cpu_data, policy->cpu);
> > +	struct dbs_data *od_data =3D policy->governor_data;
> > +	struct od_dbs_tuners *od_tuners =3D od_data->tuners;
> > +	struct od_cpu_dbs_info_s *od_info =3D
> > +		od_data->cdata->get_cpu_dbs_info_s(policy->cpu);
> > +
> > +	if (!od_info->freq_table)
> > +		return freq_next;
> > +
> > +	rdmsr_on_cpu(policy->cpu, MSR_AMD64_FREQ_SENSITIVITY_ACTUAL,
> > +		&actual.l, &actual.h);
> > +	rdmsr_on_cpu(policy->cpu, MSR_AMD64_FREQ_SENSITIVITY_REFERENCE,
> > +		&reference.l, &reference.h);
> > +	actual.h &=3D 0x00ffffff;
> > +	reference.h &=3D 0x00ffffff;
> > +
> > +	/* counter wrapped around, so stay on current frequency */
> > +	if (actual.q < data->actual || reference.q < data->reference) {
> > +		freq_next =3D policy->cur;
> > +		goto out;
> > +	}
> > +
> > +	d_actual =3D actual.q - data->actual;
> > +	d_reference =3D reference.q - data->reference;
> > +
> > +	/* divide by 0, so stay on current frequency as well */
> > +	if (d_reference =3D=3D 0) {
> > +		freq_next =3D policy->cur;
> > +		goto out;
> > +	}
> > +
> > +	sensitivity =3D POWERSAVE_BIAS_MAX -
> > +		(POWERSAVE_BIAS_MAX * (d_reference - d_actual) / d_reference);
> > +
> > +	clamp(sensitivity, 0, POWERSAVE_BIAS_MAX);
> > +
> > +	/* this workload is not CPU bound, so choose a lower freq */
> > +	if (sensitivity < od_tuners->powersave_bias) {
>=20
> Ok, I still didn't get an answer to that: don't we want to use this
> feature by default, even without looking at ->powersave_bias? I mean,
> with feedback from the hardware, we kinda know better than the user, =
no?

Well, so this powersave_bias also works as a tunable knob.

=46rom ondemand side, if /sys/../ondemand/powersave_bias is 0, then we
(AMD sensitivity) don't get called and you get the default ondemand
behavior.

Like existing powersave_bias, users can tune the value to whatever
they want, to get a specturum of less to more aggressive power savings
vs performance.

I thought tunable would be more flexible .. out in the field or what
not .. no?

>=20
> > +		if (data->freq_prev =3D=3D policy->cur)
> > +			freq_next =3D policy->cur;
> > +
> > +		if (freq_next > policy->cur)
> > +			freq_next =3D policy->cur;
> > +		else if (freq_next < policy->cur)
> > +			freq_next =3D policy->min;
> > +		else {
> > +			unsigned int index;
> > +
> > +			cpufreq_frequency_table_target(policy,
> > +				od_info->freq_table, policy->cur - 1,
> > +				CPUFREQ_RELATION_H, &index);
> > +			freq_next =3D od_info->freq_table[index].frequency;
> > +		}
> > +
> > +		data->freq_prev =3D freq_next;
> > +	} else
> > +		data->freq_prev =3D 0;
> > +
> > +out:
> > +	data->actual =3D actual.q;
> > +	data->reference =3D reference.q;
> > +	return freq_next;
> > +}
> > +
> > +static int __init amd_freq_sensitivity_init(void)
> > +{
> > +	int err;
> > +	u64 val;
> > +
> > +	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD)
> > +		return -ENODEV;
> > +
> > +	if (!static_cpu_has(X86_FEATURE_PROC_FEEDBACK))
> > +		return -ENODEV;
> > +
> > +	err =3D rdmsrl_safe(MSR_AMD64_FREQ_SENSITIVITY_ACTUAL, &val);
> > +
>=20
> extraneous newline.
>=20
> > +	if (err)
> > +		return -ENODEV;
> > +
> > +	if ((val >> CLASS_CODE_SHIFT) !=3D CLASS_CODE_CORE_FREQ_SENSITIVI=
TY)
> > +		return -ENODEV;
>=20
> If this CLASS_CODE_CORE_FREQ_SENSITIVITY is always going to be a
> non-null value, you can simplify the check even more, as I proposed
> earlier:
>=20
> 	if (val >> CLASS_CODE_SHIFT)
> 		...
>=20
> and drop CLASS_CODE_CORE_FREQ_SENSITIVITY.
>=20
> Thanks.
>=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
> Sent from a fat crate under my desk. Formatting is fine.
> --
>=20

