From: Josh Benson <handle2001@gmail.com>
Subject: [PATCH] Fixed hwmon_register_device() error regression
Date: Sun, 28 May 2017 22:38:58 -0400
Message-ID: <20170529023858.GA1713@localhost.highwinds.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35270 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbdE2CjI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 May 2017 22:39:08 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, handle2001@gmail.com

Signed-off-by: Josh Benson <handle2001@gmail.com>
---
 drivers/thermal/thermal_hwmon.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 541af5946203..c4a508a124dc 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -59,14 +59,6 @@ static LIST_HEAD(thermal_hwmon_list);
 static DEFINE_MUTEX(thermal_hwmon_list_lock);
 
 static ssize_t
-name_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct thermal_hwmon_device *hwmon = dev_get_drvdata(dev);
-	return sprintf(buf, "%s\n", hwmon->type);
-}
-static DEVICE_ATTR_RO(name);
-
-static ssize_t
 temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	int temperature;
@@ -165,15 +157,12 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 
 	INIT_LIST_HEAD(&hwmon->tz_list);
 	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
-	hwmon->device = hwmon_device_register(NULL);
+	hwmon->device = hwmon_device_register_with_info(NULL, hwmon->type,
+							hwmon, NULL, NULL);
 	if (IS_ERR(hwmon->device)) {
 		result = PTR_ERR(hwmon->device);
 		goto free_mem;
 	}
-	dev_set_drvdata(hwmon->device, hwmon);
-	result = device_create_file(hwmon->device, &dev_attr_name);
-	if (result)
-		goto free_mem;
 
  register_sys_interface:
 	temp = kzalloc(sizeof(*temp), GFP_KERNEL);
@@ -222,10 +211,8 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
  free_temp_mem:
 	kfree(temp);
  unregister_name:
-	if (new_hwmon_device) {
-		device_remove_file(hwmon->device, &dev_attr_name);
+	if (new_hwmon_device)
 		hwmon_device_unregister(hwmon->device);
-	}
  free_mem:
 	if (new_hwmon_device)
 		kfree(hwmon);
@@ -267,7 +254,6 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
 	list_del(&hwmon->node);
 	mutex_unlock(&thermal_hwmon_list_lock);
 
-	device_remove_file(hwmon->device, &dev_attr_name);
 	hwmon_device_unregister(hwmon->device);
 	kfree(hwmon);
 }
-- 
2.13.0
