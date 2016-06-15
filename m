From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: adjust _PSS[0] freqeuency
Date: Wed, 15 Jun 2016 02:02:16 -0700
Message-ID: <1465981336.4343.3.camel@linux.intel.com>
References: <1465971179-7832-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <2223313.a2PmTKX7X3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43762 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932084AbcFOCD2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jun 2016 22:03:28 -0400
In-Reply-To: <2223313.a2PmTKX7X3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

On Wed, 2016-06-15 at 01:23 +0200, Rafael J. Wysocki wrote:
> On Tuesday, June 14, 2016 11:12:59 PM Srinivas Pandruvada wrote:
> > Intel P State uses max P-State as the max turbo P-State. This max
> > P-State
> > can be limited by ACPI _PSS table entry 0. After
> > 'commit 9522a2ff9cde ("cpufreq: intel_pstate: Enforce _PPC
> > limits")''
> > the _PSS table entry[0] will be used to cap max performance for
> > enterprise and performance server by default.
> >=20
> > Even though this is correct processing, but when the performance
> > results
> > are compared with the version before the above commit, then
> > obviously the
> > results will be worse, if the _PSS table entry 0 is not the max
> > turbo
> > P-State.
> >=20
> > This change will change the _PSS table entry 0 to the max turbo
> > frequency
> > if turbo is enabled in the BIOS. In this way, the performance will
> > be
> > comparable to the version without _PSS/_PPC support.
> >=20
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > ---
> > =C2=A0drivers/cpufreq/intel_pstate.c | 22 ++--------------------
> > =C2=A01 file changed, 2 insertions(+), 20 deletions(-)
>=20
> Nice. :-)
>=20
> I guess I should add a Fixes tag pointing to commit 9522a2ff9cde to
> this?
Yes we can.

Thanks,
Srinivas

>=20
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index ee367e9..fe9dc17 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -372,26 +372,9 @@ static bool
> > intel_pstate_get_ppc_enable_status(void)
> > =C2=A0	return acpi_ppc;
> > =C2=A0}
> > =C2=A0
> > -/*
> > - * The max target pstate ratio is a 8 bit value in both
> > PLATFORM_INFO MSR and
> > - * in TURBO_RATIO_LIMIT MSR, which pstate driver stores in
> > max_pstate and
> > - * max_turbo_pstate fields. The PERF_CTL MSR contains 16 bit value
> > for P state
> > - * ratio, out of it only high 8 bits are used. For example 0x1700
> > is setting
> > - * target ratio 0x17. The _PSS control value stores in a format
> > which can be
> > - * directly written to PERF_CTL MSR. But in intel_pstate driver
> > this shift
> > - * occurs during write to PERF_CTL (E.g. for cores
> > core_set_pstate()).
> > - * This function converts the _PSS control value to intel pstate
> > driver format
> > - * for comparison and assignment.
> > - */
> > -static int convert_to_native_pstate_format(struct cpudata *cpu,
> > int index)
> > -{
> > -	return cpu->acpi_perf_data.states[index].control >> 8;
> > -}
> > -
> > =C2=A0static void intel_pstate_init_acpi_perf_limits(struct
> > cpufreq_policy *policy)
> > =C2=A0{
> > =C2=A0	struct cpudata *cpu;
> > -	int turbo_pss_ctl;
> > =C2=A0	int ret;
> > =C2=A0	int i;
> > =C2=A0
> > @@ -441,11 +424,10 @@ static void
> > intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
> > =C2=A0	=C2=A0* max frequency, which will cause a reduced performanc=
e
> > as
> > =C2=A0	=C2=A0* this driver uses real max turbo frequency as the max
> > =C2=A0	=C2=A0* frequency. So correct this frequency in _PSS table t=
o
> > -	=C2=A0* correct max turbo frequency based on the turbo ratio.
> > +	=C2=A0* correct max turbo frequency based on the turbo state.
> > =C2=A0	=C2=A0* Also need to convert to MHz as _PSS freq is in MHz.
> > =C2=A0	=C2=A0*/
> > -	turbo_pss_ctl =3D convert_to_native_pstate_format(cpu, 0);
> > -	if (turbo_pss_ctl > cpu->pstate.max_pstate)
> > +	if (!limits->turbo_disabled)
> > =C2=A0		cpu->acpi_perf_data.states[0].core_frequency =3D
> > =C2=A0					policy->cpuinfo.max_freq /
> > 1000;
> > =C2=A0	cpu->valid_pss_table =3D true;
> >=20
>=20
> Thanks,
> Rafael
>=20
