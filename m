From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH] thermal: trivial: fix the typo
Date: Tue,  3 May 2016 20:07:41 +0800
Message-ID: <1462277262-29935-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jiri Kosina <trivial@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

See the thermal code, the obvious typo from my editor.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 Documentation/devicetree/bindings/thermal/thermal.txt | 10 +++++-----
 drivers/thermal/thermal_core.c                        |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index 41b817f..88b6ea1 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -62,7 +62,7 @@ For more examples of cooling devices, refer to the example sections below.
 Required properties:
 - #cooling-cells:	Used to provide cooling device specific information
   Type: unsigned	while referring to it. Must be at least 2, in order
-  Size: one cell      	to specify minimum and maximum cooling state used
+  Size: one cell	to specify minimum and maximum cooling state used
 			in the reference. The first cell is the minimum
 			cooling state requested and the second cell is
 			the maximum cooling state requested in the reference.
@@ -119,7 +119,7 @@ Required properties:
 Optional property:
 - contribution:		The cooling contribution to the thermal zone of the
   Type: unsigned	referred cooling device at the referred trip point.
-  Size: one cell      	The contribution is a ratio of the sum
+  Size: one cell	The contribution is a ratio of the sum
 			of all cooling contributions within a thermal zone.
 
 Note: Using the THERMAL_NO_LIMIT (-1UL) constant in the cooling-device phandle
@@ -145,7 +145,7 @@ Required properties:
   Size: one cell
 
 - thermal-sensors:	A list of thermal sensor phandles and sensor specifier
-  Type: list of 	used while monitoring the thermal zone.
+  Type: list of		used while monitoring the thermal zone.
   phandles + sensor
   specifier
 
@@ -473,7 +473,7 @@ thermal-zones {
 				  <&adc>;	/* pcb north */
 
 		/* hotspot = 100 * bandgap - 120 * adc + 484 */
-		coefficients = 		<100	-120	484>;
+		coefficients =		<100	-120	484>;
 
 		trips {
 			...
@@ -502,7 +502,7 @@ from the ADC sensor. The binding would be then:
         thermal-sensors =  <&adc>;
 
 		/* hotspot = 1 * adc + 6000 */
-	coefficients = 		<1	6000>;
+	coefficients =		<1	6000>;
 
 (d) - Board thermal
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e5bfbd3..26870ef 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -513,7 +513,7 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 		if (!ret && *temp < crit_temp)
 			*temp = tz->emul_temperature;
 	}
- 
+
 	mutex_unlock(&tz->lock);
 exit:
 	return ret;
-- 
1.9.1
