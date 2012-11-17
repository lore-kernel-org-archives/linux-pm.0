From: Durgadoss R <durgadoss.r@intel.com>
Subject: [RFC PATCH 4/7] Thermal: Add Thermal_trip sysfs node
Date: Sat, 17 Nov 2012 16:15:55 +0530
Message-ID: <1353149158-19102-5-git-send-email-durgadoss.r@intel.com>
References: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25300 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab2KQKtb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 17 Nov 2012 05:49:31 -0500
In-Reply-To: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, linux-pm@vger.kernel.org
Cc: wni@nvidia.com, eduardo.valentin@ti.com, amit.kachhap@linaro.org, hongbo.zhang@linaro.org, sachin.kamat@linaro.org, Durgadoss R <durgadoss.r@intel.com>

This patch adds a thermal_trip directory under
/sys/class/thermal/zoneX. This directory contains
the trip point values for sensors bound to this
zone.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |  244 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/thermal.h       |   32 ++++++
 2 files changed, 274 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 70e5f5a..011588a 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -480,9 +480,15 @@ static void remove_sensor_from_zone(struct thermal_zone *tz,
 
 	sysfs_remove_link(&tz->device.kobj, kobject_name(&ts->device.kobj));
 
+	/* Delete this sensor's trip Kobject */
+	kobject_del(tz->kobj_trip[indx]);
+
 	/* Shift the entries in the tz->sensors array */
-	for (j = indx; j < MAX_SENSORS_PER_ZONE - 1; j++)
+	for (j = indx; j < MAX_SENSORS_PER_ZONE - 1; j++) {
 		tz->sensors[j] = tz->sensors[j + 1];
+		tz->trip[j] = tz->trip[j + 1];
+		tz->kobj_trip[j] = tz->kobj_trip[j + 1];
+	}
 
 	tz->sensor_indx--;
 }
@@ -505,6 +511,41 @@ static void remove_cdev_from_zone(struct thermal_zone *tz,
 	tz->cdev_indx--;
 }
 
+static struct thermal_zone *get_zone_by_trip_kobj(struct kobject *kobj)
+{
+	struct thermal_zone *pos;
+	struct thermal_zone *tz = NULL;
+
+	if (!kobj)
+		return NULL;
+
+	mutex_lock(&tz_list_lock);
+	for_each_thermal_zone(pos) {
+		if (pos->kobj_thermal_trip == kobj) {
+			tz = pos;
+			break;
+		}
+	}
+	mutex_unlock(&tz_list_lock);
+	return tz;
+}
+
+static struct thermal_sensor *get_sensor_by_kobj_name(const char *name)
+{
+	struct thermal_sensor *pos;
+	struct thermal_sensor *ts = NULL;
+
+	mutex_lock(&ts_list_lock);
+	for_each_thermal_sensor(pos) {
+		if (!strcmp(kobject_name(&pos->device.kobj), name)) {
+			ts = pos;
+			break;
+		}
+	}
+	mutex_unlock(&ts_list_lock);
+	return ts;
+}
+
 /* sys I/F for thermal zone */
 
 #define to_thermal_zone(_dev) \
@@ -859,6 +900,113 @@ policy_show(struct device *dev, struct device_attribute *devattr, char *buf)
 	return sprintf(buf, "%s\n", tz->governor->name);
 }
 
+static ssize_t
+active_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	int i, indx, ret = 0;
+	struct thermal_sensor *ts;
+	struct thermal_zone *tz;
+
+	ts = get_sensor_by_kobj_name(kobject_name(kobj));
+	if (!ts)
+		return -EINVAL;
+
+	tz = get_zone_by_trip_kobj(kobj->parent);
+	if (!tz)
+		return -EINVAL;
+
+	indx = get_sensor_indx(tz, ts);
+	if (indx < 0)
+		return indx;
+
+	if (tz->trip[indx]->num_active_trips <= 0)
+		return sprintf(buf, "<Not available>\n");
+
+	ret += sprintf(buf, "0x%x", tz->trip[indx]->active_trip_mask);
+	for (i = 0; i < tz->trip[indx]->num_active_trips; i++) {
+		ret += sprintf(buf + ret, " %d",
+			tz->trip[indx]->active_trips[i]);
+	}
+
+	ret += sprintf(buf + ret, "\n");
+	return ret;
+}
+
+static ssize_t
+ptrip_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	int i, indx, ret = 0;
+	struct thermal_sensor *ts;
+	struct thermal_zone *tz;
+
+	ts = get_sensor_by_kobj_name(kobject_name(kobj));
+	if (!ts)
+		return -EINVAL;
+
+	tz = get_zone_by_trip_kobj(kobj->parent);
+	if (!tz)
+		return -EINVAL;
+
+	indx = get_sensor_indx(tz, ts);
+	if (indx < 0)
+		return indx;
+
+	if (tz->trip[indx]->num_passive_trips <= 0)
+		return sprintf(buf, "<Not available>\n");
+
+	for (i = 0; i < tz->trip[indx]->num_passive_trips; i++) {
+		ret += sprintf(buf + ret, "%d ",
+			tz->trip[indx]->passive_trips[i]);
+	}
+
+	ret += sprintf(buf + ret, "\n");
+	return ret;
+}
+
+static ssize_t
+hot_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	int indx;
+	struct thermal_sensor *ts;
+	struct thermal_zone *tz;
+
+	ts = get_sensor_by_kobj_name(kobject_name(kobj));
+	if (!ts)
+		return -EINVAL;
+
+	tz = get_zone_by_trip_kobj(kobj->parent);
+	if (!tz)
+		return -EINVAL;
+
+	indx = get_sensor_indx(tz, ts);
+	if (indx < 0)
+		return indx;
+
+	return sprintf(buf, "%d\n", tz->trip[indx]->hot);
+}
+
+static ssize_t
+critical_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	int indx;
+	struct thermal_sensor *ts;
+	struct thermal_zone *tz;
+
+	ts = get_sensor_by_kobj_name(kobject_name(kobj));
+	if (!ts)
+		return -EINVAL;
+
+	tz = get_zone_by_trip_kobj(kobj->parent);
+	if (!tz)
+		return -EINVAL;
+
+	indx = get_sensor_indx(tz, ts);
+	if (indx < 0)
+		return indx;
+
+	return sprintf(buf, "%d\n", tz->trip[indx]->crit);
+}
+
 static DEVICE_ATTR(type, 0444, type_show, NULL);
 static DEVICE_ATTR(temp, 0444, temp_show, NULL);
 static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
@@ -869,7 +1017,26 @@ static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
 static DEVICE_ATTR(sensor_name, 0444, sensor_name_show, NULL);
 static DEVICE_ATTR(temp_input, 0444, sensor_temp_show, NULL);
 
-static DEVICE_ATTR(zone_name, 0444, zone_name_show, NULL);
+/* Thermal zone attributes */
+static DEVICE_ATTR(zone_name, S_IRUGO, zone_name_show, NULL);
+
+/* Thermal trip attributes */
+static struct kobj_attribute active_attr = __ATTR_RO(active);
+static struct kobj_attribute passive_attr = __ATTR_RO(ptrip);
+static struct kobj_attribute hot_attr = __ATTR_RO(hot);
+static struct kobj_attribute crit_attr = __ATTR_RO(critical);
+
+static struct attribute *trip_attrs[] = {
+			&active_attr.attr,
+			&passive_attr.attr,
+			&hot_attr.attr,
+			&crit_attr.attr,
+			NULL,
+			};
+
+static struct attribute_group trip_attr_group = {
+			.attrs = trip_attrs,
+			};
 
 /* sys I/F for cooling device */
 #define to_cooling_device(_dev)	\
@@ -1694,12 +1861,19 @@ struct thermal_zone *create_thermal_zone(const char *name, void *devdata)
 	if (ret)
 		goto exit_unregister;
 
+	tz->kobj_thermal_trip = kobject_create_and_add("thermal_trip",
+					&tz->device.kobj);
+	if (!tz->kobj_thermal_trip)
+		goto exit_name;
+
 	/* Add this zone to the global list of thermal zones */
 	mutex_lock(&tz_list_lock);
 	list_add_tail(&tz->node, &thermal_zone_list);
 	mutex_unlock(&tz_list_lock);
 	return tz;
 
+exit_name:
+	device_remove_file(&tz->device, &dev_attr_zone_name);
 exit_unregister:
 	device_unregister(&tz->device);
 exit_idr:
@@ -1713,6 +1887,7 @@ EXPORT_SYMBOL(create_thermal_zone);
 void remove_thermal_zone(struct thermal_zone *tz)
 {
 	struct thermal_zone *pos, *next;
+	int i;
 	bool found = false;
 
 	if (!tz)
@@ -1733,6 +1908,29 @@ void remove_thermal_zone(struct thermal_zone *tz)
 
 	device_remove_file(&tz->device, &dev_attr_zone_name);
 
+	/* Just for ease of usage */
+	i = tz->sensor_indx;
+
+	while (--i >= 0) {
+		sysfs_remove_link(&tz->device.kobj,
+				kobject_name(&tz->sensors[i]->device.kobj));
+		if (tz->kobj_trip[i])
+			kobject_del(tz->kobj_trip[i]);
+	}
+
+	if (tz->kobj_thermal_trip)
+		kobject_del(tz->kobj_thermal_trip);
+
+	/* Release the cdevs attached to this zone */
+	i = tz->cdev_indx;
+
+	while (--i >= 0) {
+		sysfs_remove_link(&tz->device.kobj,
+				kobject_name(&tz->cdevs[i]->device.kobj));
+	}
+
+	tz->sensor_indx = tz->cdev_indx = 0;
+
 	release_idr(&thermal_zone_idr, &thermal_idr_lock, tz->id);
 	idr_destroy(&tz->idr);
 
@@ -1864,6 +2062,48 @@ int add_cdev_to_zone(struct thermal_zone *tz,
 }
 EXPORT_SYMBOL(add_cdev_to_zone);
 
+int add_sensor_trip_info(struct thermal_zone *tz, const char *sensor_name,
+			struct thermal_trip_point *trip)
+{
+	int indx, ret = -EINVAL;
+	struct thermal_sensor *ts = get_sensor_by_name(sensor_name);
+
+	if (!tz || !ts || !trip)
+		return ret;
+
+	mutex_lock(&tz_list_lock);
+
+	indx = get_sensor_indx(tz, ts);
+	if (indx < 0)
+		goto exit_indx;
+
+	tz->kobj_trip[indx] = kobject_create_and_add(
+					kobject_name(&ts->device.kobj),
+					tz->kobj_thermal_trip);
+	if (!tz->kobj_trip[indx]) {
+		ret = -ENOMEM;
+		goto exit_indx;
+	}
+
+	ret = sysfs_create_group(tz->kobj_trip[indx], &trip_attr_group);
+	if (ret) {
+		dev_err(&tz->device, "sysfs_create_group failed:%d\n", ret);
+		goto exit_kobj;
+	}
+
+	tz->trip[indx] = trip;
+	mutex_unlock(&tz_list_lock);
+	return 0;
+
+exit_kobj:
+	kobject_del(tz->kobj_trip[indx]);
+	tz->kobj_trip[indx] = NULL;
+exit_indx:
+	mutex_unlock(&tz_list_lock);
+	return ret;
+}
+EXPORT_SYMBOL(add_sensor_trip_info);
+
 /**
  * thermal_sensor_register - register a new thermal sensor
  * @name:	name of the thermal sensor
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 2913910..7b2fe35 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -159,6 +159,30 @@ struct thermal_attr {
 	char name[THERMAL_NAME_LENGTH];
 };
 
+/*
+ * This structure defines the trip points for a sensor.
+ * The actual values for these trip points come from
+ * platform characterization. The thermal governors
+ * (either kernel or user space) may take appropriate
+ * actions when the sensors reach these trip points.
+ * See Documentation/thermal/sysfs-api2.txt for more details.
+ *
+ * As of now, For a particular sensor, we support:
+ * a) 1 hot trip point
+ * b) 1 critical trip point
+ * c) 'n' passive trip points
+ * d) 'm' active trip points
+ */
+struct thermal_trip_point {
+	int hot;
+	int crit;
+	int num_passive_trips;
+	int *passive_trips;
+	int num_active_trips;
+	int *active_trips;
+	int active_trip_mask;
+};
+
 struct thermal_sensor {
 	char name[THERMAL_NAME_LENGTH];
 	int id;
@@ -215,6 +239,11 @@ struct thermal_zone {
 	/* cdev level information */
 	int cdev_indx; /* index into 'cdevs' array */
 	struct thermal_cooling_device *cdevs[MAX_CDEVS_PER_ZONE];
+
+	/* Thermal trip information */
+	struct thermal_trip_point *trip[MAX_SENSORS_PER_ZONE];
+	struct kobject *kobj_trip[MAX_SENSORS_PER_ZONE];
+	struct kobject *kobj_thermal_trip;
 };
 
 /* Structure that holds thermal governor information */
@@ -298,6 +327,9 @@ int add_sensor_to_zone_by_name(struct thermal_zone *, const char *);
 int add_cdev_to_zone(struct thermal_zone *, struct thermal_cooling_device *);
 int add_cdev_to_zone_by_name(struct thermal_zone *, const char *);
 
+int add_sensor_trip_info(struct thermal_zone *, const char *,
+			struct thermal_trip_point *);
+
 #ifdef CONFIG_NET
 extern int thermal_generate_netlink_event(u32 orig, enum events event);
 #else
-- 
1.7.9.5

