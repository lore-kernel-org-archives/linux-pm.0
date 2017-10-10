From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 21/25] thermal/drivers/hisi: Prepare to add support for other hisi platforms
Date: Tue, 10 Oct 2017 20:02:46 +0200
Message-ID: <1507658570-32675-21-git-send-email-daniel.lezcano@linaro.org>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org
List-Id: linux-pm@vger.kernel.org

From: Kevin Wangtao <kevin.wangtao@linaro.org>

For platform compatibility, add the tsensor ops to a thermal data structure.
Each platform has its own probe function to register proper tsensor ops
function to the pointer, platform related resource request are also implemented
in the platform probe function.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 135 +++++++++++++++++++++++++++--------------
 1 file changed, 89 insertions(+), 46 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 8a70ab7..b5a7159 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/of_device.h>
 
 #include "thermal_core.h"
 
@@ -30,7 +31,7 @@
 #define HI6220_TEMP0_TH				(0x4)
 #define HI6220_TEMP0_RST_TH			(0x8)
 #define HI6220_TEMP0_CFG			(0xC)
-#define HI6220_TEMP0_CFG_SS_MSK		(0xF000)
+#define HI6220_TEMP0_CFG_SS_MSK			(0xF000)
 #define HI6220_TEMP0_CFG_HDAK_MSK		(0x30)
 #define HI6220_TEMP0_EN				(0x10)
 #define HI6220_TEMP0_INT_EN			(0x14)
@@ -41,7 +42,7 @@
 #define HI6220_TEMP_BASE			(-60000)
 #define HI6220_TEMP_RESET			(100000)
 #define HI6220_TEMP_STEP			(785)
-#define HI6220_TEMP_LAG			(3500)
+#define HI6220_TEMP_LAG				(3500)
 
 #define HI6220_DEFAULT_SENSOR		2
 
@@ -52,6 +53,10 @@ struct hisi_thermal_sensor {
 };
 
 struct hisi_thermal_data {
+	int (*get_temp)(struct hisi_thermal_data *data);
+	int (*enable_sensor)(struct hisi_thermal_data *data);
+	int (*disable_sensor)(struct hisi_thermal_data *data);
+	int (*irq_handler)(struct hisi_thermal_data *data);
 	struct platform_device *pdev;
 	struct clk *clk;
 	struct hisi_thermal_sensor sensor;
@@ -59,6 +64,7 @@ struct hisi_thermal_data {
 	int irq;
 };
 
+
 /*
  * The temperature computation on the tsensor is as follow:
  *	Unit: millidegree Celsius
@@ -192,7 +198,18 @@ static inline void hi6220_thermal_hdak_set(void __iomem *addr, int value)
 	       (value << 4), addr + HI6220_TEMP0_CFG);
 }
 
-static void hi6220_thermal_disable_sensor(struct hisi_thermal_data *data)
+static int hi6220_thermal_irq_handler(struct hisi_thermal_data *data)
+{
+	hi6220_thermal_alarm_clear(data->regs, 1);
+	return 0;
+}
+
+static int hi6220_thermal_get_temp(struct hisi_thermal_data *data)
+{
+	return hi6220_thermal_get_temperature(data->regs);
+}
+
+static int hi6220_thermal_disable_sensor(struct hisi_thermal_data *data)
 {
 	/* disable sensor module */
 	hi6220_thermal_enable(data->regs, 0);
@@ -200,9 +217,9 @@ static void hi6220_thermal_disable_sensor(struct hisi_thermal_data *data)
 	hi6220_thermal_reset_enable(data->regs, 0);
 
 	clk_disable_unprepare(data->clk);
+	return 0;
 }
 
-
 static int hi6220_thermal_enable_sensor(struct hisi_thermal_data *data)
 {
 	struct hisi_thermal_sensor *sensor = &data->sensor;
@@ -240,12 +257,50 @@ static int hi6220_thermal_enable_sensor(struct hisi_thermal_data *data)
 
 	return 0;
 }
+
+static int hi6220_thermal_probe(struct hisi_thermal_data *data)
+{
+	struct platform_device *pdev = data->pdev;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int ret;
+
+	data->get_temp = hi6220_thermal_get_temp;
+	data->enable_sensor = hi6220_thermal_enable_sensor;
+	data->disable_sensor = hi6220_thermal_disable_sensor;
+	data->irq_handler = hi6220_thermal_irq_handler;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->regs)) {
+		dev_err(dev, "failed to get io address\n");
+		return PTR_ERR(data->regs);
+	}
+
+	data->clk = devm_clk_get(dev, "thermal_clk");
+	if (IS_ERR(data->clk)) {
+		ret = PTR_ERR(data->clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get thermal clk: %d\n", ret);
+		return ret;
+	}
+
+	data->irq = platform_get_irq(pdev, 0);
+	if (data->irq < 0)
+		return data->irq;
+
+	data->sensor.id = HI6220_DEFAULT_SENSOR;
+
+	return 0;
+}
+
+
 static int hisi_thermal_get_temp(void *__data, int *temp)
 {
 	struct hisi_thermal_data *data = __data;
 	struct hisi_thermal_sensor *sensor = &data->sensor;
 
-	*temp = hi6220_thermal_get_temperature(data->regs);
+	*temp = data->get_temp(data);
 
 	dev_dbg(&data->pdev->dev, "id=%d, temp=%d, thres=%d\n",
 		sensor->id, *temp, sensor->thres_temp);
@@ -263,7 +318,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 	struct hisi_thermal_sensor *sensor = &data->sensor;
 	int temp = 0;
 
-	hi6220_thermal_alarm_clear(data->regs, 1);
+	data->irq_handler(data);
 
 	hisi_thermal_get_temp(data, &temp);
 
@@ -284,14 +339,11 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 
 static int hisi_thermal_register_sensor(struct platform_device *pdev,
 					struct hisi_thermal_data *data,
-					struct hisi_thermal_sensor *sensor,
-					int index)
+					struct hisi_thermal_sensor *sensor)
 {
 	int ret, i;
 	const struct thermal_trip *trip;
 
-	sensor->id = index;
-
 	sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
 							   sensor->id, data,
 							   &hisi_of_thermal_ops);
@@ -316,7 +368,7 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 }
 
 static const struct of_device_id of_hisi_thermal_match[] = {
-	{ .compatible = "hisilicon,tsensor" },
+	{ .compatible = "hisilicon,tsensor", .data = hi6220_thermal_probe },
 	{ /* end */ }
 };
 MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
@@ -333,58 +385,48 @@ static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
 static int hisi_thermal_probe(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data;
-	struct resource *res;
+	int (*platform_probe)(struct hisi_thermal_data *);
+	struct device *dev = &pdev->dev;
 	int ret;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	data->pdev = pdev;
+	platform_set_drvdata(pdev, data);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(data->regs)) {
-		dev_err(&pdev->dev, "failed to get io address\n");
-		return PTR_ERR(data->regs);
+	platform_probe = of_device_get_match_data(dev);
+	if (!platform_probe) {
+		dev_err(dev, "failed to get probe func\n");
+		return -EINVAL;
 	}
 
-	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0)
-		return data->irq;
-
-	platform_set_drvdata(pdev, data);
-
-	data->clk = devm_clk_get(&pdev->dev, "thermal_clk");
-	if (IS_ERR(data->clk)) {
-		ret = PTR_ERR(data->clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to get thermal clk: %d\n", ret);
+	ret = platform_probe(data);
+	if (ret)
 		return ret;
-	}
 
 	ret = hisi_thermal_register_sensor(pdev, data,
-					   &data->sensor,
-					   HI6220_DEFAULT_SENSOR);
+					   &data->sensor);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register thermal sensor: %d\n",
-			ret);
+		dev_err(dev, "failed to register thermal sensor: %d\n", ret);
 		return ret;
 	}
 
-	ret = hi6220_thermal_enable_sensor(data);
+	ret = data->enable_sensor(data);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to setup the sensor: %d\n", ret);
+		dev_err(dev, "Failed to setup the sensor: %d\n", ret);
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, data->irq, NULL,
-					hisi_thermal_alarm_irq_thread,
-					IRQF_ONESHOT, "hisi_thermal", data);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
-		return ret;
+	if (data->irq) {
+		ret = devm_request_threaded_irq(dev, data->irq, NULL,
+				hisi_thermal_alarm_irq_thread,
+				IRQF_ONESHOT, "hisi_thermal", data);
+		if (ret < 0) {
+			dev_err(dev, "failed to request alarm irq: %d\n", ret);
+			return ret;
+		}
 	}
 
 	hisi_thermal_toggle_sensor(&data->sensor, true);
@@ -398,7 +440,8 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 	struct hisi_thermal_sensor *sensor = &data->sensor;
 
 	hisi_thermal_toggle_sensor(sensor, false);
-	hi6220_thermal_disable_sensor(data);
+
+	data->disable_sensor(data);
 
 	return 0;
 }
@@ -408,7 +451,7 @@ static int hisi_thermal_suspend(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
-	hi6220_thermal_disable_sensor(data);
+	data->disable_sensor(data);
 
 	return 0;
 }
@@ -417,7 +460,7 @@ static int hisi_thermal_resume(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
-	return hi6220_thermal_enable_sensor(data);
+	return data->enable_sensor(data);
 }
 #endif
 
-- 
2.7.4
