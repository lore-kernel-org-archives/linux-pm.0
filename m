From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] thermal: mtk_thermal: Check return value of devm_thermal_zone_of_sensor_register
Date: Wed,  7 Sep 2016 17:24:52 +0800
Message-ID: <1473240292-10116-1-git-send-email-axel.lin@ingics.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34522 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757222AbcIGJZC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2016 05:25:02 -0400
Received: by mail-pa0-f65.google.com with SMTP id gi6so635808pac.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Sep 2016 02:25:01 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, Axel Lin <axel.lin@ingics.com>

devm_thermal_zone_of_sensor_register can fail, so check it's return value.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/thermal/mtk_thermal.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 7b233c7..34169c3 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -584,6 +584,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	struct resource *res;
 	const struct of_device_id *of_id;
 	u64 auxadc_phys_base, apmixed_phys_base;
+	struct thermal_zone_device *tzdev;
 
 	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
 	if (!mt)
@@ -666,11 +667,17 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mt);
 
-	devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
-					     &mtk_thermal_ops);
+	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
+						     &mtk_thermal_ops);
+	if (IS_ERR(tzdev)) {
+		ret = PTR_ERR(tzdev);
+		goto err_disable_clk_peri_therm;
+	}
 
 	return 0;
 
+err_disable_clk_peri_therm:
+	clk_disable_unprepare(mt->clk_peri_therm);
 err_disable_clk_auxadc:
 	clk_disable_unprepare(mt->clk_auxadc);
 
-- 
2.7.4

