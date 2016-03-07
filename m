From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V5 2/4] Optimize calculation for max/min_perf_adj
Date: Mon, 07 Mar 2016 13:35:14 -0800
Message-ID: <1457386514.4361.8.camel@linux.intel.com>
References: <1457249646-23072-1-git-send-email-philippe.longepe@linux.intel.com>
	 <1457249646-23072-3-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19221 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753529AbcCGViH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Mar 2016 16:38:07 -0500
In-Reply-To: <1457249646-23072-3-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org
Cc: rafael@kernel.org

On Sun, 2016-03-06 at 08:34 +0100, Philippe Longepe wrote:
> mul_fp(int_tofp(A), B) expands to:
> ((A << FRAC_BITS) * B) >> FRAC_BITS, so the same result can be
> obtained
> via simple multiplication A * B.=C2=A0=C2=A0Apply this observation to
> max_perf * limits->max_perf and max_perf * limits->min_perf in
> intel_pstate_get_min_max()."
>=20
> Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 114e4e0..c46d23a 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -828,11 +828,11 @@ static void intel_pstate_get_min_max(struct
> cpudata *cpu, int *min, int *max)
> =C2=A0	=C2=A0* policy, or by cpu specific default values determined
> through
> =C2=A0	=C2=A0* experimentation.
> =C2=A0	=C2=A0*/
> -	max_perf_adj =3D fp_toint(mul_fp(int_tofp(max_perf), limits-
> >max_perf));
> +	max_perf_adj =3D fp_toint(max_perf * limits->max_perf);
> =C2=A0	*max =3D clamp_t(int, max_perf_adj,
> =C2=A0			cpu->pstate.min_pstate, cpu-
> >pstate.turbo_pstate);
> =C2=A0
> -	min_perf =3D fp_toint(mul_fp(int_tofp(max_perf), limits-
> >min_perf));
> +	min_perf =3D fp_toint(max_perf * limits->min_perf);
> =C2=A0	*min =3D clamp_t(int, min_perf, cpu->pstate.min_pstate,
> max_perf);
> =C2=A0}
> =C2=A0
