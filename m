From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v6 1/8] devicetree: power: Add battery.txt
Date: Fri, 10 Feb 2017 18:43:33 -0800
Message-ID: <20170211024340.19491-2-liam@networkimprov.net>
References: <20170211024340.19491-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34929 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752636AbdBKCoU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2017 21:44:20 -0500
In-Reply-To: <20170211024340.19491-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Matt Ranostay <matt@ranostay.consulting>

Documentation of static battery characteristics that can be defined
for batteries which cannot self-identify. This information is required
by fuel-gauge and charger chips for proper handling of the battery.

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 .../devicetree/bindings/power/supply/battery.txt   | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
new file mode 100644
index 0000000..d78a4aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -0,0 +1,37 @@
+Battery Characteristics
+
+Required Properties:
+ - compatible: Must be "fixed-battery"
+
+Optional Properties:
+ - voltage-min-design-microvolt: drained battery voltage
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
+		energy-full-design-microwatt-hours = <5290000>;
+		charge-full-design-microamp-hours = <1430000>;
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
2.9.3

