From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 1/2] thermal: use the default governor if none was specified in the thermal zone parameters
Date: Thu, 27 Feb 2014 13:48:19 +0000
Message-ID: <1393508900-19931-1-git-send-email-javi.merino@arm.com>
References: <20140227134122.GA4417@e102654-lin.cambridge.arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:57387 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaB0Nsw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 08:48:52 -0500
In-Reply-To: <20140227134122.GA4417@e102654-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
Cc: eduardo.valentin@ti.com, wni@nvidia.com, Javi Merino <javi.merino@arm.com>

If you pass a thermal_zone_params to thermal_zone_device_register()
without specifying the governor_name, use the default one.  Currently
of_parse_thermal_zones() is the only user of thermal_zone_params, but
potentially other users of this function could do the same.

Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/thermal_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.=
c
index 338a88b..9b655b0 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -89,7 +89,7 @@ int thermal_register_governor(struct thermal_governor *go=
vernor)
 =09list_for_each_entry(pos, &thermal_tz_list, node) {
 =09=09if (pos->governor)
 =09=09=09continue;
-=09=09if (pos->tzp)
+=09=09if ((pos->tzp) && (pos->tzp->governor_name[0]))
 =09=09=09name =3D pos->tzp->governor_name;
 =09=09else
 =09=09=09name =3D DEFAULT_THERMAL_GOVERNOR;
@@ -1530,7 +1530,7 @@ struct thermal_zone_device *thermal_zone_device_regis=
ter(const char *type,
 =09/* Update 'this' zone's governor information */
 =09mutex_lock(&thermal_governor_lock);
=20
-=09if (tz->tzp)
+=09if ((tz->tzp) && (tz->tzp->governor_name[0]))
 =09=09tz->governor =3D __find_governor(tz->tzp->governor_name);
 =09else
 =09=09tz->governor =3D __find_governor(DEFAULT_THERMAL_GOVERNOR);
--=20
1.7.9.5


