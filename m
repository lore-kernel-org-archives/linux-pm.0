From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 04/14] thermal/drivers/hisi: Factor out the probe functions
Date: Tue, 25 Sep 2018 11:03:02 +0200
Message-ID: <1537866192-12320-5-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

The hi6220 and the hi3660 probe functions are doing almost the same
operations, they can share 90% of their code.

Factor out the probe functions by moving the common code in the common
probe function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 567fde6..7287818 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -391,16 +391,8 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 {
 	struct platform_device *pdev = data->pdev;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(data->regs)) {
-		dev_err(dev, "failed to get io address\n");
-		return PTR_ERR(data->regs);
-	}
-
 	data->clk = devm_clk_get(dev, "thermal_clk");
 	if (IS_ERR(data->clk)) {
 		ret = PTR_ERR(data->clk);
@@ -409,10 +401,6 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 		return ret;
 	}
 
-	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0)
-		return data->irq;
-
 	data->sensor.id = HI6220_DEFAULT_SENSOR;
 
 	return 0;
@@ -420,21 +408,6 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 
 static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 {
-	struct platform_device *pdev = data->pdev;
-	struct device *dev = &pdev->dev;
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(data->regs)) {
-		dev_err(dev, "failed to get io address\n");
-		return PTR_ERR(data->regs);
-	}
-
-	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0)
-		return data->irq;
-
 	data->sensor.id = HI3660_DEFAULT_SENSOR;
 
 	return 0;
@@ -553,6 +526,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data;
 	struct device *dev = &pdev->dev;
+	struct resource *res;
 	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -564,6 +538,17 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	data->sensor.data = data;
 	data->ops = of_device_get_match_data(dev);
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->regs)) {
+		dev_err(dev, "failed to get io address\n");
+		return PTR_ERR(data->regs);
+	}
+
+	data->irq = platform_get_irq(pdev, 0);
+	if (data->irq < 0)
+		return data->irq;
+
 	ret = data->ops->probe(data);
 	if (ret)
 		return ret;
-- 
2.7.4
