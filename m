From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 2/5] ARM: shmobile: r8a7790 dtsi: Add CPG Clock Domain
Date: Wed, 18 Mar 2015 20:46:54 +0100
Message-ID: <1426708017-28885-3-git-send-email-geert+renesas@glider.be>
References: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

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
 arch/arm/boot/dts/r8a7790.dtsi | 77 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index d4210f5b692a42b5..3c1f3b27dfdf506f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -123,6 +123,7 @@
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		clocks = <&mstp4_clks R8A7790_CLK_INTC_SYS>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio0: gpio@e6050000 {
@@ -135,6 +136,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO0>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio1: gpio@e6051000 {
@@ -147,6 +149,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO1>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio2: gpio@e6052000 {
@@ -159,6 +162,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO2>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio3: gpio@e6053000 {
@@ -171,6 +175,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO3>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio4: gpio@e6054000 {
@@ -183,6 +188,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO4>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	gpio5: gpio@e6055000 {
@@ -195,6 +201,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO5>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	thermal@e61f0000 {
@@ -202,6 +209,7 @@
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	timer {
@@ -219,6 +227,7 @@
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_CMT0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		renesas,channels-mask = <0x60>;
 
@@ -238,6 +247,7 @@
 			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_CMT1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -254,6 +264,7 @@
 			     <0 2 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 3 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A7790_CLK_IRQC>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	dmac0: dma-controller@e6700000 {
@@ -282,6 +293,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -312,6 +324,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -340,6 +353,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7790_CLK_AUDIO_DMAC0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -368,6 +382,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7790_CLK_AUDIO_DMAC1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -379,6 +394,7 @@
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -389,6 +405,7 @@
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -399,6 +416,7 @@
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -409,6 +427,7 @@
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C3>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -419,6 +438,7 @@
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -431,6 +451,7 @@
 		reg = <0 0xe6510000 0 0x425>;
 		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC1>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -443,6 +464,7 @@
 		reg = <0 0xe6520000 0 0x425>;
 		interrupts = <0 176 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC2>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac0 0x69>, <&dmac0 0x6a>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -455,6 +477,7 @@
 		reg = <0 0xe60b0000 0 0x425>;
 		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_IICDVFS>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -465,6 +488,7 @@
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF0>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
 		dma-names = "tx", "rx";
 		reg-io-width = <4>;
@@ -476,6 +500,7 @@
 		reg = <0 0xee220000 0 0x80>;
 		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac0 0xe1>, <&dmac0 0xe2>;
 		dma-names = "tx", "rx";
 		reg-io-width = <4>;
@@ -492,6 +517,7 @@
 		reg = <0 0xee100000 0 0x328>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -502,6 +528,7 @@
 		reg = <0 0xee120000 0 0x328>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac1 0xc9>, <&dmac1 0xca>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -512,6 +539,7 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -522,6 +550,7 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
+		power-domains = <&cpg_clocks>;
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx";
 		status = "disabled";
@@ -533,6 +562,7 @@
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -542,6 +572,7 @@
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA1>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -551,6 +582,7 @@
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA2>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -560,6 +592,7 @@
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB0>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -569,6 +602,7 @@
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB1>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -578,6 +612,7 @@
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB2>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -587,6 +622,7 @@
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_SCIF0>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -596,6 +632,7 @@
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_SCIF1>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -605,6 +642,7 @@
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSCIF0>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -614,6 +652,7 @@
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSCIF1>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -622,6 +661,7 @@
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_ETHER>;
+		power-domains = <&cpg_clocks>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -633,6 +673,7 @@
 		reg = <0 0xee300000 0 0x2000>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_SATA0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -641,6 +682,7 @@
 		reg = <0 0xee500000 0 0x2000>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_SATA1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -649,6 +691,7 @@
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
+		power-domains = <&cpg_clocks>;
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
@@ -662,6 +705,7 @@
 		#size-cells = <0>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
 		clock-names = "usbhs";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 
 		usb0: usb-channel@0 {
@@ -676,33 +720,37 @@
 
 	vin0: video@e6ef0000 {
 		compatible = "renesas,vin-r8a7790";
-		clocks = <&mstp8_clks R8A7790_CLK_VIN0>;
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <0 188 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7790_CLK_VIN0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
 	vin1: video@e6ef1000 {
 		compatible = "renesas,vin-r8a7790";
-		clocks = <&mstp8_clks R8A7790_CLK_VIN1>;
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <0 189 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7790_CLK_VIN1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
 	vin2: video@e6ef2000 {
 		compatible = "renesas,vin-r8a7790";
-		clocks = <&mstp8_clks R8A7790_CLK_VIN2>;
 		reg = <0 0xe6ef2000 0 0x1000>;
 		interrupts = <0 190 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7790_CLK_VIN2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
 	vin3: video@e6ef3000 {
 		compatible = "renesas,vin-r8a7790";
-		clocks = <&mstp8_clks R8A7790_CLK_VIN3>;
 		reg = <0 0xe6ef3000 0 0x1000>;
 		interrupts = <0 191 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7790_CLK_VIN3>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -711,6 +759,7 @@
 		reg = <0 0xfe920000 0 0x8000>;
 		interrupts = <0 266 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_R>;
+		power-domains = <&cpg_clocks>;
 
 		renesas,has-sru;
 		renesas,#rpf = <5>;
@@ -723,6 +772,7 @@
 		reg = <0 0xfe928000 0 0x8000>;
 		interrupts = <0 267 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_S>;
+		power-domains = <&cpg_clocks>;
 
 		renesas,has-lut;
 		renesas,has-sru;
@@ -736,6 +786,7 @@
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <0 246 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU0>;
+		power-domains = <&cpg_clocks>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -749,6 +800,7 @@
 		reg = <0 0xfe938000 0 0x8000>;
 		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU1>;
+		power-domains = <&cpg_clocks>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -803,6 +855,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_RCAN0>,
 			 <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -813,6 +866,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_RCAN1>,
 			 <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -890,6 +944,7 @@
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "sd1",
 					     "z", "rcan", "adsp";
+			#power-domain-cells = <0>;
 		};
 
 		/* Variable factor clocks */
@@ -1275,6 +1330,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_QSPI_MOD>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1288,6 +1344,7 @@
 		clocks = <&mstp0_clks R8A7790_CLK_MSIOF0>;
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1300,6 +1357,7 @@
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF1>;
 		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1312,6 +1370,7 @@
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF2>;
 		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1324,6 +1383,7 @@
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF3>;
 		dmas = <&dmac0 0x45>, <&dmac0 0x46>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1334,6 +1394,7 @@
 		reg = <0 0xee000000 0 0xc00>;
 		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SSUSB>;
+		power-domains = <&cpg_clocks>;
 		phys = <&usb2 1>;
 		phy-names = "usb";
 		status = "disabled";
@@ -1342,10 +1403,11 @@
 	pci0: pci@ee090000 {
 		compatible = "renesas,pci-r8a7790";
 		device_type = "pci";
-		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
 		reg = <0 0xee090000 0 0xc00>,
 		      <0 0xee080000 0 0x1100>;
 		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 
 		bus-range = <0 0>;
@@ -1376,10 +1438,11 @@
 	pci1: pci@ee0b0000 {
 		compatible = "renesas,pci-r8a7790";
 		device_type = "pci";
-		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
 		reg = <0 0xee0b0000 0 0xc00>,
 		      <0 0xee0a0000 0 0x1100>;
 		interrupts = <0 112 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 
 		bus-range = <1 1>;
@@ -1397,6 +1460,7 @@
 		compatible = "renesas,pci-r8a7790";
 		device_type = "pci";
 		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		power-domains = <&cpg_clocks>;
 		reg = <0 0xee0d0000 0 0xc00>,
 		      <0 0xee0c0000 0 0x1100>;
 		interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
@@ -1449,6 +1513,7 @@
 		interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_PCIEC>, <&pcie_bus_clk>;
 		clock-names = "pcie", "pcie_bus";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
-- 
1.9.1

