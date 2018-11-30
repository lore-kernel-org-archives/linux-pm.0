From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/2] thermal/drivers/hisi: Fix number of sensors on hi3660
Date: Fri, 30 Nov 2018 09:00:32 +0100
Message-ID: <1543564833-643-2-git-send-email-daniel.lezcano@linaro.org>
References: <1543564833-643-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543564833-643-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: vincent.guittot@linaro.org, john.stultz@linaro.org, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Without this patch the thermal driver is broken on hi3660.

The dual sensors support patchset was partially merged, unfortunately
the dual thermal zones definition is not available in the DT yet, so
when the driver tries to register all the sensors that fails.

By reducing to 1 the number of sensors on the hi3660, we switch back
to the previous functionnality.

Fixes: 8c6c36846f11 (thermal/drivers/hisi: Add the dual clusters sensors for hi3660)
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 50f4d00..2d26ae8 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -424,7 +424,7 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 	struct platform_device *pdev = data->pdev;
 	struct device *dev = &pdev->dev;
 
-	data->nr_sensors = 2;
+	data->nr_sensors = 1;
 
 	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor) *
 				    data->nr_sensors, GFP_KERNEL);
-- 
2.7.4
