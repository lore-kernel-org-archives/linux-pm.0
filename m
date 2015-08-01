From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 1/2] ARM: dts: Add binding documentation for AXP20x pmic usb power supply
Date: Sat,  1 Aug 2015 10:39:37 +0200
Message-ID: <1438418378-32656-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56946 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbbHAIjn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 1 Aug 2015 04:39:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Lee Jones <lee.jones@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>

Add binding documentation for the usb power supply part of the AXP20x pmic.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Split out into a separate patch from the actual driver commit
Changes in v4:
-s/usb_power_supply/usb-power-supply/ in the dts example code
---
 .../bindings/power_supply/axp20x_usb_power.txt     | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt

diff --git a/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
new file mode 100644
index 0000000..862f4a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
@@ -0,0 +1,34 @@
+AXP20x USB power supply
+
+Required Properties:
+-compatible: "x-powers,axp202-usb-power-supply"
+
+This node is a subnode of the axp20x PMIC.
+
+Example:
+
+axp209: pmic@34 {
+	compatible = "x-powers,axp209";
+	reg = <0x34>;
+	interrupt-parent = <&nmi_intc>;
+	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	regulators {
+		x-powers,dcdc-freq = <1500>;
+
+		vdd_cpu: dcdc2 {
+			regulator-always-on;
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1450000>;
+			regulator-name = "vdd-cpu";
+		};
+
+		...
+	};
+
+	usb-power-supply: usb-power-supply {
+		compatible = "x-powers,axp202-usb-power-supply";
+	};
+};
-- 
2.4.3

