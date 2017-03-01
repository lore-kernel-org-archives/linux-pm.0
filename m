From: Len Brown <lenb@kernel.org>
Subject: [PATCH 29/44] tools/power turbostat: skip unused counters on BDX
Date: Wed,  1 Mar 2017 00:27:33 -0500
Message-ID: <ade0ebacdf03591b3dab642e6e92da60c20ebdb3.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35137 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdCAFfX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 00:35:23 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Skip these two counters on BDX, as they are always zero:
cc7, pc7

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 67a275882a8d..334c4c29d4b5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2612,6 +2612,19 @@ int is_dnv(unsigned int family, unsigned int model)
 	}
 	return 0;
 }
+int is_bdx(unsigned int family, unsigned int model)
+{
+
+	if (!genuine_intel)
+		return 0;
+
+	switch (model) {
+	case INTEL_FAM6_BROADWELL_X:
+	case INTEL_FAM6_BROADWELL_XEON_D:
+		return 1;
+	}
+	return 0;
+}
 int is_skx(unsigned int family, unsigned int model)
 {
 
@@ -3933,6 +3946,10 @@ void process_cpuid()
 		BIC_NOT_PRESENT(BIC_CPU_c7);
 		BIC_NOT_PRESENT(BIC_Pkgpc7);
 	}
+	if (is_bdx(family, model)) {
+		BIC_NOT_PRESENT(BIC_CPU_c7);
+		BIC_NOT_PRESENT(BIC_Pkgpc7);
+	}
 	if (has_hsw_msrs(family, model)) {
 		BIC_PRESENT(BIC_Pkgpc8);
 		BIC_PRESENT(BIC_Pkgpc9);
-- 
2.11.0.161.g6610af872
