From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] thermal: thermal_hwmon: Convert to hwmon_device_register_with_info()
Date: Tue, 27 Dec 2016 15:31:49 -0200
Message-ID: <1482859909-6924-1-git-send-email-festevam@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34624 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933349AbcL0Rbu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Dec 2016 12:31:50 -0500
Received: by mail-qt0-f193.google.com with SMTP id p16so21670736qta.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Dec 2016 09:31:50 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: rui.zhang@intel.com, linux@roeck-us.net, linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

Booting Linux on a mx6q based board leads to the following warning:

(NULL device *): hwmon_device_register() is deprecated. Please convert the
driver to use hwmon_device_register_with_info().

,so do as suggested.

Also, this results in the core taking care of creating the 'name'
attribute, so drop the code doing that from the thermal driver.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Remove dev_set_drvdata() as it is also taken care by the hwmon core.

 drivers/thermal/thermal_hwmon.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 541af59..c4a508a 100644
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
2.7.4

