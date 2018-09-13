From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 2/2] thermal: imx: handle error path in one place to save duplicated code
Date: Thu, 13 Sep 2018 17:13:06 +0800
Message-ID: <1536829986-23702-2-git-send-email-Anson.Huang@nxp.com>
References: <1536829986-23702-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536829986-23702-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

During probe phase, the error path can be handled in one place and
use goto method to save many duplicated code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 6cfa2a8..1566154 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -762,9 +762,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		if (ret != -EPROBE_DEFER)
 			dev_err(&pdev->dev,
 				"failed to get thermal clk: %d\n", ret);
-		cpufreq_cooling_unregister(data->cdev);
-		cpufreq_cpu_put(data->policy);
-		return ret;
+		goto cpufreq_put;
 	}
 
 	/*
@@ -777,9 +775,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(data->thermal_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
-		cpufreq_cooling_unregister(data->cdev);
-		cpufreq_cpu_put(data->policy);
-		return ret;
+		goto cpufreq_put;
 	}
 
 	data->tz = thermal_zone_device_register("imx_thermal_zone",
@@ -792,10 +788,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		ret = PTR_ERR(data->tz);
 		dev_err(&pdev->dev,
 			"failed to register thermal zone device %d\n", ret);
-		clk_disable_unprepare(data->thermal_clk);
-		cpufreq_cooling_unregister(data->cdev);
-		cpufreq_cpu_put(data->policy);
-		return ret;
+		goto clk_disable;
 	}
 
 	dev_info(&pdev->dev, "%s CPU temperature grade - max:%dC"
@@ -827,14 +820,20 @@ static int imx_thermal_probe(struct platform_device *pdev)
 			0, "imx_thermal", data);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
-		clk_disable_unprepare(data->thermal_clk);
-		thermal_zone_device_unregister(data->tz);
-		cpufreq_cooling_unregister(data->cdev);
-		cpufreq_cpu_put(data->policy);
-		return ret;
+		goto thermal_zone_unregister;
 	}
 
 	return 0;
+
+thermal_zone_unregister:
+	thermal_zone_device_unregister(data->tz);
+clk_disable:
+	clk_disable_unprepare(data->thermal_clk);
+cpufreq_put:
+	cpufreq_cooling_unregister(data->cdev);
+	cpufreq_cpu_put(data->policy);
+
+	return ret;
 }
 
 static int imx_thermal_remove(struct platform_device *pdev)
-- 
2.7.4
