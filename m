From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH 1/5] thermal: exynos: enable core tmu clk on exynos platform
Date: Tue, 17 Jul 2018 10:12:18 +0000
Message-ID: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
List-Id: linux-pm@vger.kernel.org

clk_summary do not show tmu_apbif clk enable, so replace
the clk_prepare with clk_prepare_enables to enable tmu clk.
simplify the enable of tmu_triminfo_apbif clk, also fixed
the order of goto error for failed cases.

CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
before:
cat /sys/kernel/debug/clk/clk_summary | grep tmu
                         tmu_gpu           0            2    66600000          0 0
                         tmu              0            6    66600000          0 0
after:
cat /sys/kernel/debug/clk/clk_summary | grep tmu
                         tmu_gpu       2        2        0    66600000          0 0
                         tmu          6        6        0    66600000          0 0
---
 drivers/thermal/samsung/exynos_tmu.c | 45 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a992e51..0164c9e 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1060,41 +1060,40 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to get clock\n");
 		ret = PTR_ERR(data->clk);
 		goto err_sensor;
-	}
-
-	data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
-	if (IS_ERR(data->clk_sec)) {
-		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
-			dev_err(&pdev->dev, "Failed to get triminfo clock\n");
-			ret = PTR_ERR(data->clk_sec);
-			goto err_sensor;
-		}
 	} else {
-		ret = clk_prepare(data->clk_sec);
+		ret = clk_prepare_enable(data->clk);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to get clock\n");
 			goto err_sensor;
 		}
 	}
 
-	ret = clk_prepare(data->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to get clock\n");
-		goto err_clk_sec;
-	}
-
 	switch (data->soc) {
+	case SOC_ARCH_EXYNOS5420_TRIMINFO:
+		data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
+		if (IS_ERR(data->clk_sec)) {
+			dev_err(&pdev->dev, "Failed to get triminfo clock\n");
+			ret = PTR_ERR(data->clk_sec);
+			goto err_clk;
+		} else {
+			ret = clk_prepare_enable(data->clk_sec);
+			if (ret) {
+				dev_err(&pdev->dev, "Failed to get clock\n");
+				goto err_clk;
+			}
+		}
+		break;
 	case SOC_ARCH_EXYNOS5433:
 	case SOC_ARCH_EXYNOS7:
 		data->sclk = devm_clk_get(&pdev->dev, "tmu_sclk");
 		if (IS_ERR(data->sclk)) {
 			dev_err(&pdev->dev, "Failed to get sclk\n");
-			goto err_clk;
+			goto err_clk_sec;
 		} else {
 			ret = clk_prepare_enable(data->sclk);
 			if (ret) {
 				dev_err(&pdev->dev, "Failed to enable sclk\n");
-				goto err_clk;
+				goto err_clk_sec;
 			}
 		}
 		break;
@@ -1134,11 +1133,11 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
 err_sclk:
 	clk_disable_unprepare(data->sclk);
-err_clk:
-	clk_unprepare(data->clk);
 err_clk_sec:
 	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
+		clk_disable_unprepare(data->clk_sec);
+err_clk:
+	clk_disable_unprepare(data->clk);
 err_sensor:
 	if (!IS_ERR(data->regulator))
 		regulator_disable(data->regulator);
@@ -1155,9 +1154,9 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 	exynos_tmu_control(pdev, false);
 
 	clk_disable_unprepare(data->sclk);
-	clk_unprepare(data->clk);
+	clk_disable_unprepare(data->clk);
 	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
+		clk_disable_unprepare(data->clk_sec);
 
 	if (!IS_ERR(data->regulator))
 		regulator_disable(data->regulator);
-- 
2.7.4
