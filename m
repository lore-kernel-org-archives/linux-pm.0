From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/3] intel_pstate: Clarify average performance
 computation
Date: Mon, 09 May 2016 18:18:36 -0700
Message-ID: <1462843116.4224.16.camel@linux.intel.com>
References: <2638272.Bq3MnQEe4U@vostro.rjw.lan>
	 <1880504.e9G30eDLBM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38028 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990AbcEJBTI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 May 2016 21:19:08 -0400
In-Reply-To: <1880504.e9G30eDLBM@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 2016-05-07 at 01:44 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> The core_pct_busy field of struct sample actually contains the
> average performace during the last sampling period (in percent)
> and not the utilization of the core as suggested by its name
> which is confusing.
>=20
> For this reason, change the name of that field to core_avg_perf
> and rename the function that computes its value accordingly.
>=20
Makes perfect sense.

> Also notice that it would be more useful if it was a "raw" fraction
> rather than percentage, so change its meaning too and update the
> code using it accordingly (it is better to change the name of
> the field along with its meaning in one go than to make those
> two changes separately, as that would likely lead to more
> confusion).
Due to the calculation the results from old and new method will be
similar but not same. For example in one scenario the
get_avg_frequency=C2=A0difference is 4.3KHz (printed side by side using=
 both
old style using pct and new using fraction)
=46requency with old calc: 2996093 Hz
=46requency with old calc: 3000460 Hz

How much do you think the performance gain changing fraction vs pct?

>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A024 ++++++++++=
--------------
> =C2=A01 file changed, 10 insertions(+), 14 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -72,10 +72,10 @@ static inline int ceiling_fp(int32_t x)
> =C2=A0
> =C2=A0/**
> =C2=A0 * struct sample -	Store performance sample
> - * @core_pct_busy:	Ratio of APERF/MPERF in percent, which is
> actual
> + * @core_avg_perf:	Ratio of APERF/MPERF which is the actual
> average
> =C2=A0 *			performance during last sample period
> =C2=A0 * @busy_scaled:	Scaled busy value which is used to calculate
> next
> - *			P state. This can be different than
> core_pct_busy
> + *			P state. This can be different than
> core_avg_perf
> =C2=A0 *			to account for cpu idle period
> =C2=A0 * @aperf:		Difference of actual performance frequency
> clock count
> =C2=A0 *			read from APERF MSR between last and
> current sample
> @@ -90,7 +90,7 @@ static inline int ceiling_fp(int32_t x)
> =C2=A0 * data for choosing next P State.
> =C2=A0 */
> =C2=A0struct sample {
> -	int32_t core_pct_busy;
> +	int32_t core_avg_perf;
> =C2=A0	int32_t busy_scaled;
> =C2=A0	u64 aperf;
> =C2=A0	u64 mperf;
> @@ -1147,15 +1147,11 @@ static void intel_pstate_get_cpu_pstates
> =C2=A0	intel_pstate_set_min_pstate(cpu);
> =C2=A0}
> =C2=A0
> -static inline void intel_pstate_calc_busy(struct cpudata *cpu)
> +static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
> =C2=A0{
> =C2=A0	struct sample *sample =3D &cpu->sample;
> -	int64_t core_pct;
> =C2=A0
> -	core_pct =3D sample->aperf * int_tofp(100);
> -	core_pct =3D div64_u64(core_pct, sample->mperf);
> -
> -	sample->core_pct_busy =3D (int32_t)core_pct;
> +	sample->core_avg_perf =3D div_fp(sample->aperf, sample-
> >mperf);
> =C2=A0}
> =C2=A0
> =C2=A0static inline bool intel_pstate_sample(struct cpudata *cpu, u64
> time)
> @@ -1198,9 +1194,9 @@ static inline bool intel_pstate_sample(s
> =C2=A0
> =C2=A0static inline int32_t get_avg_frequency(struct cpudata *cpu)
> =C2=A0{
> -	return fp_toint(mul_fp(cpu->sample.core_pct_busy,
> +	return fp_toint(mul_fp(cpu->sample.core_avg_perf,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int_tofp(cpu-
> >pstate.max_pstate_physical *
> -						cpu->pstate.scaling
> / 100)));
> +						cpu-
> >pstate.scaling)));
> =C2=A0}
> =C2=A0
> =C2=A0static inline int32_t get_avg_pstate(struct cpudata *cpu)
> @@ -1260,7 +1256,7 @@ static inline int32_t get_target_pstate_
> =C2=A0	=C2=A0* period. The result will be a percentage of busy at a
> =C2=A0	=C2=A0* specified pstate.
> =C2=A0	=C2=A0*/
> -	core_busy =3D cpu->sample.core_pct_busy;
> +	core_busy =3D 100 * cpu->sample.core_avg_perf;
> =C2=A0	max_pstate =3D cpu->pstate.max_pstate_physical;
> =C2=A0	current_pstate =3D cpu->pstate.current_pstate;
> =C2=A0	core_busy =3D mul_fp(core_busy, div_fp(max_pstate,
> current_pstate));
> @@ -1312,7 +1308,7 @@ static inline void intel_pstate_adjust_b
> =C2=A0	intel_pstate_update_pstate(cpu, target_pstate);
> =C2=A0
> =C2=A0	sample =3D &cpu->sample;
> -	trace_pstate_sample(fp_toint(sample->core_pct_busy),
> +	trace_pstate_sample(fp_toint(100 * sample->core_avg_perf),
> =C2=A0		fp_toint(sample->busy_scaled),
> =C2=A0		from,
> =C2=A0		cpu->pstate.current_pstate,
> @@ -1332,7 +1328,7 @@ static void intel_pstate_update_util(str
> =C2=A0		bool sample_taken =3D intel_pstate_sample(cpu, time);
> =C2=A0
> =C2=A0		if (sample_taken) {
> -			intel_pstate_calc_busy(cpu);
> +			intel_pstate_calc_avg_perf(cpu);
> =C2=A0			if (!hwp_active)
> =C2=A0				intel_pstate_adjust_busy_pstate(cpu)
> ;
> =C2=A0		}
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
