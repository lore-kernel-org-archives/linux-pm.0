From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v7 10/10] power: supply: sbs-battery: move gpio present
 detect to sbs_get_property
Date: Mon, 3 Jul 2017 17:21:03 +0200
Message-ID: <20170703152103.vw4htej6xswmzeky@earth>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
 <1497535178-12001-11-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gyhd445ngqeoqlnx"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52799 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbdGCPVH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 11:21:07 -0400
Content-Disposition: inline
In-Reply-To: <1497535178-12001-11-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org


--gyhd445ngqeoqlnx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 15, 2017 at 09:59:38PM +0800, Phil Reid wrote:
> Currently when a gpio is defined for battery presence it is only used in
> the sbs_get_battery_presence_and_health function for 2 properties.
> All other properties currently try to read data form the battery before
> returning an error if not present. We should know in advance that no
> data is going to returned.
>=20
> As the driver tries multiple times to access a property, this prevents
> a lot of smbus accesses, which had a significant effect on device boot-up.
> As when the device is registered lots of property accesses are attempted
> during boot.
>=20
> If no gpio is used for presence detection no change in behaviour should
> occur.
>=20
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  drivers/power/supply/sbs-battery.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index cf43e38..1e3a8b2 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -324,16 +324,6 @@ static int sbs_get_battery_presence_and_health(
>  	union power_supply_propval *val)
>  {
>  	s32 ret;
> -	struct sbs_info *chip =3D i2c_get_clientdata(client);
> -
> -	if (psp =3D=3D POWER_SUPPLY_PROP_PRESENT && chip->gpio_detect) {
> -		ret =3D gpiod_get_value_cansleep(chip->gpio_detect);
> -		if (ret < 0)
> -			return ret;
> -		val->intval =3D ret;
> -		chip->is_present =3D val->intval;
> -		return ret;
> -	}
> =20
>  	/*
>  	 * Write to ManufacturerAccess with ManufacturerAccess command
> @@ -599,6 +589,19 @@ static int sbs_get_property(struct power_supply *psy,
>  	struct sbs_info *chip =3D power_supply_get_drvdata(psy);
>  	struct i2c_client *client =3D chip->client;
> =20
> +	if (chip->gpio_detect) {
> +		ret =3D gpiod_get_value_cansleep(chip->gpio_detect);
> +		if (ret < 0)
> +			return ret;
> +		if (psp =3D=3D POWER_SUPPLY_PROP_PRESENT) {
> +			val->intval =3D ret;
> +			chip->is_present =3D val->intval;
> +			return 0;
> +		}
> +		if (ret =3D=3D 0)
> +			return -ENODATA;
> +	}
> +
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_PRESENT:
>  	case POWER_SUPPLY_PROP_HEALTH:
> --=20
> 1.8.3.1
>=20

--gyhd445ngqeoqlnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllaYN8ACgkQ2O7X88g7
+poBEw//SkbgBsGBo0cIjuHFRVib5iLUCbf8VWE1Fia/GAZEEtuHBueYsrsKCLUh
c2RNcH2vVPuzBbhgMqo5sVP2pY9yd9FSuJlF9xfEVzGqNaJ1BzbdJjzvnu15jevK
BlO6JIa+/5f8ELOpR2SttYKyPijKJlPSzHf0ONmJOxU/9LDjRRxt/kXN3iZPGIm9
sbPt0zpqWgXtnnkcHD1POKbImYUlq//Ji8vRikDZMwb8z9Q+5eVAujz4EtaGSfLn
CcotUd3AzVhOtzz/WdzoaY7F/TA92ONFJgK5Md4LJtKcbp6SpPGQB6ykuwM8qGbC
8xIBqB2nUJQPx9NAg/S55yQeCd/cIQ9SaicOpWIGJOwC+tGlAT1ZI8rx2ayLuyMX
OhbF5i2713St32xjhb52Zc0ckDmhBZdFpNCJDTlW8E73vl7yhnld2sVz0TiH+akL
jt+3BbecPuTFPoMqp1LhKdTXnnBkM7GLwWz7dtmJIL8SbsAD+6rjh78yOmY46P1I
GOLwf6aj9G5rsOv/KbW/MnkEwBypzU5sA2+wPTeDvaN1LLxeMRkG5mB2XJxU+PZj
r8vVqS9V/emy3VteSME3kftBv+eqPp4NrLJ/lKTnKbSVED//fS8CD+Fy7Mx4TJhN
+uc+OXpbABk+m/r8qhkmh2k74X7JBuoWKXd0TzGYxMgkKsS2NPw=
=W8UP
-----END PGP SIGNATURE-----

--gyhd445ngqeoqlnx--
