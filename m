From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 10/34] Thermal: Introduce fair_share thermal governor
Date: Sun,  2 Dec 2012 22:44:44 +0800
Message-ID: <1354459508-3707-10-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:6656 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441Ab2LBOpg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:36 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch introduces a simple 'weight' based
governor named fair_share governor. Whenever the
thermal framework gets notified of the trip point
violation, this governor (if configured), throttles
the cooling devices associated with a thermal zone.

This mapping between a thermal zone and a cooling device
and the effectiveness of cooling are provided in the
platform layer.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/Kconfig      |    6 ++
 drivers/thermal/Makefile     |    1 +
 drivers/thermal/fair_share.c |  133 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 0 deletions(-)
 create mode 100644 drivers/thermal/fair_share.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e1cb6bd..84b0f03 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -55,3 +55,9 @@ config EXYNOS_THERMAL
 	help
 	  If you say yes here you get support for TMU (Thermal Managment
 	  Unit) on SAMSUNG EXYNOS series of SoC.
+
+config FAIR_SHARE
+	bool "Fair-share thermal governor"
+	depends on THERMAL
+	help
+	  Enable this to manage platform thermals using fair-share governor.
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 885550d..30540dd 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_CPU_THERMAL)		+= cpu_cooling.o
 obj-$(CONFIG_SPEAR_THERMAL)		+= spear_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
 obj-$(CONFIG_EXYNOS_THERMAL)		+= exynos_thermal.o
+obj-$(CONFIG_FAIR_SHARE)		+= fair_share.o
diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
new file mode 100644
index 0000000..5d3a7a3
--- /dev/null
+++ b/drivers/thermal/fair_share.c
@@ -0,0 +1,133 @@
+/*
+ *  fair_share.c - A simple weight based Thermal governor
+ *
+ *  Copyright (C) 2012 Intel Corp
+ *  Copyright (C) 2012 Durgadoss R <durgadoss.r@intel.com>
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/thermal.h>
+
+#include "thermal_core.h"
+
+/**
+ * get_trip_level: - obtains the current trip level for a zone
+ * @tz:		thermal zone device
+ */
+static int get_trip_level(struct thermal_zone_device *tz)
+{
+	int count = 0;
+	unsigned long trip_temp;
+
+	if (tz->trips == 0 || !tz->ops->get_trip_temp)
+		return 0;
+
+	for (count = 0; count < tz->trips; count++) {
+		tz->ops->get_trip_temp(tz, count, &trip_temp);
+		if (tz->temperature < trip_temp)
+			break;
+	}
+	return count;
+}
+
+static long get_target_state(struct thermal_zone_device *tz,
+		struct thermal_cooling_device *cdev, int weight, int level)
+{
+	unsigned long max_state;
+
+	cdev->ops->get_max_state(cdev, &max_state);
+
+	return (long)(weight * level * max_state) / (100 * tz->trips);
+}
+
+/**
+ * fair_share_throttle - throttles devices asscciated with the given zone
+ * @tz - thermal_zone_device
+ *
+ * Throttling Logic: This uses three parameters to calculate the new
+ * throttle state of the cooling devices associated with the given zone.
+ *
+ * Parameters used for Throttling:
+ * P1. max_state: Maximum throttle state exposed by the cooling device.
+ * P2. weight[i]/100:
+ *	How 'effective' the 'i'th device is, in cooling the given zone.
+ * P3. cur_trip_level/max_no_of_trips:
+ *	This describes the extent to which the devices should be throttled.
+ *	We do not want to throttle too much when we trip a lower temperature,
+ *	whereas the throttling is at full swing if we trip critical levels.
+ *	(Heavily assumes the trip points are in ascending order)
+ * new_state of cooling device = P3 * P2 * P1
+ */
+int fair_share_throttle(struct thermal_zone_device *tz, int trip)
+{
+	const struct thermal_zone_params *tzp;
+	struct thermal_cooling_device *cdev;
+	struct thermal_instance *instance;
+	int i;
+	int cur_trip_level = get_trip_level(tz);
+
+	if (!tz->tzp || !tz->tzp->tbp)
+		return -EINVAL;
+
+	tzp = tz->tzp;
+
+	for (i = 0; i < tzp->num_tbps; i++) {
+		if (!tzp->tbp[i].cdev)
+			continue;
+
+		cdev = tzp->tbp[i].cdev;
+		instance = get_thermal_instance(tz, cdev, trip);
+		if (!instance)
+			continue;
+
+		instance->target = get_target_state(tz, cdev,
+					tzp->tbp[i].weight, cur_trip_level);
+
+		instance->cdev->updated = false;
+		thermal_cdev_update(cdev);
+	}
+	return 0;
+}
+
+struct thermal_governor thermal_gov_fair_share = {
+	.name		= "fair_share",
+	.throttle	= fair_share_throttle,
+	.owner		= THIS_MODULE,
+};
+
+static int __init thermal_gov_fair_share_init(void)
+{
+	return thermal_register_governor(&thermal_gov_fair_share);
+}
+
+static void __exit thermal_gov_fair_share_exit(void)
+{
+	thermal_unregister_governor(&thermal_gov_fair_share);
+}
+
+/* This should load after thermal framework */
+fs_initcall(thermal_gov_fair_share_init);
+module_exit(thermal_gov_fair_share_exit);
+
+MODULE_AUTHOR("Durgadoss R");
+MODULE_DESCRIPTION("A simple weight based thermal throttling governor");
+MODULE_LICENSE("GPL");
-- 
1.7.7.6

