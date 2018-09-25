From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 06/14] thermal/drivers/hisi: Add multiple sensors support
Date: Tue, 25 Sep 2018 11:03:04 +0200
Message-ID: <1537866192-12320-7-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Change the code as it is dealing with several sensors.

For git-bisect compatibility (compilation and booting), assume the DT
is not yet changed and we have a single interrupt.

Next changes will support multiple interrupt sorted by their name.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 79 +++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 87b82fb..a5756f6 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -448,8 +448,8 @@ static const struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
 
 static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 {
-	struct hisi_thermal_data *data = dev;
-	struct hisi_thermal_sensor *sensor = &data->sensor[0];
+	struct hisi_thermal_sensor *sensor = dev;
+	struct hisi_thermal_data *data = sensor->data;
 	int temp = 0;
 
 	data->ops->irq_handler(sensor);
@@ -457,15 +457,17 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 	hisi_thermal_get_temp(sensor, &temp);
 
 	if (temp >= sensor->thres_temp) {
-		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
-			 temp, sensor->thres_temp);
+		dev_crit(&data->pdev->dev,
+			 "sensor <%d> THERMAL ALARM: %d > %d\n",
+			 sensor->id, temp, sensor->thres_temp);
 
-		thermal_zone_device_update(data->sensor[0].tzd,
+		thermal_zone_device_update(sensor->tzd,
 					   THERMAL_EVENT_UNSPECIFIED);
 
 	} else {
-		dev_crit(&data->pdev->dev, "THERMAL ALARM stopped: %d < %d\n",
-			 temp, sensor->thres_temp);
+		dev_crit(&data->pdev->dev,
+			 "sensor <%d> THERMAL ALARM stopped: %d < %d\n",
+			 sensor->id, temp, sensor->thres_temp);
 	}
 
 	return IRQ_HANDLED;
@@ -543,7 +545,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	struct hisi_thermal_data *data;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	int ret;
+	int i, ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -560,37 +562,41 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(data->regs);
 	}
 
-	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0)
-		return data->irq;
-
 	ret = data->ops->probe(data);
 	if (ret)
 		return ret;
 
-	ret = hisi_thermal_register_sensor(pdev, &data->sensor[0]);
-	if (ret) {
-		dev_err(dev, "failed to register thermal sensor: %d\n", ret);
-		return ret;
-	}
+	for (i = 0; i < data->nr_sensors; i++) {
+		struct hisi_thermal_sensor *sensor = &data->sensor[i];
 
-	ret = data->ops->enable_sensor(&data->sensor[0]);
-	if (ret) {
-		dev_err(dev, "Failed to setup the sensor: %d\n", ret);
-		return ret;
-	}
+		ret = hisi_thermal_register_sensor(pdev, sensor);
+		if (ret) {
+			dev_err(dev, "failed to register thermal sensor: %d\n",
+				ret);
+			return ret;
+		}
+
+		data->irq = platform_get_irq(pdev, 0);
+		if (data->irq < 0)
+			return data->irq;
 
-	if (data->irq) {
 		ret = devm_request_threaded_irq(dev, data->irq, NULL,
-				hisi_thermal_alarm_irq_thread,
-				IRQF_ONESHOT, "hisi_thermal", data);
+						hisi_thermal_alarm_irq_thread,
+						IRQF_ONESHOT, "hisi_thermal",
+						sensor);
 		if (ret < 0) {
 			dev_err(dev, "failed to request alarm irq: %d\n", ret);
 			return ret;
 		}
-	}
 
-	hisi_thermal_toggle_sensor(&data->sensor[0], true);
+		ret = data->ops->enable_sensor(sensor);
+		if (ret) {
+			dev_err(dev, "Failed to setup the sensor: %d\n", ret);
+			return ret;
+		}
+
+		hisi_thermal_toggle_sensor(sensor, true);
+	}
 
 	return 0;
 }
@@ -598,11 +604,14 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 static int hisi_thermal_remove(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
-	struct hisi_thermal_sensor *sensor = &data->sensor[0];
+	int i;
 
-	hisi_thermal_toggle_sensor(sensor, false);
+	for (i = 0; i < data->nr_sensors; i++) {
+		struct hisi_thermal_sensor *sensor = &data->sensor[i];
 
-	data->ops->disable_sensor(sensor);
+		hisi_thermal_toggle_sensor(sensor, false);
+		data->ops->disable_sensor(sensor);
+	}
 
 	return 0;
 }
@@ -611,8 +620,10 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 static int hisi_thermal_suspend(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
+	int i;
 
-	data->ops->disable_sensor(&data->sensor[0]);
+	for (i = 0; i < data->nr_sensors; i++)
+		data->ops->disable_sensor(&data->sensor[i]);
 
 	return 0;
 }
@@ -620,8 +631,12 @@ static int hisi_thermal_suspend(struct device *dev)
 static int hisi_thermal_resume(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
+	int i, ret = 0;
+
+	for (i = 0; i < data->nr_sensors; i++)
+		ret |= data->ops->enable_sensor(&data->sensor[i]);
 
-	return data->ops->enable_sensor(&data->sensor[0]);
+	return ret;
 }
 #endif
 
-- 
2.7.4
