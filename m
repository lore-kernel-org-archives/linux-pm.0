From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/44] tools/power turbostat: dump Atom P-states correctly
Date: Wed,  1 Mar 2017 00:27:20 -0500
Message-ID: <0f7887c49b0c454aef9936a6eadabe1c91b5af55.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36455 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdCAHR3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 02:17:29 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Turbostat dumps MSR_TURBO_RATIO_LIMIT on Core Architecture.
But Atom Architecture uses MSR_ATOM_CORE_RATIOS and
MSR_ATOM_CORE_TURBO_RATIOS.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 103 +++++++++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 21 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a1ec9d816dfa..da6ec640caf7 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1722,6 +1722,54 @@ dump_nhm_turbo_ratio_limits(void)
 }
 
 static void
+dump_atom_turbo_ratio_limits(void)
+{
+	unsigned long long msr;
+	unsigned int ratio;
+
+	get_msr(base_cpu, MSR_ATOM_CORE_RATIOS, &msr);
+	fprintf(outf, "cpu%d: MSR_ATOM_CORE_RATIOS: 0x%08llx\n", base_cpu, msr & 0xFFFFFFFF);
+
+	ratio = (msr >> 0) & 0x3F;
+	if (ratio)
+		fprintf(outf, "%d * %.1f = %.1f MHz minimum operating frequency\n",
+			ratio, bclk, ratio * bclk);
+
+	ratio = (msr >> 8) & 0x3F;
+	if (ratio)
+		fprintf(outf, "%d * %.1f = %.1f MHz low frequency mode (LFM)\n",
+			ratio, bclk, ratio * bclk);
+
+	ratio = (msr >> 16) & 0x3F;
+	if (ratio)
+		fprintf(outf, "%d * %.1f = %.1f MHz base frequency\n",
+			ratio, bclk, ratio * bclk);
+
+	get_msr(base_cpu, MSR_ATOM_CORE_TURBO_RATIOS, &msr);
+	fprintf(outf, "cpu%d: MSR_ATOM_CORE_TURBO_RATIOS: 0x%08llx\n", base_cpu, msr & 0xFFFFFFFF);
+
+	ratio = (msr >> 24) & 0x3F;
+	if (ratio)
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 4 active cores\n",
+			ratio, bclk, ratio * bclk);
+
+	ratio = (msr >> 16) & 0x3F;
+	if (ratio)
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 3 active cores\n",
+			ratio, bclk, ratio * bclk);
+
+	ratio = (msr >> 8) & 0x3F;
+	if (ratio)
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 2 active cores\n",
+			ratio, bclk, ratio * bclk);
+
+	ratio = (msr >> 0) & 0x3F;
+	if (ratio)
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 1 active core\n",
+			ratio, bclk, ratio * bclk);
+}
+
+static void
 dump_knl_turbo_ratio_limits(void)
 {
 	const unsigned int buckets_no = 7;
@@ -2496,8 +2544,32 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	has_base_hz = 1;
 	return 1;
 }
+/*
+ * SLV client has supporet for unique MSRs:
+ *
+ * MSR_CC6_DEMOTION_POLICY_CONFIG
+ * MSR_MC6_DEMOTION_POLICY_CONFIG
+ */
+
+int has_slv_msrs(unsigned int family, unsigned int model)
+{
+	if (!genuine_intel)
+		return 0;
+
+	switch (model) {
+	case INTEL_FAM6_ATOM_SILVERMONT1:
+	case INTEL_FAM6_ATOM_MERRIFIELD:
+	case INTEL_FAM6_ATOM_MOOREFIELD:
+		return 1;
+	}
+	return 0;
+}
+
 int has_nhm_turbo_ratio_limit(unsigned int family, unsigned int model)
 {
+	if (has_slv_msrs(family, model))
+		return 0;
+
 	switch (model) {
 	/* Nehalem compatible, but do not include turbo-ratio limit support */
 	case INTEL_FAM6_NEHALEM_EX:	/* Nehalem-EX Xeon - Beckton */
@@ -2509,6 +2581,13 @@ int has_nhm_turbo_ratio_limit(unsigned int family, unsigned int model)
 		return 1;
 	}
 }
+int has_atom_turbo_ratio_limit(unsigned int family, unsigned int model)
+{
+	if (has_slv_msrs(family, model))
+		return 1;
+
+	return 0;
+}
 int has_ivt_turbo_ratio_limit(unsigned int family, unsigned int model)
 {
 	if (!genuine_intel)
@@ -2606,6 +2685,9 @@ dump_cstate_pstate_config_info(unsigned int family, unsigned int model)
 	if (has_nhm_turbo_ratio_limit(family, model))
 		dump_nhm_turbo_ratio_limits();
 
+	if (has_atom_turbo_ratio_limit(family, model))
+		dump_atom_turbo_ratio_limits();
+
 	if (has_knl_turbo_ratio_limit(family, model))
 		dump_knl_turbo_ratio_limits();
 
@@ -3287,27 +3369,6 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 }
 
 /*
- * SLV client has supporet for unique MSRs:
- *
- * MSR_CC6_DEMOTION_POLICY_CONFIG
- * MSR_MC6_DEMOTION_POLICY_CONFIG
- */
-
-int has_slv_msrs(unsigned int family, unsigned int model)
-{
-	if (!genuine_intel)
-		return 0;
-
-	switch (model) {
-	case INTEL_FAM6_ATOM_SILVERMONT1:
-	case INTEL_FAM6_ATOM_MERRIFIELD:
-	case INTEL_FAM6_ATOM_MOOREFIELD:
-		return 1;
-	}
-	return 0;
-}
-
-/*
  * HSW adds support for additional MSRs:
  *
  * MSR_PKG_C8_RESIDENCY		0x00000630
-- 
2.11.0.161.g6610af872
