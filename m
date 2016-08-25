From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v8 10/11] doc: bindings: power: act8945a-charger: Update properties.
Date: Thu, 25 Aug 2016 15:40:26 +0800
Message-ID: <1472110826-22328-1-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>
List-Id: linux-pm@vger.kernel.org

Due the driver improvements, update the properties,
 - Remove "active-semi,check-battery-temperature" property.
 - Add the properties, "active-semi,irq_gpio"
   and "active-semi,lbo-gpios".
 - As act8945a-charger is regarded as a sub-device, update
   the compatible and examples.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v8:
 - Since the act8945a-charger is regarded as a sub-device, update
   the compatible decription and examples.

Changes in v7: None
Changes in v6: None
Changes in v5:
 - Add Acked-by tag.

Changes in v4:
 - Update the doc/binding for using "interrupts" property.

Changes in v3: None
Changes in v2: None

 .../bindings/power/supply/act8945a-charger.txt     | 31 +++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt b/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
index bea254c..de78d76 100644
--- a/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
@@ -1,13 +1,18 @@
 Device-Tree bindings for charger of Active-semi ACT8945A Multi-Function Device
 
 Required properties:
- - compatible: "active-semi,act8945a", please refer to ../mfd/act8945a.txt.
+ - compatible: "active-semi,act8945a-charger".
  - active-semi,chglev-gpios: charge current level phandle with args
    as described in ../gpio/gpio.txt.
+ - active-semi,lbo-gpios: specify the low battery voltage detect phandle
+   with args as as described in ../gpio/gpio.txt.
+ - interrupts: <a b> where a is the interrupt number and b is a
+   field that represents an encoding of the sense and level
+   information for the interrupt.
+ - interrupt-parent: the phandle for the interrupt controller that
+   services interrupts for this device.
 
 Optional properties:
- - active-semi,check-battery-temperature: boolean to check the battery
-   temperature or not.
  - active-semi,input-voltage-threshold-microvolt: unit: mV;
    Specifies the charger's input over-voltage threshold value;
    The value can be: 6600, 7000, 7500, 8000; default: 6600
@@ -26,10 +31,18 @@ Example:
 		reg = <0x5b>;
 		status = "okay";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_charger_chglev>;
-		active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
-		active-semi,input-voltage-threshold-microvolt = <6600>;
-		active-semi,precondition-timeout = <40>;
-		active-semi,total-timeout = <3>;
+		charger {
+			compatible = "active-semi,act8945a-charger";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
+			interrupt-parent = <&pioA>;
+			interrupts = <45 GPIO_ACTIVE_LOW>;
+
+			active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
+			active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
+			active-semi,input-voltage-threshold-microvolt = <6600>;
+			active-semi,precondition-timeout = <40>;
+			active-semi,total-timeout = <3>;
+			status = "okay";
+		};
 	};
-- 
2.7.4
