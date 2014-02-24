From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH] thermal: of: use the default governor when registering thermal zones from DT
Date: Mon, 24 Feb 2014 17:45:53 +0000
Message-ID: <1393263953-4590-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:53983 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbaBXRqO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2014 12:46:14 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: sudeep.holla@arm.com, punit.agrawal@arm.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>

Thermal zones specified in the DT get no governor because the
thermal_zone_parameters they pass to thermal_zone_device_register()
has an empty governor_name entry.  As there is no way to set the
governor from the DT at the moment, make them register the default
governor.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---

Another alternative would be to set governor_name to the default in
thermal_zone_device_register() if it receives the empty string.

There are no other users of thermal_zone_parameters in the kernel and
there is no user of the governor_name.  I was tempted to kill
governor_name, but I guess it's there to be used by external modules.

 drivers/thermal/of-thermal.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 04b1be7..3f850f2 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -791,6 +791,13 @@ int __init of_parse_thermal_zones(void)
 =09=09/* No hwmon because there might be hwmon drivers registering */
 =09=09tzp->no_hwmon =3D true;
=20
+=09=09/*
+=09=09 * We can't specify the governor in the DT, so use the
+=09=09 * default one
+=09=09 */
+=09=09strncpy(tzp->governor_name, DEFAULT_THERMAL_GOVERNOR,
+=09=09=09ARRAY_SIZE(tzp->governor_name));
+
 =09=09zone =3D thermal_zone_device_register(child->name, tz->ntrips,
 =09=09=09=09=09=09    0, tz,
 =09=09=09=09=09=09    ops, tzp,
--=20
1.7.9.5


