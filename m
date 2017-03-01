From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/44] tools/power turbostat: decode Baytrail CC6 and MC6 demotion configuration
Date: Wed,  1 Mar 2017 00:27:08 -0500
Message-ID: <71616c8e936a6dd541f0627d7bf4ff09971d8ccb.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35937 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbdCAH2R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 02:28:17 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

with --debug, see:

cpu0: MSR_CC6_DEMOTION_POLICY_CONFIG: 0x00000000 (DISable-CC6-Demotion)
cpu0: MSR_MC6_DEMOTION_POLICY_CONFIG: 0x00000000 (DISable-MC6-Demotion)

Note that the hardware default is to enable demotion,
and Linux started clearing these registers in 3.17.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index fdf0273465fa..1b762f67e3e2 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3263,6 +3263,27 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 }
 
 /*
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
+/*
  * HSW adds support for additional MSRs:
  *
  * MSR_PKG_C8_RESIDENCY		0x00000630
@@ -3496,6 +3517,24 @@ void decode_misc_pwr_mgmt_msr(void)
 			msr & (1 << 1) ? "EN" : "DIS",
 			msr & (1 << 8) ? "EN" : "DIS");
 }
+/*
+ * Decode MSR_CC6_DEMOTION_POLICY_CONFIG, MSR_MC6_DEMOTION_POLICY_CONFIG
+ *
+ * This MSRs are present on Silvermont processors,
+ * Intel Atom processor E3000 series (Baytrail), and friends.
+ */
+void decode_c6_demotion_policy_msr(void)
+{
+	unsigned long long msr;
+
+	if (!get_msr(base_cpu, MSR_CC6_DEMOTION_POLICY_CONFIG, &msr))
+		fprintf(outf, "cpu%d: MSR_CC6_DEMOTION_POLICY_CONFIG: 0x%08llx (%sable-CC6-Demotion)\n",
+			base_cpu, msr, msr & (1 << 0) ? "EN" : "DIS");
+
+	if (!get_msr(base_cpu, MSR_MC6_DEMOTION_POLICY_CONFIG, &msr))
+		fprintf(outf, "cpu%d: MSR_MC6_DEMOTION_POLICY_CONFIG: 0x%08llx (%sable-MC6-Demotion)\n",
+			base_cpu, msr, msr & (1 << 0) ? "EN" : "DIS");
+}
 
 void process_cpuid()
 {
@@ -3700,6 +3739,9 @@ void process_cpuid()
 	if (debug)
 		decode_misc_pwr_mgmt_msr();
 
+	if (debug && has_slv_msrs(family, model))
+		decode_c6_demotion_policy_msr();
+
 	rapl_probe(family, model);
 	perf_limit_reasons_probe(family, model);
 
-- 
2.11.0.161.g6610af872
