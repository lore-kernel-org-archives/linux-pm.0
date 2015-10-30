From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 1/3] thermal: Add support for hierarchical thermal zones
Date: Fri, 30 Oct 2015 16:46:09 +0000
Message-ID: <1446223571-23272-2-git-send-email-javi.merino@arm.com>
References: <1446223571-23272-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446223571-23272-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rui.zang@intel.com, edubezval@gmail.com, Punit.Agrawal@arm.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Add the ability to stack thermal zones on top of each other, creating a
hierarchy of thermal zones.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 Documentation/thermal/sysfs-api.txt |  35 +++++++++
 drivers/thermal/thermal_core.c      | 151 ++++++++++++++++++++++++++++++++++--
 include/linux/thermal.h             |  16 ++++
 3 files changed, 197 insertions(+), 5 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 10f062ea6bc2..5650b7eaaf7e 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -72,6 +72,41 @@ temperature) and throttle appropriate devices.
     It deletes the corresponding entry form /sys/class/thermal folder and
     unbind all the thermal cooling devices it uses.
 
+
+1.1.3 int thermal_zone_add_subtz(struct thermal_zone_device *tz,
+                                 struct thermal_zone_device *subtz)
+
+    Add subtz to the list of slaves of tz.  When calculating the
+    temperature of thermal zone tz, report the maximum of the slave
+    thermal zones.  This lets you create a hierarchy of thermal zones.
+    The hierarchy must be a Direct Acyclic Graph (DAG).  If a loop is
+    detected, thermal_zone_get_temp() will return -EDEADLK to prevent
+    the deadlock.  thermal_zone_add_subtz() does not affect subtz.
+
+    For example, if you have an SoC with a thermal sensor in each cpu
+    of the two cpus you could have a thermal zone to monitor each
+    sensor, let's call them cpu0_tz and cpu1_tz.  You could then have a
+    a SoC thermal zone (soc_tz) without a get_temp() op which can be
+    configured like this:
+
+    thermal_zone_add_subtz(soc_tz, cpu0_tz);
+    thermal_zone_add_subtz(soc_tz, cpu1_tz);
+
+    Now soc_tz's temperature is the maximum of cpu0_tz and cpu1_tz.
+    Furthermore, soc_tz could be combined with other thermal zones to
+    create a "device" thermal zone.
+
+
+1.1.4 int thermal_zone_del_subtz(struct thermal_zone_device *tz,
+                                 struct thermal_zone_device *subtz)
+
+    Delete subtz from the slave thermal zones of tz.  This basically
+    reverses what thermal_zone_add_subtz() does.  If tz still has
+    other slave thermal zones, its temperature would be the maximum of
+    the remaining slave thermal zones.  If tz no longer has slave
+    thermal zones, thermal_zone_get_temp() will return -EINVAL.
+
+
 1.2 thermal cooling device interface
 1.2.1 struct thermal_cooling_device *thermal_cooling_device_register(char *name,
 		void *devdata, struct thermal_cooling_device_ops *)
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d9e525cc9c1c..a2ab482337f3 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -61,6 +61,11 @@ static DEFINE_MUTEX(thermal_governor_lock);
 
 static struct thermal_governor *def_governor;
 
+struct thermal_zone_link {
+	struct thermal_zone_device *slave;
+	struct list_head node;
+};
+
 static struct thermal_governor *__find_governor(const char *name)
 {
 	struct thermal_governor *pos;
@@ -465,6 +470,42 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 }
 
 /**
+ * get_subtz_temp() - get the maximum temperature of all the sub thermal zones
+ * @tz:	thermal zone pointer
+ * @temp: pointer in which to store the result
+ *
+ * Go through all the thermal zones listed in @tz slave_tzs and
+ * calculate the maximum temperature of all of them.  The maximum
+ * temperature is stored in @temp.
+ *
+ * Return: 0 on success, -EINVAL if there are no slave thermal zones,
+ * -E* if thermal_zone_get_temp() fails for any of the slave thermal
+ * zones.
+ */
+static int get_subtz_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct thermal_zone_link *link;
+	int max_temp = INT_MIN;
+
+	if (list_empty(&tz->slave_tzs))
+		return -EINVAL;
+
+	list_for_each_entry(link, &tz->slave_tzs, node) {
+		int this_temp, ret;
+
+		ret = thermal_zone_get_temp(link->slave, &this_temp);
+		if (ret)
+			return ret;
+
+		if (this_temp > max_temp)
+			max_temp = this_temp;
+	}
+
+	*temp = max_temp;
+	return 0;
+}
+
+/**
  * thermal_zone_get_temp() - returns the temperature of a thermal zone
  * @tz: a valid pointer to a struct thermal_zone_device
  * @temp: a valid pointer to where to store the resulting temperature.
@@ -481,11 +522,22 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	int crit_temp = INT_MAX;
 	enum thermal_trip_type type;
 
-	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
+	if (!tz || IS_ERR(tz))
 		goto exit;
 
+	/* Avoid loops */
+	if (tz->slave_tz_visited)
+		return -EDEADLK;
+
 	mutex_lock(&tz->lock);
 
+	tz->slave_tz_visited = true;
+
+	if (!tz->ops->get_temp) {
+		ret = get_subtz_temp(tz, temp);
+		goto unlock;
+	}
+
 	ret = tz->ops->get_temp(tz, temp);
 
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
@@ -506,7 +558,9 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 		if (!ret && *temp < crit_temp)
 			*temp = tz->emul_temperature;
 	}
- 
+
+unlock:
+	tz->slave_tz_visited = false;
 	mutex_unlock(&tz->lock);
 exit:
 	return ret;
@@ -540,9 +594,6 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 {
 	int count;
 
-	if (!tz->ops->get_temp)
-		return;
-
 	update_temperature(tz);
 
 	for (count = 0; count < tz->trips; count++)
@@ -1789,6 +1840,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
 
+	INIT_LIST_HEAD(&tz->slave_tzs);
 	INIT_LIST_HEAD(&tz->thermal_instances);
 	idr_init(&tz->idr);
 	mutex_init(&tz->lock);
@@ -1921,6 +1973,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	const struct thermal_zone_params *tzp;
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
+	struct thermal_zone_link *link, *tmp;
 
 	if (!tz)
 		return;
@@ -1958,6 +2011,9 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	mutex_unlock(&thermal_list_lock);
 
+	list_for_each_entry_safe(link, tmp, &tz->slave_tzs, node)
+		thermal_zone_del_subtz(tz, link->slave);
+
 	thermal_zone_device_set_polling(tz, 0);
 
 	if (tz->type[0])
@@ -1980,6 +2036,91 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
 
 /**
+ * thermal_zone_add_subtz() - add a sub thermal zone to a thermal zone
+ * @tz:	pointer to the master thermal zone
+ * @subtz: pointer to the slave thermal zone
+ *
+ * Add @subtz to the list of slave thermal zones of @tz.  If @tz
+ * doesn't provide a get_temp() op, its temperature will be calculated
+ * as a combination of the temperatures of its sub thermal zones.  See
+ * get_sub_tz_temp() for more information on how it's calculated.
+ *
+ * Return: 0 on success, -EINVAL if @tz or @subtz are not valid
+ * pointers, -EEXIST if the link already exists or -ENOMEM if we ran
+ * out of memory.
+ */
+int thermal_zone_add_subtz(struct thermal_zone_device *tz,
+			   struct thermal_zone_device *subtz)
+{
+	int ret;
+	struct thermal_zone_link *link;
+
+	if (IS_ERR_OR_NULL(tz) || IS_ERR_OR_NULL(subtz))
+		return -EINVAL;
+
+	mutex_lock(&tz->lock);
+
+	list_for_each_entry(link, &tz->slave_tzs, node) {
+		if (link->slave == subtz) {
+			ret = -EEXIST;
+			goto unlock;
+		}
+	}
+
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	link->slave = subtz;
+	list_add_tail(&link->node, &tz->slave_tzs);
+
+	ret = 0;
+
+unlock:
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+
+/**
+ * thermal_zone_del_subtz() - delete a sub thermal zone from its master thermal zone
+ * @tz:	pointer to the master thermal zone
+ * @subtz: pointer to the slave thermal zone
+ *
+ * Remove @subtz from the list of slave thermal zones of @tz.
+ *
+ * Return: 0 on success, -EINVAL if either thermal is invalid or if
+ * @subtz is not a slave of @tz.
+ */
+int thermal_zone_del_subtz(struct thermal_zone_device *tz,
+			   struct thermal_zone_device *subtz)
+{
+	int ret = -EINVAL;
+	struct thermal_zone_link *link;
+
+	if (IS_ERR_OR_NULL(tz) || IS_ERR_OR_NULL(subtz))
+		return -EINVAL;
+
+	mutex_lock(&tz->lock);
+
+	list_for_each_entry(link, &tz->slave_tzs, node) {
+		if (link->slave == subtz) {
+			list_del(&link->node);
+			kfree(link);
+
+			ret = 0;
+			break;
+		}
+	}
+
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+
+/**
  * thermal_zone_get_zone_by_name() - search for a zone and returns its ref
  * @name: thermal zone name to fetch the temperature
  *
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 157d366e761b..7996b4e7e61a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -168,6 +168,8 @@ struct thermal_attr {
  * @ops:	operations this &thermal_zone_device supports
  * @tzp:	thermal zone parameters
  * @governor:	pointer to the governor for this thermal zone
+ * @slave_tzs:	list of thermal zones that are a slave of this thermal zone
+ * @slave_tz_visited: used to detect loops in stacked thermal zones
  * @governor_data:	private pointer for governor data
  * @thermal_instances:	list of &struct thermal_instance of this thermal zone
  * @idr:	&struct idr to generate unique id for this zone's cooling
@@ -195,6 +197,8 @@ struct thermal_zone_device {
 	struct thermal_zone_device_ops *ops;
 	struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;
+	struct list_head slave_tzs;
+	bool slave_tz_visited;
 	void *governor_data;
 	struct list_head thermal_instances;
 	struct idr idr;
@@ -403,6 +407,10 @@ struct thermal_cooling_device *
 thermal_of_cooling_device_register(struct device_node *np, char *, void *,
 				   const struct thermal_cooling_device_ops *);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
+int thermal_zone_add_subtz(struct thermal_zone_device *,
+			   struct thermal_zone_device *);
+int thermal_zone_del_subtz(struct thermal_zone_device *,
+			   struct thermal_zone_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 
@@ -455,6 +463,14 @@ thermal_of_cooling_device_register(struct device_node *np,
 static inline void thermal_cooling_device_unregister(
 	struct thermal_cooling_device *cdev)
 { }
+static inline struct thermal_zone_device *
+thermal_zone_add_subtz(struct thermal_zone_device *tz,
+		       struct thermal_zone_device *subtz)
+{ return -ENODEV; }
+static inline struct thermal_zone_device *
+thermal_zone_del_subtz(struct thermal_zone_device *tz,
+		       struct thermal_zone_device *subtz)
+{ return -ENODEV; }
 static inline struct thermal_zone_device *thermal_zone_get_zone_by_name(
 		const char *name)
 { return ERR_PTR(-ENODEV); }
-- 
1.9.1
