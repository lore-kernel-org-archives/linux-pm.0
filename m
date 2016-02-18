From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 3/3] thermal: exynos: Print a message about exceeded number of
 supported trip-points
Date: Thu, 18 Feb 2016 14:14:20 +0900
Message-ID: <1455772460-20684-3-git-send-email-k.kozlowski@samsung.com>
References: <1455772460-20684-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1455772460-20684-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

When DeviveTree contains more trip-points than SoC can configure
(usually more than four) and polling mode is not enabled, then the
remaining trip-points will be silently ignored. No interrupts will be
generated for them.

This might be quite dangerous when one provides DTB with a
non-configurable critical trip-point, like (assuming four supported
thresholds in TMU):
 - alert @50 C (type: active),
 - alert @60 C (type: active),
 - alert @70 C (type: active),
 - alert @80 C (type: active),
 - critical @120 C (type: critical) <- no interrupts generated.

This is a mistake in DTB so print a message in such case.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index fa61eff88496..6c6f59ba7423 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -184,6 +184,7 @@
  * @temp_error2: fused value of the second point trim.
  * @regulator: pointer to the TMU regulator structure.
  * @reg_conf: pointer to structure to register with core thermal.
+ * @ntrip: number of supported trip points.
  * @tmu_initialize: SoC specific TMU initialization method
  * @tmu_control: SoC specific TMU control method
  * @tmu_read: SoC specific TMU temperature read method
@@ -203,6 +204,7 @@ struct exynos_tmu_data {
 	u16 temp_error1, temp_error2;
 	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
+	unsigned int ntrip;
 
 	int (*tmu_initialize)(struct platform_device *pdev);
 	void (*tmu_control)(struct platform_device *pdev, bool on);
@@ -346,6 +348,14 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	int ret;
 
+	if (of_thermal_get_ntrips(data->tzd) > data->ntrip) {
+		dev_info(&pdev->dev,
+			 "More trip points than supported by this TMU.\n");
+		dev_info(&pdev->dev,
+			 "%d trip points should be configured in polling mode.\n",
+			 (of_thermal_get_ntrips(data->tzd) - data->ntrip));
+	}
+
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
 	if (!IS_ERR(data->clk_sec))
@@ -1210,6 +1220,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_control = exynos4210_tmu_control;
 		data->tmu_read = exynos4210_tmu_read;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->ntrip = 4;
 		break;
 	case SOC_ARCH_EXYNOS3250:
 	case SOC_ARCH_EXYNOS4412:
@@ -1222,6 +1233,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_read = exynos4412_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->ntrip = 4;
 		break;
 	case SOC_ARCH_EXYNOS5433:
 		data->tmu_initialize = exynos5433_tmu_initialize;
@@ -1229,6 +1241,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_read = exynos4412_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->ntrip = 8;
 		break;
 	case SOC_ARCH_EXYNOS5440:
 		data->tmu_initialize = exynos5440_tmu_initialize;
@@ -1236,6 +1249,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_read = exynos5440_tmu_read;
 		data->tmu_set_emulation = exynos5440_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos5440_tmu_clear_irqs;
+		data->ntrip = 4;
 		break;
 	case SOC_ARCH_EXYNOS7:
 		data->tmu_initialize = exynos7_tmu_initialize;
@@ -1243,6 +1257,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_read = exynos7_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->ntrip = 8;
 		break;
 	default:
 		dev_err(&pdev->dev, "Platform not supported\n");
-- 
2.5.0
