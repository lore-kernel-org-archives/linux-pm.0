From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 09/14] thermal/drivers/hisi: Use platform_get_irq_byname
Date: Tue, 25 Sep 2018 11:03:07 +0200
Message-ID: <1537866192-12320-10-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

As we have the interrupt names defines, replace platform_get_irq() by
platform_get_irq_byname(), so no confusion can be made when getting
the interrupt with the sensor id.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index a542cb3..941c2c4 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -63,6 +63,7 @@ struct hisi_thermal_data;
 struct hisi_thermal_sensor {
 	struct hisi_thermal_data *data;
 	struct thermal_zone_device *tzd;
+	const char *irq_name;
 	uint32_t id;
 	uint32_t thres_temp;
 };
@@ -407,6 +408,7 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 		return -ENOMEM;
 
 	data->sensor[0].id = HI6220_CLUSTER0_SENSOR;
+	data->sensor[0].irq_name = "tsensor_intr";
 	data->sensor[0].data = data;
 	data->nr_sensors = 1;
 
@@ -423,6 +425,7 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 		return -ENOMEM;
 
 	data->sensor[0].id = HI3660_BIG_SENSOR;
+	data->sensor[0].irq_name = "tsensor_a73";
 	data->sensor[0].data = data;
 	data->nr_sensors = 1;
 
@@ -576,13 +579,13 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		data->irq = platform_get_irq(pdev, 0);
+		data->irq = platform_get_irq_byname(pdev, sensor->irq_name);
 		if (data->irq < 0)
 			return data->irq;
 
 		ret = devm_request_threaded_irq(dev, data->irq, NULL,
 						hisi_thermal_alarm_irq_thread,
-						IRQF_ONESHOT, "hisi_thermal",
+						IRQF_ONESHOT, sensor->irq_name,
 						sensor);
 		if (ret < 0) {
 			dev_err(dev, "failed to request alarm irq: %d\n", ret);
-- 
2.7.4
