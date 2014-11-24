From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v19 4/5] ARM: dts: add main Thermal info to rk3288
Date: Mon, 24 Nov 2014 12:59:01 +0800
Message-ID: <1416805142-27304-5-git-send-email-caesar.wang@rock-chips.com>
References: <1416805142-27304-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416805142-27304-1-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com
Cc: zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dmitry.torokhov@gmail.com, huangtao@rock-chips.com, fzf@rock-chips.com, caesar.wang@rock-chips.com
List-Id: linux-pm@vger.kernel.org

This patch is depend on rk3288-thermal.dtsi,or
it will compile error.

If for some reason we are unable to shut it down
in orderly fashion (kernel is stuck holding a lock or
similar), then hardware TSHUT will reset it.

If the temperature over a period of time High,over 95C
the resulting TSHUT gave CRU module,let it reset
the entire chip,or via GPIO give PMIC.

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 9cd269a..c7a2691 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3288-cru.h>
+#include <dt-bindings/thermal/thermal.h>
 #include "skeleton.dtsi"
 
 / {
@@ -66,6 +67,7 @@
 				 216000  900000
 				 126000  900000
 			>;
+			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 		};
@@ -346,6 +348,25 @@
 		status = "disabled";
 	};
 
+	thermal-zones {
+		#include "rk3288-thermal.dtsi"
+	};
+
+	tsadc: tsadc@ff280000 {
+		compatible = "rockchip,rk3288-tsadc";
+		reg = <0xff280000 0x100>;
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
 	usb_host0_ehci: usb@ff500000 {
 		compatible = "generic-ehci";
 		reg = <0xff500000 0x100>;
@@ -965,6 +986,12 @@
 			};
 		};
 
+		tsadc {
+			otp_out: otp-out {
+				rockchip,pins = <0 10 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
 		pwm0 {
 			pwm0_pin: pwm0-pin {
 				rockchip,pins = <7 0 RK_FUNC_1 &pcfg_pull_none>;
-- 
1.9.1
