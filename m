From: Michael Haas <haas@computerlinguist.org>
Subject: [PATCH v2 4/6] ARM: dts: Add binding documentation for AXP20x pmic ac power supply
Date: Sun,  1 May 2016 10:57:25 +0200
Message-ID: <1462093047-7885-5-git-send-email-haas@computerlinguist.org>
References: <1462093047-7885-1-git-send-email-haas@computerlinguist.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:55363 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbcEAI56 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 1 May 2016 04:57:58 -0400
In-Reply-To: <1462093047-7885-1-git-send-email-haas@computerlinguist.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, maxime.ripard@free-electrons.com, wens@csie.org, lee.jones@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: degoede@redhat.com, bonbons@linux-vserver.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-sunxi@googlegroups.com, Michael Haas <haas@computerlinguist.org>

Add binding documentation for the ac power supply part of the AXP20x
pmic.

Signed-off-by: Michael Haas <haas@computerlinguist.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power_supply/axp20x_ac_power.txt      | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt

diff --git a/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt
new file mode 100644
index 0000000..1cbdcfb
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt
@@ -0,0 +1,34 @@
+AXP20x AC power supply
+
+Required Properties:
+-compatible: "x-powers,axp202-ac-power-supply"
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
+	ac-power-supply: ac-power-supply {
+		compatible = "x-powers,axp202-ac-power-supply";
+	};
+};
-- 
2.8.0

