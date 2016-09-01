From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v9 4/4] ARM: at91/dt: sama5d2_xplained: Add act8945a-charger node.
Date: Thu, 1 Sep 2016 17:30:01 +0800
Message-ID: <1472722201-31872-5-git-send-email-wenyou.yang@atmel.com>
References: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, Wenyou Yang <wenyou.yang@microchip.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>
List-Id: linux-pm@vger.kernel.org

Add act8945a-charger as a sub-device node.
Use the "interrupts" property, instead of the "active-semi,irq_gpios"
to denote the act8945a chager's irq.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v9:
 - Not include seven patches which have been queued or applied.

Changes in v8:
 - Add 4 new patches: 1/11, 2/11, 9/11, and 11/11.

Changes in v7: None
Changes in v6: None
Changes in v4: None

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 0b9a59d..87eff10 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -162,14 +162,6 @@
 					compatible = "active-semi,act8945a";
 					reg = <0x5b>;
 					active-semi,vsel-high;
-					active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
-					active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
-					active-semi,irq_gpios = <&pioA 45 GPIO_ACTIVE_LOW>;
-					active-semi,input-voltage-threshold-microvolt = <6600>;
-					active-semi,precondition-timeout = <40>;
-					active-semi,total-timeout = <3>;
-					pinctrl-names = "default";
-					pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
 					status = "okay";
 
 					regulators {
@@ -222,6 +214,21 @@
 							regulator-always-on;
 						};
 					};
+
+					charger {
+						compatible = "active-semi,act8945a-charger";
+						pinctrl-names = "default";
+						pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
+						interrupt-parent = <&pioA>;
+						interrupts = <45 GPIO_ACTIVE_LOW>;
+
+						active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
+						active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
+						active-semi,input-voltage-threshold-microvolt = <6600>;
+						active-semi,precondition-timeout = <40>;
+						active-semi,total-timeout = <3>;
+						status = "okay";
+					};
 				};
 			};
 
-- 
2.7.4
