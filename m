From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 10/16] ARM: mvebu: add CA9 MPcore SoC Controller node
Date: Wed, 23 Jul 2014 15:00:47 +0200
Message-ID: <1406120453-29291-11-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40725 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753813AbaGWNBH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 09:01:07 -0400
In-Reply-To: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devicetree@vger.kernel.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

The CA9 MPcore SoC Control block is a set of registers that allows to
configure certain internal aspects of the core blocks of the SoC
(Cortex-A9, L2 cache controller, etc.). In most cases, the default
values are fine so they aren't many reasons to touch those registers,
but there is one exception: to support cpuidle on Armada 38x, we need
to modify the value of the CA9 MPcore Reset Control register.

Therefore, this commit adds a new Device Tree binding for this
hardware block, and uses this new binding for the Armada 38x Device
Tree file.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt | 14 ++++++++++++++
 arch/arm/boot/dts/armada-38x.dtsi                          |  5 +++++
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt b/Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt
new file mode 100644
index 0000000..8781073
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada-380-mpcore-soc-ctrl.txt
@@ -0,0 +1,14 @@
+Marvell Armada 38x CA9 MPcore SoC Controller
+============================================
+
+Required properties:
+
+- compatible: Should be "marvell,armada-380-mpcore-soc-ctrl".
+
+- reg: should be the register base and length as documented in the
+  datasheet for the CA9 MPcore SoC Control registers
+
+mpcore-soc-ctrl@20d20 {
+	compatible = "marvell,armada-380-mpcore-soc-ctrl";
+	reg = <0x20d20 0x6c>;
+};
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 689fa1a..242d0ec 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -286,6 +286,11 @@
 				reg = <0x20800 0x10>;
 			};
 
+			mpcore-soc-ctrl@20d20 {
+				compatible = "marvell,armada-380-mpcore-soc-ctrl";
+				reg = <0x20d20 0x6c>;
+			};
+
 			coherency-fabric@21010 {
 				compatible = "marvell,armada-380-coherency-fabric";
 				reg = <0x21010 0x1c>;
-- 
2.0.0

