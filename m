From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: [PATCH v9 3/8] devicetree: power: bq27xxx: Add monitored-battery documentation
Date: Sun,  5 Mar 2017 23:25:34 -0800
Message-ID: <20170306072539.980-4-liam@networkimprov.net>
References: <20170306072539.980-1-liam@networkimprov.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170306072539.980-1-liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>

Document monitored-battery = <&battery_node>

Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Signed-off-by: Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/power/supply/bq27xxx.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
index b0c95ef..cf83371 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
@@ -28,9 +28,18 @@ Required properties:
  * "ti,bq27621" - BQ27621
 - reg: integer, i2c address of the device.
 
+Optional properties:
+- monitored-battery: phandle of battery information devicetree node
+
+  See Documentation/devicetree/bindings/power/supply/battery.txt
+  If either of the referenced battery's *-full-design-*-hours properties are set,
+  then both must be.
+
 Example:
 
-bq27510g3 {
+bq27510g3 : fuel-gauge@55 {
     compatible = "ti,bq27510g3";
     reg = <0x55>;
+
+    monitored-battery = <&bat>;
 };
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
