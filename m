From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [RFC PATCH 5/5] power: generic-adc-battery: Add capacity handling
Date: Tue, 29 Aug 2017 12:11:47 +0200
Message-ID: <20170829101147.debhadzyfrxhkrvt@earth>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ttrkynuklo57xaqr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek.belisko@open-nandra.com>
Cc: robh+dt@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, pavel@ucw.cz, Marek Belisko <marek.belisko@gmail.com>
List-Id: linux-pm@vger.kernel.org


--ttrkynuklo57xaqr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 01, 2017 at 10:55:26PM +0200, Marek Belisko wrote:
> From: Marek Belisko <marek.belisko@gmail.com>
>=20
> Signed-off-by: Marek Belisko <marek.belisko@gmail.com>
> ---
>  drivers/power/supply/generic-adc-battery.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/s=
upply/generic-adc-battery.c
> index 0d27b59..9ce51d2 100644
> --- a/drivers/power/supply/generic-adc-battery.c
> +++ b/drivers/power/supply/generic-adc-battery.c
> @@ -24,6 +24,7 @@
>  #include <linux/iio/types.h>
>  #include <linux/power/generic-adc-battery.h>
>  #include <linux/of_gpio.h>
> +#include <linux/power/generic-fuel-gauge.h>
> =20
>  #define JITTER_DEFAULT 10 /* hope 10ms is enough */
> =20
> @@ -81,6 +82,7 @@ static const enum power_supply_property gab_props[] =3D=
 {
>  	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_CAPACITY,
>  };
> =20
>  /*
> @@ -202,6 +204,18 @@ static int gab_get_property(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_MODEL_NAME:
>  		val->strval =3D bat_info->name;
>  		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		{
> +		int ret, curr, voltage;
> +
> +		ret =3D read_channel(adc_bat, POWER_SUPPLY_PROP_CURRENT_NOW, &curr);
> +		ret |=3D read_channel(adc_bat, POWER_SUPPLY_PROP_VOLTAGE_NOW, &voltage=
);
> +		if (ret < 0)
> +			goto err;
> +
> +		val->intval =3D fuel_level_LiIon(voltage, curr, 10);
> +		}
> +		break;
>  	default:
>  		return -EINVAL;
>  	}

Without patch description: See Last Question in

Documentation/power/power_supply_class.txt

-- Sebastian

--ttrkynuklo57xaqr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlPeAACgkQ2O7X88g7
+prqRA//aZhp5YFpO5SE7OSboboSWkmn9WbD+eWJhF9r3HpuukZ65XuQEcOODldL
jNUdO4LUSxCZ9qfLXnIvvAwk0HyIh0G/T0gzEt6vhdOCeuqgmoPqwBFCtXPfyb0+
6n6nyzSLVCinHL0iPOfOWT3dB9DwmI14dDqkJC2qkc0Wn/zqQqOQ3x7H4hS3/aKL
quReqmP60zmCavil+oDdY1PYic2pgpogDqgD7kS4LFseww6VrjN5auBuGRA/VKa7
FxNo4y7LQxJDXHaMpM6XQkdfQbkXXrqkUqwpcmtDohEAkQohUzCfc3nj7yJwo5s+
JtjBHk3asd8h5rJdUrH5iU/bxR3iKwyf9q5cChHDCuG/joqenLR00DTHkjE6ea4X
lxgyN4poFT+vwmhf71QFHB1V8rqE8j54x8I62inCHJbxO0tvKZyoIbEUTryvZjRj
uh51ODJD2GYKLgE33122MjpE0hHlaJGyZDrtDqFcevqNgF/cQuk6g0+M3EpK6u1r
KG4jJ3ktN+iSr0uT082P7AUrQn8tsa5teLyXDfLtKUmhgmmC8auzosr8AoweTTB4
NFsagRkjgwCaBqfEii/uG/dkw+xRFSMZHw4VOa5G9UhNcFMUxlIkpkbVUWnIKbL6
sDHFQh7SGaLDWbASORZJUd5phjVfqNfTD1UYMOjrAyeswWBKRZM=
=E3Gy
-----END PGP SIGNATURE-----

--ttrkynuklo57xaqr--
