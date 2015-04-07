From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 06/13] thermal: streamline get_trend callbacks
Date: Mon, 6 Apr 2015 20:19:52 -0700
Message-ID: <20150407031950.GK4648@localhost.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-7-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0FM4RQAc0jwHekq5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36503 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbbDGDTq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 23:19:46 -0400
Content-Disposition: inline
In-Reply-To: <1427385240-6086-7-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org


--0FM4RQAc0jwHekq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 04:53:53PM +0100, Sascha Hauer wrote:
> The .get_trend callback in struct thermal_zone_device_ops has the prototy=
pe:
>=20
> 	int (*get_trend) (struct thermal_zone_device *, int,
> 			  enum thermal_trend *);
>=20
> whereas the .get_trend callback in struct thermal_zone_of_device_ops has:
>=20
> 	int (*get_trend)(void *, long *);
>=20
> Streamline both prototypes and add the trip argument to the OF callback
> aswell and use enum thermal_trend * instead of an integer pointer.
>=20
> While the OF prototype may be the better one, this should be decided at
> framework level and not on OF level.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/of-thermal.c                       | 11 +---------
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 25 +++++++---------=
------
>  include/linux/thermal.h                            |  2 +-
>  3 files changed, 10 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 668fb1b..b39e22f 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -187,24 +187,15 @@ static int of_thermal_get_trend(struct thermal_zone=
_device *tz, int trip,
>  				enum thermal_trend *trend)
>  {
>  	struct __thermal_zone *data =3D tz->devdata;
> -	long dev_trend;
>  	int r;
> =20
>  	if (!data->ops->get_trend)
>  		return -EINVAL;
> =20
> -	r =3D data->ops->get_trend(data->sensor_data, &dev_trend);
> +	r =3D data->ops->get_trend(data->sensor_data, trip, trend);
>  	if (r)
>  		return r;
> =20
> -	/* TODO: These intervals might have some thresholds, but in core code */
> -	if (dev_trend > 0)
> -		*trend =3D THERMAL_TREND_RAISING;
> -	else if (dev_trend < 0)
> -		*trend =3D THERMAL_TREND_DROPPING;
> -	else
> -		*trend =3D THERMAL_TREND_STABLE;
> -
>  	return 0;
>  }
> =20
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers=
/thermal/ti-soc-thermal/ti-thermal-common.c
> index a38c175..7f8e5f3 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -238,7 +238,7 @@ static int ti_thermal_get_trip_temp(struct thermal_zo=
ne_device *thermal,
>  	return 0;
>  }
> =20
> -static int __ti_thermal_get_trend(void *p, long *trend)
> +static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend =
*trend)
>  {
>  	struct ti_thermal_data *data =3D p;
>  	struct ti_bandgap *bgp;
> @@ -251,22 +251,6 @@ static int __ti_thermal_get_trend(void *p, long *tre=
nd)
>  	if (ret)
>  		return ret;
> =20
> -	*trend =3D tr;
> -
> -	return 0;
> -}
> -
> -/* Get the temperature trend callback functions for thermal zone */
> -static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
> -				int trip, enum thermal_trend *trend)
> -{
> -	int ret;
> -	long tr;
> -
> -	ret =3D __ti_thermal_get_trend(thermal->devdata, &tr);
> -	if (ret)
> -		return ret;
> -
>  	if (tr > 0)
>  		*trend =3D THERMAL_TREND_RAISING;
>  	else if (tr < 0)
> @@ -277,6 +261,13 @@ static int ti_thermal_get_trend(struct thermal_zone_=
device *thermal,
>  	return 0;
>  }
> =20
> +/* Get the temperature trend callback functions for thermal zone */
> +static int ti_thermal_get_trend(struct thermal_zone_device *thermal,
> +				int trip, enum thermal_trend *trend)
> +{
> +	return __ti_thermal_get_trend(thermal->devdata, trip, trend);
> +}
> +
>  /* Get critical temperature callback functions for thermal zone */
>  static int ti_thermal_get_crit_temp(struct thermal_zone_device *thermal,
>  				    unsigned long *temp)
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index db6c12b..ba2e29a 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -273,7 +273,7 @@ struct thermal_genl_event {
>   */
>  struct thermal_zone_of_device_ops {
>  	int (*get_temp)(void *, long *);
> -	int (*get_trend)(void *, long *);
> +	int (*get_trend)(void *, int trend, enum thermal_trend *);

Could you please keep the kernel doc entry up to date?


Apart from that, looks good to me.

>  	int (*set_emul_temp)(void *, unsigned long);
>  };
> =20
> --=20
> 2.1.4
>=20

--0FM4RQAc0jwHekq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVI0zRAAoJEMLUO4d9pOJWd1sH/1efN2Us60VOa2IrQ7JTb/xp
kEQuZKcb27AXv7T4gbYqJUKz9XbYz0U2xK2/SJL/a+MD66efm2WQBAzN2ay919Cm
kuwi/dAUKGaDq7tj/DsvcsK0IMd8DA3FRGYE7Yi1ynPqjr4gQ7WnlQBsI00UclpD
MutAzReGhTDs65qEV9NDFtvkB5xCHfhtYyNo2+K1nds+R+KDMFccEcPP0r1fjniT
vVymzHaQarb5g3TV8iUXgaMTEVmAFGBUWtRYLPUJd6PXRWeh6+II+bAX7FNDTcW7
EOczz2SokC7c7hK83TPPOZ3z2W+ycEFGARVZfuNmK6Q6H1rc79mEwQhDM1bVpcY=
=qZRm
-----END PGP SIGNATURE-----

--0FM4RQAc0jwHekq5--
