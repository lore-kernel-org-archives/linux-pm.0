From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] intel_pstate: Add support for Gemini Lake
Date: Wed, 29 Mar 2017 09:45:57 -0700
Message-ID: <1490805957-4268-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:13555 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751603AbdC2QqR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Mar 2017 12:46:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, "Box, David E" <david.e.box@intel.com>, Box@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: "Box, David E" <david.e.box@intel.com>

Use same parameters as INTEL_FAM6_ATOM_GOLDMONT to enable
Gemini Lake.

Signed-off-by: Box, David E <david.e.box@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b62daf5..c31b72b 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1861,6 +1861,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_funcs),
 	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		bxt_funcs),
+	ICPU(INTEL_FAM6_ATOM_GEMINI_LAKE,       bxt_funcs),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
-- 
2.7.4
