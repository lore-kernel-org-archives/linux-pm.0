From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v14 02/11] dt-bindings: power: supply: Add battery.txt with simple-battery binding
Date: Wed,  7 Jun 2017 11:37:50 -0700
Message-ID: <20170607183759.20261-3-liam@networkimprov.net>
References: <20170607183759.20261-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35457 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbdFGSi1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 14:38:27 -0400
In-Reply-To: <20170607183759.20261-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Documentation of static battery characteristics that can be defined
for batteries that do not embed this data, which are required by
fuel-gauge and charger chips for proper handling of the battery.

The following properties are defined:
  voltage-min-design-microvolt
  charge-full-design-microamp-hours
  energy-full-design-microwatt-hours
  precharge-current-microamp
  charge-term-current-microamp
  constant-charge-current-max-microamp
  constant-charge-voltage-max-microamp

Property names are derived from corresponding elements in
enum power_supply_property from include/linux/power_supply.h
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/power_supply.h

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/power/supply/battery.txt   | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
new file mode 100644
index 00000000..f4d3b4a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -0,0 +1,57 @@
+Battery Characteristics
+
+The devicetree battery node provides static battery characteristics.
+In smart batteries, these are typically stored in non-volatile memory
+on a fuel gauge chip. The battery node should be used where there is
+no appropriate non-volatile memory, or it is unprogrammed/incorrect.
+
+Upstream dts files should not include battery nodes, unless the battery
+represented cannot easily be replaced in the system by one of a
+different type. This prevents unpredictable, potentially harmful,
+behavior should a replacement that changes the battery type occur
+without a corresponding update to the dtb.
+
+Required Properties:
+ - compatible: Must be "simple-battery"
+
+Optional Properties:
+ - voltage-min-design-microvolt: drained battery voltage
+ - energy-full-design-microwatt-hours: battery design energy
+ - charge-full-design-microamp-hours: battery design capacity
+ - precharge-current-microamp: current for pre-charge phase
+ - charge-term-current-microamp: current for charge termination phase
+ - constant-charge-current-max-microamp: maximum constant input current
+ - constant-charge-voltage-max-microvolt: maximum constant input voltage
+
+Battery properties are named, where possible, for the corresponding
+elements in enum power_supply_property, defined in
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/power_supply.h
+
+Batteries must be referenced by chargers and/or fuel-gauges
+using a phandle. The phandle's property should be named
+"monitored-battery".
+
+Example:
+
+	bat: battery {
+		compatible = "simple-battery";
+		voltage-min-design-microvolt = <3200000>;
+		energy-full-design-microwatt-hours = <5290000>;
+		charge-full-design-microamp-hours = <1430000>;
+		precharge-current-microamp = <256000>;
+		charge-term-current-microamp = <128000>;
+		constant-charge-current-max-microamp = <900000>;
+		constant-charge-voltage-max-microvolt = <4200000>;
+	};
+
+	charger: charger@11 {
+		....
+		monitored-battery = <&bat>;
+		...
+	};
+
+	fuel_gauge: fuel-gauge@22 {
+		....
+		monitored-battery = <&bat>;
+		...
+	};
-- 
2.13.0
