From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: [PATCH 1/2] thermal: of: Match function to pass bindparam index
Date: Tue, 13 Jan 2015 17:51:21 +0000
Message-ID: <1421171482-16101-2-git-send-email-kapileshwar.singh@arm.com>
References: <1421171482-16101-1-git-send-email-kapileshwar.singh@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48199 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbbAMRv1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jan 2015 12:51:27 -0500
In-Reply-To: <1421171482-16101-1-git-send-email-kapileshwar.singh@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@arm.com, punit.agrawal@arm.com

From: KP Singh <kapileshwar.singh@arm.com>

The match function should pass the index of the binding parameters
which the cooling device needs to be matched against. There are currently
no implementations of match function within the kernel. A successful
match requires:

=09trip_mask =3D=3D expected_trip_mask;
=09weight =3D=3D expected_weight;
=09binding_limits =3D=3D expected_binding_limits;
=09thermal_zone =3D=3D expected_thermal_zone;

Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
---
 drivers/thermal/thermal_core.c |    4 ++--
 include/linux/thermal.h        |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.=
c
index 87e0b0782023..db4d6407c1ec 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -276,7 +276,7 @@ static void bind_cdev(struct thermal_cooling_device *cd=
ev)
 =09=09for (i =3D 0; i < tzp->num_tbps; i++) {
 =09=09=09if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
 =09=09=09=09continue;
-=09=09=09if (tzp->tbp[i].match(pos, cdev))
+=09=09=09if (tzp->tbp[i].match(pos, cdev, i))
 =09=09=09=09continue;
 =09=09=09tzp->tbp[i].cdev =3D cdev;
 =09=09=09__bind(pos, tzp->tbp[i].trip_mask, cdev,
@@ -315,7 +315,7 @@ static void bind_tz(struct thermal_zone_device *tz)
 =09=09for (i =3D 0; i < tzp->num_tbps; i++) {
 =09=09=09if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
 =09=09=09=09continue;
-=09=09=09if (tzp->tbp[i].match(tz, pos))
+=09=09=09if (tzp->tbp[i].match(tz, pos, i))
 =09=09=09=09continue;
 =09=09=09tzp->tbp[i].cdev =3D pos;
 =09=09=09__bind(tz, tzp->tbp[i].trip_mask, pos,
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index fc52e307efab..dc8cf6dc59e5 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -237,7 +237,7 @@ struct thermal_bind_params {
 =09 */
 =09unsigned long *binding_limits;
 =09int (*match) (struct thermal_zone_device *tz,
-=09=09=09struct thermal_cooling_device *cdev);
+=09=09      struct thermal_cooling_device *cdev, int index);
 };
=20
 /* Structure to define Thermal Zone parameters */
--=20
1.7.9.5


