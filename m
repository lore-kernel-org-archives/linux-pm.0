From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V5 4/4] intel_pstate: Remove the freq calculation from
 the intel_pstate_calc_busy function
Date: Mon, 07 Mar 2016 13:42:04 -0800
Message-ID: <1457386924.4361.10.camel@linux.intel.com>
References: <1457249646-23072-1-git-send-email-philippe.longepe@linux.intel.com>
	 <1457249646-23072-5-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3100 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752891AbcCGVoj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Mar 2016 16:44:39 -0500
In-Reply-To: <1457249646-23072-5-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org
Cc: rafael@kernel.org

On Sun, 2016-03-06 at 08:34 +0100, Philippe Longepe wrote:
> Use a helper function to compute the average pstate and call it only
> where it is needed (only when tracing or in intel_pstate_get).
>=20
> Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 16 ++++++++--------
> =C2=A01 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 903341f..6e07366 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -878,12 +878,6 @@ static inline void intel_pstate_calc_busy(struct
> cpudata *cpu)
> =C2=A0	core_pct =3D int_tofp(sample->aperf) * int_tofp(100);
> =C2=A0	core_pct =3D div64_u64(core_pct, int_tofp(sample->mperf));
> =C2=A0
> -	sample->freq =3D fp_toint(
> -		mul_fp(int_tofp(
> -			cpu->pstate.max_pstate_physical *
> -			cpu->pstate.scaling / 100),
> -			core_pct));
> -
> =C2=A0	sample->core_pct_busy =3D (int32_t)core_pct;
> =C2=A0}
> =C2=A0
> @@ -917,6 +911,12 @@ static inline void intel_pstate_sample(struct
> cpudata *cpu, u64 time)
> =C2=A0	cpu->prev_tsc =3D tsc;
> =C2=A0}
> =C2=A0
> +static inline int32_t get_avg_frequency(struct cpudata *cpu)
> +{
> +	return div64_u64(cpu->pstate.max_pstate_physical * cpu-
> >sample.aperf *
> +		cpu->pstate.scaling, cpu->sample.mperf);
> +}
> +
> =C2=A0static inline int32_t get_target_pstate_use_cpu_load(struct cpu=
data
> *cpu)
> =C2=A0{
> =C2=A0	struct sample *sample =3D &cpu->sample;
> @@ -1012,7 +1012,7 @@ static inline void
> intel_pstate_adjust_busy_pstate(struct cpudata *cpu)
> =C2=A0		sample->mperf,
> =C2=A0		sample->aperf,
> =C2=A0		sample->tsc,
> -		sample->freq);
> +		get_avg_frequency(cpu));
> =C2=A0}
> =C2=A0
> =C2=A0static void intel_pstate_update_util(struct update_util_data *d=
ata,
> u64 time,
> @@ -1101,7 +1101,7 @@ static unsigned int intel_pstate_get(unsigned
> int cpu_num)
> =C2=A0	if (!cpu)
> =C2=A0		return 0;
> =C2=A0	sample =3D &cpu->sample;
> -	return sample->freq;
> +	return get_avg_frequency(cpu);
> =C2=A0}
> =C2=A0
> =C2=A0static int intel_pstate_set_policy(struct cpufreq_policy *polic=
y)
