From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 04/21] thermal: of: Extend current of-thermal.c code to
 allow setting emulated temp
Date: Tue, 18 Nov 2014 11:23:29 -0400
Message-ID: <20141118152327.GB18674@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-5-git-send-email-l.majewski@samsung.com>
 <20141107014448.GE10180@developer>
 <20141107122035.2973ad20@amdc2363>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:33807 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898AbaKRPXl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Nov 2014 10:23:41 -0500
Content-Disposition: inline
In-Reply-To: <20141107122035.2973ad20@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Lukasz,


On Fri, Nov 07, 2014 at 12:20:35PM +0100, Lukasz Majewski wrote:
> Hi Eduardo,
>=20
> > Hello,
> >=20
> > On Thu, Oct 09, 2014 at 06:38:40PM +0200, Lukasz Majewski wrote:
> > > Before this change it was only possible to set get_temp() and
> > > get_trend() methods to be used in the common code handling passing
> > > parameters via device tree to "cpu-thermal" CPU thermal zone device.
> > >=20
> > > Now it is possible to also set emulated value of temperature for
> > > debug purposes.
> > >=20
> > > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > > ---
> > >  drivers/thermal/of-thermal.c | 25 ++++++++++++++++++++++---
> > >  include/linux/thermal.h      |  6 ++++--
> > >  2 files changed, 26 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/thermal/of-thermal.c
> > > b/drivers/thermal/of-thermal.c index cd74e64..f206375 100644
> > > --- a/drivers/thermal/of-thermal.c
> > > +++ b/drivers/thermal/of-thermal.c
> > > @@ -98,10 +98,22 @@ struct __thermal_zone {
> > >  	void *sensor_data;
> > >  	int (*get_temp)(void *, long *);
> > >  	int (*get_trend)(void *, long *);
> > > +	int (*set_emul_temp)(void *, unsigned long);
> > >  };
> > > =20
> > >  /***   DT thermal zone device callbacks   ***/
> > > =20
> > > +static int of_thermal_set_emul_temp(struct thermal_zone_device *tz,
> > > +				    unsigned long temp)
> > > +{
> > > +	struct __thermal_zone *data =3D tz->devdata;
> > > +
> > > +	if (!data->set_emul_temp)
> > > +		return -EINVAL;
> > > +
> > > +	return data->set_emul_temp(data->sensor_data, temp);
> > > +}
> > > +
> > >  static int of_thermal_get_temp(struct thermal_zone_device *tz,
> > >  			       unsigned long *temp)
> > >  {
> > > @@ -352,7 +364,8 @@ static struct thermal_zone_device *
> > >  thermal_zone_of_add_sensor(struct device_node *zone,
> > >  			   struct device_node *sensor, void *data,
> > >  			   int (*get_temp)(void *, long *),
> > > -			   int (*get_trend)(void *, long *))
> > > +			   int (*get_trend)(void *, long *),
> > > +			   int (*set_emul_temp)(void *, unsigned
> > > long))
> >=20
> > Thanks for improving the API. However, looking at what is above, it
> > starts to be pretty ugly. And for sure, this is not the last callback
> > to be added.
>=20
> Presumably there would be some more callbacks.
>=20
> > I believe it is time to add a .ops in the of-thermal.
> > While in here, do you mind adding the .ops in a separated patch, then
> > add the .set_emul_temp in the .ops field?
>=20
> I will add an option to pass .ops with thermal_zone_of_add_sensor().
>=20
> I'm only concerned a bit about testing other users of of-thermal.=20
> I have only beaglebone black (BBB) for testing, which on-soc bandgap
> thermal sensor is very inaccurate and hence not supported even at BBB
> github linux kernel repository (v3.14).
>=20
> Because of above I would need your support for testing.
>=20

I did the .ops part that is required for your patch:
https://patchwork.kernel.org/patch/5329801/

As you already reviewed it. Do you mind refreshing your series on top of
it?

Cheers,


> >=20
> > >  {
> > >  	struct thermal_zone_device *tzd;
> > >  	struct __thermal_zone *tz;
> > > @@ -366,10 +379,12 @@ thermal_zone_of_add_sensor(struct device_node
> > > *zone, mutex_lock(&tzd->lock);
> > >  	tz->get_temp =3D get_temp;
> > >  	tz->get_trend =3D get_trend;
> > > +	tz->set_emul_temp =3D set_emul_temp;
> > >  	tz->sensor_data =3D data;
> > > =20
> > >  	tzd->ops->get_temp =3D of_thermal_get_temp;
> > >  	tzd->ops->get_trend =3D of_thermal_get_trend;
> > > +	tzd->ops->set_emul_temp =3D of_thermal_set_emul_temp;
> > >  	mutex_unlock(&tzd->lock);
> > > =20
> > >  	return tzd;
> > > @@ -411,7 +426,8 @@ thermal_zone_of_add_sensor(struct device_node
> > > *zone, struct thermal_zone_device *
> > >  thermal_zone_of_sensor_register(struct device *dev, int sensor_id,
> > >  				void *data, int (*get_temp)(void
> > > *, long *),
> > > -				int (*get_trend)(void *, long *))
> > > +				int (*get_trend)(void *, long *),
> > > +				int (*set_emul_temp)(void *,
> > > unsigned long)) {
> > >  	struct device_node *np, *child, *sensor_np;
> > > =20
> > > @@ -453,7 +469,8 @@ thermal_zone_of_sensor_register(struct device
> > > *dev, int sensor_id, return thermal_zone_of_add_sensor(child,
> > > sensor_np, data,
> > >  							  get_temp,
> > > -
> > > get_trend);
> > > +
> > > get_trend,
> > > +
> > > set_emul_temp); }
> > >  	}
> > >  	of_node_put(np);
> > > @@ -494,9 +511,11 @@ void thermal_zone_of_sensor_unregister(struct
> > > device *dev, mutex_lock(&tzd->lock);
> > >  	tzd->ops->get_temp =3D NULL;
> > >  	tzd->ops->get_trend =3D NULL;
> > > +	tzd->ops->set_emul_temp =3D NULL;
> > > =20
> > >  	tz->get_temp =3D NULL;
> > >  	tz->get_trend =3D NULL;
> > > +	tz->set_emul_temp =3D NULL;
> > >  	tz->sensor_data =3D NULL;
> > >  	mutex_unlock(&tzd->lock);
> > >  }
> > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > index 0305cde..36010e9 100644
> > > --- a/include/linux/thermal.h
> > > +++ b/include/linux/thermal.h
> > > @@ -290,14 +290,16 @@ struct thermal_genl_event {
> > >  struct thermal_zone_device *
> > >  thermal_zone_of_sensor_register(struct device *dev, int id,
> > >  				void *data, int (*get_temp)(void
> > > *, long *),
> > > -				int (*get_trend)(void *, long *));
> > > +				int (*get_trend)(void *, long *),
> > > +				int (*set_emul_temp)(void *,
> > > unsigned long)); void thermal_zone_of_sensor_unregister(struct
> > > device *dev, struct thermal_zone_device *tz);
> > >  #else
> > >  static inline struct thermal_zone_device *
> > >  thermal_zone_of_sensor_register(struct device *dev, int id,
> > >  				void *data, int (*get_temp)(void
> > > *, long *),
> > > -				int (*get_trend)(void *, long *))
> > > +				int (*get_trend)(void *, long *),
> > > +				int (*set_emul_temp)(void *,
> > > unsigned long)) {
> > >  	return NULL;
> > >  }
> > > --=20
> > > 2.0.0.rc2
> > >=20
>=20
>=20
>=20
> --=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUa2RlAAoJEMLUO4d9pOJWUoIH/3t+oN9xb9nDHSqfcd/ejmTy
8R7FQ53X3zKPwPB9EZ4k7SSJ3IvrxgGtXf3v4H5ZgU6psIUP9uCLQZ4jOddCdtos
FmhlKh0NikPJ2E0xkbepZfLfsgp1Suqhxkm1uehyj/n+xNWzP74FiNuT6Dqed4VE
m8dGj+RyZt66PtAZfmyKY4am28VFJsaWb4CdCVvvEqFNaKKZ/xJj8qrV/Nhpk8lV
tt+FQoiOgSCdh9JB6sWioEg13r0qJ4GpLkG3NbyaWWcOi3JHHl3usfgAFIgRHj14
QxFJYiKzDXlj9Xv/EosN731J3VEvVUMB9OChe/vOW+OlF74krCpF/D6Htqggki4=
=bA99
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
