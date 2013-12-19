From: Anson Huang <b20788@freescale.com>
Subject: [PATCH 2/3] thermal: imx: add necessary clk operation
Date: Thu, 19 Dec 2013 13:17:24 -0500
Message-ID: <1387477045-19037-2-git-send-email-b20788@freescale.com>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:59369
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751948Ab3LSGTb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2013 01:19:31 -0500
In-Reply-To: <1387477045-19037-1-git-send-email-b20788@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: shawn.guo@linaro.org, kernel@pengutronix.de, rui.zhang@intel.com, eduardo.valentin@ti.com
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Thermal sensor needs pll3_usb_otg when measuring temperature,
otherwise the temperature read will be incorrect, so need to
enable this clk before sensor working, for alarm function,
as hardware will take measurement periodically, so we should
keep this clk always on once alarm function is enabled.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 drivers/thermal/imx_thermal.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 1d6c801..7abbc04 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/cpu_cooling.h>
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
@@ -73,6 +74,7 @@ struct imx_thermal_data {
 	unsigned long last_temp;
 	bool irq_enabled;
 	int irq;
+	struct clk *thermal_clk;
 };
 
 static void imx_set_alarm_temp(struct imx_thermal_data *data,
@@ -427,6 +429,13 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(data->thermal_clk)) {
+		ret = IS_ERR(data->thermal_clk);
+		dev_err(&pdev->dev, "failed to get thermal clk!\n");
+		return ret;
+	}
+
 	/* Make sure sensor is in known good state for measurements */
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
 	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
@@ -457,6 +466,19 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * Thermal sensor needs clk on to get correct value, normally
+	 * we should enable its clk before taking measurement and disable
+	 * clk after measurement is done, but if alarm function is enabled,
+	 * hardware will auto measure the temperature periodically, so we
+	 * need to keep the clk always on for alarm function.
+	 */
+	ret = clk_prepare_enable(data->thermal_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
+		return ret;
+	}
+
 	/* Enable measurements at ~ 10 Hz */
 	regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
 	measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
-- 
1.7.9.5


