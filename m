From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 1/2] power: supply: lego_ev3_battery: Don't ignore
 iio_read_channel_processed() return value
Date: Mon, 23 Jul 2018 00:02:11 +0200
Message-ID: <20180722220211.qzlxawn63itxbjmc@earth.universe>
References: <20180720201944.20503-1-david@lechnology.com>
 <20180720201944.20503-2-david@lechnology.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="unnuhg22akc6mbck"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180720201944.20503-2-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--unnuhg22akc6mbck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 20, 2018 at 03:19:43PM -0500, David Lechner wrote:
> This changes the LEGO MINDSTORMS EV3 power supply driver to return an
> error if iio_read_channel_processed() fails.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/lego_ev3_battery.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/lego_ev3_battery.c b/drivers/power/supp=
ly/lego_ev3_battery.c
> index 7b993d669f7f..6e3b3e384172 100644
> --- a/drivers/power/supply/lego_ev3_battery.c
> +++ b/drivers/power/supply/lego_ev3_battery.c
> @@ -39,7 +39,7 @@ static int lego_ev3_battery_get_property(struct power_s=
upply *psy,
>  					 union power_supply_propval *val)
>  {
>  	struct lego_ev3_battery *batt =3D power_supply_get_drvdata(psy);
> -	int val2;
> +	int ret, val2;
> =20
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_TECHNOLOGY:
> @@ -47,11 +47,18 @@ static int lego_ev3_battery_get_property(struct power=
_supply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>  		/* battery voltage is iio channel * 2 + Vce of transistor */
> -		iio_read_channel_processed(batt->iio_v, &val->intval);
> +		ret =3D iio_read_channel_processed(batt->iio_v, &val->intval);
> +		if (ret)
> +			return ret;
> +
>  		val->intval *=3D 2000;
>  		val->intval +=3D 200000;
> +
>  		/* plus adjust for shunt resistor drop */
> -		iio_read_channel_processed(batt->iio_i, &val2);
> +		ret =3D iio_read_channel_processed(batt->iio_i, &val2);
> +		if (ret)
> +			return ret;
> +
>  		val2 *=3D 1000;
>  		val2 /=3D 15;
>  		val->intval +=3D val2;
> @@ -64,7 +71,10 @@ static int lego_ev3_battery_get_property(struct power_=
supply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  		/* battery current is iio channel / 15 / 0.05 ohms */
> -		iio_read_channel_processed(batt->iio_i, &val->intval);
> +		ret =3D iio_read_channel_processed(batt->iio_i, &val->intval);
> +		if (ret)
> +			return ret;
> +
>  		val->intval *=3D 20000;
>  		val->intval /=3D 15;
>  		break;
> --=20
> 2.17.1
>=20

--unnuhg22akc6mbck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltU/uIACgkQ2O7X88g7
+poxBw/+PFhihh/m2VdPZQaT+eUdZ63d/njrXEZCdTHB0OJV16Kn8t8/NmfoS4nX
aBe1eZrpZaHEFC8swR01t67cPUGbRZ/lLvOT7hArhN+ovP0CiGomKBcScCDxnpaB
mhmBzqcBLMTFJabnjCwvFPfmBGbyzq/g+tQU0EwwC7SA2uwf8fGu7DMJO4gEFRgk
8TpM/zwmLtHC+bcXzpB89E9cbnNd3d9XGnxHXRXTuD0POpvclZ0ynVYnNthSmszo
nx2DbxgDaJqHbKt+f8GQBApuvYHT23KgQB9vCbEADgEaWZIbPSV49zIfrcQZb1ca
TU21+I1F+0YnXoYvUIzSQhjoB8fUaPJxA8arLnHYfb+BRXkKGSym+IiHWq4DwN0V
bS4TkeuPnhGDSH37PY0xV2RKewEJ586WsrbO+0rYYlu8JKht3E0W4Rn006Z1qkMX
C9sXjMFFqAIg0sBy1LCaSfqrQpHDkNaKthO9FZrPutonn6eEI9hP2H0ihdXTkp0X
5fgMAlubBNmqWJXm1z/bN2ugHl4FfyfLJNrHHyqL87corTt2KFnStyNOWGF8vv6J
9NGphZr3CQBnPCVqQV/r/Dq/WZ/1L1SVJk3lWYKmFqNbsP+zW3o6PnrgGzHECL6/
4YoOw+bcpUGKj1Vo92kVuIGNfSZgTk8nFS1mSMYForshRH2t0M4=
=XyMI
-----END PGP SIGNATURE-----

--unnuhg22akc6mbck--
