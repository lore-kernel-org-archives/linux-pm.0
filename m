From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] thermal: thermal_hwmon: Convert to hwmon_device_register_with_info()
Date: Sat, 13 Jan 2018 12:08:49 -0200
Message-ID: <1515852529-11760-1-git-send-email-festevam@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37762 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754998AbeAMOJC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Jan 2018 09:09:02 -0500
Received: by mail-qt0-f193.google.com with SMTP id f2so9361201qtj.4
        for <linux-pm@vger.kernel.org>; Sat, 13 Jan 2018 06:09:01 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org, linux@roeck-us.net, pavel@ucw.cz, arthurborsboom@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

Booting Linux on a mx6q based board leads to the following warning:
    
(NULL device *): hwmon_device_register() is deprecated. Please convert the
driver to use hwmon_device_register_with_info().
    
, so do the conversion as suggested.

Also, this results in the core taking care of creating the 'name'
attribute, so drop the code doing that from the thermal driver.

The initial attempt to convert this driver to
hwmon_device_register_with_info() caused issues on the N900 platform
in commit 7611fb68062f ("thermal: thermal_hwmon: Convert to
hwmon_device_register_with_info()"):

bq27xxx-battery 2-0055: failed to register battery
bq27xxx-battery: probe of 2-0055 failed with error -22
...
rx51-battery: probe of n900-battery failed with error -22

, leading to a revert in commit 3feb479cea37 ("Revert "thermal:
thermal_hwmon: Convert to hwmon_device_register_with_info()"").

The probe errors happened due to the '-' character being present in
the name of the power supply devices: bq27200-0 and rx51-battery.

Since commit 74d3b6419772 ("hwmon: Relax name attribute validation
for new APIs") hwmon will no longer treat these names as errors,
allowing the transition for hwmon_device_register_with_info() to
happen in a safely manner. 

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since v1:
- Fix commit id (Rui)
- Collected Guenter's Acked-by

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
