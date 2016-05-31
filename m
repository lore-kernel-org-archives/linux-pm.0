From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 24/48] thermal: core: move cooling device sysfs to thermal_sysfs.c
Date: Mon, 30 May 2016 23:18:31 -0700
Message-ID: <1464675535-2433-25-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

This is a code reorganization, simply to concentrate
the sysfs handling functions in thermal_sysfs.c.

This patch moves the cooling device handling functions.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c  | 128 +-------------------------------------
 drivers/thermal/thermal_core.h  |  11 ++++
 drivers/thermal/thermal_sysfs.c | 133 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 127 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a81faef..4c4f1b4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -741,132 +741,6 @@ int thermal_build_list_of_policies(char *buf)
 	return count;
 }
 
-/* sys I/F for cooling device */
-static ssize_t
-thermal_cooling_device_type_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-
-	return sprintf(buf, "%s\n", cdev->type);
-}
-
-static ssize_t
-thermal_cooling_device_max_state_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-	unsigned long state;
-	int ret;
-
-	ret = cdev->ops->get_max_state(cdev, &state);
-	if (ret)
-		return ret;
-	return sprintf(buf, "%ld\n", state);
-}
-
-static ssize_t
-thermal_cooling_device_cur_state_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-	unsigned long state;
-	int ret;
-
-	ret = cdev->ops->get_cur_state(cdev, &state);
-	if (ret)
-		return ret;
-	return sprintf(buf, "%ld\n", state);
-}
-
-static ssize_t
-thermal_cooling_device_cur_state_store(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf, size_t count)
-{
-	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-	unsigned long state;
-	int result;
-
-	if (sscanf(buf, "%ld\n", &state) != 1)
-		return -EINVAL;
-
-	if ((long)state < 0)
-		return -EINVAL;
-
-	result = cdev->ops->set_cur_state(cdev, state);
-	if (result)
-		return result;
-	return count;
-}
-
-static struct device_attribute dev_attr_cdev_type =
-__ATTR(type, 0444, thermal_cooling_device_type_show, NULL);
-static DEVICE_ATTR(max_state, 0444,
-		   thermal_cooling_device_max_state_show, NULL);
-static DEVICE_ATTR(cur_state, 0644,
-		   thermal_cooling_device_cur_state_show,
-		   thermal_cooling_device_cur_state_store);
-
-static ssize_t
-thermal_cooling_device_trip_point_show(struct device *dev,
-				       struct device_attribute *attr, char *buf)
-{
-	struct thermal_instance *instance;
-
-	instance =
-	    container_of(attr, struct thermal_instance, attr);
-
-	if (instance->trip == THERMAL_TRIPS_NONE)
-		return sprintf(buf, "-1\n");
-	else
-		return sprintf(buf, "%d\n", instance->trip);
-}
-
-static struct attribute *cooling_device_attrs[] = {
-	&dev_attr_cdev_type.attr,
-	&dev_attr_max_state.attr,
-	&dev_attr_cur_state.attr,
-	NULL,
-};
-
-static const struct attribute_group cooling_device_attr_group = {
-	.attrs = cooling_device_attrs,
-};
-
-static const struct attribute_group *cooling_device_attr_groups[] = {
-	&cooling_device_attr_group,
-	NULL,
-};
-
-static ssize_t
-thermal_cooling_device_weight_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct thermal_instance *instance;
-
-	instance = container_of(attr, struct thermal_instance, weight_attr);
-
-	return sprintf(buf, "%d\n", instance->weight);
-}
-
-static ssize_t
-thermal_cooling_device_weight_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	struct thermal_instance *instance;
-	int ret, weight;
-
-	ret = kstrtoint(buf, 0, &weight);
-	if (ret)
-		return ret;
-
-	instance = container_of(attr, struct thermal_instance, weight_attr);
-	instance->weight = weight;
-
-	return count;
-}
 /* Device management */
 
 /**
@@ -1118,7 +992,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->ops = ops;
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
-	cdev->device.groups = cooling_device_attr_groups;
+	thermal_cooling_device_setup_sysfs(cdev);
 	cdev->devdata = devdata;
 	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
 	result = device_register(&cdev->device);
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 5619243..2412b37 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -71,6 +71,17 @@ int thermal_build_list_of_policies(char *buf);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
+void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *);
+/* used only at binding time */
+ssize_t
+thermal_cooling_device_trip_point_show(struct device *,
+				       struct device_attribute *, char *);
+ssize_t thermal_cooling_device_weight_show(struct device *,
+					   struct device_attribute *, char *);
+
+ssize_t thermal_cooling_device_weight_store(struct device *,
+					    struct device_attribute *,
+					    const char *, size_t);
 
 #ifdef CONFIG_THERMAL_GOV_STEP_WISE
 int thermal_gov_step_wise_register(void);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 3d7ac7d..24a0c97 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -616,3 +616,136 @@ int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
 
 	return 0;
 }
+
+/* sys I/F for cooling device */
+static ssize_t
+thermal_cooling_device_type_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+
+	return sprintf(buf, "%s\n", cdev->type);
+}
+
+static ssize_t
+thermal_cooling_device_max_state_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	unsigned long state;
+	int ret;
+
+	ret = cdev->ops->get_max_state(cdev, &state);
+	if (ret)
+		return ret;
+	return sprintf(buf, "%ld\n", state);
+}
+
+static ssize_t
+thermal_cooling_device_cur_state_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	unsigned long state;
+	int ret;
+
+	ret = cdev->ops->get_cur_state(cdev, &state);
+	if (ret)
+		return ret;
+	return sprintf(buf, "%ld\n", state);
+}
+
+static ssize_t
+thermal_cooling_device_cur_state_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	unsigned long state;
+	int result;
+
+	if (sscanf(buf, "%ld\n", &state) != 1)
+		return -EINVAL;
+
+	if ((long)state < 0)
+		return -EINVAL;
+
+	result = cdev->ops->set_cur_state(cdev, state);
+	if (result)
+		return result;
+	return count;
+}
+
+static struct device_attribute dev_attr_cdev_type =
+__ATTR(type, 0444, thermal_cooling_device_type_show, NULL);
+static DEVICE_ATTR(max_state, 0444,
+		   thermal_cooling_device_max_state_show, NULL);
+static DEVICE_ATTR(cur_state, 0644,
+		   thermal_cooling_device_cur_state_show,
+		   thermal_cooling_device_cur_state_store);
+
+static struct attribute *cooling_device_attrs[] = {
+	&dev_attr_cdev_type.attr,
+	&dev_attr_max_state.attr,
+	&dev_attr_cur_state.attr,
+	NULL,
+};
+
+static const struct attribute_group cooling_device_attr_group = {
+	.attrs = cooling_device_attrs,
+};
+
+static const struct attribute_group *cooling_device_attr_groups[] = {
+	&cooling_device_attr_group,
+	NULL,
+};
+
+void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *cdev)
+{
+	cdev->device.groups = cooling_device_attr_groups;
+}
+
+/* these helper will be used only at the time of bindig */
+ssize_t
+thermal_cooling_device_trip_point_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct thermal_instance *instance;
+
+	instance =
+	    container_of(attr, struct thermal_instance, attr);
+
+	if (instance->trip == THERMAL_TRIPS_NONE)
+		return sprintf(buf, "-1\n");
+	else
+		return sprintf(buf, "%d\n", instance->trip);
+}
+
+ssize_t
+thermal_cooling_device_weight_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct thermal_instance *instance;
+
+	instance = container_of(attr, struct thermal_instance, weight_attr);
+
+	return sprintf(buf, "%d\n", instance->weight);
+}
+
+ssize_t
+thermal_cooling_device_weight_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct thermal_instance *instance;
+	int ret, weight;
+
+	ret = kstrtoint(buf, 0, &weight);
+	if (ret)
+		return ret;
+
+	instance = container_of(attr, struct thermal_instance, weight_attr);
+	instance->weight = weight;
+
+	return count;
+}
-- 
2.1.4
