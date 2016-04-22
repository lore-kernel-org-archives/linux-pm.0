From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 11/12] ARM: dts: r8a7793: Use SYSC "always-on" PM Domain
Date: Fri, 22 Apr 2016 11:07:33 +0200
Message-ID: <1461316054-27999-12-git-send-email-geert+renesas@glider.be>
References: <1461316054-27999-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:50876 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbcDVJHk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 05:07:40 -0400
In-Reply-To: <1461316054-27999-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Hook up all devices that are part of the CPG/MSTP Clock Domain to the
SYSC "always-on" PM Domain, for a more consistent device-power-area
description in DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v6:
  - Rebased,
  - Use "<&sysc R8A7793_PD_ALWAYS_ON>" for recently added sdhi[0-2]
    device nodes,

v5:
  - Add Acked-by,

v4:
  - New.
---
 arch/arm/boot/dts/r8a7793.dtsi | 102 ++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 53e235e3279d08c1..2abf2e4896991bad 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -105,7 +105,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio1: gpio@e6051000 {
@@ -118,7 +118,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio2: gpio@e6052000 {
@@ -131,7 +131,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio3: gpio@e6053000 {
@@ -144,7 +144,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio4: gpio@e6054000 {
@@ -157,7 +157,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO4>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio5: gpio@e6055000 {
@@ -170,7 +170,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO5>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio6: gpio@e6055400 {
@@ -183,7 +183,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO6>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio7: gpio@e6055800 {
@@ -196,7 +196,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO7>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	thermal: thermal@e61f0000 {
@@ -206,7 +206,7 @@
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A7793_CLK_THERMAL>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#thermal-sensor-cells = <0>;
 	};
 
@@ -225,7 +225,7 @@
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7793_CLK_CMT0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 
 		renesas,channels-mask = <0x60>;
 
@@ -245,7 +245,7 @@
 			     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7793_CLK_CMT1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -268,7 +268,7 @@
 			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A7793_CLK_IRQC>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	dmac0: dma-controller@e6700000 {
@@ -297,7 +297,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7793_CLK_SYS_DMAC0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -328,7 +328,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7793_CLK_SYS_DMAC1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -357,7 +357,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7793_CLK_AUDIO_DMAC0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -386,7 +386,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7793_CLK_AUDIO_DMAC1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -399,7 +399,7 @@
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -411,7 +411,7 @@
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -423,7 +423,7 @@
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -435,7 +435,7 @@
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -447,7 +447,7 @@
 		reg = <0 0xe6520000 0 0x40>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C4>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -460,7 +460,7 @@
 		reg = <0 0xe6528000 0 0x40>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C5>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <110>;
 		status = "disabled";
 	};
@@ -475,7 +475,7 @@
 		clocks = <&mstp9_clks R8A7793_CLK_IICDVFS>;
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -488,7 +488,7 @@
 		clocks = <&mstp3_clks R8A7793_CLK_IIC0>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -501,7 +501,7 @@
 		clocks = <&mstp3_clks R8A7793_CLK_IIC1>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -517,7 +517,7 @@
 		clocks = <&mstp3_clks R8A7793_CLK_SDHI0>;
 		dmas = <&dmac0 0xcd>, <&dmac0 0xce>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -528,7 +528,7 @@
 		clocks = <&mstp3_clks R8A7793_CLK_SDHI1>;
 		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -539,7 +539,7 @@
 		clocks = <&mstp3_clks R8A7793_CLK_SDHI2>;
 		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -552,7 +552,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -565,7 +565,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -578,7 +578,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -591,7 +591,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -604,7 +604,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -617,7 +617,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -630,7 +630,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -643,7 +643,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -656,7 +656,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -670,7 +670,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -684,7 +684,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -698,7 +698,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -712,7 +712,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -726,7 +726,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -740,7 +740,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -754,7 +754,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -768,7 +768,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -782,7 +782,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -791,7 +791,7 @@
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7793_CLK_ETHER>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -805,7 +805,7 @@
 		clocks = <&mstp9_clks R8A7793_CLK_QSPI_MOD>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -849,7 +849,7 @@
 		clocks = <&mstp9_clks R8A7793_CLK_RCAN0>,
 			 <&cpg_clocks R8A7793_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -860,7 +860,7 @@
 		clocks = <&mstp9_clks R8A7793_CLK_RCAN1>,
 			 <&cpg_clocks R8A7793_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -1327,7 +1327,7 @@
 				"src.4", "src.3", "src.2", "src.1", "src.0",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 
 		status = "disabled";
 
-- 
1.9.1

