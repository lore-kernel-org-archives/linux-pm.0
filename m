From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 3/5] ARM: shmobile: r8a7790: Add INTC-SYS clock to device tree
Date: Wed, 18 Mar 2015 20:16:02 +0100
Message-ID: <1426706164-28309-4-git-send-email-geert+renesas@glider.be>
References: <1426706164-28309-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:36149 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933234AbbCRTQO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 15:16:14 -0400
In-Reply-To: <1426706164-28309-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Link the ARM GIC to the INTC-SYS module clock, so it can be power
managed using that clock in the future.

Note that currently the GIC driver doesn't support module clocks nor
Runtime PM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 7 ++++---
 include/dt-bindings/clock/r8a7790-clock.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index a81cfda0872fc30a..d4210f5b692a42b5 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -122,6 +122,7 @@
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		clocks = <&mstp4_clks R8A7790_CLK_INTC_SYS>;
 	};
 
 	gpio0: gpio@e6050000 {
@@ -1162,10 +1163,10 @@
 		mstp4_clks: mstp4_clks@e6150140 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
-			clocks = <&cp_clk>;
+			clocks = <&cp_clk>, <&zs_clk>;
 			#clock-cells = <1>;
-			clock-indices = <R8A7790_CLK_IRQC>;
-			clock-output-names = "irqc";
+			clock-indices = <R8A7790_CLK_IRQC R8A7790_CLK_INTC_SYS>;
+			clock-output-names = "irqc", "intc-sys";
 		};
 		mstp5_clks: mstp5_clks@e6150144 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index ff7ca3584e169589..49419ee93aed825e 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -81,6 +81,7 @@
 
 /* MSTP4 */
 #define R8A7790_CLK_IRQC		7
+#define R8A7790_CLK_INTC_SYS		8
 
 /* MSTP5 */
 #define R8A7790_CLK_AUDIO_DMAC1		1
-- 
1.9.1

