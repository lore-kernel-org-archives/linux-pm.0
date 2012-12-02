From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 14/34] Thermal: Add a notification API
Date: Sun,  2 Dec 2012 22:44:48 +0800
Message-ID: <1354459508-3707-14-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:6656 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770Ab2LBOpi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:38 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch adds a notification API which the sensor drivers'
can use to notify the framework. The framework then takes
care of the throttling according to the configured policy.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |   18 ++++++++++++++++++
 include/linux/thermal.h       |    1 +
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 64f3e97..a69f24c 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1369,6 +1369,24 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 EXPORT_SYMBOL(thermal_cdev_update);
 
 /**
+ * notify_thermal_framework - Sensor drivers use this API to notify framework
+ * @tz:		thermal zone device
+ * @trip:	indicates which trip point has been crossed
+ *
+ * This function handles the trip events from sensor drivers. It starts
+ * throttling the cooling devices according to the policy configured.
+ * For CRITICAL and HOT trip points, this notifies the respective drivers,
+ * and does actual throttling for other trip points i.e ACTIVE and PASSIVE.
+ * The throttling policy is based on the configured platform data; if no
+ * platform data is provided, this uses the step_wise throttling policy.
+ */
+void notify_thermal_framework(struct thermal_zone_device *tz, int trip)
+{
+	handle_thermal_trip(tz, trip);
+}
+EXPORT_SYMBOL(notify_thermal_framework);
+
+/**
  * create_trip_attrs - create attributes for trip points
  * @tz:		the thermal zone device
  * @mask:	Writeable trip point bitmap.
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 2bd9158..807f214 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -232,6 +232,7 @@ int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
 		struct thermal_cooling_device *, int);
 void thermal_cdev_update(struct thermal_cooling_device *);
+void notify_thermal_framework(struct thermal_zone_device *, int);
 
 int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
-- 
1.7.7.6

