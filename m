From: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 13/13] dt: power: bq2425x-charger: Cover additional devices
Date: Tue, 8 Sep 2015 19:12:37 -0500
Message-ID: <1441757557-7266-14-git-send-email-dannenberg@ti.com>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441757557-7266-1-git-send-email-dannenberg-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Extend the bq2425x charger's device tree documentation to cover the
bq24250 and bq24257 devices as well as recent feature additions.

Signed-off-by: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/power/bq24257.txt          | 21 -------
 .../devicetree/bindings/power/bq2425x.txt          | 70 ++++++++++++++++++++++
 2 files changed, 70 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/bq24257.txt
 create mode 100644 Documentation/devicetree/bindings/power/bq2425x.txt

diff --git a/Documentation/devicetree/bindings/power/bq24257.txt b/Documentation/devicetree/bindings/power/bq24257.txt
deleted file mode 100644
index 5c9d394..0000000
--- a/Documentation/devicetree/bindings/power/bq24257.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Binding for TI bq24257 Li-Ion Charger
-
-Required properties:
-- compatible: Should contain one of the following:
- * "ti,bq24257"
-- reg:			   integer, i2c address of the device.
-- ti,battery-regulation-voltage: integer, maximum charging voltage in uV.
-- ti,charge-current:	   integer, maximum charging current in uA.
-- ti,termination-current:  integer, charge will be terminated when current in
-			   constant-voltage phase drops below this value (in uA).
-
-Example:
-
-bq24257 {
-	compatible = "ti,bq24257";
-	reg = <0x6a>;
-
-	ti,battery-regulation-voltage = <4200000>;
-	ti,charge-current = <1000000>;
-	ti,termination-current = <50000>;
-};
diff --git a/Documentation/devicetree/bindings/power/bq2425x.txt b/Documentation/devicetree/bindings/power/bq2425x.txt
new file mode 100644
index 0000000..3e171c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/bq2425x.txt
@@ -0,0 +1,70 @@
+Binding for TI bq2425x Li-Ion Charger
+
+Required properties:
+- compatible: Should contain one of the following:
+ * "ti,bq24250"
+ * "ti,bq24251"
+ * "ti,bq24257"
+- reg: integer, i2c address of the device.
+- stat-gpios: GPIO used for the devices STAT_IN pin. Alternatively the pin can
+    also be defined through the standard interrupt definition properties (see
+    optional properties section below). Only use one method.
+- ti,battery-regulation-voltage: integer, maximum charging voltage in uV.
+- ti,charge-current: integer, maximum charging current in uA.
+- ti,termination-current: integer, charge will be terminated when current in
+    constant-voltage phase drops below this value (in uA).
+
+Optional properties:
+- pg-gpios: GPIO used for connecting the bq2425x device PG (Power Good) pin.
+    This pin is not available on all devices however it should be used if
+    possible as this is the recommended way to obtain the charger's input PG
+    state. If this pin is not specified a software-based approach for PG
+    detection is used.
+- ti,current-limit: The maximum current to be drawn from the charger's input
+    (in uA). If this property is not specified a USB D+/D- signal based charger
+    type detection is used (if available) and the input limit current is set
+    accordingly. If the D+/D- based detection is not available on a given device
+    a default of 500,000 is used (=500mA).
+- ti,ovp-voltage: Configures the over voltage protection voltage (in uV). If
+    not specified a default of 6,5000,000 (=6.5V) is used.
+- ti,in-dpm-voltage: Configures the threshold input voltage for the dynamic
+    power path management (in uV). If not specified a default of 4,360,000
+    (=4.36V) is used.
+- ti,safety-timer-2x-enable: If this property is set to 1 the device's safety
+    timer is extended (slowed down) by a factor of two. Setting this property
+    to 0 or not providing it will leave the safety timer at its default
+    setting.
+- interrupt-parent: Should be the phandle for the interrupt controller. Use in
+    conjunction with "interrupts" and only in case "stat-gpios" is not used.
+- interrupts: Interrupt mapping for GPIO IRQ (configure for both edges). Use in
+    conjunction with "interrupt-parent" and only in case "stat-gpios" is not
+    used.
+
+Example:
+
+bq24257 {
+	compatible = "ti,bq24257";
+	reg = <0x6a>;
+	stat-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
+	pg-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+
+	ti,battery-regulation-voltage = <4200000>;
+	ti,charge-current = <1000000>;
+	ti,termination-current = <50000>;
+};
+
+Example:
+
+bq24250 {
+	compatible = "ti,bq24250";
+	reg = <0x6a>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <16 IRQ_TYPE_EDGE_BOTH>;
+
+	ti,battery-regulation-voltage = <4200000>;
+	ti,charge-current = <500000>;
+	ti,termination-current = <50000>;
+	ti,current-limit = <900000>;
+	ti,ovp-voltage = <9500000>;
+	ti,in-dpm-voltage = <4440000>;
+};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
