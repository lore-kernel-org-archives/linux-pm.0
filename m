From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 09/13] thermal: of: always set sensor related callbacks
Date: Mon, 6 Apr 2015 20:25:23 -0700
Message-ID: <20150407032522.GL4648@localhost.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-10-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AGBBLMjITsWHeOTZ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33120 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbbDGDZR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 23:25:17 -0400
Content-Disposition: inline
In-Reply-To: <1427385240-6086-10-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org


--AGBBLMjITsWHeOTZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 04:53:56PM +0100, Sascha Hauer wrote:
> Now that the thermal core treats -ENOSYS like the callbacks were
> not present at all we no longer have to overwrite the ops during
> runtime but instead can always set them and return -ENOSYS if no
> sensor is registered.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/of-thermal.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index b39e22f..df14fdd 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -91,7 +91,7 @@ static int of_thermal_get_temp(struct thermal_zone_devi=
ce *tz,
>  {
>  	struct __thermal_zone *data =3D tz->devdata;
> =20
> -	if (!data->ops->get_temp)
> +	if (!data->ops)
>  		return -EINVAL;
> =20
>  	return data->ops->get_temp(data->sensor_data, temp);
> @@ -178,7 +178,7 @@ static int of_thermal_set_emul_temp(struct thermal_zo=
ne_device *tz,
>  	struct __thermal_zone *data =3D tz->devdata;
> =20
>  	if (!data->ops || !data->ops->set_emul_temp)
> -		return -EINVAL;
> +		return -ENOSYS;
> =20
>  	return data->ops->set_emul_temp(data->sensor_data, temp);
>  }
> @@ -189,8 +189,8 @@ static int of_thermal_get_trend(struct thermal_zone_d=
evice *tz, int trip,
>  	struct __thermal_zone *data =3D tz->devdata;
>  	int r;
> =20
> -	if (!data->ops->get_trend)
> -		return -EINVAL;
> +	if (!data->ops || !data->ops->get_trend)
> +		return -ENOSYS;
> =20
>  	r =3D data->ops->get_trend(data->sensor_data, trip, trend);
>  	if (r)
> @@ -366,6 +366,10 @@ static int of_thermal_get_crit_temp(struct thermal_z=
one_device *tz,
>  }
> =20
>  static struct thermal_zone_device_ops of_thermal_ops =3D {
> +	.get_temp =3D of_thermal_get_temp,
> +	.get_trend =3D of_thermal_get_trend,
> +	.set_emul_temp =3D of_thermal_set_emul_temp,
> +
>  	.get_mode =3D of_thermal_get_mode,
>  	.set_mode =3D of_thermal_set_mode,
> =20
> @@ -399,13 +403,13 @@ thermal_zone_of_add_sensor(struct device_node *zone,
>  	if (!ops)
>  		return ERR_PTR(-EINVAL);
> =20
> +	if (!ops->get_temp)
> +		return ERR_PTR(-EINVAL);
> +
>  	mutex_lock(&tzd->lock);
>  	tz->ops =3D ops;
>  	tz->sensor_data =3D data;
> =20
> -	tzd->ops->get_temp =3D of_thermal_get_temp;
> -	tzd->ops->get_trend =3D of_thermal_get_trend;
> -	tzd->ops->set_emul_temp =3D of_thermal_set_emul_temp;

You may want to update the thermal_zone_of_sensor_unregister too.

>  	mutex_unlock(&tzd->lock);
> =20
>  	return tzd;
> --=20
> 2.1.4
>=20

--AGBBLMjITsWHeOTZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVI039AAoJEMLUO4d9pOJWyukH/3VQ0Elpg7/7A6pBfvYxouYM
7qaMsQmU9MaA/EolT5q79I5CkqLknwnl525EtclgzXFV3WHpN5AOk3V7WE6XcJCf
IM1moD9emN7bNCMf2W9VTM6WkL2r/roHMOp5hKp3Q3dUppRpjjSlfuDr7x7i0wSU
PwW4h9wEFC3/78j+x1XYQYEoD9FklHo/I0GB5nHRX7OnU3cwFL6xW2ZP9jKk263T
AtgyJYvcLflB3sWxNFT5Mfwga7qoHILYRUtapB1jKmWkHU4CyWKFZM8anpBz+XHn
494+1mVcEH1JMtccEaWWvXGjFE8DaKJ9enLAh4Es6Wf1O67aqqJEZbdbDHe7Yrs=
=ndI7
-----END PGP SIGNATURE-----

--AGBBLMjITsWHeOTZ--
