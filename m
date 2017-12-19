From: Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH v5 01/11] dt-bindings: thermal: Describe Armada AP806 and CP110
Date: Tue, 19 Dec 2017 14:57:09 +0100
Message-ID: <20171219135719.9531-2-miquel.raynal@free-electrons.com>
References: <20171219135719.9531-1-miquel.raynal@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55179 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763249AbdLSN5f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Dec 2017 08:57:35 -0500
In-Reply-To: <20171219135719.9531-1-miquel.raynal@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Miquel Raynal <miquel.raynal@free-electrons.com>, Baruch Siach <baruch@tkos.co.il>, David Sniatkiwicz <davidsn@marvell.com>

From: Baruch Siach <baruch@tkos.co.il>

Add compatible strings for AP806 and CP110 that are part of the Armada
8k/7k line of SoCs.

Add a note on the differences in the size of the control area in
different bindings. This is an existing difference between the Armada
375 binding and the other boards already supported. The new AP806 and
CP110 bindings are similar to the existing Armada 375 in this regard.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
[<miquel.raynal@free-electrons.com>: reword, additional details]
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 .../devicetree/bindings/thermal/armada-thermal.txt | 37 +++++++++++++++-------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
index 24aacf8948c5..e0d013a2e66d 100644
--- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
@@ -2,22 +2,35 @@
 
 Required properties:
 
-- compatible:	Should be set to one of the following:
-		marvell,armada370-thermal
-		marvell,armada375-thermal
-		marvell,armada380-thermal
-		marvell,armadaxp-thermal
+- compatible: Should be set to one of the following:
+    * marvell,armada370-thermal
+    * marvell,armada375-thermal
+    * marvell,armada380-thermal
+    * marvell,armadaxp-thermal
+    * marvell,armada-ap806-thermal
+    * marvell,armada-cp110-thermal
 
-- reg:		Device's register space.
-		Two entries are expected, see the examples below.
-		The first one is required for the sensor register;
-		the second one is required for the control register
-		to be used for sensor initialization (a.k.a. calibration).
+- reg: Device's register space.
+  Two entries are expected, see the examples below. The first one points
+  to the status register (4B). The second one points to the control
+  registers (8B).
+  Note: The compatibles marvell,armada370-thermal,
+  marvell,armada380-thermal, and marvell,armadaxp-thermal must point to
+  "control MSB/control 1", with size of 4 (deprecated binding), or point
+  to "control LSB/control 0" with size of 8 (current binding). All other
+  compatibles must point to "control LSB/control 0" with size of 8.
 
-Example:
+Examples:
 
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
+	};
-- 
2.11.0
