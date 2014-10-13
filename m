From: Heiner Kallweit <heiner.kallweit@web.de>
Subject: [PATCH v3] imx: thermal: imx_get_temp might be called before sensor
 clock is prepared
Date: Mon, 13 Oct 2014 22:51:23 +0200
Message-ID: <543C3B4B.6080700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:56163 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429AbaJMUv3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Oct 2014 16:51:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Zhang Rui <rui.zhang@intel.com>; Eduardo Valentin" <edubezval@gmail.com>

imx_get_temp might be called before the sensor clock is prepared
thus resulting in a timeout of the first attempt to read temp:
thermal thermal_zone0: failed to read out thermal zone 0
Happened to me on a Utilite Standard with IMX6 Dual SoC.

Reason is that in imx_thermal_probe thermal_zone_device_register
is called before the sensor clock is prepared.
thermal_zone_device_register however calls
thermal_zone_device_update which eventually calls imx_get_temp.

Fix this by preparing the clock before calling
thermal_zone_device_register.

Signed-off-by: Heiner Kallweit <heiner.kallweit@web.de>
---
v2: revised error path. Bail out and tidy up properly if we can't
    get the clock or fail to enable it
v3: don't print error message if getting clock returns EPROBE_DEFER
---
 drivers/thermal/imx_thermal.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 461bf3d..0e8ef55 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -521,6 +521,30 @@ static int imx_thermal_probe(struct platform_device *pdev)
                return ret;
        }

+       data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
+       if (IS_ERR(data->thermal_clk)) {
+               ret = PTR_ERR(data->thermal_clk);
+               if (ret != -EPROBE_DEFER)
+                       dev_err(&pdev->dev,
+                               "failed to get thermal clk: %d\n", ret);
+               cpufreq_cooling_unregister(data->cdev);
+               return ret;
+       }
+
+       /*
+        * Thermal sensor needs clk on to get correct value, normally
+        * we should enable its clk before taking measurement and disable
+        * clk after measurement is done, but if alarm function is enabled,
+        * hardware will auto measure the temperature periodically, so we
+        * need to keep the clk always on for alarm function.
+        */
+       ret = clk_prepare_enable(data->thermal_clk);
+       if (ret) {
+               dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
+               cpufreq_cooling_unregister(data->cdev);
+               return ret;
+       }
+
        data->tz = thermal_zone_device_register("imx_thermal_zone",
                                                IMX_TRIP_NUM,
                                                BIT(IMX_TRIP_PASSIVE), data,
@@ -531,26 +555,11 @@ static int imx_thermal_probe(struct platform_device *pdev)
                ret = PTR_ERR(data->tz);
                dev_err(&pdev->dev,
                        "failed to register thermal zone device %d\n", ret);
+               clk_disable_unprepare(data->thermal_clk);
                cpufreq_cooling_unregister(data->cdev);
                return ret;
        }

-       data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
-       if (IS_ERR(data->thermal_clk)) {
-               dev_warn(&pdev->dev, "failed to get thermal clk!\n");
-       } else {
-               /*
-                * Thermal sensor needs clk on to get correct value, normally
-                * we should enable its clk before taking measurement and disable
-                * clk after measurement is done, but if alarm function is enabled,
-                * hardware will auto measure the temperature periodically, so we
-                * need to keep the clk always on for alarm function.
-                */
-               ret = clk_prepare_enable(data->thermal_clk);
-               if (ret)
-                       dev_warn(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
-       }
-
        /* Enable measurements at ~ 10 Hz */
        regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
        measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
--
2.1.2
