From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 08/14] ARM: shmobile: r8a7779 dtsi: Add CPG Clock Domain
Date: Thu, 28 May 2015 20:53:33 +0200
Message-ID: <1432839219-475-9-git-send-email-geert+renesas@glider.be>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:36668 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbbE1Sx4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2015 14:53:56 -0400
In-Reply-To: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add an appropriate "#power-domain-cells" property to the cpg_clocks
device node, to create the CPG Clock Domain.

Add "power-domains" properties to all device nodes for devices that are
part of the CPG Clock Domain and can be power-managed through an MSTP
clock.  This applies to most on-SoC devices, which have a one-to-one
mapping from SoC device to DT device node.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/arm/boot/dts/r8a7779.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 5c8071e87ae9c719..d75f46a539749eae 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -172,6 +172,7 @@
 		reg = <0xffc70000 0x1000>;
 		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -182,6 +183,7 @@
 		reg = <0xffc71000 0x1000>;
 		interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -192,6 +194,7 @@
 		reg = <0xffc72000 0x1000>;
 		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -202,6 +205,7 @@
 		reg = <0xffc73000 0x1000>;
 		interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C3>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -211,6 +215,7 @@
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF0>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -220,6 +225,7 @@
 		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF1>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -229,6 +235,7 @@
 		interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF2>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -238,6 +245,7 @@
 		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF3>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -247,6 +255,7 @@
 		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF4>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -256,6 +265,7 @@
 		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF5>;
 		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -277,6 +287,7 @@
 			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		#renesas,channels = <3>;
 
@@ -291,6 +302,7 @@
 			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_TMU1>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		#renesas,channels = <3>;
 
@@ -305,6 +317,7 @@
 			     <0 42 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_TMU2>;
 		clock-names = "fck";
+		power-domains = <&cpg_clocks>;
 
 		#renesas,channels = <3>;
 
@@ -316,6 +329,7 @@
 		reg = <0xfc600000 0x2000>;
 		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
+		power-domains = <&cpg_clocks>;
 	};
 
 	sdhi0: sd@ffe4c000 {
@@ -323,6 +337,7 @@
 		reg = <0xffe4c000 0x100>;
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI0>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -331,6 +346,7 @@
 		reg = <0xffe4d000 0x100>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI1>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -339,6 +355,7 @@
 		reg = <0xffe4e000 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI2>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -347,6 +364,7 @@
 		reg = <0xffe4f000 0x100>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI3>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -357,6 +375,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -367,6 +386,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -377,6 +397,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
 
@@ -385,6 +406,7 @@
 		reg = <0 0xfff80000 0 0x40000>;
 		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7779_CLK_DU>;
+		power-domains = <&cpg_clocks>;
 		status = "disabled";
 
 		ports {
@@ -426,6 +448,7 @@
 			#clock-cells = <1>;
 			clock-output-names = "plla", "z", "zs", "s",
 					     "s1", "p", "b", "out";
+			#power-domain-cells = <0>;
 		};
 
 		/* Fixed factor clocks */
-- 
1.9.1

