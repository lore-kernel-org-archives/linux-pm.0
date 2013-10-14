From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 14/14] ARM: dts: mvebu: Add a new set of registers to the PMSU node
Date: Mon, 14 Oct 2013 15:58:26 +0200
Message-ID: <1381759106-15004-15-git-send-email-gregory.clement@free-electrons.com>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60903 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756084Ab3JNN7B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 09:59:01 -0400
In-Reply-To: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>, devicetree@vger.kernel.org

The Power Management Unit Service block also controls the Coherency
Fabric subsystem. This new set of registers is needed for the CPU idle
implementation for the Armada XP, it allows to enter in a deep CPU
idle state where the Coherency Fabric and the L2 cache are powerdown.

Cc: devicetree@vger.kernel.org
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt | 12 +++++++-----
 arch/arm/boot/dts/armada-xp.dtsi                             |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
index 926b4d6..8a9db0c 100644
--- a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
+++ b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
@@ -7,14 +7,16 @@ Required properties:
 - compatible: "marvell,armada-370-xp-pmsu"
 
 - reg: Should contain PMSU registers location and length. First pair
-  for the per-CPU SW Reset Control registers, second pair for the
-  Power Management Service Unit.
+  for the per-CPU SW Reset Control registers, second pair for the CPU
+  Power Management Service Unit registers, third pair for the Fabric Power
+  Management Service Unit registers.
 
 Example:
 
-armada-370-xp-pmsu@d0022000 {
+armada-370-xp-pmsu@22000 {
 	compatible = "marvell,armada-370-xp-pmsu";
-	reg = <0xd0022100 0x430>,
-	      <0xd0020800 0x20>;
+	reg = <0x22100 0x430>,
+	      <0x20800 0x20>,
+	      <0x22000 0x24>;
 };
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 3058522..25ec8cd 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -48,7 +48,7 @@
 
 			armada-370-xp-pmsu@22000 {
 				compatible = "marvell,armada-370-xp-pmsu";
-				reg = <0x22100 0x430>, <0x20800 0x20>;
+				reg = <0x22100 0x430>, <0x20800 0x20>, <0x22000 0x24>;
 			};
 
 			serial@12200 {
-- 
1.8.1.2

