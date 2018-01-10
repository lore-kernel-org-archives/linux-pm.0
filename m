From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] cpufreq: intel_pstate: Replace bxt_funcs with core_funcs
Date: Wed, 10 Jan 2018 11:38:51 -0800
Message-ID: <20180110193852.63667-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:38251 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753628AbeAJTiz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jan 2018 14:38:55 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Since core_funcs and bxt_funcs have same set of callbacks, replace
bxt_funcs with core_funcs.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 93a0e88bef76..3b6616b15c59 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1595,15 +1595,6 @@ static const struct pstate_funcs knl_funcs = {
 	.get_val = core_get_val,
 };
 
-static const struct pstate_funcs bxt_funcs = {
-	.get_max = core_get_max_pstate,
-	.get_max_physical = core_get_max_pstate_physical,
-	.get_min = core_get_min_pstate,
-	.get_turbo = core_get_turbo_pstate,
-	.get_scaling = core_get_scaling,
-	.get_val = core_get_val,
-};
-
 #define ICPU(model, policy) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF,\
 			(unsigned long)&policy }
@@ -1627,8 +1618,8 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_funcs),
-	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		bxt_funcs),
-	ICPU(INTEL_FAM6_ATOM_GEMINI_LAKE,       bxt_funcs),
+	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		core_funcs),
+	ICPU(INTEL_FAM6_ATOM_GEMINI_LAKE,       core_funcs),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
-- 
2.13.6
