From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH 13/13] dt: power: bq24257-charger: Cover additional devices
Date: Mon, 31 Aug 2015 21:10:35 -0500
Message-ID: <1441073435-12349-14-git-send-email-dannenberg@ti.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37603 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754723AbbIACME (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 31 Aug 2015 22:12:04 -0400
In-Reply-To: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

Extend the bq24257 charger's device tree documentation to cover the
bq24250 and bq24257 devices as well as recent feature additions.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 .../devicetree/bindings/power/bq24257.txt          | 59 ++++++++++++++++++++--
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/bq24257.txt b/Documentation/devicetree/bindings/power/bq24257.txt
index 5c9d394..36b115c 100644
--- a/Documentation/devicetree/bindings/power/bq24257.txt
+++ b/Documentation/devicetree/bindings/power/bq24257.txt
@@ -2,20 +2,71 @@ Binding for TI bq24257 Li-Ion Charger
 
 Required properties:
 - compatible: Should contain one of the following:
+ * "ti,bq24250"
+ * "ti,bq24251"
  * "ti,bq24257"
-- reg:			   integer, i2c address of the device.
+- reg: integer, i2c address of the device.
+- stat-gpio: GPIO used for the devices STAT_IN pin. Alternatively the pin can
+    also be defined through the standard interrupt definition properties (see
+    optional properties section below). Only use one method.
+- pg-gpio: GPIO used for the device PG (Power Good) pin. This pin is not
+    available on all devices and therefore only required on applicable devices.
+    However it is also possible to explicitly disable the use of this pin
+    through the optional property "ti,pg-gpio-disable" (see below) if desired.
+    In this case the "pg-gpio" property is no longer required.
 - ti,battery-regulation-voltage: integer, maximum charging voltage in uV.
-- ti,charge-current:	   integer, maximum charging current in uA.
-- ti,termination-current:  integer, charge will be terminated when current in
-			   constant-voltage phase drops below this value (in uA).
+- ti,charge-current: integer, maximum charging current in uA.
+- ti,termination-current: integer, charge will be terminated when current in
+    constant-voltage phase drops below this value (in uA).
+
+Optional properties:
+- ti,in-ilimit-autoset-disable: If this boolean property is present it disables
+    the automatic setting of the input current limit. This property is also set
+    implicitly on devices without charger type detection. If this property is
+    provided the input current limit should be set manually through
+    "ti,in-limit-current".
+- ti,in-limit-current: The maximum current to be drawn from the charger's input
+    (in uA). Use this for devices that don't have charger type detection or if
+    you have have set "ti,in-ilimit-autoset-disable".
+- ti,vovp-voltage: Configures the over voltage protection voltage (in uV).
+- ti,vindpm-voltage:  Configures the threshold input voltage for the dynamic
+    power path management (in uV).
+- ti,pg-gpio-disable: If this boolean property is provided a software-based
+    approach for power good determination is used. Note that the PG-pin based
+    approach is generally preferable.
+- ti,timer-2x-enable: If this boolean property is provided the device's safety
+    timer is extended by a factor of two.
+- interrupt-parent: Should be the phandle for the interrupt controller. Use in
+    conjunction with "interrupts" and only in case "stat-gpio" is not used.
+- interrupts: Interrupt mapping for GPIO IRQ (configure for both edges). Use in
+    conjunction with "interrupt-parent" and only in case "stat-gpio" is not
+    used.
 
 Example:
 
 bq24257 {
 	compatible = "ti,bq24257";
 	reg = <0x6a>;
+	stat-gpio = <&gpio1 16 GPIO_ACTIVE_HIGH>;
+	pg-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
 
 	ti,battery-regulation-voltage = <4200000>;
 	ti,charge-current = <1000000>;
 	ti,termination-current = <50000>;
 };
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
+	ti,in-limit-current = <900000>;
+	ti,vovp-voltage = <9500000>;
+	ti,vindpm-voltage = <4440000>;
+};
-- 
1.9.1

