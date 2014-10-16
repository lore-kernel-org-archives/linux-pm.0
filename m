From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v11 4/5] ARM: dts: add main Thermal info to rk3288
Date: Thu, 16 Oct 2014 21:31:40 +0800
Message-ID: <1413466301-25952-5-git-send-email-caesar.wang@rock-chips.com>
References: <1413466301-25952-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413466301-25952-1-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com
Cc: zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dmitry.torokhov@gmail.com, dbasehore@chromium.org, huangtao@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com, vladimir_zapolskiy@mentor.com, Caesar Wang <caesar.wang@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

This patch is depend on rk3288-thermal.dtsi,or
it will compile error.

If the temperature over a period of time High,over 120C
the resulting TSHUT gave CRU module,let it reset
the entire chip,or via GPIO give PMIC.

Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index cb18bb4..bf34111 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3288-cru.h>
+#include <dt-bindings/thermal/thermal.h>
 #include "skeleton.dtsi"
 
 / {
@@ -346,6 +347,19 @@
 		status = "disabled";
 	};
 
+	tsadc: tsadc@ff280000 {
+		compatible = "rockchip,rk3288-tsadc";
+		reg = <0xff280000 0x100>;
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+		clock-names = "tsadc", "apb_pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&otp_out>;
+		#thermal-sensor-cells = <1>;
+		hw-shut-temp = <120000>;
+		status = "disabled"
+	};
+
 	usb_host0_ehci: usb@ff500000 {
 		compatible = "generic-ehci";
 		reg = <0xff500000 0x100>;
@@ -965,6 +979,12 @@
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
