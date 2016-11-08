From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 49/49] thermal: core: move slop and offset helpers to thermal_helpers.c
Date: Mon,  7 Nov 2016 21:09:27 -0800
Message-ID: <1478581767-7009-50-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

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
index 4f93844..7daffc1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1358,36 +1358,6 @@ struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name)
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
index dfdba5a..8cdf75a 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -194,3 +194,33 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
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
