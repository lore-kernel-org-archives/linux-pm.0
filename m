Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E213A5E85;
	Mon, 23 Mar 2026 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290011; cv=none; b=A1vohmCcK0odmLmgHDUAi/8PUu9SgSI9zATIIVi//gyFVgwYjPBc398CnfDN4iJcDckfsUr2eBmh3ns72yiBomKUKnR19AKLd+n6G1OKcsFpLrlSO6md12W6WXUklKAEmbcCVNa3t0lMmkRzFHki3tWeUK0G2KAOtm29+LxdkmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290011; c=relaxed/simple;
	bh=l3TK2fyopYDLeOdwUu55Wa1QN8poSXjvmMWPq7ZQQsQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MazU3jE85HLl1IuleiHlesND3h4oZ7zoC1HZVkUzcW3JIBOqb065Ay0YWwqxEfYtb1MS6K3A8W6oeBQ6c5/qtvVY1ipHmoL69LCBTCFVjkxudgkwWIh87mfYZcgjJ5hXcibbNxmbqc2mWk30SsjZrY5aWgQhCelYLkzhcI9SbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HY84Adjj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HY84Adjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774290004; x=1805826004;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=l3TK2fyopYDLeOdwUu55Wa1QN8poSXjvmMWPq7ZQQsQ=;
  b=HY84AdjjomavOhmpFbFY1C63oLVxCz3Yq2+aZ0ezBmhpDK8o9/wgaDXn
   BgkDETpeDJRVXB4NvZZO5oVNAczd0rc6wss6h6c7F4cVBVHVOFSMyxame
   BwKA6eJQq5C7y23R7gDx7GXsttBqoa465wxtJuZhyu9Rp4COq8/pjIRk0
   6cu9CIJDThGCiVqFTCyN9YhNMa8fZCsJOgaMmcvO5HzfJ6I0Cqt+521DZ
   nHTx2l+DmFD+hRD6QJEBH/YvzWLIugzBcmCYSfXObNErdzUMKUl13k+AR
   4+vT5//To0TNBIPesXo91w+dwiYvr6o8de57Jow/79gqGUQoo9pkHz35U
   Q==;
X-CSE-ConnectionGUID: lxqj5tQbQ0GK/86DNAI0Nw==
X-CSE-MsgGUID: aCwbP6PmTKa5sr6Nck1Vig==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75205607"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75205607"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 11:20:03 -0700
X-CSE-ConnectionGUID: EgBEBBAkRfKQExM1LDAsNg==
X-CSE-MsgGUID: C+InbcT4R3KdBrkzjcSrPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="219247471"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 11:20:02 -0700
Message-ID: <ed821010a38d535bd123e3d1999d3fd722ccd1ba.camel@linux.intel.com>
Subject: Re: [PATCH v1] powercap: intel_rapl: Consolidate PL4 and PMU
 support flags into rapl_defaults
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  "Rafael J . Wysocki"	 <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 23 Mar 2026 11:20:02 -0700
In-Reply-To: <20260313190052.2370963-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: 
	<20260313190052.2370963-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-13 at 12:00 -0700, Kuppuswamy Sathyanarayanan wrote:
> Currently, PL4 and MSR-based RAPL PMU support are detected using
> separate CPU ID tables (pl4_support_ids and pmu_support_ids) in the
> MSR driver probe path. This creates a maintenance burden since adding
> a new CPU requires updates in two places: the rapl_ids table and one
> or both of these capability tables.
>=20
> Consolidate PL4 and PMU capability information directly into
> struct rapl_defaults by adding msr_pl4_support and msr_pmu_support
> flags. This allows per-CPU capability to be expressed in a single
> place alongside other per-CPU defaults, eliminating the duplicate
> CPU ID tables entirely.
>=20
> No functional changes are intended.
>=20
> Co-developed-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>


Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> ---
> =C2=A0drivers/powercap/intel_rapl_msr.c | 83 ++++++++++++++--------------=
-
> --
> =C2=A0include/linux/intel_rapl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 +
> =C2=A02 files changed, 38 insertions(+), 47 deletions(-)
>=20
> diff --git a/drivers/powercap/intel_rapl_msr.c
> b/drivers/powercap/intel_rapl_msr.c
> index cfb35973f0b5..a34543e66446 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -216,33 +216,6 @@ static int rapl_msr_write_raw(int cpu, struct
> reg_action *ra)
> =C2=A0	return ra->err;
> =C2=A0}
> =C2=A0
> -/* List of verified CPUs. */
> -static const struct x86_cpu_id pl4_support_ids[] =3D {
> -	X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
> -	X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
> -	X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
> -	X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
> -	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, NULL),
> -	X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
> -	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
> -	X86_MATCH_VFM(INTEL_METEORLAKE, NULL),
> -	X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
> -	X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
> -	X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
> -	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
> -	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
> -	X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
> -	X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
> -	{}
> -};
> -
> -/* List of MSR-based RAPL PMU support CPUs */
> -static const struct x86_cpu_id pmu_support_ids[] =3D {
> -	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
> -	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
> -	{}
> -};
> -
> =C2=A0static int rapl_check_unit_atom(struct rapl_domain *rd)
> =C2=A0{
> =C2=A0	struct reg_action ra;
> @@ -420,6 +393,23 @@ static const struct rapl_defaults
> rapl_defaults_amd =3D {
> =C2=A0	.check_unit =3D rapl_default_check_unit,
> =C2=A0};
> =C2=A0
> +static const struct rapl_defaults rapl_defaults_core_pl4 =3D {
> +	.floor_freq_reg_addr =3D 0,
> +	.check_unit =3D rapl_default_check_unit,
> +	.set_floor_freq =3D rapl_default_set_floor_freq,
> +	.compute_time_window =3D rapl_default_compute_time_window,
> +	.msr_pl4_support =3D 1,
> +};
> +
> +static const struct rapl_defaults rapl_defaults_core_pl4_pmu =3D {
> +	.floor_freq_reg_addr =3D 0,
> +	.check_unit =3D rapl_default_check_unit,
> +	.set_floor_freq =3D rapl_default_set_floor_freq,
> +	.compute_time_window =3D rapl_default_compute_time_window,
> +	.msr_pl4_support =3D 1,
> +	.msr_pmu_support =3D 1,
> +};
> +
> =C2=A0static const struct x86_cpu_id rapl_ids[]=C2=A0 =3D {
> =C2=A0	X86_MATCH_VFM(INTEL_SANDYBRIDGE,		&rapl_defaul
> ts_core),
> =C2=A0	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,		&rapl_defaul
> ts_core),
> @@ -443,35 +433,35 @@ static const struct x86_cpu_id rapl_ids[]=C2=A0 =3D=
 {
> =C2=A0	X86_MATCH_VFM(INTEL_KABYLAKE_L,			&rap
> l_defaults_core),
> =C2=A0	X86_MATCH_VFM(INTEL_KABYLAKE,			&rapl_defaul
> ts_core),
> =C2=A0	X86_MATCH_VFM(INTEL_CANNONLAKE_L,		&rapl_defaul
> ts_core),
> -
> 	X86_MATCH_VFM(INTEL_ICELAKE_L,			&rapl_defaults_core),
> +	X86_MATCH_VFM(INTEL_ICELAKE_L,			&rapl_defaul
> ts_core_pl4),
> =C2=A0	X86_MATCH_VFM(INTEL_ICELAKE,			&rapl_defaul
> ts_core),
> =C2=A0	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,		&rapl_defaul
> ts_core),
> =C2=A0	X86_MATCH_VFM(INTEL_ICELAKE_X,			&rapl_defaul
> ts_hsw_server),
> =C2=A0	X86_MATCH_VFM(INTEL_ICELAKE_D,			&rapl_defaul
> ts_hsw_server),
> =C2=A0	X86_MATCH_VFM(INTEL_COMETLAKE_L,		&rapl_defaul
> ts_core),
> =C2=A0	X86_MATCH_VFM(INTEL_COMETLAKE,			&rapl_defaul
> ts_core),
> -
> 	X86_MATCH_VFM(INTEL_TIGERLAKE_L,		&rapl_defaults_core),
> +	X86_MATCH_VFM(INTEL_TIGERLAKE_L,		&rapl_defaul
> ts_core_pl4),
> =C2=A0	X86_MATCH_VFM(INTEL_TIGERLAKE,			&rapl_defaul
> ts_core),
> =C2=A0	X86_MATCH_VFM(INTEL_ROCKETLAKE,			&rap
> l_defaults_core),
> -
> 	X86_MATCH_VFM(INTEL_ALDERLAKE,			&rapl_defaults_core),
> -
> 	X86_MATCH_VFM(INTEL_ALDERLAKE_L,		&rapl_defaults_core),
> -
> 	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,		&rapl_defaults_core),
> -
> 	X86_MATCH_VFM(INTEL_RAPTORLAKE,			&rapl_defaults_core),
> -
> 	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,		&rapl_defaults_core),
> +	X86_MATCH_VFM(INTEL_ALDERLAKE,			&rapl_defaul
> ts_core_pl4),
> +	X86_MATCH_VFM(INTEL_ALDERLAKE_L,		&rapl_defaul
> ts_core_pl4),
> +	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,		&rapl_defaul
> ts_core_pl4),
> +	X86_MATCH_VFM(INTEL_RAPTORLAKE,			&rap
> l_defaults_core_pl4),
> +	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,		&rapl_defaul
> ts_core_pl4),
> =C2=A0	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,		&rapl_defaul
> ts_core),
> =C2=A0	X86_MATCH_VFM(INTEL_BARTLETTLAKE,		&rapl_defaul
> ts_core),
> -
> 	X86_MATCH_VFM(INTEL_METEORLAKE,			&rapl_defaults_core),
> -
> 	X86_MATCH_VFM(INTEL_METEORLAKE_L,		&rapl_defaults_core),
> +	X86_MATCH_VFM(INTEL_METEORLAKE,			&rap
> l_defaults_core_pl4),
> +	X86_MATCH_VFM(INTEL_METEORLAKE_L,		&rapl_defaul
> ts_core_pl4),
> =C2=A0	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,		&rapl_defaul
> ts_spr_server),
> =C2=A0	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,		&rapl_defaul
> ts_spr_server),
> =C2=A0	X86_MATCH_VFM(INTEL_LUNARLAKE_M,		&rapl_defaul
> ts_core),
> -
> 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,		&rapl_defaults_core),
> -
> 	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,		&rapl_defaults_core),
> -
> 	X86_MATCH_VFM(INTEL_NOVALAKE,			&rapl_defaults_core),
> -
> 	X86_MATCH_VFM(INTEL_NOVALAKE_L,			&rapl_defaults_core),
> -
> 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,		&rapl_defaults_core),
> +	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,		&rapl_defaul
> ts_core_pl4_pmu),
> +	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,		&rapl_defaul
> ts_core_pl4_pmu),
> +	X86_MATCH_VFM(INTEL_NOVALAKE,			&rapl_defaul
> ts_core_pl4),
> +	X86_MATCH_VFM(INTEL_NOVALAKE_L,			&rap
> l_defaults_core_pl4),
> +	X86_MATCH_VFM(INTEL_ARROWLAKE_H,		&rapl_defaul
> ts_core_pl4),
> =C2=A0	X86_MATCH_VFM(INTEL_ARROWLAKE,			&rapl_defaul
> ts_core),
> -
> 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,		&rapl_defaults_core),
> +	X86_MATCH_VFM(INTEL_ARROWLAKE_U,		&rapl_defaul
> ts_core_pl4),
> =C2=A0	X86_MATCH_VFM(INTEL_LAKEFIELD,			&rapl_defaul
> ts_core),
> =C2=A0
> =C2=A0	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,		&rapl_defaul
> ts_byt),
> @@ -498,7 +488,6 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
> =C2=A0
> =C2=A0static int rapl_msr_probe(struct platform_device *pdev)
> =C2=A0{
> -	const struct x86_cpu_id *id =3D
> x86_match_cpu(pl4_support_ids);
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	switch (boot_cpu_data.x86_vendor) {
> @@ -518,16 +507,16 @@ static int rapl_msr_probe(struct
> platform_device *pdev)
> =C2=A0	rapl_msr_priv->defaults =3D (const struct rapl_defaults
> *)pdev->dev.platform_data;
> =C2=A0	rapl_msr_priv->rpi =3D rpi_msr;
> =C2=A0
> -	if (id) {
> +	if (rapl_msr_priv->defaults->msr_pl4_support) {
> =C2=A0		rapl_msr_priv->limits[RAPL_DOMAIN_PACKAGE] |=3D
> BIT(POWER_LIMIT4);
> =C2=A0		rapl_msr_priv-
> >regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_PL4].msr =3D
> =C2=A0			MSR_VR_CURRENT_CONFIG;
> -		pr_info("PL4 support detected.\n");
> +		pr_info("PL4 support detected (updated).\n");
> =C2=A0	}
> =C2=A0
> -	if (x86_match_cpu(pmu_support_ids)) {
> +	if (rapl_msr_priv->defaults->msr_pmu_support) {
> =C2=A0		rapl_msr_pmu =3D true;
> -		pr_info("MSR-based RAPL PMU support enabled\n");
> +		pr_info("MSR-based RAPL PMU support enabled
> (updated)\n");
> =C2=A0	}
> =C2=A0
> =C2=A0	rapl_msr_priv->control_type =3D
> powercap_register_control_type(NULL, "intel-rapl", NULL);
> diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
> index 01f290de3586..328004f605c3 100644
> --- a/include/linux/intel_rapl.h
> +++ b/include/linux/intel_rapl.h
> @@ -135,6 +135,8 @@ struct rapl_defaults {
> =C2=A0	unsigned int dram_domain_energy_unit;
> =C2=A0	unsigned int psys_domain_energy_unit;
> =C2=A0	bool spr_psys_bits;
> +	bool msr_pl4_support;
> +	bool msr_pmu_support;
> =C2=A0};
> =C2=A0
> =C2=A0#define PRIMITIVE_INFO_INIT(p, m, s, i, u, f) {	\
