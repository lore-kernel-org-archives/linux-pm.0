From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 07/34] Thermal: Add a policy sysfs attribute
Date: Sun,  2 Dec 2012 22:44:41 +0800
Message-ID: <1354459508-3707-7-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:34443 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631Ab2LBOpg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:36 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch adds a policy sysfs attribute to a thermal zone.
This attribute denotes the throttling governor used for the
zone. This is a RW attribute.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |   42 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 0afd84c..a6933da 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -454,10 +454,41 @@ passive_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%d\n", tz->forced_passive);
 }
 
+static ssize_t
+policy_store(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
+{
+	int ret = -EINVAL;
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_governor *gov;
+
+	mutex_lock(&thermal_governor_lock);
+
+	gov = __find_governor(buf);
+	if (!gov)
+		goto exit;
+
+	tz->governor = gov;
+	ret = count;
+
+exit:
+	mutex_unlock(&thermal_governor_lock);
+	return ret;
+}
+
+static ssize_t
+policy_show(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+
+	return sprintf(buf, "%s\n", tz->governor->name);
+}
+
 static DEVICE_ATTR(type, 0444, type_show, NULL);
 static DEVICE_ATTR(temp, 0444, temp_show, NULL);
 static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
 static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
+static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
 
 /* sys I/F for cooling device */
 #define to_cooling_device(_dev)	\
@@ -1509,10 +1540,14 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 			passive = 1;
 	}
 
-	if (!passive)
-		result = device_create_file(&tz->device,
-					    &dev_attr_passive);
+	if (!passive) {
+		result = device_create_file(&tz->device, &dev_attr_passive);
+		if (result)
+			goto unregister;
+	}
 
+	/* Create policy attribute */
+	result = device_create_file(&tz->device, &dev_attr_policy);
 	if (result)
 		goto unregister;
 
@@ -1588,6 +1623,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	device_remove_file(&tz->device, &dev_attr_temp);
 	if (tz->ops->get_mode)
 		device_remove_file(&tz->device, &dev_attr_mode);
+	device_remove_file(&tz->device, &dev_attr_policy);
 	remove_trip_attrs(tz);
 	tz->governor = NULL;
 
-- 
1.7.7.6

