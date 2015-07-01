From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 12/16] ARM: shmobile: r8a7794 dtsi: Add CPG/MSTP Clock Domain
Date: Wed,  1 Jul 2015 17:58:06 +0200
Message-ID: <1435766290-3005-13-git-send-email-geert+renesas@glider.be>
References: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add an appropriate "#power-domain-cells" property to the cpg_clocks
device node, to create the CPG/MSTP Clock Domain.

Add "power-domains" properties to all device nodes for devices that are
part of the CPG/MSTP Clock Domain and can be power-managed through an
MSTP clock.  This applies to most on-SoC devices, which have a
one-to-one mapping from SoC device to DT device node.

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
 arch/arm/boot/dts/r8a7794.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 8824dbd5dbb4a5c2..d9fd0e06565a356b 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -57,6 +57,7 @@
 			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7794_CLK_CMT0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		renesas,channels-mask = <0x60>;
 
@@ -76,6 +77,7 @@
 			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_CMT1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -106,6 +108,7 @@
 			     <0 16 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A7794_CLK_IRQC>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	dmac0: dma-controller@e6700000 {
@@ -134,6 +137,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7794_CLK_SYS_DMAC0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -164,6 +168,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7794_CLK_SYS_DMAC1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -176,6 +181,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -187,6 +193,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -198,6 +205,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -209,6 +217,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -220,6 +229,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -231,6 +241,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -242,6 +253,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -253,6 +265,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -264,6 +277,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -275,6 +289,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -286,6 +301,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -297,6 +313,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -308,6 +325,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -319,6 +337,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -330,6 +349,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -341,6 +361,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -352,6 +373,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -363,6 +385,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -371,6 +394,7 @@
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_ETHER>;
+		power-domains = <&cpg_clocks>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -382,6 +406,7 @@
 		reg = <0 0xee100000 0 0x200>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -390,6 +415,7 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -398,6 +424,7 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -424,6 +451,7 @@
 			#clock-cells = <1>;
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "z";
+			#power-domain-cells = <0>;
 		};
 		/* Variable factor clocks */
 		sd2_clk: sd2_clk@e6150078 {
-- 
1.9.1

