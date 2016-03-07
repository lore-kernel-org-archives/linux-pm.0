From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V5 3/4] Move the intel_pstate_calc_busy into
 get_target_pstate_use_performance
Date: Mon, 07 Mar 2016 13:36:41 -0800
Message-ID: <1457386601.4361.9.camel@linux.intel.com>
References: <1457249646-23072-1-git-send-email-philippe.longepe@linux.intel.com>
	 <1457249646-23072-4-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41231 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260AbcCGVjQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Mar 2016 16:39:16 -0500
In-Reply-To: <1457249646-23072-4-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org
Cc: rafael@kernel.org

On Sun, 2016-03-06 at 08:34 +0100, Philippe Longepe wrote:
> The cpu_load algorithm doesn't need to invoke
> intel_pstate_calc_busy(),
> so move that call from intel_pstate_sample() to
> get_target_pstate_use_performance().
>=20
> Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 5 ++---
> =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index c46d23a..903341f 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -912,8 +912,6 @@ static inline void intel_pstate_sample(struct
> cpudata *cpu, u64 time)
> =C2=A0	cpu->sample.mperf -=3D cpu->prev_mperf;
> =C2=A0	cpu->sample.tsc -=3D cpu->prev_tsc;
> =C2=A0
> -	intel_pstate_calc_busy(cpu);
> -
> =C2=A0	cpu->prev_aperf =3D aperf;
> =C2=A0	cpu->prev_mperf =3D mperf;
> =C2=A0	cpu->prev_tsc =3D tsc;
> @@ -942,7 +940,6 @@ static inline int32_t
> get_target_pstate_use_cpu_load(struct cpudata *cpu)
> =C2=A0	mperf =3D cpu->sample.mperf + delta_iowait_mperf;
> =C2=A0	cpu->prev_cummulative_iowait =3D cummulative_iowait;
> =C2=A0
> -
> =C2=A0	/*
> =C2=A0	=C2=A0* The load can be estimated as the ratio of the mperf
> counter
> =C2=A0	=C2=A0* running at a constant frequency during active periods
> @@ -960,6 +957,8 @@ static inline int32_t
> get_target_pstate_use_performance(struct cpudata *cpu)
> =C2=A0	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
> =C2=A0	u64 duration_ns;
> =C2=A0
> +	intel_pstate_calc_busy(cpu);
> +
> =C2=A0	/*
> =C2=A0	=C2=A0* core_busy is the ratio of actual performance to max
> =C2=A0	=C2=A0* max_pstate is the max non turbo pstate available
