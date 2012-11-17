From: Durgadoss R <durgadoss.r@intel.com>
Subject: [RFC PATCH 1/7] Thermal: Create sensor level APIs
Date: Sat, 17 Nov 2012 16:15:52 +0530
Message-ID: <1353149158-19102-2-git-send-email-durgadoss.r@intel.com>
References: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25300 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753774Ab2KQKtX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 17 Nov 2012 05:49:23 -0500
In-Reply-To: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, linux-pm@vger.kernel.org
Cc: wni@nvidia.com, eduardo.valentin@ti.com, amit.kachhap@linaro.org, hongbo.zhang@linaro.org, sachin.kamat@linaro.org, Durgadoss R <durgadoss.r@intel.com>

This patch creates sensor level APIs, in the
generic thermal framework. With this, thermal
sensor drivers can register/unregister themselves
with the thermal framework, and thus can participate
in platform thermal management.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 drivers/thermal/thermal_sys.c |  212 +++++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h       |   27 ++++++
 2 files changed, 239 insertions(+)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 8f0f37b..e726c8b 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -45,13 +45,16 @@ MODULE_LICENSE("GPL");
 
 static DEFINE_IDR(thermal_tz_idr);
 static DEFINE_IDR(thermal_cdev_idr);
+static DEFINE_IDR(thermal_sensor_idr);
 static DEFINE_MUTEX(thermal_idr_lock);
 
 static LIST_HEAD(thermal_tz_list);
+static LIST_HEAD(thermal_sensor_list);
 static LIST_HEAD(thermal_cdev_list);
 static LIST_HEAD(thermal_governor_list);
 
 static DEFINE_MUTEX(thermal_list_lock);
+static DEFINE_MUTEX(ts_list_lock);
 static DEFINE_MUTEX(thermal_governor_lock);
 
 static struct thermal_governor *__find_governor(const char *name)
@@ -421,6 +424,66 @@ static void thermal_zone_device_check(struct work_struct *work)
 #define to_thermal_zone(_dev) \
 	container_of(_dev, struct thermal_zone_device, device)
 
+#define to_thermal_sensor(_dev) \
+	container_of(_dev, struct thermal_sensor, device)
+
+static ssize_t
+sensor_name_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct thermal_sensor *ts = to_thermal_sensor(dev);
+
+	return sprintf(buf, "%s\n", ts->name);
+}
+
+static ssize_t
+sensor_temp_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int ret;
+	long val;
+	struct thermal_sensor *ts = to_thermal_sensor(dev);
+
+	ret = ts->ops->get_temp(ts, &val);
+
+	return ret ? ret : sprintf(buf, "%ld\n", val);
+}
+
+static ssize_t
+threshold_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int indx, ret;
+	long val;
+	struct thermal_sensor *ts = to_thermal_sensor(dev);
+
+	if (!sscanf(attr->attr.name, "threshold%d", &indx))
+		return -EINVAL;
+
+	ret = ts->ops->get_threshold(ts, indx, &val);
+
+	return ret ? ret : sprintf(buf, "%ld\n", val);
+}
+
+static ssize_t
+threshold_store(struct device *dev, struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int indx, ret;
+	long val;
+	struct thermal_sensor *ts = to_thermal_sensor(dev);
+
+	if (!ts->ops->set_threshold)
+		return -EPERM;
+
+	if (!sscanf(attr->attr.name, "threshold%d", &indx))
+		return -EINVAL;
+
+	if (kstrtol(buf, 10, &val))
+		return -EINVAL;
+
+	ret = ts->ops->set_threshold(ts, indx, val);
+
+	return ret ? ret : count;
+}
+
 static ssize_t
 type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -705,6 +768,10 @@ static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
 static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
 static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
 
+/* Thermal sensor attributes */
+static DEVICE_ATTR(sensor_name, 0444, sensor_name_show, NULL);
+static DEVICE_ATTR(temp_input, 0444, sensor_temp_show, NULL);
+
 /* sys I/F for cooling device */
 #define to_cooling_device(_dev)	\
 	container_of(_dev, struct thermal_cooling_device, device)
@@ -1491,6 +1558,151 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
 }
 
 /**
+ * thermal_sensor_register - register a new thermal sensor
+ * @name:	name of the thermal sensor
+ * @ops:	standard thermal sensor callbacks
+ * @devdata:	private device data
+ */
+struct thermal_sensor *thermal_sensor_register(const char *name,
+			struct thermal_sensor_ops *ops, void *devdata)
+{
+	struct thermal_sensor *ts;
+	int ret;
+
+	if (!name || (name && strlen(name) >= THERMAL_NAME_LENGTH))
+		return ERR_PTR(-EINVAL);
+
+	if (!ops || !ops->get_temp)
+		return ERR_PTR(-EINVAL);
+
+	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return ERR_PTR(-ENOMEM);
+
+	idr_init(&ts->idr);
+	ret = get_idr(&thermal_sensor_idr, &thermal_idr_lock, &ts->id);
+	if (ret)
+		goto exit_free;
+
+	strcpy(ts->name, name);
+	ts->ops = ops;
+	ts->devdata = devdata;
+	ts->device.class = &thermal_class;
+
+	dev_set_name(&ts->device, "sensor%d", ts->id);
+	ret = device_register(&ts->device);
+	if (ret)
+		goto exit_idr;
+
+	ret = device_create_file(&ts->device, &dev_attr_sensor_name);
+	if (ret)
+		goto exit_unregister;
+
+	ret = device_create_file(&ts->device, &dev_attr_temp_input);
+	if (ret)
+		goto exit_name;
+
+	/* Add this sensor to the global list of sensors */
+	mutex_lock(&ts_list_lock);
+	list_add_tail(&ts->node, &thermal_sensor_list);
+	mutex_unlock(&ts_list_lock);
+
+	return ts;
+
+exit_name:
+	device_remove_file(&ts->device, &dev_attr_sensor_name);
+exit_unregister:
+	device_unregister(&ts->device);
+exit_idr:
+	release_idr(&thermal_sensor_idr, &thermal_idr_lock, ts->id);
+exit_free:
+	kfree(ts);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(thermal_sensor_register);
+
+void thermal_sensor_unregister(struct thermal_sensor *ts)
+{
+	int i;
+	struct thermal_sensor *pos, *next;
+	bool found = false;
+
+	if (!ts)
+		return;
+
+	mutex_lock(&ts_list_lock);
+	list_for_each_entry_safe(pos, next, &thermal_sensor_list, node) {
+		if (pos == ts) {
+			list_del(&ts->node);
+			found = true;
+			break;
+		}
+	}
+	mutex_unlock(&ts_list_lock);
+
+	if (!found)
+		return;
+
+	for (i = 0; i < ts->thresholds; i++)
+		device_remove_file(&ts->device, &ts->thresh_attrs[i].attr);
+
+	device_remove_file(&ts->device, &dev_attr_sensor_name);
+	device_remove_file(&ts->device, &dev_attr_temp_input);
+
+	release_idr(&thermal_sensor_idr, &thermal_idr_lock, ts->id);
+	idr_destroy(&ts->idr);
+
+	device_unregister(&ts->device);
+
+	kfree(ts);
+	return;
+}
+EXPORT_SYMBOL(thermal_sensor_unregister);
+
+int enable_sensor_thresholds(struct thermal_sensor *ts, int count)
+{
+	int i, ret;
+	int size = sizeof(struct thermal_attr) * count;
+
+	if (count == 0)
+		return 0; /* Not an error */
+
+	if (unlikely(!ts) || !ts->ops->get_threshold)
+		return -EINVAL;
+
+	ts->thresh_attrs = kzalloc(size, GFP_KERNEL);
+	if (!ts->thresh_attrs)
+		return -ENOMEM;
+
+	ts->thresholds = count;
+
+	/* Create threshold attributes */
+	for (i = 0; i < count; i++) {
+		snprintf(ts->thresh_attrs[i].name, THERMAL_NAME_LENGTH,
+						 "threshold%d", i);
+
+		sysfs_attr_init(&ts->thresh_attrs[i].attr.attr);
+		ts->thresh_attrs[i].attr.attr.name =
+						ts->thresh_attrs[i].name;
+		ts->thresh_attrs[i].attr.attr.mode = S_IRUGO | S_IWUSR;
+		ts->thresh_attrs[i].attr.show = threshold_show;
+		ts->thresh_attrs[i].attr.store = threshold_store;
+
+		ret = device_create_file(&ts->device,
+					&ts->thresh_attrs[i].attr);
+		if (ret)
+			goto exit_fail;
+	}
+	return 0;
+
+exit_fail:
+	while (--i >= 0)
+		device_remove_file(&ts->device, &ts->thresh_attrs[i].attr);
+	return ret;
+}
+EXPORT_SYMBOL(enable_sensor_thresholds);
+
+/**
  * thermal_zone_device_register - register a new thermal zone device
  * @type:	the thermal zone device type
  * @trips:	the number of trip points the thermal zone support
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 807f214..e2f85ec 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -49,6 +49,7 @@
 /* Default Thermal Governor: Does Linear Throttling */
 #define DEFAULT_THERMAL_GOVERNOR	"step_wise"
 
+struct thermal_sensor;
 struct thermal_zone_device;
 struct thermal_cooling_device;
 
@@ -127,6 +128,13 @@ struct thermal_cooling_device_ops {
 	int (*set_cur_state) (struct thermal_cooling_device *, unsigned long);
 };
 
+struct thermal_sensor_ops {
+	int (*get_temp) (struct thermal_sensor *, long *);
+	int (*get_trend) (struct thermal_sensor *, int, enum thermal_trend *);
+	int (*set_threshold) (struct thermal_sensor *, int, long);
+	int (*get_threshold) (struct thermal_sensor *, int, long *);
+};
+
 struct thermal_cooling_device {
 	int id;
 	char type[THERMAL_NAME_LENGTH];
@@ -144,6 +152,20 @@ struct thermal_attr {
 	char name[THERMAL_NAME_LENGTH];
 };
 
+struct thermal_sensor {
+	char name[THERMAL_NAME_LENGTH];
+	int id;
+	int temp;
+	int prev_temp;
+	int thresholds;
+	void *devdata;
+	struct idr idr;
+	struct device device;
+	struct list_head node;
+	struct thermal_sensor_ops *ops;
+	struct thermal_attr *thresh_attrs;
+};
+
 struct thermal_zone_device {
 	int id;
 	char type[THERMAL_NAME_LENGTH];
@@ -237,6 +259,11 @@ void notify_thermal_framework(struct thermal_zone_device *, int);
 int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
 
+struct thermal_sensor *thermal_sensor_register(const char *,
+				struct thermal_sensor_ops *, void *);
+void thermal_sensor_unregister(struct thermal_sensor *);
+int enable_sensor_thresholds(struct thermal_sensor *, int);
+
 #ifdef CONFIG_NET
 extern int thermal_generate_netlink_event(u32 orig, enum events event);
 #else
-- 
1.7.9.5

