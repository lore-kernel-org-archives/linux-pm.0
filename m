From: Javi Merino <javi.merino@arm.com>
Subject: [RFC PATCH 1/5] thermal: let governors have private data for each thermal zone
Date: Tue,  6 May 2014 13:06:34 +0100
Message-ID: <1399377998-14870-2-git-send-email-javi.merino@arm.com>
References: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33617 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbaEFMHN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 May 2014 08:07:13 -0400
In-Reply-To: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Punit.Agrawal@arm.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

A governor may need to store its current state between calls to
throttle().  That state depends on the thermal zone, so store it as
private data in struct thermal_zone_device.

The governors may have two new ops: bind_to_tz() and unbind_from_tz().
When provided, these functions let governors do some initialization
and teardown when they are bound/unbound to a tz and possibly store that
information in the governor_data field of the struct
thermal_zone_device.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/thermal_core.c |   67 +++++++++++++++++++++++++++++++++++-=
----
 include/linux/thermal.h        |    3 ++
 2 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.=
c
index 71b0ec0c370d..ac8e5990a63e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -72,6 +72,45 @@ static struct thermal_governor *__find_governor(const ch=
ar *name)
 =09return NULL;
 }
=20
+/**
+ * thermal_set_governor() - Switch to another governor
+ * @tz:=09=09a valid pointer to a struct thermal_zone_device
+ * @new_gov:=09pointer to the new governor
+ *
+ * Change the governor of thermal zone @tz.
+ *
+ * Returns 0 on success, an error if the new governor's bind_to_tz() faile=
d.
+ */
+static int thermal_set_governor(struct thermal_zone_device *tz,
+=09=09=09=09struct thermal_governor *new_gov)
+{
+=09int ret =3D 0;
+
+=09if (tz->governor && tz->governor->unbind_from_tz)
+=09=09tz->governor->unbind_from_tz(tz);
+
+=09if (new_gov && new_gov->bind_to_tz) {
+=09=09ret =3D new_gov->bind_to_tz(tz);
+=09=09if (ret) {
+=09=09=09/* Try to register the old governor again */
+=09=09=09if (tz->governor && tz->governor->bind_to_tz) {
+=09=09=09=09if (tz->governor->bind_to_tz(tz))
+=09=09=09=09=09/*
+=09=09=09=09=09 * The new governor failed to register
+=09=09=09=09=09 * and the previous one failed as well
+=09=09=09=09=09 */
+=09=09=09=09=09tz->governor =3D NULL;
+=09=09=09}
+
+=09=09=09return ret;
+=09=09}
+=09}
+
+=09tz->governor =3D new_gov;
+
+=09return ret;
+}
+
 int thermal_register_governor(struct thermal_governor *governor)
 {
 =09int err;
@@ -104,8 +143,12 @@ int thermal_register_governor(struct thermal_governor =
*governor)
=20
 =09=09name =3D pos->tzp->governor_name;
=20
-=09=09if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH))
-=09=09=09pos->governor =3D governor;
+=09=09if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH)) {
+=09=09=09int ret =3D thermal_set_governor(pos, governor);
+=09=09=09if (ret)
+=09=09=09=09pr_warn("Failed to set governor %s for zone %d: %d\n",
+=09=09=09=09=09governor->name, pos->id, ret);
+=09=09}
 =09}
=20
 =09mutex_unlock(&thermal_list_lock);
@@ -131,7 +174,7 @@ void thermal_unregister_governor(struct thermal_governo=
r *governor)
 =09list_for_each_entry(pos, &thermal_tz_list, node) {
 =09=09if (!strnicmp(pos->governor->name, governor->name,
 =09=09=09=09=09=09THERMAL_NAME_LENGTH))
-=09=09=09pos->governor =3D NULL;
+=09=09=09thermal_set_governor(pos, NULL);
 =09}
=20
 =09mutex_unlock(&thermal_list_lock);
@@ -756,8 +799,9 @@ policy_store(struct device *dev, struct device_attribut=
e *attr,
 =09if (!gov)
 =09=09goto exit;
=20
-=09tz->governor =3D gov;
-=09ret =3D count;
+=09ret =3D thermal_set_governor(tz, gov);
+=09if (!ret)
+=09=09ret =3D count;
=20
 exit:
 =09mutex_unlock(&thermal_governor_lock);
@@ -1452,6 +1496,7 @@ struct thermal_zone_device *thermal_zone_device_regis=
ter(const char *type,
 =09int result;
 =09int count;
 =09int passive =3D 0;
+=09struct thermal_governor *governor;
=20
 =09if (type && strlen(type) >=3D THERMAL_NAME_LENGTH)
 =09=09return ERR_PTR(-EINVAL);
@@ -1542,9 +1587,15 @@ struct thermal_zone_device *thermal_zone_device_regi=
ster(const char *type,
 =09mutex_lock(&thermal_governor_lock);
=20
 =09if (tz->tzp)
-=09=09tz->governor =3D __find_governor(tz->tzp->governor_name);
+=09=09governor =3D __find_governor(tz->tzp->governor_name);
 =09else
-=09=09tz->governor =3D def_governor;
+=09=09governor =3D def_governor;
+
+=09result =3D thermal_set_governor(tz, governor);
+=09if (result) {
+=09=09mutex_unlock(&thermal_governor_lock);
+=09=09goto unregister;
+=09}
=20
 =09mutex_unlock(&thermal_governor_lock);
=20
@@ -1634,7 +1685,7 @@ void thermal_zone_device_unregister(struct thermal_zo=
ne_device *tz)
 =09=09device_remove_file(&tz->device, &dev_attr_mode);
 =09device_remove_file(&tz->device, &dev_attr_policy);
 =09remove_trip_attrs(tz);
-=09tz->governor =3D NULL;
+=09thermal_set_governor(tz, NULL);
=20
 =09thermal_remove_hwmon_sysfs(tz);
 =09release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index f7e11c7ea7d9..baac212f815e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -177,6 +177,7 @@ struct thermal_zone_device {
 =09struct thermal_zone_device_ops *ops;
 =09const struct thermal_zone_params *tzp;
 =09struct thermal_governor *governor;
+=09void *governor_data;
 =09struct list_head thermal_instances;
 =09struct idr idr;
 =09struct mutex lock; /* protect thermal_instances list */
@@ -187,6 +188,8 @@ struct thermal_zone_device {
 /* Structure that holds thermal governor information */
 struct thermal_governor {
 =09char name[THERMAL_NAME_LENGTH];
+=09int (*bind_to_tz)(struct thermal_zone_device *tz);
+=09void (*unbind_from_tz)(struct thermal_zone_device *tz);
 =09int (*throttle)(struct thermal_zone_device *tz, int trip);
 =09struct list_head=09governor_list;
 };
--=20
1.7.9.5


