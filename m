From: Michael Haas <haas@computerlinguist.org>
Subject: [PATCH v3 3/5] ARM: dts: Add binding documentation for AXP20x pmic ac power supply
Date: Thu,  5 May 2016 12:35:06 +0200
Message-ID: <1462444508-9363-4-git-send-email-haas@computerlinguist.org>
References: <1462444508-9363-1-git-send-email-haas@computerlinguist.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:48589 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756680AbcEEKf0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 May 2016 06:35:26 -0400
In-Reply-To: <1462444508-9363-1-git-send-email-haas@computerlinguist.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, maxime.ripard@free-electrons.com, wens@csie.org, lee.jones@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: hdegoede@redhat.com, bonbons@linux-vserver.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-sunxi@googlegroups.com, Michael Haas <haas@computerlinguist.org>

Add binding documentation for the ac power supply part of the AXP20x
pmic.

Signed-off-by: Michael Haas <haas@computerlinguist.org>
---
 .../bindings/power_supply/axp20x_ac_power.txt           | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt

diff --git a/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt
new file mode 100644
index 0000000..1cebe35
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt
@@ -0,0 +1,17 @@
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
+
+	ac-power-supply: ac-power-supply {
+		compatible = "x-powers,axp202-ac-power-supply";
+	};
+
+	...
+};
-- 
2.8.2

