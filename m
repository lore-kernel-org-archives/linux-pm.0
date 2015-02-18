From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v3 4/5] thermal: export weight to sysfs
Date: Wed, 18 Feb 2015 16:04:24 +0000
Message-ID: <1424275465-16144-5-git-send-email-javi.merino@arm.com>
References: <1424275465-16144-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:44013 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbbBRQFS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 11:05:18 -0500
In-Reply-To: <1424275465-16144-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Javi Merino <javi.merino@arm.com>

It's useful to have access to the weights for the cooling devices for
thermal zones and change them if needed.  Export them to sysfs.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 Documentation/thermal/sysfs-api.txt | 15 +++++++++++++-
 drivers/thermal/thermal_core.c      | 40 +++++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_core.h      |  2 ++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 7ec632ed9769..3625453ceef6 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -194,6 +194,8 @@ thermal_zone_bind_cooling_device/thermal_zone_unbind_cooling_device.
 /sys/class/thermal/thermal_zone[0-*]:
     |---cdev[0-*]:		[0-*]th cooling device in current thermal zone
     |---cdev[0-*]_trip_point:	Trip point that cdev[0-*] is associated with
+    |---cdev[0-*]_weight:       Influence of the cooling device in
+                                this thermal zone
 
 Besides the thermal zone device sysfs I/F and cooling device sysfs I/F,
 the generic thermal driver also creates a hwmon sysfs I/F for each _type_
@@ -267,6 +269,14 @@ cdev[0-*]_trip_point
 	point.
 	RO, Optional
 
+cdev[0-*]_weight
+        The influence of cdev[0-*] in this thermal zone. This value
+        is relative to the rest of cooling devices in the thermal
+        zone. For example, if a cooling device has a weight double
+        than that of other, it's twice as effective in cooling the
+        thermal zone.
+        RW, Optional
+
 passive
 	Attribute is only present for zones in which the passive cooling
 	policy is not supported by native thermal driver. Default is zero
@@ -320,7 +330,8 @@ passive, active. If an ACPI thermal zone supports critical, passive,
 active[0] and active[1] at the same time, it may register itself as a
 thermal_zone_device (thermal_zone1) with 4 trip points in all.
 It has one processor and one fan, which are both registered as
-thermal_cooling_device.
+thermal_cooling_device. Both are considered to have the same
+effectiveness in cooling the thermal zone.
 
 If the processor is listed in _PSL method, and the fan is listed in _AL0
 method, the sys I/F structure will be built like this:
@@ -342,8 +353,10 @@ method, the sys I/F structure will be built like this:
     |---trip_point_3_type:	active1
     |---cdev0:			--->/sys/class/thermal/cooling_device0
     |---cdev0_trip_point:	1	/* cdev0 can be used for passive */
+    |---cdev0_weight:           1024
     |---cdev1:			--->/sys/class/thermal/cooling_device3
     |---cdev1_trip_point:	2	/* cdev1 can be used for active[0]*/
+    |---cdev1_weight:           1024
 
 |cooling_device0:
     |---type:			Processor
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9a424a66c83a..eaa704043e51 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -904,6 +904,34 @@ thermal_cooling_device_trip_point_show(struct device *dev,
 		return sprintf(buf, "%d\n", instance->trip);
 }
 
+static ssize_t
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
+static ssize_t
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
 /* Device management */
 
 /**
@@ -998,6 +1026,16 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	if (result)
 		goto remove_symbol_link;
 
+	sprintf(dev->weight_attr_name, "cdev%d_weight", dev->id);
+	sysfs_attr_init(&dev->weight_attr.attr);
+	dev->weight_attr.attr.name = dev->weight_attr_name;
+	dev->weight_attr.attr.mode = S_IWUSR | S_IRUGO;
+	dev->weight_attr.show = thermal_cooling_device_weight_show;
+	dev->weight_attr.store = thermal_cooling_device_weight_store;
+	result = device_create_file(&tz->device, &dev->weight_attr);
+	if (result)
+		goto remove_trip_file;
+
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
@@ -1015,6 +1053,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	if (!result)
 		return 0;
 
+	device_remove_file(&tz->device, &dev->weight_attr);
+remove_trip_file:
 	device_remove_file(&tz->device, &dev->attr);
 remove_symbol_link:
 	sysfs_remove_link(&tz->device.kobj, dev->name);
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 7a465e9d456c..faebe881f062 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -46,6 +46,8 @@ struct thermal_instance {
 	unsigned long target;	/* expected cooling state */
 	char attr_name[THERMAL_NAME_LENGTH];
 	struct device_attribute attr;
+	char weight_attr_name[THERMAL_NAME_LENGTH];
+	struct device_attribute weight_attr;
 	struct list_head tz_node; /* node in tz->thermal_instances */
 	struct list_head cdev_node; /* node in cdev->thermal_instances */
 	unsigned int weight; /* The weight of the cooling device */
-- 
1.9.1

