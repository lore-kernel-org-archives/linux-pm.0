From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 06/18] thermal/drivers/hisi: Remove pointless lock
Date: Thu, 19 Oct 2017 19:05:48 +0200
Message-ID: <1508432760-17847-6-git-send-email-daniel.lezcano@linaro.org>
References: <6ac48f08-7fe6-92e9-0801-6ed3bcd05ff1@linaro.org>
 <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The threaded interrupt inspect the sensors structure to look in the temp
threshold field, but this field is read-only in all the code, except in the
probe function before the threaded interrupt is set. In other words there
is not race window in the threaded interrupt when reading the field value.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 1b44bfe..b657ae4 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -221,14 +221,10 @@ static irqreturn_t hisi_thermal_alarm_irq(int irq, void *dev)
 static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 {
 	struct hisi_thermal_data *data = dev;
-	struct hisi_thermal_sensor *sensor;
-
-	mutex_lock(&data->thermal_lock);
-	sensor = &data->sensors;
+	struct hisi_thermal_sensor *sensor = &data->sensors;
 
 	dev_crit(&data->pdev->dev, "THERMAL ALARM: T > %d\n",
 		 sensor->thres_temp);
-	mutex_unlock(&data->thermal_lock);
 
 	thermal_zone_device_update(data->sensors.tzd,
 				   THERMAL_EVENT_UNSPECIFIED);
-- 
2.7.4
