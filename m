From: Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH v2 6/6] power: supply: add AC power supply driver for
 AXP813
Date: Mon, 8 Oct 2018 09:44:09 +0200
Message-ID: <20181008074409.5g73zrfm6nbn6vpp@qschulz>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
 <20181006211836.28253-7-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m6savxunrnv5uhcs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181006211836.28253-7-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Oskari Lemmela <oskari@lemmela.net>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--m6savxunrnv5uhcs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On Sun, Oct 07, 2018 at 12:18:36AM +0300, Oskari Lemmela wrote:
> AXP813 and AXP803 PMICs can control input current and
> minimum voltage.
>=20
> Both of these values are configurable.
>=20
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  drivers/power/supply/axp20x_ac_power.c | 92 ++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>=20
> diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/suppl=
y/axp20x_ac_power.c
> index 0771f951b11f..92a92354f6f0 100644
> --- a/drivers/power/supply/axp20x_ac_power.c
> +++ b/drivers/power/supply/axp20x_ac_power.c
> @@ -27,6 +27,16 @@
>  #define AXP20X_PWR_STATUS_ACIN_PRESENT	BIT(7)
>  #define AXP20X_PWR_STATUS_ACIN_AVAIL	BIT(6)
> =20
> +#define AXP813_VHOLD_MASK		GENMASK(5, 3)
> +#define AXP813_VHOLD_UV_TO_BIT(x)	((((x) / 100000) - 40) << 3)
> +#define AXP813_VHOLD_REG_TO_UV(x)	\
> +	(((((x) & AXP813_VHOLD_MASK) >> 3) + 40) * 100000)
> +
> +#define AXP813_CURR_LIMIT_MASK		GENMASK(2, 0)
> +#define AXP813_CURR_LIMIT_UA_TO_BIT(x)	(((x) / 500000) - 3)
> +#define AXP813_CURR_LIMIT_REG_TO_UA(x)	\
> +	((((x) & AXP813_CURR_LIMIT_MASK) + 3) * 500000)
> +
>  #define DRVNAME "axp20x-ac-power-supply"
> =20
>  struct axp20x_ac_power {
> @@ -102,6 +112,55 @@ static int axp20x_ac_power_get_property(struct power=
_supply *psy,
> =20
>  		return 0;
> =20
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		ret =3D regmap_read(power->regmap, AXP813_ACIN_PATH_CTRL, &reg);
> +		if (ret)
> +			return ret;
> +
> +		val->intval =3D AXP813_VHOLD_REG_TO_UV(reg);
> +
> +		return 0;
> +
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D regmap_read(power->regmap, AXP813_ACIN_PATH_CTRL, &reg);
> +		if (ret)
> +			return ret;
> +
> +		val->intval =3D AXP813_CURR_LIMIT_REG_TO_UA(reg);
> +
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int axp20x_ac_power_set_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					const union power_supply_propval *val)
> +{

Argh, missed this one in the first version. Since you're introducing it
with the AXP813 and it isn't used with the AXP20X, I'd name it
axp813_ac_power_set_property. I'll let Maxime or Chen-Yu confirm though.

With the modification in the header from the previous patch in this
patch,

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Thanks!
Quentin

--m6savxunrnv5uhcs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu7CskACgkQhLiadT7g
8aMUHg//RrUQjS7a+hWMfDiWAHIllZpaZuXftDgKPQr21NFxcVm152TCsfgf8Wqr
nykx2jmJ5uooczCqTJLnFOsT2sUwHOc4mSNbSXYg/RXzm/GYPudOnxFW8OTaz+tf
dZ22pXikUJg7DsedEQstG1gwD/13kfJCXkJUyMSm3zqLrngCTibViCL/elhqD/FA
PIuayVMWmscuDcTS5ISoygk9L7XYKQWCRuN5Nb/slxgfeUiaWFnx8s6kXwIDPst+
xffUc3U5s3eWyK0U5U/qiJIhJscquDHYfnGa8XpsZREwqVwNoC0RZg4kpUMRVHXV
Ha6pc6+a/4xZvbC33BuoI/DES0ZiYcv+CidqZdGLAGaeUVIualxxl0Tu3F9tZDJC
OGjvCW1BeLG3s7+SHcnaRm9DRQqIGeHbWmikyTJTjo+F82Uy+WFvz/RGjycTpUkl
OGFP6+g9JWu5/3Fr/urJmA26ZxHflEpw6t1stXcSGnnrG5ov58odYIxWkuH9SnQ8
uWc6u7VIjuEiEi6O2JTJImQLOhb7MUj3M3du+RhsSAg7Q2wZa5ngHx6VvGH9EX+j
Hi2Iy5O6lu2LjXPpaZzG8W0gxACOyYqHKgVIlCvCGilyO/QwCETbS1oFmUC9t4fP
2I0gEnM9rEB7Dhpiw5TBgQ/Su9eZijD4rlP8w4Ge8D3u4xmGMFA=
=pnaj
-----END PGP SIGNATURE-----

--m6savxunrnv5uhcs--
