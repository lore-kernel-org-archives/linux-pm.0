From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Tue, 01 Mar 2016 10:10:41 -0800
Message-ID: <1456855841.21069.59.camel@linux.intel.com>
References: <1456778205-19197-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20160301022830.GX2791@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60894 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbcCASMV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Mar 2016 13:12:21 -0500
In-Reply-To: <20160301022830.GX2791@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org

On Tue, 2016-03-01 at 07:58 +0530, Viresh Kumar wrote:
> On 29-02-16, 12:36, Srinivas Pandruvada wrote:
> > Currently scaling_available_frequencies displays list of available
> > frequencies which can be used to set max/min or current scaling
> > frequency.
> >=20
> > > cat scaling_available_frequencies
> > 2301000 2300000 2200000 2000000 1900000 1800000 1700000 1500000
> > 1400000
> > 1300000 1100000 1000000 900000 800000 600000 500000
> >=20
> > Here traditionally it is assumed that only 2301000 is a turbo
> > frequency,
> > which is purely opportunistic, anything else user can request and
> > may
> > get it.
> > But because of configurable thermal design power implementation in
> > several
> > Intel CPUs, the opportunistic frequency start can be any frequency
> > in this
> > range. For example it can be 2300000 or any lower value.
> > This change adds an optional new attribute called "base_frequency",
> > which displays the max non-turbo frequency (base frequency). For
> > example:
> > > cat base_frequency
> > 2200000
> > This will allow user to choose a certain frequency which is not
> > opportunistic.
> >=20
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > ---
>=20
> You missed adding a version log and V2 in subject :(
>=20
> > =C2=A0drivers/cpufreq/acpi-cpufreq.c | 36
> > ++++++++++++++++++++++++++++++++++++
> > =C2=A01 file changed, 36 insertions(+)
> >=20
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-
> > cpufreq.c
> > index 51eef87..76edd28 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -646,6 +646,21 @@ static int acpi_cpufreq_blacklist(struct
> > cpuinfo_x86 *c)
> > =C2=A0}
> > =C2=A0#endif
> > =C2=A0
> > +static ssize_t show_base_frequency(struct cpufreq_policy *policy,
> > char *buf)
> > +{
> > +	u64 tar;
> > +	int err;
> > +
> > +	err =3D rdmsrl_safe_on_cpu(policy->cpu,
> > MSR_TURBO_ACTIVATION_RATIO, &tar);
> > +	if (!err)
>=20
> So, this will automatically take care of checking if a CPU has
> support
> for it or not, right ?
Yes. It will fail if it doesn't support.
>=20
> > +		/* Refer to IA64, IA32 SDM table 35-20, unit =3D 100
> > MHz */
> > +		return sprintf(buf, "%llu\n", tar * 100000);
> > +
> > +	return err;
> > +}
> > +
> > +cpufreq_freq_attr_ro(base_frequency);
> > +
> > =C2=A0static int acpi_cpufreq_cpu_init(struct cpufreq_policy *polic=
y)
> > =C2=A0{
> > =C2=A0	unsigned int i;
> > @@ -889,6 +904,7 @@ static struct freq_attr *acpi_cpufreq_attr[] =3D
> > {
> > =C2=A0	&cpb,
> > =C2=A0#endif
> > =C2=A0	NULL,
> > +	NULL,
>=20
> Its not straight forward, so please add a comment (like cpufreq-dt),
> that what the first NULL is going to be used for.
>=20
OK.
> > =C2=A0};
> > =C2=A0
> > =C2=A0static struct cpufreq_driver acpi_cpufreq_driver =3D {
> > @@ -971,6 +987,26 @@ static int __init acpi_cpufreq_init(void)
> > =C2=A0			}
> > =C2=A0	}
> > =C2=A0#endif
> > +
> > +	if (boot_cpu_has(X86_FEATURE_IDA)) {
> > +		u64 plat_info, tar;
> > +		int err;
> > +
> > +		err =3D rdmsrl_safe_on_cpu(0, MSR_PLATFORM_INFO,
> > &plat_info);
> > +		/* Check number of config TDP levels > 0 */
> > +		if (!err && ((plat_info >> 33) & 0x03) > 0) {
> > +			err =3D rdmsrl_safe_on_cpu(0,
> > MSR_TURBO_ACTIVATION_RATIO,
> > +						=C2=A0&tar);
> > +			if (!err) {
>=20
> Maybe just:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!rdmsrl_safe_on_c=
pu(0, MSR_TURBO_ACTIVATION_RATIO, &tar))
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
OK
>=20
> > +				struct freq_attr **attr;
> > +
> > +				for (attr =3D acpi_cpufreq_attr;
> > *attr; attr++)
> > +				;
> > +				*attr =3D &base_frequency;
>=20
> What about:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_cpufreq_attr[AR=
RAY_SIZE(acpi_cpu
> freq_attr) - 2] =3D &base_frequency;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0and a comment to des=
cribe that ?
>=20
Will it work in this case?
"
Even if CONFIG_X86_ACPI_CPUFREQ_CPB is defined,=C2=A0
acpi_cpufreq_attr[2] will be set to NULL in the init callback when
some condition fails. So we will have a NULL in the acpi_cpufreq_attr[]
before &base_frequency if we add at fixed place.=C2=A0
"

Thanks,
Srinivas


