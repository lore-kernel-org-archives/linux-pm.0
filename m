From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v3] thermal: add available policies sysfs attribute
Date: Tue, 14 Jul 2015 15:40:56 +0800
Message-ID: <1436859656-16964-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7177 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbbGNHlA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2015 03:41:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: javi.merino@arm.com, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Wei Ni <wni@nvidia.com>

The Linux thermal framework support to change thermal governor
policy in userspace, but it can't show what available policies
supported.

This patch adds available_policies attribute to the thermal
framework, it can list the thermal governors which can be
used for a particular zone. This attribute is read only.

Signed-off-by: Wei Ni <wni@nvidia.com>
Reviewed-by: Javi Merino <javi.merino@arm.com>
---
v3: Initialize "size" as PAGE_SIZE.
v2: This change had been submitted and discussed in
http://marc.info/?l=linux-tegra&m=138961183931457&w=2
https://www.marc.info/?l=linux-pm&m=138986468007449&w=1
cherry-picked it,and updated to this v2 version.

 Documentation/thermal/sysfs-api.txt |  6 ++++++
 drivers/thermal/thermal_core.c      | 28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index c1f6864a8c5d..10f062ea6bc2 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -180,6 +180,7 @@ Thermal zone device sys I/F, created once it's registered:
     |---temp:			Current temperature
     |---mode:			Working mode of the thermal zone
     |---policy:			Thermal governor used for this zone
+    |---available_policies:	Available thermal governors for this zone
     |---trip_point_[0-*]_temp:	Trip point temperature
     |---trip_point_[0-*]_type:	Trip point type
     |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
@@ -256,6 +257,10 @@ policy
 	One of the various thermal governors used for a particular zone.
 	RW, Required
 
+available_policies
+	Available thermal governors which can be used for a particular zone.
+	RO, Required
+
 trip_point_[0-*]_temp
 	The temperature above which trip point will be fired.
 	Unit: millidegree Celsius
@@ -417,6 +422,7 @@ method, the sys I/F structure will be built like this:
     |---temp:			37000
     |---mode:			enabled
     |---policy:			step_wise
+    |---available_policies:	step_wise fair_share
     |---trip_point_0_temp:	100000
     |---trip_point_0_type:	critical
     |---trip_point_1_temp:	80000
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 04659bfb888b..c4700950e42e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -847,6 +847,27 @@ policy_show(struct device *dev, struct device_attribute *devattr, char *buf)
 	return sprintf(buf, "%s\n", tz->governor->name);
 }
 
+static ssize_t
+available_policies_show(struct device *dev, struct device_attribute *devattr,
+			char *buf)
+{
+	struct thermal_governor *pos;
+	ssize_t count = 0;
+	ssize_t size = PAGE_SIZE;
+
+	mutex_lock(&thermal_governor_lock);
+
+	list_for_each_entry(pos, &thermal_governor_list, governor_list) {
+		size = PAGE_SIZE - count;
+		count += scnprintf(buf + count, size, "%s ", pos->name);
+	}
+	count += scnprintf(buf + count, size, "\n");
+
+	mutex_unlock(&thermal_governor_lock);
+
+	return count;
+}
+
 #ifdef CONFIG_THERMAL_EMULATION
 static ssize_t
 emul_temp_store(struct device *dev, struct device_attribute *attr,
@@ -1032,6 +1053,7 @@ static DEVICE_ATTR(temp, 0444, temp_show, NULL);
 static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
 static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
 static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
+static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_show, NULL);
 
 /* sys I/F for cooling device */
 #define to_cooling_device(_dev)	\
@@ -1817,6 +1839,11 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	if (result)
 		goto unregister;
 
+	/* Create available_policies attribute */
+	result = device_create_file(&tz->device, &dev_attr_available_policies);
+	if (result)
+		goto unregister;
+
 	/* Update 'this' zone's governor information */
 	mutex_lock(&thermal_governor_lock);
 
@@ -1917,6 +1944,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	if (tz->ops->get_mode)
 		device_remove_file(&tz->device, &dev_attr_mode);
 	device_remove_file(&tz->device, &dev_attr_policy);
+	device_remove_file(&tz->device, &dev_attr_available_policies);
 	remove_trip_attrs(tz);
 	thermal_set_governor(tz, NULL);
 
-- 
1.9.1

