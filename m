From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v9 2/2] power: add documentation for ACT8945A's charger DT bindings
Date: Mon, 15 Feb 2016 16:22:04 +0800
Message-ID: <1455524524-9359-3-git-send-email-wenyou.yang@atmel.com>
References: <1455524524-9359-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.245]:46946 "EHLO
	DVREDG01.corp.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752311AbcBOI0X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 03:26:23 -0500
In-Reply-To: <1455524524-9359-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Lee Jones <lee.jones@linaro.org>, Peter Korsgaard <jacmet@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>

This patch adds documentation for the DT bindings of the charger
subdevice of ACT8945A MFD.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---

Changes in v9: None
Changes in v8:
 - due the mfd cell .of_compatible removal, update the compatibe
   description and example.

Changes in v7: None
Changes in v6: None
Changes in v5:
 - collect Reviewed-by from Krzysztof.

Changes in v4:
 - change the properties with more legible name, clearer description.

Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/power/act8945a-charger.txt |   35 ++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/act8945a-charger.txt

diff --git a/Documentation/devicetree/bindings/power/act8945a-charger.txt b/Documentation/devicetree/bindings/power/act8945a-charger.txt
new file mode 100644
index 0000000..bea254c
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/act8945a-charger.txt
@@ -0,0 +1,35 @@
+Device-Tree bindings for charger of Active-semi ACT8945A Multi-Function Device
+
+Required properties:
+ - compatible: "active-semi,act8945a", please refer to ../mfd/act8945a.txt.
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
+	pmic@5b {
+		compatible = "active-semi,act8945a";
+		reg = <0x5b>;
+		status = "okay";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_charger_chglev>;
+		active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
+		active-semi,input-voltage-threshold-microvolt = <6600>;
+		active-semi,precondition-timeout = <40>;
+		active-semi,total-timeout = <3>;
+	};
-- 
1.7.9.5

