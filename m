From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v5 08/12] ARM: dts: r8a7790: Use SYSC "always-on" PM Domain
Date: Wed, 13 Apr 2016 16:44:48 +0200
Message-ID: <1460558692-10414-9-git-send-email-geert+renesas@glider.be>
References: <1460558692-10414-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460558692-10414-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hook up all devices that are part of the CPG/MSTP Clock Domain to the
SYSC "always-on" PM Domain, for a more consistent device-power-area
description in DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
v5:
  - Add Acked-by,

v4:
  - New.
---
 arch/arm/boot/dts/r8a7790.dtsi | 138 ++++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 1a3b6b08f1f3c90c..9b1b8af1cb9f5f4b 100644
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
@@ -520,7 +520,7 @@
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>,
 		       <&dmac1 0x61>, <&dmac1 0x62>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -534,7 +534,7 @@
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>,
 		       <&dmac1 0x65>, <&dmac1 0x66>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -548,7 +548,7 @@
 		dmas = <&dmac0 0x69>, <&dmac0 0x6a>,
 		       <&dmac1 0x69>, <&dmac1 0x6a>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -562,7 +562,7 @@
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>,
 		       <&dmac1 0x77>, <&dmac1 0x78>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -574,7 +574,7 @@
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
 		       <&dmac1 0xd1>, <&dmac1 0xd2>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		reg-io-width = <4>;
 		status = "disabled";
 		max-frequency = <97500000>;
@@ -588,7 +588,7 @@
 		dmas = <&dmac0 0xe1>, <&dmac0 0xe2>,
 		       <&dmac1 0xe1>, <&dmac1 0xe2>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		reg-io-width = <4>;
 		status = "disabled";
 		max-frequency = <97500000>;
@@ -608,7 +608,7 @@
 		       <&dmac0 0xcd>, <&dmac0 0xce>;
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <156000000>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -621,7 +621,7 @@
 		       <&dmac0 0xc9>, <&dmac0 0xca>;
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <156000000>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -634,7 +634,7 @@
 		       <&dmac0 0xc1>, <&dmac0 0xc2>;
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <97500000>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -647,7 +647,7 @@
 		       <&dmac0 0xd3>, <&dmac0 0xd4>;
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <97500000>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -661,7 +661,7 @@
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>,
 		       <&dmac1 0x21>, <&dmac1 0x22>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -675,7 +675,7 @@
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>,
 		       <&dmac1 0x25>, <&dmac1 0x26>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -689,7 +689,7 @@
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>,
 		       <&dmac1 0x27>, <&dmac1 0x28>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -703,7 +703,7 @@
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
 		       <&dmac1 0x3d>, <&dmac1 0x3e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -717,7 +717,7 @@
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
 		       <&dmac1 0x19>, <&dmac1 0x1a>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -731,7 +731,7 @@
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
 		       <&dmac1 0x1d>, <&dmac1 0x1e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -746,7 +746,7 @@
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
 		       <&dmac1 0x29>, <&dmac1 0x2a>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -761,7 +761,7 @@
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
 		       <&dmac1 0x2d>, <&dmac1 0x2e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -776,7 +776,7 @@
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
 		       <&dmac1 0x2b>, <&dmac1 0x2c>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -791,7 +791,7 @@
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
 		       <&dmac1 0x39>, <&dmac1 0x3a>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -806,7 +806,7 @@
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
 		       <&dmac1 0x4d>, <&dmac1 0x4e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -815,7 +815,7 @@
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_ETHER>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -828,7 +828,7 @@
 		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
 		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_ETHERAVB>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -839,7 +839,7 @@
 		reg = <0 0xee300000 0 0x2000>;
 		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_SATA0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -848,7 +848,7 @@
 		reg = <0 0xee500000 0 0x2000>;
 		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_SATA1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -860,7 +860,7 @@
 		dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
 		       <&usb_dmac1 0>, <&usb_dmac1 1>;
 		dma-names = "ch0", "ch1", "ch2", "ch3";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
@@ -874,7 +874,7 @@
 		#size-cells = <0>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
 		clock-names = "usbhs";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		usb0: usb-channel@0 {
@@ -892,7 +892,7 @@
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_VIN0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -901,7 +901,7 @@
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_VIN1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -910,7 +910,7 @@
 		reg = <0 0xe6ef2000 0 0x1000>;
 		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_VIN2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -919,7 +919,7 @@
 		reg = <0 0xe6ef3000 0 0x1000>;
 		interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_VIN3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -928,7 +928,7 @@
 		reg = <0 0xfe920000 0 0x8000>;
 		interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_R>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 
 		renesas,has-sru;
 		renesas,#rpf = <5>;
@@ -941,7 +941,7 @@
 		reg = <0 0xfe928000 0 0x8000>;
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_S>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 
 		renesas,has-lut;
 		renesas,has-sru;
@@ -955,7 +955,7 @@
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -969,7 +969,7 @@
 		reg = <0 0xfe938000 0 0x8000>;
 		interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -1024,7 +1024,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_RCAN0>,
 			 <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -1035,7 +1035,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_RCAN1>,
 			 <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -1044,7 +1044,7 @@
 		reg = <0 0xfe980000 0 0x10300>;
 		interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_JPU>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 	};
 
 	clocks {
@@ -1496,7 +1496,7 @@
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>,
 		       <&dmac1 0x17>, <&dmac1 0x18>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1511,7 +1511,7 @@
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>,
 		       <&dmac1 0x51>, <&dmac1 0x52>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1525,7 +1525,7 @@
 		dmas = <&dmac0 0x55>, <&dmac0 0x56>,
 		       <&dmac1 0x55>, <&dmac1 0x56>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1539,7 +1539,7 @@
 		dmas = <&dmac0 0x41>, <&dmac0 0x42>,
 		       <&dmac1 0x41>, <&dmac1 0x42>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1553,7 +1553,7 @@
 		dmas = <&dmac0 0x45>, <&dmac0 0x46>,
 		       <&dmac1 0x45>, <&dmac1 0x46>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1564,7 +1564,7 @@
 		reg = <0 0xee000000 0 0xc00>;
 		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SSUSB>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		phys = <&usb2 1>;
 		phy-names = "usb";
 		status = "disabled";
@@ -1577,7 +1577,7 @@
 		      <0 0xee080000 0 0x1100>;
 		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		bus-range = <0 0>;
@@ -1612,7 +1612,7 @@
 		      <0 0xee0a0000 0 0x1100>;
 		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		bus-range = <1 1>;
@@ -1630,7 +1630,7 @@
 		compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
 		device_type = "pci";
 		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		reg = <0 0xee0d0000 0 0xc00>,
 		      <0 0xee0c0000 0 0x1100>;
 		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
@@ -1683,7 +1683,7 @@
 		interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_PCIEC>, <&pcie_bus_clk>;
 		clock-names = "pcie", "pcie_bus";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -1726,7 +1726,7 @@
 				"mix.0", "mix.1",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 
 		status = "disabled";
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
