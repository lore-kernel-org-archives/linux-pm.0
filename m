From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] thermal: imx: Fix race condition in imx_thermal_probe()
Date: Fri,  2 Feb 2018 16:17:46 -0200
Message-ID: <1517595466-23465-1-git-send-email-festevam@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: rui.zhang@intel.com
Cc: edubezval@gmail.com, mikhail.lappo@esrlabs.com, linux-pm@vger.kernel.org, linux-imx@nxp.com, p.zabel@pengutronix.de, shawnguo@kernel.org, stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-pm@vger.kernel.org

From: Mikhail Lappo <mikhail.lappo@esrlabs.com>

When device boots with T > T_trip_1 and requests interrupt,
the race condition takes place. The interrupt comes before
THERMAL_DEVICE_ENABLED is set. This leads to an attempt to
reading sensor value from irq and disabling the sensor, based on
the data->mode field, which expected to be THERMAL_DEVICE_ENABLED,
but still stays as THERMAL_DEVICE_DISABLED. Afher this issue
sensor is never re-enabled, as the driver state is wrong.

Fix this problem by setting the 'data' members prior to
requesting the interrupts.

Fixes: 37713a1e8e4c ("thermal: imx: implement thermal alarm interrupt handling")
Cc: <stable@vger.kernel.org>
Signed-off-by: Mikhail Lappo <mikhail.lappo@esrlabs.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/thermal/imx_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index a67781b..ee3a215 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -637,6 +637,9 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
 
+	data->irq_enabled = true;
+	data->mode = THERMAL_DEVICE_ENABLED;
+
 	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
 			0, "imx_thermal", data);
@@ -649,9 +652,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	data->irq_enabled = true;
-	data->mode = THERMAL_DEVICE_ENABLED;
-
 	return 0;
 }
 
-- 
2.7.4
