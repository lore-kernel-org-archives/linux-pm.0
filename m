From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v14 05/11] dt-bindings: power: supply: bq27xxx: Add monitored-battery documentation
Date: Wed,  7 Jun 2017 11:37:53 -0700
Message-ID: <20170607183759.20261-6-liam@networkimprov.net>
References: <20170607183759.20261-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35925 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752394AbdFGSif (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 14:38:35 -0400
In-Reply-To: <20170607183759.20261-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Document monitored-battery = <&battery_node>

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/power/supply/bq27xxx.txt   | 31 +++++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
index b0c95ef6..6858e1a8 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
@@ -1,7 +1,7 @@
-Binding for TI BQ27XXX fuel gauge family
+TI BQ27XXX fuel gauge family
 
 Required properties:
-- compatible: Should contain one of the following:
+- compatible: contains one of the following:
  * "ti,bq27200" - BQ27200
  * "ti,bq27210" - BQ27210
  * "ti,bq27500" - deprecated, use revision specific property below
@@ -26,11 +26,28 @@ Required properties:
  * "ti,bq27425" - BQ27425
  * "ti,bq27441" - BQ27441
  * "ti,bq27621" - BQ27621
-- reg: integer, i2c address of the device.
+- reg: integer, I2C address of the fuel gauge.
+
+Optional properties:
+- monitored-battery: phandle of battery characteristics node
+    The fuel gauge uses the following battery properties:
+    + energy-full-design-microwatt-hours
+    + charge-full-design-microamp-hours
+    + voltage-min-design-microvolt
+  Both or neither of the *-full-design-*-hours properties must be set.
+  See Documentation/devicetree/bindings/power/supply/battery.txt
 
 Example:
 
-bq27510g3 {
-    compatible = "ti,bq27510g3";
-    reg = <0x55>;
-};
+	bat: battery {
+		compatible = "simple-battery";
+		voltage-min-design-microvolt = <3200000>;
+		energy-full-design-microwatt-hours = <5290000>;
+		charge-full-design-microamp-hours = <1430000>;
+	};
+
+	bq27510g3: fuel-gauge@55 {
+		compatible = "ti,bq27510g3";
+		reg = <0x55>;
+		monitored-battery = <&bat>;
+	};
-- 
2.13.0
