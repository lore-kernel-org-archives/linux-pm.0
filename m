From: Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH v3 01/11] dt-bindings: thermal: Describe Armada AP806 and CP110
Date: Thu, 14 Dec 2017 11:30:01 +0100
Message-ID: <20171214103011.24713-2-miquel.raynal@free-electrons.com>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57124 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbdLNKaW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Dec 2017 05:30:22 -0500
In-Reply-To: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Miquel Raynal <miquel.raynal@free-electrons.com>, Baruch Siach <baruch@tkos.co.il>, David Sniatkiwicz <davidsn@marvell.com>

From: Baruch Siach <baruch@tkos.co.il>

Add compatible strings for AP806 and CP110 that are part of the Armada
8k/7k line of SoCs.

Add a note on the differences in the size of the control area in
different bindings. This is an existing difference between the Armada
375 binding and the other boards already supported. The new AP806 and
CP110 bindings are similar to the existing Armada 375 in this regard.

Also add a note about the new property "marvell,thermal-zone-name" to
help identify the zones from the sysfs.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
[<miquel.raynal@free-electrons.com>: reword, additional details, new
property]
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 .../devicetree/bindings/thermal/armada-thermal.txt | 29 ++++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
index 24aacf8948c5..1602dc2ee220 100644
--- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
@@ -7,17 +7,36 @@ Required properties:
 		marvell,armada375-thermal
 		marvell,armada380-thermal
 		marvell,armadaxp-thermal
+		marvell,armada-ap806-thermal
+		marvell,armada-cp110-thermal
 
 - reg:		Device's register space.
 		Two entries are expected, see the examples below.
-		The first one is required for the sensor register;
-		the second one is required for the control register
-		to be used for sensor initialization (a.k.a. calibration).
+		The first one points to the status register (4B).
+		The second one points to the control registers (8B).
+		Note: with legacy bindings, the second entry pointed
+		only on the so called "control MSB" ("control 1"), was
+		4B wide and did not let the possibility to reach the
+		"control LSB" ("control 0") register.
 
-Example:
+Optional properties:
 
+- marvell,thermal-zone-name: The name to identify the thermal zone
+                             within the sysfs, useful when multiple
+                             thermal zones are registered (AP, CPx...).
+
+Examples:
+
+	/* Legacy bindings */
 	thermal@d0018300 {
 		compatible = "marvell,armada370-thermal";
-                reg = <0xd0018300 0x4
+		reg = <0xd0018300 0x4
 		       0xd0018304 0x4>;
 	};
+
+	ap_thermal: thermal@6f8084 {
+		compatible = "marvell,armada-ap806-thermal";
+		reg = <0x6f808C 0x4>,
+		      <0x6f8084 0x8>;
+		marvell,thermal-zone-name = "ap_thermal_zone";
+	};
-- 
2.11.0
