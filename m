From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCHv4 07/48] thermal: core: move passive attr to
 tz->device.groups
Date: Thu, 16 Jun 2016 12:15:57 +0800
Message-ID: <1466050557.9422.18.camel@intel.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
	 <1464675535-2433-8-git-send-email-edubezval@gmail.com>
	 <1466047670.9422.16.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:13092 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbcFPEQC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 Jun 2016 00:16:02 -0400
In-Reply-To: <1466047670.9422.16.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>

On =E5=9B=9B, 2016-06-16 at 11:27 +0800, Zhang Rui wrote:
> On =E4=B8=80, 2016-05-30 at 23:18 -0700, Eduardo Valentin wrote:
> >=20
> > This patch moves the passive attribute to tz->device.groups. Moving
> > the
> > passive attribute also requires a .is_visible() callback
> > implementation
> > for its attribute group.
> >=20
> > The logic behind the visibility of passive attribute is kept the
> > same.
> > We only expose the passive attribute if the thermal driver has
> > exposed
> > at least one passive trip point.
> >=20
> No, the passive attribute is only present for zones in which the
> passive cooling policy is not supported by native thermal driver.
>=20
> >=20
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> > ---
> > =C2=A0drivers/thermal/thermal_core.c | 42
> > +++++++++++++++++++++++++++++++++---------
> > =C2=A01 file changed, 33 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c
> > index 19fea9e..efc190c 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1056,9 +1056,42 @@ static struct attribute_group
> > thermal_zone_mode_attribute_group =3D {
> > =C2=A0	.is_visible =3D thermal_zone_mode_is_visible,
> > =C2=A0};
> > =C2=A0
> > +/* We expose passive only if passive trips are present */
> > +static struct attribute *thermal_zone_passive_attrs[] =3D {
> > +	&dev_attr_passive.attr,
> > +	NULL,
> > +};
> > +
> > +static umode_t thermal_zone_passive_is_visible(struct kobject
> > *kobj,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct attribute
> > *attr,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int attrno)
> > +{
> > +	struct device *dev =3D container_of(kobj, struct device,
> > kobj);
> > +	struct thermal_zone_device *tz;
> > +	enum thermal_trip_type trip_type;
> > +	int count;
> > +
> > +	tz =3D container_of(dev, struct thermal_zone_device,
> > device);
> > +
> > +	for (count =3D 0; count < tz->trips; count++) {
> > +		tz->ops->get_trip_type(tz, count, &trip_type);
> > +
> > +		if (trip_type =3D=3D THERMAL_TRIP_PASSIVE)
> > +			return attr->mode;
> we should
> 			return 0;
> >=20
> > +	}
> > +
> > +	return 0;
> and
> 	return attr->mode;
>=20
refreshed patch attached, please review.
=46rom 98415315a7ce1027d2e788476980b7815d9e9627 Mon Sep 17 00:00:00 200=
1
=46rom: Eduardo Valentin <edubezval@gmail.com>
Date: Mon, 30 May 2016 23:18:14 -0700
Subject: [PATCH] thermal: core: move passive attr to tz->device.groups

This patch moves the passive attribute to tz->device.groups. Moving the
passive attribute also requires a .is_visible() callback implementation
for its attribute group.

The logic behind the visibility of passive attribute is kept the same.
We only expose the passive attribute if the thermal driver has exposed
at least one passive trip point.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
=C2=A0drivers/thermal/thermal_core.c | 42 +++++++++++++++++++++++++++++=
++++---------
=C2=A01 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
index 19fea9e..40299a0 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1056,9 +1056,42 @@ static struct attribute_group thermal_zone_mode_=
attribute_group =3D {
=C2=A0	.is_visible =3D thermal_zone_mode_is_visible,
=C2=A0};
=C2=A0
+/* We expose passive only if passive trips are present */
+static struct attribute *thermal_zone_passive_attrs[] =3D {
+	&dev_attr_passive.attr,
+	NULL,
+};
+
+static umode_t thermal_zone_passive_is_visible(struct kobject *kobj,
+					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct attribute *attr,
+					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int attrno)
+{
+	struct device *dev =3D container_of(kobj, struct device, kobj);
+	struct thermal_zone_device *tz;
+	enum thermal_trip_type trip_type;
+	int count;
+
+	tz =3D container_of(dev, struct thermal_zone_device, device);
+
+	for (count =3D 0; count < tz->trips; count++) {
+		tz->ops->get_trip_type(tz, count, &trip_type);
+
+		if (trip_type =3D=3D THERMAL_TRIP_PASSIVE)
+			return 0;
+	}
+
+	return attr->mode;
+}
+
+static struct attribute_group thermal_zone_passive_attribute_group =3D=
 {
+	.attrs =3D thermal_zone_passive_attrs,
+	.is_visible =3D thermal_zone_passive_is_visible,
+};
+
=C2=A0static const struct attribute_group *thermal_zone_attribute_group=
s[] =3D {
=C2=A0	&thermal_zone_attribute_group,
=C2=A0	&thermal_zone_mode_attribute_group,
+	&thermal_zone_passive_attribute_group,
=C2=A0	NULL
=C2=A0};
=C2=A0
@@ -1843,7 +1876,6 @@ struct thermal_zone_device *thermal_zone_device_r=
egister(const char *type,
=C2=A0	int trip_temp;
=C2=A0	int result;
=C2=A0	int count;
-	int passive =3D 0;
=C2=A0	struct thermal_governor *governor;
=C2=A0
=C2=A0	if (!type || strlen(type) =3D=3D 0)
@@ -1904,8 +1936,6 @@ struct thermal_zone_device *thermal_zone_device_r=
egister(const char *type,
=C2=A0	for (count =3D 0; count < trips; count++) {
=C2=A0		if (tz->ops->get_trip_type(tz, count, &trip_type))
=C2=A0			set_bit(count, &tz->trips_disabled);
-		if (trip_type =3D=3D THERMAL_TRIP_PASSIVE)
-			passive =3D 1;
=C2=A0		if (tz->ops->get_trip_temp(tz, count, &trip_temp))
=C2=A0			set_bit(count, &tz->trips_disabled);
=C2=A0		/* Check for bogus trip points */
@@ -1913,12 +1943,6 @@ struct thermal_zone_device *thermal_zone_device_=
register(const char *type,
=C2=A0			set_bit(count, &tz->trips_disabled);
=C2=A0	}
=C2=A0
-	if (!passive) {
-		result =3D device_create_file(&tz->device, &dev_attr_passive);
-		if (result)
-			goto unregister;
-	}
-
=C2=A0	/* Update 'this' zone's governor information */
=C2=A0	mutex_lock(&thermal_governor_lock);
=C2=A0
--=C2=A0
2.7.4

