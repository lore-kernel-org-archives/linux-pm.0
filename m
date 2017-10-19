From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 14/18] thermal/drivers/hisi: Move the clk setup in the corresponding functions
Date: Thu, 19 Oct 2017 19:05:56 +0200
Message-ID: <1508432760-17847-14-git-send-email-daniel.lezcano@linaro.org>
References: <6ac48f08-7fe6-92e9-0801-6ed3bcd05ff1@linaro.org>
 <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org, Kevin Wangtao <kevin.wangtao@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Kevin Wangtao <kevin.wangtao@linaro.org>

The sensor's clock is enabled and disabled outside of the probe and
disable function. Moving the corresponding action in the
hisi_thermal_setup() and hisi_thermal_disable_sensor(), factors out
some lines of code and makes the code more symmetric.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
Tested-by: Daniel Lezcano <daniel.lezcano@linaro.org> # hikey6220
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 8d1a8be..b9e4a9a 100644
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
