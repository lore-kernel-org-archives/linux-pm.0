From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6/7] ARM: shmobile: r8a7791: Add IRQC clock to device tree
Date: Wed, 18 Mar 2015 19:56:00 +0100
Message-ID: <1426704961-27322-7-git-send-email-geert+renesas@glider.be>
References: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Link the external IRQ controller irqc0 to the IRQC module clock, so it
can be power managed using that clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi            | 9 +++++++++
 include/dt-bindings/clock/r8a7791-clock.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 4696062f6ddeaaeb..20ab7668088493b9 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -239,6 +239,7 @@
 			     <0 15 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 16 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 17 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R8A7791_CLK_IRQC>;
 	};
 
 	dmac0: dma-controller@e6700000 {
@@ -1160,6 +1161,14 @@
 				"mmcif0", "i2c7", "pciec", "i2c8", "ssusb", "cmt1",
 				"usbdmac0", "usbdmac1";
 		};
+		mstp4_clks: mstp4_clks@e6150140 {
+			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
+			clocks = <&cp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7791_CLK_IRQC>;
+			clock-output-names = "irqc";
+		};
 		mstp5_clks: mstp5_clks@e6150144 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index 8fc5dc8faeea4051..402268384b99093c 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -70,6 +70,9 @@
 #define R8A7791_CLK_USBDMAC0		30
 #define R8A7791_CLK_USBDMAC1		31
 
+/* MSTP4 */
+#define R8A7791_CLK_IRQC		7
+
 /* MSTP5 */
 #define R8A7791_CLK_AUDIO_DMAC1		1
 #define R8A7791_CLK_AUDIO_DMAC0		2
-- 
1.9.1
