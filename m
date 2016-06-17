From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCHv4 14/48] thermal: core: move trips attributes to
 tz->device.groups
Date: Fri, 17 Jun 2016 16:44:56 +0800
Message-ID: <1466153096.9422.34.camel@intel.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
	 <1464675535-2433-15-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464675535-2433-15-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>
List-Id: linux-pm@vger.kernel.org

On =E4=B8=80, 2016-05-30 at 23:18 -0700, Eduardo Valentin wrote:
> Finally, move the last thermal zone sysfs attributes to
> tz->device.groups: trips attributes. This requires adding a
> attribute_group to thermal_zone_device, creating it dynamically, and
> then setting all trips attributes in it. The trips attribute is then
> added to the tz->device.groups.
>=20
> As the removal of all attributes are handled by device core, the
> device
> remove calls are not needed anymore.
>=20
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
> =C2=A0drivers/thermal/thermal_core.c | 77 +++++++++++++++++++++------=
-----
> ----------
> =C2=A0include/linux/thermal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A02 ++
> =C2=A02 files changed, 41 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c
> index ba4f7a9..0b60b04 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1188,8 +1188,9 @@ static const struct attribute_group
> *thermal_zone_attribute_groups[] =3D {
> =C2=A0 */
> =C2=A0static int create_trip_attrs(struct thermal_zone_device *tz, in=
t
> mask)
> =C2=A0{
> -	int indx;
> =C2=A0	int size =3D sizeof(struct thermal_attr) * tz->trips;
> +	struct attribute **attrs;
> +	int indx;
> =C2=A0
> =C2=A0	tz->trip_type_attrs =3D kzalloc(size, GFP_KERNEL);
> =C2=A0	if (!tz->trip_type_attrs)
> @@ -1210,6 +1211,15 @@ static int create_trip_attrs(struct
> thermal_zone_device *tz, int mask)
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> +	attrs =3D kzalloc(sizeof(*attrs) * tz->trips * 3 + 1,
> GFP_KERNEL);
> +	if (!attrs) {
> +		kfree(tz->trip_type_attrs);
> +		kfree(tz->trip_temp_attrs);
> +		if (tz->ops->get_trip_hyst)
> +			kfree(tz->trip_hyst_attrs);
> +		return -ENOMEM;
> +	}
> +
> =C2=A0	for (indx =3D 0; indx < tz->trips; indx++) {
> =C2=A0		/* create trip type attribute */
> =C2=A0		snprintf(tz->trip_type_attrs[indx].name,
> THERMAL_NAME_LENGTH,
> @@ -1220,9 +1230,7 @@ static int create_trip_attrs(struct
> thermal_zone_device *tz, int mask)
> =C2=A0						tz-
> >trip_type_attrs[indx].name;
> =C2=A0		tz->trip_type_attrs[indx].attr.attr.mode =3D S_IRUGO;
> =C2=A0		tz->trip_type_attrs[indx].attr.show =3D
> trip_point_type_show;
> -
> -		device_create_file(&tz->device,
> -				=C2=A0=C2=A0=C2=A0&tz->trip_type_attrs[indx].attr);
> +		attrs[indx] =3D &tz->trip_type_attrs[indx].attr.attr;
> =C2=A0
> =C2=A0		/* create trip temp attribute */
> =C2=A0		snprintf(tz->trip_temp_attrs[indx].name,
> THERMAL_NAME_LENGTH,
> @@ -1239,9 +1247,7 @@ static int create_trip_attrs(struct
> thermal_zone_device *tz, int mask)
> =C2=A0			tz->trip_temp_attrs[indx].attr.store =3D
> =C2=A0							trip_point_t
> emp_store;
> =C2=A0		}
> -
> -		device_create_file(&tz->device,
> -				=C2=A0=C2=A0=C2=A0&tz->trip_temp_attrs[indx].attr);
> +		attrs[indx + tz->trips] =3D &tz-
> >trip_temp_attrs[indx].attr.attr;
> =C2=A0
> =C2=A0		/* create Optional trip hyst attribute */
> =C2=A0		if (!tz->ops->get_trip_hyst)
> @@ -1259,45 +1265,38 @@ static int create_trip_attrs(struct
> thermal_zone_device *tz, int mask)
> =C2=A0			tz->trip_hyst_attrs[indx].attr.store =3D
> =C2=A0					trip_point_hyst_store;
> =C2=A0		}
> -
> -		device_create_file(&tz->device,
> -				=C2=A0=C2=A0=C2=A0&tz->trip_hyst_attrs[indx].attr);
> +		attrs[indx + tz->trips * 2] =3D
> +					&tz-
> >trip_hyst_attrs[indx].attr.attr;
> =C2=A0	}
> -	return 0;
> -}
> +	attrs[tz->trips * 3] =3D NULL;

why bother clearing it explicitly? kzalloc already handles this, right?

> -static void remove_trip_attrs(struct thermal_zone_device *tz)
> -{
> -	int indx;
> +	tz->trips_attribute_group.attrs =3D attrs;
> =C2=A0
> -	for (indx =3D 0; indx < tz->trips; indx++) {
> -		device_remove_file(&tz->device,
> -				=C2=A0=C2=A0=C2=A0&tz->trip_type_attrs[indx].attr);
> -		device_remove_file(&tz->device,
> -				=C2=A0=C2=A0=C2=A0&tz->trip_temp_attrs[indx].attr);
> -		if (tz->ops->get_trip_hyst)
> -			device_remove_file(&tz->device,
> -					=C2=A0=C2=A0=C2=A0&tz-
> >trip_hyst_attrs[indx].attr);
> -	}
> -	kfree(tz->trip_type_attrs);
> -	kfree(tz->trip_temp_attrs);
> -	kfree(tz->trip_hyst_attrs);
> +	return 0;
> =C2=A0}
> =C2=A0
> -static int thermal_zone_create_device_groups(struct
> thermal_zone_device *tz)
> +static int thermal_zone_create_device_groups(struct
> thermal_zone_device *tz,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int mask)
> =C2=A0{
> =C2=A0	const struct attribute_group **groups;
> -	int i, size;
> +	int i, size, result;
> +
> +	result =3D create_trip_attrs(tz, mask);
> +	if (result)
> +		return result;
> =C2=A0
> -	size =3D ARRAY_SIZE(thermal_zone_attribute_groups) + 1;
> +	/* we need one extra for trips and the NULL to terminate the
> array */
> +	size =3D ARRAY_SIZE(thermal_zone_attribute_groups) + 2;
> =C2=A0	/* This also takes care of API requirement to be NULL
> terminated */
> =C2=A0	groups =3D kcalloc(size, sizeof(*groups), GFP_KERNEL);
> =C2=A0	if (!groups)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	for (i =3D 0; i < size - 1; i++)
> +	for (i =3D 0; i < size - 2; i++)
> =C2=A0		groups[i] =3D thermal_zone_attribute_groups[i];
> =C2=A0
> +	groups[size - 2] =3D &tz->trips_attribute_group;
> +

Problem is that, previously, create_trip_attrs() does not handle the
case that tz->trips =3D=3D 0 good enough, it happens to not bring big
problem.
tz->trip_type_attrs/tz->trip_temp_attrs/tz->trip_hyst_attrs is set
to=C2=A0ZERO_SIZE_PTR when tz->trips equals 0, kfree() handles this.
But registering a sysfs group with one invalid attribute item is wrong.
And this causes oops in my machine when test_power driver, which has no
trip point, is unloaded. And maybe this is also the root cause of this
report=C2=A0http://www.spinics.net/lists/kernel/msg2280260.html

Attached is an updated version, which creates trip attributes only if
tz->trips > 0, which solves the problem for me.

=46rom e1e917e790b70b88bd418545a29b1eefa01a5566 Mon Sep 17 00:00:00 200=
1
=46rom: Eduardo Valentin <edubezval@gmail.com>
Date: Mon, 30 May 2016 23:18:21 -0700
Subject: [PATCH] thermal: core: move trips attributes to tz->device.gro=
ups

=46inally, move the last thermal zone sysfs attributes to
tz->device.groups: trips attributes. This requires adding a
attribute_group to thermal_zone_device, creating it dynamically, and
then setting all trips attributes in it. The trips attribute is then
added to the tz->device.groups.

As the removal of all attributes are handled by device core, the device
remove calls are not needed anymore.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
=C2=A0drivers/thermal/thermal_core.c | 78 ++++++++++++++++++++++-------=
-------------
=C2=A0include/linux/thermal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A02 ++
=C2=A02 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
index 657ba02..9926c89 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1188,8 +1188,9 @@ static const struct attribute_group *thermal_zone=
_attribute_groups[] =3D {
=C2=A0 */
=C2=A0static int create_trip_attrs(struct thermal_zone_device *tz, int =
mask)
=C2=A0{
-	int indx;
=C2=A0	int size =3D sizeof(struct thermal_attr) * tz->trips;
+	struct attribute **attrs;
+	int indx;
=C2=A0
=C2=A0	tz->trip_type_attrs =3D kzalloc(size, GFP_KERNEL);
=C2=A0	if (!tz->trip_type_attrs)
@@ -1210,6 +1211,15 @@ static int create_trip_attrs(struct thermal_zone=
_device *tz, int mask)
=C2=A0		}
=C2=A0	}
=C2=A0
+	attrs =3D kzalloc(sizeof(*attrs) * tz->trips * 3 + 1, GFP_KERNEL);
+	if (!attrs) {
+		kfree(tz->trip_type_attrs);
+		kfree(tz->trip_temp_attrs);
+		if (tz->ops->get_trip_hyst)
+			kfree(tz->trip_hyst_attrs);
+		return -ENOMEM;
+	}
+
=C2=A0	for (indx =3D 0; indx < tz->trips; indx++) {
=C2=A0		/* create trip type attribute */
=C2=A0		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
@@ -1220,9 +1230,7 @@ static int create_trip_attrs(struct thermal_zone_=
device *tz, int mask)
=C2=A0						tz->trip_type_attrs[indx].name;
=C2=A0		tz->trip_type_attrs[indx].attr.attr.mode =3D S_IRUGO;
=C2=A0		tz->trip_type_attrs[indx].attr.show =3D trip_point_type_show;
-
-		device_create_file(&tz->device,
-				=C2=A0=C2=A0=C2=A0&tz->trip_type_attrs[indx].attr);
+		attrs[indx] =3D &tz->trip_type_attrs[indx].attr.attr;
=C2=A0
=C2=A0		/* create trip temp attribute */
=C2=A0		snprintf(tz->trip_temp_attrs[indx].name, THERMAL_NAME_LENGTH,
@@ -1239,9 +1247,7 @@ static int create_trip_attrs(struct thermal_zone_=
device *tz, int mask)
=C2=A0			tz->trip_temp_attrs[indx].attr.store =3D
=C2=A0							trip_point_temp_store;
=C2=A0		}
-
-		device_create_file(&tz->device,
-				=C2=A0=C2=A0=C2=A0&tz->trip_temp_attrs[indx].attr);
+		attrs[indx + tz->trips] =3D &tz->trip_temp_attrs[indx].attr.attr;
=C2=A0
=C2=A0		/* create Optional trip hyst attribute */
=C2=A0		if (!tz->ops->get_trip_hyst)
@@ -1259,45 +1265,39 @@ static int create_trip_attrs(struct thermal_zon=
e_device *tz, int mask)
=C2=A0			tz->trip_hyst_attrs[indx].attr.store =3D
=C2=A0					trip_point_hyst_store;
=C2=A0		}
-
-		device_create_file(&tz->device,
-				=C2=A0=C2=A0=C2=A0&tz->trip_hyst_attrs[indx].attr);
+		attrs[indx + tz->trips * 2] =3D
+					&tz->trip_hyst_attrs[indx].attr.attr;
=C2=A0	}
-	return 0;
-}
+	attrs[tz->trips * 3] =3D NULL;
=C2=A0
-static void remove_trip_attrs(struct thermal_zone_device *tz)
-{
-	int indx;
+	tz->trips_attribute_group.attrs =3D attrs;
=C2=A0
-	for (indx =3D 0; indx < tz->trips; indx++) {
-		device_remove_file(&tz->device,
-				=C2=A0=C2=A0=C2=A0&tz->trip_type_attrs[indx].attr);
-		device_remove_file(&tz->device,
-				=C2=A0=C2=A0=C2=A0&tz->trip_temp_attrs[indx].attr);
-		if (tz->ops->get_trip_hyst)
-			device_remove_file(&tz->device,
-					=C2=A0=C2=A0=C2=A0&tz->trip_hyst_attrs[indx].attr);
-	}
-	kfree(tz->trip_type_attrs);
-	kfree(tz->trip_temp_attrs);
-	kfree(tz->trip_hyst_attrs);
+	return 0;
=C2=A0}
=C2=A0
-static int thermal_zone_create_device_groups(struct thermal_zone_devic=
e *tz)
+static int thermal_zone_create_device_groups(struct thermal_zone_devic=
e *tz,
+					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int mask)
=C2=A0{
=C2=A0	const struct attribute_group **groups;
-	int i, size;
+	int i, size, result;
=C2=A0
-	size =3D ARRAY_SIZE(thermal_zone_attribute_groups) + 1;
+	/* we need one extra for trips and the NULL to terminate the array */
+	size =3D ARRAY_SIZE(thermal_zone_attribute_groups) + 2;
=C2=A0	/* This also takes care of API requirement to be NULL terminated=
 */
=C2=A0	groups =3D kcalloc(size, sizeof(*groups), GFP_KERNEL);
=C2=A0	if (!groups)
=C2=A0		return -ENOMEM;
=C2=A0
-	for (i =3D 0; i < size - 1; i++)
+	for (i =3D 0; i < size - 2; i++)
=C2=A0		groups[i] =3D thermal_zone_attribute_groups[i];
=C2=A0
+	if (tz->trips) {
+		result =3D create_trip_attrs(tz, mask);
+		if (result)
+			return result;
+		groups[size - 2] =3D &tz->trips_attribute_group;
+	}
+
=C2=A0	tz->device.groups =3D groups;
=C2=A0
=C2=A0	return 0;
@@ -1934,8 +1934,12 @@ struct thermal_zone_device *thermal_zone_device_=
register(const char *type,
=C2=A0	tz->passive_delay =3D passive_delay;
=C2=A0	tz->polling_delay =3D polling_delay;
=C2=A0
+	/* sys I/F */
=C2=A0	/* Add nodes that are always present via .groups */
-	thermal_zone_create_device_groups(tz);
+	result =3D thermal_zone_create_device_groups(tz, mask);
+	if (result)
+		goto unregister;
+
=C2=A0	/* A new thermal zone needs to be updated anyway. */
=C2=A0	atomic_set(&tz->need_update, 1);
=C2=A0
@@ -1947,11 +1951,6 @@ struct thermal_zone_device *thermal_zone_device_=
register(const char *type,
=C2=A0		return ERR_PTR(result);
=C2=A0	}
=C2=A0
-	/* sys I/F */
-	result =3D create_trip_attrs(tz, mask);
-	if (result)
-		goto unregister;
-
=C2=A0	for (count =3D 0; count < trips; count++) {
=C2=A0		if (tz->ops->get_trip_type(tz, count, &trip_type))
=C2=A0			set_bit(count, &tz->trips_disabled);
@@ -2056,7 +2055,10 @@ void thermal_zone_device_unregister(struct therm=
al_zone_device *tz)
=C2=A0
=C2=A0	thermal_zone_device_set_polling(tz, 0);
=C2=A0
-	remove_trip_attrs(tz);
+	kfree(tz->trip_type_attrs);
+	kfree(tz->trip_temp_attrs);
+	kfree(tz->trip_hyst_attrs);
+	kfree(tz->trips_attribute_group.attrs);
=C2=A0	thermal_set_governor(tz, NULL);
=C2=A0
=C2=A0	thermal_remove_hwmon_sysfs(tz);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index ee517be..580809c 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -28,6 +28,7 @@
=C2=A0#include <linux/of.h>
=C2=A0#include <linux/idr.h>
=C2=A0#include <linux/device.h>
+#include <linux/sysfs.h>
=C2=A0#include <linux/workqueue.h>
=C2=A0#include <uapi/linux/thermal.h>
=C2=A0
@@ -187,6 +188,7 @@ struct thermal_zone_device {
=C2=A0	int id;
=C2=A0	char type[THERMAL_NAME_LENGTH];
=C2=A0	struct device device;
+	struct attribute_group trips_attribute_group;
=C2=A0	struct thermal_attr *trip_temp_attrs;
=C2=A0	struct thermal_attr *trip_type_attrs;
=C2=A0	struct thermal_attr *trip_hyst_attrs;
--=C2=A0
2.7.4
