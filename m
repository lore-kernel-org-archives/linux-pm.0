From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [RFC PATCH 3/5] power/generic-adc-battery: Add support for
 temperature and add check for charge from iio current channel
Date: Tue, 29 Aug 2017 11:54:55 +0200
Message-ID: <20170829095455.uq7ducjv5aa2n5vo@earth>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-4-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j6324ebnnuudu5w5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56028 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbdH2JzA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 05:55:00 -0400
Content-Disposition: inline
In-Reply-To: <1501620926-22669-4-git-send-email-marek.belisko@open-nandra.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Belisko <marek.belisko@open-nandra.com>
Cc: robh+dt@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, pavel@ucw.cz, Marek Belisko <marek.belisko@gmail.com>


--j6324ebnnuudu5w5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 01, 2017 at 10:55:24PM +0200, Marek Belisko wrote:
> From: Marek Belisko <marek.belisko@gmail.com>
>=20
> Status reporting not working yet. During boot when workqueue is called st=
atus
> is updated (by reading iio current channel but value is -705 (reason unkn=
own as later
> report correct value).
>=20
> Signed-off-by: Marek Belisko <marek.belisko@gmail.com>
> ---
>  drivers/power/supply/generic-adc-battery.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/s=
upply/generic-adc-battery.c
> index d4daa6a..0d27b59 100644
> --- a/drivers/power/supply/generic-adc-battery.c
> +++ b/drivers/power/supply/generic-adc-battery.c
> @@ -31,6 +31,7 @@ enum gab_chan_type {
>  	GAB_VOLTAGE =3D 0,
>  	GAB_CURRENT,
>  	GAB_POWER,
> +	GAB_TEMPERATURE,
>  	GAB_MAX_CHAN_TYPE
>  };
> =20
> @@ -41,7 +42,8 @@ enum gab_chan_type {
>  static const char *const gab_chan_name[] =3D {
>  	[GAB_VOLTAGE]	=3D "voltage",
>  	[GAB_CURRENT]	=3D "current",
> -	[GAB_POWER]		=3D "power",
> +	[GAB_POWER]	=3D "power",
> +	[GAB_TEMPERATURE] =3D "temperature",
>  };
> =20
>  struct gab {
> @@ -78,6 +80,7 @@ static const enum power_supply_property gab_props[] =3D=
 {
>  	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
>  	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
>  	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_TEMP,
>  };
> =20
>  /*
> @@ -123,6 +126,8 @@ static enum gab_chan_type gab_prop_to_chan(enum power=
_supply_property psp)
>  		return GAB_VOLTAGE;
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  		return GAB_CURRENT;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		return GAB_TEMPERATURE;
>  	default:
>  		WARN_ON(1);
>  		break;
> @@ -176,6 +181,7 @@ static int gab_get_property(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  	case POWER_SUPPLY_PROP_POWER_NOW:
> +	case POWER_SUPPLY_PROP_TEMP:
>  		ret =3D read_channel(adc_bat, psp, &result);
>  		if (ret < 0)
>  			goto err;
> @@ -210,13 +216,19 @@ static void gab_work(struct work_struct *work)
>  	struct delayed_work *delayed_work;
>  	bool is_plugged;
>  	int status;
> +	int ret, iio_charge;
> =20
>  	delayed_work =3D to_delayed_work(work);
>  	adc_bat =3D container_of(delayed_work, struct gab, bat_work);
>  	pdata =3D adc_bat->pdata;
>  	status =3D adc_bat->status;
> -
> -	is_plugged =3D power_supply_am_i_supplied(adc_bat->psy);
> +	ret =3D read_channel(adc_bat, POWER_SUPPLY_PROP_CURRENT_NOW, &iio_charg=
e);
> +	if (ret < 0) {
> +		pr_info("Cannot read current channel, ret:%d\n", ret);
> +		iio_charge =3D 0;
> +	} else
> +		pr_info("iio_charge:%d\n", iio_charge);
> +	is_plugged =3D power_supply_am_i_supplied(adc_bat->psy) || (iio_charge =
> 0);

This has nothing to do with adding temperature support and
I suspect, that you are missing proper supplied_by configuration,
so that power_supply_am_i_supplied does not work. Have a look at
the following file:

Documentation/devicetree/bindings/power/supply/power_supply.txt

-- Sebastian

>  	adc_bat->cable_plugged =3D is_plugged;
> =20
>  	if (!is_plugged)
> --=20
> 2.7.4
>=20

--j6324ebnnuudu5w5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlOe8ACgkQ2O7X88g7
+pphlQ/9GO5zNEZZJGWIYIpUhI0W/X7rIr5Rmy7B0bZeGESnaelJxzGA2UkW+lQz
a5Z0WkiZVw7tuCYqZ53XYJmbIdjrPwq8C3w552a3x4m3Xfmhr9ykUTUPyTif4WoJ
nT/LgOkiq26KLX48XnhR1WoNz1MOzTq7be/mu0n29T5QbJm18BZNTYg+Aty/jEUk
GjPETvTnt2ResEXfa/gibWTsinf+TnuS4eSdo+ECIC1CQa4/xLKLPve0977u9riD
/KcI8F0MdPbTtHuL6d1SiL8eqt9QruO9FfOkVS0KbAwww6dirkJSOt/SFR2bm+mo
e+fSOXobKhF6QLL+DYL5FxfoGGjRY7xQSvNtYhtuwxw/s6fJBWkFySx7CFKnxg30
2aqursvAMF2dxTF2kX9Ne8DG49SU+d4vVz50W8Y6C32JBRfcplK4Qn9zOz2p3HGo
QKfnN+7TrrUl5NGVZYkl4FO+4t5A/PsQY+CN2ZIxR1vqP4h9HgEwpxBun0R24Y+M
e9OkeywN2wGmxICCdl4vfN9AOd13yCUTPuJtbMH645BpmkXn+dqQ761l60HABCG2
HOhUhHEgjtJZd2S340rRZz6ljs8wnFr17FEq6K3/gIKjdY6006SAjAyobn1r80bW
I5szTtSgYr32Jsx6Z7qsB6y00SitwOZRCd4rMae+sdCE37Gxggk=
=UoCk
-----END PGP SIGNATURE-----

--j6324ebnnuudu5w5--
