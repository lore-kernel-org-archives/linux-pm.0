From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [Update][PATCH 4/4] cpufreq: intel_pstate: Calculate guaranteed performance for HWP
Date: Thu, 19 Jan 2017 15:03:14 -0800
Message-ID: <1484866994-27056-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:4586 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbdASXGq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Jan 2017 18:06:46 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When HWP is active, turbo activation ratio is not used to calculate max
non turbo ratio. But on these systems the max non turbo ratio is decided
by config TDP settings.

This change removes usage of MSR_TURBO_ACTIVATION_RATIO for HWP systems,
instead directly use TDP ratios, when more than one TDPs are available.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Change:
- Fix bug when TDP is locked, need to mask lock bit before compare.

 drivers/cpufreq/intel_pstate.c | 75 +++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 095bcaf..5639a89 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1343,48 +1343,71 @@ static int core_get_max_pstate_physical(void)
 	return (value >> 8) & 0xFF;
 }
 
+static int core_get_tdp_ratio(u64 plat_info)
+{
+	/* Check how many TDP levels present */
+	if (plat_info & 0x600000000) {
+		u64 tdp_ctrl;
+		u64 tdp_ratio;
+		int tdp_msr;
+		int err;
+
+		/* Get the TDP level (0, 1, 2) to get ratios */
+		err = rdmsrl_safe(MSR_CONFIG_TDP_CONTROL, &tdp_ctrl);
+		if (err)
+			return err;
+
+		/* TDP MSR are continuous starting at 0x648 */
+		tdp_msr = MSR_CONFIG_TDP_NOMINAL + (tdp_ctrl & 0x03);
+		err = rdmsrl_safe(tdp_msr, &tdp_ratio);
+		if (err)
+			return err;
+
+		/* For level 1 and 2, bits[23:16] contain the ratio */
+		if (tdp_ctrl & 0x03)
+			tdp_ratio >>= 16;
+
+		tdp_ratio &= 0xff; /* ratios are only 8 bits long */
+		pr_debug("tdp_ratio %x\n", (int)tdp_ratio);
+
+		return (int)tdp_ratio;
+	}
+
+	return -ENXIO;
+}
+
 static int core_get_max_pstate(void)
 {
 	u64 tar;
 	u64 plat_info;
 	int max_pstate;
+	int tdp_ratio;
 	int err;
 
 	rdmsrl(MSR_PLATFORM_INFO, plat_info);
 	max_pstate = (plat_info >> 8) & 0xFF;
 
+	tdp_ratio = core_get_tdp_ratio(plat_info);
+	if (tdp_ratio <= 0)
+		return max_pstate;
+
+	if (hwp_active) {
+		/* Turbo activation ratio is not used on HWP platforms */
+		return tdp_ratio;
+	}
+
 	err = rdmsrl_safe(MSR_TURBO_ACTIVATION_RATIO, &tar);
 	if (!err) {
+		int tar_levels;
+
 		/* Do some sanity checking for safety */
-		if (plat_info & 0x600000000) {
-			u64 tdp_ctrl;
-			u64 tdp_ratio;
-			int tdp_msr;
-
-			err = rdmsrl_safe(MSR_CONFIG_TDP_CONTROL, &tdp_ctrl);
-			if (err)
-				goto skip_tar;
-
-			tdp_msr = MSR_CONFIG_TDP_NOMINAL + (tdp_ctrl & 0x3);
-			err = rdmsrl_safe(tdp_msr, &tdp_ratio);
-			if (err)
-				goto skip_tar;
-
-			/* For level 1 and 2, bits[23:16] contain the ratio */
-			if (tdp_ctrl)
-				tdp_ratio >>= 16;
-
-			tdp_ratio &= 0xff; /* ratios are only 8 bits long */
-			if (tdp_ratio - 1 == tar) {
-				max_pstate = tar;
-				pr_debug("max_pstate=TAC %x\n", max_pstate);
-			} else {
-				goto skip_tar;
-			}
+		tar_levels = tar & 0xff;
+		if (tdp_ratio - 1 == tar_levels) {
+			max_pstate = tar_levels;
+			pr_debug("max_pstate=TAC %x\n", max_pstate);
 		}
 	}
 
-skip_tar:
 	return max_pstate;
 }
 
-- 
2.7.4

