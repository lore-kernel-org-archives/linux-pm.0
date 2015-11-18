From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/3] ARM64: dts: mt8173: Add thermal/auxadc device nodes
Date: Wed, 18 Nov 2015 09:24:26 +0100
Message-ID: <1447835066-10482-4-git-send-email-s.hauer@pengutronix.de>
References: <1447835066-10482-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53841 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232AbbKRIYb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 03:24:31 -0500
In-Reply-To: <1447835066-10482-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

This adds the thermal controller and auxadc nodes to the Mediatek MT8173
dtsi file.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 06a1564..e2ddd03 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -277,6 +277,11 @@
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
@@ -487,6 +492,18 @@
 			clock-names = "source", "hclk";
 			status = "disabled";
 		};
+
+		thermal: thermal@1100b000 {
+			#thermal-sensor-cells = <0>;
+			compatible = "mediatek,mt8173-thermal";
+			reg = <0 0x1100b000 0 0x1000>;
+			interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
+			clock-names = "therm", "auxadc";
+			resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
+			mediatek,auxadc = <&auxadc>;
+			mediatek,apmixedsys = <&apmixedsys>;
+		};
 	};
 };
 
-- 
2.6.2

