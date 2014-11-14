From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 1/4] thermal: exynos: add optional sclk support
Date: Fri, 14 Nov 2014 16:47:59 +0530
Message-ID: <1415963882-3460-2-git-send-email-a.kesavan@samsung.com>
References: <1415963882-3460-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:51718 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965011AbaKNLTQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 06:19:16 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NF1006IM0S2OL50@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 14 Nov 2014 20:19:14 +0900 (KST)
In-reply-to: <1415963882-3460-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, amit.daniel@samsung.com, kesavan.abhilash@gmail.com

Exynos7 has a special clock required for the functional operation
of the TMU that is not present in earlier SoCs. Add support for
this optional clock and update the binding documentation.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 .../devicetree/bindings/thermal/exynos-thermal.txt |    3 ++
 drivers/thermal/samsung/exynos_tmu.c               |   29 ++++++++++++++++----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index ae738f5..2393eac 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -32,10 +32,13 @@
 - clocks : The main clocks for TMU device
 	-- 1. operational clock for TMU channel
 	-- 2. optional clock to access the shared registers of TMU channel
+	-- 3. optional special clock for functional operation
 - clock-names : Thermal system clock name
 	-- "tmu_apbif" operational clock for current TMU channel
 	-- "tmu_triminfo_apbif" clock to access the shared triminfo register
 		for current TMU channel
+	-- "tmu_sclk" clock for functional operation of the current TMU
+		channel
 - vtmu-supply: This entry is optional and provides the regulator node supplying
 		voltage to TMU. If needed this entry can be placed inside
 		board/platform specific dts file.
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 1e7d073..c8caf5b 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -48,6 +48,7 @@
  * @lock: lock to implement synchronization.
  * @clk: pointer to the clock structure.
  * @clk_sec: pointer to the clock structure for accessing the base_second.
+ * @sclk: pointer to the clock structure for accessing the tmu special clk.
  * @temp_error1: fused value of the first point trim.
  * @temp_error2: fused value of the second point trim.
  * @regulator: pointer to the TMU regulator structure.
@@ -62,7 +63,7 @@ struct exynos_tmu_data {
 	enum soc_type soc;
 	struct work_struct irq_work;
 	struct mutex lock;
-	struct clk *clk, *clk_sec;
+	struct clk *clk, *clk_sec, *sclk;
 	u8 temp_error1, temp_error2;
 	struct regulator *regulator;
 	struct thermal_sensor_conf *reg_conf;
@@ -625,6 +626,17 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_clk_sec;
 	}
 
+	data->sclk = devm_clk_get(&pdev->dev, "tmu_sclk");
+	if (IS_ERR(data->sclk)) {
+		dev_err(&pdev->dev, "Failed to get optional special clock\n");
+	} else {
+		ret = clk_prepare_enable(data->sclk);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to enable special clock\n");
+			goto err_clk;
+		}
+	}
+
 	if (pdata->type == SOC_ARCH_EXYNOS3250 ||
 	    pdata->type == SOC_ARCH_EXYNOS4210 ||
 	    pdata->type == SOC_ARCH_EXYNOS4412 ||
@@ -636,13 +648,13 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	else {
 		ret = -EINVAL;
 		dev_err(&pdev->dev, "Platform not supported\n");
-		goto err_clk;
+		goto err_sclk;
 	}
 
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize TMU\n");
-		goto err_clk;
+		goto err_sclk;
 	}
 
 	exynos_tmu_control(pdev, true);
@@ -652,7 +664,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 				sizeof(struct thermal_sensor_conf), GFP_KERNEL);
 	if (!sensor_conf) {
 		ret = -ENOMEM;
-		goto err_clk;
+		goto err_sclk;
 	}
 	sprintf(sensor_conf->name, "therm_zone%d", data->id);
 	sensor_conf->read_temperature = (int (*)(void *))exynos_tmu_read;
@@ -684,7 +696,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	ret = exynos_register_thermal(sensor_conf);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register thermal interface\n");
-		goto err_clk;
+		goto err_sclk;
 	}
 	data->reg_conf = sensor_conf;
 
@@ -692,10 +704,13 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
-		goto err_clk;
+		goto err_sclk;
 	}
 
 	return 0;
+err_sclk:
+	if (!IS_ERR(data->sclk))
+		clk_disable_unprepare(data->sclk);
 err_clk:
 	clk_unprepare(data->clk);
 err_clk_sec:
@@ -712,6 +727,8 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 
 	exynos_tmu_control(pdev, false);
 
+	if (!IS_ERR(data->sclk))
+		clk_disable_unprepare(data->sclk);
 	clk_unprepare(data->clk);
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
-- 
1.7.9.5

