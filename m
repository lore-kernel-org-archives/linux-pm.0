From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Enable HWP by default
Date: Thu, 25 Feb 2016 15:09:19 -0800
Message-ID: <1456441759-4877-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:45572 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbcBYXKx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Feb 2016 18:10:53 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

If the processor supports HWP, enable it by default without checking
for the cpu model. This will allow to enable HWP in all supported
processors without driver change.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 80ea548..0eca72a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1374,6 +1374,11 @@ static inline bool intel_pstate_platform_pwr_mgmt_exists(void) { return false; }
 static inline bool intel_pstate_has_acpi_ppc(void) { return false; }
 #endif /* CONFIG_ACPI */
 
+static const struct x86_cpu_id hwp_support_ids[] __initconst = {
+	{ X86_VENDOR_INTEL, 6, X86_MODEL_ANY, X86_FEATURE_HWP },
+	{}
+};
+
 static int __init intel_pstate_init(void)
 {
 	int cpu, rc = 0;
@@ -1383,17 +1388,16 @@ static int __init intel_pstate_init(void)
 	if (no_load)
 		return -ENODEV;
 
+	if (x86_match_cpu(hwp_support_ids) && !no_hwp) {
+		copy_cpu_funcs(&core_params.funcs);
+		hwp_active++;
+		goto hwp_cpu_matched;
+	}
+
 	id = x86_match_cpu(intel_pstate_cpu_ids);
 	if (!id)
 		return -ENODEV;
 
-	/*
-	 * The Intel pstate driver will be ignored if the platform
-	 * firmware has its own power management modes.
-	 */
-	if (intel_pstate_platform_pwr_mgmt_exists())
-		return -ENODEV;
-
 	cpu_def = (struct cpu_defaults *)id->driver_data;
 
 	copy_pid_params(&cpu_def->pid_policy);
@@ -1402,17 +1406,20 @@ static int __init intel_pstate_init(void)
 	if (intel_pstate_msrs_not_valid())
 		return -ENODEV;
 
+hwp_cpu_matched:
+	/*
+	 * The Intel pstate driver will be ignored if the platform
+	 * firmware has its own power management modes.
+	 */
+	if (intel_pstate_platform_pwr_mgmt_exists())
+		return -ENODEV;
+
 	pr_info("Intel P-state driver initializing.\n");
 
 	all_cpu_data = vzalloc(sizeof(void *) * num_possible_cpus());
 	if (!all_cpu_data)
 		return -ENOMEM;
 
-	if (static_cpu_has_safe(X86_FEATURE_HWP) && !no_hwp) {
-		pr_info("intel_pstate: HWP enabled\n");
-		hwp_active++;
-	}
-
 	if (!hwp_active && hwp_only)
 		goto out;
 
@@ -1423,6 +1430,9 @@ static int __init intel_pstate_init(void)
 	intel_pstate_debug_expose_params();
 	intel_pstate_sysfs_expose_params();
 
+	if (hwp_active)
+		pr_info("intel_pstate: HWP enabled\n");
+
 	return rc;
 out:
 	get_online_cpus();
-- 
2.5.0

