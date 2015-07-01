From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 07/16] ARM: shmobile: r8a7778 dtsi: Add CPG/MSTP Clock Domain
Date: Wed,  1 Jul 2015 17:58:01 +0200
Message-ID: <1435766290-3005-8-git-send-email-geert+renesas@glider.be>
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
one-to-one mapping from SoC device to DT device node.  A notable
exception is the "sound" node, which represents multiple SoC devices,
each having their own MSTP clocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Use "CPG/MSTP Clock Domain" instead of "CPG Clock Domain",

v2:
  - New.
---
 arch/arm/boot/dts/r8a7778.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 7ce9f5fd586504f2..4b1fa9f42ad5457b 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -53,6 +53,7 @@
 		reg = <0xfde00000 0x400>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7778_CLK_ETHER>;
+		power-domains = <&cpg_clocks>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -152,6 +153,7 @@
 		reg = <0xffc70000 0x1000>;
 		interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_I2C0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -162,6 +164,7 @@
 		reg = <0xffc71000 0x1000>;
 		interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_I2C1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -172,6 +175,7 @@
 		reg = <0xffc72000 0x1000>;
 		interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_I2C2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -182,6 +186,7 @@
 		reg = <0xffc73000 0x1000>;
 		interrupts = <0 77 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_I2C3>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -193,6 +198,7 @@
 			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_TMU0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		#renesas,channels = <3>;
 
@@ -207,6 +213,7 @@
 			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_TMU1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		#renesas,channels = <3>;
 
@@ -221,6 +228,7 @@
 			     <0 42 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_TMU2>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		#renesas,channels = <3>;
 
@@ -288,6 +296,7 @@
 		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF0>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -297,6 +306,7 @@
 		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF1>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -306,6 +316,7 @@
 		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF2>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -315,6 +326,7 @@
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF3>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -324,6 +336,7 @@
 		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF4>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -333,6 +346,7 @@
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF5>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -341,6 +355,7 @@
 		reg = <0xffe4e000 0x100>;
 		interrupts = <0 61 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7778_CLK_MMC>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -349,6 +364,7 @@
 		reg = <0xffe4c000 0x100>;
 		interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7778_CLK_SDHI0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -357,6 +373,7 @@
 		reg = <0xffe4d000 0x100>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7778_CLK_SDHI1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -365,6 +382,7 @@
 		reg = <0xffe4f000 0x100>;
 		interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7778_CLK_SDHI2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -373,6 +391,7 @@
 		reg = <0xfffc7000 0x18>;
 		interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_HSPI>;
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -383,6 +402,7 @@
 		reg = <0xfffc8000 0x18>;
 		interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_HSPI>;
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -393,6 +413,7 @@
 		reg = <0xfffc6000 0x18>;
 		interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_HSPI>;
+		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -419,6 +440,7 @@
 			clocks = <&extal_clk>;
 			clock-output-names = "plla", "pllb", "b",
 					     "out", "p", "s", "s1";
+			#power-domain-cells = <0>;
 		};
 
 		/* Audio clocks; frequencies are set by boards if applicable. */
-- 
1.9.1

