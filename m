From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: [PATCH v8 1/9] devicetree: power: Add battery.txt
Date: Sun, 26 Feb 2017 23:11:09 -0800
Message-ID: <20170227071117.18934-2-liam@networkimprov.net>
References: <20170227071117.18934-1-liam@networkimprov.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170227071117.18934-1-liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>

Documentation of static battery characteristics that can be defined
for batteries which cannot self-identify. This information is required
by fuel-gauge and charger chips for proper handling of the battery.

Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
---
 .../devicetree/bindings/power/supply/battery.txt   | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
new file mode 100644
index 0000000..3d916bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -0,0 +1,42 @@
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
+Driver code should call power_supply_get_battery_info() to obtain
+battery properties via monitored-battery. For details see:
+  drivers/power/supply/power_supply_core.c
+  drivers/power/supply/bq27xxx_battery.c
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
