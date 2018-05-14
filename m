From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
Date: Mon, 14 May 2018 16:09:17 +0800
Message-ID: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch removes cpufreq cooling registration in
thermal .probe function, cpufreq cooling should be
done in cpufreq driver when it is ready.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index c30dc21..8eedb97 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -9,7 +9,6 @@
 
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
-#include <linux/cpu_cooling.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -207,7 +206,6 @@ static struct thermal_soc_data thermal_imx7d_data = {
 struct imx_thermal_data {
 	struct cpufreq_policy *policy;
 	struct thermal_zone_device *tz;
-	struct thermal_cooling_device *cdev;
 	enum thermal_device_mode mode;
 	struct regmap *tempmon;
 	u32 c1, c2; /* See formula in imx_init_calib() */
@@ -729,22 +727,12 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		return -EPROBE_DEFER;
 	}
 
-	data->cdev = cpufreq_cooling_register(data->policy);
-	if (IS_ERR(data->cdev)) {
-		ret = PTR_ERR(data->cdev);
-		dev_err(&pdev->dev,
-			"failed to register cpufreq cooling device: %d\n", ret);
-		cpufreq_cpu_put(data->policy);
-		return ret;
-	}
-
 	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(data->thermal_clk)) {
 		ret = PTR_ERR(data->thermal_clk);
 		if (ret != -EPROBE_DEFER)
 			dev_err(&pdev->dev,
 				"failed to get thermal clk: %d\n", ret);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -759,7 +747,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(data->thermal_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -775,7 +762,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"failed to register thermal zone device %d\n", ret);
 		clk_disable_unprepare(data->thermal_clk);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -811,7 +797,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
 		clk_disable_unprepare(data->thermal_clk);
 		thermal_zone_device_unregister(data->tz);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -831,7 +816,6 @@ static int imx_thermal_remove(struct platform_device *pdev)
 		clk_disable_unprepare(data->thermal_clk);
 
 	thermal_zone_device_unregister(data->tz);
-	cpufreq_cooling_unregister(data->cdev);
 	cpufreq_cpu_put(data->policy);
 
 	return 0;
-- 
2.7.4
