From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 05/13] thermal: inline only once used function
Date: Mon, 6 Apr 2015 19:23:08 -0700
Message-ID: <20150407022307.GE4648@localhost.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-6-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35706 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbbDGCXA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 22:23:00 -0400
Content-Disposition: inline
In-Reply-To: <1427385240-6086-6-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 04:53:52PM +0100, Sascha Hauer wrote:
> Inline update_temperature into its only caller to make the code
> more readable.

I am not sure I understand how this is improving readability, can you
please elaborate?

The way it is now it is more modular at least.

>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/thermal_core.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index ebca854..6d0fdad 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -431,11 +431,15 @@ exit:
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
> =20
> -static void update_temperature(struct thermal_zone_device *tz)
> +void thermal_zone_device_update(struct thermal_zone_device *tz)
>  {
> +	int count;
>  	unsigned long temp;
>  	int ret;
> =20
> +	if (!tz->ops->get_temp)
> +		return;
> +
>  	ret =3D thermal_zone_get_temp(tz, &temp);
>  	if (ret) {
>  		dev_warn(&tz->device, "failed to read out thermal zone %d\n",
> @@ -451,16 +455,6 @@ static void update_temperature(struct thermal_zone_d=
evice *tz)
>  	trace_thermal_temperature(tz);
>  	dev_dbg(&tz->device, "last_temperature=3D%lu, current_temperature=3D%lu=
\n",
>  				tz->last_temperature, tz->temperature);
> -}
> -
> -void thermal_zone_device_update(struct thermal_zone_device *tz)
> -{
> -	int count;
> -
> -	if (!tz->ops->get_temp)
> -		return;
> -
> -	update_temperature(tz);
> =20
>  	for (count =3D 0; count < tz->trips; count++)
>  		handle_thermal_trip(tz, count);
> --=20
> 2.1.4
>=20

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVIz+DAAoJEMLUO4d9pOJWxQEH/1RbKQ++9tuf9RNxqSdwIsaY
TM9J/JUsFan1fP0IkoksEJ5KFvXxXumWHEYdG+ZBqyRphaRZ/Q478Uz/lHaA2qwR
A79xgG9TgOtqAVtMdZ54S//sBg+2F5Shj7ZvaIChAJjEWA+beGYjMW/5zD47dwL3
XL0XEuNrdV9gkyd8JLWWUQaXTmd+00uAR/2RT6riDBmaFlQ4jd+996fmH+kEytrg
lC0bHa0kQ9eCaC+PiZeGu6S3unpEhplJuugKKlhuBb5xlbwXeyRlcLGvxqxBWoGx
bO/5reT78BLyMYicP2JE9dUH4En1cUSOAc8cBYnBXmvvNskQOEc2eyIJt+fw7oo=
=k/aY
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
