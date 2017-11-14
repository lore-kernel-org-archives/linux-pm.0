From: Bastian Stender <bst@pengutronix.de>
Subject: [PATCH] thermal: imx: remove cooling device
Date: Tue, 14 Nov 2017 14:48:29 +0100
Message-ID: <20171114134829.1354-1-bst@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45901 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754333AbdKNNsf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2017 08:48:35 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, kernel@pengutronix.de, Bastian Stender <bst@pengutronix.de>

The cooling device should not be part of the i.MX thermal code but
rather in the i.MX cpufreq driver. So remove it here.

Signed-off-by: Bastian Stender <bst@pengutronix.de>
---
This is part of a rework of "thermal: imx: use cpufreq cooling of
registration method" (id:20171103164203.5805-1-bst@pengutronix.de).

"cpufreq: imx6q: add CPU as cooling device" will reintroduce the
cooling device.
---
 drivers/thermal/imx_thermal.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 4798b4b1fd77..3bdbde675698 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -91,7 +91,6 @@ static struct thermal_soc_data thermal_imx6sx_data = {
 struct imx_thermal_data {
 	struct cpufreq_policy *policy;
 	struct thermal_zone_device *tz;
-	struct thermal_cooling_device *cdev;
 	enum thermal_device_mode mode;
 	struct regmap *tempmon;
 	u32 c1, c2; /* See formula in imx_get_sensor_data() */
@@ -533,22 +532,12 @@ static int imx_thermal_probe(struct platform_device *pdev)
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
@@ -563,7 +552,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(data->thermal_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -579,7 +567,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"failed to register thermal zone device %d\n", ret);
 		clk_disable_unprepare(data->thermal_clk);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -608,7 +595,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
 		clk_disable_unprepare(data->thermal_clk);
 		thermal_zone_device_unregister(data->tz);
-		cpufreq_cooling_unregister(data->cdev);
 		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
@@ -630,7 +616,6 @@ static int imx_thermal_remove(struct platform_device *pdev)
 		clk_disable_unprepare(data->thermal_clk);
 
 	thermal_zone_device_unregister(data->tz);
-	cpufreq_cooling_unregister(data->cdev);
 	cpufreq_cpu_put(data->policy);
 
 	return 0;
-- 
2.11.0
