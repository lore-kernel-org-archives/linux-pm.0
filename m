From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 12/12] arm64: dts: r8a7795: Use SYSC "always-on" PM Domain
Date: Thu,  7 Apr 2016 14:20:35 +0200
Message-ID: <1460031635-13452-13-git-send-email-geert+renesas@glider.be>
References: <1460031635-13452-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:39338 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218AbcDGMUb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 08:20:31 -0400
In-Reply-To: <1460031635-13452-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Hook up all devices that are part of the CPG/MSSR Clock Domain to the
SYSC "always-on" PM Domain, for a more consistent device-power-area
description in DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New, extracted from "[PATCH v3] arm64: dts: r8a7795: Add SYSC PM
    Domains",
  - Use "<&sysc R8A7795_PD_ALWAYS_ON>" for recently added can0, can1,
    pciec0, and pciec1 device nodes,
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 110 +++++++++++++++----------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 89c72280f9a77403..05e7d6ab06362acd 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -178,7 +178,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 912>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		gpio1: gpio@e6051000 {
@@ -192,7 +192,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 911>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		gpio2: gpio@e6052000 {
@@ -206,7 +206,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 910>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		gpio3: gpio@e6053000 {
@@ -220,7 +220,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 909>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		gpio4: gpio@e6054000 {
@@ -234,7 +234,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 908>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		gpio5: gpio@e6055000 {
@@ -248,7 +248,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 907>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		gpio6: gpio@e6055400 {
@@ -262,7 +262,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 906>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		gpio7: gpio@e6055800 {
@@ -276,7 +276,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 905>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		pmu_a57 {
@@ -346,7 +346,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 502>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -378,7 +378,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 501>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -400,7 +400,7 @@
 				      GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH
 				      GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 407>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		dmac0: dma-controller@e6700000 {
@@ -431,7 +431,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 219>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -464,7 +464,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 218>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -497,7 +497,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 217>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -539,7 +539,7 @@
 					  "ch20", "ch21", "ch22", "ch23",
 					  "ch24";
 			clocks = <&cpg CPG_MOD 812>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			phy-mode = "rgmii-id";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -556,7 +556,7 @@
 			clock-names = "clkp1", "clkp2", "can_clk";
 			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -571,7 +571,7 @@
 			clock-names = "clkp1", "clkp2", "can_clk";
 			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -587,7 +587,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -603,7 +603,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -619,7 +619,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -635,7 +635,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -651,7 +651,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -666,7 +666,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x51>, <&dmac1 0x50>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -681,7 +681,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x53>, <&dmac1 0x52>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -696,7 +696,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x13>, <&dmac1 0x12>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -711,7 +711,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -726,7 +726,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -741,7 +741,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -752,7 +752,7 @@
 			reg = <0 0xe6500000 0 0x40>;
 			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 931>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
@@ -764,7 +764,7 @@
 			reg = <0 0xe6508000 0 0x40>;
 			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 930>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
@@ -776,7 +776,7 @@
 			reg = <0 0xe6510000 0 0x40>;
 			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 929>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
@@ -788,7 +788,7 @@
 			reg = <0 0xe66d0000 0 0x40>;
 			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 928>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
@@ -800,7 +800,7 @@
 			reg = <0 0xe66d8000 0 0x40>;
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 927>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
@@ -812,7 +812,7 @@
 			reg = <0 0xe66e0000 0 0x40>;
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 919>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
@@ -824,7 +824,7 @@
 			reg = <0 0xe66e8000 0 0x40>;
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 918>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
@@ -874,7 +874,7 @@
 				      "src.1", "src.0",
 				      "dvc.0", "dvc.1",
 				      "clk_a", "clk_b", "clk_c", "clk_i";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 
 			rcar_sound,dvc {
@@ -1008,7 +1008,7 @@
 			reg = <0 0xee000000 0 0xc00>;
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 328>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1017,7 +1017,7 @@
 			reg = <0 0xee040000 0 0xc00>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 327>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1029,7 +1029,7 @@
 				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "ch0", "ch1";
 			clocks = <&cpg CPG_MOD 330>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
 			dma-channels = <2>;
 		};
@@ -1042,7 +1042,7 @@
 				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "ch0", "ch1";
 			clocks = <&cpg CPG_MOD 331>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
 			dma-channels = <2>;
 		};
@@ -1052,7 +1052,7 @@
 			reg = <0 0xee100000 0 0x2000>;
 			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 314>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1061,7 +1061,7 @@
 			reg = <0 0xee120000 0 0x2000>;
 			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 313>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1070,7 +1070,7 @@
 			reg = <0 0xee140000 0 0x2000>;
 			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 312>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			cap-mmc-highspeed;
 			status = "disabled";
 		};
@@ -1080,7 +1080,7 @@
 			reg = <0 0xee160000 0 0x2000>;
 			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 311>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			cap-mmc-highspeed;
 			status = "disabled";
 		};
@@ -1090,7 +1090,7 @@
 			reg = <0 0xee080200 0 0x700>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 703>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
@@ -1099,7 +1099,7 @@
 			compatible = "renesas,usb2-phy-r8a7795";
 			reg = <0 0xee0a0200 0 0x700>;
 			clocks = <&cpg CPG_MOD 702>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
@@ -1108,7 +1108,7 @@
 			compatible = "renesas,usb2-phy-r8a7795";
 			reg = <0 0xee0c0200 0 0x700>;
 			clocks = <&cpg CPG_MOD 701>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
@@ -1120,7 +1120,7 @@
 			clocks = <&cpg CPG_MOD 703>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1131,7 +1131,7 @@
 			clocks = <&cpg CPG_MOD 702>;
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1142,7 +1142,7 @@
 			clocks = <&cpg CPG_MOD 701>;
 			phys = <&usb2_phy2>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1153,7 +1153,7 @@
 			clocks = <&cpg CPG_MOD 703>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1164,7 +1164,7 @@
 			clocks = <&cpg CPG_MOD 702>;
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1175,7 +1175,7 @@
 			clocks = <&cpg CPG_MOD 701>;
 			phys = <&usb2_phy2>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 		pciec0: pcie@fe000000 {
@@ -1199,7 +1199,7 @@
 			interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
 			clock-names = "pcie", "pcie_bus";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1224,7 +1224,7 @@
 			interrupt-map = <0 0 0 0 &gic GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 318>, <&pcie_bus_clk>;
 			clock-names = "pcie", "pcie_bus";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 	};
-- 
1.9.1

