Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138C830BF6B
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069754; cv=none; b=CRT0Qog+KvpiNCDJvmV30lW5G0coQPUVFReNjgdvc86VLRieIoehY/ljNBlILDojY6+enVq3u8q/gbcxUdoFZ3Hmj3F+kCTenYN7HM/kio22Rurpu+gxN+n5s+oSVfuFhLpnZan7NyEGT3F3BF5Rt2nU0cS8f0Hu86sxltYUuEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069754; c=relaxed/simple;
	bh=Kv155bury1ySyWPQPAVmF/kyefgPRxy2Onngm/ToK18=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TABWmKleaVHlEJJrFLiXyftW5SB0gfpQkbFj5NM7BjLPidPp0zHToi61Ir3dVxd49U7sQ2IARh7dc6w0LmZtS6hSZjpaCR6gR5sz1sh5fx4U2XSFZXYlvmMsPpAsDxWTh1AbKHAPIUjP+YRUVLR6RpQ4NdzSJ9gbsgPPPSBZQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKw/MFkF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKw/MFkF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778069752; x=1809605752;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Kv155bury1ySyWPQPAVmF/kyefgPRxy2Onngm/ToK18=;
  b=dKw/MFkFY207EiyiXDICQMYRF7v0j/j4VMZ7Jvd8XBwFMYKCOGZYL/dr
   XvXJ7xz3WVU5O4t7LeCSejxZsY9fr6LGLW8EANfmbFuANg7llicqYolz3
   KY/Ml3ZDjl3VfCrzoD1AqQMCjq0g1v8plPTgPGMjNagbVRnIWqK2SMUaM
   TFBmHfaMTIOCe4tkM4lcLWD4HOnuMQkL43WnHvx8zCEFUUatYVQyx1vH2
   9boRuSRlJZW+CjVrVc0rHRxBo3SDr6d8rpTQoQpTlS9g9Nvg4u3a/rAO7
   T6t5UfDGeuB7vCR/mFk/xMq1RmJwNP003SYzziuhbVjrOfFHa68t89rba
   g==;
X-CSE-ConnectionGUID: rMc+343iSlahGjEiI5eH9g==
X-CSE-MsgGUID: yfiJY4ZLTQy5zXIcRwt46g==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89307566"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="89307566"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 05:15:51 -0700
X-CSE-ConnectionGUID: tXOoAtShSg6Qj6unhrxckg==
X-CSE-MsgGUID: 2ihFjyXtT4mcjjDdjJ3PMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="235117644"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.141]) ([10.125.110.141])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 05:15:50 -0700
Message-ID: <7d47a806110c750c47c4b473f45eff6d7f3ebc18.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use CPPC to get scaling factor
 for Bartlett Lake
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Henry Tseng <henrytseng@qnap.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Len Brown <lenb@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, SW Chen <swchen@qnap.com>, Kevin Ko
	 <kevinko@qnap.com>
Date: Wed, 06 May 2026 05:15:49 -0700
In-Reply-To: <20260506095157.1591221-1-henrytseng@qnap.com>
References: <20260506095157.1591221-1-henrytseng@qnap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-06 at 17:51 +0800, Henry Tseng wrote:
> Previously, hwp_get_cpu_scaling() returned INTEL_PSTATE_CORE_SCALING
> (100000) as the scaling factor for non-hybrid CPUs.=C2=A0 However, this
> value is too large for Bartlett Lake processors, where HWP
> performance levels do not map 1:1 to PERF_CTL P-state ratios.
>=20
> Per the Intel datasheet [1], the Intel Core 9 273PE specifies:
>=20
> =C2=A0 Performance-cores:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12
> =C2=A0 Efficient-cores:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0
> =C2=A0 Max Turbo Frequency:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.7 GHz
> =C2=A0 Intel Thermal Velocity Boost Frequency:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.7 GHz
> =C2=A0 Intel Turbo Boost Max Technology 3.0 Frequency:=C2=A0=C2=A0=C2=A0 =
5.6 GHz
> =C2=A0 Performance-core Max Turbo Frequency:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.4 GHz
> =C2=A0 Performance-core Base Frequency:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 2.3 GHz
>=20
> Because this CPU has no E-cores and does not report
> X86_FEATURE_HYBRID_CPU, hwp_get_cpu_scaling() returns 100000.=C2=A0 In
> intel_pstate_get_cpu_pstates(), the condition
> cpu->pstate.scaling =3D=3D perf_ctl_scaling then takes the early path
> that simply multiplies HWP performance levels by 100000, producing
> cpuinfo_max_freq values that exceed the documented maximum turbo
> frequency:
>=20
> =C2=A0 intel_pstate: CPU0: PERF_CTL turbo =3D 57
> =C2=A0 intel_pstate: CPU0: HWP_CAP guaranteed =3D 30
> =C2=A0 intel_pstate: CPU0: HWP_CAP highest =3D 70
> =C2=A0 intel_pstate: CPU0: HWP-to-frequency scaling factor: 100000
> =C2=A0 intel_pstate: set_policy cpuinfo.max 7000000 policy->max 7000000
> =C2=A0 ...
> =C2=A0 intel_pstate: CPU12: HWP_CAP highest =3D 73
> =C2=A0 intel_pstate: CPU12: HWP-to-frequency scaling factor: 100000
> =C2=A0 intel_pstate: set_policy cpuinfo.max 7300000 policy->max 7300000
>=20
> To avoid impacting traditional non-hybrid CPUs, introduce a new
> intel_cppc_scaling_ids[] table that lists non-hybrid CPU models
> requiring dynamic scaling factor computation via CPPC.=C2=A0 CPUs in
> this list call intel_pstate_cppc_get_scaling() instead of
> core_get_scaling().
>=20
> Because the scaling factor is now obtained from CPPC,
> intel_pstate_hybrid_hwp_adjust() no longer takes the early return
> on these CPUs.=C2=A0 To prevent hwp_is_hybrid from being set incorrectly
> on non-hybrid systems (which would enable asymmetric capacity
> scaling and disable ITMT), guard the assignment with
> X86_FEATURE_HYBRID_CPU.
>=20
> Since intel_pstate_hybrid_hwp_adjust() now also handles non-hybrid
> processors, rename it to intel_pstate_hwp_adjust() and update the
> kerneldoc and inline comments accordingly.
>=20
> After this patch (Intel Core 9 273PE):
>=20
> =C2=A0 intel_pstate: CPU0: PERF_CTL turbo =3D 57
> =C2=A0 intel_pstate: CPU0: HWP_CAP guaranteed =3D 30
> =C2=A0 intel_pstate: CPU0: HWP_CAP highest =3D 70
> =C2=A0 intel_pstate: CPU0: HWP-to-frequency scaling factor: 79310
> =C2=A0 intel_pstate: set_policy cpuinfo.max 5500000 policy->max 5500000
> =C2=A0 ...
> =C2=A0 intel_pstate: CPU12: HWP_CAP highest =3D 73
> =C2=A0 intel_pstate: CPU12: HWP-to-frequency scaling factor: 79310
> =C2=A0 intel_pstate: set_policy cpuinfo.max 5700000 policy->max 5700000
>=20
> The scaling factor 79310 is computed from CPPC
> nominal_freq=3D2300 MHz and nominal_perf=3D29.
>=20

This is a special embedded processor, so to reduce enabling effort by=20
in BIOS, why not just add

diff --git a/drivers/cpufreq/intel_pstate.c
b/drivers/cpufreq/intel_pstate.c
index ec4abe374573..763598ca13cd 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3732,6 +3732,7 @@ static const struct x86_cpu_id
intel_hybrid_scaling_factor[] =3D {
        X86_MATCH_VFM(INTEL_RAPTORLAKE, HYBRID_SCALING_FACTOR_ADL),
        X86_MATCH_VFM(INTEL_RAPTORLAKE_P, HYBRID_SCALING_FACTOR_ADL),
        X86_MATCH_VFM(INTEL_RAPTORLAKE_S, HYBRID_SCALING_FACTOR_ADL),
+       X86_MATCH_VFM(INTEL_BARTLETTLAKE, HYBRID_SCALING_FACTOR_ADL),
        X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
        X86_MATCH_VFM(INTEL_LUNARLAKE_M, HYBRID_SCALING_FACTOR_LNL),
        {}

CPPC scaling introduces rounding issues for some frequency. This will
avoid introducing another CPU model list.

Thanks,
Srinivas



> The resulting sysfs values are:
>=20
> =C2=A0 $ cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_max_freq
> =C2=A0 5500000=C2=A0 (20 CPUs with HWP_CAP highest =3D 70)
> =C2=A0 5700000=C2=A0 ( 4 CPUs with HWP_CAP highest =3D 73)
> =C2=A0 $ cat /sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq
> =C2=A0 5500000
> =C2=A0 5700000
>=20
> The reported maximum turbo frequency now matches the datasheet's
> Max Turbo Frequency of 5.7 GHz.
>=20
> [1]
> https://www.intel.com/content/www/us/en/products/sku/245717/intel-core-9-=
processor-273pe-36m-cache-up-to-5-70-ghz/specifications.html
>=20
> Signed-off-by: Henry Tseng <henrytseng@qnap.com>
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c | 37 +++++++++++++++++++++++--------=
-
> --
> =C2=A01 file changed, 25 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 1292da53e5fc..4d3dbea19eb7 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -557,17 +557,17 @@ static int intel_pstate_freq_to_hwp(struct
> cpudata *cpu, int freq)
> =C2=A0}
> =C2=A0
> =C2=A0/**
> - * intel_pstate_hybrid_hwp_adjust - Calibrate HWP performance
> levels.
> + * intel_pstate_hwp_adjust - Calibrate HWP performance levels.
> =C2=A0 * @cpu: Target CPU.
> =C2=A0 *
> - * On hybrid processors, HWP may expose more performance levels than
> there are
> + * On some processors, HWP may expose more performance levels than
> there are
> =C2=A0 * P-states accessible through the PERF_CTL interface.=C2=A0 If tha=
t
> happens, the
> =C2=A0 * scaling factor between HWP performance levels and CPU frequency
> will be less
> =C2=A0 * than the scaling factor between P-state values and CPU frequency=
.
> =C2=A0 *
> =C2=A0 * In that case, adjust the CPU parameters used in computations
> accordingly.
> =C2=A0 */
> -static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
> +static void intel_pstate_hwp_adjust(struct cpudata *cpu)
> =C2=A0{
> =C2=A0	int perf_ctl_max_phys =3D cpu->pstate.max_pstate_physical;
> =C2=A0	int perf_ctl_scaling =3D cpu->pstate.perf_ctl_scaling;
> @@ -585,7 +585,8 @@ static void intel_pstate_hybrid_hwp_adjust(struct
> cpudata *cpu)
> =C2=A0	if (scaling =3D=3D perf_ctl_scaling)
> =C2=A0		return;
> =C2=A0
> -	hwp_is_hybrid =3D true;
> +	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> +		hwp_is_hybrid =3D true;
> =C2=A0
> =C2=A0	cpu->pstate.turbo_freq =3D rounddown(cpu->pstate.turbo_pstate
> * scaling,
> =C2=A0					=C2=A0=C2=A0 perf_ctl_scaling);
> @@ -1815,6 +1816,7 @@ static const struct attribute_group
> intel_pstate_attr_group =3D {
> =C2=A0};
> =C2=A0
> =C2=A0static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[];
> +static const struct x86_cpu_id intel_cppc_scaling_ids[];
> =C2=A0
> =C2=A0static struct kobject *intel_pstate_kobject;
> =C2=A0
> @@ -2285,15 +2287,16 @@ static int hwp_get_cpu_scaling(int cpu)
> =C2=A0		return core_get_scaling();
> =C2=A0	}
> =C2=A0
> -	/* Use core scaling on non-hybrid systems. */
> -	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> -		return core_get_scaling();
> -
> =C2=A0	/*
> -	 * The system is hybrid, but the hybrid scaling factor is
> not known or
> -	 * the CPU type is not one of the above, so use CPPC to
> compute the
> -	 * scaling factor for this CPU.
> +	 * Use core scaling on non-hybrid systems, except for those
> whose
> +	 * perf-to-frequency scaling factor differs from the default
> +	 * (e.g. Bartlett Lake) and must be computed via CPPC.
> =C2=A0	 */
> +	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU) &&
> +	=C2=A0=C2=A0=C2=A0 !x86_match_cpu(intel_cppc_scaling_ids))
> +		return core_get_scaling();
> +
> +	/* Compute the scaling factor via CPPC. */
> =C2=A0	return intel_pstate_cppc_get_scaling(cpu);
> =C2=A0}
> =C2=A0
> @@ -2328,7 +2331,7 @@ static void intel_pstate_get_cpu_pstates(struct
> cpudata *cpu)
> =C2=A0
> =C2=A0		if (pstate_funcs.get_cpu_scaling) {
> =C2=A0			cpu->pstate.scaling =3D
> pstate_funcs.get_cpu_scaling(cpu->cpu);
> -			intel_pstate_hybrid_hwp_adjust(cpu);
> +			intel_pstate_hwp_adjust(cpu);
> =C2=A0		} else {
> =C2=A0			cpu->pstate.scaling =3D perf_ctl_scaling;
> =C2=A0		}
> @@ -3739,6 +3742,16 @@ static const struct x86_cpu_id
> intel_hybrid_scaling_factor[] =3D {
> =C2=A0	{}
> =C2=A0};
> =C2=A0
> +/*
> + * Non-hybrid CPUs whose perf-to-frequency scaling factor differs
> from
> + * INTEL_PSTATE_CORE_SCALING. For these, compute the scaling factor
> + * dynamically via CPPC.
> + */
> +static const struct x86_cpu_id intel_cppc_scaling_ids[] =3D {
> +	X86_MATCH_VFM(INTEL_BARTLETTLAKE, NULL),
> +	{}
> +};
> +
> =C2=A0static bool hwp_check_epp(void)
> =C2=A0{
> =C2=A0	if (boot_cpu_has(X86_FEATURE_HWP_EPP))
