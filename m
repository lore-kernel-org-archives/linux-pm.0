From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 4/5] ARM: dove: add Dove PMU DT entries to dove.dtsi
Date: Sun, 27 Apr 2014 14:29:06 +0100
Message-ID: <E1WeP8k-0000Us-4w@rmk-PC.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:53697 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752944AbaD0N3K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Apr 2014 09:29:10 -0400
In-Reply-To: <20140427132312.GC26756@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/dove.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 187fd46b7b5e..64773e96e7f6 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -367,6 +367,13 @@
 				status = "disabled";
 			};
 
+			pmu: power-management@d0000 {
+				compatible = "marvell,pmu";
+				reg = <0xd0000 0x8000>, <0xd8000 0x8000>;
+				interrupts = <33>;
+				#reset-cells = <1>;
+			};
+
 			thermal: thermal-diode@d001c {
 				compatible = "marvell,dove-thermal";
 				reg = <0xd001c 0x0c>, <0xd005c 0x08>;
-- 
1.8.3.1

