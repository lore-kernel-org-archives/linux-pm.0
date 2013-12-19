From: Anson Huang <b20788@freescale.com>
Subject: [PATCH V2 2/2] thermal: imx: add necessary clk operation
Date: Thu, 19 Dec 2013 15:53:22 -0500
Message-ID: <1387486402-30777-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: shawn.guo@linaro.org, kernel@pengutronix.de, rui.zhang@intel.com, eduardo.valentin@ti.com
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Thermal sensor needs pll3_usb_otg when measuring temperature,
otherwise the temperature read will be incorrect, so need to
enable this clk before sensor working, for alarm function,
as hardware will take measurement periodically, so we should
keep this clk always on once alarm function is enabled.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 .../devicetree/bindings/thermal/imx-thermal.txt    |    2 ++
 drivers/thermal/imx_thermal.c                      |   18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
index 541c25e..e518c6e 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
@@ -7,6 +7,7 @@ Required properties:
 - fsl,tempmon-data : phandle pointer to fuse controller that contains TEMPMON
   calibration data, e.g. OCOTP on imx6q.  The details about calibration data
   can be found in SoC Reference Manual.
+- clocks : thermal sensor's clock source.
 
 Example:
 
@@ -14,4 +15,5 @@ tempmon {
 	compatible = "fsl,imx6q-tempmon";
 	fsl,tempmon = <&anatop>;
 	fsl,tempmon-data = <&ocotp>;
+	clocks = <&clks 172>;
 };
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 1d6c801..c2b8173 100644
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
@@ -457,6 +459,22 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(data->thermal_clk)) {
+		dev_warn(&pdev->dev, "failed to get thermal clk!\n");
+	} else {
+		/*
+		 * Thermal sensor needs clk on to get correct value, normally
+		 * we should enable its clk before taking measurement and disable
+		 * clk after measurement is done, but if alarm function is enabled,
+		 * hardware will auto measure the temperature periodically, so we
+		 * need to keep the clk always on for alarm function.
+		 */
+		ret = clk_prepare_enable(data->thermal_clk);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
+	}
+
 	/* Enable measurements at ~ 10 Hz */
 	regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
 	measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
-- 
1.7.9.5
