Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76C3DDDD9;
	Fri, 13 Mar 2026 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428481; cv=none; b=qc9pnEmSnEdC05RcFu0vvdBSuSfrIjC/PSUqnrsluSbKghZx+uIstcHCGrWV0TQ5OLLRwlFciEKpZkFlQhzjkIqgVeIX1Z2FigtEwRdNx2maJWEc0nMHPFA9pNwbP4XaujixawIiOxx7JgsZH+YLoGdTufQew65R+gXXWeYt+ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428481; c=relaxed/simple;
	bh=5taLKhtQcUnLQIxbSSE7F60+XKWocokUv9645P5Rbak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LlhL3aULl16zGaUUA3e1/ljQtPNHLiypV8qnpiVThbN2+XXndenyzVQ7Yt9bwNdpaq1twVLGyBJDIo4FFpCW2VDc66FR4wf6wP5jPa3fkFEIc9MLEf64YJEmLLCjlgDCgTQV4Qy6hlt2rj1LitRirOtUACpy8/aBgQHlsIwAk/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGbItS8R; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGbItS8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773428468; x=1804964468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5taLKhtQcUnLQIxbSSE7F60+XKWocokUv9645P5Rbak=;
  b=JGbItS8RD4F+eg4sNUHi1O3KgNvxsP2E/IOkB9ENuxLwyYd6gIa2rx0G
   NqKILG+1cyssDSf4/XSt1VkkL6cLNEoEtix1EcSNW258psGPq3r3iOkh4
   VYFs+n2ht0KWtwAF3frAOPvbPig9sa4xh0++Rl9ubMfF7Uruw65Nzsujh
   zXRa/B+XXc93+bdbMLUKeHJjIys2OaPZ+zyJsCgpGXkOg8s9W1qA1Syv4
   ykkNZNH27m4sOlzZLwYUwRfLr1VNwgt2YmgAHZWUCrl1X2ff8XUkit1fO
   u7RtIJ35yzqX6RfWYQ9UMdPrL6a2rXs+TOAisE23eZbuP41qtMCmKHs6s
   g==;
X-CSE-ConnectionGUID: w0zNCtxiStaCtluiTlkogg==
X-CSE-MsgGUID: OLBnSMnBRFaZr0aXtvDH2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74574619"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74574619"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 12:01:08 -0700
X-CSE-ConnectionGUID: dDVP1uAiRRm3aZM67bxmlA==
X-CSE-MsgGUID: lXmappibStGuckRs/Sikdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="221206297"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 12:01:08 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] powercap: intel_rapl: Consolidate PL4 and PMU support flags into rapl_defaults
Date: Fri, 13 Mar 2026 12:00:52 -0700
Message-ID: <20260313190052.2370963-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

