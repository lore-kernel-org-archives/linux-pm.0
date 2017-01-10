From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/7] power: supply: ab8500_fg: convert to IIO ADC
Date: Wed, 11 Jan 2017 00:47:41 +0100
Message-ID: <20170110234745.29691-4-linus.walleij@linaro.org>
References: <20170110234745.29691-1-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35565 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758538AbdAJXr6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2017 18:47:58 -0500
Received: by mail-lf0-f47.google.com with SMTP id m78so104814801lfg.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2017 15:47:58 -0800 (PST)
In-Reply-To: <20170110234745.29691-1-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Mboumba Cedric Madianga <cedric.madianga@gmail.com>, linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

This switches the AB8500 fuel gauge driver to using
the standard IIO ADC channel lookup and conversion routines.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_fg.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index c569f82a0071..b26122e1da51 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -32,7 +32,7 @@
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/mfd/abx500/ab8500-bm.h>
-#include <linux/mfd/abx500/ab8500-gpadc.h>
+#include <linux/iio/consumer.h>
 #include <linux/kernel.h>
 
 #define MILLI_TO_MICRO			1000
@@ -182,7 +182,7 @@ struct inst_curr_result_list {
  * @bat_cap:		Structure for battery capacity specific parameters
  * @avg_cap:		Average capacity filter
  * @parent:		Pointer to the struct ab8500
- * @gpadc:		Pointer to the struct gpadc
+ * @main_bat_v:		ADC channel for the main battery voltage
  * @bm:           	Platform specific battery management information
  * @fg_psy:		Structure that holds the FG specific battery properties
  * @fg_wq:		Work queue for running the FG algorithm
@@ -224,7 +224,7 @@ struct ab8500_fg {
 	struct ab8500_fg_battery_capacity bat_cap;
 	struct ab8500_fg_avg_cap avg_cap;
 	struct ab8500 *parent;
-	struct ab8500_gpadc *gpadc;
+	struct iio_channel *main_bat_v;
 	struct abx500_bm_data *bm;
 	struct power_supply *fg_psy;
 	struct workqueue_struct *fg_wq;
@@ -831,13 +831,13 @@ static void ab8500_fg_acc_cur_work(struct work_struct *work)
  */
 static int ab8500_fg_bat_voltage(struct ab8500_fg *di)
 {
-	int vbat;
+	int vbat, ret;
 	static int prev;
 
-	vbat = ab8500_gpadc_convert(di->gpadc, MAIN_BAT_V);
-	if (vbat < 0) {
+	ret = iio_read_channel_processed(di->main_bat_v, &vbat);
+	if (ret < 0) {
 		dev_err(di->dev,
-			"%s gpadc conversion failed, using previous value\n",
+			"%s ADC conversion failed, using previous value\n",
 			__func__);
 		return prev;
 	}
@@ -3072,7 +3072,14 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	/* get parent data */
 	di->dev = &pdev->dev;
 	di->parent = dev_get_drvdata(pdev->dev.parent);
-	di->gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
+
+	di->main_bat_v = devm_iio_channel_get(&pdev->dev, "main_bat_v");
+	if (IS_ERR(di->main_bat_v)) {
+		if (PTR_ERR(di->main_bat_v) == -ENODEV)
+                        return -EPROBE_DEFER;
+		dev_err(&pdev->dev, "failed to get main battery ADC channel\n");
+		return PTR_ERR(di->main_bat_v);
+	}
 
 	psy_cfg.supplied_to = supply_interface;
 	psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
-- 
2.9.3

