From: Caesar Wang <wxt@rock-chips.com>
Subject: [RESEND PATCH 7/8] ARM: dts: rockchip: add the thermal main info found on rk3228
Date: Mon, 15 Feb 2016 15:33:32 +0800
Message-ID: <1455521613-27340-8-git-send-email-wxt@rock-chips.com>
References: <1455521613-27340-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455521613-27340-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, edubezval@gmail.com
Cc: huangtao@rock-chips.com, Michael Turquette <mturquette@baylibre.com>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, zhangqing@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

This patch adds the thermal needed main information for rk3228 SoCS.

Basically has the following content:

1) TSADC controller:
Add the needed attributes for rk3036 TSADC controller.

Especially for the TSHUT, in some cases if we are unable to shut it down
in orderly fashion (says: kernel is stuck holding a lock or similar), then
hardware TSHUT will reset it.
If the temperature is over 95C over a period of time the thermal shutdown
of the tsadc is invoked with can either reset the entire chip via the CRU,
or notify the PMIC via a GPIO. This should be set in the specific board.

2) Thermal zones:
Add the needed device mode for thermal generic framework.
Detail in Documentation/devicetree/bindings/thermal/thermal.txt.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm/boot/dts/rk3228.dtsi | 69 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/rk3228.dtsi b/arch/arm/boot/dts/rk3228.dtsi
index 119ff12..4084081 100644
--- a/arch/arm/boot/dts/rk3228.dtsi
+++ b/arch/arm/boot/dts/rk3228.dtsi
@@ -43,6 +43,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3228-cru.h>
+#include <dt-bindings/thermal/thermal.h>
 #include "skeleton.dtsi"
 
 / {
@@ -69,6 +70,7 @@
 				/* KHz    uV */
 				 816000 1000000
 			>;
+			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 		};
@@ -247,6 +249,63 @@
 		assigned-clock-rates = <594000000>;
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <100>; /* milliseconds */
+			polling-delay = <5000>; /* milliseconds */
+
+			thermal-sensors = <&tsadc 0>;
+
+			trips {
+				cpu_alert0: cpu_alert0 {
+					temperature = <70000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+				cpu_alert1: cpu_alert1 {
+					temperature = <75000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+				cpu_crit: cpu_crit {
+					temperature = <90000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device =
+						<&cpu0 THERMAL_NO_LIMIT 6>;
+				};
+				map1 {
+					trip = <&cpu_alert1>;
+					cooling-device =
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
+	tsadc: tsadc@11150000 {
+		compatible = "rockchip,rk3228-tsadc";
+		reg = <0x11150000 0x100>;
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		resets = <&cru SRST_TSADC>;
+		reset-names = "tsadc-apb";
+		pinctrl-names = "init", "default", "sleep";
+		pinctrl-0 = <&otp_gpio>;
+		pinctrl-1 = <&otp_out>;
+		pinctrl-2 = <&otp_gpio>;
+		#thermal-sensor-cells = <0>;
+		rockchip,hw-tshut-temp = <95000>;
+		status = "disabled";
+	};
+
 	emmc: dwmmc@30020000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		reg = <0x30020000 0x4000>;
@@ -394,6 +453,16 @@
 			};
 		};
 
+		tsadc {
+			otp_gpio: otp-gpio {
+				rockchip,pins = <0 24 RK_FUNC_GPIO &pcfg_pull_none>;
+			};
+
+			otp_out: otp-out {
+				rockchip,pins = <0 24 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
 		uart0 {
 			uart0_xfer: uart0-xfer {
 				rockchip,pins = <2 26 RK_FUNC_1 &pcfg_pull_none>,
-- 
1.9.1
