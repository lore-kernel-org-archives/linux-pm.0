From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/3] ARM64: dts: mt8173: Add thermal/auxadc device nodes
Date: Mon, 13 Jul 2015 12:34:54 +0200
Message-ID: <1436783694-30717-4-git-send-email-s.hauer@pengutronix.de>
References: <1436783694-30717-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436783694-30717-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 27237a1..8cd114a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -151,6 +151,11 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		auxadc: auxadc@11001000 {
+			compatible = "mediatek,mt8173-auxadc";
+			reg = <0 0x11001000 0 0x1000>;
+		};
+
 		uart0: serial@11002000 {
 			compatible = "mediatek,mt8173-uart",
 				     "mediatek,mt6577-uart";
@@ -186,6 +191,19 @@
 			clocks = <&uart_clk>;
 			status = "disabled";
 		};
+
+		thermal: thermal@1100b000 {
+			#thermal-sensor-cells = <1>;
+			compatible = "mediatek,mt8173-thermal";
+			reg = <0 0x1100b000 0 0x1000>;
+			interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
+			clock-names = "therm", "auxadc";
+			resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
+			reset-names = "therm";
+			auxadc = <&auxadc>;
+			apmixedsys = <&apmixedsys>;
+		};
 	};
 };
 
-- 
2.1.4
