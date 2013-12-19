From: Anson Huang <b20788@freescale.com>
Subject: [PATCH 1/3] ARM: dts: imx6qdl: add necessary thermal clk
Date: Thu, 19 Dec 2013 13:17:23 -0500
Message-ID: <1387477045-19037-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: shawn.guo@linaro.org, kernel@pengutronix.de, rui.zhang@intel.com, eduardo.valentin@ti.com
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Thermal sensor needs pll3_usb_otg when measuring temperature,
so we need to pass clk info to thermal driver.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fb28b2e..72c7e2b 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -550,6 +550,7 @@
 				interrupts = <0 49 0x04>;
 				fsl,tempmon = <&anatop>;
 				fsl,tempmon-data = <&ocotp>;
+				clocks = <&clks 172>;
 			};
 
 			usbphy1: usbphy@020c9000 {
-- 
1.7.9.5


