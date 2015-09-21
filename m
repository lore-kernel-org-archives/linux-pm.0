From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 4/5] arm64: dts: Add main Thermal info to rk3368.dtsi
Date: Mon, 21 Sep 2015 12:16:10 +0800
Message-ID: <1442808971-2619-5-git-send-email-wxt@rock-chips.com>
References: <1442808971-2619-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35381 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbIUERH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2015 00:17:07 -0400
In-Reply-To: <1442808971-2619-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de, edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, will.deacon@arm.com, robh+dt@kernel.org, inux-kernel@vger.kernel.org, galak@codeaurora.org, linux-rockchip@lists.infradead.org, dmitry.torokhov@gmail.com, mark.rutland@arm.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, ijc+devicetree@hellion.org.uk, Caesar Wang <wxt@rock-chips.com>

This patch add the thermal needed info on RK3368.
Meanwhile, support the trips to throttle for thermal.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index a712bea..71d7793 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -45,6 +45,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "rockchip,rk3368";
@@ -123,6 +124,8 @@
 			reg = <0x0 0x0>;
 			cpu-idle-states = <&cpu_sleep>;
 			enable-method = "psci";
+
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu_l1: cpu@1 {
@@ -155,6 +158,8 @@
 			reg = <0x0 0x100>;
 			cpu-idle-states = <&cpu_sleep>;
 			enable-method = "psci";
+
+			#cooling-cells = <2>; /* min followed by max */
 		};
 
 		cpu_b1: cpu@101 {
@@ -404,6 +409,25 @@
 		status = "disabled";
 	};
 
+	thermal-zones {
+		#include "rk3368-thermal.dtsi"
+	};
+
+	tsadc: tsadc@ff280000 {
+		compatible = "rockchip,rk3368-tsadc";
+		reg = <0x0 0xff280000 0x0 0x100>;
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		resets = <&cru SRST_TSADC>;
+		reset-names = "tsadc-apb";
+		pinctrl-names = "default";
+		pinctrl-0 = <&otp_out>;
+		#thermal-sensor-cells = <1>;
+		rockchip,hw-tshut-temp = <95000>;
+		status = "disabled";
+	};
+
 	gmac: ethernet@ff290000 {
 		compatible = "rockchip,rk3368-gmac";
 		reg = <0x0 0xff290000 0x0 0x10000>;
@@ -829,6 +853,12 @@
 			};
 		};
 
+		tsadc {
+			otp_out: otp-out {
+				rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		uart0 {
 			uart0_xfer: uart0-xfer {
 				rockchip,pins = <2 24 RK_FUNC_1 &pcfg_pull_up>,
-- 
1.9.1

