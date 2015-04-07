From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 12/13] thermal: Add support for hardware-tracked trip
 points
Date: Mon, 6 Apr 2015 19:40:28 -0700
Message-ID: <20150407024027.GG4648@localhost.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-13-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36018 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbbDGCkU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 22:40:20 -0400
Content-Disposition: inline
In-Reply-To: <1427385240-6086-13-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 04:53:59PM +0100, Sascha Hauer wrote:
> This adds support for hardware-tracked trip points to the device tree
> thermal sensor framework.
>=20
> The framework supports an arbitrary number of trip points. Whenever
> the current temperature is updated, the trip points immediately
> below and above the current temperature are found. A .set_trips
> callback is then called with the temperatures. If there is no trip
> point above or below the current temperature, the passed trip
> temperature will be ULONG_MAX or 0 respectively. In this callback,
> the driver should program the hardware such that it is notified
> when either of these trip points are triggered. When a trip point
> is triggered, the driver should call `thermal_zone_device_update'
> for the respective thermal zone. This will cause the trip points
> to be updated again.
>=20
> If .set_trips is not implemented, the framework behaves as before.
>=20
> This patch is based on an earlier version from Mikko Perttunen
> <mikko.perttunen@kapsi.fi>
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/thermal_core.c | 41 ++++++++++++++++++++++++++++++++++++=
+++++
>  include/linux/thermal.h        |  3 +++
>  2 files changed, 44 insertions(+)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index dcdf45e..7138f8f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -434,6 +434,45 @@ int thermal_zone_get_temp(struct thermal_zone_device=
 *tz, unsigned long *temp)
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
> =20
> +static void thermal_zone_set_trips(struct thermal_zone_device *tz)
> +{
> +	unsigned long low =3D 0;
> +	unsigned long high =3D ULONG_MAX;
> +	unsigned long trip_temp, hysteresis;
> +	unsigned long temp =3D tz->temperature;
> +	int i;
> +
> +	if (!tz->ops->set_trips)
> +		return;
> +
> +	/* No need to change trip points */
> +	if (temp > tz->prev_low_trip && temp < tz->prev_high_trip)
> +		return;
> +
> +	for (i =3D 0; i < tz->trips; i++) {
> +		unsigned long trip_low;
> +
> +		tz->ops->get_trip_temp(tz, i, &trip_temp);
> +		tz->ops->get_trip_hyst(tz, i, &hysteresis);
> +
> +		trip_low =3D trip_temp - hysteresis;
> +
> +		if (trip_low < temp && trip_low > low)
> +			low =3D trip_low;
> +
> +		if (trip_temp > temp && trip_temp < high)
> +			high =3D trip_temp;
> +	}
> +
> +	tz->prev_low_trip =3D low;
> +	tz->prev_high_trip =3D high;
> +
> +	dev_dbg(&tz->device, "new temperature boundaries: %lu < x < %lu\n",
> +			low, high);
> +
> +	tz->ops->set_trips(tz, low, high);
> +}
> +
>  void thermal_zone_device_update(struct thermal_zone_device *tz)
>  {
>  	int count;
> @@ -460,6 +499,8 @@ void thermal_zone_device_update(struct thermal_zone_d=
evice *tz)
>  	dev_dbg(&tz->device, "last_temperature=3D%lu, current_temperature=3D%lu=
\n",
>  				tz->last_temperature, tz->temperature);
> =20
> +	thermal_zone_set_trips(tz);

Do we need to lock the tz->lock to perform this operation of setting the
hardware trip points?

> +
>  	for (count =3D 0; count < tz->trips; count++)
>  		handle_thermal_trip(tz, count);
>  }
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index ac2897c..b870702 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -87,6 +87,7 @@ struct thermal_zone_device_ops {
>  	int (*unbind) (struct thermal_zone_device *,
>  		       struct thermal_cooling_device *);
>  	int (*get_temp) (struct thermal_zone_device *, unsigned long *);
> +	int (*set_trips) (struct thermal_zone_device *, unsigned long, unsigned=
 long);
>  	int (*get_mode) (struct thermal_zone_device *,
>  			 enum thermal_device_mode *);
>  	int (*set_mode) (struct thermal_zone_device *,
> @@ -183,6 +184,8 @@ struct thermal_zone_device {
>  	unsigned long temperature;
>  	unsigned long last_temperature;
>  	unsigned long emul_temperature;
> +	unsigned long prev_low_trip;
> +	unsigned long prev_high_trip;
>  	int passive;
>  	unsigned int forced_passive;
>  	const struct thermal_zone_device_ops *ops;
> --=20
> 2.1.4
>=20

--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVI0OXAAoJEMLUO4d9pOJWl4UH/0sK7HEA1M6SkZYyb1nTiyJM
hu3WltO7xC8/nwej2OsLfh5G/zmwvqWNGUYPxbQrmgpJPSvE+DOAyuHXRLY/lCt2
FH9aNFTtIfNn6WhmsMBSy3rFVxCkZ8BNVZSZPHelKOXiQLDDpBWtnZ08F0rPT5wH
U/AZmKb2lNJj3iqQ+7DsPY7O96mkmq0QsCb6p7NFzXGakfWfODJswjBuGmJa9RTt
YTr/B07+/ou9uoQMi/ehfy5SS/UEJmZNsTatvpvTwU2nI7fTxxiBWmJClS2Zxfas
OoV7UbRGEBCI9gNpo3eXTcnmmo0z4erhbi4C82kjm+ViYBxFujrTXA5QetFgppo=
=vY1O
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--
