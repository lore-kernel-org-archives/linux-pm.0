From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 26/49] thermal: core: introduce thermal_helpers.c
Date: Mon,  7 Nov 2016 21:09:04 -0800
Message-ID: <1478581767-7009-27-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36403 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753391AbcKHFaN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 00:30:13 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Here we have a simple code organization. This patch moves
functions that do not need to handle thermal core internal
data structure to thermal_helpers.c file.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Makefile          |   3 +-
 drivers/thermal/thermal_core.c    | 170 ---------------------------------
 drivers/thermal/thermal_helpers.c | 196 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 171 deletions(-)
 create mode 100644 drivers/thermal/thermal_helpers.c

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 767c3c9..6a3d7b5 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -3,7 +3,8 @@
 #
 
 obj-$(CONFIG_THERMAL)		+= thermal_sys.o
-thermal_sys-y			+= thermal_core.o thermal_sysfs.o
+thermal_sys-y			+= thermal_core.o thermal_sysfs.o \
+					thermal_helpers.o
 
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3a189fd..519aa94 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -230,48 +230,6 @@ static void release_idr(struct idr *idr, struct mutex *lock, int id)
 		mutex_unlock(lock);
 }
 
-int get_tz_trend(struct thermal_zone_device *tz, int trip)
-{
-	enum thermal_trend trend;
-
-	if (tz->emul_temperature || !tz->ops->get_trend ||
-	    tz->ops->get_trend(tz, trip, &trend)) {
-		if (tz->temperature > tz->last_temperature)
-			trend = THERMAL_TREND_RAISING;
-		else if (tz->temperature < tz->last_temperature)
-			trend = THERMAL_TREND_DROPPING;
-		else
-			trend = THERMAL_TREND_STABLE;
-	}
-
-	return trend;
-}
-EXPORT_SYMBOL(get_tz_trend);
-
-struct thermal_instance *
-get_thermal_instance(struct thermal_zone_device *tz,
-		     struct thermal_cooling_device *cdev, int trip)
-{
-	struct thermal_instance *pos = NULL;
-	struct thermal_instance *target_instance = NULL;
-
-	mutex_lock(&tz->lock);
-	mutex_lock(&cdev->lock);
-
-	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
-		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
-			target_instance = pos;
-			break;
-		}
-	}
-
-	mutex_unlock(&cdev->lock);
-	mutex_unlock(&tz->lock);
-
-	return target_instance;
-}
-EXPORT_SYMBOL(get_thermal_instance);
-
 static void print_bind_err_msg(struct thermal_zone_device *tz,
 			struct thermal_cooling_device *cdev, int ret)
 {
@@ -472,105 +430,6 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	monitor_thermal_zone(tz);
 }
 
-/**
- * thermal_zone_get_temp() - returns the temperature of a thermal zone
- * @tz: a valid pointer to a struct thermal_zone_device
- * @temp: a valid pointer to where to store the resulting temperature.
- *
- * When a valid thermal zone reference is passed, it will fetch its
- * temperature and fill @temp.
- *
- * Return: On success returns 0, an error code otherwise
- */
-int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
-{
-	int ret = -EINVAL;
-	int count;
-	int crit_temp = INT_MAX;
-	enum thermal_trip_type type;
-
-	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
-		goto exit;
-
-	mutex_lock(&tz->lock);
-
-	ret = tz->ops->get_temp(tz, temp);
-
-	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
-		for (count = 0; count < tz->trips; count++) {
-			ret = tz->ops->get_trip_type(tz, count, &type);
-			if (!ret && type == THERMAL_TRIP_CRITICAL) {
-				ret = tz->ops->get_trip_temp(tz, count,
-						&crit_temp);
-				break;
-			}
-		}
-
-		/*
-		 * Only allow emulating a temperature when the real temperature
-		 * is below the critical temperature so that the emulation code
-		 * cannot hide critical conditions.
-		 */
-		if (!ret && *temp < crit_temp)
-			*temp = tz->emul_temperature;
-	}
-
-	mutex_unlock(&tz->lock);
-exit:
-	return ret;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
-
-void thermal_zone_set_trips(struct thermal_zone_device *tz)
-{
-	int low = -INT_MAX;
-	int high = INT_MAX;
-	int trip_temp, hysteresis;
-	int i, ret;
-
-	mutex_lock(&tz->lock);
-
-	if (!tz->ops->set_trips || !tz->ops->get_trip_hyst)
-		goto exit;
-
-	for (i = 0; i < tz->trips; i++) {
-		int trip_low;
-
-		tz->ops->get_trip_temp(tz, i, &trip_temp);
-		tz->ops->get_trip_hyst(tz, i, &hysteresis);
-
-		trip_low = trip_temp - hysteresis;
-
-		if (trip_low < tz->temperature && trip_low > low)
-			low = trip_low;
-
-		if (trip_temp > tz->temperature && trip_temp < high)
-			high = trip_temp;
-	}
-
-	/* No need to change trip points */
-	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
-		goto exit;
-
-	tz->prev_low_trip = low;
-	tz->prev_high_trip = high;
-
-	dev_dbg(&tz->device,
-		"new temperature boundaries: %d < x < %d\n", low, high);
-
-	/*
-	 * Set a temperature window. When this window is left the driver
-	 * must inform the thermal core via thermal_zone_device_update.
-	 */
-	ret = tz->ops->set_trips(tz, low, high);
-	if (ret)
-		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
-
-exit:
-	mutex_unlock(&tz->lock);
-}
-EXPORT_SYMBOL_GPL(thermal_zone_set_trips);
-
 static void update_temperature(struct thermal_zone_device *tz)
 {
 	int temp, ret;
@@ -1178,35 +1037,6 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
-void thermal_cdev_update(struct thermal_cooling_device *cdev)
-{
-	struct thermal_instance *instance;
-	unsigned long target = 0;
-
-	mutex_lock(&cdev->lock);
-	/* cooling device is updated*/
-	if (cdev->updated) {
-		mutex_unlock(&cdev->lock);
-		return;
-	}
-
-	/* Make sure cdev enters the deepest cooling state */
-	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
-		dev_dbg(&cdev->device, "zone%d->target=%lu\n",
-			instance->tz->id, instance->target);
-		if (instance->target == THERMAL_NO_TARGET)
-			continue;
-		if (instance->target > target)
-			target = instance->target;
-	}
-	cdev->ops->set_cur_state(cdev, target);
-	cdev->updated = true;
-	mutex_unlock(&cdev->lock);
-	trace_cdev_update(cdev, target);
-	dev_dbg(&cdev->device, "set to state %lu\n", target);
-}
-EXPORT_SYMBOL(thermal_cdev_update);
-
 /**
  * thermal_notify_framework - Sensor drivers use this API to notify framework
  * @tz:		thermal zone device
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
new file mode 100644
index 0000000..dfdba5a
--- /dev/null
+++ b/drivers/thermal/thermal_helpers.c
@@ -0,0 +1,196 @@
+/*
+ *  thermal_helpers.c - helper functions to handle thermal devices
+ *
+ *  Copyright (C) 2016 Eduardo Valentin <edubezval@gmail.com>
+ *
+ *  Highly based on original thermal_core.c
+ *  Copyright (C) 2008 Intel Corp
+ *  Copyright (C) 2008 Zhang Rui <rui.zhang@intel.com>
+ *  Copyright (C) 2008 Sujith Thomas <sujith.thomas@intel.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/sysfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include <trace/events/thermal.h>
+
+#include "thermal_core.h"
+
+int get_tz_trend(struct thermal_zone_device *tz, int trip)
+{
+	enum thermal_trend trend;
+
+	if (tz->emul_temperature || !tz->ops->get_trend ||
+	    tz->ops->get_trend(tz, trip, &trend)) {
+		if (tz->temperature > tz->last_temperature)
+			trend = THERMAL_TREND_RAISING;
+		else if (tz->temperature < tz->last_temperature)
+			trend = THERMAL_TREND_DROPPING;
+		else
+			trend = THERMAL_TREND_STABLE;
+	}
+
+	return trend;
+}
+EXPORT_SYMBOL(get_tz_trend);
+
+struct thermal_instance *
+get_thermal_instance(struct thermal_zone_device *tz,
+		     struct thermal_cooling_device *cdev, int trip)
+{
+	struct thermal_instance *pos = NULL;
+	struct thermal_instance *target_instance = NULL;
+
+	mutex_lock(&tz->lock);
+	mutex_lock(&cdev->lock);
+
+	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
+		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
+			target_instance = pos;
+			break;
+		}
+	}
+
+	mutex_unlock(&cdev->lock);
+	mutex_unlock(&tz->lock);
+
+	return target_instance;
+}
+EXPORT_SYMBOL(get_thermal_instance);
+
+/**
+ * thermal_zone_get_temp() - returns the temperature of a thermal zone
+ * @tz: a valid pointer to a struct thermal_zone_device
+ * @temp: a valid pointer to where to store the resulting temperature.
+ *
+ * When a valid thermal zone reference is passed, it will fetch its
+ * temperature and fill @temp.
+ *
+ * Return: On success returns 0, an error code otherwise
+ */
+int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	int ret = -EINVAL;
+	int count;
+	int crit_temp = INT_MAX;
+	enum thermal_trip_type type;
+
+	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
+		goto exit;
+
+	mutex_lock(&tz->lock);
+
+	ret = tz->ops->get_temp(tz, temp);
+
+	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
+		for (count = 0; count < tz->trips; count++) {
+			ret = tz->ops->get_trip_type(tz, count, &type);
+			if (!ret && type == THERMAL_TRIP_CRITICAL) {
+				ret = tz->ops->get_trip_temp(tz, count,
+						&crit_temp);
+				break;
+			}
+		}
+
+		/*
+		 * Only allow emulating a temperature when the real temperature
+		 * is below the critical temperature so that the emulation code
+		 * cannot hide critical conditions.
+		 */
+		if (!ret && *temp < crit_temp)
+			*temp = tz->emul_temperature;
+	}
+
+	mutex_unlock(&tz->lock);
+exit:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
+
+void thermal_zone_set_trips(struct thermal_zone_device *tz)
+{
+	int low = -INT_MAX;
+	int high = INT_MAX;
+	int trip_temp, hysteresis;
+	int i, ret;
+
+	mutex_lock(&tz->lock);
+
+	if (!tz->ops->set_trips || !tz->ops->get_trip_hyst)
+		goto exit;
+
+	for (i = 0; i < tz->trips; i++) {
+		int trip_low;
+
+		tz->ops->get_trip_temp(tz, i, &trip_temp);
+		tz->ops->get_trip_hyst(tz, i, &hysteresis);
+
+		trip_low = trip_temp - hysteresis;
+
+		if (trip_low < tz->temperature && trip_low > low)
+			low = trip_low;
+
+		if (trip_temp > tz->temperature && trip_temp < high)
+			high = trip_temp;
+	}
+
+	/* No need to change trip points */
+	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
+		goto exit;
+
+	tz->prev_low_trip = low;
+	tz->prev_high_trip = high;
+
+	dev_dbg(&tz->device,
+		"new temperature boundaries: %d < x < %d\n", low, high);
+
+	/*
+	 * Set a temperature window. When this window is left the driver
+	 * must inform the thermal core via thermal_zone_device_update.
+	 */
+	ret = tz->ops->set_trips(tz, low, high);
+	if (ret)
+		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
+
+exit:
+	mutex_unlock(&tz->lock);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_set_trips);
+
+void thermal_cdev_update(struct thermal_cooling_device *cdev)
+{
+	struct thermal_instance *instance;
+	unsigned long target = 0;
+
+	mutex_lock(&cdev->lock);
+	/* cooling device is updated*/
+	if (cdev->updated) {
+		mutex_unlock(&cdev->lock);
+		return;
+	}
+
+	/* Make sure cdev enters the deepest cooling state */
+	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
+		dev_dbg(&cdev->device, "zone%d->target=%lu\n",
+			instance->tz->id, instance->target);
+		if (instance->target == THERMAL_NO_TARGET)
+			continue;
+		if (instance->target > target)
+			target = instance->target;
+	}
+	cdev->ops->set_cur_state(cdev, target);
+	cdev->updated = true;
+	mutex_unlock(&cdev->lock);
+	trace_cdev_update(cdev, target);
+	dev_dbg(&cdev->device, "set to state %lu\n", target);
+}
+EXPORT_SYMBOL(thermal_cdev_update);
-- 
2.1.4

