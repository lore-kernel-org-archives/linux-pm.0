From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/4] thermal: imx: Use better parameter names than "val"
Date: Tue, 21 Nov 2017 21:02:22 +0100
Message-ID: <20171121200225.23316-2-u.kleine-koenig@pengutronix.de>
References: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:56984 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbdKUULk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Nov 2017 15:11:40 -0500
In-Reply-To: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de

The values passed to imx_init_calib() and imx_init_temp_grade() are
read from specific OCOTP values. Use their names (in lower case) as
parameter name instead of "val" to make the code easier to understand.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/thermal/imx_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index e7d4ffc3de7f..21b8c4c4da3c 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -347,13 +347,13 @@ static struct thermal_zone_device_ops imx_tz_ops = {
 	.set_trip_temp = imx_set_trip_temp,
 };
 
-static int imx_init_calib(struct platform_device *pdev, u32 val)
+static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
 {
 	struct imx_thermal_data *data = platform_get_drvdata(pdev);
 	int t1, n1;
 	u64 temp64;
 
-	if (val == 0 || val == ~0) {
+	if (ocotp_ana1 == 0 || ocotp_ana1 == ~0) {
 		dev_err(&pdev->dev, "invalid sensor calibration data\n");
 		return -EINVAL;
 	}
@@ -364,7 +364,7 @@ static int imx_init_calib(struct platform_device *pdev, u32 val)
 	 * Use universal formula now and only need sensor value @ 25C
 	 * slope = 0.4297157 - (0.0015976 * 25C fuse)
 	 */
-	n1 = val >> 20;
+	n1 = ocotp_ana1 >> 20;
 	t1 = 25; /* t1 always 25C */
 
 	/*
@@ -392,12 +392,12 @@ static int imx_init_calib(struct platform_device *pdev, u32 val)
 	return 0;
 }
 
-static void imx_init_temp_grade(struct platform_device *pdev, u32 val)
+static void imx_init_temp_grade(struct platform_device *pdev, u32 ocotp_mem0)
 {
 	struct imx_thermal_data *data = platform_get_drvdata(pdev);
 
 	/* The maximum die temp is specified by the Temperature Grade */
-	switch ((val >> 6) & 0x3) {
+	switch ((ocotp_mem0 >> 6) & 0x3) {
 	case 0: /* Commercial (0 to 95C) */
 		data->temp_grade = "Commercial";
 		data->temp_max = 95000;
-- 
2.14.2
