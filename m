From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v4 2/8] devicetree: power: add battery state machine documentation
Date: Sun, 22 Jan 2017 14:22:12 -0800
Message-ID: <20170122222212.27086-1-liam@networkimprov.net>
References: <20170122071404.9654-3-matt@ranostay.consulting>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33242 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdAVWWY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2017 17:22:24 -0500
In-reply-to: <20170122071404.9654-3-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: sre@kernel.org, tony@atomide.com, Matt Ranostay <matt@ranostay.consulting>, Rob Herring <robh@kernel.org>

I think Matt meant the following :-)

Note: nominal-microvolt is not the correct term for termination voltage.
Changed to termination-microvolt
---

Documentation on battery properties that can be defined for
fine tuning fuel gauge state machines.

From: Matt Ranostay <matt@ranostay.consulting>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 .../devicetree/bindings/power/supply/battery.txt   | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
new file mode 100644
index 000000000000..398b4d622883
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -0,0 +1,34 @@
+Battery Characteristics
+
+Required Properties:
+ - compatible: Must be "fixed-battery"
+
+Optional Properties:
+ - termination-microvolt: dead battery voltage
+ - design-microwatt-hours: battery design energy
+ - design-microamp-hours: battery design capacity
+
+Batteries must be referenced by chargers and/or fuel-gauges
+using a phandle. The phandle's property should be named
+"monitored-battery".
+
+Example:
+
+	bat: battery {
+		compatible = "fixed-battery";
+		terminate-microvolt = <3700000>;
+		design-microwatt-hours = <5290000>;
+		design-microamp-hours = <1430000>;
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
