From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 12/12] ARM: dts: r8a7794: Use SYSC "always-on" PM Domain
Date: Fri, 22 Apr 2016 11:07:34 +0200
Message-ID: <1461316054-27999-13-git-send-email-geert+renesas@glider.be>
References: <1461316054-27999-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:48231 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101AbcDVJHj (ORCPT
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
 arch/arm/boot/dts/r8a7794.dtsi | 106 ++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 70eff80a813ec85a..136911c1dc74441c 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -86,7 +86,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7794_CLK_GPIO0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
 	gpio1: gpio@e6051000 {
@@ -99,7 +99,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7794_CLK_GPIO1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
 	gpio2: gpio@e6052000 {
@@ -112,7 +112,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7794_CLK_GPIO2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
 	gpio3: gpio@e6053000 {
@@ -125,7 +125,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7794_CLK_GPIO3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
 	gpio4: gpio@e6054000 {
@@ -138,7 +138,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7794_CLK_GPIO4>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
 	gpio5: gpio@e6055000 {
@@ -151,7 +151,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7794_CLK_GPIO5>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
 	gpio6: gpio@e6055400 {
@@ -164,7 +164,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7794_CLK_GPIO6>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
 	cmt0: timer@ffca0000 {
@@ -174,7 +174,7 @@
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7794_CLK_CMT0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 
 		renesas,channels-mask = <0x60>;
 
@@ -194,7 +194,7 @@
 			     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_CMT1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -225,7 +225,7 @@
 			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A7794_CLK_IRQC>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 	};
 
 	pfc: pin-controller@e6060000 {
@@ -259,7 +259,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7794_CLK_SYS_DMAC0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -290,7 +290,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7794_CLK_SYS_DMAC1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -304,7 +304,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -317,7 +317,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -330,7 +330,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -343,7 +343,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -356,7 +356,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -369,7 +369,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -382,7 +382,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -395,7 +395,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -408,7 +408,7 @@
 		clock-names = "fck";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -422,7 +422,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -436,7 +436,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -450,7 +450,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -464,7 +464,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -478,7 +478,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -492,7 +492,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -506,7 +506,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -520,7 +520,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -534,7 +534,7 @@
 		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -543,7 +543,7 @@
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_ETHER>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -556,7 +556,7 @@
 		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
 		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_ETHERAVB>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -568,7 +568,7 @@
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -580,7 +580,7 @@
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -592,7 +592,7 @@
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -604,7 +604,7 @@
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -616,7 +616,7 @@
 		reg = <0 0xe6520000 0 0x40>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C4>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -628,7 +628,7 @@
 		reg = <0 0xe6528000 0 0x40>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C5>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -642,7 +642,7 @@
 		clocks = <&mstp3_clks R8A7794_CLK_IIC0>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -655,7 +655,7 @@
 		clocks = <&mstp3_clks R8A7794_CLK_IIC1>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -668,7 +668,7 @@
 		clocks = <&mstp3_clks R8A7794_CLK_MMCIF0>;
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -678,7 +678,7 @@
 		reg = <0 0xee100000 0 0x200>;
 		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -687,7 +687,7 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -696,7 +696,7 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -707,7 +707,7 @@
 		clocks = <&mstp9_clks R8A7794_CLK_QSPI_MOD>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -719,7 +719,7 @@
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_VIN0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -728,7 +728,7 @@
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_VIN1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -739,7 +739,7 @@
 		      <0 0xee080000 0 0x1100>;
 		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_EHCI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		bus-range = <0 0>;
@@ -774,7 +774,7 @@
 		      <0 0xee0c0000 0 0x1100>;
 		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_EHCI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		bus-range = <1 1>;
@@ -807,7 +807,7 @@
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSUSB>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
@@ -821,7 +821,7 @@
 		#size-cells = <0>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSUSB>;
 		clock-names = "usbhs";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		usb0: usb-channel@0 {
@@ -869,7 +869,7 @@
 		clocks = <&mstp9_clks R8A7794_CLK_RCAN0>,
 			 <&cpg_clocks R8A7794_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -880,7 +880,7 @@
 		clocks = <&mstp9_clks R8A7794_CLK_RCAN1>,
 			 <&cpg_clocks R8A7794_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
-- 
1.9.1

