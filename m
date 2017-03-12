From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH RFC 1/3] thermal: allow hwmon devices to be created for of-thermal
 zones
Date: Sun, 12 Mar 2017 19:07:40 +0000
Message-ID: <E1cn8qC-0002uz-PB@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45634 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934142AbdCLTIG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Mar 2017 15:08:06 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Allow hwmon devices to be optionally created for of-thermal zones,
rather than permanently denying them "in case" there is a hwmon
driver duplicating the thermal driver.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
Without this, "sensors" is unable to report the temperature of the
Dove SoC when it supports thermal zones.

 Documentation/devicetree/bindings/thermal/thermal.txt | 3 +++
 arch/arm/boot/dts/dove.dtsi                           | 1 +
 drivers/thermal/of-thermal.c                          | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index 88b6ea1ad290..1478735fff85 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -175,6 +175,9 @@ containing trip nodes and one sub-node containing all the zone cooling maps.
 			2000mW, while on a 10'' tablet is around
 			4500mW.
 
+- linux,hwmon:		Allow Linux to create hwmon devices for the thermal
+  Type: bool		zone.
+
 Note: The delay properties are bound to the maximum dT/dt (temperature
 derivative over time) in two situations for a thermal zone:
 (i)  - when passive cooling is activated (polling-delay-passive); and
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 40fb98687230..00f5971cd039 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -804,6 +804,7 @@
 
 	thermal-zones {
 		soc-thermal {
+			linux,hwmon;
 			polling-delay-passive = <250>; /* ms */
 			polling-delay = <1000>; /* ms */
 			thermal-sensors = <&thermal>;
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index d04ec3b9e5ff..5cd1838405f0 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -995,7 +995,8 @@ int __init of_parse_thermal_zones(void)
 		}
 
 		/* No hwmon because there might be hwmon drivers registering */
-		tzp->no_hwmon = true;
+		if (!of_property_read_bool(child, "linux,hwmon"))
+			tzp->no_hwmon = true;
 
 		if (!of_property_read_u32(child, "sustainable-power", &prop))
 			tzp->sustainable_power = prop;
-- 
2.7.4
