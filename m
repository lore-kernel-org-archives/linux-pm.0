From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v3] cpufreq: acpi_cpufreq: base frequency attribute
 support
Date: Wed, 02 Mar 2016 09:32:08 -0800
Message-ID: <1456939928.21069.80.camel@linux.intel.com>
References: <1456870059-21681-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1456870059-21681-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20160302031929.GR16437@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62228 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672AbcCBRdv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Mar 2016 12:33:51 -0500
In-Reply-To: <20160302031929.GR16437@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org

On Wed, 2016-03-02 at 08:49 +0530, Viresh Kumar wrote:
> On 01-03-16, 14:07, Srinivas Pandruvada wrote:
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
>=20
> Add blank line after all paragraphs.
>=20
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > ---
>=20
> Instead of the cover-letter, you could have used this space to add
> all version
> information or things that you don't want to get committed.
Yes. I prefer to do for short version history.

>=20
> > =C2=A0Documentation/cpu-freq/acpi-cpufreq.txt | 27 ++++++++++++++++=
++++
> > =C2=A0drivers/cpufreq/acpi-cpufreq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0| 45
> > +++++++++++++++++++++++++++++++++
> > =C2=A02 files changed, 72 insertions(+)
> > =C2=A0create mode 100644 Documentation/cpu-freq/acpi-cpufreq.txt
> >=20
> > diff --git a/Documentation/cpu-freq/acpi-cpufreq.txt
> > b/Documentation/cpu-freq/acpi-cpufreq.txt
> > new file mode 100644
> > index 0000000..e5600c4
> > --- /dev/null
> > +++ b/Documentation/cpu-freq/acpi-cpufreq.txt
> > @@ -0,0 +1,27 @@
> > +Additional sysfs attributes for acpi-cpufreq
> > +
> > +acpi-cpufreq sysfs has following sysfs attributes in addition to
> > standard
> > +cpufreq attributes:
> > +
> > +base_frequency :		Max non-turbo frequency
> > +				For example:
> > +				scaling_available_frequencies
> > displays list
> > +				of available frequencies.
> > +
> > +				>cat scaling_available_frequencies
>=20
> Maybe s/>/$ / ?
>=20
> > +				2301000 2300000 2200000 2000000
> > 1900000
> > +				1800000 1700000 1500000 1400000
> > 1300000
> > +				1100000 1000000 900000 800000
> > 600000
> > +				500000
> > +
> > +				If the base_frequency attribute is
> > present
> > +				and readable, then any frequency
> > above
> > +				base_frequency is turbo frequency.
> > For example
> > +
> > +				>cat base_frequency
> > +				2200000
> > +
> > +				Then in the above displayed list
> > of
> > +				scaling_available_frequencies,
> > 2300000 and
> > +				2301000 are turbo frequencies.
> > +
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-
> > cpufreq.c
> > index 51eef87..0bdd36d 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -646,6 +646,37 @@ static int acpi_cpufreq_blacklist(struct
> > cpuinfo_x86 *c)
> > =C2=A0}
> > =C2=A0#endif
> > =C2=A0
> > +static int x86_get_turbo_activation_ratio(int cpu, u64 *tar)
> > +{
> > +	u64 plat_info;
> > +	int err;
> > +
> > +	err =3D rdmsrl_safe_on_cpu(cpu, MSR_PLATFORM_INFO,
> > &plat_info);
> > +	/* Check number of config TDP levels > 0 */
> > +	if (!err && ((plat_info >> 33) & 0x03) > 0)
> > +		err =3D rdmsrl_safe_on_cpu(cpu,
> > MSR_TURBO_ACTIVATION_RATIO,
> > +					=C2=A0tar);
> > +	else
> > +		err =3D -EOPNOTSUPP;
> > +
> > +	return err;
> > +}
> > +
> > +static ssize_t show_base_frequency(struct cpufreq_policy *policy,
> > char *buf)
> > +{
> > +	u64 tar;
> > +	int err;
> > +
> > +	err =3D x86_get_turbo_activation_ratio(policy->cpu, &tar);
> > +	if (!err)
> > +		/* Refer to IA64, IA32 SDM table 35-20, unit =3D 100
> > MHz */
> > +		return sprintf(buf, "%llu\n", tar * 100000);
> > +
>=20
> We normally write code like this:
>=20
> ret =3D ...();
> if (ret)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return fail;
>=20
> success-code..
>=20
> > +	return err;
>=20
> And so you can write your code as:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return err;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sprintf(...);
>=20
OK
> > +}
> > +
> > +cpufreq_freq_attr_ro(base_frequency);
> > +
> > =C2=A0static int acpi_cpufreq_cpu_init(struct cpufreq_policy *polic=
y)
> > =C2=A0{
> > =C2=A0	unsigned int i;
> > @@ -888,6 +919,7 @@ static struct freq_attr *acpi_cpufreq_attr[] =3D
> > {
> > =C2=A0#ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
> > =C2=A0	&cpb,
> > =C2=A0#endif
> > +	NULL, /* Extra space for base_frequency attr, if required
> > */
> > =C2=A0	NULL,
> > =C2=A0};
> > =C2=A0
> > @@ -971,6 +1003,19 @@ static int __init acpi_cpufreq_init(void)
> > =C2=A0			}
> > =C2=A0	}
> > =C2=A0#endif
> > +
> > +	if (boot_cpu_has(X86_FEATURE_IDA)) {
> > +		u64 tar;
> > +
> > +		if (!x86_get_turbo_activation_ratio(0, &tar)) {
> > +			struct freq_attr **attr;
> > +
> > +			for (attr =3D acpi_cpufreq_attr; *attr;
> > attr++)
> > +			;
> > +			*attr =3D &base_frequency;
> > +		}
> > +	}
> > +
> > =C2=A0	acpi_cpufreq_boost_init();
> > =C2=A0
> > =C2=A0	ret =3D cpufreq_register_driver(&acpi_cpufreq_driver);
>=20
> Please see if suggestions from the previous thread are acceptable.
I have to change CPB code to do so. This driver has a lot of legacy
code, so cleanup should be separate.

Thanks,
Srinivas

>=20
