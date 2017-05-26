From: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v3 1/4] dt-bindings: power: supply: add battery charge voltage/current
Date: Fri, 26 May 2017 13:04:10 +0200
Message-ID: <20170526110413.24836-1-enric.balletbo@collabora.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Add charging voltage and current characteristics to the battery DT for
proper handling of the battery by fuel-gauge and charger chips.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---
Changes since v2:
 - Requested by Sebastian Reichel
   - Move to its own patch and apply to simple-battery framework.
Changes since v1:
 - Requested by Rob Herring
   - Rename ti,charge-* to charge-* to be standard properties.
   - Use unit suffixes as per bindings/property-units.txt

 Documentation/devicetree/bindings/power/supply/battery.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 63a7028..c87a439 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -12,6 +12,8 @@ Optional Properties:
  - voltage-min-design-microvolt: drained battery voltage
  - energy-full-design-microwatt-hours: battery design energy
  - charge-full-design-microamp-hours: battery design capacity
+ - charge-voltage-microvolt: battery charging voltage
+ - charge-current-microamp: battery charging current
 
 Batteries must be referenced by chargers and/or fuel-gauges
 using a phandle. The phandle's property should be named
@@ -24,6 +26,8 @@ Example:
 		voltage-min-design-microvolt = <3200000>;
 		energy-full-design-microwatt-hours = <5290000>;
 		charge-full-design-microamp-hours = <1430000>;
+		charge-voltage-microvolt = <4100000>;
+		charge-current-microamp = <300000>;
 	};
 
 	charger: charger@11 {
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
