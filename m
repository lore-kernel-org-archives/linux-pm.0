From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 03/25] thermal/drivers/hisi: Fix kernel panic on alarm interrupt
Date: Tue, 10 Oct 2017 20:02:28 +0200
Message-ID: <1507658570-32675-3-git-send-email-daniel.lezcano@linaro.org>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org, Leo Yan <leo.yan@linaro.org>
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
