From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/4] thermal: imx: improve comments describing algorithm for temp calculation
Date: Tue, 21 Nov 2017 21:02:23 +0100
Message-ID: <20171121200225.23316-3-u.kleine-koenig@pengutronix.de>
References: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:56980 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751431AbdKUULk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Nov 2017 15:11:40 -0500
In-Reply-To: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de

The description of the implemented algorithm is hardly understandable
without having the right application note side-by-side to the code.

Fix this by using shorter and more intuitive variable names, describe
their meaning and transform a single formula instead of first talking about
slope and then about "milli_Tmeas".

There are no code changes.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/thermal/imx_thermal.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 21b8c4c4da3c..c08883dff2cb 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -359,32 +359,28 @@ static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
 	}
 
 	/*
-	 * Sensor data layout:
-	 *   [31:20] - sensor value @ 25C
-	 * Use universal formula now and only need sensor value @ 25C
-	 * slope = 0.4297157 - (0.0015976 * 25C fuse)
+	 * The sensor is calibrated at 25 °C (aka T1) and the value measured
+	 * (aka N1) at this temperature is provided in bits [31:20] in the
+	 * i.MX's OCOTP value ANA1.
+	 * To find the actual temperature T, the following formula has to be used
+	 * when reading value n from the sensor:
+	 *
+	 * T = T1 + (N - N1) / (0.4297157 - 0.0015976 * N1) °C
+	 *   = [T1 - N1 / (0.4297157 - 0.0015976 * N1) °C] + N / (0.4297157 - 0.0015976 * N1) °C
+	 *   = [T1 + N1 / (0.0015976 * N1 - 0.4297157) °C] - N / (0.0015976 * N1 - 0.4297157) °C
+	 *   = c2 - c1 * N
+	 *
+	 * with
+	 *
+	 *   c1 = 1 / (0.0015976 * N1 - 0.4297157) °C
+	 *   c2 = T1 + N1 / (0.0015976 * N1 - 0.4297157) °C
+	 *      = T1 + N1 * C1
 	 */
 	n1 = ocotp_ana1 >> 20;
-	t1 = 25; /* t1 always 25C */
+	t1 = 25; /* °C */
 
-	/*
-	 * Derived from linear interpolation:
-	 * slope = 0.4297157 - (0.0015976 * 25C fuse)
-	 * slope = (FACTOR2 - FACTOR1 * n1) / FACTOR0
-	 * (Nmeas - n1) / (Tmeas - t1) = slope
-	 * We want to reduce this down to the minimum computation necessary
-	 * for each temperature read.  Also, we want Tmeas in millicelsius
-	 * and we don't want to lose precision from integer division. So...
-	 * Tmeas = (Nmeas - n1) / slope + t1
-	 * milli_Tmeas = 1000 * (Nmeas - n1) / slope + 1000 * t1
-	 * milli_Tmeas = -1000 * (n1 - Nmeas) / slope + 1000 * t1
-	 * Let constant c1 = (-1000 / slope)
-	 * milli_Tmeas = (n1 - Nmeas) * c1 + 1000 * t1
-	 * Let constant c2 = n1 *c1 + 1000 * t1
-	 * milli_Tmeas = c2 - Nmeas * c1
-	 */
-	temp64 = FACTOR0;
-	temp64 *= 1000;
+	temp64 = FACTOR0; /* 10^7 for FACTOR1 and FACTOR2 */
+	temp64 *= 1000; /* to get result in °mC */
 	do_div(temp64, FACTOR1 * n1 - FACTOR2);
 	data->c1 = temp64;
 	data->c2 = n1 * data->c1 + 1000 * t1;
-- 
2.14.2
