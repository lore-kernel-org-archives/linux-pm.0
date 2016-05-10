From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 3/3] intel_pstate: Clean up
 get_target_pstate_use_performance()
Date: Mon, 09 May 2016 18:24:49 -0700
Message-ID: <1462843489.4224.17.camel@linux.intel.com>
References: <2638272.Bq3MnQEe4U@vostro.rjw.lan>
	 <6021838.4PBIxTzBzu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:32139 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745AbcEJBZV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 May 2016 21:25:21 -0400
In-Reply-To: <6021838.4PBIxTzBzu@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 2016-05-07 at 01:47 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> The way the code in get_target_pstate_use_performance() is arranged
> and the comments in there are totally confusing, so modify them to
> reflect what's going on.
>=20
> The results of the computations should be the same as before.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A032 ++++++++++=
+++-----------------
> --
> =C2=A01 file changed, 13 insertions(+), 19 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -1241,43 +1241,37 @@ static inline int32_t get_target_pstate_
> =C2=A0
> =C2=A0static inline int32_t get_target_pstate_use_performance(struct
> cpudata *cpu)
> =C2=A0{
> -	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
> +	int32_t perf_scaled, sample_ratio;
> =C2=A0	u64 duration_ns;
> =C2=A0
> =C2=A0	/*
> -	=C2=A0* core_busy is the ratio of actual performance to max
> -	=C2=A0* max_pstate is the max non turbo pstate available
> -	=C2=A0* current_pstate was the pstate that was requested during
> -	=C2=A0*=C2=A0	the last sample period.
> -	=C2=A0*
> -	=C2=A0* We normalize core_busy, which was our actual percent
> -	=C2=A0* performance to what we requested during the last sample
> -	=C2=A0* period. The result will be a percentage of busy at a
> -	=C2=A0* specified pstate.
> +	=C2=A0* perf_scaled is the average performance during the last
> sampling
> +	=C2=A0* period (in percent) scaled by the ratio of the P-state
> requested
> +	=C2=A0* last time to the maximum P-state.=C2=A0=C2=A0That measures =
the
> system's
> +	=C2=A0* response to the previous P-state selection.
> =C2=A0	=C2=A0*/
> -	core_busy =3D 100 * cpu->sample.core_avg_perf;
> -	max_pstate =3D cpu->pstate.max_pstate_physical;
> -	current_pstate =3D cpu->pstate.current_pstate;
> -	core_busy =3D mul_fp(core_busy, div_fp(max_pstate,
> current_pstate));
> +	perf_scaled =3D div_fp(cpu->pstate.max_pstate_physical,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpu->pstate.current_pstate);
> +	perf_scaled =3D mul_fp(perf_scaled, 100 * cpu-
> >sample.core_avg_perf);
> =C2=A0
> =C2=A0	/*
> =C2=A0	=C2=A0* Since our utilization update callback will not run unl=
ess
> we are
> =C2=A0	=C2=A0* in C0, check if the actual elapsed time is significant=
ly
> greater (3x)
> =C2=A0	=C2=A0* than our sample interval.=C2=A0=C2=A0If it is, then we=
 were idle
> for a long
> -	=C2=A0* enough period of time to adjust our busyness.
> +	=C2=A0* enough period of time to adjust our performance metric.
> =C2=A0	=C2=A0*/
> =C2=A0	duration_ns =3D cpu->sample.time - cpu->last_sample_time;
> =C2=A0	if ((s64)duration_ns > pid_params.sample_rate_ns * 3) {
> =C2=A0		sample_ratio =3D div_fp(pid_params.sample_rate_ns,
> duration_ns);
> -		core_busy =3D mul_fp(core_busy, sample_ratio);
> +		perf_scaled =3D mul_fp(perf_scaled, sample_ratio);
> =C2=A0	} else {
> =C2=A0		sample_ratio =3D div_fp(100 * cpu->sample.mperf, cpu-
> >sample.tsc);
> =C2=A0		if (sample_ratio < int_tofp(1))
> -			core_busy =3D 0;
> +			perf_scaled =3D 0;
> =C2=A0	}
> =C2=A0
> -	cpu->sample.busy_scaled =3D core_busy;
> -	return cpu->pstate.current_pstate - pid_calc(&cpu->pid,
> core_busy);
> +	cpu->sample.busy_scaled =3D perf_scaled;
> +	return cpu->pstate.current_pstate - pid_calc(&cpu->pid,
> perf_scaled);
> =C2=A0}
> =C2=A0
> =C2=A0static inline void intel_pstate_update_pstate(struct cpudata *c=
pu,
> int pstate)
>=20
