From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 3/5] ARM: shmobile: r8a7791 dtsi: Add CPG Clock Domain
Date: Wed, 18 Mar 2015 20:46:55 +0100
Message-ID: <1426708017-28885-4-git-send-email-geert+renesas@glider.be>
References: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:43624 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756392AbbCRTrD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 15:47:03 -0400
In-Reply-To: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add an appropriate "#power-domain-cells" property to the cpg_clocks
device node, to create the CPG Clock Domain.

Add "power-domains" properties to all device nodes for devices that are
part of the CPG Clock Domain and can be power-managed through their
primary clock. This includes most on-SoC devices. Notable exceptions
are:
  - du, which references 3 or 5 clocks; I assume the driver manages all
    of them itself?
  - rcar_sound, which references lots of clock; idem?

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 80 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 9191acce98a6eeb2..cd11c6dd75021edb 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -80,6 +80,7 @@
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 		clocks = <&mstp4_clks R8A7791_CLK_INTC_SYS>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio0: gpio@e6050000 {
@@ -92,6 +93,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO0>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio1: gpio@e6051000 {
@@ -104,6 +106,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO1>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio2: gpio@e6052000 {
@@ -116,6 +119,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO2>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio3: gpio@e6053000 {
@@ -128,6 +132,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO3>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio4: gpio@e6054000 {
@@ -140,6 +145,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO4>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio5: gpio@e6055000 {
@@ -152,6 +158,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO5>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio6: gpio@e6055400 {
@@ -164,6 +171,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO6>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio7: gpio@e6055800 {
@@ -176,6 +184,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO7>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	thermal@e61f0000 {
@@ -183,6 +192,7 @@
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A7791_CLK_THERMAL>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	timer {
@@ -200,6 +210,7 @@
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_CMT0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		renesas,channels-mask = <0x60>;
 
@@ -219,6 +230,7 @@
 			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_CMT1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -241,6 +253,7 @@
 			     <0 16 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A7791_CLK_IRQC>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	dmac0: dma-controller@e6700000 {
@@ -269,6 +282,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7791_CLK_SYS_DMAC0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -299,6 +313,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7791_CLK_SYS_DMAC1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -327,6 +342,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7791_CLK_AUDIO_DMAC0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -355,6 +371,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7791_CLK_AUDIO_DMAC1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -367,6 +384,7 @@
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -377,6 +395,7 @@
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -387,6 +406,7 @@
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -397,6 +417,7 @@
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C3>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -407,6 +428,7 @@
 		reg = <0 0xe6520000 0 0x40>;
 		interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C4>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -418,6 +440,7 @@
 		reg = <0 0xe6528000 0 0x40>;
 		interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C5>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -431,6 +454,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_IICDVFS>;
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -443,6 +467,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_IIC0>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -455,6 +480,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_IIC1>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -471,6 +497,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_MMCIF0>;
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -482,6 +509,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI0>;
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -492,6 +520,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI1>;
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -502,6 +531,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI2>;
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -511,6 +541,7 @@
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA0>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -520,6 +551,7 @@
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA1>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -529,6 +561,7 @@
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA2>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -538,6 +571,7 @@
 		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA3>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -547,6 +581,7 @@
 		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA4>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -556,6 +591,7 @@
 		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA5>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -565,6 +601,7 @@
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB0>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -574,6 +611,7 @@
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB1>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -583,6 +621,7 @@
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB2>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -592,6 +631,7 @@
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF0>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -601,6 +641,7 @@
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF1>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -610,6 +651,7 @@
 		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF2>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -619,6 +661,7 @@
 		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF3>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -628,6 +671,7 @@
 		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF4>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -637,6 +681,7 @@
 		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF5>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -646,6 +691,7 @@
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF0>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -655,6 +701,7 @@
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF1>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -664,6 +711,7 @@
 		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF2>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -672,6 +720,7 @@
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_ETHER>;
+		power-domains = <&cpg_clocks>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -683,6 +732,7 @@
 		reg = <0 0xee300000 0 0x2000>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_SATA0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -691,6 +741,7 @@
 		reg = <0 0xee500000 0 0x2000>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_SATA1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -699,6 +750,7 @@
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSUSB>;
+		power-domains = <&cpg_clocks>;
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
@@ -712,6 +764,7 @@
 		#size-cells = <0>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSUSB>;
 		clock-names = "usbhs";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 
 		usb0: usb-channel@0 {
@@ -726,25 +779,28 @@
 
 	vin0: video@e6ef0000 {
 		compatible = "renesas,vin-r8a7791";
-		clocks = <&mstp8_clks R8A7791_CLK_VIN0>;
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <0 188 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7791_CLK_VIN0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
 	vin1: video@e6ef1000 {
 		compatible = "renesas,vin-r8a7791";
-		clocks = <&mstp8_clks R8A7791_CLK_VIN1>;
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <0 189 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7791_CLK_VIN1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
 	vin2: video@e6ef2000 {
 		compatible = "renesas,vin-r8a7791";
-		clocks = <&mstp8_clks R8A7791_CLK_VIN2>;
 		reg = <0 0xe6ef2000 0 0x1000>;
 		interrupts = <0 190 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7791_CLK_VIN2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -753,6 +809,7 @@
 		reg = <0 0xfe928000 0 0x8000>;
 		interrupts = <0 267 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_S>;
+		power-domains = <&cpg_clocks>;
 
 		renesas,has-lut;
 		renesas,has-sru;
@@ -766,6 +823,7 @@
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <0 246 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU0>;
+		power-domains = <&cpg_clocks>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -779,6 +837,7 @@
 		reg = <0 0xfe938000 0 0x8000>;
 		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU1>;
+		power-domains = <&cpg_clocks>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -824,6 +883,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_RCAN0>,
 			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -834,6 +894,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_RCAN1>,
 			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -911,6 +972,7 @@
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "z",
 					     "rcan", "adsp";
+			#power-domain-cells = <0>;
 		};
 
 		/* Variable factor clocks */
@@ -1290,6 +1352,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_QSPI_MOD>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1303,6 +1366,7 @@
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1315,6 +1379,7 @@
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF1>;
 		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1327,6 +1392,7 @@
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF2>;
 		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1337,6 +1403,7 @@
 		reg = <0 0xee000000 0 0xc00>;
 		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SSUSB>;
+		power-domains = <&cpg_clocks>;
 		phys = <&usb2 1>;
 		phy-names = "usb";
 		status = "disabled";
@@ -1345,10 +1412,11 @@
 	pci0: pci@ee090000 {
 		compatible = "renesas,pci-r8a7791";
 		device_type = "pci";
-		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
 		reg = <0 0xee090000 0 0xc00>,
 		      <0 0xee080000 0 0x1100>;
 		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 
 		bus-range = <0 0>;
@@ -1379,10 +1447,11 @@
 	pci1: pci@ee0d0000 {
 		compatible = "renesas,pci-r8a7791";
 		device_type = "pci";
-		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
 		reg = <0 0xee0d0000 0 0xc00>,
 		      <0 0xee0c0000 0 0x1100>;
 		interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 
 		bus-range = <1 1>;
@@ -1432,6 +1501,7 @@
 		interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_PCIEC>, <&pcie_bus_clk>;
 		clock-names = "pcie", "pcie_bus";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
-- 
1.9.1

