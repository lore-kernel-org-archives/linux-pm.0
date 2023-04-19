Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC81C77B75
	for <linux-pm@archiver.kernel.org>; Wed, 19 Apr 2023 02:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjDSCMT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 18 Apr 2023 22:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDSCMT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 22:12:19 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A893124;
        Tue, 18 Apr 2023 19:12:17 -0700 (PDT)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        (user=void0red@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33J27wUg015429-33J27wUi015429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Apr 2023 10:08:00 +0800
From:   Kang Chen <void0red@hust.edu.cn>
To:     daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, daniel@makrotopia.org, dzm91@hust.edu.cn,
        error27@gmail.com, henry.yen@mediatek.com,
        hust-os-kernel-patches@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        matthias.bgg@gmail.com, rafael@kernel.org, rdunlap@infradead.org,
        rui.zhang@intel.com, Kang Chen <void0red@hust.edu.cn>
Subject: [PATCH v5 2/2] thermal: mediatek: change clk_prepare_enable to devm_clk_get_enabled in mtk_thermal_probe
Date:   Wed, 19 Apr 2023 10:07:49 +0800
Message-Id: <20230419020749.621257-2-void0red@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419020749.621257-1-void0red@hust.edu.cn>
References: <20230419020749.621257-1-void0red@hust.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: void0red@hust.edu.cn
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

use devm_clk_get_enabled to do automatic resource management.
Meanwhile, remove error handling labels in the probe function and
the whole remove function.

Signed-off-by: Kang Chen <void0red@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
v5 -> v4: use PTR_ERR to convert err ptr to err code
v4 -> v3: port to linux-next tree
v3 -> v2: remove some useles func calls.
v2 -> v1: init

 drivers/thermal/mediatek/auxadc_thermal.c | 44 +++++------------------
 1 file changed, 9 insertions(+), 35 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index dcc64237ea60..a488e1797f3d 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1186,14 +1186,6 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	mt->conf = of_device_get_match_data(&pdev->dev);
 
-	mt->clk_peri_therm = devm_clk_get(&pdev->dev, "therm");
-	if (IS_ERR(mt->clk_peri_therm))
-		return PTR_ERR(mt->clk_peri_therm);
-
-	mt->clk_auxadc = devm_clk_get(&pdev->dev, "auxadc");
-	if (IS_ERR(mt->clk_auxadc))
-		return PTR_ERR(mt->clk_auxadc);
-
 	mt->thermal_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(mt->thermal_base))
 		return PTR_ERR(mt->thermal_base);
@@ -1252,16 +1244,18 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(mt->clk_auxadc);
-	if (ret) {
+	mt->clk_auxadc = devm_clk_get_enabled(&pdev->dev, "auxadc");
+	if (IS_ERR(mt->clk_auxadc)) {
+		ret = PTR_ERR(mt->clk_auxadc);
 		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", ret);
 		return ret;
 	}
 
-	ret = clk_prepare_enable(mt->clk_peri_therm);
-	if (ret) {
+	mt->clk_peri_therm = devm_clk_get_enabled(&pdev->dev, "therm");
+	if (IS_ERR(mt->clk_peri_therm)) {
+		ret = PTR_ERR(mt->clk_peri_therm);
 		dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
-		goto err_disable_clk_auxadc;
+		return ret;
 	}
 
 	mtk_thermal_turn_on_buffer(mt, apmixed_base);
@@ -1288,38 +1282,18 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
 					      &mtk_thermal_ops);
-	if (IS_ERR(tzdev)) {
-		ret = PTR_ERR(tzdev);
-		goto err_disable_clk_peri_therm;
-	}
+	if (IS_ERR(tzdev))
+		return PTR_ERR(tzdev);
 
 	ret = devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
 	if (ret)
 		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
 
 	return 0;
-
-err_disable_clk_peri_therm:
-	clk_disable_unprepare(mt->clk_peri_therm);
-err_disable_clk_auxadc:
-	clk_disable_unprepare(mt->clk_auxadc);
-
-	return ret;
-}
-
-static int mtk_thermal_remove(struct platform_device *pdev)
-{
-	struct mtk_thermal *mt = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(mt->clk_peri_therm);
-	clk_disable_unprepare(mt->clk_auxadc);
-
-	return 0;
 }
 
 static struct platform_driver mtk_thermal_driver = {
 	.probe = mtk_thermal_probe,
-	.remove = mtk_thermal_remove,
 	.driver = {
 		.name = "mtk-thermal",
 		.of_match_table = mtk_thermal_of_match,
-- 
2.34.1

