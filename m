From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 12/16] ARM: shmobile: r8a7794 dtsi: Add CPG/MSTP Clock Domain
Date: Tue,  4 Aug 2015 14:28:13 +0200
Message-ID: <1438691297-29235-13-git-send-email-geert+renesas@glider.be>
References: <1438691297-29235-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1438691297-29235-1-git-send-email-geert+renesas@glider.be>
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
v4:
  - Add "power-domains" properties to recently introduced mmcif0 device
    node,
  - Consistently add "power-domains" properties after clock and dma
    properties,

v3:
  - Use "CPG/MSTP Clock Domain" instead of "CPG Clock Domain",

v2:
  - Add Reviewed-by,
  - Add "power-domains" properties to recently introduced USB-DMAC
    device nodes,
  - Drop adding "power-domains" properties to the GIC device node, as
    adding the INTC_SYS clock is postponed.
---
 arch/arm/boot/dts/r8a7794.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 43acf185ecc43f40..97c8e9ace5ebee1e 100644
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
 
 	pfc: pin-controller@e6060000 {
@@ -140,6 +143,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7794_CLK_SYS_DMAC0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -170,6 +174,7 @@
 				"ch12", "ch13", "ch14";
 		clocks = <&mstp2_clks R8A7794_CLK_SYS_DMAC1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -182,6 +187,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -193,6 +199,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -204,6 +211,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -215,6 +223,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -226,6 +235,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -237,6 +247,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -248,6 +259,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -259,6 +271,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -270,6 +283,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -281,6 +295,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -292,6 +307,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -303,6 +319,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -314,6 +331,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -325,6 +343,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -336,6 +355,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -347,6 +367,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -358,6 +379,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -369,6 +391,7 @@
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -377,6 +400,7 @@
 		reg = <0 0xee700000 0 0x400>;
 		interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_ETHER>;
+		power-domains = <&cpg_clocks>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -390,6 +414,7 @@
 		clocks = <&mstp3_clks R8A7794_CLK_MMCIF0>;
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
 		dma-names = "tx", "rx";
+		power-domains = <&cpg_clocks>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -399,6 +424,7 @@
 		reg = <0 0xee100000 0 0x200>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -407,6 +433,7 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -415,6 +442,7 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -441,6 +469,7 @@
 			#clock-cells = <1>;
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "z";
+			#power-domain-cells = <0>;
 		};
 		/* Variable factor clocks */
 		sd2_clk: sd2_clk@e6150078 {
-- 
1.9.1

