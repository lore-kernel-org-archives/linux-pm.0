From: Durgadoss R <durgadoss.r@intel.com>
Subject: [RFC PATCH 3/7] Thermal: Add APIs to bind cdev to new zone structure
Date: Sat, 17 Nov 2012 16:15:54 +0530
Message-ID: <1353149158-19102-4-git-send-email-durgadoss.r@intel.com>
References: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25300 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab2KQKt2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 17 Nov 2012 05:49:28 -0500
In-Reply-To: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, linux-pm@vger.kernel.org
Cc: wni@nvidia.com, eduardo.valentin@ti.com, amit.kachhap@linaro.org, hongbo.zhang@linaro.org, sachin.kamat@linaro.org, Durgadoss R <durgadoss.r@intel.com>

This patch creates new APIs to add/remove a
cdev to/from a zone. This patch does not change
the old cooling_device implementation.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |  109 +++++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h       |    9 ++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 9d386d7..70e5f5a 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -58,6 +58,7 @@ static LIST_HEAD(thermal_governor_list);
 static DEFINE_MUTEX(thermal_list_lock);
 static DEFINE_MUTEX(ts_list_lock);
 static DEFINE_MUTEX(tz_list_lock);
+static DEFINE_MUTEX(cdev_list_lock);
 static DEFINE_MUTEX(thermal_governor_lock);
 
 #define for_each_thermal_sensor(pos) \
@@ -66,6 +67,9 @@ static DEFINE_MUTEX(thermal_governor_lock);
 #define for_each_thermal_zone(pos) \
 	list_for_each_entry(pos, &thermal_zone_list, node)
 
+#define for_each_cdev(pos) \
+	list_for_each_entry(pos, &thermal_cdev_list, node)
+
 static struct thermal_governor *__find_governor(const char *name)
 {
 	struct thermal_governor *pos;
@@ -428,6 +432,25 @@ static void thermal_zone_device_check(struct work_struct *work)
 	thermal_zone_device_update(tz);
 }
 
+static int get_cdev_indx(struct thermal_zone *tz,
+			struct thermal_cooling_device *cdev)
+{
+	int i, indx = -EINVAL;
+
+	if (!tz || !cdev)
+		return -EINVAL;
+
+	mutex_lock(&cdev_list_lock);
+	for (i = 0; i < tz->cdev_indx; i++) {
+		if (tz->cdevs[i] == cdev) {
+			indx = i;
+			break;
+		}
+	}
+	mutex_unlock(&cdev_list_lock);
+	return indx;
+}
+
 static int get_sensor_indx(struct thermal_zone *tz, struct thermal_sensor *ts)
 {
 	int i, indx = -EINVAL;
@@ -464,6 +487,24 @@ static void remove_sensor_from_zone(struct thermal_zone *tz,
 	tz->sensor_indx--;
 }
 
+static void remove_cdev_from_zone(struct thermal_zone *tz,
+				struct thermal_cooling_device *cdev)
+{
+	int indx, j;
+
+	indx = get_cdev_indx(tz, cdev);
+	if (indx < 0)
+		return;
+
+	sysfs_remove_link(&tz->device.kobj, kobject_name(&cdev->device.kobj));
+
+	/* Shift the entries in the tz->cdevs array */
+	for (j = indx; j < MAX_CDEVS_PER_ZONE - 1; j++)
+		tz->cdevs[j] = tz->cdevs[j + 1];
+
+	tz->cdev_indx--;
+}
+
 /* sys I/F for thermal zone */
 
 #define to_thermal_zone(_dev) \
@@ -1423,6 +1464,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 	int i;
 	const struct thermal_zone_params *tzp;
 	struct thermal_zone_device *tz;
+	struct thermal_zone *tmp_tz;
 	struct thermal_cooling_device *pos = NULL;
 
 	if (!cdev)
@@ -1460,6 +1502,13 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	mutex_unlock(&thermal_list_lock);
 
+	mutex_lock(&tz_list_lock);
+
+	for_each_thermal_zone(tmp_tz)
+		remove_cdev_from_zone(tmp_tz, cdev);
+
+	mutex_unlock(&tz_list_lock);
+
 	if (cdev->type[0])
 		device_remove_file(&cdev->device, &dev_attr_cdev_type);
 	device_remove_file(&cdev->device, &dev_attr_max_state);
@@ -1695,6 +1744,23 @@ exit:
 }
 EXPORT_SYMBOL(remove_thermal_zone);
 
+struct thermal_cooling_device *get_cdev_by_name(const char *name)
+{
+	struct thermal_cooling_device *pos;
+	struct thermal_cooling_device *cdev = NULL;
+
+	mutex_lock(&cdev_list_lock);
+	for_each_cdev(pos) {
+		if (!strnicmp(pos->type, name, THERMAL_NAME_LENGTH)) {
+			cdev = pos;
+			break;
+		}
+	}
+	mutex_unlock(&cdev_list_lock);
+	return cdev;
+}
+EXPORT_SYMBOL(get_cdev_by_name);
+
 struct thermal_sensor *get_sensor_by_name(const char *name)
 {
 	struct thermal_sensor *pos;
@@ -1755,6 +1821,49 @@ int add_sensor_to_zone(struct thermal_zone *tz, struct thermal_sensor *ts)
 }
 EXPORT_SYMBOL(add_sensor_to_zone);
 
+int add_cdev_to_zone_by_name(struct thermal_zone *tz, const char *name)
+{
+	int ret;
+	struct thermal_cooling_device *cdev = get_cdev_by_name(name);
+
+	if (!tz || !cdev)
+		return -EINVAL;
+
+	mutex_lock(&tz_list_lock);
+
+	/* Ensure we are not adding the same cdev again!! */
+	ret = get_cdev_indx(tz, cdev);
+	if (ret >= 0) {
+		ret = -EEXIST;
+		goto exit_zone;
+	}
+
+	mutex_lock(&cdev_list_lock);
+	ret = sysfs_create_link(&tz->device.kobj, &cdev->device.kobj,
+				kobject_name(&cdev->device.kobj));
+	if (ret)
+		goto exit_cdev;
+
+	tz->cdevs[tz->cdev_indx++] = cdev;
+
+exit_cdev:
+	mutex_unlock(&cdev_list_lock);
+exit_zone:
+	mutex_unlock(&tz_list_lock);
+	return ret;
+}
+EXPORT_SYMBOL(add_cdev_to_zone_by_name);
+
+int add_cdev_to_zone(struct thermal_zone *tz,
+			struct thermal_cooling_device *cdev)
+{
+	if (!tz || !cdev)
+		return -EINVAL;
+
+	return add_cdev_to_zone_by_name(tz, cdev->type);
+}
+EXPORT_SYMBOL(add_cdev_to_zone);
+
 /**
  * thermal_sensor_register - register a new thermal sensor
  * @name:	name of the thermal sensor
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 38438be..2913910 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -54,6 +54,8 @@
  */
 #define MAX_SENSORS_PER_ZONE		5
 
+#define MAX_CDEVS_PER_ZONE		5
+
 struct thermal_sensor;
 struct thermal_zone_device;
 struct thermal_cooling_device;
@@ -209,6 +211,10 @@ struct thermal_zone {
 	/* Sensor level information */
 	int sensor_indx; /* index into 'sensors' array */
 	struct thermal_sensor *sensors[MAX_SENSORS_PER_ZONE];
+
+	/* cdev level information */
+	int cdev_indx; /* index into 'cdevs' array */
+	struct thermal_cooling_device *cdevs[MAX_CDEVS_PER_ZONE];
 };
 
 /* Structure that holds thermal governor information */
@@ -289,6 +295,9 @@ void remove_thermal_zone(struct thermal_zone *);
 int add_sensor_to_zone(struct thermal_zone *, struct thermal_sensor *);
 int add_sensor_to_zone_by_name(struct thermal_zone *, const char *);
 
+int add_cdev_to_zone(struct thermal_zone *, struct thermal_cooling_device *);
+int add_cdev_to_zone_by_name(struct thermal_zone *, const char *);
+
 #ifdef CONFIG_NET
 extern int thermal_generate_netlink_event(u32 orig, enum events event);
 #else
-- 
1.7.9.5

