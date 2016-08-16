From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v5 7/7] doc: bindings: act8945a-charger: Update properties
Date: Tue, 16 Aug 2016 16:59:58 +0800
Message-ID: <1471337998-6467-8-git-send-email-wenyou.yang@atmel.com>
References: <1471337998-6467-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1471337998-6467-1-git-send-email-wenyou.yang@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Due the driver improvements, update the properties,
 - Remove "active-semi,check-battery-temperature" property.
 - Add the properties, "active-semi,irq_gpio"
   and "active-semi,lbo-gpios".

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v5:
 - Add Acked-by tag.

Changes in v4:
 - Update the doc/binding for using "interrupts" property.

Changes in v3: None
Changes in v2: None

 .../bindings/power/supply/act8945a-charger.txt           | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt b/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
index bea254c..f9866c4 100644
--- a/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/act8945a-charger.txt
@@ -4,10 +4,15 @@ Required properties:
  - compatible: "active-semi,act8945a", please refer to ../mfd/act8945a.txt.
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
@@ -27,9 +32,14 @@ Example:
 		status = "okay";
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_charger_chglev>;
+		pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
+
 		active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
+		active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
 		active-semi,input-voltage-threshold-microvolt = <6600>;
 		active-semi,precondition-timeout = <40>;
 		active-semi,total-timeout = <3>;
+		interrupt-parent = <&pioA>;
+		interrupts = <45 GPIO_ACTIVE_LOW>;
+
 	};
-- 
2.7.4
