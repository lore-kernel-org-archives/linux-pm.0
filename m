From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 14/48] thermal: core: move trips attributes to tz->device.groups
Date: Mon, 30 May 2016 23:18:21 -0700
Message-ID: <1464675535-2433-15-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Finally, move the last thermal zone sysfs attributes to
tz->device.groups: trips attributes. This requires adding a
attribute_group to thermal_zone_device, creating it dynamically, and
then setting all trips attributes in it. The trips attribute is then
added to the tz->device.groups.

As the removal of all attributes are handled by device core, the device
remove calls are not needed anymore.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 77 +++++++++++++++++++++---------------------
 include/linux/thermal.h        |  2 ++
 2 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index ba4f7a9..0b60b04 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1188,8 +1188,9 @@ static const struct attribute_group *thermal_zone_attribute_groups[] = {
  */
 static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 {
-	int indx;
 	int size = sizeof(struct thermal_attr) * tz->trips;
+	struct attribute **attrs;
+	int indx;
 
 	tz->trip_type_attrs = kzalloc(size, GFP_KERNEL);
 	if (!tz->trip_type_attrs)
@@ -1210,6 +1211,15 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		}
 	}
 
+	attrs = kzalloc(sizeof(*attrs) * tz->trips * 3 + 1, GFP_KERNEL);
+	if (!attrs) {
+		kfree(tz->trip_type_attrs);
+		kfree(tz->trip_temp_attrs);
+		if (tz->ops->get_trip_hyst)
+			kfree(tz->trip_hyst_attrs);
+		return -ENOMEM;
+	}
+
 	for (indx = 0; indx < tz->trips; indx++) {
 		/* create trip type attribute */
 		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
@@ -1220,9 +1230,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 						tz->trip_type_attrs[indx].name;
 		tz->trip_type_attrs[indx].attr.attr.mode = S_IRUGO;
 		tz->trip_type_attrs[indx].attr.show = trip_point_type_show;
-
-		device_create_file(&tz->device,
-				   &tz->trip_type_attrs[indx].attr);
+		attrs[indx] = &tz->trip_type_attrs[indx].attr.attr;
 
 		/* create trip temp attribute */
 		snprintf(tz->trip_temp_attrs[indx].name, THERMAL_NAME_LENGTH,
@@ -1239,9 +1247,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 			tz->trip_temp_attrs[indx].attr.store =
 							trip_point_temp_store;
 		}
-
-		device_create_file(&tz->device,
-				   &tz->trip_temp_attrs[indx].attr);
+		attrs[indx + tz->trips] = &tz->trip_temp_attrs[indx].attr.attr;
 
 		/* create Optional trip hyst attribute */
 		if (!tz->ops->get_trip_hyst)
@@ -1259,45 +1265,38 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 			tz->trip_hyst_attrs[indx].attr.store =
 					trip_point_hyst_store;
 		}
-
-		device_create_file(&tz->device,
-				   &tz->trip_hyst_attrs[indx].attr);
+		attrs[indx + tz->trips * 2] =
+					&tz->trip_hyst_attrs[indx].attr.attr;
 	}
-	return 0;
-}
+	attrs[tz->trips * 3] = NULL;
 
-static void remove_trip_attrs(struct thermal_zone_device *tz)
-{
-	int indx;
+	tz->trips_attribute_group.attrs = attrs;
 
-	for (indx = 0; indx < tz->trips; indx++) {
-		device_remove_file(&tz->device,
-				   &tz->trip_type_attrs[indx].attr);
-		device_remove_file(&tz->device,
-				   &tz->trip_temp_attrs[indx].attr);
-		if (tz->ops->get_trip_hyst)
-			device_remove_file(&tz->device,
-					   &tz->trip_hyst_attrs[indx].attr);
-	}
-	kfree(tz->trip_type_attrs);
-	kfree(tz->trip_temp_attrs);
-	kfree(tz->trip_hyst_attrs);
+	return 0;
 }
 
-static int thermal_zone_create_device_groups(struct thermal_zone_device *tz)
+static int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
+					     int mask)
 {
 	const struct attribute_group **groups;
-	int i, size;
+	int i, size, result;
+
+	result = create_trip_attrs(tz, mask);
+	if (result)
+		return result;
 
-	size = ARRAY_SIZE(thermal_zone_attribute_groups) + 1;
+	/* we need one extra for trips and the NULL to terminate the array */
+	size = ARRAY_SIZE(thermal_zone_attribute_groups) + 2;
 	/* This also takes care of API requirement to be NULL terminated */
 	groups = kcalloc(size, sizeof(*groups), GFP_KERNEL);
 	if (!groups)
 		return -ENOMEM;
 
-	for (i = 0; i < size - 1; i++)
+	for (i = 0; i < size - 2; i++)
 		groups[i] = thermal_zone_attribute_groups[i];
 
+	groups[size - 2] = &tz->trips_attribute_group;
+
 	tz->device.groups = groups;
 
 	return 0;
@@ -1934,8 +1933,12 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	tz->passive_delay = passive_delay;
 	tz->polling_delay = polling_delay;
 
+	/* sys I/F */
 	/* Add nodes that are always present via .groups */
-	thermal_zone_create_device_groups(tz);
+	result = thermal_zone_create_device_groups(tz, mask);
+	if (result)
+		goto unregister;
+
 	/* A new thermal zone needs to be updated anyway. */
 	atomic_set(&tz->need_update, 1);
 
@@ -1947,11 +1950,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 		return ERR_PTR(result);
 	}
 
-	/* sys I/F */
-	result = create_trip_attrs(tz, mask);
-	if (result)
-		goto unregister;
-
 	for (count = 0; count < trips; count++) {
 		if (tz->ops->get_trip_type(tz, count, &trip_type))
 			set_bit(count, &tz->trips_disabled);
@@ -2056,7 +2054,10 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	thermal_zone_device_set_polling(tz, 0);
 
-	remove_trip_attrs(tz);
+	kfree(tz->trip_type_attrs);
+	kfree(tz->trip_temp_attrs);
+	kfree(tz->trip_hyst_attrs);
+	kfree(tz->trips_attribute_group.attrs);
 	thermal_set_governor(tz, NULL);
 
 	thermal_remove_hwmon_sysfs(tz);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e45abe7..fa2c2be 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 #include <linux/idr.h>
 #include <linux/device.h>
+#include <linux/sysfs.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/thermal.h>
 
@@ -187,6 +188,7 @@ struct thermal_zone_device {
 	int id;
 	char type[THERMAL_NAME_LENGTH];
 	struct device device;
+	struct attribute_group trips_attribute_group;
 	struct thermal_attr *trip_temp_attrs;
 	struct thermal_attr *trip_type_attrs;
 	struct thermal_attr *trip_hyst_attrs;
-- 
2.1.4
