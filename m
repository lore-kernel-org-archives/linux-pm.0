From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 10/12] ARM: dts: r8a7793: Use SYSC "always-on" PM Domain
Date: Wed, 13 Apr 2016 16:44:50 +0200
Message-ID: <1460558692-10414-11-git-send-email-geert+renesas@glider.be>
References: <1460558692-10414-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1460558692-10414-1-git-send-email-geert+renesas@glider.be>
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
v5:
  - Add Acked-by,

v4:
  - New.
---
 arch/arm/boot/dts/r8a7793.dtsi | 96 +++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index c8c32b7423f6c8bb..93a4f1f6efd9c70a 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -105,7 +105,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio1: gpio@e6051000 {
@@ -118,7 +118,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio2: gpio@e6052000 {
@@ -131,7 +131,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio3: gpio@e6053000 {
@@ -144,7 +144,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio4: gpio@e6054000 {
@@ -157,7 +157,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO4>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio5: gpio@e6055000 {
@@ -170,7 +170,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO5>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio6: gpio@e6055400 {
@@ -183,7 +183,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO6>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	gpio7: gpio@e6055800 {
@@ -196,7 +196,7 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		clocks = <&mstp9_clks R8A7793_CLK_GPIO7>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	thermal: thermal@e61f0000 {
@@ -206,7 +206,7 @@
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A7793_CLK_THERMAL>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#thermal-sensor-cells = <0>;
 	};
 
@@ -225,7 +225,7 @@
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7793_CLK_CMT0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 
 		renesas,channels-mask = <0x60>;
 
@@ -245,7 +245,7 @@
 			     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7793_CLK_CMT1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -268,7 +268,7 @@
 			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A7793_CLK_IRQC>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 	};
 
 	dmac0: dma-controller@e6700000 {
@@ -297,7 +297,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7793_CLK_SYS_DMAC0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -328,7 +328,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7793_CLK_SYS_DMAC1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -357,7 +357,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7793_CLK_AUDIO_DMAC0>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -386,7 +386,7 @@
 				"ch12";
 		clocks = <&mstp5_clks R8A7793_CLK_AUDIO_DMAC1>;
 		clock-names = "fck";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -399,7 +399,7 @@
 		reg = <0 0xe6508000 0 0x40>;
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C0>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -411,7 +411,7 @@
 		reg = <0 0xe6518000 0 0x40>;
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C1>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -423,7 +423,7 @@
 		reg = <0 0xe6530000 0 0x40>;
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C2>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -435,7 +435,7 @@
 		reg = <0 0xe6540000 0 0x40>;
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C3>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -447,7 +447,7 @@
 		reg = <0 0xe6520000 0 0x40>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C4>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -460,7 +460,7 @@
 		reg = <0 0xe6528000 0 0x40>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C5>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		i2c-scl-internal-delay-ns = <110>;
 		status = "disabled";
 	};
@@ -476,7 +476,7 @@
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>,
 		       <&dmac1 0x77>, <&dmac1 0x78>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -490,7 +490,7 @@
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>,
 		       <&dmac1 0x61>, <&dmac1 0x62>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -504,7 +504,7 @@
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>,
 		       <&dmac1 0x65>, <&dmac1 0x66>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -523,7 +523,7 @@
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>,
 		       <&dmac1 0x21>, <&dmac1 0x22>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -537,7 +537,7 @@
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>,
 		       <&dmac1 0x25>, <&dmac1 0x26>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -551,7 +551,7 @@
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>,
 		       <&dmac1 0x27>, <&dmac1 0x28>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -565,7 +565,7 @@
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>,
 		       <&dmac1 0x1b>, <&dmac1 0x1c>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -579,7 +579,7 @@
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>,
 		       <&dmac1 0x1f>, <&dmac1 0x20>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -593,7 +593,7 @@
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>,
 		       <&dmac1 0x23>, <&dmac1 0x24>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -607,7 +607,7 @@
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
 		       <&dmac1 0x3d>, <&dmac1 0x3e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -621,7 +621,7 @@
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
 		       <&dmac1 0x19>, <&dmac1 0x1a>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -635,7 +635,7 @@
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
 		       <&dmac1 0x1d>, <&dmac1 0x1e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -650,7 +650,7 @@
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
 		       <&dmac1 0x29>, <&dmac1 0x2a>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -665,7 +665,7 @@
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
 		       <&dmac1 0x2d>, <&dmac1 0x2e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -680,7 +680,7 @@
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
 		       <&dmac1 0x2b>, <&dmac1 0x2c>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -695,7 +695,7 @@
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
 		       <&dmac1 0x2f>, <&dmac1 0x30>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -710,7 +710,7 @@
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>,
 		       <&dmac1 0xfb>, <&dmac1 0xfc>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -725,7 +725,7 @@
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>,
 		       <&dmac1 0xfd>, <&dmac1 0xfe>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -740,7 +740,7 @@
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
 		       <&dmac1 0x39>, <&dmac1 0x3a>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -755,7 +755,7 @@
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
 		       <&dmac1 0x4d>, <&dmac1 0x4e>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -770,7 +770,7 @@
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>,
 		       <&dmac1 0x3b>, <&dmac1 0x3c>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -779,7 +779,7 @@
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7793_CLK_ETHER>;
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -794,7 +794,7 @@
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>,
 		       <&dmac1 0x17>, <&dmac1 0x18>;
 		dma-names = "tx", "rx", "tx", "rx";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -838,7 +838,7 @@
 		clocks = <&mstp9_clks R8A7793_CLK_RCAN0>,
 			 <&cpg_clocks R8A7793_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -849,7 +849,7 @@
 		clocks = <&mstp9_clks R8A7793_CLK_RCAN1>,
 			 <&cpg_clocks R8A7793_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		status = "disabled";
 	};
 
@@ -1316,7 +1316,7 @@
 				"src.4", "src.3", "src.2", "src.1", "src.0",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
-		power-domains = <&cpg_clocks>;
+		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 
 		status = "disabled";
 
-- 
1.9.1
