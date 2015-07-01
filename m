From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 10/16] ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain
Date: Wed,  1 Jul 2015 17:58:04 +0200
Message-ID: <1435766290-3005-11-git-send-email-geert+renesas@glider.be>
References: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add an appropriate "#power-domain-cells" property to the cpg_clocks
device node, to create the CPG/MSTP Clock Domain.

Add "power-domains" properties to all device nodes for devices that are
part of the CPG/MSTP Clock Domain and can be power-managed through an
MSTP clock.  This applies to most on-SoC devices, which have a
one-to-one mapping from SoC device to DT device node.  Notable
exceptions are the "display" and "sound" nodes, which represent multiple
SoC devices, each having their own MSTP clocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
v3:
  - Use "CPG/MSTP Clock Domain" instead of "CPG Clock Domain",

v2:
  - Add Reviewed-by,
  - Add "power-domains" properties to recently introduced USB-DMAC
    device nodes,
  - Drop adding "power-domains" properties to the GIC device node, as
    adding the INTC_SYS clock is postponed.
---
 arch/arm/boot/dts/r8a7791.dtsi | 81 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 07ea2bebe4966da0..5560d4d43fc0a857 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -91,6 +91,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO0>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio1: gpio@e6051000 {
@@ -103,6 +104,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO1>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio2: gpio@e6052000 {
@@ -115,6 +117,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO2>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio3: gpio@e6053000 {
@@ -127,6 +130,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO3>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio4: gpio@e6054000 {
@@ -139,6 +143,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO4>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio5: gpio@e6055000 {
@@ -151,6 +156,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO5>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio6: gpio@e6055400 {
@@ -163,6 +169,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO6>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio7: gpio@e6055800 {
@@ -175,6 +182,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO7>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	thermal@e61f0000 {
@@ -182,6 +190,7 @@
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A7791_CLK_THERMAL>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	timer {
@@ -199,6 +208,7 @@
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_CMT0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		renesas,channels-mask = <0x60>;
 
@@ -218,6 +228,7 @@
 			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_CMT1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -240,6 +251,7 @@
 			     <0 16 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A7791_CLK_IRQC>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	dmac0: dma-controller@e6700000 {
@@ -268,6 +280,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7791_CLK_SYS_DMAC0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -298,6 +311,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7791_CLK_SYS_DMAC1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -326,6 +340,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7791_CLK_AUDIO_DMAC0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -354,6 +369,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7791_CLK_AUDIO_DMAC1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -365,6 +381,7 @@
 			      0 109 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "ch0", "ch1";
 		clocks = <&mstp3_clks R8A7791_CLK_USBDMAC0>;
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
 	};
@@ -376,6 +393,7 @@
 			      0 110 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "ch0", "ch1";
 		clocks = <&mstp3_clks R8A7791_CLK_USBDMAC1>;
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
 	};
@@ -388,6 +406,7 @@
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -398,6 +417,7 @@
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -408,6 +428,7 @@
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -418,6 +439,7 @@
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C3>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -428,6 +450,7 @@
 		reg = <0 0xe6520000 0 0x40>;
 		interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C4>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -439,6 +462,7 @@
 		reg = <0 0xe6528000 0 0x40>;
 		interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C5>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -452,6 +476,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_IICDVFS>;
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -464,6 +489,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_IIC0>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -476,6 +502,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_IIC1>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -492,6 +519,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_MMCIF0>;
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		reg-io-width = <4>;
 		status = "disabled";
 		max-frequency = <97500000>;
@@ -504,6 +532,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI0>;
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -514,6 +543,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI1>;
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -524,6 +554,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI2>;
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -535,6 +566,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -546,6 +578,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -557,6 +590,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -568,6 +602,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -579,6 +614,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -590,6 +626,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -601,6 +638,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -612,6 +650,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -623,6 +662,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -634,6 +674,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -645,6 +686,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -656,6 +698,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -667,6 +710,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -678,6 +722,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -689,6 +734,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -700,6 +746,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -711,6 +758,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -722,6 +770,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -730,6 +779,7 @@
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_ETHER>;
+		power-domains = <&cpg_clocks>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -741,6 +791,7 @@
 		reg = <0 0xee300000 0 0x2000>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_SATA0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -749,6 +800,7 @@
 		reg = <0 0xee500000 0 0x2000>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_SATA1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -757,6 +809,7 @@
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSUSB>;
+		power-domains = <&cpg_clocks>;
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
@@ -773,6 +826,7 @@
 		#size-cells = <0>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSUSB>;
 		clock-names = "usbhs";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 
 		usb0: usb-channel@0 {
@@ -787,25 +841,28 @@
 
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
 
@@ -814,6 +871,7 @@
 		reg = <0 0xfe928000 0 0x8000>;
 		interrupts = <0 267 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_S>;
+		power-domains = <&cpg_clocks>;
 
 		renesas,has-lut;
 		renesas,has-sru;
@@ -827,6 +885,7 @@
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <0 246 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU0>;
+		power-domains = <&cpg_clocks>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -840,6 +899,7 @@
 		reg = <0 0xfe938000 0 0x8000>;
 		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU1>;
+		power-domains = <&cpg_clocks>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -885,6 +945,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_RCAN0>,
 			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -895,6 +956,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_RCAN1>,
 			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -972,6 +1034,7 @@
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "z",
 					     "rcan", "adsp";
+			#power-domain-cells = <0>;
 		};
 
 		/* Variable factor clocks */
@@ -1351,6 +1414,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_QSPI_MOD>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1364,6 +1428,7 @@
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1376,6 +1441,7 @@
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF1>;
 		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1388,6 +1454,7 @@
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF2>;
 		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1398,6 +1465,7 @@
 		reg = <0 0xee000000 0 0xc00>;
 		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SSUSB>;
+		power-domains = <&cpg_clocks>;
 		phys = <&usb2 1>;
 		phy-names = "usb";
 		status = "disabled";
@@ -1406,10 +1474,11 @@
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
@@ -1440,10 +1509,11 @@
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
@@ -1493,6 +1563,7 @@
 		interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_PCIEC>, <&pcie_bus_clk>;
 		clock-names = "pcie", "pcie_bus";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
-- 
1.9.1
