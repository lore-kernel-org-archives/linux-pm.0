From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] Thermal: x86 package temp thermal crash
Date: Wed, 10 Jul 2013 22:49:23 -0700
Message-ID: <1373521763-23184-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44653 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841Ab3GKFnI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Jul 2013 01:43:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dwalker@fifo99.com
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, eduardo.valentin@ti.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On some older platform this resulted in general protection fault,
for accessing MSRs, which are not present.
Added change so that the module is loaded, only when the CPU has
PTS feature. The previous check has an issue when DTS sensor is
present but PTS is not supported.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reported-by: Daniel Walker <dwalker@fifo99.com>
---
 drivers/thermal/x86_pkg_temp_thermal.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 5de56f6..cfb6b7d 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -506,14 +506,10 @@ static int pkg_temp_thermal_device_remove(unsigned int cpu)
 
 static int get_core_online(unsigned int cpu)
 {
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct phy_dev_entry *phdev = pkg_temp_thermal_get_phy_entry(cpu);
 
 	/* Check if there is already an instance for this package */
 	if (!phdev) {
-		if (!cpu_has(c, X86_FEATURE_DTHERM) &&
-					!cpu_has(c, X86_FEATURE_PTS))
-			return -ENODEV;
 		if (pkg_temp_thermal_device_add(cpu))
 			return -ENODEV;
 	} else {
@@ -562,7 +558,7 @@ static struct notifier_block pkg_temp_thermal_notifier __refdata = {
 };
 
 static const struct x86_cpu_id __initconst pkg_temp_thermal_ids[] = {
-	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_DTHERM },
+	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_PTS },
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, pkg_temp_thermal_ids);
-- 
1.7.10.4

