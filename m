From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/1] thermal: core: move slop and offset helpers to thermal_helpers.c
Date: Fri,  1 Jul 2016 18:55:50 -0700
Message-ID: <1467424550-12035-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34205 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbcGBBz4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2016 21:55:56 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Reorganize code to reflect better placement.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c    | 30 ------------------------------
 drivers/thermal/thermal_helpers.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 84857bdf..792aab7 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1350,36 +1350,6 @@ exit:
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
 
-/**
- * thermal_zone_get_slope - return the slope attribute of the thermal zone
- * @tz: thermal zone device with the slope attribute
- *
- * Return: If the thermal zone device has a slope attribute, return it, else
- * return 1.
- */
-int thermal_zone_get_slope(struct thermal_zone_device *tz)
-{
-	if (tz && tz->tzp)
-		return tz->tzp->slope;
-	return 1;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_get_slope);
-
-/**
- * thermal_zone_get_offset - return the offset attribute of the thermal zone
- * @tz: thermal zone device with the offset attribute
- *
- * Return: If the thermal zone device has a offset attribute, return it, else
- * return 0.
- */
-int thermal_zone_get_offset(struct thermal_zone_device *tz)
-{
-	if (tz && tz->tzp)
-		return tz->tzp->offset;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_get_offset);
-
 #ifdef CONFIG_NET
 static const struct genl_multicast_group thermal_event_mcgrps[] = {
 	{ .name = THERMAL_GENL_MCAST_GROUP_NAME, },
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 5e1c160..2d37d9d 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -142,3 +142,33 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	dev_dbg(&cdev->device, "set to state %lu\n", target);
 }
 EXPORT_SYMBOL(thermal_cdev_update);
+
+/**
+ * thermal_zone_get_slope - return the slope attribute of the thermal zone
+ * @tz: thermal zone device with the slope attribute
+ *
+ * Return: If the thermal zone device has a slope attribute, return it, else
+ * return 1.
+ */
+int thermal_zone_get_slope(struct thermal_zone_device *tz)
+{
+	if (tz && tz->tzp)
+		return tz->tzp->slope;
+	return 1;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_slope);
+
+/**
+ * thermal_zone_get_offset - return the offset attribute of the thermal zone
+ * @tz: thermal zone device with the offset attribute
+ *
+ * Return: If the thermal zone device has a offset attribute, return it, else
+ * return 0.
+ */
+int thermal_zone_get_offset(struct thermal_zone_device *tz)
+{
+	if (tz && tz->tzp)
+		return tz->tzp->offset;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_offset);
-- 
2.1.4

