From: Wei Ni <wni@nvidia.com>
Subject: [PATCH] thermal: add available policies sysfs attribute
Date: Thu, 7 May 2015 18:07:08 +0800
Message-ID: <1430993228-28142-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17076 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbbEGKHB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 06:07:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Wei Ni <wni@nvidia.com>

Adds avaiable_policies sysfs attribute to a thermal zone.
This attribute show the avaible governor can be used for the
zone. This is a R attribute.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/thermal_core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 962de1847cc0..bc202aaceb00 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -847,6 +847,24 @@ policy_show(struct device *dev, struct device_attribute *devattr, char *buf)
 	return sprintf(buf, "%s\n", tz->governor->name);
 }
 
+static ssize_t
+available_policies_show(struct device *dev, struct device_attribute *devattr,
+			char *buf)
+{
+	struct thermal_governor *pos;
+	ssize_t count = 0;
+
+	mutex_lock(&thermal_governor_lock);
+
+	list_for_each_entry(pos, &thermal_governor_list, governor_list)
+		count += sprintf(buf + count, "%s ", pos->name);
+	count += sprintf(buf + count, "\n");
+
+	mutex_unlock(&thermal_governor_lock);
+
+	return count;
+}
+
 #ifdef CONFIG_THERMAL_EMULATION
 static ssize_t
 emul_temp_store(struct device *dev, struct device_attribute *attr,
@@ -1028,6 +1046,7 @@ static DEVICE_ATTR(temp, 0444, temp_show, NULL);
 static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
 static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
 static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
+static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_show, NULL);
 
 /* sys I/F for cooling device */
 #define to_cooling_device(_dev)	\
@@ -1813,6 +1832,11 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	if (result)
 		goto unregister;
 
+	/* Create available_policies attribute */
+	result = device_create_file(&tz->device, &dev_attr_available_policies);
+	if (result)
+		goto unregister;
+
 	/* Update 'this' zone's governor information */
 	mutex_lock(&thermal_governor_lock);
 
@@ -1913,6 +1937,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	if (tz->ops->get_mode)
 		device_remove_file(&tz->device, &dev_attr_mode);
 	device_remove_file(&tz->device, &dev_attr_policy);
+	device_remove_file(&tz->device, &dev_attr_available_policies);
 	remove_trip_attrs(tz);
 	thermal_set_governor(tz, NULL);
 
-- 
1.9.1

