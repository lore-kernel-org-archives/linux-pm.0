From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [PATCH 1/9] thermal/drivers/hisi: move clk operation to related function
Date: Fri, 22 Sep 2017 17:42:04 +0800
Message-ID: <1506073332-92438-2-git-send-email-kevin.wangtao@hisilicon.com>
References: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: leo.yan@linaro.org, lonela.Voinescu@arm.com, Valentin.Schneider@arm.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Wangtao <kevin.wangtao@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Kevin Wangtao <kevin.wangtao@linaro.org>

The sensor's clock is enabled and disabled outside of the probe and
disable function. Moving the corresponding action in the
hisi_thermal_setup() and hisi_thermal_disable_sensor(), factors out
some lines of code and makes the code more symmetric.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 39f4627..c43e3df 100644
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
2.8.1
