From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v9 3/4] doc: bindings: mfd: act8945a: Update the example
Date: Thu, 1 Sep 2016 17:30:00 +0800
Message-ID: <1472722201-31872-4-git-send-email-wenyou.yang@atmel.com>
References: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.246]:7698 "EHLO
        ussmtp01.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932470AbcIAJc5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2016 05:32:57 -0400
In-Reply-To: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, Wenyou Yang <wenyou.yang@microchip.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>

Since the act8945a-charger is regarded as a sub-device and it using
"interrupts" property, update the examples section.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v4: None

 Documentation/devicetree/bindings/mfd/act8945a.txt | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/act8945a.txt b/Documentation/devicetree/bindings/mfd/act8945a.txt
index f712830..462819a 100644
--- a/Documentation/devicetree/bindings/mfd/act8945a.txt
+++ b/Documentation/devicetree/bindings/mfd/act8945a.txt
@@ -14,13 +14,6 @@ Example:
 		reg = <0x5b>;
 		status = "okay";
 
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_charger_chglev>;
-		active-semi,chglev-gpio = <&pioA 12 GPIO_ACTIVE_HIGH>;
-		active-semi,input-voltage-threshold-microvolt = <6600>;
-		active-semi,precondition-timeout = <40>;
-		active-semi,total-timeout = <3>;
-
 		active-semi,vsel-high;
 
 		regulators {
@@ -73,4 +66,19 @@ Example:
 				regulator-always-on;
 			};
 		};
+
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

