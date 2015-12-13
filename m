From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2] tools/power turbostat: bugfix: TDP MSRs print bits fixing
Date: Sun, 13 Dec 2015 21:09:31 +0800
Message-ID: <a941ab01b962ac057bd67d3bb397fe41ac548b79.1450011064.git.yu.c.chen@intel.com>
References: <cover.1450011064.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30889 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869AbbLMNEk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 13 Dec 2015 08:04:40 -0500
In-Reply-To: <cover.1450011064.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: len.brown@intel.com
Cc: rjw@rjwysocki.net, srinivas.pandruvada@intel.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

MSR_CONFIG_TDP_NOMINAL:
should print all 8 bits of base_ratio (bit 0:7) 0xFF

MSR_CONFIG_TDP_LEVEL_1:
should print all 15 bits of PKG_MIN_PWR_LVL1 (bit 48:62) 0x7FFF
should print all 15 bits of PKG_MAX_PWR_LVL1 (bit 32:46) 0x7FFF
should print all 8 bits of LVL1_RATIO (bit 16:23) 0xFF
should print all 15 bits of PKG_TDP_LVL1 (bit 0:14) 0x7FFF

And the same modification to MSR_CONFIG_TDP_LEVEL_2.

MSR_TURBO_ACTIVATION_RATIO:
should print all 8 bits of MAX_NON_TURBO_RATIO (bit 0:7) 0xFF

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0dac7e0..9854929 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1409,25 +1409,25 @@ dump_config_tdp(void)
 
 	get_msr(base_cpu, MSR_CONFIG_TDP_NOMINAL, &msr);
 	fprintf(stderr, "cpu%d: MSR_CONFIG_TDP_NOMINAL: 0x%08llx", base_cpu, msr);
-	fprintf(stderr, " (base_ratio=%d)\n", (unsigned int)msr & 0xEF);
+	fprintf(stderr, " (base_ratio=%d)\n", (unsigned int)msr & 0xFF);
 
 	get_msr(base_cpu, MSR_CONFIG_TDP_LEVEL_1, &msr);
 	fprintf(stderr, "cpu%d: MSR_CONFIG_TDP_LEVEL_1: 0x%08llx (", base_cpu, msr);
 	if (msr) {
-		fprintf(stderr, "PKG_MIN_PWR_LVL1=%d ", (unsigned int)(msr >> 48) & 0xEFFF);
-		fprintf(stderr, "PKG_MAX_PWR_LVL1=%d ", (unsigned int)(msr >> 32) & 0xEFFF);
-		fprintf(stderr, "LVL1_RATIO=%d ", (unsigned int)(msr >> 16) & 0xEF);
-		fprintf(stderr, "PKG_TDP_LVL1=%d", (unsigned int)(msr) & 0xEFFF);
+		fprintf(stderr, "PKG_MIN_PWR_LVL1=%d ", (unsigned int)(msr >> 48) & 0x7FFF);
+		fprintf(stderr, "PKG_MAX_PWR_LVL1=%d ", (unsigned int)(msr >> 32) & 0x7FFF);
+		fprintf(stderr, "LVL1_RATIO=%d ", (unsigned int)(msr >> 16) & 0xFF);
+		fprintf(stderr, "PKG_TDP_LVL1=%d", (unsigned int)(msr) & 0x7FFF);
 	}
 	fprintf(stderr, ")\n");
 
 	get_msr(base_cpu, MSR_CONFIG_TDP_LEVEL_2, &msr);
 	fprintf(stderr, "cpu%d: MSR_CONFIG_TDP_LEVEL_2: 0x%08llx (", base_cpu, msr);
 	if (msr) {
-		fprintf(stderr, "PKG_MIN_PWR_LVL2=%d ", (unsigned int)(msr >> 48) & 0xEFFF);
-		fprintf(stderr, "PKG_MAX_PWR_LVL2=%d ", (unsigned int)(msr >> 32) & 0xEFFF);
-		fprintf(stderr, "LVL2_RATIO=%d ", (unsigned int)(msr >> 16) & 0xEF);
-		fprintf(stderr, "PKG_TDP_LVL2=%d", (unsigned int)(msr) & 0xEFFF);
+		fprintf(stderr, "PKG_MIN_PWR_LVL2=%d ", (unsigned int)(msr >> 48) & 0x7FFF);
+		fprintf(stderr, "PKG_MAX_PWR_LVL2=%d ", (unsigned int)(msr >> 32) & 0x7FFF);
+		fprintf(stderr, "LVL2_RATIO=%d ", (unsigned int)(msr >> 16) & 0xFF);
+		fprintf(stderr, "PKG_TDP_LVL2=%d", (unsigned int)(msr) & 0x7FFF);
 	}
 	fprintf(stderr, ")\n");
 
@@ -1440,7 +1440,7 @@ dump_config_tdp(void)
 	
 	get_msr(base_cpu, MSR_TURBO_ACTIVATION_RATIO, &msr);
 	fprintf(stderr, "cpu%d: MSR_TURBO_ACTIVATION_RATIO: 0x%08llx (", base_cpu, msr);
-	fprintf(stderr, "MAX_NON_TURBO_RATIO=%d", (unsigned int)(msr) & 0x7F);
+	fprintf(stderr, "MAX_NON_TURBO_RATIO=%d", (unsigned int)(msr) & 0xFF);
 	fprintf(stderr, " lock=%d", (unsigned int)(msr >> 31) & 1);
 	fprintf(stderr, ")\n");
 }
-- 
1.8.4.2

