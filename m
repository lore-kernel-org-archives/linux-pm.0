From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 03/18] thermal/drivers/hisi: Fix kernel panic on alarm interrupt
Date: Thu, 19 Oct 2017 19:05:45 +0200
Message-ID: <1508432760-17847-3-git-send-email-daniel.lezcano@linaro.org>
References: <6ac48f08-7fe6-92e9-0801-6ed3bcd05ff1@linaro.org>
 <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The threaded interrupt for the alarm interrupt is requested before the
temperature controller is setup. This one can fire an interrupt immediately
leading to a kernel panic as the sensor data is not initialized.

In order to prevent that, move the threaded irq after the Tsensor is setup.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 687efd4..feae552 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -287,15 +287,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	if (data->irq < 0)
 		return data->irq;
 
-	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
-					hisi_thermal_alarm_irq,
-					hisi_thermal_alarm_irq_thread,
-					0, "hisi_thermal", data);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, data);
 
 	data->clk = devm_clk_get(&pdev->dev, "thermal_clk");
@@ -328,6 +319,15 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 
 	hisi_thermal_toggle_sensor(&data->sensors, true);
 
+	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
+					hisi_thermal_alarm_irq,
+					hisi_thermal_alarm_irq_thread,
+					0, "hisi_thermal", data);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
+		return ret;
+	}
+
 	enable_irq(data->irq);
 
 	return 0;
-- 
2.7.4
