From: Michael Haas <haas@computerlinguist.org>
Subject: [PATCH v2 5/6] ARM: dts: axp209: Add ac_power_supply child node to the ax209 node
Date: Sun,  1 May 2016 10:57:26 +0200
Message-ID: <1462093047-7885-6-git-send-email-haas@computerlinguist.org>
References: <1462093047-7885-1-git-send-email-haas@computerlinguist.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:55379 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbcEAI57 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 1 May 2016 04:57:59 -0400
In-Reply-To: <1462093047-7885-1-git-send-email-haas@computerlinguist.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, maxime.ripard@free-electrons.com, wens@csie.org, lee.jones@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: degoede@redhat.com, bonbons@linux-vserver.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-sunxi@googlegroups.com, Michael Haas <haas@computerlinguist.org>

Add a node representing the ac power supply part of the axp209 pmic.

Signed-off-by: Michael Haas <haas@computerlinguist.org>
---
 arch/arm/boot/dts/axp209.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index 051ab3b..9046f0a 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -94,4 +94,10 @@
 		compatible = "x-powers,axp202-usb-power-supply";
 		status = "disabled";
 	};
+
+	ac_power_supply: ac_power_supply {
+		compatible = "x-powers,axp202-ac-power-supply";
+		status = "disabled";
+	};
+
 };
-- 
2.8.0

