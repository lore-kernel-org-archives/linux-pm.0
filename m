From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 7/7] ARM: shmobile: r8a7794: Add IRQC clock to device tree
Date: Wed, 18 Mar 2015 19:56:01 +0100
Message-ID: <1426704961-27322-8-git-send-email-geert+renesas@glider.be>
References: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Link the external IRQ controller irqc0 to the IRQC module clock, so it
can be power managed using that clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 9 +++++++++
 include/dt-bindings/clock/r8a7794-clock.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 7a3ffa51a8bf2c8b..01cf54f70501e8c2 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -105,6 +105,7 @@
 			     <0 15 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 16 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 17 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R8A7794_CLK_IRQC>;
 	};
 
 	dmac0: dma-controller@e6700000 {
@@ -625,6 +626,14 @@
 			        "sdhi2", "sdhi1", "sdhi0",
 				"mmcif0", "cmt1", "usbdmac0", "usbdmac1";
 		};
+		mstp4_clks: mstp4_clks@e6150140 {
+			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
+			clocks = <&cp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7794_CLK_IRQC>;
+			clock-output-names = "irqc";
+		};
 		mstp7_clks: mstp7_clks@e615014c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index d63323032d6ef80e..09da38a58776b403 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -60,6 +60,9 @@
 #define R8A7794_CLK_USBDMAC0		30
 #define R8A7794_CLK_USBDMAC1		31
 
+/* MSTP4 */
+#define R8A7794_CLK_IRQC		7
+
 /* MSTP5 */
 #define R8A7794_CLK_THERMAL		22
 #define R8A7794_CLK_PWM			23
-- 
1.9.1

