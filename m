From: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3] imx: thermal: use CPU temperature grade info for thresholds
Date: Thu, 19 Nov 2015 06:49:40 -0800
Message-ID: <1447944580-29736-1-git-send-email-tharvey@gateworks.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33627 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934339AbbKSOtg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2015 09:49:36 -0500
Received: by pabfh17 with SMTP id fh17so86003952pab.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2015 06:49:36 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Anson Huang <b20788@freescale.com>, Fabio Estevam <fabio.estevam@freescale.com>

The IMX6Q/IMX6DL SoC's have a 2-bit temperature grade stored in OTP which
is valid for all IMX6 SoC's (despite the fact that the IMXSDLRM and
IMXSXRM do not document this - this has been proven via tests as well as
verified by Freescale FAE).

Instead of assuming a fixed 85C for passive cooling threshold and 105C for
critical use the thermal grade for these configurations.

We will set the critical to maxT - 5C and passive to maxT - 10C.

Cc: Anson Huang <b20788@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Jon Nettleton <jon@solid-run.com>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
----
v3:
 - rebase against linux-soc-thermal.git
 - added ack's from Shawn and Jon
v2:
 - remove check for IMX6Q and update comments: The OTP values have been tested
   on IMX6SOLO, IMX6DUALLITE, and IMX6SX and Freescale FAE has shared data with
   me that the OTP settings are the same and that the reference manuals will
   reflect this in their next updates.
 - set critical to max - 5C
 - set passive to max - 10C
 - display max temp in info
 - do not allow passive to be set above critical

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/thermal/imx_thermal.c | 56 +++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index c8fe3ca..c5547bd 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -55,6 +55,7 @@
 #define TEMPSENSE2_PANIC_VALUE_SHIFT	16
 #define TEMPSENSE2_PANIC_VALUE_MASK	0xfff0000
 
+#define OCOTP_MEM0			0x0480
 #define OCOTP_ANA1			0x04e0
 
 /* The driver supports 1 passive trip point and 1 critical trip point */
@@ -64,12 +65,6 @@ enum imx_thermal_trip {
 	IMX_TRIP_NUM,
 };
 
-/*
- * It defines the temperature in millicelsius for passive trip point
- * that will trigger cooling action when crossed.
- */
-#define IMX_TEMP_PASSIVE		85000
-
 #define IMX_POLLING_DELAY		2000 /* millisecond */
 #define IMX_PASSIVE_DELAY		1000
 
@@ -100,12 +95,14 @@ struct imx_thermal_data {
 	u32 c1, c2; /* See formula in imx_get_sensor_data() */
 	int temp_passive;
 	int temp_critical;
+	int temp_max;
 	int alarm_temp;
 	int last_temp;
 	bool irq_enabled;
 	int irq;
 	struct clk *thermal_clk;
 	const struct thermal_soc_data *socdata;
+	const char *temp_grade;
 };
 
 static void imx_set_panic_temp(struct imx_thermal_data *data,
@@ -285,10 +282,12 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
 {
 	struct imx_thermal_data *data = tz->devdata;
 
+	/* do not allow changing critical threshold */
 	if (trip == IMX_TRIP_CRITICAL)
 		return -EPERM;
 
-	if (temp < 0 || temp > IMX_TEMP_PASSIVE)
+	/* do not allow passive to be set higher than critical */
+	if (temp < 0 || temp > data->temp_critical)
 		return -EINVAL;
 
 	data->temp_passive = temp;
@@ -404,17 +403,39 @@ static int imx_get_sensor_data(struct platform_device *pdev)
 	data->c1 = temp64;
 	data->c2 = n1 * data->c1 + 1000 * t1;
 
-	/*
-	 * Set the default passive cooling trip point,
-	 * can be changed from userspace.
-	 */
-	data->temp_passive = IMX_TEMP_PASSIVE;
+	/* use OTP for thermal grade */
+	ret = regmap_read(map, OCOTP_MEM0, &val);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to read temp grade: %d\n", ret);
+		return ret;
+	}
+
+	/* The maximum die temp is specified by the Temperature Grade */
+	switch ((val >> 6) & 0x3) {
+	case 0: /* Commercial (0 to 95C) */
+		data->temp_grade = "Commercial";
+		data->temp_max = 95000;
+		break;
+	case 1: /* Extended Commercial (-20 to 105C) */
+		data->temp_grade = "Extended Commercial";
+		data->temp_max = 105000;
+		break;
+	case 2: /* Industrial (-40 to 105C) */
+		data->temp_grade = "Industrial";
+		data->temp_max = 105000;
+		break;
+	case 3: /* Automotive (-40 to 125C) */
+		data->temp_grade = "Automotive";
+		data->temp_max = 125000;
+		break;
+	}
 
 	/*
-	 * The maximum die temperature set to 20 C higher than
-	 * IMX_TEMP_PASSIVE.
+	 * Set the critical trip point at 5C under max
+	 * Set the passive trip point at 10C under max (can change via sysfs)
 	 */
-	data->temp_critical = 1000 * 20 + data->temp_passive;
+	data->temp_critical = data->temp_max - (1000 * 5);
+	data->temp_passive = data->temp_max - (1000 * 10);
 
 	return 0;
 }
@@ -551,6 +572,11 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	dev_info(&pdev->dev, "%s CPU temperature grade - max:%dC"
+		 " critical:%dC passive:%dC\n", data->temp_grade,
+		 data->temp_max / 1000, data->temp_critical / 1000,
+		 data->temp_passive / 1000);
+
 	/* Enable measurements at ~ 10 Hz */
 	regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
 	measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
-- 
1.9.1

