From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 2/4] ARM: shmobile: r8a7791/koelsch dts(i): Switch from MSTP to MSSR
Date: Tue, 22 Sep 2015 17:44:04 +0200
Message-ID: <1442936646-30362-3-git-send-email-geert+renesas@glider.be>
References: <1442936646-30362-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:46863 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758480AbbIVPoS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 11:44:18 -0400
In-Reply-To: <1442936646-30362-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Switch from the old "renesas,cpg-mstp-clocks" bindings to the new
"renesas,r8a7791-cpg-mssr" bindings:
  - Replace the multiple "mstp*_clks" nodes by a single "mssr" node,
    covering the whole CPG/MSTP register block and all MSTP clocks,
    delegating register set handling (up to 10 now, while the old
    bindings supported only 2) to the driver,
  - Add "#reset-cells = <1>;", so we can easily add reset controller
    support later,
  - Change the R8A7791_CLK_* macro definitions to include the MSTP
    register number, so the user-visible numbers match the datasheet
    clock numbers, and pack them to avoid wasting space in sparse
    clk_onecell_data arrays.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts     |   6 +-
 arch/arm/boot/dts/r8a7791.dtsi            | 560 +++++++++++++++---------------
 include/dt-bindings/clock/r8a7791-clock.h | 232 +++++++------
 3 files changed, 403 insertions(+), 395 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index fc44ea361a4b72bc..712aecab8d85dd8b 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -295,9 +295,9 @@
 	pinctrl-names = "default";
 	status = "okay";
 
-	clocks = <&mstp7_clks R8A7791_CLK_DU0>,
-		 <&mstp7_clks R8A7791_CLK_DU1>,
-		 <&mstp7_clks R8A7791_CLK_LVDS0>,
+	clocks = <&mssr R8A7791_CLK_DU0>,
+		 <&mssr R8A7791_CLK_DU1>,
+		 <&mssr R8A7791_CLK_LVDS0>,
 		 <&x13_clk>, <&x2_clk>;
 	clock-names = "du.0", "du.1", "lvds.0",
 		      "dclkin.0", "dclkin.1";
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index e4cc66c0cf1fb4a5..67bb7a1536d796dc 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -90,7 +90,7 @@
 		gpio-ranges = <&pfc 0 0 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7791_CLK_GPIO0>;
+		clocks = <&mssr R8A7791_CLK_GPIO0>;
 		power-domains = <&cpg_clocks>;
 	};
 
@@ -103,7 +103,7 @@
 		gpio-ranges = <&pfc 0 32 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7791_CLK_GPIO1>;
+		clocks = <&mssr R8A7791_CLK_GPIO1>;
 		power-domains = <&cpg_clocks>;
 	};
 
@@ -116,7 +116,7 @@
 		gpio-ranges = <&pfc 0 64 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7791_CLK_GPIO2>;
+		clocks = <&mssr R8A7791_CLK_GPIO2>;
 		power-domains = <&cpg_clocks>;
 	};
 
@@ -129,7 +129,7 @@
 		gpio-ranges = <&pfc 0 96 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7791_CLK_GPIO3>;
+		clocks = <&mssr R8A7791_CLK_GPIO3>;
 		power-domains = <&cpg_clocks>;
 	};
 
@@ -142,7 +142,7 @@
 		gpio-ranges = <&pfc 0 128 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7791_CLK_GPIO4>;
+		clocks = <&mssr R8A7791_CLK_GPIO4>;
 		power-domains = <&cpg_clocks>;
 	};
 
@@ -155,7 +155,7 @@
 		gpio-ranges = <&pfc 0 160 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7791_CLK_GPIO5>;
+		clocks = <&mssr R8A7791_CLK_GPIO5>;
 		power-domains = <&cpg_clocks>;
 	};
 
@@ -168,7 +168,7 @@
 		gpio-ranges = <&pfc 0 192 32>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7791_CLK_GPIO6>;
+		clocks = <&mssr R8A7791_CLK_GPIO6>;
 		power-domains = <&cpg_clocks>;
 	};
 
@@ -181,7 +181,7 @@
 		gpio-ranges = <&pfc 0 224 26>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
-		clocks = <&mstp9_clks R8A7791_CLK_GPIO7>;
+		clocks = <&mssr R8A7791_CLK_GPIO7>;
 		power-domains = <&cpg_clocks>;
 	};
 
@@ -189,7 +189,7 @@
 		compatible = "renesas,thermal-r8a7791", "renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp5_clks R8A7791_CLK_THERMAL>;
+		clocks = <&mssr R8A7791_CLK_THERMAL>;
 		power-domains = <&cpg_clocks>;
 	};
 
@@ -206,7 +206,7 @@
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7791_CLK_CMT0>;
+		clocks = <&mssr R8A7791_CLK_CMT0>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 
@@ -226,7 +226,7 @@
 			     <0 125 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 126 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7791_CLK_CMT1>;
+		clocks = <&mssr R8A7791_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 
@@ -250,7 +250,7 @@
 			     <0 15 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 16 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 17 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp4_clks R8A7791_CLK_IRQC>;
+		clocks = <&mssr R8A7791_CLK_IRQC>;
 		power-domains = <&cpg_clocks>;
 	};
 
@@ -278,7 +278,7 @@
 				"ch4", "ch5", "ch6", "ch7",
 				"ch8", "ch9", "ch10", "ch11",
 				"ch12", "ch13", "ch14";
-		clocks = <&mstp2_clks R8A7791_CLK_SYS_DMAC0>;
+		clocks = <&mssr R8A7791_CLK_SYS_DMAC0>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
@@ -309,7 +309,7 @@
 				"ch4", "ch5", "ch6", "ch7",
 				"ch8", "ch9", "ch10", "ch11",
 				"ch12", "ch13", "ch14";
-		clocks = <&mstp2_clks R8A7791_CLK_SYS_DMAC1>;
+		clocks = <&mssr R8A7791_CLK_SYS_DMAC1>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
@@ -338,7 +338,7 @@
 				"ch4", "ch5", "ch6", "ch7",
 				"ch8", "ch9", "ch10", "ch11",
 				"ch12";
-		clocks = <&mstp5_clks R8A7791_CLK_AUDIO_DMAC0>;
+		clocks = <&mssr R8A7791_CLK_AUDIO_DMAC0>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
@@ -367,7 +367,7 @@
 				"ch4", "ch5", "ch6", "ch7",
 				"ch8", "ch9", "ch10", "ch11",
 				"ch12";
-		clocks = <&mstp5_clks R8A7791_CLK_AUDIO_DMAC1>;
+		clocks = <&mssr R8A7791_CLK_AUDIO_DMAC1>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
@@ -380,7 +380,7 @@
 		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH
 			      0 109 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "ch0", "ch1";
-		clocks = <&mstp3_clks R8A7791_CLK_USBDMAC0>;
+		clocks = <&mssr R8A7791_CLK_USBDMAC0>;
 		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
@@ -392,7 +392,7 @@
 		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH
 			      0 110 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "ch0", "ch1";
-		clocks = <&mstp3_clks R8A7791_CLK_USBDMAC1>;
+		clocks = <&mssr R8A7791_CLK_USBDMAC1>;
 		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
@@ -405,7 +405,7 @@
 		compatible = "renesas,i2c-r8a7791";
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
+		clocks = <&mssr R8A7791_CLK_I2C0>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -416,7 +416,7 @@
 		compatible = "renesas,i2c-r8a7791";
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7791_CLK_I2C1>;
+		clocks = <&mssr R8A7791_CLK_I2C1>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -427,7 +427,7 @@
 		compatible = "renesas,i2c-r8a7791";
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7791_CLK_I2C2>;
+		clocks = <&mssr R8A7791_CLK_I2C2>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -438,7 +438,7 @@
 		compatible = "renesas,i2c-r8a7791";
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7791_CLK_I2C3>;
+		clocks = <&mssr R8A7791_CLK_I2C3>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -449,7 +449,7 @@
 		compatible = "renesas,i2c-r8a7791";
 		reg = <0 0xe6520000 0 0x40>;
 		interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7791_CLK_I2C4>;
+		clocks = <&mssr R8A7791_CLK_I2C4>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -461,7 +461,7 @@
 		compatible = "renesas,i2c-r8a7791";
 		reg = <0 0xe6528000 0 0x40>;
 		interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7791_CLK_I2C5>;
+		clocks = <&mssr R8A7791_CLK_I2C5>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -473,7 +473,7 @@
 		compatible = "renesas,iic-r8a7791", "renesas,rmobile-iic";
 		reg = <0 0xe60b0000 0 0x425>;
 		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7791_CLK_IICDVFS>;
+		clocks = <&mssr R8A7791_CLK_IICDVFS>;
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -486,7 +486,7 @@
 		compatible = "renesas,iic-r8a7791", "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7791_CLK_IIC0>;
+		clocks = <&mssr R8A7791_CLK_IIC0>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -499,7 +499,7 @@
 		compatible = "renesas,iic-r8a7791", "renesas,rmobile-iic";
 		reg = <0 0xe6510000 0 0x425>;
 		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7791_CLK_IIC1>;
+		clocks = <&mssr R8A7791_CLK_IIC1>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -516,7 +516,7 @@
 		compatible = "renesas,mmcif-r8a7791", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7791_CLK_MMCIF0>;
+		clocks = <&mssr R8A7791_CLK_MMCIF0>;
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -529,7 +529,7 @@
 		compatible = "renesas,sdhi-r8a7791";
 		reg = <0 0xee100000 0 0x328>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7791_CLK_SDHI0>;
+		clocks = <&mssr R8A7791_CLK_SDHI0>;
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -540,7 +540,7 @@
 		compatible = "renesas,sdhi-r8a7791";
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7791_CLK_SDHI1>;
+		clocks = <&mssr R8A7791_CLK_SDHI1>;
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -551,7 +551,7 @@
 		compatible = "renesas,sdhi-r8a7791";
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7791_CLK_SDHI2>;
+		clocks = <&mssr R8A7791_CLK_SDHI2>;
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -562,7 +562,7 @@
 		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7791_CLK_SCIFA0>;
+		clocks = <&mssr R8A7791_CLK_SCIFA0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
 		dma-names = "tx", "rx";
@@ -574,7 +574,7 @@
 		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7791_CLK_SCIFA1>;
+		clocks = <&mssr R8A7791_CLK_SCIFA1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
 		dma-names = "tx", "rx";
@@ -586,7 +586,7 @@
 		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7791_CLK_SCIFA2>;
+		clocks = <&mssr R8A7791_CLK_SCIFA2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
 		dma-names = "tx", "rx";
@@ -598,7 +598,7 @@
 		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
 		reg = <0 0xe6c70000 0 64>;
 		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp11_clks R8A7791_CLK_SCIFA3>;
+		clocks = <&mssr R8A7791_CLK_SCIFA3>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
 		dma-names = "tx", "rx";
@@ -610,7 +610,7 @@
 		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
 		reg = <0 0xe6c78000 0 64>;
 		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp11_clks R8A7791_CLK_SCIFA4>;
+		clocks = <&mssr R8A7791_CLK_SCIFA4>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
 		dma-names = "tx", "rx";
@@ -622,7 +622,7 @@
 		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
 		reg = <0 0xe6c80000 0 64>;
 		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp11_clks R8A7791_CLK_SCIFA5>;
+		clocks = <&mssr R8A7791_CLK_SCIFA5>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
 		dma-names = "tx", "rx";
@@ -634,7 +634,7 @@
 		compatible = "renesas,scifb-r8a7791", "renesas,scifb";
 		reg = <0 0xe6c20000 0 64>;
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7791_CLK_SCIFB0>;
+		clocks = <&mssr R8A7791_CLK_SCIFB0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
 		dma-names = "tx", "rx";
@@ -646,7 +646,7 @@
 		compatible = "renesas,scifb-r8a7791", "renesas,scifb";
 		reg = <0 0xe6c30000 0 64>;
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7791_CLK_SCIFB1>;
+		clocks = <&mssr R8A7791_CLK_SCIFB1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
 		dma-names = "tx", "rx";
@@ -658,7 +658,7 @@
 		compatible = "renesas,scifb-r8a7791", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 64>;
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7791_CLK_SCIFB2>;
+		clocks = <&mssr R8A7791_CLK_SCIFB2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
 		dma-names = "tx", "rx";
@@ -670,7 +670,7 @@
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF0>;
+		clocks = <&mssr R8A7791_CLK_SCIF0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
@@ -682,7 +682,7 @@
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF1>;
+		clocks = <&mssr R8A7791_CLK_SCIF1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
@@ -694,7 +694,7 @@
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6e58000 0 64>;
 		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF2>;
+		clocks = <&mssr R8A7791_CLK_SCIF2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
 		dma-names = "tx", "rx";
@@ -706,7 +706,7 @@
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6ea8000 0 64>;
 		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF3>;
+		clocks = <&mssr R8A7791_CLK_SCIF3>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
 		dma-names = "tx", "rx";
@@ -718,7 +718,7 @@
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6ee0000 0 64>;
 		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF4>;
+		clocks = <&mssr R8A7791_CLK_SCIF4>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
 		dma-names = "tx", "rx";
@@ -730,7 +730,7 @@
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6ee8000 0 64>;
 		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF5>;
+		clocks = <&mssr R8A7791_CLK_SCIF5>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
 		dma-names = "tx", "rx";
@@ -742,7 +742,7 @@
 		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_HSCIF0>;
+		clocks = <&mssr R8A7791_CLK_HSCIF0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
@@ -754,7 +754,7 @@
 		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_HSCIF1>;
+		clocks = <&mssr R8A7791_CLK_HSCIF1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
@@ -766,7 +766,7 @@
 		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
 		reg = <0 0xe62d0000 0 96>;
 		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_HSCIF2>;
+		clocks = <&mssr R8A7791_CLK_HSCIF2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
 		dma-names = "tx", "rx";
@@ -778,7 +778,7 @@
 		compatible = "renesas,ether-r8a7791";
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7791_CLK_ETHER>;
+		clocks = <&mssr R8A7791_CLK_ETHER>;
 		power-domains = <&cpg_clocks>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
@@ -790,7 +790,7 @@
 		compatible = "renesas,sata-r8a7791";
 		reg = <0 0xee300000 0 0x2000>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7791_CLK_SATA0>;
+		clocks = <&mssr R8A7791_CLK_SATA0>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -799,7 +799,7 @@
 		compatible = "renesas,sata-r8a7791";
 		reg = <0 0xee500000 0 0x2000>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7791_CLK_SATA1>;
+		clocks = <&mssr R8A7791_CLK_SATA1>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -808,7 +808,7 @@
 		compatible = "renesas,usbhs-r8a7791";
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_HSUSB>;
+		clocks = <&mssr R8A7791_CLK_HSUSB>;
 		dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
 		       <&usb_dmac1 0>, <&usb_dmac1 1>;
 		dma-names = "ch0", "ch1", "ch2", "ch3";
@@ -824,7 +824,7 @@
 		reg = <0 0xe6590100 0 0x100>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&mstp7_clks R8A7791_CLK_HSUSB>;
+		clocks = <&mssr R8A7791_CLK_HSUSB>;
 		clock-names = "usbhs";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -843,7 +843,7 @@
 		compatible = "renesas,vin-r8a7791";
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <0 188 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7791_CLK_VIN0>;
+		clocks = <&mssr R8A7791_CLK_VIN0>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -852,7 +852,7 @@
 		compatible = "renesas,vin-r8a7791";
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <0 189 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7791_CLK_VIN1>;
+		clocks = <&mssr R8A7791_CLK_VIN1>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -861,7 +861,7 @@
 		compatible = "renesas,vin-r8a7791";
 		reg = <0 0xe6ef2000 0 0x1000>;
 		interrupts = <0 190 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp8_clks R8A7791_CLK_VIN2>;
+		clocks = <&mssr R8A7791_CLK_VIN2>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -870,7 +870,7 @@
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe928000 0 0x8000>;
 		interrupts = <0 267 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7791_CLK_VSP1_S>;
+		clocks = <&mssr R8A7791_CLK_VSP1_S>;
 		power-domains = <&cpg_clocks>;
 
 		renesas,has-lut;
@@ -884,7 +884,7 @@
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <0 246 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU0>;
+		clocks = <&mssr R8A7791_CLK_VSP1_DU0>;
 		power-domains = <&cpg_clocks>;
 
 		renesas,has-lif;
@@ -898,7 +898,7 @@
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe938000 0 0x8000>;
 		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU1>;
+		clocks = <&mssr R8A7791_CLK_VSP1_DU1>;
 		power-domains = <&cpg_clocks>;
 
 		renesas,has-lif;
@@ -915,9 +915,9 @@
 		reg-names = "du", "lvds.0";
 		interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 268 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_DU0>,
-			 <&mstp7_clks R8A7791_CLK_DU1>,
-			 <&mstp7_clks R8A7791_CLK_LVDS0>;
+		clocks = <&mssr R8A7791_CLK_DU0>,
+			 <&mssr R8A7791_CLK_DU1>,
+			 <&mssr R8A7791_CLK_LVDS0>;
 		clock-names = "du.0", "du.1", "lvds.0";
 		status = "disabled";
 
@@ -942,7 +942,7 @@
 		compatible = "renesas,can-r8a7791";
 		reg = <0 0xe6e80000 0 0x1000>;
 		interrupts = <0 186 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7791_CLK_RCAN0>,
+		clocks = <&mssr R8A7791_CLK_RCAN0>,
 			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&cpg_clocks>;
@@ -953,7 +953,7 @@
 		compatible = "renesas,can-r8a7791";
 		reg = <0 0xe6e88000 0 0x1000>;
 		interrupts = <0 187 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7791_CLK_RCAN1>,
+		clocks = <&mssr R8A7791_CLK_RCAN1>,
 			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&cpg_clocks>;
@@ -964,7 +964,7 @@
 		compatible = "renesas,jpu-r8a7791";
 		reg = <0 0xfe980000 0 0x10300>;
 		interrupts = <0 272 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7791_CLK_JPU>;
+		clocks = <&mssr R8A7791_CLK_JPU>;
 		power-domains = <&cpg_clocks>;
 	};
 
@@ -1089,204 +1089,210 @@
 				clock-output-names = "ssprs";
 			};
 
-			/* Gate clocks */
-			mstp0_clks: mstp0_clks@e6150130 {
-				compatible = "renesas,r8a7791-mstp-clocks",
-					     "renesas,cpg-mstp-clocks";
-				reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
-				clocks = <&mp_clk>;
-				#clock-cells = <1>;
-				clock-indices = <R8A7791_CLK_MSIOF0>;
-				clock-output-names = "msiof0";
-			};
-			mstp1_clks: mstp1_clks@e6150134 {
-				compatible = "renesas,r8a7791-mstp-clocks",
-					     "renesas,cpg-mstp-clocks";
-				reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
-				clocks = <&zs_clk>, <&zs_clk>, <&m2_clk>, <&zs_clk>, <&p_clk>,
-					 <&zg_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
-					 <&p_clk>, <&rclk_clk>, <&cp_clk>, <&zs_clk>, <&zs_clk>,
-					 <&zs_clk>;
+			/* Module Standby and Software Reset */
+			mssr: mssr@e6150130 {
+				compatible = "renesas,r8a7791-cpg-mssr";
+				reg = <0 0xe6150000 0 0x1000>;
+
 				#clock-cells = <1>;
+				clocks =
+					/* MSTP0 */
+					<&mp_clk>,
+					/* MSTP1 */
+					<&zs_clk>, <&zs_clk>, <&m2_clk>,
+					<&zs_clk>, <&p_clk>, <&zg_clk>,
+					<&zs_clk>, <&zs_clk>, <&zs_clk>,
+					<&p_clk>, <&p_clk>, <&rclk_clk>,
+					<&cp_clk>, <&zs_clk>, <&zs_clk>,
+					<&zs_clk>,
+					/* MSTP2 */
+					<&mp_clk>, <&mp_clk>, <&mp_clk>,
+					<&mp_clk>, <&mp_clk>, <&mp_clk>,
+					<&mp_clk>, <&mp_clk>, <&zs_clk>,
+					<&zs_clk>,
+					/* MSTP3 */
+					<&cp_clk>, <&sd3_clk>, <&sd2_clk>,
+					<&cpg_clocks R8A7791_CLK_SD0>,
+					<&mmc0_clk>, <&hp_clk>, <&mp_clk>,
+					<&hp_clk>, <&mp_clk>, <&rclk_clk>,
+					<&hp_clk>, <&hp_clk>,
+					/* MSTP4 */
+					<&cp_clk>,
+					/* MSTP5 */
+					<&hp_clk>, <&hp_clk>,
+					<&cpg_clocks R8A7791_CLK_ADSP>,
+					<&extal_clk>, <&p_clk>,
+					/* MSTP7 */
+					<&mp_clk>,  <&hp_clk>, <&zs_clk>,
+					<&p_clk>, <&p_clk>, <&zs_clk>,
+					<&zs_clk>, <&p_clk>, <&p_clk>,
+					<&p_clk>, <&p_clk>, <&zx_clk>,
+					<&zx_clk>, <&zx_clk>,
+					/* MSTP8 */
+					<&zx_clk>, <&hp_clk>, <&zg_clk>,
+					<&zg_clk>, <&zg_clk>, <&p_clk>,
+					<&zs_clk>, <&zs_clk>,
+					/* MSTP9 */
+					<&cp_clk>, <&cp_clk>, <&cp_clk>,
+					<&cp_clk>, <&cp_clk>, <&cp_clk>,
+					<&cp_clk>, <&cp_clk>, <&p_clk>,
+					<&p_clk>,
+					<&cpg_clocks R8A7791_CLK_QSPI>,
+					<&hp_clk>, <&cp_clk>, <&hp_clk>,
+					<&hp_clk>, <&hp_clk>, <&hp_clk>,
+					<&hp_clk>,
+					/* MSTP10 */
+					<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+					<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+					<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+					<&mssr R8A7791_CLK_SCU_ALL>,
+					<&mssr R8A7791_CLK_SCU_ALL>,
+					<&mssr R8A7791_CLK_SCU_ALL>,
+					<&mssr R8A7791_CLK_SCU_ALL>,
+					<&mssr R8A7791_CLK_SCU_ALL>,
+					<&mssr R8A7791_CLK_SCU_ALL>,
+					<&mssr R8A7791_CLK_SCU_ALL>,
+					<&mssr R8A7791_CLK_SCU_ALL>,
+					<&mssr R8A7791_CLK_SCU_ALL>,
+					<&mssr R8A7791_CLK_SCU_ALL>,
+					<&mssr R8A7791_CLK_SCU_ALL>,
+					<&mssr R8A7791_CLK_SCU_ALL>,
+					<&mssr R8A7791_CLK_SCU_ALL>,
+					<&mssr R8A7791_CLK_SCU_ALL>,
+					/* MSTP11 */
+					<&mp_clk>, <&mp_clk>, <&mp_clk>;
 				clock-indices = <
-					R8A7791_CLK_VCP0 R8A7791_CLK_VPC0 R8A7791_CLK_JPU
-					R8A7791_CLK_SSP1 R8A7791_CLK_TMU1 R8A7791_CLK_3DG
-					R8A7791_CLK_2DDMAC R8A7791_CLK_FDP1_1 R8A7791_CLK_FDP1_0
-					R8A7791_CLK_TMU3 R8A7791_CLK_TMU2 R8A7791_CLK_CMT0
-					R8A7791_CLK_TMU0 R8A7791_CLK_VSP1_DU1 R8A7791_CLK_VSP1_DU0
+					/* MSTP0 */
+					R8A7791_CLK_MSIOF0
+					/* MSTP1 */
+					R8A7791_CLK_VCP0 R8A7791_CLK_VPC0
+					R8A7791_CLK_JPU R8A7791_CLK_SSP1
+					R8A7791_CLK_TMU1 R8A7791_CLK_3DG
+					R8A7791_CLK_2DDMAC R8A7791_CLK_FDP1_1
+					R8A7791_CLK_FDP1_0 R8A7791_CLK_TMU3
+					R8A7791_CLK_TMU2 R8A7791_CLK_CMT0
+					R8A7791_CLK_TMU0 R8A7791_CLK_VSP1_DU1
+					R8A7791_CLK_VSP1_DU0
 					R8A7791_CLK_VSP1_S
-				>;
-				clock-output-names =
-					"vcp0", "vpc0", "jpu", "ssp1", "tmu1", "3dg",
-					"2ddmac", "fdp1-1", "fdp1-0", "tmu3", "tmu2", "cmt0",
-					"tmu0", "vsp1-du1", "vsp1-du0", "vsp1-sy";
-			};
-			mstp2_clks: mstp2_clks@e6150138 {
-				compatible = "renesas,r8a7791-mstp-clocks",
-					     "renesas,cpg-mstp-clocks";
-				reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
-				clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
-					 <&mp_clk>, <&mp_clk>, <&mp_clk>,
-					 <&zs_clk>, <&zs_clk>;
-				#clock-cells = <1>;
-				clock-indices = <
-					R8A7791_CLK_SCIFA2 R8A7791_CLK_SCIFA1 R8A7791_CLK_SCIFA0
-					R8A7791_CLK_MSIOF2 R8A7791_CLK_SCIFB0 R8A7791_CLK_SCIFB1
+					/* MSTP2 */
+					R8A7791_CLK_SCIFA2 R8A7791_CLK_SCIFA1
+					R8A7791_CLK_SCIFA0 R8A7791_CLK_MSIOF2
+					R8A7791_CLK_SCIFB0 R8A7791_CLK_SCIFB1
 					R8A7791_CLK_MSIOF1 R8A7791_CLK_SCIFB2
-					R8A7791_CLK_SYS_DMAC1 R8A7791_CLK_SYS_DMAC0
-				>;
-				clock-output-names =
-					"scifa2", "scifa1", "scifa0", "msiof2", "scifb0",
-					"scifb1", "msiof1", "scifb2",
-					"sys-dmac1", "sys-dmac0";
-			};
-			mstp3_clks: mstp3_clks@e615013c {
-				compatible = "renesas,r8a7791-mstp-clocks",
-					     "renesas,cpg-mstp-clocks";
-				reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
-				clocks = <&cp_clk>, <&sd3_clk>, <&sd2_clk>, <&cpg_clocks R8A7791_CLK_SD0>,
-					 <&mmc0_clk>, <&hp_clk>, <&mp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>,
-					 <&hp_clk>, <&hp_clk>;
-				#clock-cells = <1>;
-				clock-indices = <
-					R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1 R8A7791_CLK_SDHI0
-					R8A7791_CLK_MMCIF0 R8A7791_CLK_IIC0 R8A7791_CLK_PCIEC R8A7791_CLK_IIC1
+					R8A7791_CLK_SYS_DMAC1
+					R8A7791_CLK_SYS_DMAC0
+					/* MSTP3 */
+					R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2
+					R8A7791_CLK_SDHI1 R8A7791_CLK_SDHI0
+					R8A7791_CLK_MMCIF0 R8A7791_CLK_IIC0
+					R8A7791_CLK_PCIEC R8A7791_CLK_IIC1
 					R8A7791_CLK_SSUSB R8A7791_CLK_CMT1
-					R8A7791_CLK_USBDMAC0 R8A7791_CLK_USBDMAC1
-				>;
-				clock-output-names =
-					"tpu0", "sdhi2", "sdhi1", "sdhi0",
-					"mmcif0", "i2c7", "pciec", "i2c8", "ssusb", "cmt1",
-					"usbdmac0", "usbdmac1";
-			};
-			mstp4_clks: mstp4_clks@e6150140 {
-				compatible = "renesas,r8a7791-mstp-clocks",
-					     "renesas,cpg-mstp-clocks";
-				reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
-				clocks = <&cp_clk>;
-				#clock-cells = <1>;
-				clock-indices = <R8A7791_CLK_IRQC>;
-				clock-output-names = "irqc";
-			};
-			mstp5_clks: mstp5_clks@e6150144 {
-				compatible = "renesas,r8a7791-mstp-clocks",
-					     "renesas,cpg-mstp-clocks";
-				reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-				clocks = <&hp_clk>, <&hp_clk>, <&cpg_clocks R8A7791_CLK_ADSP>,
-					 <&extal_clk>, <&p_clk>;
-				#clock-cells = <1>;
-				clock-indices = <
-					R8A7791_CLK_AUDIO_DMAC0 R8A7791_CLK_AUDIO_DMAC1
-					R8A7791_CLK_ADSP_MOD R8A7791_CLK_THERMAL
-					R8A7791_CLK_PWM
-				>;
-				clock-output-names = "audmac0", "audmac1", "adsp_mod",
-						     "thermal", "pwm";
-			};
-			mstp7_clks: mstp7_clks@e615014c {
-				compatible = "renesas,r8a7791-mstp-clocks",
-					     "renesas,cpg-mstp-clocks";
-				reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
-				clocks = <&mp_clk>,  <&hp_clk>, <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
-					 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-					 <&zx_clk>, <&zx_clk>, <&zx_clk>;
-				#clock-cells = <1>;
-				clock-indices = <
-					R8A7791_CLK_EHCI R8A7791_CLK_HSUSB R8A7791_CLK_HSCIF2 R8A7791_CLK_SCIF5
-					R8A7791_CLK_SCIF4 R8A7791_CLK_HSCIF1 R8A7791_CLK_HSCIF0
-					R8A7791_CLK_SCIF3 R8A7791_CLK_SCIF2 R8A7791_CLK_SCIF1
-					R8A7791_CLK_SCIF0 R8A7791_CLK_DU1 R8A7791_CLK_DU0
-					R8A7791_CLK_LVDS0
-				>;
-				clock-output-names =
-					"ehci", "hsusb", "hscif2", "scif5", "scif4", "hscif1", "hscif0",
-					"scif3", "scif2", "scif1", "scif0", "du1", "du0", "lvds0";
-			};
-			mstp8_clks: mstp8_clks@e6150990 {
-				compatible = "renesas,r8a7791-mstp-clocks",
-					     "renesas,cpg-mstp-clocks";
-				reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
-				clocks = <&zx_clk>, <&hp_clk>, <&zg_clk>, <&zg_clk>,
-					 <&zg_clk>, <&p_clk>, <&zs_clk>, <&zs_clk>;
-				#clock-cells = <1>;
-				clock-indices = <
+					R8A7791_CLK_USBDMAC0
+					R8A7791_CLK_USBDMAC1
+					/* MSTP4 */
+					R8A7791_CLK_IRQC
+					/* MSTP5 */
+					R8A7791_CLK_AUDIO_DMAC0
+					R8A7791_CLK_AUDIO_DMAC1
+					R8A7791_CLK_ADSP_MOD
+					R8A7791_CLK_THERMAL R8A7791_CLK_PWM
+					/* MSTP7 */
+					R8A7791_CLK_EHCI R8A7791_CLK_HSUSB
+					R8A7791_CLK_HSCIF2 R8A7791_CLK_SCIF5
+					R8A7791_CLK_SCIF4 R8A7791_CLK_HSCIF1
+					R8A7791_CLK_HSCIF0 R8A7791_CLK_SCIF3
+					R8A7791_CLK_SCIF2 R8A7791_CLK_SCIF1
+					R8A7791_CLK_SCIF0 R8A7791_CLK_DU1
+					R8A7791_CLK_DU0 R8A7791_CLK_LVDS0
+					/* MSTP8 */
 					R8A7791_CLK_IPMMU_SGX R8A7791_CLK_MLB
-					R8A7791_CLK_VIN2 R8A7791_CLK_VIN1 R8A7791_CLK_VIN0
-					R8A7791_CLK_ETHER R8A7791_CLK_SATA1 R8A7791_CLK_SATA0
-				>;
-				clock-output-names =
-					"ipmmu_sgx", "mlb", "vin2", "vin1", "vin0", "ether",
-					"sata1", "sata0";
-			};
-			mstp9_clks: mstp9_clks@e6150994 {
-				compatible = "renesas,r8a7791-mstp-clocks",
-					     "renesas,cpg-mstp-clocks";
-				reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
-				clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
-					 <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
-					 <&p_clk>, <&p_clk>, <&cpg_clocks R8A7791_CLK_QSPI>, <&hp_clk>,
-					 <&cp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>,
-					 <&hp_clk>, <&hp_clk>;
-				#clock-cells = <1>;
-				clock-indices = <
-					R8A7791_CLK_GPIO7 R8A7791_CLK_GPIO6 R8A7791_CLK_GPIO5 R8A7791_CLK_GPIO4
-					R8A7791_CLK_GPIO3 R8A7791_CLK_GPIO2 R8A7791_CLK_GPIO1 R8A7791_CLK_GPIO0
-					R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_QSPI_MOD R8A7791_CLK_I2C5
-					R8A7791_CLK_IICDVFS R8A7791_CLK_I2C4 R8A7791_CLK_I2C3 R8A7791_CLK_I2C2
+					R8A7791_CLK_VIN2 R8A7791_CLK_VIN1
+					R8A7791_CLK_VIN0 R8A7791_CLK_ETHER
+					R8A7791_CLK_SATA1 R8A7791_CLK_SATA0
+					/* MSTP9 */
+					R8A7791_CLK_GPIO7 R8A7791_CLK_GPIO6
+					R8A7791_CLK_GPIO5 R8A7791_CLK_GPIO4
+					R8A7791_CLK_GPIO3 R8A7791_CLK_GPIO2
+					R8A7791_CLK_GPIO1 R8A7791_CLK_GPIO0
+					R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0
+					R8A7791_CLK_QSPI_MOD R8A7791_CLK_I2C5
+					R8A7791_CLK_IICDVFS R8A7791_CLK_I2C4
+					R8A7791_CLK_I2C3 R8A7791_CLK_I2C2
 					R8A7791_CLK_I2C1 R8A7791_CLK_I2C0
+					/* MSTP10 */
+					R8A7791_CLK_SSI_ALL R8A7791_CLK_SSI9
+					R8A7791_CLK_SSI8 R8A7791_CLK_SSI7
+					R8A7791_CLK_SSI6 R8A7791_CLK_SSI5
+					R8A7791_CLK_SSI4 R8A7791_CLK_SSI3
+					R8A7791_CLK_SSI2 R8A7791_CLK_SSI1
+					R8A7791_CLK_SSI0 R8A7791_CLK_SCU_ALL
+					R8A7791_CLK_SCU_DVC1
+					R8A7791_CLK_SCU_DVC0
+					R8A7791_CLK_SCU_CTU1_MIX1
+					R8A7791_CLK_SCU_CTU0_MIX0
+					R8A7791_CLK_SCU_SRC9
+					R8A7791_CLK_SCU_SRC8
+					R8A7791_CLK_SCU_SRC7
+					R8A7791_CLK_SCU_SRC6
+					R8A7791_CLK_SCU_SRC5
+					R8A7791_CLK_SCU_SRC4
+					R8A7791_CLK_SCU_SRC3
+					R8A7791_CLK_SCU_SRC2
+					R8A7791_CLK_SCU_SRC1
+					R8A7791_CLK_SCU_SRC0
+					/* MSTP11 */
+					R8A7791_CLK_SCIFA3 R8A7791_CLK_SCIFA4
+					R8A7791_CLK_SCIFA5
 				>;
 				clock-output-names =
-					"gpio7", "gpio6", "gpio5", "gpio4", "gpio3", "gpio2", "gpio1", "gpio0",
-					"rcan1", "rcan0", "qspi_mod", "i2c5", "i2c6", "i2c4", "i2c3", "i2c2",
-					"i2c1", "i2c0";
-			};
-			mstp10_clks: mstp10_clks@e6150998 {
-				compatible = "renesas,r8a7791-mstp-clocks",
-					     "renesas,cpg-mstp-clocks";
-				reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
-				clocks = <&p_clk>,
-					<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-					<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-					<&p_clk>,
-					<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
-					<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
-					<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
-					<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
-					<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
-					<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
-					<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>;
-
-				#clock-cells = <1>;
-				clock-indices = <
-					R8A7791_CLK_SSI_ALL
-					R8A7791_CLK_SSI9 R8A7791_CLK_SSI8 R8A7791_CLK_SSI7 R8A7791_CLK_SSI6 R8A7791_CLK_SSI5
-					R8A7791_CLK_SSI4 R8A7791_CLK_SSI3 R8A7791_CLK_SSI2 R8A7791_CLK_SSI1 R8A7791_CLK_SSI0
-					R8A7791_CLK_SCU_ALL
-					R8A7791_CLK_SCU_DVC1 R8A7791_CLK_SCU_DVC0
-					R8A7791_CLK_SCU_CTU1_MIX1 R8A7791_CLK_SCU_CTU0_MIX0
-					R8A7791_CLK_SCU_SRC9 R8A7791_CLK_SCU_SRC8 R8A7791_CLK_SCU_SRC7 R8A7791_CLK_SCU_SRC6 R8A7791_CLK_SCU_SRC5
-					R8A7791_CLK_SCU_SRC4 R8A7791_CLK_SCU_SRC3 R8A7791_CLK_SCU_SRC2 R8A7791_CLK_SCU_SRC1 R8A7791_CLK_SCU_SRC0
-				>;
-				clock-output-names =
-					"ssi-all",
-					"ssi9", "ssi8", "ssi7", "ssi6", "ssi5",
-					"ssi4", "ssi3", "ssi2", "ssi1", "ssi0",
-					"scu-all",
-					"scu-dvc1", "scu-dvc0",
-					"scu-ctu1-mix1", "scu-ctu0-mix0",
-					"scu-src9", "scu-src8", "scu-src7", "scu-src6", "scu-src5",
-					"scu-src4", "scu-src3", "scu-src2", "scu-src1", "scu-src0";
-			};
-			mstp11_clks: mstp11_clks@e615099c {
-				compatible = "renesas,r8a7791-mstp-clocks",
-					     "renesas,cpg-mstp-clocks";
-				reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
-				clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>;
-				#clock-cells = <1>;
-				clock-indices = <
-					R8A7791_CLK_SCIFA3 R8A7791_CLK_SCIFA4 R8A7791_CLK_SCIFA5
-				>;
-				clock-output-names = "scifa3", "scifa4", "scifa5";
+					/* MSTP0 */
+					"msiof0",
+					/* MSTP1 */
+					"vcp0", "vpc0", "jpu", "ssp1", "tmu1",
+					"3dg", "2ddmac", "fdp1-1", "fdp1-0",
+					"tmu3", "tmu2", "cmt0", "tmu0",
+					"vsp1-du1", "vsp1-du0", "vsp1-sy",
+					/* MSTP2 */
+					"scifa2", "scifa1", "scifa0", "msiof2",
+					"scifb0", "scifb1", "msiof1", "scifb2",
+					"sys-dmac1", "sys-dmac0",
+					/* MSTP3 */
+					"tpu0", "sdhi2", "sdhi1", "sdhi0",
+					"mmcif0", "i2c7", "pciec", "i2c8",
+					"ssusb", "cmt1", "usbdmac0",
+					"usbdmac1",
+					/* MSTP4 */
+					"irqc",
+					/* MSTP5 */
+					"audmac0", "audmac1", "adsp_mod",
+					"thermal", "pwm",
+					/* MSTP7 */
+					"ehci", "hsusb", "hscif2", "scif5",
+					"scif4", "hscif1", "hscif0", "scif3",
+					"scif2", "scif1", "scif0", "du1",
+					"du0", "lvds0",
+					/* MSTP8 */
+					"ipmmu_sgx", "mlb", "vin2", "vin1",
+					"vin0", "ether", "sata1", "sata0",
+					/* MSTP9 */
+					"gpio7", "gpio6", "gpio5", "gpio4",
+					"gpio3", "gpio2", "gpio1", "gpio0",
+					"rcan1", "rcan0", "qspi_mod", "i2c5",
+					"i2c6", "i2c4", "i2c3", "i2c2", "i2c1",
+					"i2c0",
+					/* MSTP10 */
+					"ssi-all", "ssi9", "ssi8", "ssi7",
+					"ssi6", "ssi5", "ssi4", "ssi3", "ssi2",
+					"ssi1", "ssi0", "scu-all", "scu-dvc1",
+					"scu-dvc0", "scu-ctu1-mix1",
+					"scu-ctu0-mix0", "scu-src9",
+					"scu-src8", "scu-src7", "scu-src6",
+					"scu-src5", "scu-src4", "scu-src3",
+					"scu-src2", "scu-src1", "scu-src0",
+					/* MSTP11 */
+					"scifa3", "scifa4", "scifa5";
+
+				#reset-cells = <1>;
 			};
 		};
 
@@ -1442,7 +1448,7 @@
 		compatible = "renesas,qspi-r8a7791", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
 		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7791_CLK_QSPI_MOD>;
+		clocks = <&mssr R8A7791_CLK_QSPI_MOD>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -1456,7 +1462,7 @@
 		compatible = "renesas,msiof-r8a7791";
 		reg = <0 0xe6e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
+		clocks = <&mssr R8A7791_CLK_MSIOF0>;
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -1469,7 +1475,7 @@
 		compatible = "renesas,msiof-r8a7791";
 		reg = <0 0xe6e10000 0 0x0064>;
 		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7791_CLK_MSIOF1>;
+		clocks = <&mssr R8A7791_CLK_MSIOF1>;
 		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -1482,7 +1488,7 @@
 		compatible = "renesas,msiof-r8a7791";
 		reg = <0 0xe6e00000 0 0x0064>;
 		interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7791_CLK_MSIOF2>;
+		clocks = <&mssr R8A7791_CLK_MSIOF2>;
 		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -1495,7 +1501,7 @@
 		compatible = "renesas,xhci-r8a7791";
 		reg = <0 0xee000000 0 0xc00>;
 		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7791_CLK_SSUSB>;
+		clocks = <&mssr R8A7791_CLK_SSUSB>;
 		power-domains = <&cpg_clocks>;
 		phys = <&usb2 1>;
 		phy-names = "usb";
@@ -1508,7 +1514,7 @@
 		reg = <0 0xee090000 0 0xc00>,
 		      <0 0xee080000 0 0x1100>;
 		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
+		clocks = <&mssr R8A7791_CLK_EHCI>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 
@@ -1543,7 +1549,7 @@
 		reg = <0 0xee0d0000 0 0xc00>,
 		      <0 0xee0c0000 0 0x1100>;
 		interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
+		clocks = <&mssr R8A7791_CLK_EHCI>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 
@@ -1592,7 +1598,7 @@
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp3_clks R8A7791_CLK_PCIEC>, <&pcie_bus_clk>;
+		clocks = <&mssr R8A7791_CLK_PCIEC>, <&pcie_bus_clk>;
 		clock-names = "pcie", "pcie_bus";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -1673,20 +1679,20 @@
 			<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
 		reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
-		clocks = <&mstp10_clks R8A7791_CLK_SSI_ALL>,
-			<&mstp10_clks R8A7791_CLK_SSI9>, <&mstp10_clks R8A7791_CLK_SSI8>,
-			<&mstp10_clks R8A7791_CLK_SSI7>, <&mstp10_clks R8A7791_CLK_SSI6>,
-			<&mstp10_clks R8A7791_CLK_SSI5>, <&mstp10_clks R8A7791_CLK_SSI4>,
-			<&mstp10_clks R8A7791_CLK_SSI3>, <&mstp10_clks R8A7791_CLK_SSI2>,
-			<&mstp10_clks R8A7791_CLK_SSI1>, <&mstp10_clks R8A7791_CLK_SSI0>,
-			<&mstp10_clks R8A7791_CLK_SCU_SRC9>, <&mstp10_clks R8A7791_CLK_SCU_SRC8>,
-			<&mstp10_clks R8A7791_CLK_SCU_SRC7>, <&mstp10_clks R8A7791_CLK_SCU_SRC6>,
-			<&mstp10_clks R8A7791_CLK_SCU_SRC5>, <&mstp10_clks R8A7791_CLK_SCU_SRC4>,
-			<&mstp10_clks R8A7791_CLK_SCU_SRC3>, <&mstp10_clks R8A7791_CLK_SCU_SRC2>,
-			<&mstp10_clks R8A7791_CLK_SCU_SRC1>, <&mstp10_clks R8A7791_CLK_SCU_SRC0>,
-			<&mstp10_clks R8A7791_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7791_CLK_SCU_CTU1_MIX1>,
-			<&mstp10_clks R8A7791_CLK_SCU_CTU0_MIX0>, <&mstp10_clks R8A7791_CLK_SCU_CTU1_MIX1>,
-			<&mstp10_clks R8A7791_CLK_SCU_DVC0>, <&mstp10_clks R8A7791_CLK_SCU_DVC1>,
+		clocks = <&mssr R8A7791_CLK_SSI_ALL>,
+			<&mssr R8A7791_CLK_SSI9>, <&mssr R8A7791_CLK_SSI8>,
+			<&mssr R8A7791_CLK_SSI7>, <&mssr R8A7791_CLK_SSI6>,
+			<&mssr R8A7791_CLK_SSI5>, <&mssr R8A7791_CLK_SSI4>,
+			<&mssr R8A7791_CLK_SSI3>, <&mssr R8A7791_CLK_SSI2>,
+			<&mssr R8A7791_CLK_SSI1>, <&mssr R8A7791_CLK_SSI0>,
+			<&mssr R8A7791_CLK_SCU_SRC9>, <&mssr R8A7791_CLK_SCU_SRC8>,
+			<&mssr R8A7791_CLK_SCU_SRC7>, <&mssr R8A7791_CLK_SCU_SRC6>,
+			<&mssr R8A7791_CLK_SCU_SRC5>, <&mssr R8A7791_CLK_SCU_SRC4>,
+			<&mssr R8A7791_CLK_SCU_SRC3>, <&mssr R8A7791_CLK_SCU_SRC2>,
+			<&mssr R8A7791_CLK_SCU_SRC1>, <&mssr R8A7791_CLK_SCU_SRC0>,
+			<&mssr R8A7791_CLK_SCU_CTU0_MIX0>, <&mssr R8A7791_CLK_SCU_CTU1_MIX1>,
+			<&mssr R8A7791_CLK_SCU_CTU0_MIX0>, <&mssr R8A7791_CLK_SCU_CTU1_MIX1>,
+			<&mssr R8A7791_CLK_SCU_DVC0>, <&mssr R8A7791_CLK_SCU_DVC1>,
 			<&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>, <&m2_clk>;
 		clock-names = "ssi-all",
 				"ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index 7c318c5bbacab4ff..fbf0fc23d324bd30 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -23,141 +23,143 @@
 #define R8A7791_CLK_RCAN		9
 #define R8A7791_CLK_ADSP		10
 
+#define MSTP(n)				(n / 100 * 32 + n % 100)
+
 /* MSTP0 */
-#define R8A7791_CLK_MSIOF0		0
+#define R8A7791_CLK_MSIOF0		MSTP(0)
 
 /* MSTP1 */
-#define R8A7791_CLK_VCP0		1
-#define R8A7791_CLK_VPC0		3
-#define R8A7791_CLK_JPU			6
-#define R8A7791_CLK_SSP1		9
-#define R8A7791_CLK_TMU1		11
-#define R8A7791_CLK_3DG			12
-#define R8A7791_CLK_2DDMAC		15
-#define R8A7791_CLK_FDP1_1		18
-#define R8A7791_CLK_FDP1_0		19
-#define R8A7791_CLK_TMU3		21
-#define R8A7791_CLK_TMU2		22
-#define R8A7791_CLK_CMT0		24
-#define R8A7791_CLK_TMU0		25
-#define R8A7791_CLK_VSP1_DU1		27
-#define R8A7791_CLK_VSP1_DU0		28
-#define R8A7791_CLK_VSP1_S		31
+#define R8A7791_CLK_VCP0		MSTP(101)
+#define R8A7791_CLK_VPC0		MSTP(103)
+#define R8A7791_CLK_JPU			MSTP(106)
+#define R8A7791_CLK_SSP1		MSTP(109)
+#define R8A7791_CLK_TMU1		MSTP(111)
+#define R8A7791_CLK_3DG			MSTP(112)
+#define R8A7791_CLK_2DDMAC		MSTP(115)
+#define R8A7791_CLK_FDP1_1		MSTP(118)
+#define R8A7791_CLK_FDP1_0		MSTP(119)
+#define R8A7791_CLK_TMU3		MSTP(121)
+#define R8A7791_CLK_TMU2		MSTP(122)
+#define R8A7791_CLK_CMT0		MSTP(124)
+#define R8A7791_CLK_TMU0		MSTP(125)
+#define R8A7791_CLK_VSP1_DU1		MSTP(127)
+#define R8A7791_CLK_VSP1_DU0		MSTP(128)
+#define R8A7791_CLK_VSP1_S		MSTP(131)
 
 /* MSTP2 */
-#define R8A7791_CLK_SCIFA2		2
-#define R8A7791_CLK_SCIFA1		3
-#define R8A7791_CLK_SCIFA0		4
-#define R8A7791_CLK_MSIOF2		5
-#define R8A7791_CLK_SCIFB0		6
-#define R8A7791_CLK_SCIFB1		7
-#define R8A7791_CLK_MSIOF1		8
-#define R8A7791_CLK_SCIFB2		16
-#define R8A7791_CLK_SYS_DMAC1		18
-#define R8A7791_CLK_SYS_DMAC0		19
+#define R8A7791_CLK_SCIFA2		MSTP(202)
+#define R8A7791_CLK_SCIFA1		MSTP(203)
+#define R8A7791_CLK_SCIFA0		MSTP(204)
+#define R8A7791_CLK_MSIOF2		MSTP(205)
+#define R8A7791_CLK_SCIFB0		MSTP(206)
+#define R8A7791_CLK_SCIFB1		MSTP(207)
+#define R8A7791_CLK_MSIOF1		MSTP(208)
+#define R8A7791_CLK_SCIFB2		MSTP(216)
+#define R8A7791_CLK_SYS_DMAC1		MSTP(218)
+#define R8A7791_CLK_SYS_DMAC0		MSTP(219)
 
 /* MSTP3 */
-#define R8A7791_CLK_TPU0		4
-#define R8A7791_CLK_SDHI2		11
-#define R8A7791_CLK_SDHI1		12
-#define R8A7791_CLK_SDHI0		14
-#define R8A7791_CLK_MMCIF0		15
-#define R8A7791_CLK_IIC0		18
-#define R8A7791_CLK_PCIEC		19
-#define R8A7791_CLK_IIC1		23
-#define R8A7791_CLK_SSUSB		28
-#define R8A7791_CLK_CMT1		29
-#define R8A7791_CLK_USBDMAC0		30
-#define R8A7791_CLK_USBDMAC1		31
+#define R8A7791_CLK_TPU0		MSTP(304)
+#define R8A7791_CLK_SDHI2		MSTP(311)
+#define R8A7791_CLK_SDHI1		MSTP(312)
+#define R8A7791_CLK_SDHI0		MSTP(314)
+#define R8A7791_CLK_MMCIF0		MSTP(315)
+#define R8A7791_CLK_IIC0		MSTP(318)
+#define R8A7791_CLK_PCIEC		MSTP(319)
+#define R8A7791_CLK_IIC1		MSTP(323)
+#define R8A7791_CLK_SSUSB		MSTP(328)
+#define R8A7791_CLK_CMT1		MSTP(329)
+#define R8A7791_CLK_USBDMAC0		MSTP(330)
+#define R8A7791_CLK_USBDMAC1		MSTP(331)
 
 /* MSTP4 */
-#define R8A7791_CLK_IRQC		7
-#define R8A7791_CLK_INTC_SYS		8
+#define R8A7791_CLK_IRQC		MSTP(407)
+#define R8A7791_CLK_INTC_SYS		MSTP(408)
 
 /* MSTP5 */
-#define R8A7791_CLK_AUDIO_DMAC1		1
-#define R8A7791_CLK_AUDIO_DMAC0		2
-#define R8A7791_CLK_ADSP_MOD		6
-#define R8A7791_CLK_THERMAL		22
-#define R8A7791_CLK_PWM			23
+#define R8A7791_CLK_AUDIO_DMAC1		MSTP(501)
+#define R8A7791_CLK_AUDIO_DMAC0		MSTP(502)
+#define R8A7791_CLK_ADSP_MOD		MSTP(506)
+#define R8A7791_CLK_THERMAL		MSTP(522)
+#define R8A7791_CLK_PWM			MSTP(523)
 
 /* MSTP7 */
-#define R8A7791_CLK_EHCI		3
-#define R8A7791_CLK_HSUSB		4
-#define R8A7791_CLK_HSCIF2		13
-#define R8A7791_CLK_SCIF5		14
-#define R8A7791_CLK_SCIF4		15
-#define R8A7791_CLK_HSCIF1		16
-#define R8A7791_CLK_HSCIF0		17
-#define R8A7791_CLK_SCIF3		18
-#define R8A7791_CLK_SCIF2		19
-#define R8A7791_CLK_SCIF1		20
-#define R8A7791_CLK_SCIF0		21
-#define R8A7791_CLK_DU1			23
-#define R8A7791_CLK_DU0			24
-#define R8A7791_CLK_LVDS0		26
+#define R8A7791_CLK_EHCI		MSTP(703)
+#define R8A7791_CLK_HSUSB		MSTP(704)
+#define R8A7791_CLK_HSCIF2		MSTP(713)
+#define R8A7791_CLK_SCIF5		MSTP(714)
+#define R8A7791_CLK_SCIF4		MSTP(715)
+#define R8A7791_CLK_HSCIF1		MSTP(716)
+#define R8A7791_CLK_HSCIF0		MSTP(717)
+#define R8A7791_CLK_SCIF3		MSTP(718)
+#define R8A7791_CLK_SCIF2		MSTP(719)
+#define R8A7791_CLK_SCIF1		MSTP(720)
+#define R8A7791_CLK_SCIF0		MSTP(721)
+#define R8A7791_CLK_DU1			MSTP(723)
+#define R8A7791_CLK_DU0			MSTP(724)
+#define R8A7791_CLK_LVDS0		MSTP(726)
 
 /* MSTP8 */
-#define R8A7791_CLK_IPMMU_SGX		0
-#define R8A7791_CLK_MLB			2
-#define R8A7791_CLK_VIN2		9
-#define R8A7791_CLK_VIN1		10
-#define R8A7791_CLK_VIN0		11
-#define R8A7791_CLK_ETHER		13
-#define R8A7791_CLK_SATA1		14
-#define R8A7791_CLK_SATA0		15
+#define R8A7791_CLK_IPMMU_SGX		MSTP(800)
+#define R8A7791_CLK_MLB			MSTP(802)
+#define R8A7791_CLK_VIN2		MSTP(809)
+#define R8A7791_CLK_VIN1		MSTP(810)
+#define R8A7791_CLK_VIN0		MSTP(811)
+#define R8A7791_CLK_ETHER		MSTP(813)
+#define R8A7791_CLK_SATA1		MSTP(814)
+#define R8A7791_CLK_SATA0		MSTP(815)
 
 /* MSTP9 */
-#define R8A7791_CLK_GPIO7		4
-#define R8A7791_CLK_GPIO6		5
-#define R8A7791_CLK_GPIO5		7
-#define R8A7791_CLK_GPIO4		8
-#define R8A7791_CLK_GPIO3		9
-#define R8A7791_CLK_GPIO2		10
-#define R8A7791_CLK_GPIO1		11
-#define R8A7791_CLK_GPIO0		12
-#define R8A7791_CLK_RCAN1		15
-#define R8A7791_CLK_RCAN0		16
-#define R8A7791_CLK_QSPI_MOD		17
-#define R8A7791_CLK_I2C5		25
-#define R8A7791_CLK_IICDVFS		26
-#define R8A7791_CLK_I2C4		27
-#define R8A7791_CLK_I2C3		28
-#define R8A7791_CLK_I2C2		29
-#define R8A7791_CLK_I2C1		30
-#define R8A7791_CLK_I2C0		31
+#define R8A7791_CLK_GPIO7		MSTP(904)
+#define R8A7791_CLK_GPIO6		MSTP(905)
+#define R8A7791_CLK_GPIO5		MSTP(907)
+#define R8A7791_CLK_GPIO4		MSTP(908)
+#define R8A7791_CLK_GPIO3		MSTP(909)
+#define R8A7791_CLK_GPIO2		MSTP(910)
+#define R8A7791_CLK_GPIO1		MSTP(911)
+#define R8A7791_CLK_GPIO0		MSTP(912)
+#define R8A7791_CLK_RCAN1		MSTP(915)
+#define R8A7791_CLK_RCAN0		MSTP(916)
+#define R8A7791_CLK_QSPI_MOD		MSTP(917)
+#define R8A7791_CLK_I2C5		MSTP(925)
+#define R8A7791_CLK_IICDVFS		MSTP(926)
+#define R8A7791_CLK_I2C4		MSTP(927)
+#define R8A7791_CLK_I2C3		MSTP(928)
+#define R8A7791_CLK_I2C2		MSTP(929)
+#define R8A7791_CLK_I2C1		MSTP(930)
+#define R8A7791_CLK_I2C0		MSTP(931)
 
 /* MSTP10 */
-#define R8A7791_CLK_SSI_ALL		5
-#define R8A7791_CLK_SSI9		6
-#define R8A7791_CLK_SSI8		7
-#define R8A7791_CLK_SSI7		8
-#define R8A7791_CLK_SSI6		9
-#define R8A7791_CLK_SSI5		10
-#define R8A7791_CLK_SSI4		11
-#define R8A7791_CLK_SSI3		12
-#define R8A7791_CLK_SSI2		13
-#define R8A7791_CLK_SSI1		14
-#define R8A7791_CLK_SSI0		15
-#define R8A7791_CLK_SCU_ALL		17
-#define R8A7791_CLK_SCU_DVC1		18
-#define R8A7791_CLK_SCU_DVC0		19
-#define R8A7791_CLK_SCU_CTU1_MIX1	20
-#define R8A7791_CLK_SCU_CTU0_MIX0	21
-#define R8A7791_CLK_SCU_SRC9		22
-#define R8A7791_CLK_SCU_SRC8		23
-#define R8A7791_CLK_SCU_SRC7		24
-#define R8A7791_CLK_SCU_SRC6		25
-#define R8A7791_CLK_SCU_SRC5		26
-#define R8A7791_CLK_SCU_SRC4		27
-#define R8A7791_CLK_SCU_SRC3		28
-#define R8A7791_CLK_SCU_SRC2		29
-#define R8A7791_CLK_SCU_SRC1		30
-#define R8A7791_CLK_SCU_SRC0		31
+#define R8A7791_CLK_SSI_ALL		MSTP(1005)
+#define R8A7791_CLK_SSI9		MSTP(1006)
+#define R8A7791_CLK_SSI8		MSTP(1007)
+#define R8A7791_CLK_SSI7		MSTP(1008)
+#define R8A7791_CLK_SSI6		MSTP(1009)
+#define R8A7791_CLK_SSI5		MSTP(1010)
+#define R8A7791_CLK_SSI4		MSTP(1011)
+#define R8A7791_CLK_SSI3		MSTP(1012)
+#define R8A7791_CLK_SSI2		MSTP(1013)
+#define R8A7791_CLK_SSI1		MSTP(1014)
+#define R8A7791_CLK_SSI0		MSTP(1015)
+#define R8A7791_CLK_SCU_ALL		MSTP(1017)
+#define R8A7791_CLK_SCU_DVC1		MSTP(1018)
+#define R8A7791_CLK_SCU_DVC0		MSTP(1019)
+#define R8A7791_CLK_SCU_CTU1_MIX1	MSTP(1020)
+#define R8A7791_CLK_SCU_CTU0_MIX0	MSTP(1021)
+#define R8A7791_CLK_SCU_SRC9		MSTP(1022)
+#define R8A7791_CLK_SCU_SRC8		MSTP(1023)
+#define R8A7791_CLK_SCU_SRC7		MSTP(1024)
+#define R8A7791_CLK_SCU_SRC6		MSTP(1025)
+#define R8A7791_CLK_SCU_SRC5		MSTP(1026)
+#define R8A7791_CLK_SCU_SRC4		MSTP(1027)
+#define R8A7791_CLK_SCU_SRC3		MSTP(1028)
+#define R8A7791_CLK_SCU_SRC2		MSTP(1029)
+#define R8A7791_CLK_SCU_SRC1		MSTP(1030)
+#define R8A7791_CLK_SCU_SRC0		MSTP(1031)
 
 /* MSTP11 */
-#define R8A7791_CLK_SCIFA3		6
-#define R8A7791_CLK_SCIFA4		7
-#define R8A7791_CLK_SCIFA5		8
+#define R8A7791_CLK_SCIFA3		MSTP(1106)
+#define R8A7791_CLK_SCIFA4		MSTP(1107)
+#define R8A7791_CLK_SCIFA5		MSTP(1108)
 
 #endif /* __DT_BINDINGS_CLOCK_R8A7791_H__ */
-- 
1.9.1

