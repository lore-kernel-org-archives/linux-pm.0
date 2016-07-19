From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] intel_pstate: Update cpu_frequency tracepoint every time
Date: Tue, 19 Jul 2016 15:39:18 -0700
Message-ID: <1468967958.2125.2.camel@linux.intel.com>
References: <3678564.0E838ntcHL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44091 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbcGSWjn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Jul 2016 18:39:43 -0400
In-Reply-To: <3678564.0E838ntcHL@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 2016-07-19 at 15:10 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Currently, intel_pstate only updates the cpu_frequency tracepoint
> if the new P-state to set is different from the current one, but
> that causes powertop to report 100% idle on an 100% loaded system
> sometimes.
>=20
> Prevent that from happening by updating the cpu_frequency tracepoint
> every time intel_pstate_update_pstate() is called.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>-

> --
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A012 ++++------=
--
> =C2=A01 file changed, 4 insertions(+), 8 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -1134,17 +1134,12 @@ static void intel_pstate_get_min_max(str
> =C2=A0	*min =3D clamp_t(int, min_perf, cpu->pstate.min_pstate,
> max_perf);
> =C2=A0}
> =C2=A0
> -static inline void intel_pstate_record_pstate(struct cpudata *cpu,
> int pstate)
> -{
> -	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
> -	cpu->pstate.current_pstate =3D pstate;
> -}
> -
> =C2=A0static void intel_pstate_set_min_pstate(struct cpudata *cpu)
> =C2=A0{
> =C2=A0	int pstate =3D cpu->pstate.min_pstate;
> =C2=A0
> -	intel_pstate_record_pstate(cpu, pstate);
> +	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
> +	cpu->pstate.current_pstate =3D pstate;
> =C2=A0	/*
> =C2=A0	=C2=A0* Generally, there is no guarantee that this code will
> always run on
> =C2=A0	=C2=A0* the CPU being updated, so force the register update to
> run on the
> @@ -1304,10 +1299,11 @@ static inline void intel_pstate_update_p
> =C2=A0
> =C2=A0	intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
> =C2=A0	pstate =3D clamp_t(int, pstate, min_perf, max_perf);
> +	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
> =C2=A0	if (pstate =3D=3D cpu->pstate.current_pstate)
> =C2=A0		return;
> =C2=A0
> -	intel_pstate_record_pstate(cpu, pstate);
> +	cpu->pstate.current_pstate =3D pstate;
> =C2=A0	wrmsrl(MSR_IA32_PERF_CTL, pstate_funcs.get_val(cpu,
> pstate));
> =C2=A0}
> =C2=A0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
