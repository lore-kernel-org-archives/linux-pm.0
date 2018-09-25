From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 01/14] thermal/drivers/hisi: Change the platform data pointer to sensor ops
Date: Tue, 25 Sep 2018 11:02:59 +0200
Message-ID: <1537866192-12320-2-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Group the temperature sensor specific ops into a single structure and
assign it to hisi thermal data structure.

Change the platform data pointer to reference the specific sensor ops
instead of the probe functions.

Moving out those allow to split the code to self-encapsulate the
sensor object.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 60 ++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 761d055..9794cfe 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -64,11 +64,18 @@ struct hisi_thermal_sensor {
 	uint32_t thres_temp;
 };
 
-struct hisi_thermal_data {
+struct hisi_thermal_data;
+
+struct hisi_thermal_ops {
 	int (*get_temp)(struct hisi_thermal_data *data);
 	int (*enable_sensor)(struct hisi_thermal_data *data);
 	int (*disable_sensor)(struct hisi_thermal_data *data);
 	int (*irq_handler)(struct hisi_thermal_data *data);
+	int (*probe)(struct hisi_thermal_data *data);
+};
+
+struct hisi_thermal_data {
+	const struct hisi_thermal_ops *ops;
 	struct platform_device *pdev;
 	struct clk *clk;
 	struct hisi_thermal_sensor sensor;
@@ -374,11 +381,6 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 	struct resource *res;
 	int ret;
 
-	data->get_temp = hi6220_thermal_get_temp;
-	data->enable_sensor = hi6220_thermal_enable_sensor;
-	data->disable_sensor = hi6220_thermal_disable_sensor;
-	data->irq_handler = hi6220_thermal_irq_handler;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(data->regs)) {
@@ -409,11 +411,6 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 
-	data->get_temp = hi3660_thermal_get_temp;
-	data->enable_sensor = hi3660_thermal_enable_sensor;
-	data->disable_sensor = hi3660_thermal_disable_sensor;
-	data->irq_handler = hi3660_thermal_irq_handler;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(data->regs)) {
@@ -435,7 +432,7 @@ static int hisi_thermal_get_temp(void *__data, int *temp)
 	struct hisi_thermal_data *data = __data;
 	struct hisi_thermal_sensor *sensor = &data->sensor;
 
-	*temp = data->get_temp(data);
+	*temp = data->ops->get_temp(data);
 
 	dev_dbg(&data->pdev->dev, "id=%d, temp=%d, thres=%d\n",
 		sensor->id, *temp, sensor->thres_temp);
@@ -453,7 +450,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 	struct hisi_thermal_sensor *sensor = &data->sensor;
 	int temp = 0;
 
-	data->irq_handler(data);
+	data->ops->irq_handler(data);
 
 	hisi_thermal_get_temp(data, &temp);
 
@@ -502,14 +499,30 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 	return 0;
 }
 
+static const struct hisi_thermal_ops hi6220_ops = {
+	.get_temp	= hi6220_thermal_get_temp,
+	.enable_sensor	= hi6220_thermal_enable_sensor,
+	.disable_sensor	= hi6220_thermal_disable_sensor,
+	.irq_handler	= hi6220_thermal_irq_handler,
+	.probe		= hi6220_thermal_probe,
+};
+
+static const struct hisi_thermal_ops hi3660_ops = {
+	.get_temp	= hi3660_thermal_get_temp,
+	.enable_sensor	= hi3660_thermal_enable_sensor,
+	.disable_sensor	= hi3660_thermal_disable_sensor,
+	.irq_handler	= hi3660_thermal_irq_handler,
+	.probe		= hi3660_thermal_probe,
+};
+
 static const struct of_device_id of_hisi_thermal_match[] = {
 	{
 		.compatible = "hisilicon,tsensor",
-		.data = hi6220_thermal_probe
+		.data = &hi6220_ops,
 	},
 	{
 		.compatible = "hisilicon,hi3660-tsensor",
-		.data = hi3660_thermal_probe
+		.data = &hi3660_ops,
 	},
 	{ /* end */ }
 };
@@ -527,7 +540,6 @@ static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
 static int hisi_thermal_probe(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data;
-	int (*platform_probe)(struct hisi_thermal_data *);
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -538,13 +550,9 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	data->pdev = pdev;
 	platform_set_drvdata(pdev, data);
 
-	platform_probe = of_device_get_match_data(dev);
-	if (!platform_probe) {
-		dev_err(dev, "failed to get probe func\n");
-		return -EINVAL;
-	}
+	data->ops = of_device_get_match_data(dev);
 
-	ret = platform_probe(data);
+	ret = data->ops->probe(data);
 	if (ret)
 		return ret;
 
@@ -555,7 +563,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = data->enable_sensor(data);
+	ret = data->ops->enable_sensor(data);
 	if (ret) {
 		dev_err(dev, "Failed to setup the sensor: %d\n", ret);
 		return ret;
@@ -583,7 +591,7 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 
 	hisi_thermal_toggle_sensor(sensor, false);
 
-	data->disable_sensor(data);
+	data->ops->disable_sensor(data);
 
 	return 0;
 }
@@ -593,7 +601,7 @@ static int hisi_thermal_suspend(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
-	data->disable_sensor(data);
+	data->ops->disable_sensor(data);
 
 	return 0;
 }
@@ -602,7 +610,7 @@ static int hisi_thermal_resume(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
-	return data->enable_sensor(data);
+	return data->ops->enable_sensor(data);
 }
 #endif
 
-- 
2.7.4
