From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5/7] ARM: shmobile: r8a7790: Add IRQC clock to device tree
Date: Wed, 18 Mar 2015 19:55:59 +0100
Message-ID: <1426704961-27322-6-git-send-email-geert+renesas@glider.be>
References: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:58542 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933036AbbCRS4E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 14:56:04 -0400
In-Reply-To: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Link the external IRQ controller irqc0 to the IRQC module clock, so it
can be power managed using that clock.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 9 +++++++++
 include/dt-bindings/clock/r8a7790-clock.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 4bb2f4c17321bd55..a81cfda0872fc30a 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -252,6 +252,7 @@
 			     <0 1 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 2 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 3 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R8A7790_CLK_IRQC>;
 	};
 
 	dmac0: dma-controller@e6700000 {
@@ -1158,6 +1159,14 @@
 				"iic0", "pciec", "iic1", "ssusb", "cmt1",
 				"usbdmac0", "usbdmac1";
 		};
+		mstp4_clks: mstp4_clks@e6150140 {
+			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
+			clocks = <&cp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7790_CLK_IRQC>;
+			clock-output-names = "irqc";
+		};
 		mstp5_clks: mstp5_clks@e6150144 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 3f2c6b198d4ac289..ff7ca3584e169589 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -79,6 +79,9 @@
 #define R8A7790_CLK_USBDMAC0		30
 #define R8A7790_CLK_USBDMAC1		31
 
+/* MSTP4 */
+#define R8A7790_CLK_IRQC		7
+
 /* MSTP5 */
 #define R8A7790_CLK_AUDIO_DMAC1		1
 #define R8A7790_CLK_AUDIO_DMAC0		2
-- 
1.9.1

