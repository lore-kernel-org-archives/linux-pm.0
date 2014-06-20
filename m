From: Anson Huang <b20788@freescale.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20Thermal=3A=20imx=3A=20correct=20critical=20trip=20temperature=20setting?=
Date: Fri, 20 Jun 2014 15:03:06 +0800
Message-ID: <1403247786-19899-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bl2lp0209.outbound.protection.outlook.com ([207.46.163.209]:1811
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933600AbaFTHFD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Jun 2014 03:05:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, eduardo.valentin@ti.com
Cc: linux-pm@vger.kernel.org

On latest i.MX6 SOC with thermal calibration data of 0x5A100000,
the critical trip temperature will be an invalid value and
cause system auto shutdown as below log:

thermal thermal_zone0: critical temperature reached(42 C),shutting down

So, with universal formula for thermal sensor, only room
temperature point is calibrated, which means the calibration
data read from fuse only has valid data of bit [31:20], others
are all 0, the critical trip point temperature can NOT depend
on the hot point calibration data, here we set it to 20 C higher
than default passive temperature.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 drivers/thermal/imx_thermal.c |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_therma=
l.c
index a99c631..2c516f2 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -306,7 +306,7 @@ static int imx_get_sensor_data(struct platform_devi=
ce *pdev)
 {
 	struct imx_thermal_data *data =3D platform_get_drvdata(pdev);
 	struct regmap *map;
-	int t1, t2, n1, n2;
+	int t1, n1;
 	int ret;
 	u32 val;
 	u64 temp64;
@@ -333,14 +333,10 @@ static int imx_get_sensor_data(struct platform_de=
vice *pdev)
 	/*
 	 * Sensor data layout:
 	 *   [31:20] - sensor value @ 25C
-	 *    [19:8] - sensor value of hot
-	 *     [7:0] - hot temperature value
 	 * Use universal formula now and only need sensor value @ 25C
 	 * slope =3D 0.4297157 - (0.0015976 * 25C fuse)
 	 */
 	n1 =3D val >> 20;
-	n2 =3D (val & 0xfff00) >> 8;
-	t2 =3D val & 0xff;
 	t1 =3D 25; /* t1 always 25C */
=20
 	/*
@@ -366,16 +362,16 @@ static int imx_get_sensor_data(struct platform_de=
vice *pdev)
 	data->c2 =3D n1 * data->c1 + 1000 * t1;
=20
 	/*
-	 * Set the default passive cooling trip point to 20 =C2=B0C below the
-	 * maximum die temperature. Can be changed from userspace.
+	 * Set the default passive cooling trip point,
+	 * can be changed from userspace.
 	 */
-	data->temp_passive =3D 1000 * (t2 - 20);
+	data->temp_passive =3D IMX_TEMP_PASSIVE;
=20
 	/*
-	 * The maximum die temperature is t2, let's give 5 =C2=B0C cushion
-	 * for noise and possible temperature rise between measurements.
+	 * The maximum die temperature set to 20 C higher than
+	 * IMX_TEMP_PASSIVE.
 	 */
-	data->temp_critical =3D 1000 * (t2 - 5);
+	data->temp_critical =3D 1000 * 20 + data->temp_passive;
=20
 	return 0;
 }
--=20
1.7.9.5

