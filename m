From: Durgadoss R <durgadoss.r@intel.com>
Subject: [RFC PATCH 5/7] Thermal: Add 'thermal_map' sysfs node
Date: Sat, 17 Nov 2012 16:15:56 +0530
Message-ID: <1353149158-19102-6-git-send-email-durgadoss.r@intel.com>
References: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25300 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab2KQKte (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 17 Nov 2012 05:49:34 -0500
In-Reply-To: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, linux-pm@vger.kernel.org
Cc: wni@nvidia.com, eduardo.valentin@ti.com, amit.kachhap@linaro.org, hongbo.zhang@linaro.org, sachin.kamat@linaro.org, Durgadoss R <durgadoss.r@intel.com>

This patch creates a thermal map sysfs node under
/sys/class/thermal/thermal_zoneX/. This contains
entries named map0, map1 .. mapN. Each map has the
following space separated values:
trip_type sensor_name cdev_name trip_mask weights

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |  158 +++++++++++++++++++++++++++++++++++++++--
 include/linux/thermal.h       |   25 +++++++
 2 files changed, 178 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 011588a..af52a16 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -530,6 +530,25 @@ static struct thermal_zone *get_zone_by_trip_kobj(struct kobject *kobj)
 	return tz;
 }
 
+static struct thermal_zone *get_zone_by_map_kobj(struct kobject *kobj)
+{
+	struct thermal_zone *pos;
+	struct thermal_zone *tz = NULL;
+
+	if (!kobj)
+		return NULL;
+
+	mutex_lock(&tz_list_lock);
+	for_each_thermal_zone(pos) {
+		if (pos->kobj_thermal_map == kobj) {
+			tz = pos;
+			break;
+		}
+	}
+	mutex_unlock(&tz_list_lock);
+	return tz;
+}
+
 static struct thermal_sensor *get_sensor_by_kobj_name(const char *name)
 {
 	struct thermal_sensor *pos;
@@ -546,6 +565,41 @@ static struct thermal_sensor *get_sensor_by_kobj_name(const char *name)
 	return ts;
 }
 
+static void __clean_map_entry(struct thermal_zone *tz, int i)
+{
+	tz->map[i] = NULL;
+	sysfs_remove_file(tz->kobj_thermal_map, &tz->map_attr[i]->attr.attr);
+	/* Free map attributes */
+	kfree(tz->map_attr[i]);
+	tz->map_attr[i] = NULL;
+}
+
+static void remove_sensor_map_entry(struct thermal_zone *tz,
+				struct thermal_sensor *ts)
+{
+	int i;
+
+	for (i = 0; i < MAX_MAPS_PER_ZONE; i++) {
+		if (tz->map[i] && !strnicmp(ts->name, tz->map[i]->sensor_name,
+						THERMAL_NAME_LENGTH)) {
+			__clean_map_entry(tz, i);
+		}
+	}
+}
+
+static void remove_cdev_map_entry(struct thermal_zone *tz,
+				struct thermal_cooling_device *cdev)
+{
+	int i;
+
+	for (i = 0; i < MAX_MAPS_PER_ZONE; i++) {
+		if (tz->map[i] && !strnicmp(cdev->type, tz->map[i]->cdev_name,
+						THERMAL_NAME_LENGTH)) {
+			__clean_map_entry(tz, i);
+		}
+	}
+}
+
 /* sys I/F for thermal zone */
 
 #define to_thermal_zone(_dev) \
@@ -901,6 +955,42 @@ policy_show(struct device *dev, struct device_attribute *devattr, char *buf)
 }
 
 static ssize_t
+map_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	int i, indx, ret = 0;
+	struct thermal_zone *tz;
+	struct thermal_map *map;
+	char *trip;
+
+	tz = get_zone_by_map_kobj(kobj);
+	if (!tz)
+		return -EINVAL;
+
+	sscanf(attr->attr.name, "map%d", &indx);
+
+	if (indx < 0 || indx >= MAX_MAPS_PER_ZONE)
+		return -EINVAL;
+
+	if (!tz->map[indx])
+		return sprintf(buf, "<Unavailable>\n");
+
+	map = tz->map[indx];
+
+	trip = (map->trip_type == THERMAL_TRIP_ACTIVE) ?
+					"active" : "passive";
+	ret += sprintf(buf, "%s", trip);
+	ret += sprintf(buf + ret, " %s", map->sensor_name);
+	ret += sprintf(buf + ret, " %s", map->cdev_name);
+	ret += sprintf(buf + ret, " 0x%x", map->trip_mask);
+
+	for (i = 0; i < map->num_weights; i++)
+		ret += sprintf(buf + ret, " %d", map->weights[i]);
+
+	ret += sprintf(buf + ret, "\n");
+	return ret;
+}
+
+static ssize_t
 active_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	int i, indx, ret = 0;
@@ -1671,8 +1761,10 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	mutex_lock(&tz_list_lock);
 
-	for_each_thermal_zone(tmp_tz)
+	for_each_thermal_zone(tmp_tz) {
 		remove_cdev_from_zone(tmp_tz, cdev);
+		remove_cdev_map_entry(tmp_tz, cdev);
+	}
 
 	mutex_unlock(&tz_list_lock);
 
@@ -1866,12 +1958,19 @@ struct thermal_zone *create_thermal_zone(const char *name, void *devdata)
 	if (!tz->kobj_thermal_trip)
 		goto exit_name;
 
+	tz->kobj_thermal_map = kobject_create_and_add("thermal_map",
+					&tz->device.kobj);
+	if (!tz->kobj_thermal_map)
+		goto exit_trip;
+
 	/* Add this zone to the global list of thermal zones */
 	mutex_lock(&tz_list_lock);
 	list_add_tail(&tz->node, &thermal_zone_list);
 	mutex_unlock(&tz_list_lock);
 	return tz;
 
+exit_trip:
+	kobject_del(tz->kobj_thermal_trip);
 exit_name:
 	device_remove_file(&tz->device, &dev_attr_zone_name);
 exit_unregister:
@@ -1918,9 +2017,6 @@ void remove_thermal_zone(struct thermal_zone *tz)
 			kobject_del(tz->kobj_trip[i]);
 	}
 
-	if (tz->kobj_thermal_trip)
-		kobject_del(tz->kobj_thermal_trip);
-
 	/* Release the cdevs attached to this zone */
 	i = tz->cdev_indx;
 
@@ -1931,6 +2027,9 @@ void remove_thermal_zone(struct thermal_zone *tz)
 
 	tz->sensor_indx = tz->cdev_indx = 0;
 
+	kobject_del(tz->kobj_thermal_trip);
+	kobject_del(tz->kobj_thermal_map);
+
 	release_idr(&thermal_zone_idr, &thermal_idr_lock, tz->id);
 	idr_destroy(&tz->idr);
 
@@ -1976,6 +2075,53 @@ struct thermal_sensor *get_sensor_by_name(const char *name)
 }
 EXPORT_SYMBOL(get_sensor_by_name);
 
+int add_map_entry(struct thermal_zone *tz, struct thermal_map *map)
+{
+	int ret, indx;
+
+	if (!tz || !map)
+		return -EINVAL;
+
+	mutex_lock(&tz_list_lock);
+
+	for (indx = 0; indx < MAX_MAPS_PER_ZONE; indx++) {
+		if (tz->map[indx] == NULL)
+			break;
+	}
+
+	if (indx >= MAX_MAPS_PER_ZONE) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	tz->map_attr[indx] = kzalloc(sizeof(struct thermal_map_attr),
+					GFP_KERNEL);
+	if (!tz->map_attr[indx]) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	sprintf(tz->map_attr[indx]->name, "map%d", indx);
+
+	tz->map_attr[indx]->attr.attr.name = tz->map_attr[indx]->name;
+	tz->map_attr[indx]->attr.attr.mode = S_IRUGO;
+	tz->map_attr[indx]->attr.show = map_show;
+
+	sysfs_attr_init(&tz->map_attr[indx]->attr.attr);
+	ret = sysfs_create_file(tz->kobj_thermal_map,
+				&tz->map_attr[indx]->attr.attr);
+	if (ret) {
+		kfree(tz->map_attr[indx]);
+		goto exit;
+	}
+
+	tz->map[indx] = map;
+exit:
+	mutex_unlock(&tz_list_lock);
+	return ret;
+}
+EXPORT_SYMBOL(add_map_entry);
+
 int add_sensor_to_zone_by_name(struct thermal_zone *tz, const char *name)
 {
 	int ret;
@@ -2193,8 +2339,10 @@ void thermal_sensor_unregister(struct thermal_sensor *ts)
 
 	mutex_lock(&tz_list_lock);
 
-	for_each_thermal_zone(tz)
+	for_each_thermal_zone(tz) {
 		remove_sensor_from_zone(tz, ts);
+		remove_sensor_map_entry(tz, ts);
+	}
 
 	mutex_unlock(&tz_list_lock);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 7b2fe35..84763b5 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -56,6 +56,9 @@
 
 #define MAX_CDEVS_PER_ZONE		5
 
+/* If we map each sensor with every possible cdev for a zone */
+#define MAX_MAPS_PER_ZONE	(MAX_SENSORS_PER_ZONE * MAX_CDEVS_PER_ZONE)
+
 struct thermal_sensor;
 struct thermal_zone_device;
 struct thermal_cooling_device;
@@ -159,6 +162,21 @@ struct thermal_attr {
 	char name[THERMAL_NAME_LENGTH];
 };
 
+struct thermal_map_attr {
+	struct kobj_attribute attr;
+	char name[THERMAL_NAME_LENGTH];
+};
+
+struct thermal_map {
+	enum thermal_trip_type trip_type;
+	char cdev_name[THERMAL_NAME_LENGTH];
+	char sensor_name[THERMAL_NAME_LENGTH];
+
+	int trip_mask;
+	int num_weights;
+	int *weights;
+};
+
 /*
  * This structure defines the trip points for a sensor.
  * The actual values for these trip points come from
@@ -244,6 +262,11 @@ struct thermal_zone {
 	struct thermal_trip_point *trip[MAX_SENSORS_PER_ZONE];
 	struct kobject *kobj_trip[MAX_SENSORS_PER_ZONE];
 	struct kobject *kobj_thermal_trip;
+
+	/* Thermal map information */
+	struct thermal_map *map[MAX_MAPS_PER_ZONE];
+	struct thermal_map_attr *map_attr[MAX_MAPS_PER_ZONE];
+	struct kobject *kobj_thermal_map;
 };
 
 /* Structure that holds thermal governor information */
@@ -330,6 +353,8 @@ int add_cdev_to_zone_by_name(struct thermal_zone *, const char *);
 int add_sensor_trip_info(struct thermal_zone *, const char *,
 			struct thermal_trip_point *);
 
+int add_map_entry(struct thermal_zone *, struct thermal_map *);
+
 #ifdef CONFIG_NET
 extern int thermal_generate_netlink_event(u32 orig, enum events event);
 #else
-- 
1.7.9.5

