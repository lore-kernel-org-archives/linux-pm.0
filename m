From: "Javi Merino" <javi.merino@arm.com>
Subject: [RFC PATCH v6 4/9] thermal: let governors have private data for each thermal zone
Date: Fri,  5 Dec 2014 19:04:15 +0000
Message-ID: <1417806260-9264-5-git-send-email-javi.merino@arm.com>
References: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417806260-9264-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: punit.agrawal@arm.com, broonie@kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

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
 drivers/thermal/thermal_core.c | 83 ++++++++++++++++++++++++++++++++++++++=
----
 include/linux/thermal.h        |  9 +++++
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.=
c
index 43b90709585f..9021cb72a13a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -75,6 +75,58 @@ static struct thermal_governor *__find_governor(const ch=
ar *name)
 =09return NULL;
 }
=20
+/**
+ * bind_previous_governor() - bind the previous governor of the thermal zo=
ne
+ * @tz:=09=09a valid pointer to a struct thermal_zone_device
+ * @failed_gov_name:=09the name of the governor that failed to register
+ *
+ * Register the previous governor of the thermal zone after a new
+ * governor has failed to be bound.
+ */
+static void bind_previous_governor(struct thermal_zone_device *tz,
+=09=09=09=09const char *failed_gov_name)
+{
+=09if (tz->governor && tz->governor->bind_to_tz) {
+=09=09if (tz->governor->bind_to_tz(tz)) {
+=09=09=09dev_err(&tz->device,
+=09=09=09=09"governor %s failed to bind and the previous one (%s) failed t=
o bind again, thermal zone %s has no governor\n",
+=09=09=09=09failed_gov_name, tz->governor->name, tz->type);
+=09=09=09tz->governor =3D NULL;
+=09=09}
+=09}
+}
+
+/**
+ * thermal_set_governor() - Switch to another governor
+ * @tz:=09=09a valid pointer to a struct thermal_zone_device
+ * @new_gov:=09pointer to the new governor
+ *
+ * Change the governor of thermal zone @tz.
+ *
+ * Return: 0 on success, an error if the new governor's bind_to_tz() faile=
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
+=09=09=09bind_previous_governor(tz, new_gov->name);
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
@@ -107,8 +159,15 @@ int thermal_register_governor(struct thermal_governor =
*governor)
=20
 =09=09name =3D pos->tzp->governor_name;
=20
-=09=09if (!strncasecmp(name, governor->name, THERMAL_NAME_LENGTH))
-=09=09=09pos->governor =3D governor;
+=09=09if (!strncasecmp(name, governor->name, THERMAL_NAME_LENGTH)) {
+=09=09=09int ret;
+
+=09=09=09ret =3D thermal_set_governor(pos, governor);
+=09=09=09if (ret)
+=09=09=09=09dev_err(&pos->device,
+=09=09=09=09=09"Failed to set governor %s for thermal zone %s: %d\n",
+=09=09=09=09=09governor->name, pos->type, ret);
+=09=09}
 =09}
=20
 =09mutex_unlock(&thermal_list_lock);
@@ -134,7 +193,7 @@ void thermal_unregister_governor(struct thermal_governo=
r *governor)
 =09list_for_each_entry(pos, &thermal_tz_list, node) {
 =09=09if (!strncasecmp(pos->governor->name, governor->name,
 =09=09=09=09=09=09THERMAL_NAME_LENGTH))
-=09=09=09pos->governor =3D NULL;
+=09=09=09thermal_set_governor(pos, NULL);
 =09}
=20
 =09mutex_unlock(&thermal_list_lock);
@@ -762,8 +821,9 @@ policy_store(struct device *dev, struct device_attribut=
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
@@ -1459,6 +1519,7 @@ struct thermal_zone_device *thermal_zone_device_regis=
ter(const char *type,
 =09int result;
 =09int count;
 =09int passive =3D 0;
+=09struct thermal_governor *governor;
=20
 =09if (type && strlen(type) >=3D THERMAL_NAME_LENGTH)
 =09=09return ERR_PTR(-EINVAL);
@@ -1549,9 +1610,15 @@ struct thermal_zone_device *thermal_zone_device_regi=
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
@@ -1640,7 +1707,7 @@ void thermal_zone_device_unregister(struct thermal_zo=
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
index ef90838b36a0..2c14ab1f5c0d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -191,6 +191,7 @@ struct thermal_attr {
  * @ops:=09operations this &thermal_zone_device supports
  * @tzp:=09thermal zone parameters
  * @governor:=09pointer to the governor for this thermal zone
+ * @governor_data:=09private pointer for governor data
  * @thermal_instances:=09list of &struct thermal_instance of this thermal =
zone
  * @idr:=09&struct idr to generate unique id for this zone's cooling
  *=09=09devices
@@ -217,6 +218,7 @@ struct thermal_zone_device {
 =09struct thermal_zone_device_ops *ops;
 =09const struct thermal_zone_params *tzp;
 =09struct thermal_governor *governor;
+=09void *governor_data;
 =09struct list_head thermal_instances;
 =09struct idr idr;
 =09struct mutex lock;
@@ -227,12 +229,19 @@ struct thermal_zone_device {
 /**
  * struct thermal_governor - structure that holds thermal governor informa=
tion
  * @name:=09name of the governor
+ * @bind_to_tz: callback called when binding to a thermal zone.  If it
+ *=09=09returns 0, the governor is bound to the thermal zone,
+ *=09=09otherwise it fails.
+ * @unbind_from_tz:=09callback called when a governor is unbound from a
+ *=09=09=09thermal zone.
  * @throttle:=09callback called for every trip point even if temperature i=
s
  *=09=09below the trip point temperature
  * @governor_list:=09node in thermal_governor_list (in thermal_core.c)
  */
 struct thermal_governor {
 =09char name[THERMAL_NAME_LENGTH];
+=09int (*bind_to_tz)(struct thermal_zone_device *tz);
+=09void (*unbind_from_tz)(struct thermal_zone_device *tz);
 =09int (*throttle)(struct thermal_zone_device *tz, int trip);
 =09struct list_head=09governor_list;
 };
--=20
1.9.1
