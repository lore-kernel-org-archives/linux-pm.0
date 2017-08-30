From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 03/13] thermal/drivers/hisi: Fix kernel panic on alarm interrupt
Date: Wed, 30 Aug 2017 10:47:27 +0200
Message-ID: <1504082857-21702-3-git-send-email-daniel.lezcano@linaro.org>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, leo.yan@linaro.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The threaded interrupt for the alarm interrupt is requested before the
temperature controller is setup. This one can fire an interrupt immediately
leading to a kernel panic as the sensor data is not initialized.

In order to prevent that, move the threaded irq after the Tsensor is setup.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 92b6889..67db523 100644
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
