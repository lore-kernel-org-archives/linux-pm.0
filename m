Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB653A1D02;
	Fri, 31 Jul 2026 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518407; cv=none; b=ImEQkHRPkK0bEIqzXHoW9cnJkQFOupl4ahebZIBcw3BHTQ9MHQB9V1L6rRPazaoH1Q73VhoPcC1ittH6E8orJRABGdEMPR5PC8pbPjCg12JwVEd3s8kiTDjoM+cyKcTbLhHX6sKwchUEBK4t0xkR0Fh5DThJn5dV1a2kiJvmrwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518407; c=relaxed/simple;
	bh=F+n6sOCWq60vneMEByC53EOL69hJhL6t6zWYN0SOpJk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qRxSMxpyB2Lzv2sdckL9EiHlTFkFuYI5IQFxiDmUGjQDEzvmX/yWyUWXeVYZAX53ArySD3/SU8isb3ghu0nmc3KgUMeo8W3q18G5TlEFmAJs1MpKoLz3fQNnrRtn8bazLVgPO6uy1FV+sLBJivWsupg0dMYaBXwyt75BcZ1e56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KoP7Z8bi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KoP7Z8bi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785518405; x=1817054405;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=F+n6sOCWq60vneMEByC53EOL69hJhL6t6zWYN0SOpJk=;
  b=KoP7Z8bi425j6W7Nysft3+741b2WFlU8XpNfiAITTL79VEwtfcvcyGxP
   OTVW3C+Xvp66q4UpksPecqHXc/P3UOS1WmCqnap7Y2ec8zoo7pU9g87rk
   WXLgv2o+YXTh1vQ4hTYYgFrHNxnFtj/nySgkp7fyt4e3KqHFatYcV+e51
   7kY3yGz/w6AmB9ghOzKstEfOBNXNktnSgjaIap9NQPSdfAF2sm+9XiwVJ
   FbbRrbseQn8j2/sCLEYkqiWg9rvGo5kxVmnikWY586zz/gjp4TjtcZ7As
   iPh6i4hdfUf+vP5krCNFvyl4S4POsYVaIwq9NkCjCaS2QC8wb0e0x4w75
   g==;
X-CSE-ConnectionGUID: iSiqmW91T5GnlN0o1ygrmA==
X-CSE-MsgGUID: hOIiQjxoRyy/7H1eI8FhrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="86227915"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="86227915"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 10:20:05 -0700
X-CSE-ConnectionGUID: aNmzq6HcRAG1Q/BYk9h5Sw==
X-CSE-MsgGUID: /j5oSfbRT2mj+dACj0GJPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="298859871"
Received: from unknown (HELO [143.181.48.226]) ([143.181.48.226])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 10:20:04 -0700
Message-ID: <306864970e3cbb3650617427aa83eb8277175377.camel@linux.intel.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Adjust policy->cur in active
 mode to policy
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Jing Wu <realwujing@gmail.com>,
 	linux-pm@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Doug Smythies
 <dsmythies@telus.net>,  "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org
Date: Fri, 31 Jul 2026 10:20:03 -0700
In-Reply-To: <5144014.31r3eYUQgx@rafael.j.wysocki>
References: 
	<20260729-bug-intel-pstate-policy-cur-v1-1-51f61e5cbd74@gmail.com>
	 <5144014.31r3eYUQgx@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-29 at 20:40 +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 29, 2026 10:59:24 AM CEST Jing Wu wrote:
> > When cpu->policy is CPUFREQ_POLICY_PERFORMANCE,
> > intel_pstate_set_policy()
> > pins the CPU to a fixed pstate (max(min_pstate, max_perf_ratio))
> > and
> > programs it directly, precisely because, per the existing comment,
> > "NOHZ_FULL CPUs need this as the governor callback may not be
> > invoked
> > on them". Two lines later it still unconditionally clobbers policy-
> > >cur
> > down to policy->min, discarding the pinned value it just computed
> > and
> > applied.
> >=20
> > arch_freq_get_on_cpu() falls back to cpufreq_quick_get(), i.e.
> > policy->cur, whenever its APERF/MPERF sample goes stale. A CPU
> > whose
> > tick keeps running refreshes that sample constantly and rarely hits
> > the fallback, but an isolated CPU covered by nohz_full with a
> > single
> > runnable task never gets another tick, so it permanently reports
> > the
> > floor through this fallback - even though it is genuinely pinned
> > to,
> > and running at, the frequency computed just above.
> >=20
> > Set policy->cur to the exact pinned frequency (pstate * scaling) in
> > the CPUFREQ_POLICY_PERFORMANCE branch instead, and only fall back
> > to
> > policy->min for the general case, where the frequency genuinely
> > isn't
> > known without a fresh sample.
> >=20
> > Fixes: d51847acb018 ("cpufreq: intel_pstate: set stale CPU
> > frequency to minimum")
> > Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> > Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> > Signed-off-by: Jing Wu <realwujing@gmail.com>
> > ---
> > =C2=A0drivers/cpufreq/intel_pstate.c | 20 +++++++++++++++-----
> > =C2=A01 file changed, 15 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 5a0eeb84d3821..b2c60c4931dcd 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2908,8 +2908,23 @@ static int intel_pstate_set_policy(struct
> > cpufreq_policy *policy)
> > =C2=A0		 */
> > =C2=A0		intel_pstate_clear_update_util_hook(policy->cpu);
> > =C2=A0		intel_pstate_set_pstate(cpu, pstate);
> > +
> > +		/*
> > +		 * Report the exact pinned frequency instead of
> > the floor:
> > +		 * the CPU is pinned to pstate here and nothing
> > else changes
> > +		 * it, unlike the general case below.
> > +		 */
> > +		policy->cur =3D pstate * cpu->pstate.scaling;
> > =C2=A0	} else {
> > =C2=A0		intel_pstate_set_update_util_hook(policy->cpu);
> > +
> > +		/*
> > +		 * Keep policy->cur within limits here: outside of
> > the pinned
> > +		 * CPUFREQ_POLICY_PERFORMANCE case above, it is
> > never updated
> > +		 * by the intel_pstate driver, but it is used as a
> > stale
> > +		 * frequency value.
> > +		 */
> > +		policy->cur =3D policy->min;
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	if (hwp_active) {
> > @@ -2922,11 +2937,6 @@ static int intel_pstate_set_policy(struct
> > cpufreq_policy *policy)
> > =C2=A0			intel_pstate_clear_update_util_hook(policy
> > ->cpu);
> > =C2=A0		intel_pstate_hwp_set(policy->cpu);
> > =C2=A0	}
> > -	/*
> > -	 * policy->cur is never updated with the intel_pstate
> > driver, but it
> > -	 * is used as a stale frequency value. So, keep it within
> > limits.
> > -	 */
> > -	policy->cur =3D policy->min;
> > =C2=A0
> > =C2=A0	mutex_unlock(&intel_pstate_limits_lock);
> > =C2=A0
> >=20
> > ---
>=20
> Good idea overall, but it takes a bit more to do this.=C2=A0 In
> particular, the HWP
> case needs some more care.
>=20
> Also, I don't think that this really is a fix.=C2=A0 The code works as
> intended,
> although what it does is sometimes confusing.
>=20
> Below is my version of this change (on top of linux-next), please let
> me know
> if it works for you.
>=20
> Thanks!
>=20
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1] cpufreq: intel_pstate: Adjust policy->cur in
> active mode to policy
>=20
> Since arch_freq_get_on_cpu() on x86 falls back to
> cpufreq_quick_get(),
> which effectively causes policy->cur to be returned when intel_pstate
> is used, adjust intel_pstate_set_policy() to set policy->cur to
> reflect
> the P-state that is actually going to be requested in the
> "performance"
> policy case instead of setting it to policy->min (which is confusing
> because it causes scaling_cur_freq to show the minimum frequency
> while
> the CPU is likely running at the maximum one).
>=20
> For this purpose, rearrange intel_pstate_set_policy() to handle the
> HWP
> case separately, to avoid calling intel_pstate_set_pstate()
> pointlessly
> with HWP enabled, and use the observation that with HWP enabled in
> the
> active mode, the utilization update hook is only needed when HWP
> boost
> is used and the policy is not "performance".
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0 38 +++++++++++++++++++=
++++-------
> --------
> =C2=A01 file changed, 23 insertions(+), 15 deletions(-)
>=20
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2870,6 +2870,7 @@ static void intel_pstate_set_pstate(stru
> =C2=A0
> =C2=A0static int intel_pstate_set_policy(struct cpufreq_policy *policy)
> =C2=A0{
> +	unsigned int freq =3D policy->min;
> =C2=A0	struct cpudata *cpu;
> =C2=A0
> =C2=A0	if (!policy->cpuinfo.max_freq)
> @@ -2885,7 +2886,23 @@ static int intel_pstate_set_policy(struc
> =C2=A0
> =C2=A0	intel_pstate_update_perf_limits(cpu, policy->min, policy-
> >max);
> =C2=A0
> -	if (cpu->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE) {
> +	if (hwp_active) {
> +		/*
> +		 * The active mode only requires an update util hook
> if HWP
> +		 * boost is used and the policy is not
> "performance".
> +		 */
> +		if (hwp_boost && cpu->policy !=3D
> CPUFREQ_POLICY_PERFORMANCE) {
> +			intel_pstate_set_update_util_hook(policy-
> >cpu);
> +		} else {
> +			intel_pstate_clear_update_util_hook(policy-
> >cpu);
> +			if (cpu->policy =3D=3D
> CPUFREQ_POLICY_PERFORMANCE) {
> +				freq =3D cpu->max_perf_ratio * cpu-
> >pstate.scaling;
> +				if (cpu->pstate.scaling !=3D cpu-
> >pstate.perf_ctl_scaling)
> +					freq =3D rounddown(freq, cpu-
> >pstate.perf_ctl_scaling);
> +			}
> +		}
> +		intel_pstate_hwp_set(policy->cpu);
> +	} else if (cpu->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE) {
> =C2=A0		int pstate =3D max(cpu->pstate.min_pstate, cpu-
> >max_perf_ratio);
> =C2=A0
> =C2=A0		/*
> @@ -2894,25 +2910,17 @@ static int intel_pstate_set_policy(struc
> =C2=A0		 */
> =C2=A0		intel_pstate_clear_update_util_hook(policy->cpu);
> =C2=A0		intel_pstate_set_pstate(cpu, pstate);
> +		freq =3D pstate * cpu->pstate.scaling;
> =C2=A0	} else {
> =C2=A0		intel_pstate_set_update_util_hook(policy->cpu);
> =C2=A0	}
> -
> -	if (hwp_active) {
> -		/*
> -		 * When hwp_boost was active before and dynamically
> it
> -		 * was turned off, in that case we need to clear the
> -		 * update util hook.
> -		 */
> -		if (!hwp_boost)
> -			intel_pstate_clear_update_util_hook(policy-
> >cpu);
> -		intel_pstate_hwp_set(policy->cpu);
> -	}
> =C2=A0	/*
> -	 * policy->cur is never updated with the intel_pstate
> driver, but it
> -	 * is used as a stale frequency value. So, keep it within
> limits.
> +	 * policy->cur is never updated in the intel_pstate driver,
> but it is
> +	 * used as a stale frequency value, so set it to reflect the
> actual
> +	 * requested P-state in the "performance" policy case and to
> the min
> +	 * otherwise.
> =C2=A0	 */
> -	policy->cur =3D policy->min;
> +	policy->cur =3D freq;
> =C2=A0
> =C2=A0	mutex_unlock(&intel_pstate_limits_lock);
> =C2=A0
>=20
>=20
>=20
