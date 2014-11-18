From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH 04/21] thermal: of: Extend current of-thermal.c code to
 allow setting emulated temp
Date: Tue, 18 Nov 2014 21:28:10 +0100
Message-ID: <20141118212810.39e48c11@jawa>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-5-git-send-email-l.majewski@samsung.com>
 <20141107014448.GE10180@developer>
 <20141107122035.2973ad20@amdc2363>
 <20141118152327.GB18674@developer>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8692851516957007571=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141118152327.GB18674@developer>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

--===============8692851516957007571==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/EiSyk/O7b0ka8QAVX5JI6g1"; protocol="application/pgp-signature"

--Sig_/EiSyk/O7b0ka8QAVX5JI6g1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Nov 2014 11:23:29 -0400
Eduardo Valentin <edubezval@gmail.com> wrote:

> Lukasz,
>=20
>=20
> On Fri, Nov 07, 2014 at 12:20:35PM +0100, Lukasz Majewski wrote:
> > Hi Eduardo,
> >=20
> > > Hello,
> > >=20
> > > On Thu, Oct 09, 2014 at 06:38:40PM +0200, Lukasz Majewski wrote:
> > > > Before this change it was only possible to set get_temp() and
> > > > get_trend() methods to be used in the common code handling
> > > > passing parameters via device tree to "cpu-thermal" CPU thermal
> > > > zone device.
> > > >=20
> > > > Now it is possible to also set emulated value of temperature for
> > > > debug purposes.
> > > >=20
> > > > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > > > ---
> > > >  drivers/thermal/of-thermal.c | 25 ++++++++++++++++++++++---
> > > >  include/linux/thermal.h      |  6 ++++--
> > > >  2 files changed, 26 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/drivers/thermal/of-thermal.c
> > > > b/drivers/thermal/of-thermal.c index cd74e64..f206375 100644
> > > > --- a/drivers/thermal/of-thermal.c
> > > > +++ b/drivers/thermal/of-thermal.c
> > > > @@ -98,10 +98,22 @@ struct __thermal_zone {
> > > >  	void *sensor_data;
> > > >  	int (*get_temp)(void *, long *);
> > > >  	int (*get_trend)(void *, long *);
> > > > +	int (*set_emul_temp)(void *, unsigned long);
> > > >  };
> > > > =20
> > > >  /***   DT thermal zone device callbacks   ***/
> > > > =20
> > > > +static int of_thermal_set_emul_temp(struct thermal_zone_device
> > > > *tz,
> > > > +				    unsigned long temp)
> > > > +{
> > > > +	struct __thermal_zone *data =3D tz->devdata;
> > > > +
> > > > +	if (!data->set_emul_temp)
> > > > +		return -EINVAL;
> > > > +
> > > > +	return data->set_emul_temp(data->sensor_data, temp);
> > > > +}
> > > > +
> > > >  static int of_thermal_get_temp(struct thermal_zone_device *tz,
> > > >  			       unsigned long *temp)
> > > >  {
> > > > @@ -352,7 +364,8 @@ static struct thermal_zone_device *
> > > >  thermal_zone_of_add_sensor(struct device_node *zone,
> > > >  			   struct device_node *sensor, void
> > > > *data, int (*get_temp)(void *, long *),
> > > > -			   int (*get_trend)(void *, long *))
> > > > +			   int (*get_trend)(void *, long *),
> > > > +			   int (*set_emul_temp)(void *,
> > > > unsigned long))
> > >=20
> > > Thanks for improving the API. However, looking at what is above,
> > > it starts to be pretty ugly. And for sure, this is not the last
> > > callback to be added.
> >=20
> > Presumably there would be some more callbacks.
> >=20
> > > I believe it is time to add a .ops in the of-thermal.
> > > While in here, do you mind adding the .ops in a separated patch,
> > > then add the .set_emul_temp in the .ops field?
> >=20
> > I will add an option to pass .ops with thermal_zone_of_add_sensor().
> >=20
> > I'm only concerned a bit about testing other users of of-thermal.=20
> > I have only beaglebone black (BBB) for testing, which on-soc bandgap
> > thermal sensor is very inaccurate and hence not supported even at
> > BBB github linux kernel repository (v3.14).
> >=20
> > Because of above I would need your support for testing.
> >=20
>=20
> I did the .ops part that is required for your patch:
> https://patchwork.kernel.org/patch/5329801/
>=20
> As you already reviewed it. Do you mind refreshing your series on top
> of it?

Yours patches were almost identical to mine. I will wait maybe two more
days, and if nobody opposed to your concept, I send my work on top of
your patch.

Best regards,
Lukasz Majewski
>=20
> Cheers,
>=20
>=20
> > >=20
> > > >  {
> > > >  	struct thermal_zone_device *tzd;
> > > >  	struct __thermal_zone *tz;
> > > > @@ -366,10 +379,12 @@ thermal_zone_of_add_sensor(struct
> > > > device_node *zone, mutex_lock(&tzd->lock);
> > > >  	tz->get_temp =3D get_temp;
> > > >  	tz->get_trend =3D get_trend;
> > > > +	tz->set_emul_temp =3D set_emul_temp;
> > > >  	tz->sensor_data =3D data;
> > > > =20
> > > >  	tzd->ops->get_temp =3D of_thermal_get_temp;
> > > >  	tzd->ops->get_trend =3D of_thermal_get_trend;
> > > > +	tzd->ops->set_emul_temp =3D of_thermal_set_emul_temp;
> > > >  	mutex_unlock(&tzd->lock);
> > > > =20
> > > >  	return tzd;
> > > > @@ -411,7 +426,8 @@ thermal_zone_of_add_sensor(struct
> > > > device_node *zone, struct thermal_zone_device *
> > > >  thermal_zone_of_sensor_register(struct device *dev, int
> > > > sensor_id, void *data, int (*get_temp)(void
> > > > *, long *),
> > > > -				int (*get_trend)(void *, long
> > > > *))
> > > > +				int (*get_trend)(void *, long
> > > > *),
> > > > +				int (*set_emul_temp)(void *,
> > > > unsigned long)) {
> > > >  	struct device_node *np, *child, *sensor_np;
> > > > =20
> > > > @@ -453,7 +469,8 @@ thermal_zone_of_sensor_register(struct
> > > > device *dev, int sensor_id, return
> > > > thermal_zone_of_add_sensor(child, sensor_np, data,
> > > >  							  get_temp,
> > > > -
> > > > get_trend);
> > > > +
> > > > get_trend,
> > > > +
> > > > set_emul_temp); }
> > > >  	}
> > > >  	of_node_put(np);
> > > > @@ -494,9 +511,11 @@ void
> > > > thermal_zone_of_sensor_unregister(struct device *dev,
> > > > mutex_lock(&tzd->lock); tzd->ops->get_temp =3D NULL;
> > > >  	tzd->ops->get_trend =3D NULL;
> > > > +	tzd->ops->set_emul_temp =3D NULL;
> > > > =20
> > > >  	tz->get_temp =3D NULL;
> > > >  	tz->get_trend =3D NULL;
> > > > +	tz->set_emul_temp =3D NULL;
> > > >  	tz->sensor_data =3D NULL;
> > > >  	mutex_unlock(&tzd->lock);
> > > >  }
> > > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > > index 0305cde..36010e9 100644
> > > > --- a/include/linux/thermal.h
> > > > +++ b/include/linux/thermal.h
> > > > @@ -290,14 +290,16 @@ struct thermal_genl_event {
> > > >  struct thermal_zone_device *
> > > >  thermal_zone_of_sensor_register(struct device *dev, int id,
> > > >  				void *data, int
> > > > (*get_temp)(void *, long *),
> > > > -				int (*get_trend)(void *, long
> > > > *));
> > > > +				int (*get_trend)(void *, long
> > > > *),
> > > > +				int (*set_emul_temp)(void *,
> > > > unsigned long)); void thermal_zone_of_sensor_unregister(struct
> > > > device *dev, struct thermal_zone_device *tz);
> > > >  #else
> > > >  static inline struct thermal_zone_device *
> > > >  thermal_zone_of_sensor_register(struct device *dev, int id,
> > > >  				void *data, int
> > > > (*get_temp)(void *, long *),
> > > > -				int (*get_trend)(void *, long
> > > > *))
> > > > +				int (*get_trend)(void *, long
> > > > *),
> > > > +				int (*set_emul_temp)(void *,
> > > > unsigned long)) {
> > > >  	return NULL;
> > > >  }
> > > > --=20
> > > > 2.0.0.rc2
> > > >=20
> >=20
> >=20
> >=20
> > --=20
> > Best regards,
> >=20
> > Lukasz Majewski
> >=20
> > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group


--Sig_/EiSyk/O7b0ka8QAVX5JI6g1
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlRrq9oACgkQf9/hG2YwgjH/KgCdGnhas3yx3FK2ey4ZqvW7DW9M
14AAnR3CD2G0BH8Ob9aIM6jQqWUlVPvJ
=2Eaf
-----END PGP SIGNATURE-----

--Sig_/EiSyk/O7b0ka8QAVX5JI6g1--


--===============8692851516957007571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8692851516957007571==--
