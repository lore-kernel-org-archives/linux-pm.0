From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v2 1/4] dt-bindings: thermal/armada: describe AP806 and CP110
Date: Sun,  3 Dec 2017 13:11:21 +0200
Message-ID: <f8c589337a4fb78852eadf15058e8f8d132d4dc0.1512299484.git.baruch@tkos.co.il>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:57331 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbdLCLSx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 Dec 2017 06:18:53 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, Miquel Raynal <miquel.raynal@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baruch Siach <baruch@tkos.co.il>

Add compatible strings for AP806 and CP110 that are part of the Armada 8k/7k
line of SoCs.

Add a note on the difference in the size of the control area in different
bindings. This is an existing difference between the Armada 375 binding and
the rest. The new AP806 and CP110 bindings are similar to the existing Armada
375 in this regard.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2: No change
---
 Documentation/devicetree/bindings/thermal/armada-thermal.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
index 24aacf8948c5..eec57f509166 100644
--- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
@@ -7,12 +7,19 @@ Required properties:
 		marvell,armada375-thermal
 		marvell,armada380-thermal
 		marvell,armadaxp-thermal
+		marvell,armada-ap806-thermal
+		marvell,armada-cp110-thermal
 
 - reg:		Device's register space.
 		Two entries are expected, see the examples below.
 		The first one is required for the sensor register;
-		the second one is required for the control register
+		the second one is required for the control area
 		to be used for sensor initialization (a.k.a. calibration).
+		The size of the control area must be 4 for
+		marvell,armada370-thermal, marvell,armada380-thermal, and
+		marvell,armadaxp-thermal. The size must be 8 for
+		marvell,armada375-thermal, marvell,armada-ap806-thermal, and
+		marvell,armada-cp110-thermal.
 
 Example:
 
-- 
2.15.0
