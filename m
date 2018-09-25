From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 05/14] thermal/drivers/hisi: Prepare to support multiple sensors
Date: Tue, 25 Sep 2018 11:03:03 +0200
Message-ID: <1537866192-12320-6-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Convert the 'sensor' field to a pointer and propagate the change in
the file. Havintg a pointer, gives us the opportunity to define
multiple sensors.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 7287818..87b82fb 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -77,10 +77,11 @@ struct hisi_thermal_ops {
 
 struct hisi_thermal_data {
 	const struct hisi_thermal_ops *ops;
-	struct hisi_thermal_sensor sensor;
+	struct hisi_thermal_sensor *sensor;
 	struct platform_device *pdev;
 	struct clk *clk;
 	void __iomem *regs;
+	int nr_sensors;
 	int irq;
 };
 
@@ -401,14 +402,29 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 		return ret;
 	}
 
-	data->sensor.id = HI6220_DEFAULT_SENSOR;
+	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor), GFP_KERNEL);
+	if (!data->sensor)
+		return -ENOMEM;
+
+	data->sensor[0].id = HI6220_DEFAULT_SENSOR;
+	data->sensor[0].data = data;
+	data->nr_sensors = 1;
 
 	return 0;
 }
 
 static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 {
-	data->sensor.id = HI3660_DEFAULT_SENSOR;
+	struct platform_device *pdev = data->pdev;
+	struct device *dev = &pdev->dev;
+
+	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor), GFP_KERNEL);
+	if (!data->sensor)
+		return -ENOMEM;
+
+	data->sensor[0].id = HI3660_DEFAULT_SENSOR;
+	data->sensor[0].data = data;
+	data->nr_sensors = 1;
 
 	return 0;
 }
@@ -433,7 +449,7 @@ static const struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
 static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 {
 	struct hisi_thermal_data *data = dev;
-	struct hisi_thermal_sensor *sensor = &data->sensor;
+	struct hisi_thermal_sensor *sensor = &data->sensor[0];
 	int temp = 0;
 
 	data->ops->irq_handler(sensor);
@@ -444,7 +460,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
 			 temp, sensor->thres_temp);
 
-		thermal_zone_device_update(data->sensor.tzd,
+		thermal_zone_device_update(data->sensor[0].tzd,
 					   THERMAL_EVENT_UNSPECIFIED);
 
 	} else {
@@ -535,7 +551,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 
 	data->pdev = pdev;
 	platform_set_drvdata(pdev, data);
-	data->sensor.data = data;
 	data->ops = of_device_get_match_data(dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -553,13 +568,13 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = hisi_thermal_register_sensor(pdev, &data->sensor);
+	ret = hisi_thermal_register_sensor(pdev, &data->sensor[0]);
 	if (ret) {
 		dev_err(dev, "failed to register thermal sensor: %d\n", ret);
 		return ret;
 	}
 
-	ret = data->ops->enable_sensor(&data->sensor);
+	ret = data->ops->enable_sensor(&data->sensor[0]);
 	if (ret) {
 		dev_err(dev, "Failed to setup the sensor: %d\n", ret);
 		return ret;
@@ -575,7 +590,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		}
 	}
 
-	hisi_thermal_toggle_sensor(&data->sensor, true);
+	hisi_thermal_toggle_sensor(&data->sensor[0], true);
 
 	return 0;
 }
@@ -583,11 +598,11 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 static int hisi_thermal_remove(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
-	struct hisi_thermal_sensor *sensor = &data->sensor;
+	struct hisi_thermal_sensor *sensor = &data->sensor[0];
 
 	hisi_thermal_toggle_sensor(sensor, false);
 
-	data->ops->disable_sensor(&data->sensor);
+	data->ops->disable_sensor(sensor);
 
 	return 0;
 }
@@ -597,7 +612,7 @@ static int hisi_thermal_suspend(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
-	data->ops->disable_sensor(&data->sensor);
+	data->ops->disable_sensor(&data->sensor[0]);
 
 	return 0;
 }
@@ -606,7 +621,7 @@ static int hisi_thermal_resume(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
-	return data->ops->enable_sensor(&data->sensor);
+	return data->ops->enable_sensor(&data->sensor[0]);
 }
 #endif
 
-- 
2.7.4
