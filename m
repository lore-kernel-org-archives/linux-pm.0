From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 06/16] ARM: shmobile: r7s72100 dtsi: Add CPG/MSTP Clock Domain
Date: Wed,  1 Jul 2015 17:58:00 +0200
Message-ID: <1435766290-3005-7-git-send-email-geert+renesas@glider.be>
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
---
v3:
  - Use "CPG/MSTP Clock Domain" instead of "CPG Clock Domain",

v2:
  - New.
---
 arch/arm/boot/dts/r7s72100.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 277e73c110e5d40c..060c32cbd66923ed 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -86,6 +86,7 @@
 			reg = <0xfcfe0000 0x18>;
 			clocks = <&extal_clk>, <&usb_x1_clk>;
 			clock-output-names = "pll", "i", "g";
+			#power-domain-cells = <0>;
 		};
 
 		/* MSTP clocks */
@@ -157,6 +158,7 @@
 			     <0 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF0>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -169,6 +171,7 @@
 			     <0 193 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF1>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -181,6 +184,7 @@
 			     <0 197 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF2>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -193,6 +197,7 @@
 			     <0 201 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF3>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -205,6 +210,7 @@
 			     <0 205 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF4>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -217,6 +223,7 @@
 			     <0 209 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF5>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -229,6 +236,7 @@
 			     <0 213 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF6>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -241,6 +249,7 @@
 			     <0 217 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF7>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -252,6 +261,7 @@
 			     <0 240 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
 		clocks = <&mstp10_clks R7S72100_CLK_SPI0>;
+		power-domains = <&cpg_clocks>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -266,6 +276,7 @@
 			     <0 243 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
 		clocks = <&mstp10_clks R7S72100_CLK_SPI1>;
+		power-domains = <&cpg_clocks>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -280,6 +291,7 @@
 			     <0 246 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
 		clocks = <&mstp10_clks R7S72100_CLK_SPI2>;
+		power-domains = <&cpg_clocks>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -294,6 +306,7 @@
 			     <0 249 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
 		clocks = <&mstp10_clks R7S72100_CLK_SPI3>;
+		power-domains = <&cpg_clocks>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -308,6 +321,7 @@
 			     <0 252 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
 		clocks = <&mstp10_clks R7S72100_CLK_SPI4>;
+		power-domains = <&cpg_clocks>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -338,6 +352,7 @@
 			     <0 164 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R7S72100_CLK_I2C0>;
 		clock-frequency = <100000>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -356,6 +371,7 @@
 			     <0 172 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R7S72100_CLK_I2C1>;
 		clock-frequency = <100000>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -374,6 +390,7 @@
 			     <0 180 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R7S72100_CLK_I2C2>;
 		clock-frequency = <100000>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -392,6 +409,7 @@
 			     <0 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R7S72100_CLK_I2C3>;
 		clock-frequency = <100000>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -402,6 +420,7 @@
 		interrupt-names = "tgi0a";
 		clocks = <&mstp3_clks R7S72100_CLK_MTU2>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 };
-- 
1.9.1

