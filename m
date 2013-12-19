From: Anson Huang <b20788@freescale.com>
Subject: [PATCH 3/3] thermal: imx: add clk info for thermal sensor
Date: Thu, 19 Dec 2013 13:17:25 -0500
Message-ID: <1387477045-19037-3-git-send-email-b20788@freescale.com>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1387477045-19037-1-git-send-email-b20788@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: shawn.guo@linaro.org, kernel@pengutronix.de, rui.zhang@intel.com, eduardo.valentin@ti.com
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

thermal sensor needs dedicated clock to work in correct way,
so we need to add necessary clock info in dts.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 .../devicetree/bindings/thermal/imx-thermal.txt    |    2 ++
 1 file changed, 2 insertions(+)

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
-- 
1.7.9.5


