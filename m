From: "Javi Merino" <javi.merino@arm.com>
Subject: [RFC PATCH v6 9/9] of: thermal: Introduce sustainable power for a thermal zone
Date: Fri,  5 Dec 2014 19:04:20 +0000
Message-ID: <1417806260-9264-10-git-send-email-javi.merino@arm.com>
References: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: punit.agrawal@arm.com, broonie@kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Punit Agrawal <punit.agrawal@arm.com>

Introduce an optional property called, sustainable-power, which
represents the power (in mW) which the thermal zone can safely
dissipate.

If provided the property is parsed and associated with the thermal
zone via the thermal zone parameters.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 4 ++++
 drivers/thermal/of-thermal.c                          | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Docume=
ntation/devicetree/bindings/thermal/thermal.txt
index f5db6b72a36f..c6eb9a8d2aed 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -167,6 +167,10 @@ Optional property:
 =09=09=09by means of sensor ID. Additional coefficients are
 =09=09=09interpreted as constant offset.
=20
+- sustainable-power:=09An estimate of the sustainable power (in mW) that t=
he
+  Type: unsigned=09thermal zone can dissipate.
+  Size: one cell
+
 Note: The delay properties are bound to the maximum dT/dt (temperature
 derivative over time) in two situations for a thermal zone:
 (i)  - when passive cooling is activated (polling-delay-passive); and
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 62143ba31001..e032b9bf4085 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -794,6 +794,7 @@ int __init of_parse_thermal_zones(void)
 =09for_each_child_of_node(np, child) {
 =09=09struct thermal_zone_device *zone;
 =09=09struct thermal_zone_params *tzp;
+=09=09u32 prop;
=20
 =09=09/* Check whether child is enabled or not */
 =09=09if (!of_device_is_available(child))
@@ -820,6 +821,9 @@ int __init of_parse_thermal_zones(void)
 =09=09/* No hwmon because there might be hwmon drivers registering */
 =09=09tzp->no_hwmon =3D true;
=20
+=09=09if (!of_property_read_u32(child, "sustainable-power", &prop))
+=09=09=09tzp->sustainable_power =3D prop;
+
 =09=09zone =3D thermal_zone_device_register(child->name, tz->ntrips,
 =09=09=09=09=09=09    0, tz,
 =09=09=09=09=09=09    ops, tzp,
--=20
1.9.1
