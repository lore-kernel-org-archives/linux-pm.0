From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 2/5] ARM: shmobile: r8a73a4: Add INTC-SYS clock to device tree
Date: Wed, 18 Mar 2015 20:16:01 +0100
Message-ID: <1426706164-28309-3-git-send-email-geert+renesas@glider.be>
References: <1426706164-28309-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1426706164-28309-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Link the ARM GIC to the INTC-SYS module clock, so it can be power
managed using that clock in the future.

Note that currently the GIC driver doesn't support module clocks nor
Runtime PM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4.dtsi            | 11 +++++++----
 include/dt-bindings/clock/r8a73a4-clock.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 7ee22a41c6c97488..76618a911b9a4e7a 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -443,6 +443,7 @@
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		clocks = <&mstp4_clks R8A73A4_CLK_INTC_SYS>;
 	};
 
 	bsc: bus@fec10000 {
@@ -726,16 +727,18 @@
 		mstp4_clks: mstp4_clks@e6150140 {
 			compatible = "renesas,r8a73a4-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
-			clocks = <&main_div2_clk>, <&main_div2_clk>,
+			clocks = <&main_div2_clk>, <&cpg_clocks R8A73A4_CLK_ZS>,
+				 <&main_div2_clk>,
 				 <&cpg_clocks R8A73A4_CLK_HP>,
 				 <&cpg_clocks R8A73A4_CLK_HP>;
 			#clock-cells = <1>;
 			clock-indices = <
-				R8A73A4_CLK_IRQC R8A73A4_CLK_IIC5
-				R8A73A4_CLK_IIC4 R8A73A4_CLK_IIC3
+				R8A73A4_CLK_IRQC R8A73A4_CLK_INTC_SYS
+				R8A73A4_CLK_IIC5 R8A73A4_CLK_IIC4
+				R8A73A4_CLK_IIC3
 			>;
 			clock-output-names =
-				"irqc", "iic5", "iic4", "iic3";
+				"irqc", "intc-sys", "iic5", "iic4", "iic3";
 		};
 		mstp5_clks: mstp5_clks@e6150144 {
 			compatible = "renesas,r8a73a4-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a73a4-clock.h b/include/dt-bindings/clock/r8a73a4-clock.h
index dd11ecdf837e8e65..4b36681572570c15 100644
--- a/include/dt-bindings/clock/r8a73a4-clock.h
+++ b/include/dt-bindings/clock/r8a73a4-clock.h
@@ -54,6 +54,7 @@
 #define R8A73A4_CLK_IIC3	11
 #define R8A73A4_CLK_IIC4	10
 #define R8A73A4_CLK_IIC5	9
+#define R8A73A4_CLK_INTC_SYS	8
 #define R8A73A4_CLK_IRQC	7
 
 /* MSTP5 */
-- 
1.9.1

