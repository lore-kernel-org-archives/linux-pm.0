From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 08/16] ARM: shmobile: r8a7779 dtsi: Add CPG/MSTP Clock Domain
Date: Wed,  1 Jul 2015 17:58:02 +0200
Message-ID: <1435766290-3005-9-git-send-email-geert+renesas@glider.be>
References: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:53240 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbbGAP61 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 11:58:27 -0400
In-Reply-To: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

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
 arch/arm/boot/dts/r8a7779.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index a2b5430d32575f99..6afa909865b52b71 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -173,6 +173,7 @@
 		reg = <0xffc70000 0x1000>;
 		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -183,6 +184,7 @@
 		reg = <0xffc71000 0x1000>;
 		interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -193,6 +195,7 @@
 		reg = <0xffc72000 0x1000>;
 		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -203,6 +206,7 @@
 		reg = <0xffc73000 0x1000>;
 		interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C3>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -212,6 +216,7 @@
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF0>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -221,6 +226,7 @@
 		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF1>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -230,6 +236,7 @@
 		interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF2>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -239,6 +246,7 @@
 		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF3>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -248,6 +256,7 @@
 		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF4>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -257,6 +266,7 @@
 		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF5>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -278,6 +288,7 @@
 			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		#renesas,channels = <3>;
 
@@ -292,6 +303,7 @@
 			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_TMU1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		#renesas,channels = <3>;
 
@@ -306,6 +318,7 @@
 			     <0 42 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_TMU2>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		#renesas,channels = <3>;
 
@@ -317,6 +330,7 @@
 		reg = <0xfc600000 0x2000>;
 		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	sdhi0: sd@ffe4c000 {
@@ -324,6 +338,7 @@
 		reg = <0xffe4c000 0x100>;
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -332,6 +347,7 @@
 		reg = <0xffe4d000 0x100>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -340,6 +356,7 @@
 		reg = <0xffe4e000 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -348,6 +365,7 @@
 		reg = <0xffe4f000 0x100>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI3>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -358,6 +376,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -368,6 +387,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -378,6 +398,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -386,6 +407,7 @@
 		reg = <0 0xfff80000 0 0x40000>;
 		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7779_CLK_DU>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 
 		ports {
@@ -427,6 +449,7 @@
 			#clock-cells = <1>;
 			clock-output-names = "plla", "z", "zs", "s",
 					     "s1", "p", "b", "out";
+			#power-domain-cells = <0>;
 		};
 
 		/* Fixed factor clocks */
-- 
1.9.1

