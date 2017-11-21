From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 4/4] thermal: imx: update to new formula according to NXP AN5215
Date: Tue, 21 Nov 2017 21:02:25 +0100
Message-ID: <20171121200225.23316-5-u.kleine-koenig@pengutronix.de>
References: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:56974 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdKUULk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Nov 2017 15:11:40 -0500
In-Reply-To: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de

According to an application note from 03/2017 there is an updated formula to
calculate the temperature that better matches reality. This is implemented here.

While updating move the magic constants from cpp defines which are far above the
explaining formula to constants in the code just under the explaining comment.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/thermal/imx_thermal.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index b24aa6cfebbf..95116475ac98 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -70,10 +70,6 @@ enum imx_thermal_trip {
 #define IMX_POLLING_DELAY		2000 /* millisecond */
 #define IMX_PASSIVE_DELAY		1000
 
-#define FACTOR0				10000000
-#define FACTOR1				15976
-#define FACTOR2				4297157
-
 #define TEMPMON_IMX6Q			1
 #define TEMPMON_IMX6SX			2
 
@@ -350,7 +346,7 @@ static struct thermal_zone_device_ops imx_tz_ops = {
 static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
 {
 	struct imx_thermal_data *data = platform_get_drvdata(pdev);
-	int t1, n1;
+	int n1;
 	u64 temp64;
 
 	if (ocotp_ana1 == 0 || ocotp_ana1 == ~0) {
@@ -365,25 +361,25 @@ static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
 	 * To find the actual temperature T, the following formula has to be used
 	 * when reading value n from the sensor:
 	 *
-	 * T = T1 + (N - N1) / (0.4297157 - 0.0015976 * N1) °C
-	 *   = [T1 - N1 / (0.4297157 - 0.0015976 * N1) °C] + N / (0.4297157 - 0.0015976 * N1) °C
-	 *   = [T1 + N1 / (0.0015976 * N1 - 0.4297157) °C] - N / (0.0015976 * N1 - 0.4297157) °C
+	 * T = T1 + (N - N1) / (0.4148468 - 0.0015423 * N1) °C + 3.580661 °C
+	 *   = [T1' - N1 / (0.4148468 - 0.0015423 * N1) °C] + N / (0.4148468 - 0.0015423 * N1) °C
+	 *   = [T1' + N1 / (0.0015423 * N1 - 0.4148468) °C] - N / (0.0015423 * N1 - 0.4148468) °C
 	 *   = c2 - c1 * N
 	 *
 	 * with
 	 *
-	 *   c1 = 1 / (0.0015976 * N1 - 0.4297157) °C
-	 *   c2 = T1 + N1 / (0.0015976 * N1 - 0.4297157) °C
-	 *      = T1 + N1 * C1
+	 *  T1' = 28.580661 °C
+	 *   c1 = 1 / (0.0015423 * N1 - 0.4297157) °C
+	 *   c2 = T1' + N1 / (0.0015423 * N1 - 0.4148468) °C
+	 *      = T1' + N1 * c1
 	 */
 	n1 = ocotp_ana1 >> 20;
-	t1 = 25; /* °C */
 
-	temp64 = FACTOR0; /* 10^7 for FACTOR1 and FACTOR2 */
+	temp64 = 10000000; /* use 10^7 as fixed point constant for values in formula */
 	temp64 *= 1000; /* to get result in °mC */
-	do_div(temp64, FACTOR1 * n1 - FACTOR2);
+	do_div(temp64, 15423 * n1 - 4148468);
 	data->c1 = temp64;
-	data->c2 = n1 * data->c1 + 1000 * t1;
+	data->c2 = n1 * data->c1 + 28581;
 
 	return 0;
 }
-- 
2.14.2
