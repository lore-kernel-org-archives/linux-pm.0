From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 11/12] ARM: dts: r8a7794: Use SYSC "always-on" PM Domain
Date: Wed, 13 Apr 2016 16:44:51 +0200
Message-ID: <1460558692-10414-12-git-send-email-geert+renesas@glider.be>
References: <1460558692-10414-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:55650 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933471AbcDMOos (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2016 10:44:48 -0400
In-Reply-To: <1460558692-10414-1-git-send-email-geert+renesas@glider.be>
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
v5:
  - Add Acked-by,

v4:
  - New.
---
 arch/arm/boot/dts/r8a7794.dtsi | 106 ++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 99c41c9099b0c233..3ed50640df1d63f5 100644
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
@@ -305,7 +305,7 @@
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>,
 		       <&dmac1 0x21>, <&dmac1 0x22>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -319,7 +319,7 @@
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>,
 		       <&dmac1 0x25>, <&dmac1 0x26>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -333,7 +333,7 @@
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>,
 		       <&dmac1 0x27>, <&dmac1 0x28>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -347,7 +347,7 @@
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>,
 		       <&dmac1 0x1b>, <&dmac1 0x1c>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -361,7 +361,7 @@
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>,
 		       <&dmac1 0x1f>, <&dmac1 0x20>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -375,7 +375,7 @@
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>,
 		       <&dmac1 0x23>, <&dmac1 0x24>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -389,7 +389,7 @@
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
 		       <&dmac1 0x3d>, <&dmac1 0x3e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -403,7 +403,7 @@
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
 		       <&dmac1 0x19>, <&dmac1 0x1a>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -417,7 +417,7 @@
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
 		       <&dmac1 0x1d>, <&dmac1 0x1e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -432,7 +432,7 @@
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
 		       <&dmac1 0x29>, <&dmac1 0x2a>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -447,7 +447,7 @@
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
 		       <&dmac1 0x2d>, <&dmac1 0x2e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -462,7 +462,7 @@
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
 		       <&dmac1 0x2b>, <&dmac1 0x2c>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -477,7 +477,7 @@
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
 		       <&dmac1 0x2f>, <&dmac1 0x30>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -492,7 +492,7 @@
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>,
 		       <&dmac1 0xfb>, <&dmac1 0xfc>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -507,7 +507,7 @@
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>,
 		       <&dmac1 0xfd>, <&dmac1 0xfe>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -522,7 +522,7 @@
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
 		       <&dmac1 0x39>, <&dmac1 0x3a>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -537,7 +537,7 @@
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
 		       <&dmac1 0x4d>, <&dmac1 0x4e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -552,7 +552,7 @@
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>,
 		       <&dmac1 0x3b>, <&dmac1 0x3c>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -561,7 +561,7 @@
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_ETHER>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -574,7 +574,7 @@
 		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
 		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_ETHERAVB>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -586,7 +586,7 @@
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -598,7 +598,7 @@
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -610,7 +610,7 @@
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -622,7 +622,7 @@
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -634,7 +634,7 @@
 		reg = <0 0xe6520000 0 0x40>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C4>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -646,7 +646,7 @@
 		reg = <0 0xe6528000 0 0x40>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C5>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -660,7 +660,7 @@
 		clocks = <&mstp3_clks R8A7794_CLK_IIC0>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -673,7 +673,7 @@
 		clocks = <&mstp3_clks R8A7794_CLK_IIC1>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
 		dma-names = "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -687,7 +687,7 @@
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
 		       <&dmac1 0xd1>, <&dmac1 0xd2>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -700,7 +700,7 @@
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>,
 		       <&dmac0 0xcd>, <&dmac0 0xce>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -712,7 +712,7 @@
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>,
 		       <&dmac0 0xc1>, <&dmac0 0xc2>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -724,7 +724,7 @@
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>,
 		       <&dmac0 0xd3>, <&dmac0 0xd4>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -736,7 +736,7 @@
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>,
 		       <&dmac1 0x17>, <&dmac1 0x18>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -748,7 +748,7 @@
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_VIN0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -757,7 +757,7 @@
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_VIN1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -768,7 +768,7 @@
 		      <0 0xee080000 0 0x1100>;
 		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_EHCI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		bus-range = <0 0>;
@@ -803,7 +803,7 @@
 		      <0 0xee0c0000 0 0x1100>;
 		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_EHCI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		bus-range = <1 1>;
@@ -836,7 +836,7 @@
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSUSB>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
@@ -850,7 +850,7 @@
 		#size-cells = <0>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSUSB>;
 		clock-names = "usbhs";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		usb0: usb-channel@0 {
@@ -898,7 +898,7 @@
 		clocks = <&mstp9_clks R8A7794_CLK_RCAN0>,
 			 <&cpg_clocks R8A7794_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -909,7 +909,7 @@
 		clocks = <&mstp9_clks R8A7794_CLK_RCAN1>,
 			 <&cpg_clocks R8A7794_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
-- 
1.9.1

