From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] thermal/drivers/hisi: Switch to interrupt mode
Date: Wed, 27 Sep 2017 01:54:09 +0200
Message-ID: <1506470049-12597-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

At this moment, we have both the interrupt setup and the polling enabled. The
interrupt does nothing more than forcing an update while the temperature is
polled every second.

We can do much better than that, threshold is set to 65C in the DT and the
passive ooling device enters in the dance when 75C is reached. We need to
sample the temperature at 65C in order to let the IPA gather enough values for
the PID computation. If the SoC is running at a temperature below 65C, we will
be constantly polling for nothing.

This patch disables the sensor when the temperature is below the temperature
and enables it when passing the threshold. It resuls the sensor thermal sensor
driver will have no activity most of the time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 39f4627..74ea70d 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -218,6 +218,15 @@ static int hisi_thermal_get_temp(void *__data, int *temp)
 	return 0;
 }
 
+static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
+				       bool on)
+{
+	struct thermal_zone_device *tzd = sensor->tzd;
+
+	tzd->ops->set_mode(tzd,
+		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
+}
+
 static const struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
 	.get_temp = hisi_thermal_get_temp,
 };
@@ -236,12 +245,16 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
 			 temp, sensor->thres_temp);
 
+		hisi_thermal_toggle_sensor(&data->sensor, true);
+
 		thermal_zone_device_update(data->sensor.tzd,
 					   THERMAL_EVENT_UNSPECIFIED);
 
 	} else if (temp < sensor->thres_temp) {
 		dev_crit(&data->pdev->dev, "THERMAL ALARM stopped: %d < %d\n",
 			 temp, sensor->thres_temp);
+
+		hisi_thermal_toggle_sensor(&data->sensor, false);
 	}
 
 	return IRQ_HANDLED;
@@ -286,15 +299,6 @@ static const struct of_device_id of_hisi_thermal_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
 
-static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
-				       bool on)
-{
-	struct thermal_zone_device *tzd = sensor->tzd;
-
-	tzd->ops->set_mode(tzd,
-		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
-}
-
 static int hisi_thermal_setup(struct hisi_thermal_data *data)
 {
 	struct hisi_thermal_sensor *sensor;
@@ -393,7 +397,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	hisi_thermal_toggle_sensor(&data->sensor, true);
+	hisi_thermal_toggle_sensor(&data->sensor, false);
 
 	return 0;
 }
-- 
2.7.4
