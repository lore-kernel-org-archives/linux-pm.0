From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 02/13] hwmon: convert ntc_thermistor to use devm_thermal_zone_of_sensor_register
Date: Wed,  9 Mar 2016 13:35:24 -0800
Message-ID: <1457559336-17652-3-git-send-email-edubezval@gmail.com>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33747 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbcCIVfn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 16:35:43 -0500
In-Reply-To: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Eduardo Valentin <edubezval@gmail.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>

This changes the driver to use the devm_ version
of thermal_zone_of_sensor_register and cleans
up the  local points and unregister calls.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/hwmon/ntc_thermistor.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index feed306..ffc12f1 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -221,7 +221,6 @@ struct ntc_data {
 	struct device *dev;
 	int n_comp;
 	char name[PLATFORM_NAME_SIZE];
-	struct thermal_zone_device *tz;
 };
 
 #if defined(CONFIG_OF) && IS_ENABLED(CONFIG_IIO)
@@ -539,6 +538,7 @@ static const struct thermal_zone_of_device_ops ntc_of_thermal_ops = {
 
 static int ntc_thermistor_probe(struct platform_device *pdev)
 {
+	struct thermal_zone_device *tz;
 	const struct of_device_id *of_id =
 			of_match_device(of_match_ptr(ntc_match), &pdev->dev);
 	const struct platform_device_id *pdev_id;
@@ -633,12 +633,10 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "Thermistor type: %s successfully probed.\n",
 								pdev_id->name);
 
-	data->tz = thermal_zone_of_sensor_register(data->dev, 0, data->dev,
-						   &ntc_of_thermal_ops);
-	if (IS_ERR(data->tz)) {
+	tz = devm_thermal_zone_of_sensor_register(data->dev, 0, data->dev,
+						  &ntc_of_thermal_ops);
+	if (IS_ERR(tz))
 		dev_dbg(&pdev->dev, "Failed to register to thermal fw.\n");
-		data->tz = NULL;
-	}
 
 	return 0;
 err_after_sysfs:
@@ -656,8 +654,6 @@ static int ntc_thermistor_remove(struct platform_device *pdev)
 	sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
 	ntc_iio_channel_release(pdata);
 
-	thermal_zone_of_sensor_unregister(data->dev, data->tz);
-
 	return 0;
 }
 
-- 
2.1.4

