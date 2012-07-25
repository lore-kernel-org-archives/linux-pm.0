From: Len Brown <lenb@kernel.org>
Subject: [PATCH 51/52] Thermal: Add Hysteresis attributes
Date: Tue, 24 Jul 2012 23:41:47 -0400
Message-ID: <27365a6c7d64a3bba22ee62109e4a071bbd7f933.1343187618.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Durgadoss R <dugardoss.r@intel.com>, Durgadoss R <durgadoss.r@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Durgadoss R <dugardoss.r@intel.com>

The Linux Thermal Framework does not support hysteresis
attributes. Most thermal sensors, today, have a
hysteresis value associated with trip points.

This patch adds hysteresis attributes on a per-trip-point
basis, to the Thermal Framework. These attributes are
optionally writable.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thermal/sysfs-api.txt |  6 +++
 drivers/thermal/thermal_sys.c       | 88 ++++++++++++++++++++++++++++++++++---
 include/linux/thermal.h             |  5 +++
 3 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 4c10593..2ba4c9b 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -121,6 +121,7 @@ Thermal zone device sys I/F, created once it's registered:
     |---mode:			Working mode of the thermal zone
     |---trip_point_[0-*]_temp:	Trip point temperature
     |---trip_point_[0-*]_type:	Trip point type
+    |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
 
 Thermal cooling device sys I/F, created once it's registered:
 /sys/class/thermal/cooling_device[0-*]:
@@ -190,6 +191,11 @@ trip_point_[0-*]_type
 	thermal zone.
 	RO, Optional
 
+trip_point_[0-*]_hyst
+	The hysteresis value for a trip point, represented as an integer
+	Unit: Celsius
+	RW, Optional
+
 cdev[0-*]
 	Sysfs link to the thermal cooling device node where the sys I/F
 	for cooling device throttling control represents.
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 5feb335..2d7a9fe 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -240,6 +240,52 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t
+trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	int trip, ret;
+	unsigned long temperature;
+
+	if (!tz->ops->set_trip_hyst)
+		return -EPERM;
+
+	if (!sscanf(attr->attr.name, "trip_point_%d_hyst", &trip))
+		return -EINVAL;
+
+	if (kstrtoul(buf, 10, &temperature))
+		return -EINVAL;
+
+	/*
+	 * We are not doing any check on the 'temperature' value
+	 * here. The driver implementing 'set_trip_hyst' has to
+	 * take care of this.
+	 */
+	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
+
+	return ret ? ret : count;
+}
+
+static ssize_t
+trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	int trip, ret;
+	unsigned long temperature;
+
+	if (!tz->ops->get_trip_hyst)
+		return -EPERM;
+
+	if (!sscanf(attr->attr.name, "trip_point_%d_hyst", &trip))
+		return -EINVAL;
+
+	ret = tz->ops->get_trip_hyst(tz, trip, &temperature);
+
+	return ret ? ret : sprintf(buf, "%ld\n", temperature);
+}
+
+static ssize_t
 passive_store(struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
@@ -1091,21 +1137,29 @@ EXPORT_SYMBOL(thermal_zone_device_update);
 static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 {
 	int indx;
+	int size = sizeof(struct thermal_attr) * tz->trips;
 
-	tz->trip_type_attrs =
-		kzalloc(sizeof(struct thermal_attr) * tz->trips, GFP_KERNEL);
+	tz->trip_type_attrs = kzalloc(size, GFP_KERNEL);
 	if (!tz->trip_type_attrs)
 		return -ENOMEM;
 
-	tz->trip_temp_attrs =
-		kzalloc(sizeof(struct thermal_attr) * tz->trips, GFP_KERNEL);
+	tz->trip_temp_attrs = kzalloc(size, GFP_KERNEL);
 	if (!tz->trip_temp_attrs) {
 		kfree(tz->trip_type_attrs);
 		return -ENOMEM;
 	}
 
-	for (indx = 0; indx < tz->trips; indx++) {
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
 		/* create trip type attribute */
 		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_type", indx);
@@ -1136,6 +1190,26 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 
 		device_create_file(&tz->device,
 				   &tz->trip_temp_attrs[indx].attr);
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
 	}
 	return 0;
 }
@@ -1149,9 +1223,13 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
 				   &tz->trip_type_attrs[indx].attr);
 		device_remove_file(&tz->device,
 				   &tz->trip_temp_attrs[indx].attr);
+		if (tz->ops->get_trip_hyst)
+			device_remove_file(&tz->device,
+				  &tz->trip_hyst_attrs[indx].attr);
 	}
 	kfree(tz->trip_type_attrs);
 	kfree(tz->trip_temp_attrs);
+	kfree(tz->trip_hyst_attrs);
 }
 
 /**
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 6eaf914..cfc8d90 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -60,6 +60,10 @@ struct thermal_zone_device_ops {
 			      unsigned long *);
 	int (*set_trip_temp) (struct thermal_zone_device *, int,
 			      unsigned long);
+	int (*get_trip_hyst) (struct thermal_zone_device *, int,
+			      unsigned long *);
+	int (*set_trip_hyst) (struct thermal_zone_device *, int,
+			      unsigned long);
 	int (*get_crit_temp) (struct thermal_zone_device *, unsigned long *);
 	int (*notify) (struct thermal_zone_device *, int,
 		       enum thermal_trip_type);
@@ -98,6 +102,7 @@ struct thermal_zone_device {
 	struct device device;
 	struct thermal_attr *trip_temp_attrs;
 	struct thermal_attr *trip_type_attrs;
+	struct thermal_attr *trip_hyst_attrs;
 	void *devdata;
 	int trips;
 	int tc1;
-- 
1.7.12.rc0
