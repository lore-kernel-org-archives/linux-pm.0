From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: [PATCH v13 05/11] dt-bindings: power: supply: bq27xxx: Add monitored-battery documentation
Date: Wed,  3 May 2017 23:18:05 -0700
Message-ID: <20170504061811.18107-6-liam@networkimprov.net>
References: <20170504061811.18107-1-liam@networkimprov.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170504061811.18107-1-liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>

Document monitored-battery = <&battery_node>

Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/power/supply/bq27xxx.txt   | 31 +++++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
index b0c95ef..6858e1a 100644
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
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
