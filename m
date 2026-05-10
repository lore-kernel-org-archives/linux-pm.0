Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEC537B019
	for <linux-pm@vger.kernel.org>; Sun, 10 May 2026 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778423673; cv=none; b=EIW64FfYTL4R5QoXpVhTHyrWQU0EaPp+SYzaclosY/dwtop1FWxqXHjg8T8pbbZA62W+ycM/J7h76KVpqEtssawDIMwsniFxl5KUGXJ3xx1jC76kalSytrfWpjnkz1J6SupC+Ct6bzR862tteTOlijzaw7NHFVxNQ35fXXdzV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778423673; c=relaxed/simple;
	bh=akX6oc/UBhFIsH6/xvzRFQmuOSqP2wkx384H9qJdowY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wy9gy8jtCAVap0aR7X/NtF1MWBjTDoI02v0igeec+omUf0hLfI9vglWsSx4TO5ecUy9fVvw5id5oX0bHMK5gHYyB/kJtN8r9qxNCripbMaE78+/qvMwToTmNEHFQP5DIRGSvpVfDVdWRnwzqQE8Rxd1/+wSvSIhA4zIRi+yS9Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqaMcN/o; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqaMcN/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778423671; x=1809959671;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=akX6oc/UBhFIsH6/xvzRFQmuOSqP2wkx384H9qJdowY=;
  b=JqaMcN/o5WiYdBqaTgZyvzjJDjG6dnsB/vTOZOvjolK05dDfbfB2dNbi
   gk6Qhdvy5WRztDcoCm3388emFLB4QZMYEDIkQ3ioDpZtmdZXRBhB9Zkk2
   jj9PrJIegK/oK8W1HB5Vk6hjyMI0A3WWvyjTJrkdvDQL3dEmsyR3rFkMi
   Wl9uxwX81KQMGSYaFtuQh39aZq/RRJatKyuJoxiksyFzrzfw3OzWMVgHI
   AORXlupWbcMw1sXvzK7AQt1jxbyOK9m0MxTjJoy88eNl+4Lx/DBiWINdO
   Bm46Z/gl5yDhfZmdg5tg32aylG8hJ6iQq7af0ydSAcy/ic2O0dwgKF1JP
   Q==;
X-CSE-ConnectionGUID: 5AI/EDMfSNWXCDLwKTqx/g==
X-CSE-MsgGUID: Y/ztSaY1T+WQiaidjXuS4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="83177756"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="83177756"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 07:34:30 -0700
X-CSE-ConnectionGUID: G4OMi87qT0ioDv7aR1fFQg==
X-CSE-MsgGUID: WjKR2javQPWGKwsd53Cg8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="236376949"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.125.111.113]) ([10.125.111.113])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 07:34:30 -0700
Message-ID: <3bc634d8d8566f188909fca9e176f651f6295dfb.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] cpufreq: intel_pstate: Fix scaling for
 hybrid-capable CPUs not reporting hybrid
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Henry Tseng <henrytseng@qnap.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Len Brown <lenb@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, SW Chen <swchen@qnap.com>, Kevin Ko
	 <kevinko@qnap.com>
Date: Sun, 10 May 2026 07:34:28 -0700
In-Reply-To: <20260508063032.3248602-2-henrytseng@qnap.com>
References: <20260508063032.3248602-1-henrytseng@qnap.com>
	 <20260508063032.3248602-2-henrytseng@qnap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-08 at 14:30 +0800, Henry Tseng wrote:
> Commit 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get scaling
> factors") restructured hwp_get_cpu_scaling() so that, when the CPU
> model is registered in intel_hybrid_scaling_factor[] and
> hybrid_get_cpu_type() does not return INTEL_CPU_TYPE_CORE, the
> function early-returns core_get_scaling() (100000) instead of
> falling through to intel_pstate_cppc_get_scaling().
>=20
> This regresses the behavior previously addressed by
> commit 0fcfc9e51990 ("cpufreq: intel_pstate: Fix scaling for
> hybrid-capable systems with disabled E-cores").=C2=A0 On hybrid-capable
> processors not reporting X86_FEATURE_HYBRID_CPU (no E-cores
> enumerated), hybrid_get_cpu_type() returns 0.=C2=A0 Before 9b18d536b124,
> such CPUs fell through to intel_pstate_cppc_get_scaling(), which
> returned the registered hybrid_scaling_factor.=C2=A0 After 9b18d536b124,
> for models registered in the table the early return takes
> core_get_scaling() before reaching that fallback, so the registered
> factor is not used.
>=20
> Fix this by returning hybrid_scaling_factor directly for CPU models
> registered in intel_hybrid_scaling_factor[] that do not report
> X86_FEATURE_HYBRID_CPU, before checking hybrid_get_cpu_type().
>=20
> With that fix, non-hybrid CPUs in the table now reach
> intel_pstate_hybrid_hwp_adjust() with scaling !=3D perf_ctl_scaling.
> Since commit 5313ec4a215a ("cpufreq: intel_pstate: Improve printing
> of
> debug messages") sets hwp_is_hybrid =3D true unconditionally inside
> that
> function, set hwp_is_hybrid based on X86_FEATURE_HYBRID_CPU instead,
> so the flag is not set on non-hybrid systems.
>=20
> Fixes: 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get scaling
> factors")
> Signed-off-by: Henry Tseng <henrytseng@qnap.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 1292da53e5fc..d39592e86570 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -585,7 +585,7 @@ static void intel_pstate_hybrid_hwp_adjust(struct
> cpudata *cpu)
> =C2=A0	if (scaling =3D=3D perf_ctl_scaling)
> =C2=A0		return;
> =C2=A0
> -	hwp_is_hybrid =3D true;
> +	hwp_is_hybrid =3D cpu_feature_enabled(X86_FEATURE_HYBRID_CPU);
> =C2=A0
> =C2=A0	cpu->pstate.turbo_freq =3D rounddown(cpu->pstate.turbo_pstate
> * scaling,
> =C2=A0					=C2=A0=C2=A0 perf_ctl_scaling);
> @@ -2275,6 +2275,9 @@ static int knl_get_turbo_pstate(int cpu)
> =C2=A0static int hwp_get_cpu_scaling(int cpu)
> =C2=A0{
> =C2=A0	if (hybrid_scaling_factor) {
> +		if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> +			return hybrid_scaling_factor;

It breaks Alder Lake systems with only E-cores and no P-cores. So need
to think about this. So this change didn't restore the behavior of
0fcfc9e51990.
So need to think about this.

Thanks,
Srinivas


> +
> =C2=A0		/*
> =C2=A0		 * Return the hybrid scaling factor for P-cores and
> use the
> =C2=A0		 * default core scaling for E-cores.
