From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH] thermal: imx: fix a possible NULL dereference
Date: Tue, 16 Aug 2016 10:51:38 +0200
Message-ID: <1471337498-6382-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36236 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbcHPIvn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Aug 2016 04:51:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, LABBE Corentin <clabbe.montjoie@gmail.com>

of_match_device could return NULL, and so cause a NULL pointer
dereference later at line 472:
data->socdata = of_id->data;

For fixing this problem, we use of_device_get_match_data(), this will
simplify the code a little by using a standard function for
getting the match data.

Reported-by: coverity (CID 1324128)
Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/thermal/imx_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index c5547bd..e473548b 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -471,8 +471,6 @@ MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
 
 static int imx_thermal_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-		of_match_device(of_imx_thermal_match, &pdev->dev);
 	struct imx_thermal_data *data;
 	struct regmap *map;
 	int measure_freq;
@@ -490,7 +488,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	}
 	data->tempmon = map;
 
-	data->socdata = of_id->data;
+	data->socdata = of_device_get_match_data(&pdev->dev);
 
 	/* make sure the IRQ flag is clear before enabling irq on i.MX6SX */
 	if (data->socdata->version == TEMPMON_IMX6SX) {
-- 
2.7.3

