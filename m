From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] thermal/powerclamp: remove cpu whitelist
Date: Thu, 17 Mar 2016 11:26:13 -0700
Message-ID: <1458239173-14896-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25707 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933192AbcCQS1n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Mar 2016 14:27:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Powerclamp works by aligning idle time to achieve package level
idle states, aka cstates. As long as one of the package cstates
is available, synchronized idle injection is meaningful.

This patch replaces the CPU whitelist with CPU feature and
package cstate counter check such that we don't have to modify
this whitelist for every new CPU.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/thermal/intel_powerclamp.c | 47 ++++++++------------------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 6c79588..015ce2e 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -510,12 +510,6 @@ static int start_power_clamp(void)
 	unsigned long cpu;
 	struct task_struct *thread;
 
-	/* check if pkg cstate counter is completely 0, abort in this case */
-	if (!has_pkg_state_counter()) {
-		pr_err("pkg cstate counter not functional, abort\n");
-		return -EINVAL;
-	}
-
 	set_target_ratio = clamp(set_target_ratio, 0U, MAX_TARGET_RATIO - 1);
 	/* prevent cpu hotplug */
 	get_online_cpus();
@@ -672,35 +666,11 @@ static struct thermal_cooling_device_ops powerclamp_cooling_ops = {
 	.set_cur_state = powerclamp_set_cur_state,
 };
 
-/* runs on Nehalem and later */
 static const struct x86_cpu_id intel_powerclamp_ids[] __initconst = {
-	{ X86_VENDOR_INTEL, 6, 0x1a},
-	{ X86_VENDOR_INTEL, 6, 0x1c},
-	{ X86_VENDOR_INTEL, 6, 0x1e},
-	{ X86_VENDOR_INTEL, 6, 0x1f},
-	{ X86_VENDOR_INTEL, 6, 0x25},
-	{ X86_VENDOR_INTEL, 6, 0x26},
-	{ X86_VENDOR_INTEL, 6, 0x2a},
-	{ X86_VENDOR_INTEL, 6, 0x2c},
-	{ X86_VENDOR_INTEL, 6, 0x2d},
-	{ X86_VENDOR_INTEL, 6, 0x2e},
-	{ X86_VENDOR_INTEL, 6, 0x2f},
-	{ X86_VENDOR_INTEL, 6, 0x37},
-	{ X86_VENDOR_INTEL, 6, 0x3a},
-	{ X86_VENDOR_INTEL, 6, 0x3c},
-	{ X86_VENDOR_INTEL, 6, 0x3d},
-	{ X86_VENDOR_INTEL, 6, 0x3e},
-	{ X86_VENDOR_INTEL, 6, 0x3f},
-	{ X86_VENDOR_INTEL, 6, 0x45},
-	{ X86_VENDOR_INTEL, 6, 0x46},
-	{ X86_VENDOR_INTEL, 6, 0x47},
-	{ X86_VENDOR_INTEL, 6, 0x4c},
-	{ X86_VENDOR_INTEL, 6, 0x4d},
-	{ X86_VENDOR_INTEL, 6, 0x4e},
-	{ X86_VENDOR_INTEL, 6, 0x4f},
-	{ X86_VENDOR_INTEL, 6, 0x56},
-	{ X86_VENDOR_INTEL, 6, 0x57},
-	{ X86_VENDOR_INTEL, 6, 0x5e},
+	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_MWAIT },
+	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_ARAT },
+	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_NONSTOP_TSC },
+	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_CONSTANT_TSC},
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
@@ -712,11 +682,12 @@ static int __init powerclamp_probe(void)
 				boot_cpu_data.x86, boot_cpu_data.x86_model);
 		return -ENODEV;
 	}
-	if (!boot_cpu_has(X86_FEATURE_NONSTOP_TSC) ||
-		!boot_cpu_has(X86_FEATURE_CONSTANT_TSC) ||
-		!boot_cpu_has(X86_FEATURE_MWAIT) ||
-		!boot_cpu_has(X86_FEATURE_ARAT))
+
+	/* The goal for idle time alignment is to achieve package cstate. */
+	if (!has_pkg_state_counter()) {
+		pr_info("No package C-state available");
 		return -ENODEV;
+	}
 
 	/* find the deepest mwait value */
 	find_target_mwait();
-- 
1.9.1

