From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 17/25] thermal/drivers/hisi: Move the clk setup in the corresponding functions
Date: Tue, 10 Oct 2017 20:02:42 +0200
Message-ID: <1507658570-32675-17-git-send-email-daniel.lezcano@linaro.org>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:49023 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932630AbdJJSFP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 14:05:15 -0400
Received: by mail-wm0-f50.google.com with SMTP id i124so7424156wmf.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2017 11:05:14 -0700 (PDT)
In-Reply-To: <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org

From: Kevin Wangtao <kevin.wangtao@linaro.org>

The sensor's clock is enabled and disabled outside of the probe and
disable function. Moving the corresponding action in the
hisi_thermal_setup() and hisi_thermal_disable_sensor(), factors out
some lines of code and makes the code more symmetric.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 241d42c..02d0ad8 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -203,6 +203,8 @@ static void hisi_thermal_disable_sensor(struct hisi_thermal_data *data)
 	hisi_thermal_enable(data->regs, 0);
 	hisi_thermal_alarm_enable(data->regs, 0);
 	hisi_thermal_reset_enable(data->regs, 0);
+
+	clk_disable_unprepare(data->clk);
 }
 
 static int hisi_thermal_get_temp(void *__data, int *temp)
@@ -297,9 +299,13 @@ static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
 
 static int hisi_thermal_setup(struct hisi_thermal_data *data)
 {
-	struct hisi_thermal_sensor *sensor;
+	struct hisi_thermal_sensor *sensor = &data->sensor;
+	int ret;
 
-	sensor = &data->sensor;
+	/* enable clock for tsensor */
+	ret = clk_prepare_enable(data->clk);
+	if (ret)
+		return ret;
 
 	/* disable module firstly */
 	hisi_thermal_reset_enable(data->regs, 0);
@@ -363,13 +369,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* enable clock for thermal */
-	ret = clk_prepare_enable(data->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
-		return ret;
-	}
-
 	ret = hisi_thermal_register_sensor(pdev, data,
 					   &data->sensor,
 					   HISI_DEFAULT_SENSOR);
@@ -405,7 +404,6 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 
 	hisi_thermal_toggle_sensor(sensor, false);
 	hisi_thermal_disable_sensor(data);
-	clk_disable_unprepare(data->clk);
 
 	return 0;
 }
@@ -417,23 +415,14 @@ static int hisi_thermal_suspend(struct device *dev)
 
 	hisi_thermal_disable_sensor(data);
 
-	clk_disable_unprepare(data->clk);
-
 	return 0;
 }
 
 static int hisi_thermal_resume(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
-	int ret;
 
-	ret = clk_prepare_enable(data->clk);
-	if (ret)
-		return ret;
-
-	hisi_thermal_setup(data);
-
-	return 0;
+	return hisi_thermal_setup(data);
 }
 #endif
 
-- 
2.7.4
