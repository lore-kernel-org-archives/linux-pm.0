From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] Thermal: x86_pkg_temp: Limit number of pkg temp zones
Date: Mon, 15 Jul 2013 15:38:52 -0700
Message-ID: <1373927932-26176-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59278 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758296Ab3GOWc3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Jul 2013 18:32:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: eduardo.valentin@ti.com, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Although it is unlikley that physical package id is set to some
arbitary number, it is better to prevent in anycase. Since package
temp zones use this in thermal zone type and for allocation, added
a limit.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/x86_pkg_temp_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index cf172d5..810143a 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -54,6 +54,8 @@ MODULE_PARM_DESC(notify_delay_ms,
 * is some wrong values returned by cpuid for number of thresholds.
 */
 #define MAX_NUMBER_OF_TRIPS	2
+/* Limit number of package temp zones */
+#define MAX_PKG_TEMP_ZONE_IDS	256
 
 struct phy_dev_entry {
 	struct list_head list;
@@ -401,6 +403,9 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	if (!thres_count)
 		return -ENODEV;
 
+	if (topology_physical_package_id(cpu) > MAX_PKG_TEMP_ZONE_IDS)
+		return -ENODEV;
+
 	thres_count = clamp_val(thres_count, 0, MAX_NUMBER_OF_TRIPS);
 
 	err = get_tj_max(cpu, &tj_max);
-- 
1.7.11.7

