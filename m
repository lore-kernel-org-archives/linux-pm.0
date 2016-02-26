From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/5] thermal: hisilicon: support to use any sensor
Date: Fri, 26 Feb 2016 11:43:44 +0800
Message-ID: <1456458227-12950-3-git-send-email-leo.yan@linaro.org>
References: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, kongxinwei <kong.kongxinwei@hisilicon.com>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <Punit.Agrawal@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

In current code sensor driver registers all 4 sensors together and if
any of them has not bound to thermal zone successfully then driver will
return failure for driver's initialization. As a result, if DT binds
thermal zone with only one sensor, then the thermal driver will not work
well anymore.

So this patch is to fix this issue. It allows the thermal sensor driver
can register any number sensors at initialization phase, and fix up code
for other related code to skip related sensor's accessing if the sensor
has not been enabled in initialization phase.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 5e820b5..7a3e5d8 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -160,7 +160,7 @@ static int hisi_thermal_get_temp(void *_sensor, int *temp)
 	struct hisi_thermal_sensor *sensor = _sensor;
 	struct hisi_thermal_data *data = sensor->thermal;
 
-	int sensor_id = 0, i;
+	int sensor_id = -1, i;
 	long max_temp = 0;
 
 	*temp = hisi_thermal_get_sensor_temp(data, sensor);
@@ -168,12 +168,19 @@ static int hisi_thermal_get_temp(void *_sensor, int *temp)
 	sensor->sensor_temp = *temp;
 
 	for (i = 0; i < HISI_MAX_SENSORS; i++) {
+		if (!data->sensors[i].tzd)
+			continue;
+
 		if (data->sensors[i].sensor_temp >= max_temp) {
 			max_temp = data->sensors[i].sensor_temp;
 			sensor_id = i;
 		}
 	}
 
+	/* If no sensor has been enabled, then skip to enable irq */
+	if (sensor_id == -1)
+		return 0;
+
 	mutex_lock(&data->thermal_lock);
 	data->irq_bind_sensor = sensor_id;
 	mutex_unlock(&data->thermal_lock);
@@ -226,8 +233,12 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 		 sensor->thres_temp / 1000);
 	mutex_unlock(&data->thermal_lock);
 
-	for (i = 0; i < HISI_MAX_SENSORS; i++)
+	for (i = 0; i < HISI_MAX_SENSORS; i++) {
+		if (!data->sensors[i].tzd)
+			continue;
+
 		thermal_zone_device_update(data->sensors[i].tzd);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -247,6 +258,7 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 				sensor, &hisi_of_thermal_ops);
 	if (IS_ERR(sensor->tzd)) {
 		ret = PTR_ERR(sensor->tzd);
+		sensor->tzd = NULL;
 		dev_err(&pdev->dev, "failed to register sensor id %d: %d\n",
 			sensor->id, ret);
 		return ret;
@@ -334,25 +346,17 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	for (i = 0; i < HISI_MAX_SENSORS; ++i) {
 		ret = hisi_thermal_register_sensor(pdev, data,
 						   &data->sensors[i], i);
-		if (ret) {
+		if (ret)
 			dev_err(&pdev->dev,
 				"failed to register thermal sensor: %d\n", ret);
-			goto err_get_sensor_data;
-		}
+		else
+			hisi_thermal_toggle_sensor(&data->sensors[i], true);
 	}
 
 	hisi_thermal_enable_bind_irq_sensor(data);
 	data->irq_enabled = true;
 
-	for (i = 0; i < HISI_MAX_SENSORS; i++)
-		hisi_thermal_toggle_sensor(&data->sensors[i], true);
-
 	return 0;
-
-err_get_sensor_data:
-	clk_disable_unprepare(data->clk);
-
-	return ret;
 }
 
 static int hisi_thermal_remove(struct platform_device *pdev)
@@ -363,6 +367,9 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 	for (i = 0; i < HISI_MAX_SENSORS; i++) {
 		struct hisi_thermal_sensor *sensor = &data->sensors[i];
 
+		if (!sensor->tzd)
+			continue;
+
 		hisi_thermal_toggle_sensor(sensor, false);
 		thermal_zone_of_sensor_unregister(&pdev->dev, sensor->tzd);
 	}
-- 
1.9.1
