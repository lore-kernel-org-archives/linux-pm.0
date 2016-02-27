From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/16] tools/power turbostat: Decode MSR_MISC_PWR_MGMT
Date: Sat, 27 Feb 2016 04:00:59 -0500
Message-ID: <f0057310b40efe9f797ff337e9464e6a6fb9d782.1456563103.git.len.brown@intel.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f193.google.com ([209.85.160.193]:35863 "EHLO
	mail-yk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756219AbcB0JBx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 04:01:53 -0500
Received: by mail-yk0-f193.google.com with SMTP id z13so2786981ykd.3
        for <linux-pm@vger.kernel.org>; Sat, 27 Feb 2016 01:01:53 -0800 (PST)
In-Reply-To: <1456563670-23282-1-git-send-email-lenb@kernel.org>
In-Reply-To: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
References: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This MSR is helpful to show if P-state HW coordination
is enabled or disabled.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index af3b955..c600340 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2783,6 +2783,26 @@ void decode_misc_enable_msr(void)
 			msr & (1 << 18) ? "MONITOR" : "");
 }
 
+/*
+ * Decode MSR_MISC_PWR_MGMT
+ *
+ * Decode the bits according to the Nehalem documentation
+ * bit[0] seems to continue to have same meaning going forward
+ * bit[1] less so...
+ */
+void decode_misc_pwr_mgmt_msr(void)
+{
+	unsigned long long msr;
+
+	if (!do_nhm_platform_info)
+		return;
+
+	if (!get_msr(base_cpu, MSR_MISC_PWR_MGMT, &msr))
+		fprintf(stderr, "cpu%d: MSR_MISC_PWR_MGMT: 0x%08llx (%sable-EIST_Coordination %sable-EPB)\n",
+			base_cpu, msr,
+			msr & (1 << 0) ? "DIS" : "EN",
+			msr & (1 << 1) ? "EN" : "DIS");
+}
 
 void process_cpuid()
 {
@@ -2936,6 +2956,9 @@ void process_cpuid()
 	do_slm_cstates = is_slm(family, model);
 	do_knl_cstates  = is_knl(family, model);
 
+	if (debug)
+		decode_misc_pwr_mgmt_msr();
+
 	rapl_probe(family, model);
 	perf_limit_reasons_probe(family, model);
 
-- 
2.7.1.339.g0233b80

