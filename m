From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 10/12] ARM: dts: r8a7791: Use SYSC "always-on" PM Domain
Date: Fri, 22 Apr 2016 11:07:32 +0200
Message-ID: <1461316054-27999-11-git-send-email-geert+renesas@glider.be>
References: <1461316054-27999-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:48224 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbcDVJHj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 05:07:39 -0400
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

v5:
  - Add Acked-by,

v4:
  - New.
---
 arch/arm/boot/dts/r8a7791.dtsi | 146 ++++++++++++++++++++---------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index b8657f4b45efdfe5..db67e342c58566fa 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -122,7 +122,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 	};
 
 	gpio1: gpio@e6051000 {
@@ -135,7 +135,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 	};
 
 	gpio2: gpio@e6052000 {
@@ -148,7 +148,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 	};
 
 	gpio3: gpio@e6053000 {
@@ -161,7 +161,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 	};
 
 	gpio4: gpio@e6054000 {
@@ -174,7 +174,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO4>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 	};
 
 	gpio5: gpio@e6055000 {
@@ -187,7 +187,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO5>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 	};
 
 	gpio6: gpio@e6055400 {
@@ -200,7 +200,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO6>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 	};
 
 	gpio7: gpio@e6055800 {
@@ -213,7 +213,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7791_CLK_GPIO7>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 	};
 
 	thermal: thermal@e61f0000 {
@@ -223,7 +223,7 @@
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A7791_CLK_THERMAL>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#thermal-sensor-cells = <0>;
 	};
 
@@ -242,7 +242,7 @@
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_CMT0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 
 		renesas,channels-mask = <0x60>;
 
@@ -262,7 +262,7 @@
 			     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_CMT1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -285,7 +285,7 @@
 			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A7791_CLK_IRQC>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 	};
 
 	dmac0: dma-controller@e6700000 {
@@ -314,7 +314,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7791_CLK_SYS_DMAC0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -345,7 +345,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7791_CLK_SYS_DMAC1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -374,7 +374,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7791_CLK_AUDIO_DMAC0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -403,7 +403,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7791_CLK_AUDIO_DMAC1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -415,7 +415,7 @@
 			      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "ch0", "ch1";
 		clocks = <&mstp3_clks R8A7791_CLK_USBDMAC0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
 	};
@@ -427,7 +427,7 @@
 			      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "ch0", "ch1";
 		clocks = <&mstp3_clks R8A7791_CLK_USBDMAC1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
 	};
@@ -440,7 +440,7 @@
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -452,7 +452,7 @@
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -464,7 +464,7 @@
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -476,7 +476,7 @@
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -488,7 +488,7 @@
 		reg = <0 0xe6520000 0 0x40>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C4>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -501,7 +501,7 @@
 		reg = <0 0xe6528000 0 0x40>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C5>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <110>;
 		status = "disabled";
 	};
@@ -516,7 +516,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_IICDVFS>;
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -529,7 +529,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_IIC0>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -542,7 +542,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_IIC1>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -558,7 +558,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_MMCIF0>;
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		reg-io-width = <4>;
 		status = "disabled";
 		max-frequency = <97500000>;
@@ -571,7 +571,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI0>;
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -582,7 +582,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI1>;
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -593,7 +593,7 @@
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI2>;
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -606,7 +606,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -619,7 +619,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -632,7 +632,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -645,7 +645,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -658,7 +658,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -671,7 +671,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -684,7 +684,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -697,7 +697,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -710,7 +710,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -724,7 +724,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -738,7 +738,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -752,7 +752,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -766,7 +766,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -780,7 +780,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -794,7 +794,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -808,7 +808,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -822,7 +822,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -836,7 +836,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -845,7 +845,7 @@
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_ETHER>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -858,7 +858,7 @@
 		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
 		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_ETHERAVB>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -869,7 +869,7 @@
 		reg = <0 0xee300000 0 0x2000>;
 		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_SATA0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -878,7 +878,7 @@
 		reg = <0 0xee500000 0 0x2000>;
 		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_SATA1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -890,7 +890,7 @@
 		dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
 		       <&usb_dmac1 0>, <&usb_dmac1 1>;
 		dma-names = "ch0", "ch1", "ch2", "ch3";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
@@ -904,7 +904,7 @@
 		#size-cells = <0>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSUSB>;
 		clock-names = "usbhs";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		usb0: usb-channel@0 {
@@ -922,7 +922,7 @@
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_VIN0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -931,7 +931,7 @@
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_VIN1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -940,7 +940,7 @@
 		reg = <0 0xe6ef2000 0 0x1000>;
 		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_VIN2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -949,7 +949,7 @@
 		reg = <0 0xfe928000 0 0x8000>;
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_S>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 
 		renesas,has-lut;
 		renesas,has-sru;
@@ -963,7 +963,7 @@
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -977,7 +977,7 @@
 		reg = <0 0xfe938000 0 0x8000>;
 		interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -1023,7 +1023,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_RCAN0>,
 			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -1034,7 +1034,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_RCAN1>,
 			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -1043,7 +1043,7 @@
 		reg = <0 0xfe980000 0 0x10300>;
 		interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_JPU>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 	};
 
 	clocks {
@@ -1480,7 +1480,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_QSPI_MOD>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1494,7 +1494,7 @@
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1507,7 +1507,7 @@
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF1>;
 		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1520,7 +1520,7 @@
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF2>;
 		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1531,7 +1531,7 @@
 		reg = <0 0xee000000 0 0xc00>;
 		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SSUSB>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		phys = <&usb2 1>;
 		phy-names = "usb";
 		status = "disabled";
@@ -1544,7 +1544,7 @@
 		      <0 0xee080000 0 0x1100>;
 		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		bus-range = <0 0>;
@@ -1579,7 +1579,7 @@
 		      <0 0xee0c0000 0 0x1100>;
 		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		bus-range = <1 1>;
@@ -1629,7 +1629,7 @@
 		interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_PCIEC>, <&pcie_bus_clk>;
 		clock-names = "pcie", "pcie_bus";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -1732,7 +1732,7 @@
 				"mix.0", "mix.1",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 
 		status = "disabled";
 
-- 
1.9.1

