From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH v2] thermal: exynos: add special clock support
Date: Wed, 26 Nov 2014 06:21:10 +0530
Message-ID: <1416963070-5806-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:13428 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbaKZAvQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 19:51:16 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, amit.daniel@samsung.com, kesavan.abhilash@gmail.com, l.majewski@samsung.com, cw00.choi@samsung.com

Exynos7 has a special clock required for the functional operation
of the TMU that is not present in earlier SoCs. Add support for
this clock and update the binding documentation.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
Changes since v1:
	- Added a per-soc flag to indicate the presence of special clock
	- Changed the name of special clock from "tmu_sclk" to "sclk"
	- Fixed the error handling for sclk

Tested on 5420 and 5800 based chromebooks, no change in existing behavior.

 .../devicetree/bindings/thermal/exynos-thermal.txt |    3 ++
 drivers/thermal/samsung/exynos_tmu.c               |   31 ++++++++++++++++----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index ae738f5..acf4705 100644
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
+	-- "sclk" clock for functional operation of the current TMU
+		channel
 - vtmu-supply: This entry is optional and provides the regulator node supplying
 		voltage to TMU. If needed this entry can be placed inside
 		board/platform specific dts file.
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index d44d91d..8ed8409 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -123,11 +123,14 @@
  * @base: base address of the single instance of the TMU controller.
  * @base_second: base address of the common registers of the TMU controller.
  * @irq: irq number of the TMU controller.
+ * @needs_sclk: SoC specific flag indicating that sclk is required for
+	functional operation of the TMU controller.
  * @soc: id of the SOC type.
  * @irq_work: pointer to the irq work structure.
  * @lock: lock to implement synchronization.
  * @clk: pointer to the clock structure.
  * @clk_sec: pointer to the clock structure for accessing the base_second.
+ * @sclk: pointer to the clock structure for accessing the tmu special clock.
  * @temp_error1: fused value of the first point trim.
  * @temp_error2: fused value of the second point trim.
  * @regulator: pointer to the TMU regulator structure.
@@ -144,10 +147,11 @@ struct exynos_tmu_data {
 	void __iomem *base;
 	void __iomem *base_second;
 	int irq;
+	bool needs_sclk;
 	enum soc_type soc;
 	struct work_struct irq_work;
 	struct mutex lock;
-	struct clk *clk, *clk_sec;
+	struct clk *clk, *clk_sec, *sclk;
 	u8 temp_error1, temp_error2;
 	struct regulator *regulator;
 	struct thermal_sensor_conf *reg_conf;
@@ -883,10 +887,24 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_clk_sec;
 	}
 
+	if (data->needs_sclk) {
+		data->sclk = devm_clk_get(&pdev->dev, "sclk");
+		if (IS_ERR(data->sclk)) {
+			dev_err(&pdev->dev, "Failed to get sclk\n");
+			goto err_clk;
+		} else {
+			ret = clk_prepare_enable(data->sclk);
+			if (ret) {
+				dev_err(&pdev->dev, "Failed to enable sclk\n");
+				goto err_clk;
+			}
+		}
+	}
+
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize TMU\n");
-		goto err_clk;
+		goto err_sclk;
 	}
 
 	exynos_tmu_control(pdev, true);
@@ -896,7 +914,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 				sizeof(struct thermal_sensor_conf), GFP_KERNEL);
 	if (!sensor_conf) {
 		ret = -ENOMEM;
-		goto err_clk;
+		goto err_sclk;
 	}
 	sprintf(sensor_conf->name, "therm_zone%d", data->id);
 	sensor_conf->read_temperature = (int (*)(void *))exynos_tmu_read;
@@ -928,7 +946,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	ret = exynos_register_thermal(sensor_conf);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register thermal interface\n");
-		goto err_clk;
+		goto err_sclk;
 	}
 	data->reg_conf = sensor_conf;
 
@@ -936,10 +954,12 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
-		goto err_clk;
+		goto err_sclk;
 	}
 
 	return 0;
+err_sclk:
+	clk_disable_unprepare(data->sclk);
 err_clk:
 	clk_unprepare(data->clk);
 err_clk_sec:
@@ -956,6 +976,7 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 
 	exynos_tmu_control(pdev, false);
 
+	clk_disable_unprepare(data->sclk);
 	clk_unprepare(data->clk);
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
-- 
1.7.9.5

