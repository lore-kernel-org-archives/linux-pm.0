From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/7] ARM: shmobile: r8a7734: Add IRQC clock to device tree
Date: Wed, 18 Mar 2015 19:55:58 +0100
Message-ID: <1426704961-27322-5-git-send-email-geert+renesas@glider.be>
References: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Link the external IRQ controllers irqc0 and irqc1 to the IRQC module
clock, so they can be power managed using that clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4.dtsi            | 11 +++++++----
 include/dt-bindings/clock/r8a73a4-clock.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 0fd889f88109de17..7ee22a41c6c97488 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -163,6 +163,7 @@
 			     <0 29 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 30 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R8A73A4_CLK_IRQC>;
 		power-domains = <&pd_c4>;
 	};
 
@@ -197,6 +198,7 @@
 			     <0 55 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 56 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 57 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R8A73A4_CLK_IRQC>;
 		power-domains = <&pd_c4>;
 	};
 
@@ -724,15 +726,16 @@
 		mstp4_clks: mstp4_clks@e6150140 {
 			compatible = "renesas,r8a73a4-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
-			clocks = <&main_div2_clk>, <&cpg_clocks R8A73A4_CLK_HP>,
+			clocks = <&main_div2_clk>, <&main_div2_clk>,
+				 <&cpg_clocks R8A73A4_CLK_HP>,
 				 <&cpg_clocks R8A73A4_CLK_HP>;
 			#clock-cells = <1>;
 			clock-indices = <
-				R8A73A4_CLK_IIC5 R8A73A4_CLK_IIC4
-				R8A73A4_CLK_IIC3
+				R8A73A4_CLK_IRQC R8A73A4_CLK_IIC5
+				R8A73A4_CLK_IIC4 R8A73A4_CLK_IIC3
 			>;
 			clock-output-names =
-				"iic5", "iic4", "iic3";
+				"irqc", "iic5", "iic4", "iic3";
 		};
 		mstp5_clks: mstp5_clks@e6150144 {
 			compatible = "renesas,r8a73a4-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a73a4-clock.h b/include/dt-bindings/clock/r8a73a4-clock.h
index 9a4b4c9ca44aba70..dd11ecdf837e8e65 100644
--- a/include/dt-bindings/clock/r8a73a4-clock.h
+++ b/include/dt-bindings/clock/r8a73a4-clock.h
@@ -54,6 +54,7 @@
 #define R8A73A4_CLK_IIC3	11
 #define R8A73A4_CLK_IIC4	10
 #define R8A73A4_CLK_IIC5	9
+#define R8A73A4_CLK_IRQC	7
 
 /* MSTP5 */
 #define R8A73A4_CLK_THERMAL	22
-- 
1.9.1

