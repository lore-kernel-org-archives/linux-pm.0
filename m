From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 4/5] power: supply: sc27xx: Add suspend/resume interfaces
Date: Wed, 14 Nov 2018 17:07:07 +0800
Message-ID: <edd5230db26b5f69b9b4030972b5a34927055460.1542185618.git.baolin.wang@linaro.org>
References: <cover.1542185618.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
References: <cover.1542185618.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

Add fuel gauge platform suspend and resume interfaces. In suspend state,
we should enable the low voltage and coulomb counter threshold interrupts
to wake up system to calibrate the battery capacity in lower voltage stage.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   77 ++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 962d0f8..8c52e29 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -789,6 +789,7 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 	data->bat_present = !!ret;
 	mutex_init(&data->lock);
 	data->dev = &pdev->dev;
+	platform_set_drvdata(pdev, data);
 
 	fgu_cfg.drv_data = data;
 	fgu_cfg.of_node = np;
@@ -846,6 +847,81 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sc27xx_fgu_resume(struct device *dev)
+{
+	struct sc27xx_fgu_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_FGU_INT_EN,
+				 SC27XX_FGU_LOW_OVERLOAD_INT |
+				 SC27XX_FGU_CLBCNT_DELTA_INT, 0);
+	if (ret) {
+		dev_err(data->dev, "failed to disable fgu interrupts\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sc27xx_fgu_suspend(struct device *dev)
+{
+	struct sc27xx_fgu_data *data = dev_get_drvdata(dev);
+	int ret, status, ocv;
+
+	ret = sc27xx_fgu_get_status(data, &status);
+	if (ret)
+		return ret;
+
+	/*
+	 * If we are charging, then no need to enable the FGU interrupts to
+	 * adjust the battery capacity.
+	 */
+	if (status != POWER_SUPPLY_STATUS_NOT_CHARGING)
+		return 0;
+
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_FGU_INT_EN,
+				 SC27XX_FGU_LOW_OVERLOAD_INT,
+				 SC27XX_FGU_LOW_OVERLOAD_INT);
+	if (ret) {
+		dev_err(data->dev, "failed to enable low voltage interrupt\n");
+		return ret;
+	}
+
+	ret = sc27xx_fgu_get_vbat_ocv(data, &ocv);
+	if (ret)
+		goto disable_int;
+
+	/*
+	 * If current OCV is less than the minimum voltage, we should enable the
+	 * coulomb counter threshold interrupt to notify events to adjust the
+	 * battery capacity.
+	 */
+	if (ocv < data->min_volt) {
+		ret = regmap_update_bits(data->regmap,
+					 data->base + SC27XX_FGU_INT_EN,
+					 SC27XX_FGU_CLBCNT_DELTA_INT,
+					 SC27XX_FGU_CLBCNT_DELTA_INT);
+		if (ret) {
+			dev_err(data->dev,
+				"failed to enable coulomb threshold int\n");
+			goto disable_int;
+		}
+	}
+
+	return 0;
+
+disable_int:
+	regmap_update_bits(data->regmap, data->base + SC27XX_FGU_INT_EN,
+			   SC27XX_FGU_LOW_OVERLOAD_INT, 0);
+	return ret;
+}
+#endif
+
+static const struct dev_pm_ops sc27xx_fgu_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sc27xx_fgu_suspend, sc27xx_fgu_resume)
+};
+
 static const struct of_device_id sc27xx_fgu_of_match[] = {
 	{ .compatible = "sprd,sc2731-fgu", },
 	{ }
@@ -856,6 +932,7 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 	.driver = {
 		.name = "sc27xx-fgu",
 		.of_match_table = sc27xx_fgu_of_match,
+		.pm = &sc27xx_fgu_pm_ops,
 	}
 };
 
-- 
1.7.9.5
