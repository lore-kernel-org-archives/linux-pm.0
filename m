From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v8 09/11] doc: bindings: mfd: act8945a: Update the example
Date: Thu, 25 Aug 2016 15:38:35 +0800
Message-ID: <1472110715-22242-1-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472109599-21915-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Since the act8945a-charger is regarded as a sub-device and it using
"interrupts" property, update the examples section.

Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
