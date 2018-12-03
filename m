From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Subject: [PATCH 2/5] thermal/drivers/hisi: Remove pointless lock
Date: Mon,  3 Dec 2018 11:31:04 -0200
Message-ID: <20181203133107.4002-3-rafael.tinoco@linaro.org>
References: <20181203133107.4002-1-rafael.tinoco@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203133107.4002-1-rafael.tinoco@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sashal@kernel.org
Cc: rafael.tinoco@linaro.org, gregkh@linuxfoundation.org, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

commit 2d4fa7b4c6f8080ced2e8237c9f46fb1fc110d64 upstream.

The threaded interrupt inspect the sensors structure to look in the temp
threshold field, but this field is read-only in all the code, except in the
probe function before the threaded interrupt is set. In other words there
is not race window in the threaded interrupt when reading the field value.

Link: https://bugs.linaro.org/show_bug.cgi?id=4053 (PATCH 2/5)
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
(cherry picked from commit 2d4fa7b4c6f8080ced2e8237c9f46fb1fc110d64)
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index aecbfe9fc8f2..0c2966c285b1 100644
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
2.20.0.rc1
