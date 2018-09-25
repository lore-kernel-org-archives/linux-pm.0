From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 14/14] thermal/drivers/hisi: Add the dual clusters sensors for hi3660
Date: Tue, 25 Sep 2018 11:03:12 +0200
Message-ID: <1537866192-12320-15-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

The code is ready to support multiple sensors on the hi3660. The DT
defines a thermal zone per cluster.

Add the little cluster sensor and let it bind with the thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index ba89cb9..c4111a9 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -424,14 +424,20 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 	struct platform_device *pdev = data->pdev;
 	struct device *dev = &pdev->dev;
 
-	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor), GFP_KERNEL);
+	data->nr_sensors = 2;
+
+	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor) *
+				    data->nr_sensors, GFP_KERNEL);
 	if (!data->sensor)
 		return -ENOMEM;
 
 	data->sensor[0].id = HI3660_BIG_SENSOR;
 	data->sensor[0].irq_name = "tsensor_a73";
 	data->sensor[0].data = data;
-	data->nr_sensors = 1;
+
+	data->sensor[1].id = HI3660_LITTLE_SENSOR;
+	data->sensor[1].irq_name = "tsensor_a53";
+	data->sensor[1].data = data;
 
 	return 0;
 }
@@ -443,8 +449,8 @@ static int hisi_thermal_get_temp(void *__data, int *temp)
 
 	*temp = data->ops->get_temp(sensor);
 
-	dev_dbg(&data->pdev->dev, "id=%d, temp=%d, thres=%d\n",
-		sensor->id, *temp, sensor->thres_temp);
+	dev_dbg(&data->pdev->dev, "tzd=%p, id=%d, temp=%d, thres=%d\n",
+		sensor->tzd, sensor->id, *temp, sensor->thres_temp);
 
 	return 0;
 }
-- 
2.7.4
