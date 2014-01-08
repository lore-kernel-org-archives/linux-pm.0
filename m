From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] thermal: add trip parameter for of .get_trend
Date: Wed, 8 Jan 2014 08:48:44 -0400
Message-ID: <52CD492C.2030508@ti.com>
References: <1389172038-723-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nWmnMQRfs8GbSnPfSvQeJM0E1kTb0Qvkw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37453 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610AbaAHMsz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2014 07:48:55 -0500
In-Reply-To: <1389172038-723-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, mark.rutland@arm.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org

--nWmnMQRfs8GbSnPfSvQeJM0E1kTb0Qvkw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08-01-2014 05:07, Wei Ni wrote:
> Add trip parameter for the of-thermal's .get_trend(), so
> that it can be compatible with current thermal framework.

You need to have a better look on the existing users of an API before
changing it.

>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/thermal/of-thermal.c                       |   16 +++++-------=
----
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   18 +++++++++---=
------
>  include/linux/thermal.h                            |    4 ++--
>  3 files changed, 16 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.=
c
> index 97c12cf..a503e61 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -97,7 +97,7 @@ struct __thermal_zone {
>  	/* sensor interface */
>  	void *sensor_data;
>  	int (*get_temp)(void *, long *);
> -	int (*get_trend)(void *, long *);
> +	int (*get_trend)(void *, int, long *);
>  };
> =20
>  /***   DT thermal zone device callbacks   ***/
> @@ -123,17 +123,11 @@ static int of_thermal_get_trend(struct thermal_zo=
ne_device *tz, int trip,
>  	if (!data->get_trend)
>  		return -EINVAL;
> =20
> -	r =3D data->get_trend(data->sensor_data, &dev_trend);
> +	r =3D data->get_trend(data->sensor_data, trip, &dev_trend);
>  	if (r)
>  		return r;
> =20
> -	/* TODO: These intervals might have some thresholds, but in core code=
 */
> -	if (dev_trend > 0)
> -		*trend =3D THERMAL_TREND_RAISING;
> -	else if (dev_trend < 0)
> -		*trend =3D THERMAL_TREND_DROPPING;
> -	else
> -		*trend =3D THERMAL_TREND_STABLE;
> +	*trend =3D dev_trend;
> =20
>  	return 0;
>  }
> @@ -325,7 +319,7 @@ static struct thermal_zone_device *
>  thermal_zone_of_add_sensor(struct device_node *zone,
>  			   struct device_node *sensor, void *data,
>  			   int (*get_temp)(void *, long *),
> -			   int (*get_trend)(void *, long *))
> +			   int (*get_trend)(void *, int, long *))
>  {
>  	struct thermal_zone_device *tzd;
>  	struct __thermal_zone *tz;
> @@ -384,7 +378,7 @@ thermal_zone_of_add_sensor(struct device_node *zone=
,
>  struct thermal_zone_device *
>  thermal_zone_of_sensor_register(struct device *dev, int sensor_id,
>  				void *data, int (*get_temp)(void *, long *),
> -				int (*get_trend)(void *, long *))
> +				int (*get_trend)(void *, int, long *))
>  {
>  	struct device_node *np, *child, *sensor_np;
> =20
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drive=
rs/thermal/ti-soc-thermal/ti-thermal-common.c
> index 9eec26d..1a8ae03 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -239,7 +239,7 @@ static int ti_thermal_get_trip_temp(struct thermal_=
zone_device *thermal,
>  	return 0;
>  }
> =20
> -static int __ti_thermal_get_trend(void *p, long *trend)
> +static int __ti_thermal_get_trend(void *p, int trip, long *trend)
>  {
>  	struct ti_thermal_data *data =3D p;
>  	struct ti_bandgap *bgp;
> @@ -252,7 +252,12 @@ static int __ti_thermal_get_trend(void *p, long *t=
rend)
>  	if (ret)
>  		return ret;
> =20
> -	*trend =3D tr;
> +	if (tr > 0)
> +		*trend =3D THERMAL_TREND_RAISING;
> +	else if (tr < 0)
> +		*trend =3D THERMAL_TREND_DROPPING;
> +	else
> +		*trend =3D THERMAL_TREND_STABLE;
> =20
>  	return 0;
>  }
> @@ -264,16 +269,11 @@ static int ti_thermal_get_trend(struct thermal_zo=
ne_device *thermal,
>  	int ret;
>  	long tr;
> =20
> -	ret =3D __ti_thermal_get_trend(thermal->devdata, &tr);
> +	ret =3D __ti_thermal_get_trend(thermal->devdata, trip, &tr);
>  	if (ret)
>  		return ret;
> =20
> -	if (tr > 0)
> -		*trend =3D THERMAL_TREND_RAISING;
> -	else if (tr < 0)
> -		*trend =3D THERMAL_TREND_DROPPING;
> -	else
> -		*trend =3D THERMAL_TREND_STABLE;
> +	*trend =3D tr;

This enforces users of this API (device drivers) to be compatible to
thermal framework, which is not always the case. For instance, hwmon
drivers are not aware of thermal constants.

> =20
>  	return 0;
>  }
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index a94de8c..37e4e03 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -249,14 +249,14 @@ struct thermal_genl_event {
>  struct thermal_zone_device *
>  thermal_zone_of_sensor_register(struct device *dev, int id,
>  				void *data, int (*get_temp)(void *, long *),
> -				int (*get_trend)(void *, long *));
> +				int (*get_trend)(void *, int, long *));
>  void thermal_zone_of_sensor_unregister(struct device *dev,
>  				       struct thermal_zone_device *tz);
>  #else
>  static inline struct thermal_zone_device *
>  thermal_zone_of_sensor_register(struct device *dev, int id,
>  				void *data, int (*get_temp)(void *, long *),
> -				int (*get_trend)(void *, long *))
> +				int (*get_trend)(void *, int, long *))
>  {
>  	return NULL;
>  }
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--nWmnMQRfs8GbSnPfSvQeJM0E1kTb0Qvkw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLNSSwACgkQCXcVR3XQvP1XewEA2j8i5cTp9Ub50+q6ITImd2/C
u1gKwXzCCsOYlwdQC2AA/j0oB5lCf5k+cVLjKifLyV5gGkfFyhvmGIkf9aF6O3Lp
=xUMj
-----END PGP SIGNATURE-----

--nWmnMQRfs8GbSnPfSvQeJM0E1kTb0Qvkw--
