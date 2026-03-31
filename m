Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52D4611C9;
	Tue, 31 Mar 2026 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992012; cv=none; b=UikGr0nJftWMKaAbhqbOnBYRAq+M1Vew5WfLTHtgFNkNdRIh0ttLqgdjcNuvq7gc2VsPenRYD3Nt6ZCq75CxWMkQTquJ23KjJiw+LaeNwOOPJHK79GEnJBJl0g5rE0NBaU4k36CDjFzkJ2f1xbHUWB3UCYoFm+1hnyU4PrQYXiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992012; c=relaxed/simple;
	bh=8b2yVV/7GRGLn0g7MEzZw35eJUa7CnQ2WI5ca/mfSH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJ6pJg31dDnbTPjohVdyEWThRq/OiOIA3ufE48aBZ8xDd4ObfFsxcRJM4FLBCwF3WscOK+GC3ttYSWGfCmOK91ygMtWkzRFy4g0AEvE4eutb6LJZ4FNkXhmhrde0mV5/jDE+yH3hK+nVr1vPhpDIKao5ZxGaJUUzrKVMaDfA4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GesD+8QW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GesD+8QW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774992010; x=1806528010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8b2yVV/7GRGLn0g7MEzZw35eJUa7CnQ2WI5ca/mfSH0=;
  b=GesD+8QWIx/+GeFa+gXqQRF/ukZcPEdTl9K4vyXhbgULRtllCJ0ARSZF
   xhWpYLx3HvjhFG6/8/ek2LF2Gn/nBVVhw+9mGOTQy1fszTHhjlHDO33Zt
   E0BopYgc4whDkSxLgoRjTIhF/+qjrRVPYuHzuKKJWEHe7XHEi6l5KSepU
   5lLojSyK4aM2U9qiLQ12QZu+GZ+nY8JGX/qAs8ZGMqSwdiX2UWFZkN6K+
   FuXbK5v9pG6eKtWTY1mvQxjQdlN7cUlDvS30v9N2zC/K+e8u3m4lRsthn
   qCjdNrv5OMGSZddGW3Ctjut0xcHnwwFQa2QOnIRdb3TBHxmnJJ76Z/pvi
   Q==;
X-CSE-ConnectionGUID: Pxq8kEvITD+h0KpB9r96Aw==
X-CSE-MsgGUID: AQP9zeZUSsiJr8n610TibA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79625026"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="79625026"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:20:06 -0700
X-CSE-ConnectionGUID: gueX6qIuQGiVb6ALTioxVg==
X-CSE-MsgGUID: +NTYWDmKRm+9cszVL7kZpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="221627130"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 14:20:06 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/7] powercap: intel_rapl: Consolidate PL4 and PMU support flags into rapl_defaults
Date: Tue, 31 Mar 2026 14:19:50 -0700
Message-ID: <20260331211950.3329932-8-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331211950.3329932-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260331211950.3329932-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, PL4 and MSR-based RAPL PMU support are detected using
separate CPU ID tables (pl4_support_ids and pmu_support_ids) in the
MSR driver probe path. This creates a maintenance burden since adding
a new CPU requires updates in two places: the rapl_ids table and one
or both of these capability tables.

Consolidate PL4 and PMU capability information directly into
struct rapl_defaults by adding msr_pl4_support and msr_pmu_support
flags. This allows per-CPU capability to be expressed in a single
place alongside other per-CPU defaults, eliminating the duplicate
CPU ID tables entirely.

No functional changes are intended.

Co-developed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_msr.c | 83 ++++++++++++++-----------------
 include/linux/intel_rapl.h        |  2 +
 2 files changed, 38 insertions(+), 47 deletions(-)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index cfb35973f0b5..a34543e66446 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -216,33 +216,6 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
 	return ra->err;
 }
 
-/* List of verified CPUs. */
-static const struct x86_cpu_id pl4_support_ids[] = {
-	X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
-	X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
-	X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
-	X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
-	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, NULL),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
-	X86_MATCH_VFM(INTEL_METEORLAKE, NULL),
-	X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
-	X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
-	X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
-	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
-	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
-	X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
-	X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
-	{}
-};
-
-/* List of MSR-based RAPL PMU support CPUs */
-static const struct x86_cpu_id pmu_support_ids[] = {
-	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
-	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
-	{}
-};
-
 static int rapl_check_unit_atom(struct rapl_domain *rd)
 {
 	struct reg_action ra;
@@ -420,6 +393,23 @@ static const struct rapl_defaults rapl_defaults_amd = {
 	.check_unit = rapl_default_check_unit,
 };
 
+static const struct rapl_defaults rapl_defaults_core_pl4 = {
+	.floor_freq_reg_addr = 0,
+	.check_unit = rapl_default_check_unit,
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
+	.msr_pl4_support = 1,
+};
+
+static const struct rapl_defaults rapl_defaults_core_pl4_pmu = {
+	.floor_freq_reg_addr = 0,
+	.check_unit = rapl_default_check_unit,
+	.set_floor_freq = rapl_default_set_floor_freq,
+	.compute_time_window = rapl_default_compute_time_window,
+	.msr_pl4_support = 1,
+	.msr_pmu_support = 1,
+};
+
 static const struct x86_cpu_id rapl_ids[]  = {
 	X86_MATCH_VFM(INTEL_SANDYBRIDGE,		&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,		&rapl_defaults_core),
@@ -443,35 +433,35 @@ static const struct x86_cpu_id rapl_ids[]  = {
 	X86_MATCH_VFM(INTEL_KABYLAKE_L,			&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_KABYLAKE,			&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_CANNONLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ICELAKE_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,			&rapl_defaults_core_pl4),
 	X86_MATCH_VFM(INTEL_ICELAKE,			&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,		&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ICELAKE_X,			&rapl_defaults_hsw_server),
 	X86_MATCH_VFM(INTEL_ICELAKE_D,			&rapl_defaults_hsw_server),
 	X86_MATCH_VFM(INTEL_COMETLAKE_L,		&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_COMETLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_TIGERLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,		&rapl_defaults_core_pl4),
 	X86_MATCH_VFM(INTEL_TIGERLAKE,			&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ROCKETLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ALDERLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ALDERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,			&rapl_defaults_core_pl4),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,		&rapl_defaults_core_pl4),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,		&rapl_defaults_core_pl4),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,			&rapl_defaults_core_pl4),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,		&rapl_defaults_core_pl4),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,		&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_BARTLETTLAKE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_METEORLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_METEORLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE,			&rapl_defaults_core_pl4),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,		&rapl_defaults_core_pl4),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,		&rapl_defaults_spr_server),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,		&rapl_defaults_spr_server),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_NOVALAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_NOVALAKE_L,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ARROWLAKE_H,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,		&rapl_defaults_core_pl4_pmu),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,		&rapl_defaults_core_pl4_pmu),
+	X86_MATCH_VFM(INTEL_NOVALAKE,			&rapl_defaults_core_pl4),
+	X86_MATCH_VFM(INTEL_NOVALAKE_L,			&rapl_defaults_core_pl4),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,		&rapl_defaults_core_pl4),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,			&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ARROWLAKE_U,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,		&rapl_defaults_core_pl4),
 	X86_MATCH_VFM(INTEL_LAKEFIELD,			&rapl_defaults_core),
 
 	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,		&rapl_defaults_byt),
@@ -498,7 +488,6 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
 
 static int rapl_msr_probe(struct platform_device *pdev)
 {
-	const struct x86_cpu_id *id = x86_match_cpu(pl4_support_ids);
 	int ret;
 
 	switch (boot_cpu_data.x86_vendor) {
@@ -518,16 +507,16 @@ static int rapl_msr_probe(struct platform_device *pdev)
 	rapl_msr_priv->defaults = (const struct rapl_defaults *)pdev->dev.platform_data;
 	rapl_msr_priv->rpi = rpi_msr;
 
-	if (id) {
+	if (rapl_msr_priv->defaults->msr_pl4_support) {
 		rapl_msr_priv->limits[RAPL_DOMAIN_PACKAGE] |= BIT(POWER_LIMIT4);
 		rapl_msr_priv->regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_PL4].msr =
 			MSR_VR_CURRENT_CONFIG;
-		pr_info("PL4 support detected.\n");
+		pr_info("PL4 support detected (updated).\n");
 	}
 
-	if (x86_match_cpu(pmu_support_ids)) {
+	if (rapl_msr_priv->defaults->msr_pmu_support) {
 		rapl_msr_pmu = true;
-		pr_info("MSR-based RAPL PMU support enabled\n");
+		pr_info("MSR-based RAPL PMU support enabled (updated)\n");
 	}
 
 	rapl_msr_priv->control_type = powercap_register_control_type(NULL, "intel-rapl", NULL);
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 01f290de3586..328004f605c3 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -135,6 +135,8 @@ struct rapl_defaults {
 	unsigned int dram_domain_energy_unit;
 	unsigned int psys_domain_energy_unit;
 	bool spr_psys_bits;
+	bool msr_pl4_support;
+	bool msr_pmu_support;
 };
 
 #define PRIMITIVE_INFO_INIT(p, m, s, i, u, f) {	\
-- 
2.43.0

