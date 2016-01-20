From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v5 2/2] power: add documentation for ACT8945A's charger DT bindings
Date: Wed, 20 Jan 2016 15:04:25 +0800
Message-ID: <1453273465-24060-3-git-send-email-wenyou.yang@atmel.com>
References: <1453273465-24060-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:12227 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757443AbcATHJi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 02:09:38 -0500
In-Reply-To: <1453273465-24060-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Lee Jones <lee.jones@linaro.org>, Peter Korsgaard <jacmet@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>

This patch adds documentation for the DT bindings of the charger
subdevice of ACT8945A MFD.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---

Changes in v5:
 - collect Reviewed-by from Krzysztof.

Changes in v4:
 - change the properties with more legible name, clearer description.

Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/power/act8945a-charger.txt |   33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/act8945a-charger.txt

diff --git a/Documentation/devicetree/bindings/power/act8945a-charger.txt b/Documentation/devicetree/bindings/power/act8945a-charger.txt
new file mode 100644
index 0000000..2055da7
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/act8945a-charger.txt
@@ -0,0 +1,33 @@
+Device-Tree bindings for charger of Active-semi ACT8945A Multi-Function Device
+
+Required properties:
+ - compatible: "active-semi,act8945a-charger".
+ - active-semi,chglev-gpios: charge current level phandle with args
+   as described in ../gpio/gpio.txt.
+
+Optional properties:
+ - active-semi,check-battery-temperature: boolean to check the battery
+   temperature or not.
+ - active-semi,input-voltage-threshold-microvolt: unit: mV;
+   Specifies the charger's input over-voltage threshold value;
+   The value can be: 6600, 7000, 7500, 8000; default: 6600
+ - active-semi,precondition-timeout: unit: minutes;
+   Specifies the charger's PRECONDITION safety timer setting value;
+   The value can be: 40, 60, 80, 0; If 0, it means to disable this timer;
+   default: 40.
+ - active-semi,total-timeout: unit: hours;
+   Specifies the charger's total safety timer setting value;
+   The value can be: 3, 4, 5, 0; If 0, it means to disable this timer;
+   default: 3.
+
+Example:
+
+	charger {
+		compatible = "active-semi,act8945a-charger";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_charger_chglev>;
+		active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
+		active-semi,input-voltage-threshold-microvolt = <6600>;
+		active-semi,precondition-timeout = <40>;
+		active-semi,total-timeout = <3>;
+	};
-- 
1.7.9.5

