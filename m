From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/7] hwmon: ab8500: convert to IIO ADC
Date: Wed, 11 Jan 2017 00:47:42 +0100
Message-ID: <20170110234745.29691-5-linus.walleij@linaro.org>
References: <20170110234745.29691-1-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36713 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758552AbdAJXsB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2017 18:48:01 -0500
Received: by mail-lf0-f45.google.com with SMTP id o140so71152155lff.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2017 15:48:00 -0800 (PST)
In-Reply-To: <20170110234745.29691-1-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Mboumba Cedric Madianga <cedric.madianga@gmail.com>, linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

This switches the AB8500 hardware monitor driver to using
the standard IIO ADC channel lookup and conversion routines.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/hwmon/ab8500.c | 65 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/ab8500.c b/drivers/hwmon/ab8500.c
index 8b6a4f4c8774..6f4a5534bdcb 100644
--- a/drivers/hwmon/ab8500.c
+++ b/drivers/hwmon/ab8500.c
@@ -17,20 +17,24 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500-bm.h>
-#include <linux/mfd/abx500/ab8500-gpadc.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/power/ab8500.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/iio/consumer.h>
 #include "abx500.h"
 
 #define DEFAULT_POWER_OFF_DELAY	(HZ * 10)
 #define THERMAL_VCC		1800
 #define PULL_UP_RESISTOR	47000
-/* Number of monitored sensors should not greater than NUM_SENSORS */
-#define NUM_MONITORED_SENSORS	4
+
+#define AB8500_SENSOR_AUX1		0
+#define AB8500_SENSOR_AUX2		1
+#define AB8500_SENSOR_BTEMP_BALL	2
+#define AB8500_SENSOR_BAT_CTRL		3
+#define NUM_MONITORED_SENSORS		4
 
 struct ab8500_gpadc_cfg {
 	const struct abx500_res_to_temp *temp_tbl;
@@ -40,7 +44,8 @@ struct ab8500_gpadc_cfg {
 };
 
 struct ab8500_temp {
-	struct ab8500_gpadc *gpadc;
+	struct iio_channel *aux1;
+	struct iio_channel *aux2;
 	struct ab8500_btemp *btemp;
 	struct delayed_work power_off_work;
 	struct ab8500_gpadc_cfg cfg;
@@ -82,15 +87,21 @@ static int ab8500_read_sensor(struct abx500_temp *data, u8 sensor, int *temp)
 	int voltage, ret;
 	struct ab8500_temp *ab8500_data = data->plat_data;
 
-	if (sensor == BAT_CTRL) {
-		*temp = ab8500_btemp_get_batctrl_temp(ab8500_data->btemp);
-	} else if (sensor == BTEMP_BALL) {
+	if (sensor == AB8500_SENSOR_BTEMP_BALL) {
 		*temp = ab8500_btemp_get_temp(ab8500_data->btemp);
-	} else {
-		voltage = ab8500_gpadc_convert(ab8500_data->gpadc, sensor);
-		if (voltage < 0)
-			return voltage;
-
+	} else if (sensor == AB8500_SENSOR_BAT_CTRL) {
+		*temp = ab8500_btemp_get_batctrl_temp(ab8500_data->btemp);
+	} else if (sensor == AB8500_SENSOR_AUX1) {
+		ret = iio_read_channel_processed(ab8500_data->aux1, &voltage);
+		if (ret < 0)
+			return ret;
+		ret = ab8500_voltage_to_temp(&ab8500_data->cfg, voltage, temp);
+		if (ret < 0)
+			return ret;
+	} else if (sensor == AB8500_SENSOR_AUX2) {
+		ret = iio_read_channel_processed(ab8500_data->aux2, &voltage);
+		if (ret < 0)
+			return ret;
 		ret = ab8500_voltage_to_temp(&ab8500_data->cfg, voltage, temp);
 		if (ret < 0)
 			return ret;
@@ -164,10 +175,6 @@ int abx500_hwmon_init(struct abx500_temp *data)
 	if (!ab8500_data)
 		return -ENOMEM;
 
-	ab8500_data->gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
-	if (IS_ERR(ab8500_data->gpadc))
-		return PTR_ERR(ab8500_data->gpadc);
-
 	ab8500_data->btemp = ab8500_btemp_get();
 	if (IS_ERR(ab8500_data->btemp))
 		return PTR_ERR(ab8500_data->btemp);
@@ -181,15 +188,25 @@ int abx500_hwmon_init(struct abx500_temp *data)
 	ab8500_data->cfg.tbl_sz = ab8500_temp_tbl_a_size;
 
 	data->plat_data = ab8500_data;
+	ab8500_data->aux1 = devm_iio_channel_get(&data->pdev->dev, "aux1");
+	if (IS_ERR(ab8500_data->aux1)) {
+		if (PTR_ERR(ab8500_data->aux1) == -ENODEV)
+                        return -EPROBE_DEFER;
+		dev_err(&data->pdev->dev, "failed to get AUX1 ADC channel\n");
+		return PTR_ERR(ab8500_data->aux1);
+	}
+	ab8500_data->aux2 = devm_iio_channel_get(&data->pdev->dev, "aux2");
+	if (IS_ERR(ab8500_data->aux2)) {
+		if (PTR_ERR(ab8500_data->aux2) == -ENODEV)
+                        return -EPROBE_DEFER;
+		dev_err(&data->pdev->dev, "failed to get AUX2 ADC channel\n");
+		return PTR_ERR(ab8500_data->aux2);
+	}
 
-	/*
-	 * ADC_AUX1 and ADC_AUX2, connected to external NTC
-	 * BTEMP_BALL and BAT_CTRL, fixed usage
-	 */
-	data->gpadc_addr[0] = ADC_AUX1;
-	data->gpadc_addr[1] = ADC_AUX2;
-	data->gpadc_addr[2] = BTEMP_BALL;
-	data->gpadc_addr[3] = BAT_CTRL;
+	data->gpadc_addr[0] = AB8500_SENSOR_AUX1;
+	data->gpadc_addr[1] = AB8500_SENSOR_AUX2;
+	data->gpadc_addr[2] = AB8500_SENSOR_BTEMP_BALL;
+	data->gpadc_addr[3] = AB8500_SENSOR_BAT_CTRL;
 	data->monitored_sensors = NUM_MONITORED_SENSORS;
 
 	data->ops.read_sensor = ab8500_read_sensor;
-- 
2.9.3

