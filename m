From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 2/2] Thermal: thermal zone governor fix
Date: Thu, 27 Feb 2014 13:48:20 +0000
Message-ID: <1393508900-19931-2-git-send-email-javi.merino@arm.com>
References: <20140227134122.GA4417@e102654-lin.cambridge.arm.com>
 <1393508900-19931-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:58488 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaB0NtV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 08:49:21 -0500
In-Reply-To: <1393508900-19931-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
Cc: eduardo.valentin@ti.com, wni@nvidia.com

From: Zhang Rui <rui.zhang@intel.com>

This patch does a cleanup about the thermal zone govenor,
setting and make the following rule.
1. For thermal zone devices that are registered w/o tz->tzp,
   they can use the default thermal governor only.
2. For thermal zone devices w/ governor name specified in
   tz->tzp->governor_name, we will use the default govenor
   if the governor specified is not available at the moment,
   and update tz->governor when the matched governor is registered.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.=
c
index 9b655b0..cc9b420 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -56,10 +56,15 @@ static LIST_HEAD(thermal_governor_list);
 static DEFINE_MUTEX(thermal_list_lock);
 static DEFINE_MUTEX(thermal_governor_lock);
=20
+static struct thermal_governor *def_governor;
+
 static struct thermal_governor *__find_governor(const char *name)
 {
 =09struct thermal_governor *pos;
=20
+=09if (!name)
+=09=09return def_governor;
+
 =09list_for_each_entry(pos, &thermal_governor_list, governor_list)
 =09=09if (!strnicmp(name, pos->name, THERMAL_NAME_LENGTH))
 =09=09=09return pos;
@@ -82,17 +87,23 @@ int thermal_register_governor(struct thermal_governor *=
governor)
 =09if (__find_governor(governor->name) =3D=3D NULL) {
 =09=09err =3D 0;
 =09=09list_add(&governor->governor_list, &thermal_governor_list);
+=09=09if (!def_governor && !strncmp(governor->name,
+=09=09=09DEFAULT_THERMAL_GOVERNOR, THERMAL_NAME_LENGTH))
+=09=09=09def_governor =3D governor;
 =09}
=20
 =09mutex_lock(&thermal_list_lock);
=20
 =09list_for_each_entry(pos, &thermal_tz_list, node) {
+=09=09/*
+=09=09 * only thermal zones with specified tz->tzp->governor_name
+=09=09 * may run with tz->governor unset
+=09=09 */
 =09=09if (pos->governor)
 =09=09=09continue;
-=09=09if ((pos->tzp) && (pos->tzp->governor_name[0]))
-=09=09=09name =3D pos->tzp->governor_name;
-=09=09else
-=09=09=09name =3D DEFAULT_THERMAL_GOVERNOR;
+
+=09=09name =3D pos->tzp->governor_name;
+
 =09=09if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH))
 =09=09=09pos->governor =3D governor;
 =09}
@@ -342,8 +353,8 @@ static void monitor_thermal_zone(struct thermal_zone_de=
vice *tz)
 static void handle_non_critical_trips(struct thermal_zone_device *tz,
 =09=09=09int trip, enum thermal_trip_type trip_type)
 {
-=09if (tz->governor)
-=09=09tz->governor->throttle(tz, trip);
+=09tz->governor ? tz->governor->throttle(tz, trip) :
+=09=09       def_governor->throttle(tz, trip);
 }
=20
 static void handle_critical_trips(struct thermal_zone_device *tz,
@@ -1533,7 +1544,7 @@ struct thermal_zone_device *thermal_zone_device_regis=
ter(const char *type,
 =09if ((tz->tzp) && (tz->tzp->governor_name[0]))
 =09=09tz->governor =3D __find_governor(tz->tzp->governor_name);
 =09else
-=09=09tz->governor =3D __find_governor(DEFAULT_THERMAL_GOVERNOR);
+=09=09tz->governor =3D def_governor;
=20
 =09mutex_unlock(&thermal_governor_lock);
=20
--=20
1.7.9.5


