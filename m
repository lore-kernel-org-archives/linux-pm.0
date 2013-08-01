From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 1/2] thermal: imx: dynamic passive and SoC specific critical trip points
Date: Thu,  1 Aug 2013 18:33:11 +0200
Message-ID: <1375374792-32326-2-git-send-email-p.zabel@pengutronix.de>
References: <1375374792-32326-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59797 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab3HAQd0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2013 12:33:26 -0400
In-Reply-To: <1375374792-32326-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Shawn Guo <shawn.guo@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>

Set passive and critical trip point values depending on the maximum die
temperature stored in the OCOTP fuses. This allows higher trip points
for industrial and automotive rated i.MX6 SoCs.
Also allow to configure the passive trip point from userspace.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/thermal/imx_thermal.c | 50 ++++++++++++++++++++++++++++++++++-=
--------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_therma=
l.c
index d16c33c..9387e47 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -55,12 +55,6 @@ enum imx_thermal_trip {
  */
 #define IMX_TEMP_PASSIVE		85000
=20
-/*
- * The maximum die temperature on imx parts is 105C, let's give some c=
ushion
- * for noise and possible temperature rise between measurements.
- */
-#define IMX_TEMP_CRITICAL		100000
-
 #define IMX_POLLING_DELAY		2000 /* millisecond */
 #define IMX_PASSIVE_DELAY		1000
=20
@@ -70,6 +64,8 @@ struct imx_thermal_data {
 	enum thermal_device_mode mode;
 	struct regmap *tempmon;
 	int c1, c2; /* See formula in imx_get_sensor_data() */
+	unsigned long temp_passive;
+	unsigned long temp_critical;
 };
=20
 static int imx_get_temp(struct thermal_zone_device *tz, unsigned long =
*temp)
@@ -156,15 +152,35 @@ static int imx_get_trip_type(struct thermal_zone_=
device *tz, int trip,
 static int imx_get_crit_temp(struct thermal_zone_device *tz,
 			     unsigned long *temp)
 {
-	*temp =3D IMX_TEMP_CRITICAL;
+	struct imx_thermal_data *data =3D tz->devdata;
+
+	*temp =3D data->temp_critical;
 	return 0;
 }
=20
 static int imx_get_trip_temp(struct thermal_zone_device *tz, int trip,
 			     unsigned long *temp)
 {
-	*temp =3D (trip =3D=3D IMX_TRIP_PASSIVE) ? IMX_TEMP_PASSIVE :
-					     IMX_TEMP_CRITICAL;
+	struct imx_thermal_data *data =3D tz->devdata;
+
+	*temp =3D (trip =3D=3D IMX_TRIP_PASSIVE) ? data->temp_passive :
+					     data->temp_critical;
+	return 0;
+}
+
+static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
+			     unsigned long temp)
+{
+	struct imx_thermal_data *data =3D tz->devdata;
+
+	if (trip =3D=3D IMX_TRIP_CRITICAL)
+		return -EPERM;
+
+	if (temp > IMX_TEMP_PASSIVE)
+		return -EINVAL;
+
+	data->temp_passive =3D temp;
+
 	return 0;
 }
=20
@@ -211,6 +227,7 @@ static const struct thermal_zone_device_ops imx_tz_=
ops =3D {
 	.get_trip_type =3D imx_get_trip_type,
 	.get_trip_temp =3D imx_get_trip_temp,
 	.get_crit_temp =3D imx_get_crit_temp,
+	.set_trip_temp =3D imx_set_trip_temp,
 };
=20
 static int imx_get_sensor_data(struct platform_device *pdev)
@@ -267,6 +284,18 @@ static int imx_get_sensor_data(struct platform_dev=
ice *pdev)
 	data->c1 =3D 1000 * (t1 - t2) / (n1 - n2);
 	data->c2 =3D 1000 * t2 - data->c1 * n2;
=20
+	/*
+	 * Set the default passive cooling trip point to 20 =C2=B0C below the
+	 * maximum die temperature. Can be changed from userspace.
+	 */
+	data->temp_passive =3D 1000 * (t2 - 20);
+
+	/*
+	 * The maximum die temperature is t2, let's give 5 =C2=B0C cushion
+	 * for noise and possible temperature rise between measurements.
+	 */
+	data->temp_critical =3D 1000 * (t2 - 5);
+
 	return 0;
 }
=20
@@ -314,7 +343,8 @@ static int imx_thermal_probe(struct platform_device=
 *pdev)
 	}
=20
 	data->tz =3D thermal_zone_device_register("imx_thermal_zone",
-						IMX_TRIP_NUM, 0, data,
+						IMX_TRIP_NUM,
+						BIT(IMX_TRIP_PASSIVE), data,
 						&imx_tz_ops, NULL,
 						IMX_PASSIVE_DELAY,
 						IMX_POLLING_DELAY);
--=20
1.8.4.rc0

