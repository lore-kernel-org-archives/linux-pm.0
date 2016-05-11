From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/3] intel_pstate: Clarify average performance
 computation
Date: Tue, 10 May 2016 22:01:09 -0700
Message-ID: <1462942869.4224.25.camel@linux.intel.com>
References: <2638272.Bq3MnQEe4U@vostro.rjw.lan>
	 <CAJZ5v0h3Z9Dr72KdXzCiv-5Yb6kjv-Bpt0weacQ2jO0gU96hEQ@mail.gmail.com>
	 <1462910284.28729.116.camel@linux.intel.com>
	 <1703361.r4IIOaCPTn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1703361.r4IIOaCPTn@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2016-05-10 at 22:57 +0200, Rafael J. Wysocki wrote:
> > > >=20

[...]

> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] intel_pstate: Clarify average performance
> computation
>=20
> The core_pct_busy field of struct sample actually contains the
> average performace during the last sampling period (in percent)
> and not the utilization of the core as suggested by its name
> which is confusing.
>=20
> For this reason, change the name of that field to core_avg_perf
> and rename the function that computes its value accordingly.
>=20
> Also notice that storing this value as percentage requires a costly
> integer multiplication to be carried out in a hot path, so instead
> store it as an "extended fixed point" value with more fraction bits
> and update the code using it accordingly (it is better to change the
> name of the field along with its meaning in one go than to make those
> two changes separately, as that would likely lead to more
> confusion).
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A031 ++++++++++=
+++++---------------
> -
> =C2=A01 file changed, 15 insertions(+), 16 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -49,6 +49,9 @@
> =C2=A0#define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
> =C2=A0#define fp_toint(X) ((X) >> FRAC_BITS)
> =C2=A0
> +#define EXT_BITS 6
> +#define EXT_FRAC_BITS (EXT_BITS + FRAC_BITS)
> +
> =C2=A0static inline int32_t mul_fp(int32_t x, int32_t y)
> =C2=A0{
> =C2=A0	return ((int64_t)x * (int64_t)y) >> FRAC_BITS;
> @@ -72,10 +75,10 @@ static inline int ceiling_fp(int32_t x)
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
> @@ -90,8 +93,8 @@ static inline int ceiling_fp(int32_t x)
> =C2=A0 * data for choosing next P State.
> =C2=A0 */
> =C2=A0struct sample {
> -	int32_t core_pct_busy;
> =C2=A0	int32_t busy_scaled;
> +	u64 core_avg_perf;
> =C2=A0	u64 aperf;
> =C2=A0	u64 mperf;
> =C2=A0	u64 tsc;
> @@ -1147,15 +1150,12 @@ static void intel_pstate_get_cpu_pstates
> =C2=A0	intel_pstate_set_min_pstate(cpu);
> =C2=A0}
> =C2=A0
> -static inline void intel_pstate_calc_busy(struct cpudata *cpu)
> +static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
> =C2=A0{
> =C2=A0	struct sample *sample =3D &cpu->sample;
> -	int64_t core_pct;
> -
> -	core_pct =3D sample->aperf * int_tofp(100);
> -	core_pct =3D div64_u64(core_pct, sample->mperf);
> =C2=A0
> -	sample->core_pct_busy =3D (int32_t)core_pct;
> +	sample->core_avg_perf =3D div64_u64(sample->aperf <<
> EXT_FRAC_BITS,
> +					=C2=A0=C2=A0sample->mperf);
> =C2=A0}
> =C2=A0
> =C2=A0static inline bool intel_pstate_sample(struct cpudata *cpu, u64
> time)
> @@ -1198,9 +1198,8 @@ static inline bool intel_pstate_sample(s
> =C2=A0
> =C2=A0static inline int32_t get_avg_frequency(struct cpudata *cpu)
> =C2=A0{
> -	return fp_toint(mul_fp(cpu->sample.core_pct_busy,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int_tofp(cpu-
> >pstate.max_pstate_physical *
> -						cpu->pstate.scaling
> / 100)));
> +	return (cpu->sample.core_avg_perf * cpu-
> >pstate.max_pstate_physical *
> +			cpu->pstate.scaling) >> EXT_FRAC_BITS;

This breaks frequency display. Needs cast
return ((u64)cpu->sample.core_avg_perf * cpu->
	pstate.max_pstate_physical * cpu->pstate.scaling) >>
EXT_FRAC_BITS;

Otherwise results are very close with the version without this change.

Thanks,
Srinivas
