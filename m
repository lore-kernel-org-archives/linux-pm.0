From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v5 09/12] ARM: dts: r8a7791: Use SYSC "always-on" PM Domain
Date: Wed, 13 Apr 2016 16:44:49 +0200
Message-ID: <1460558692-10414-10-git-send-email-geert+renesas@glider.be>
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
 arch/arm/boot/dts/r8a7791.dtsi | 146 ++++++++++++++++++++---------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index cffd7f49c01fb7a1..3f962299ae6212f3 100644
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
@@ -517,7 +517,7 @@
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>,
 		       <&dmac1 0x77>, <&dmac1 0x78>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -531,7 +531,7 @@
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>,
 		       <&dmac1 0x61>, <&dmac1 0x62>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -545,7 +545,7 @@
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>,
 		       <&dmac1 0x65>, <&dmac1 0x66>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -562,7 +562,7 @@
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
 		       <&dmac1 0xd1>, <&dmac1 0xd2>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		reg-io-width = <4>;
 		status = "disabled";
 		max-frequency = <97500000>;
@@ -576,7 +576,7 @@
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>,
 		       <&dmac0 0xcd>, <&dmac0 0xce>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -588,7 +588,7 @@
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>,
 		       <&dmac0 0xc1>, <&dmac0 0xc2>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -600,7 +600,7 @@
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>,
 		       <&dmac0 0xd3>, <&dmac0 0xd4>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -614,7 +614,7 @@
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>,
 		       <&dmac1 0x21>, <&dmac1 0x22>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -628,7 +628,7 @@
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>,
 		       <&dmac1 0x25>, <&dmac1 0x26>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -642,7 +642,7 @@
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>,
 		       <&dmac1 0x27>, <&dmac1 0x28>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -656,7 +656,7 @@
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>,
 		       <&dmac1 0x1b>, <&dmac1 0x1c>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -670,7 +670,7 @@
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>,
 		       <&dmac1 0x1f>, <&dmac1 0x20>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -684,7 +684,7 @@
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>,
 		       <&dmac1 0x23>, <&dmac1 0x24>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -698,7 +698,7 @@
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
 		       <&dmac1 0x3d>, <&dmac1 0x3e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -712,7 +712,7 @@
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
 		       <&dmac1 0x19>, <&dmac1 0x1a>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -726,7 +726,7 @@
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
 		       <&dmac1 0x1d>, <&dmac1 0x1e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -741,7 +741,7 @@
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
 		       <&dmac1 0x29>, <&dmac1 0x2a>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -756,7 +756,7 @@
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
 		       <&dmac1 0x2d>, <&dmac1 0x2e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -771,7 +771,7 @@
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
 		       <&dmac1 0x2b>, <&dmac1 0x2c>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -786,7 +786,7 @@
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
 		       <&dmac1 0x2f>, <&dmac1 0x30>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -801,7 +801,7 @@
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>,
 		       <&dmac1 0xfb>, <&dmac1 0xfc>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -816,7 +816,7 @@
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>,
 		       <&dmac1 0xfd>, <&dmac1 0xfe>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -831,7 +831,7 @@
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
 		       <&dmac1 0x39>, <&dmac1 0x3a>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -846,7 +846,7 @@
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
 		       <&dmac1 0x4d>, <&dmac1 0x4e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -861,7 +861,7 @@
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>,
 		       <&dmac1 0x3b>, <&dmac1 0x3c>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -870,7 +870,7 @@
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_ETHER>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -883,7 +883,7 @@
 		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
 		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_ETHERAVB>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -894,7 +894,7 @@
 		reg = <0 0xee300000 0 0x2000>;
 		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_SATA0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -903,7 +903,7 @@
 		reg = <0 0xee500000 0 0x2000>;
 		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_SATA1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -915,7 +915,7 @@
 		dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
 		       <&usb_dmac1 0>, <&usb_dmac1 1>;
 		dma-names = "ch0", "ch1", "ch2", "ch3";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
@@ -929,7 +929,7 @@
 		#size-cells = <0>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSUSB>;
 		clock-names = "usbhs";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		usb0: usb-channel@0 {
@@ -947,7 +947,7 @@
 		reg = <0 0xe6ef0000 0 0x1000>;
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_VIN0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -956,7 +956,7 @@
 		reg = <0 0xe6ef1000 0 0x1000>;
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_VIN1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -965,7 +965,7 @@
 		reg = <0 0xe6ef2000 0 0x1000>;
 		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_VIN2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -974,7 +974,7 @@
 		reg = <0 0xfe928000 0 0x8000>;
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_S>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 
 		renesas,has-lut;
 		renesas,has-sru;
@@ -988,7 +988,7 @@
 		reg = <0 0xfe930000 0 0x8000>;
 		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -1002,7 +1002,7 @@
 		reg = <0 0xfe938000 0 0x8000>;
 		interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 
 		renesas,has-lif;
 		renesas,has-lut;
@@ -1048,7 +1048,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_RCAN0>,
 			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -1059,7 +1059,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_RCAN1>,
 			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -1068,7 +1068,7 @@
 		reg = <0 0xfe980000 0 0x10300>;
 		interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_JPU>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 	};
 
 	clocks {
@@ -1509,7 +1509,7 @@
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>,
 		       <&dmac1 0x17>, <&dmac1 0x18>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1524,7 +1524,7 @@
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>,
 		       <&dmac1 0x51>, <&dmac1 0x52>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1538,7 +1538,7 @@
 		dmas = <&dmac0 0x55>, <&dmac0 0x56>,
 		       <&dmac1 0x55>, <&dmac1 0x56>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1552,7 +1552,7 @@
 		dmas = <&dmac0 0x41>, <&dmac0 0x42>,
 		       <&dmac1 0x41>, <&dmac1 0x42>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1563,7 +1563,7 @@
 		reg = <0 0xee000000 0 0xc00>;
 		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SSUSB>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		phys = <&usb2 1>;
 		phy-names = "usb";
 		status = "disabled";
@@ -1576,7 +1576,7 @@
 		      <0 0xee080000 0 0x1100>;
 		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		bus-range = <0 0>;
@@ -1611,7 +1611,7 @@
 		      <0 0xee0c0000 0 0x1100>;
 		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 
 		bus-range = <1 1>;
@@ -1661,7 +1661,7 @@
 		interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_PCIEC>, <&pcie_bus_clk>;
 		clock-names = "pcie", "pcie_bus";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -1764,7 +1764,7 @@
 				"mix.0", "mix.1",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 
 		status = "disabled";
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
