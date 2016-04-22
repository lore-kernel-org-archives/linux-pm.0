From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 09/12] ARM: dts: r8a7790: Use SYSC "always-on" PM Domain
Date: Fri, 22 Apr 2016 11:07:31 +0200
Message-ID: <1461316054-27999-10-git-send-email-geert+renesas@glider.be>
References: <1461316054-27999-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461316054-27999-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Hook up all devices that are part of the CPG/MSTP Clock Domain to the
SYSC "always-on" PM Domain, for a more consistent device-power-area
description in DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v6:
  - Rebased,

v5:
  - Add Acked-by,

v4:
  - New.
---
 arch/arm/boot/dts/r8a7790.dtsi | 138 ++++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 36c91d921771336a..dc8497b1558677ea 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -184,7 +184,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
 	gpio1: gpio@e6051000 {
@@ -197,7 +197,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
 	gpio2: gpio@e6052000 {
@@ -210,7 +210,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
 	gpio3: gpio@e6053000 {
@@ -223,7 +223,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
 	gpio4: gpio@e6054000 {
@@ -236,7 +236,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO4>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
 	gpio5: gpio@e6055000 {
@@ -249,7 +249,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7790_CLK_GPIO5>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
 	thermal: thermal@e61f0000 {
@@ -259,7 +259,7 @@
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#thermal-sensor-cells = <0>;
 	};
 
@@ -278,7 +278,7 @@
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_CMT0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 
 		renesas,channels-mask = <0x60>;
 
@@ -298,7 +298,7 @@
 			     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_CMT1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -315,7 +315,7 @@
 			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A7790_CLK_IRQC>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
 	dmac0: dma-controller@e6700000 {
@@ -344,7 +344,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -375,7 +375,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -404,7 +404,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7790_CLK_AUDIO_DMAC0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -433,7 +433,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7790_CLK_AUDIO_DMAC1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -445,7 +445,7 @@
 			      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "ch0", "ch1";
 		clocks = <&mstp3_clks R8A7790_CLK_USBDMAC0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
 	};
@@ -457,7 +457,7 @@
 			      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "ch0", "ch1";
 		clocks = <&mstp3_clks R8A7790_CLK_USBDMAC1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
 	};
@@ -469,7 +469,7 @@
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <110>;
 		status = "disabled";
 	};
@@ -481,7 +481,7 @@
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -493,7 +493,7 @@
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -505,7 +505,7 @@
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <110>;
 		status = "disabled";
 	};
@@ -519,7 +519,7 @@
 		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -532,7 +532,7 @@
 		clocks = <&mstp3_clks R8A7790_CLK_IIC1>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -545,7 +545,7 @@
 		clocks = <&mstp3_clks R8A7790_CLK_IIC2>;
 		dmas = <&dmac0 0x69>, <&dmac0 0x6a>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -558,7 +558,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_IICDVFS>;
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -569,7 +569,7 @@
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF0>;
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		reg-io-width = <4>;
 		status = "disabled";
 		max-frequency = <97500000>;
@@ -582,7 +582,7 @@
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
 		dmas = <&dmac0 0xe1>, <&dmac0 0xe2>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		reg-io-width = <4>;
 		status = "disabled";
 		max-frequency = <97500000>;
@@ -601,7 +601,7 @@
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx";
 		max-frequency = <195000000>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -613,7 +613,7 @@
 		dmas = <&dmac1 0xc9>, <&dmac1 0xca>;
 		dma-names = "tx", "rx";
 		max-frequency = <195000000>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -625,7 +625,7 @@
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx";
 		max-frequency = <97500000>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -637,7 +637,7 @@
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx";
 		max-frequency = <97500000>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -650,7 +650,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -663,7 +663,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -676,7 +676,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -689,7 +689,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -702,7 +702,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -715,7 +715,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -729,7 +729,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -743,7 +743,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -757,7 +757,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -771,7 +771,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -785,7 +785,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -794,7 +794,7 @@
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_ETHER>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -807,7 +807,7 @@
 		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
 		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_ETHERAVB>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -818,7 +818,7 @@
 		reg = <0 0xee300000 0 0x2000>;
 		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_SATA0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -827,7 +827,7 @@
 		reg = <0 0xee500000 0 0x2000>;
 		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_SATA1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -839,7 +839,7 @@
 		dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
 		       <&usb_dmac1 0>, <&usb_dmac1 1>;
 		dma-names = "ch0", "ch1", "ch2", "ch3";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
@@ -853,7 +853,7 @@
 		#size-cells = <0>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
 		clock-names = "usbhs";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		usb0: usb-channel@0 {
@@ -871,7 +871,7 @@
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_VIN0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -880,7 +880,7 @@
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_VIN1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -889,7 +889,7 @@
 		reg = <0 0xe6ef2000 0 0x1000>;
 		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_VIN2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -898,7 +898,7 @@
 		reg = <0 0xe6ef3000 0 0x1000>;
 		interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_VIN3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -907,7 +907,7 @@
 		reg = <0 0xfe920000 0 0x8000>;
 		interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_R>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 
 		renesas,has-sru;
 		renesas,#rpf = <5>;
@@ -920,7 +920,7 @@
 		reg = <0 0xfe928000 0 0x8000>;
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_S>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 
 		renesas,has-lut;
 		renesas,has-sru;
@@ -934,7 +934,7 @@
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -948,7 +948,7 @@
 		reg = <0 0xfe938000 0 0x8000>;
 		interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -1003,7 +1003,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_RCAN0>,
 			 <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -1014,7 +1014,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_RCAN1>,
 			 <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -1023,7 +1023,7 @@
 		reg = <0 0xfe980000 0 0x10300>;
 		interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_JPU>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
 	clocks {
@@ -1474,7 +1474,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_QSPI_MOD>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1488,7 +1488,7 @@
 		clocks = <&mstp0_clks R8A7790_CLK_MSIOF0>;
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1501,7 +1501,7 @@
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF1>;
 		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1514,7 +1514,7 @@
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF2>;
 		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1527,7 +1527,7 @@
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF3>;
 		dmas = <&dmac0 0x45>, <&dmac0 0x46>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1538,7 +1538,7 @@
 		reg = <0 0xee000000 0 0xc00>;
 		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SSUSB>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		phys = <&usb2 1>;
 		phy-names = "usb";
 		status = "disabled";
@@ -1551,7 +1551,7 @@
 		      <0 0xee080000 0 0x1100>;
 		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		bus-range = <0 0>;
@@ -1586,7 +1586,7 @@
 		      <0 0xee0a0000 0 0x1100>;
 		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		bus-range = <1 1>;
@@ -1604,7 +1604,7 @@
 		compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
 		device_type = "pci";
 		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		reg = <0 0xee0d0000 0 0xc00>,
 		      <0 0xee0c0000 0 0x1100>;
 		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
@@ -1657,7 +1657,7 @@
 		interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_PCIEC>, <&pcie_bus_clk>;
 		clock-names = "pcie", "pcie_bus";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -1700,7 +1700,7 @@
 				"mix.0", "mix.1",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 
 		status = "disabled";
 
-- 
1.9.1
