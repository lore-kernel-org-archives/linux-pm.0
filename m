From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v5 1/7] max8903: adds documentation for device tree bindings.
Date: Fri, 24 Jun 2016 12:26:06 +1000
Message-ID: <1466735172-13372-2-git-send-email-chris@cpdesign.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466735172-13372-1-git-send-email-chris@cpdesign.com.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466735172-13372-1-git-send-email-chris@cpdesign.com.au>
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>
List-Id: linux-pm@vger.kernel.org

From: Chris Lapa <chris@lapa.com.au>

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 .../devicetree/bindings/power/max8903-charger.txt  | 25 +++++++++++++++
 arch/arm/boot/dts/dairytest-servo.dtsi             | 36 ++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/max8903-charger.txt
 create mode 100644 arch/arm/boot/dts/dairytest-servo.dtsi

diff --git a/Documentation/devicetree/bindings/power/max8903-charger.txt b/Documentation/devicetree/bindings/power/max8903-charger.txt
new file mode 100644
index 0000000..f0f4e12
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/max8903-charger.txt
@@ -0,0 +1,25 @@
+Maxim Semiconductor MAX8903 Battery Charger bindings
+
+Required properties:
+- compatible: "maxim,max8903" for MAX8903 Battery Charger
+- dok-gpios: Valid DC power has been detected (active low, input), optional if uok-gpios is provided
+- uok-gpios: Valid USB power has been detected (active low, input), optional if dok-gpios is provided
+
+Optional properties:
+- cen-gpios: Charge enable pin (active low, output)
+- chg-gpios: Charger status pin (active low, input)
+- flt-gpios: Fault pin (active low, output)
+- dcm-gpios: Current limit mode setting (DC=1 or USB=0, output)
+- usus-gpios: USB suspend pin (active high, output)
+
+
+Example:
+
+	max8903-charger {
+		compatible = "maxim,max8903";
+		dok-gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
+		flt-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
+		chg-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
+		cen-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
+		status = "okay";
+	};
diff --git a/arch/arm/boot/dts/dairytest-servo.dtsi b/arch/arm/boot/dts/dairytest-servo.dtsi
new file mode 100644
index 0000000..3fbe81d
--- /dev/null
+++ b/arch/arm/boot/dts/dairytest-servo.dtsi
@@ -0,0 +1,36 @@
+#include <dt-bindings/board/am335x-bbw-bbb-base.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/am33xx.h>
+
+&am33xx_pinmux {
+    servo_power_pin: pinmux_servo_power_pin{
+        pinctrl-single,pins = <
+            BONE_P9_27 (PIN_OUTPUT| MUX_MODE7)  /* ZCZ(C13) - gpio3_19, OUTPUT | MODE7 */
+        >;
+    };
+
+    ehrpwm2_pin: pinmux_ehrpwm2_pin{
+        pinctrl-single,pins = <
+            BONE_P8_19 (PIN_OUTPUT | MUX_MODE4) /* ZCZ(R1) - ehrpwm2a, OUTPUT | MODE3 */
+        >;
+    };
+};
+
+/ {
+    servo_power {
+        status = "okay";
+        compatible = "pinctrl-single";
+        pinctrl-names = "default";
+        pinctrl-0 = <&servo_power_pin>;
+    };
+};
+
+&epwmss2 {
+    status = "okay";
+};
+
+&ehrpwm2 {
+    pinctrl-names = "default";
+    pinctrl-0 = <&ehrpwm2_pin>;
+    status = "okay";
+};
-- 
1.9.1
