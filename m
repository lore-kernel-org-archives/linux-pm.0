From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 26/48] thermal: core: introduce thermal_helpers.c
Date: Mon, 30 May 2016 15:16:02 -0700
Message-ID: <1464646584-14322-27-git-send-email-edubezval@gmail.com>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Here we have a simple code organization. This patch moves
functions that do not need to handle thermal core internal
data structure to thermal_helpers.c file.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/Makefile          |   3 +-
 drivers/thermal/thermal_core.c    | 118 -------------------------------
 drivers/thermal/thermal_helpers.c | 144 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 119 deletions(-)
 create mode 100644 drivers/thermal/thermal_helpers.c

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 95ccb75..cded802 100644
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
index 37d29f3..1629613 100644
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
@@ -472,55 +430,6 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
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
 static void update_temperature(struct thermal_zone_device *tz)
 {
 	int temp, ret;
@@ -1120,33 +1029,6 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
-void thermal_cdev_update(struct thermal_cooling_device *cdev)
-{
-	struct thermal_instance *instance;
-	unsigned long target = 0;
-
-	/* cooling device is updated*/
-	if (cdev->updated)
-		return;
-
-	mutex_lock(&cdev->lock);
-	/* Make sure cdev enters the deepest cooling state */
-	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
-		dev_dbg(&cdev->device, "zone%d->target=%lu\n",
-			instance->tz->id, instance->target);
-		if (instance->target == THERMAL_NO_TARGET)
-			continue;
-		if (instance->target > target)
-			target = instance->target;
-	}
-	mutex_unlock(&cdev->lock);
-	cdev->ops->set_cur_state(cdev, target);
-	cdev->updated = true;
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
index 0000000..5e1c160
--- /dev/null
+++ b/drivers/thermal/thermal_helpers.c
@@ -0,0 +1,144 @@
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
+void thermal_cdev_update(struct thermal_cooling_device *cdev)
+{
+	struct thermal_instance *instance;
+	unsigned long target = 0;
+
+	/* cooling device is updated*/
+	if (cdev->updated)
+		return;
+
+	mutex_lock(&cdev->lock);
+	/* Make sure cdev enters the deepest cooling state */
+	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
+		dev_dbg(&cdev->device, "zone%d->target=%lu\n",
+			instance->tz->id, instance->target);
+		if (instance->target == THERMAL_NO_TARGET)
+			continue;
+		if (instance->target > target)
+			target = instance->target;
+	}
+	mutex_unlock(&cdev->lock);
+	cdev->ops->set_cur_state(cdev, target);
+	cdev->updated = true;
+	trace_cdev_update(cdev, target);
+	dev_dbg(&cdev->device, "set to state %lu\n", target);
+}
+EXPORT_SYMBOL(thermal_cdev_update);
-- 
2.1.4
