From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v5 1/8] devicetree: power: Add battery.txt
Date: Sat,  4 Feb 2017 01:15:56 -0800
Message-ID: <20170204091603.32242-2-liam@networkimprov.net>
References: <20170204091603.32242-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36863 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753745AbdBDJRo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Feb 2017 04:17:44 -0500
In-Reply-To: <20170204091603.32242-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, Matt Ranostay <matt@ranostay.consulting>, linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

From: Matt Ranostay <matt@ranostay.consulting>

From: Matt Ranostay <matt@ranostay.consulting>

Documentation of static battery characteristics that can be defined
for batteries which cannot self-identify. This information is required
by fuel-gauge and charger chips for proper handling of the battery.

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 .../devicetree/bindings/power/supply/battery.txt   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
new file mode 100644
index 0000000..d663c48
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -0,0 +1,39 @@
+Battery Characteristics
+
+Required Properties:
+ - compatible: Must be "fixed-battery"
+
+Optional Properties:
+ - voltage-min-design-microvolt: drained battery voltage
+ - voltage-max-design-microvolt: charged battery voltage
+ - energy-full-design-microwatt-hours: battery design energy
+ - charge-full-design-microamp-hours: battery design capacity
+
+Future Properties must be named for the corresponding elements in
+enum power_supply_property, defined in include/linux/power_supply.h.
+
+Batteries must be referenced by chargers and/or fuel-gauges
+using a phandle. The phandle's property should be named
+"monitored-battery".
+
+Example:
+
+	bat: battery {
+		compatible = "fixed-battery";
+		voltage-min-design-microvolt = <3200000>;
+		voltage-max-design-microvolt = <4200000>;
+		energy-full-design-microwatt-hours = <5290000>;
+		charge-full-design-microamp-hours = <1430000>;
+	};
+
+	charger: charger@0 {
+		....
+		monitored-battery = <&bat>;
+		...
+	};
+
+	fuel_gauge: fuel_gauge@0 {
+		....
+		monitored-battery = <&bat>;
+		...
+	};
-- 
2.9.3

