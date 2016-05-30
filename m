From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 12/48] thermal: core: move the trip attrs to the tz sysfs I/F section
Date: Mon, 30 May 2016 15:15:48 -0700
Message-ID: <1464646584-14322-13-git-send-email-edubezval@gmail.com>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Code reorganization to keep all the sysfs I/F of a thermal zone in the
same section.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 216 ++++++++++++++++++++---------------------
 1 file changed, 108 insertions(+), 108 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index bd6b144..8f1a16e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1173,6 +1173,114 @@ static const struct attribute_group *thermal_zone_attribute_groups[] = {
 	NULL
 };
 
+/**
+ * create_trip_attrs() - create attributes for trip points
+ * @tz:		the thermal zone device
+ * @mask:	Writeable trip point bitmap.
+ *
+ * helper function to instantiate sysfs entries for every trip
+ * point and its properties of a struct thermal_zone_device.
+ *
+ * Return: 0 on success, the proper error value otherwise.
+ */
+static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
+{
+	int indx;
+	int size = sizeof(struct thermal_attr) * tz->trips;
+
+	tz->trip_type_attrs = kzalloc(size, GFP_KERNEL);
+	if (!tz->trip_type_attrs)
+		return -ENOMEM;
+
+	tz->trip_temp_attrs = kzalloc(size, GFP_KERNEL);
+	if (!tz->trip_temp_attrs) {
+		kfree(tz->trip_type_attrs);
+		return -ENOMEM;
+	}
+
+	if (tz->ops->get_trip_hyst) {
+		tz->trip_hyst_attrs = kzalloc(size, GFP_KERNEL);
+		if (!tz->trip_hyst_attrs) {
+			kfree(tz->trip_type_attrs);
+			kfree(tz->trip_temp_attrs);
+			return -ENOMEM;
+		}
+	}
+
+	for (indx = 0; indx < tz->trips; indx++) {
+		/* create trip type attribute */
+		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
+			 "trip_point_%d_type", indx);
+
+		sysfs_attr_init(&tz->trip_type_attrs[indx].attr.attr);
+		tz->trip_type_attrs[indx].attr.attr.name =
+						tz->trip_type_attrs[indx].name;
+		tz->trip_type_attrs[indx].attr.attr.mode = S_IRUGO;
+		tz->trip_type_attrs[indx].attr.show = trip_point_type_show;
+
+		device_create_file(&tz->device,
+				   &tz->trip_type_attrs[indx].attr);
+
+		/* create trip temp attribute */
+		snprintf(tz->trip_temp_attrs[indx].name, THERMAL_NAME_LENGTH,
+			 "trip_point_%d_temp", indx);
+
+		sysfs_attr_init(&tz->trip_temp_attrs[indx].attr.attr);
+		tz->trip_temp_attrs[indx].attr.attr.name =
+						tz->trip_temp_attrs[indx].name;
+		tz->trip_temp_attrs[indx].attr.attr.mode = S_IRUGO;
+		tz->trip_temp_attrs[indx].attr.show = trip_point_temp_show;
+		if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
+		    mask & (1 << indx)) {
+			tz->trip_temp_attrs[indx].attr.attr.mode |= S_IWUSR;
+			tz->trip_temp_attrs[indx].attr.store =
+							trip_point_temp_store;
+		}
+
+		device_create_file(&tz->device,
+				   &tz->trip_temp_attrs[indx].attr);
+
+		/* create Optional trip hyst attribute */
+		if (!tz->ops->get_trip_hyst)
+			continue;
+		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
+			 "trip_point_%d_hyst", indx);
+
+		sysfs_attr_init(&tz->trip_hyst_attrs[indx].attr.attr);
+		tz->trip_hyst_attrs[indx].attr.attr.name =
+					tz->trip_hyst_attrs[indx].name;
+		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
+		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
+		if (tz->ops->set_trip_hyst) {
+			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
+			tz->trip_hyst_attrs[indx].attr.store =
+					trip_point_hyst_store;
+		}
+
+		device_create_file(&tz->device,
+				   &tz->trip_hyst_attrs[indx].attr);
+	}
+	return 0;
+}
+
+static void remove_trip_attrs(struct thermal_zone_device *tz)
+{
+	int indx;
+
+	for (indx = 0; indx < tz->trips; indx++) {
+		device_remove_file(&tz->device,
+				   &tz->trip_type_attrs[indx].attr);
+		device_remove_file(&tz->device,
+				   &tz->trip_temp_attrs[indx].attr);
+		if (tz->ops->get_trip_hyst)
+			device_remove_file(&tz->device,
+					   &tz->trip_hyst_attrs[indx].attr);
+	}
+	kfree(tz->trip_type_attrs);
+	kfree(tz->trip_temp_attrs);
+	kfree(tz->trip_hyst_attrs);
+}
+
 /* sys I/F for cooling device */
 #define to_cooling_device(_dev)	\
 	container_of(_dev, struct thermal_cooling_device, device)
@@ -1731,114 +1839,6 @@ void thermal_notify_framework(struct thermal_zone_device *tz, int trip)
 EXPORT_SYMBOL_GPL(thermal_notify_framework);
 
 /**
- * create_trip_attrs() - create attributes for trip points
- * @tz:		the thermal zone device
- * @mask:	Writeable trip point bitmap.
- *
- * helper function to instantiate sysfs entries for every trip
- * point and its properties of a struct thermal_zone_device.
- *
- * Return: 0 on success, the proper error value otherwise.
- */
-static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
-{
-	int indx;
-	int size = sizeof(struct thermal_attr) * tz->trips;
-
-	tz->trip_type_attrs = kzalloc(size, GFP_KERNEL);
-	if (!tz->trip_type_attrs)
-		return -ENOMEM;
-
-	tz->trip_temp_attrs = kzalloc(size, GFP_KERNEL);
-	if (!tz->trip_temp_attrs) {
-		kfree(tz->trip_type_attrs);
-		return -ENOMEM;
-	}
-
-	if (tz->ops->get_trip_hyst) {
-		tz->trip_hyst_attrs = kzalloc(size, GFP_KERNEL);
-		if (!tz->trip_hyst_attrs) {
-			kfree(tz->trip_type_attrs);
-			kfree(tz->trip_temp_attrs);
-			return -ENOMEM;
-		}
-	}
-
-	for (indx = 0; indx < tz->trips; indx++) {
-		/* create trip type attribute */
-		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
-			 "trip_point_%d_type", indx);
-
-		sysfs_attr_init(&tz->trip_type_attrs[indx].attr.attr);
-		tz->trip_type_attrs[indx].attr.attr.name =
-						tz->trip_type_attrs[indx].name;
-		tz->trip_type_attrs[indx].attr.attr.mode = S_IRUGO;
-		tz->trip_type_attrs[indx].attr.show = trip_point_type_show;
-
-		device_create_file(&tz->device,
-				   &tz->trip_type_attrs[indx].attr);
-
-		/* create trip temp attribute */
-		snprintf(tz->trip_temp_attrs[indx].name, THERMAL_NAME_LENGTH,
-			 "trip_point_%d_temp", indx);
-
-		sysfs_attr_init(&tz->trip_temp_attrs[indx].attr.attr);
-		tz->trip_temp_attrs[indx].attr.attr.name =
-						tz->trip_temp_attrs[indx].name;
-		tz->trip_temp_attrs[indx].attr.attr.mode = S_IRUGO;
-		tz->trip_temp_attrs[indx].attr.show = trip_point_temp_show;
-		if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
-		    mask & (1 << indx)) {
-			tz->trip_temp_attrs[indx].attr.attr.mode |= S_IWUSR;
-			tz->trip_temp_attrs[indx].attr.store =
-							trip_point_temp_store;
-		}
-
-		device_create_file(&tz->device,
-				   &tz->trip_temp_attrs[indx].attr);
-
-		/* create Optional trip hyst attribute */
-		if (!tz->ops->get_trip_hyst)
-			continue;
-		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
-			 "trip_point_%d_hyst", indx);
-
-		sysfs_attr_init(&tz->trip_hyst_attrs[indx].attr.attr);
-		tz->trip_hyst_attrs[indx].attr.attr.name =
-					tz->trip_hyst_attrs[indx].name;
-		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
-		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
-		if (tz->ops->set_trip_hyst) {
-			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
-			tz->trip_hyst_attrs[indx].attr.store =
-					trip_point_hyst_store;
-		}
-
-		device_create_file(&tz->device,
-				   &tz->trip_hyst_attrs[indx].attr);
-	}
-	return 0;
-}
-
-static void remove_trip_attrs(struct thermal_zone_device *tz)
-{
-	int indx;
-
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
-}
-
-/**
  * thermal_zone_device_register() - register a new thermal zone device
  * @type:	the thermal zone device type
  * @trips:	the number of trip points the thermal zone support
-- 
2.1.4
