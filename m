From: Bai Ping <b51503@freescale.com>
Subject: [PATCH] thermal: imx: register irq handler later in probe
Date: Mon, 14 Sep 2015 19:09:51 +0800
Message-ID: <1442228991-10235-1-git-send-email-b51503@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The irq handler should be registered after the tempmon
module has been initialized in a known state and the
thermal_zone and cpu_cooling device have been registered
successfully. Otherwise, if the irq is triggled earlier
before thermal probe has been finished, it may lead to
'NULL' pointer kernel panic.

Signed-off-by: Bai Ping <b51503@freescale.com>
---
 drivers/thermal/imx_thermal.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 4bec1d3..acd1c78 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -487,14 +487,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	if (data->irq < 0)
 		return data->irq;
 
-	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
-			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
-			0, "imx_thermal", data);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, data);
 
 	ret = imx_get_sensor_data(pdev);
@@ -571,6 +563,17 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
 
+	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
+			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
+			0, "imx_thermal", data);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
+		clk_disable_unprepare(data->thermal_clk);
+		thermal_zone_device_unregister(data->tz);
+		cpufreq_cooling_unregister(data->cdev);
+		return ret;
+	}
+
 	data->irq_enabled = true;
 	data->mode = THERMAL_DEVICE_ENABLED;
 
-- 
1.9.1
