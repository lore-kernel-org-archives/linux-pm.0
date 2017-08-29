From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 10/14] power: supply: bq24190_charger: Add
 input_current_limit property
Date: Tue, 29 Aug 2017 13:29:10 +0200
Message-ID: <20170829112910.u2wazizuhos7vr27@earth>
References: <20170815200502.17339-1-hdegoede@redhat.com>
 <20170815200502.17339-11-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="me2qw5rrp37axfko"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170815200502.17339-11-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org


--me2qw5rrp37axfko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 15, 2017 at 10:04:58PM +0200, Hans de Goede wrote:
> Export the input current limit of the charger as a
> POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT property on the charger
> power_supply class device.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 35 ++++++++++++++++++++++++++++=
++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 073cd9d..f13f892 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -987,6 +987,33 @@ static int bq24190_charger_set_voltage(struct bq2419=
0_dev_info *bdi,
>  			ARRAY_SIZE(bq24190_cvc_vreg_values), val->intval);
>  }
> =20
> +static int bq24190_charger_get_iinlimit(struct bq24190_dev_info *bdi,
> +		union power_supply_propval *val)
> +{
> +	int iinlimit, ret;
> +
> +	ret =3D bq24190_get_field_val(bdi, BQ24190_REG_ISC,
> +			BQ24190_REG_ISC_IINLIM_MASK,
> +			BQ24190_REG_ISC_IINLIM_SHIFT,
> +			bq24190_isc_iinlim_values,
> +			ARRAY_SIZE(bq24190_isc_iinlim_values), &iinlimit);
> +	if (ret < 0)
> +		return ret;
> +
> +	val->intval =3D iinlimit;
> +	return 0;
> +}
> +
> +static int bq24190_charger_set_iinlimit(struct bq24190_dev_info *bdi,
> +		const union power_supply_propval *val)
> +{
> +	return bq24190_set_field_val(bdi, BQ24190_REG_ISC,
> +			BQ24190_REG_ISC_IINLIM_MASK,
> +			BQ24190_REG_ISC_IINLIM_SHIFT,
> +			bq24190_isc_iinlim_values,
> +			ARRAY_SIZE(bq24190_isc_iinlim_values), val->intval);
> +}
> +
>  static int bq24190_charger_get_property(struct power_supply *psy,
>  		enum power_supply_property psp, union power_supply_propval *val)
>  {
> @@ -1027,6 +1054,9 @@ static int bq24190_charger_get_property(struct powe=
r_supply *psy,
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
>  		ret =3D bq24190_charger_get_voltage_max(bdi, val);
>  		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D bq24190_charger_get_iinlimit(bdi, val);
> +		break;
>  	case POWER_SUPPLY_PROP_SCOPE:
>  		val->intval =3D POWER_SUPPLY_SCOPE_SYSTEM;
>  		ret =3D 0;
> @@ -1078,6 +1108,9 @@ static int bq24190_charger_set_property(struct powe=
r_supply *psy,
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  		ret =3D bq24190_charger_set_voltage(bdi, val);
>  		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D bq24190_charger_set_iinlimit(bdi, val);
> +		break;
>  	default:
>  		ret =3D -EINVAL;
>  	}
> @@ -1099,6 +1132,7 @@ static int bq24190_charger_property_is_writeable(st=
ruct power_supply *psy,
>  	case POWER_SUPPLY_PROP_CHARGE_TYPE:
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>  		ret =3D 1;
>  		break;
>  	default:
> @@ -1118,6 +1152,7 @@ static enum power_supply_property bq24190_charger_p=
roperties[] =3D {
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  	POWER_SUPPLY_PROP_SCOPE,
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
> --=20
> 2.9.4
>=20

--me2qw5rrp37axfko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlUAYACgkQ2O7X88g7
+pofgQ//Xw0Qr0p6GfkgEW89/tkvNHx5Ne7mGf97jxJrF9PPr2G+Ff+69VwR30eR
EILTnx6IDvkI+s/41qnB3FeiDVjXKOVU0Ru1lXqlQLM5dhLvsp8BOjUdFiQ2QZ0U
B4VL7nYVTPJ03avr1DEhSBgVkOYGc+Z/faghEnZ0lF0q/yY5DPlHQyV9i9m/5lF+
Z22bkyB0qwcGR1QCTNo9xoKEGlgAtwhvnn6u72U+797Vj8Dw2+YR+Yt0h1r4SD8X
15OwyBf4DuGbJgSIv/GQw+Ceg5eSELPEUjaShespGy0AbfSFo2yMbvRyJxPDR6T3
KQtdg/+gN6ZDXoyi5cA72KtCKzKvFvwF4nuRgezQ6MRu/IKelYCnA7UtO0/wAvAj
ROiQFBevTWQEWVDhBTrtP4+gDux9OHEO9VeVJ7TRSgjwYN9fSTHPzyrHvx9ayWnv
4mYDmoNa6peVhlawd5ePGHkwyF7SkCPEmwnpIwaXFMbzEYqjvvuHvKUYctZYm2xz
U7W+MC7ukLEdB2QyusOLCrwY08iaDPJuex7GdF2rkJAWZyH42TfJCHW6fMeVGPZn
f8662BKCCQ5RRvFMXLkmFV/VpxvusiFk7aGSm9+eDz4yWIliBayPN/cN5/AQ5T0q
OcNeGvxAoiR/wb4DFeSSkDaOujWH0uPiRzTkA5zbvR0fTw7EgDU=
=O+TF
-----END PGP SIGNATURE-----

--me2qw5rrp37axfko--
