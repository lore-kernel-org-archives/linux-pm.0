From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 02/15] thermal: sysfs: lock tz while on access to mode
 properties
Date: Wed, 22 Jun 2016 10:45:38 +0800
Message-ID: <1466563538.2471.10.camel@intel.com>
References: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
	 <1464676296-5610-3-git-send-email-edubezval@gmail.com>
	 <57568F08.2070307@ti.com> <5756923F.6010007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46293 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbcFVCrO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 21 Jun 2016 22:47:14 -0400
In-Reply-To: <5756923F.6010007@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "R, Vignesh" <vigneshr@ti.com>

On =E4=BA=8C, 2016-06-07 at 14:52 +0530, Keerthy wrote:
>=20
> On Tuesday 07 June 2016 02:38 PM, Keerthy wrote:
> >=20
> > Hi Eduardo,
> >=20
> > On Tuesday 31 May 2016 12:01 PM, Eduardo Valentin wrote:
> > >=20
> > > Serialized calls to tz.ops in user facing
> > > sysfs handler mode_show()=C2=A0=C2=A0and mode_store().
> > This seems to be causing a deadlock at boot time during the ending
> > stages of boot:
> >=20
> > http://pastebin.ubuntu.com/17085291/
> >=20
> > It took a while to git bisect on linux-next.
> >=20
> > Seems like you introduced new locking at the sysfs layer which
> > causes
> > this deadlock as the underlying code again tries to acquire the
> > same
> > tz->lock.
> I confirm reverting this patch helps me boot on linux-next. This
> patch=C2=A0
> can be dropped as the lower layer functions are already acquiring tz-
> >lock.
>=20
> Thanks Vignesh for reporting the deadlock.
>=20
the root cause of the deadlock is that some platform driver invokes
thermal_zone_device_update() in .set_mode(), after mode changed.

If we wants to lock tz->ops->set_mode(), we should cleanup all the
platform thermal drivers, and deliver a thermal_zone_device_update()
in=C2=A0mode_store(), at the same time.

thanks,
rui

> Regards,
> Keerthy
>=20
> >=20
> >=20
> > Regards,
> > Keerthy
> >=20
> > >=20
> > >=20
> > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> > > ---
> > > =C2=A0 drivers/thermal/thermal_sysfs.c | 13 ++++++++++---
> > > =C2=A0 1 file changed, 10 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/thermal/thermal_sysfs.c
> > > b/drivers/thermal/thermal_sysfs.c
> > > index ee983ca..1db2406 100644
> > > --- a/drivers/thermal/thermal_sysfs.c
> > > +++ b/drivers/thermal/thermal_sysfs.c
> > > @@ -62,7 +62,9 @@ mode_show(struct device *dev, struct
> > > device_attribute *attr, char *buf)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!tz->ops->get_mode)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0retur=
n -EPERM;
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&tz->lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0result =3D tz->ops->get_mode(=
tz, &mode);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&tz->lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (result)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0retur=
n result;
> > >=20
> > > @@ -75,17 +77,22 @@ mode_store(struct device *dev, struct
> > > device_attribute *attr,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char =
*buf, size_t count)
> > > =C2=A0 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct thermal_zone_device *t=
z =3D to_thermal_zone(dev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0enum thermal_device_mode mode =3D THERMA=
L_DEVICE_DISABLED;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int result;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!tz->ops->set_mode)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0retur=
n -EPERM;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!strncmp(buf, "enabled", =
sizeof("enabled") - 1))
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0result =3D tz->o=
ps->set_mode(tz, THERMAL_DEVICE_ENABLED);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mode =3D THERMAL=
_DEVICE_ENABLED;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (!strncmp(buf, "disab=
led", sizeof("disabled") - 1))
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0result =3D tz->o=
ps->set_mode(tz, THERMAL_DEVICE_DISABLED);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mode =3D THERMAL=
_DEVICE_DISABLED;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0result =3D -EINV=
AL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&tz->lock);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0result =3D tz->ops->set_mode(tz, mode);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&tz->lock);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (result)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0retur=
n result;
> > >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm"=
=20
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-=
info.html
