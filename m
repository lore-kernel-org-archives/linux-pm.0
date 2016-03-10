From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] intel_pstate: Do not skip samples partially
Date: Thu, 10 Mar 2016 14:53:46 -0800
Message-ID: <1457650426.19209.16.camel@linux.intel.com>
References: <1608361.vYXCevKAEf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:44111 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932089AbcCJWzY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Mar 2016 17:55:24 -0500
In-Reply-To: <1608361.vYXCevKAEf@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Philippe Longepe <philippe.longepe@linux.intel.com>

On Thu, 2016-03-10 at 23:45 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> If the current value of MPERF or the current value of TSC is the
> same as the previous one, respectively, intel_pstate_sample() bails
> out early and skips the sample.
>=20
> However, intel_pstate_adjust_busy_pstate() is still called in that
> case which is not correct, so modify intel_pstate_sample() to
> return a bool value indicating whether or not the sample has been
> taken and use it to decide whether or not to call
> intel_pstate_adjust_busy_pstate().
>=20
> While at it, remove redundant parentheses from the MPERF/TSC
> check in intel_pstate_sample().
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>=20
> On top of my linux-next branch.
>=20
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A012 +++++++---=
--
> =C2=A01 file changed, 7 insertions(+), 5 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -890,7 +890,7 @@ static inline void intel_pstate_calc_bus
> =C2=A0	sample->core_pct_busy =3D (int32_t)core_pct;
> =C2=A0}
> =C2=A0
> -static inline void intel_pstate_sample(struct cpudata *cpu, u64
> time)
> +static inline bool intel_pstate_sample(struct cpudata *cpu, u64
> time)
> =C2=A0{
> =C2=A0	u64 aperf, mperf;
> =C2=A0	unsigned long flags;
> @@ -900,9 +900,9 @@ static inline void intel_pstate_sample(s
> =C2=A0	rdmsrl(MSR_IA32_APERF, aperf);
> =C2=A0	rdmsrl(MSR_IA32_MPERF, mperf);
> =C2=A0	tsc =3D rdtsc();
> -	if ((cpu->prev_mperf =3D=3D mperf) || (cpu->prev_tsc =3D=3D tsc)) {
> +	if (cpu->prev_mperf =3D=3D mperf || cpu->prev_tsc =3D=3D tsc) {
> =C2=A0		local_irq_restore(flags);
> -		return;
> +		return false;
> =C2=A0	}
> =C2=A0	local_irq_restore(flags);
> =C2=A0
> @@ -920,6 +920,7 @@ static inline void intel_pstate_sample(s
> =C2=A0	cpu->prev_aperf =3D aperf;
> =C2=A0	cpu->prev_mperf =3D mperf;
> =C2=A0	cpu->prev_tsc =3D tsc;
> +	return true;
> =C2=A0}
> =C2=A0
> =C2=A0static inline int32_t get_target_pstate_use_cpu_load(struct cpu=
data
> *cpu)
> @@ -1026,8 +1027,9 @@ static void intel_pstate_update_util(str
> =C2=A0	u64 delta_ns =3D time - cpu->sample.time;
> =C2=A0
> =C2=A0	if ((s64)delta_ns >=3D pid_params.sample_rate_ns) {
> -		intel_pstate_sample(cpu, time);
> -		if (!hwp_active)
> +		bool sample_taken =3D intel_pstate_sample(cpu, time);
> +
> +		if (sample_taken && !hwp_active)
> =C2=A0			intel_pstate_adjust_busy_pstate(cpu);
> =C2=A0	}
> =C2=A0}
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
