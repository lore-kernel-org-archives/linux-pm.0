From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V4] intel_pstate: Use avg_pstate instead of
 current_pstate
Date: Thu, 21 Apr 2016 17:59:05 -0700
Message-ID: <1461286745.8946.203.camel@linux.intel.com>
References: <1459754617-8872-1-git-send-email-philippe.longepe@linux.intel.com>
	 <1662176.YWLDtbbot1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15646 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603AbcDVA6l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Apr 2016 20:58:41 -0400
In-Reply-To: <1662176.YWLDtbbot1@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Philippe Longepe <philippe.longepe@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, len.brown@intel.com

On Fri, 2016-04-22 at 02:48 +0200, Rafael J. Wysocki wrote:
> On Monday, April 04, 2016 09:23:36 AM Philippe Longepe wrote:
> >=20
> > The result returned by pid_calc() is subtracted from current_pstate
> > (which is the pstate requested during the last period) in order to
> > obtain the target pstate for the current iteration.
> > However, current_pstate may not reflect the real current P-state of
> > the CPU.=C2=A0=C2=A0In particular, that P-state may be higher becau=
se of the
> > frequency sharing per module.
> >=20
> > The theory is:
> >=20
> > - The load is the percentage of time spent in C0 and is related to
> > the average frequency during the same period (We'll not have the
> > same load at 1GHz or at 2GHz for the same task running).
> >=20
> > - The current frequency can be completely different than the
> > average frequency (because of frequency sharing or throttling).
> >=20
> > =3D> The frequency shift computed by the pid_calc is based on the
> > load, so it must be applied to the frequency with which the load
> > was measured.
> >=20
> > Using the average pstate instead of current pstate solve some
> > migration issues (e.g when a task migrates from one core to another
> > in the same package/module and all of the cores in there except for
> > that particular one are basically idle).
> >=20
> > Performance and power comparison with this patch on Android:
> >=20
> > IPLoad+Avg-Pstate vs IP Load:
> >=20
> > Benchmark=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=E2=88=86Perf=C2=A0=C2=A0=C2=A0=C2=A0=E2=88=
=86Power
> > FishTank=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A010.45%=C2=A0=C2=A0=C2=A0=C2=A03.1%
> > SmartBench-Gaming=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-0.1%=C2=
=A0=C2=A0=C2=A0-10.4%
> > SmartBench-Productivity -0.8%=C2=A0=C2=A0=C2=A0-10.4%
> > CandyCrush=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0n/a=C2=A0=C2=A0=C2=A0-17.4%
> > AngryBirds=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0n/a=C2=A0=C2=A0=C2=A0=C2=A0-5.9%
> > videoPlayback=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0n/a=C2=A0=C2=A0=C2=A0-13.9%
> > audioPlayback=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0n/a=C2=A0=C2=A0=C2=A0=C2=A0-4.9%
> > IcyRocks-20-50=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A00.0%=C2=A0=C2=A0=C2=A0-38.4%
> > iozone RR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-0.16%=C2=A0=C2=A0-1.3%
> > iozone RW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00.74%=C2=A0=C2=A0-1.3%
> >=20
> > Comparison with the perf algorithm:
> > (this patch in cpu_load vs Core algorithm)
> >=20
> > Benchmark=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=E2=88=86Perf=C2=A0=C2=A0=C2=A0=C2=A0=E2=88=
=86Power
> > SmartBench-Gaming=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-0.58%=C2=
=A0=C2=A0=C2=A0-22.8%
> > SmartBench-Productivity=C2=A0=C2=A00.82%
> > CandyCrush=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0n/a=C2=A0=C2=A0=C2=A0=C2=A0-20.8=
%
> > AngryBirds=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0n/a=C2=A0=C2=A0=C2=A0=C2=A0-37.0=
%
> > videoPlayback=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0n/a=C2=A0=C2=A0=C2=A0=C2=A0-53.4%
> > audioPlayback=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0n/a=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-2.1%
> > iozone RR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-0.55%=C2=A0=C2=A0=C2=A0-13.29%
> > iozone RW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02.22%
> >=20
> > =3D> No regression > 1% observed and a huge power improvement!
> >=20
> > Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>


> Srinivas, what about this one?=C2=A0=C2=A0Yes?=C2=A0=C2=A0No?=C2=A0=C2=
=A0Maybe?
>=20
I am fine with this change.
I would like to edit the commit and remove the bottom table compare
with core and statement with exclamation as this not relevant here for
the affected platforms.

Do you want me to send update?


Thanks,
Srinivas

> >=20
> > ---
> > =C2=A0drivers/cpufreq/intel_pstate.c | 8 +++++++-
> > =C2=A01 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 4b64452..b998e1d 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -919,6 +919,12 @@ static inline int32_t get_avg_frequency(struct
> > cpudata *cpu)
> > =C2=A0		cpu->pstate.scaling, cpu->sample.mperf);
> > =C2=A0}
> > =C2=A0
> > +static inline int32_t get_avg_pstate(struct cpudata *cpu)
> > +{
> > +	return div64_u64(cpu->pstate.max_pstate_physical * cpu-
> > >sample.aperf,
> > +		cpu->sample.mperf);
> > +}
> > +
> > =C2=A0static inline int32_t get_target_pstate_use_cpu_load(struct
> > cpudata *cpu)
> > =C2=A0{
> > =C2=A0	struct sample *sample =3D &cpu->sample;
> > @@ -951,7 +957,7 @@ static inline int32_t
> > get_target_pstate_use_cpu_load(struct cpudata *cpu)
> > =C2=A0	cpu_load =3D div64_u64(int_tofp(100) * mperf, sample->tsc);
> > =C2=A0	cpu->sample.busy_scaled =3D cpu_load;
> > =C2=A0
> > -	return cpu->pstate.current_pstate - pid_calc(&cpu->pid,
> > cpu_load);
> > +	return get_avg_pstate(cpu) - pid_calc(&cpu->pid,
> > cpu_load);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static inline int32_t get_target_pstate_use_performance(struc=
t
> > cpudata *cpu)
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
