From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/44] tools/power turbostat: skip unused counters on SKX
Date: Wed,  1 Mar 2017 00:27:31 -0500
Message-ID: <34c7619762f7b4ebbd5157b312e6022b725c031e.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33995 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdCAFjc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 00:39:32 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Skip these four counters on SKX, as they are always zero:
cc3, pc3
cc7, pc7

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1010135ee973..8c437115d41b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2584,6 +2584,18 @@ int is_dnv(unsigned int family, unsigned int model)
 	}
 	return 0;
 }
+int is_skx(unsigned int family, unsigned int model)
+{
+
+	if (!genuine_intel)
+		return 0;
+
+	switch (model) {
+	case INTEL_FAM6_SKYLAKE_X:
+		return 1;
+	}
+	return 0;
+}
 
 int has_nhm_turbo_ratio_limit(unsigned int family, unsigned int model)
 {
@@ -3871,6 +3883,12 @@ void process_cpuid()
 		BIC_NOT_PRESENT(BIC_Pkgpc7);
 		use_c1_residency_msr = 1;
 	}
+	if (is_skx(family, model)) {
+		BIC_NOT_PRESENT(BIC_CPU_c3);
+		BIC_NOT_PRESENT(BIC_Pkgpc3);
+		BIC_NOT_PRESENT(BIC_CPU_c7);
+		BIC_NOT_PRESENT(BIC_Pkgpc7);
+	}
 	if (has_hsw_msrs(family, model)) {
 		BIC_PRESENT(BIC_Pkgpc8);
 		BIC_PRESENT(BIC_Pkgpc9);
-- 
2.11.0.161.g6610af872
