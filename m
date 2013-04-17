From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] Thermal: thermal API cleanup
Date: Wed, 17 Apr 2013 23:18:40 +0800
Message-ID: <1366211920.2091.55.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2827 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754462Ab3DQPSq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Apr 2013 11:18:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: eduardo <eduardo.valentin@ti.com>, "Zhang, Rui" <rui.zhang@intel.com>

>From d6db6ba9831d07338e11d4821febec4ef3cdf8f6 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Wed, 17 Apr 2013 23:12:40 +0800
Subject: [PATCH] Thermal: thermal API cleanup

We build all the thermal governors into thermal module,
thus a couple of APIs should be cleaned up as they are used
by thermal governors only.

Cleanup for get_tz_trend(), get_thermal_instance(),
and thermal_cdev_update(), in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/thermal/sysfs-api.txt |   19 +------------------
 drivers/thermal/thermal_core.c      |    3 ---
 drivers/thermal/thermal_core.h      |    5 +++++
 include/linux/thermal.h             |    4 ----
 4 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index b2ffe98..4dcc4c7 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -355,27 +355,10 @@ crosses any of the configured thresholds.
 
 5. Export Symbol APIs:
 
-5.1: get_tz_trend:
-This function returns the trend of a thermal zone, i.e the rate of change
-of temperature of the thermal zone. Ideally, the thermal sensor drivers
-are supposed to implement the callback. If they don't, the thermal
-framework calculated the trend by comparing the previous and the current
-temperature values.
-
-5.2:get_thermal_instance:
-This function returns the thermal_instance corresponding to a given
-{thermal_zone, cooling_device, trip_point} combination. Returns NULL
-if such an instance does not exist.
-
-5.3:notify_thermal_framework:
+5.1:notify_thermal_framework:
 This function handles the trip events from sensor drivers. It starts
 throttling the cooling devices according to the policy configured.
 For CRITICAL and HOT trip points, this notifies the respective drivers,
 and does actual throttling for other trip points i.e ACTIVE and PASSIVE.
 The throttling policy is based on the configured platform data; if no
 platform data is provided, this uses the step_wise throttling policy.
-
-5.4:thermal_cdev_update:
-This function serves as an arbitrator to set the state of a cooling
-device. It sets the cooling device to the deepest cooling state if
-possible.
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4cdc3e3..ac380fc 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -166,7 +166,6 @@ int get_tz_trend(struct thermal_zone_device *tz, int trip)
 
 	return trend;
 }
-EXPORT_SYMBOL(get_tz_trend);
 
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *tz,
 			struct thermal_cooling_device *cdev, int trip)
@@ -189,7 +188,6 @@ struct thermal_instance *get_thermal_instance(struct thermal_zone_device *tz,
 
 	return target_instance;
 }
-EXPORT_SYMBOL(get_thermal_instance);
 
 static void print_bind_err_msg(struct thermal_zone_device *tz,
 			struct thermal_cooling_device *cdev, int ret)
@@ -1415,7 +1413,6 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	cdev->ops->set_cur_state(cdev, target);
 	cdev->updated = true;
 }
-EXPORT_SYMBOL(thermal_cdev_update);
 
 /**
  * notify_thermal_framework - Sensor drivers use this API to notify framework
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 7cf2f66..0bb98d2 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -50,6 +50,11 @@ struct thermal_instance {
 	struct list_head cdev_node; /* node in cdev->thermal_instances */
 };
 
+int get_tz_trend(struct thermal_zone_device *, int);
+struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
+                struct thermal_cooling_device *, int);
+void thermal_cdev_update(struct thermal_cooling_device *);
+
 int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 4445b95..097e674 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -240,10 +240,6 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 		const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 
-int get_tz_trend(struct thermal_zone_device *, int);
-struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
-		struct thermal_cooling_device *, int);
-void thermal_cdev_update(struct thermal_cooling_device *);
 void notify_thermal_framework(struct thermal_zone_device *, int);
 
 #ifdef CONFIG_NET
-- 
1.7.9.5



