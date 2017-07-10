From: Michael Tatarinov <kukabu@gmail.com>
Subject: [PATCH] of: thermal: Introduce "hwmon" optional property
Date: Mon, 10 Jul 2017 15:51:46 +0400
Message-ID: <20170710115146.27313-1-kukabu@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34641 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbdGJLwO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 07:52:14 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21so10040150lfk.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2017 04:52:13 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Michael Tatarinov <kukabu@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Introduce an optional property called, hwmon, which enable
registration in hwmon subsystems.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Michael Tatarinov <kukabu@gmail.com>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 6 ++++++
 drivers/thermal/of-thermal.c                          | 3 +--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index 88b6ea1ad290..4e51fbd4efa2 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -175,6 +175,10 @@ Optional property:
 			2000mW, while on a 10'' tablet is around
 			4500mW.
 
+- hwmon:		Register the thermal zone in hwmon subsystems
+  Type: boolean 	(requires CONFIG_THERMAL_HWMON).
+  Size: one cell
+
 Note: The delay properties are bound to the maximum dT/dt (temperature
 derivative over time) in two situations for a thermal zone:
 (i)  - when passive cooling is activated (polling-delay-passive); and
@@ -556,6 +560,8 @@ thermal-zones {
 
 		sustainable-power = <2500>;
 
+		hwmon;
+
 		trips {
 			/* Trips are based on resulting linear equation */
 			cpu_trip: cpu-trip {
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index d04ec3b9e5ff..ce580a57313b 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -994,8 +994,7 @@ int __init of_parse_thermal_zones(void)
 			goto exit_free;
 		}
 
-		/* No hwmon because there might be hwmon drivers registering */
-		tzp->no_hwmon = true;
+		tzp->no_hwmon = !of_property_read_bool(child, "hwmon");
 
 		if (!of_property_read_u32(child, "sustainable-power", &prop))
 			tzp->sustainable_power = prop;
-- 
2.9.4
