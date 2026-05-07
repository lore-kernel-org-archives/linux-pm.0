Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D03EF656
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165232; cv=none; b=lb6l9pH38hmw5dXlsdK/P0yz8umPbvQ6qWpnS188vsMvVEIA+fxBl/Fyk2LbKr6mFzs2WHzHI4hoH4O/PC62jhMe+zTh05CPbcHmVzUi8MxLEPLy5pcqg4N3enP0FqakL1KWvmyLQ/5sJEn4ICuhXcWrQGZvW1M2iwczoj4Gc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165232; c=relaxed/simple;
	bh=j5AwfqRpfLcGlU3nvL8d5anpS5Z5nq565SF8GAfQdcI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F0eFrsaBP2RZZJxVMPIrOtQ1Q0uTpGzAhmqBa3J8ubMnzpBYCeVGqLVxV47NO/Q9NuIkzPJlGQ2sA27iv7Nlsf/cdIEoYb76Mz7kRVoow30OLIu+xqouU4+evwZy4daNOiBVJPxK4j9FSFJM1nF1dldSYO9nJNppOMQ4hzD7TfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cq8B0T0g; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cq8B0T0g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778165229; x=1809701229;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=j5AwfqRpfLcGlU3nvL8d5anpS5Z5nq565SF8GAfQdcI=;
  b=Cq8B0T0gM2EcRTDgY7zJGT/GsQ1wmyDMBH0oRVvgctGGV/t2ruFMNjK8
   zO4nloIfl9OK20t/fbkLJuM2O7kuciogiV4sBW9Xzf18fOi235f50rj4g
   mAp5cgp5487rvB5WHSqYPS10FpzfIY5QwoSgeIYf/oL+WF4nrRA+q7q/F
   kP6OWZt3OngTDgeTFPTb5sMLBsponQe2dSsq9sOP3UUEj2dXaMsk5N6TC
   ZTP//6UOsTKf/qMDxkKGSc5eu96mT5EMJ0KrqyC5846c3LOh69g0ppn3P
   YFld+VP26RGcTyv+iX3j0JkNZu3jvJrpeaD1VGGjvQvUDXMMwcPSUz1uz
   Q==;
X-CSE-ConnectionGUID: EtmdXqaKSpyauhybkGiK1A==
X-CSE-MsgGUID: GUn3ceSsTlG2K/qZ6VjlRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79108644"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="79108644"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 07:47:09 -0700
X-CSE-ConnectionGUID: Pvld9wC0R2itro2kmhXHsw==
X-CSE-MsgGUID: tvshUlyRSPutImgQatUlcg==
X-ExtLoop1: 1
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.110.223]) ([10.125.110.223])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 07:47:07 -0700
Message-ID: <5ff02dfbafea7f5a9129853ae147e6de1cefb281.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Use CPPC to get scaling factor
 for Bartlett Lake
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Henry Tseng <henrytseng@qnap.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Len Brown <lenb@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, SW Chen <swchen@qnap.com>, Kevin Ko
	 <kevinko@qnap.com>
Date: Thu, 07 May 2026 07:47:05 -0700
In-Reply-To: <20260507092554.2631883-1-henrytseng@qnap.com>
References: <20260506095157.1591221-1-henrytseng@qnap.com>
		 <7d47a806110c750c47c4b473f45eff6d7f3ebc18.camel@linux.intel.com>
	 <20260507092554.2631883-1-henrytseng@qnap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 17:25 +0800, Henry Tseng wrote:
> On Wed, 06 May 2026 05:15:49 -0700, Srinivas Pandruvada wrote:
> > This is a special embedded processor, so to reduce enabling effort
> > by=20
> > in BIOS, why not just add
> >=20
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index ec4abe374573..763598ca13cd 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -3732,6 +3732,7 @@ static const struct x86_cpu_id
> > intel_hybrid_scaling_factor[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_RAPTORLA=
KE, HYBRID_SCALING_FACTOR_ADL),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_RAPTORLA=
KE_P,
> > HYBRID_SCALING_FACTOR_ADL),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_RAPTORLA=
KE_S,
> > HYBRID_SCALING_FACTOR_ADL),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_BARTLETTLAKE,
> > HYBRID_SCALING_FACTOR_ADL),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_METEORLA=
KE_L,
> > HYBRID_SCALING_FACTOR_MTL),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X86_MATCH_VFM(INTEL_LUNARLAK=
E_M,
> > HYBRID_SCALING_FACTOR_LNL),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {}
> >=20
> > CPPC scaling introduces rounding issues for some frequency. This
> > will
> > avoid introducing another CPU model list.
>=20
> Thanks for the review, the static table is definitely simpler. I had
> referenced commit 9b18d536b124 and went with CPPC, but I take your
> point
> about the rounding issues.
> After adding INTEL_BARTLETTLAKE to intel_hybrid_scaling_factor[], I
> noticed hwp_get_cpu_scaling() still falls back to core_get_scaling()
> on
> 273PE, because hybrid_get_cpu_type() returns 0 (not
> INTEL_CPU_TYPE_CORE)
> on a non-hybrid CPU, so the table value doesn't get picked up. I
> added a
> check for X86_FEATURE_HYBRID_CPU there to let non-hybrid CPUs in the
> table
> use hybrid_scaling_factor.
>=20

This situation is not new, refer to commit
0fcfc9e51990246a9813475716746ff5eb98c6aa
    cpufreq: intel_pstate: Fix scaling for hybrid-capable systems with
disabled E-cores

So it seems some regression as it should returned hybrid scaling
factor.
Don't have this system handy to test. hybrid_get_cpu_type() will return
0 when hybrid feature is not set.

With this commit
9b18d536b124357fee56d82b1462c02f78d219e5

adding if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)), will break
such configuration.

So I suggest to send two patches. The first one can have=20
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2273,6 +2273,9 @@ static int knl_get_turbo_pstate(int cpu)
 static int hwp_get_cpu_scaling(int cpu)
 {
        if (hybrid_scaling_factor) {
+               if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+                       return hybrid_scaling_factor;
+

You can add Fixes tag for commit
9b18d536b124357fee56d82b1462c02f78d219e5.

The second patch with hybrid scaling factor for Bartlett Lake, which is
like RPL.=20

Thanks,
Srinivas


> I also kept hwp_is_hybrid =3D 0 on 273PE to match the current mainline
> behavior on non-hybrid CPUs.
>=20
> Draft below, based on v7.1-rc2 (7fd2df204f34), tested on Intel Core 9
> 273PE:
>=20
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 1292da53e5fc..b66455252745 100644
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
> @@ -2279,7 +2279,8 @@ static int hwp_get_cpu_scaling(int cpu)
> =C2=A0		 * Return the hybrid scaling factor for P-cores and
> use the
> =C2=A0		 * default core scaling for E-cores.
> =C2=A0		 */
> -		if (hybrid_get_cpu_type(cpu) =3D=3D INTEL_CPU_TYPE_CORE)
> +		if (hybrid_get_cpu_type(cpu) =3D=3D INTEL_CPU_TYPE_CORE
> ||
> +		=C2=A0=C2=A0=C2=A0 !cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> =C2=A0			return hybrid_scaling_factor;
> =C2=A0
> =C2=A0		return core_get_scaling();
> @@ -3734,6 +3735,7 @@ static const struct x86_cpu_id
> intel_hybrid_scaling_factor[] =3D {
> =C2=A0	X86_MATCH_VFM(INTEL_RAPTORLAKE, HYBRID_SCALING_FACTOR_ADL),
> =C2=A0	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,
> HYBRID_SCALING_FACTOR_ADL),
> =C2=A0	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,
> HYBRID_SCALING_FACTOR_ADL),
> +	X86_MATCH_VFM(INTEL_BARTLETTLAKE,
> HYBRID_SCALING_FACTOR_ADL),
> =C2=A0	X86_MATCH_VFM(INTEL_METEORLAKE_L,
> HYBRID_SCALING_FACTOR_MTL),
> =C2=A0	X86_MATCH_VFM(INTEL_LUNARLAKE_M, HYBRID_SCALING_FACTOR_LNL),
> =C2=A0	{}
>=20
> Result on 273PE:
>=20
> =C2=A0 intel_pstate: CPU0:=C2=A0 HWP_CAP highest =3D 70, scaling =3D 7874=
1,
> cpuinfo.max =3D 5500000
> =C2=A0 intel_pstate: CPU12: HWP_CAP highest =3D 73, scaling =3D 78741,
> cpuinfo.max =3D 5700000
>=20
> If this direction looks OK, I'll send a v2 with a proper commit
> message.
>=20
> Thanks,
> Henry
