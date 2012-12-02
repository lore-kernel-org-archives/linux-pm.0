From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 08/34] Thermal: Update binding logic based on platform data
Date: Sun,  2 Dec 2012 22:44:42 +0800
Message-ID: <1354459508-3707-8-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60872 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579Ab2LBOpe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:34 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch updates the binding logic in thermal_sys.c
It uses the platform layer data to bind a thermal zone
to a cdev for a particular trip point.

 * If we do not have platform data and do not have
   .bind defined, do not bind.
 * If we do not have platform data but .bind is
   defined, then use tz->ops->bind.
 * If we have platform data, use it to create binding.

The same logic sequence is followed for unbind also.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |  183 +++++++++++++++++++++++++++++++++++------
 1 files changed, 157 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index a6933da..a328032 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -201,6 +201,111 @@ struct thermal_instance *get_thermal_instance(struct thermal_zone_device *tz,
 }
 EXPORT_SYMBOL(get_thermal_instance);
 
+static void print_bind_err_msg(struct thermal_zone_device *tz,
+			struct thermal_cooling_device *cdev, int ret)
+{
+	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
+				tz->type, cdev->type, ret);
+}
+
+static void __bind(struct thermal_zone_device *tz, int mask,
+			struct thermal_cooling_device *cdev)
+{
+	int i, ret;
+
+	for (i = 0; i < tz->trips; i++) {
+		if (mask & (1 << i)) {
+			ret = thermal_zone_bind_cooling_device(tz, i, cdev,
+					THERMAL_NO_LIMIT, THERMAL_NO_LIMIT);
+			if (ret)
+				print_bind_err_msg(tz, cdev, ret);
+		}
+	}
+}
+
+static void __unbind(struct thermal_zone_device *tz, int mask,
+			struct thermal_cooling_device *cdev)
+{
+	int i;
+
+	for (i = 0; i < tz->trips; i++)
+		if (mask & (1 << i))
+			thermal_zone_unbind_cooling_device(tz, i, cdev);
+}
+
+static void bind_cdev(struct thermal_cooling_device *cdev)
+{
+	int i, ret;
+	const struct thermal_zone_params *tzp;
+	struct thermal_zone_device *pos = NULL;
+
+	mutex_lock(&thermal_list_lock);
+
+	list_for_each_entry(pos, &thermal_tz_list, node) {
+		if (!pos->tzp && !pos->ops->bind)
+			continue;
+
+		if (!pos->tzp && pos->ops->bind) {
+			ret = pos->ops->bind(pos, cdev);
+			if (ret)
+				print_bind_err_msg(pos, cdev, ret);
+		}
+
+		tzp = pos->tzp;
+		if (!tzp->tbp)
+			return;
+
+		for (i = 0; i < tzp->num_tbps; i++) {
+			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
+				continue;
+			if (tzp->tbp[i].match(pos, cdev))
+				continue;
+			tzp->tbp[i].cdev = cdev;
+			__bind(pos, tzp->tbp[i].trip_mask, cdev);
+		}
+	}
+
+	mutex_unlock(&thermal_list_lock);
+}
+
+static void bind_tz(struct thermal_zone_device *tz)
+{
+	int i, ret;
+	struct thermal_cooling_device *pos = NULL;
+	const struct thermal_zone_params *tzp = tz->tzp;
+
+	if (!tzp && !tz->ops->bind)
+		return;
+
+	mutex_lock(&thermal_list_lock);
+
+	/* If there is no platform data, try to use ops->bind */
+	if (!tzp && tz->ops->bind) {
+		list_for_each_entry(pos, &thermal_cdev_list, node) {
+			ret = tz->ops->bind(tz, pos);
+			if (ret)
+				print_bind_err_msg(tz, pos, ret);
+		}
+		goto exit;
+	}
+
+	if (!tzp->tbp)
+		goto exit;
+
+	list_for_each_entry(pos, &thermal_cdev_list, node) {
+		for (i = 0; i < tzp->num_tbps; i++) {
+			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
+				continue;
+			if (tzp->tbp[i].match(tz, pos))
+				continue;
+			tzp->tbp[i].cdev = pos;
+			__bind(tz, tzp->tbp[i].trip_mask, pos);
+		}
+	}
+exit:
+	mutex_unlock(&thermal_list_lock);
+}
+
 /* sys I/F for thermal zone */
 
 #define to_thermal_zone(_dev) \
@@ -1026,7 +1131,6 @@ thermal_cooling_device_register(char *type, void *devdata,
 				const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
-	struct thermal_zone_device *pos;
 	int result;
 
 	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
@@ -1076,20 +1180,15 @@ thermal_cooling_device_register(char *type, void *devdata,
 	if (result)
 		goto unregister;
 
+	/* Add 'this' new cdev to the global cdev list */
 	mutex_lock(&thermal_list_lock);
 	list_add(&cdev->node, &thermal_cdev_list);
-	list_for_each_entry(pos, &thermal_tz_list, node) {
-		if (!pos->ops->bind)
-			continue;
-		result = pos->ops->bind(pos, cdev);
-		if (result)
-			break;
-
-	}
 	mutex_unlock(&thermal_list_lock);
 
-	if (!result)
-		return cdev;
+	/* Update binding information for 'this' new cdev */
+	bind_cdev(cdev);
+
+	return cdev;
 
 unregister:
 	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
@@ -1105,10 +1204,10 @@ EXPORT_SYMBOL(thermal_cooling_device_register);
  * thermal_cooling_device_unregister() must be called when the device is no
  * longer needed.
  */
-void thermal_cooling_device_unregister(struct
-				       thermal_cooling_device
-				       *cdev)
+void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 {
+	int i;
+	const struct thermal_zone_params *tzp;
 	struct thermal_zone_device *tz;
 	struct thermal_cooling_device *pos = NULL;
 
@@ -1125,12 +1224,28 @@ void thermal_cooling_device_unregister(struct
 		return;
 	}
 	list_del(&cdev->node);
+
+	/* Unbind all thermal zones associated with 'this' cdev */
 	list_for_each_entry(tz, &thermal_tz_list, node) {
-		if (!tz->ops->unbind)
+		if (tz->ops->unbind) {
+			tz->ops->unbind(tz, cdev);
+			continue;
+		}
+
+		if (!tz->tzp || !tz->tzp->tbp)
 			continue;
-		tz->ops->unbind(tz, cdev);
+
+		tzp = tz->tzp;
+		for (i = 0; i < tzp->num_tbps; i++) {
+			if (tzp->tbp[i].cdev == cdev) {
+				__unbind(tz, tzp->tbp[i].trip_mask, cdev);
+				tzp->tbp[i].cdev = NULL;
+			}
+		}
 	}
+
 	mutex_unlock(&thermal_list_lock);
+
 	if (cdev->type[0])
 		device_remove_file(&cdev->device, &dev_attr_cdev_type);
 	device_remove_file(&cdev->device, &dev_attr_max_state);
@@ -1468,7 +1583,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	int passive_delay, int polling_delay)
 {
 	struct thermal_zone_device *tz;
-	struct thermal_cooling_device *pos;
 	enum thermal_trip_type trip_type;
 	int result;
 	int count;
@@ -1567,14 +1681,11 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 
 	mutex_lock(&thermal_list_lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
-	if (ops->bind)
-		list_for_each_entry(pos, &thermal_cdev_list, node) {
-		result = ops->bind(tz, pos);
-		if (result)
-			break;
-		}
 	mutex_unlock(&thermal_list_lock);
 
+	/* Bind cooling devices for this zone */
+	bind_tz(tz);
+
 	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
 
 	thermal_zone_device_update(tz);
@@ -1595,12 +1706,16 @@ EXPORT_SYMBOL(thermal_zone_device_register);
  */
 void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 {
+	int i;
+	const struct thermal_zone_params *tzp;
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
 
 	if (!tz)
 		return;
 
+	tzp = tz->tzp;
+
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(pos, &thermal_tz_list, node)
 	    if (pos == tz)
@@ -1611,9 +1726,25 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 		return;
 	}
 	list_del(&tz->node);
-	if (tz->ops->unbind)
-		list_for_each_entry(cdev, &thermal_cdev_list, node)
-		    tz->ops->unbind(tz, cdev);
+
+	/* Unbind all cdevs associated with 'this' thermal zone */
+	list_for_each_entry(cdev, &thermal_cdev_list, node) {
+		if (tz->ops->unbind) {
+			tz->ops->unbind(tz, cdev);
+			continue;
+		}
+
+		if (!tzp || !tzp->tbp)
+			break;
+
+		for (i = 0; i < tzp->num_tbps; i++) {
+			if (tzp->tbp[i].cdev == cdev) {
+				__unbind(tz, tzp->tbp[i].trip_mask, cdev);
+				tzp->tbp[i].cdev = NULL;
+			}
+		}
+	}
+
 	mutex_unlock(&thermal_list_lock);
 
 	thermal_zone_device_set_polling(tz, 0);
-- 
1.7.7.6

