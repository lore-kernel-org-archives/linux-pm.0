From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: ltc2941-battery-gauge: Add charge empty
 and full properties
Date: Fri, 9 Feb 2018 13:27:09 +0100
Message-ID: <20180209122709.les6asua5hb26yky@earth.universe>
References: <20180117194607.GA7563@lenoch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h5m7ojhyeauhvbwp"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750918AbeBIM1N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Feb 2018 07:27:13 -0500
Content-Disposition: inline
In-Reply-To: <20180117194607.GA7563@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-pm@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>


--h5m7ojhyeauhvbwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 17, 2018 at 08:48:54PM +0100, Ladislav Michl wrote:
> Add properties for charge empty and charge full thresholds.
>=20
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---

Thanks, queued. My public -next branch is waiting for 4.16-rc1,
though.

-- Sebastian

>  drivers/power/supply/ltc2941-battery-gauge.c | 59 ++++++++++++++++++++++=
+-----
>  1 file changed, 50 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power=
/supply/ltc2941-battery-gauge.c
> index 08e4fd9ee607..523373ea9cbd 100644
> --- a/drivers/power/supply/ltc2941-battery-gauge.c
> +++ b/drivers/power/supply/ltc2941-battery-gauge.c
> @@ -34,6 +34,10 @@ enum ltc294x_reg {
>  	LTC294X_REG_CONTROL		=3D 0x01,
>  	LTC294X_REG_ACC_CHARGE_MSB	=3D 0x02,
>  	LTC294X_REG_ACC_CHARGE_LSB	=3D 0x03,
> +	LTC294X_REG_CHARGE_THR_HIGH_MSB	=3D 0x04,
> +	LTC294X_REG_CHARGE_THR_HIGH_LSB	=3D 0x05,
> +	LTC294X_REG_CHARGE_THR_LOW_MSB	=3D 0x06,
> +	LTC294X_REG_CHARGE_THR_LOW_LSB	=3D 0x07,
>  	LTC294X_REG_VOLTAGE_MSB		=3D 0x08,
>  	LTC294X_REG_VOLTAGE_LSB		=3D 0x09,
>  	LTC2942_REG_TEMPERATURE_MSB	=3D 0x0C,
> @@ -178,21 +182,22 @@ static int ltc294x_reset(const struct ltc294x_info =
*info, int prescaler_exp)
>  	return ret;
>  }
> =20
> -static int ltc294x_read_charge_register(const struct ltc294x_info *info)
> -{
> +static int ltc294x_read_charge_register(const struct ltc294x_info *info,
> +					enum ltc294x_reg reg)
> + {
>  	int ret;
>  	u8 datar[2];
> =20
> -	ret =3D ltc294x_read_regs(info->client,
> -		LTC294X_REG_ACC_CHARGE_MSB, &datar[0], 2);
> +	ret =3D ltc294x_read_regs(info->client, reg, &datar[0], 2);
>  	if (ret < 0)
>  		return ret;
>  	return (datar[0] << 8) + datar[1];
>  }
> =20
> -static int ltc294x_get_charge_now(const struct ltc294x_info *info, int *=
val)
> +static int ltc294x_get_charge(const struct ltc294x_info *info,
> +				enum ltc294x_reg reg, int *val)
>  {
> -	int value =3D ltc294x_read_charge_register(info);
> +	int value =3D ltc294x_read_charge_register(info, reg);
> =20
>  	if (value < 0)
>  		return value;
> @@ -244,10 +249,29 @@ static int ltc294x_set_charge_now(const struct ltc2=
94x_info *info, int val)
>  	return ret < 0 ? ret : 0;
>  }
> =20
> +static int ltc294x_set_charge_thr(const struct ltc294x_info *info,
> +					enum ltc294x_reg reg, int val)
> +{
> +	u8 dataw[2];
> +	s32 value;
> +
> +	value =3D convert_uAh_to_bin(info, val);
> +	/* Direction depends on how sense+/- were connected */
> +	if (info->Qlsb < 0)
> +		value +=3D 0xFFFF;
> +	if ((value < 0) || (value > 0xFFFF)) /* input validation */
> +		return -EINVAL;
> +
> +	/* Set new charge value */
> +	dataw[0] =3D I16_MSB(value);
> +	dataw[1] =3D I16_LSB(value);
> +	return ltc294x_write_regs(info->client, reg, &dataw[0], 2);
> +}
> +
>  static int ltc294x_get_charge_counter(
>  	const struct ltc294x_info *info, int *val)
>  {
> -	int value =3D ltc294x_read_charge_register(info);
> +	int value =3D ltc294x_read_charge_register(info, LTC294X_REG_ACC_CHARGE=
_MSB);
> =20
>  	if (value < 0)
>  		return value;
> @@ -335,8 +359,15 @@ static int ltc294x_get_property(struct power_supply =
*psy,
>  	struct ltc294x_info *info =3D power_supply_get_drvdata(psy);
> =20
>  	switch (prop) {
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		return ltc294x_get_charge(info, LTC294X_REG_CHARGE_THR_HIGH_MSB,
> +						&val->intval);
> +	case POWER_SUPPLY_PROP_CHARGE_EMPTY:
> +		return ltc294x_get_charge(info, LTC294X_REG_CHARGE_THR_LOW_MSB,
> +						&val->intval);
>  	case POWER_SUPPLY_PROP_CHARGE_NOW:
> -		return ltc294x_get_charge_now(info, &val->intval);
> +		return ltc294x_get_charge(info, LTC294X_REG_ACC_CHARGE_MSB,
> +						&val->intval);
>  	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
>  		return ltc294x_get_charge_counter(info, &val->intval);
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> @@ -357,6 +388,12 @@ static int ltc294x_set_property(struct power_supply =
*psy,
>  	struct ltc294x_info *info =3D power_supply_get_drvdata(psy);
> =20
>  	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		return ltc294x_set_charge_thr(info,
> +			LTC294X_REG_CHARGE_THR_HIGH_MSB, val->intval);
> +	case POWER_SUPPLY_PROP_CHARGE_EMPTY:
> +		return ltc294x_set_charge_thr(info,
> +			LTC294X_REG_CHARGE_THR_LOW_MSB, val->intval);
>  	case POWER_SUPPLY_PROP_CHARGE_NOW:
>  		return ltc294x_set_charge_now(info, val->intval);
>  	default:
> @@ -368,6 +405,8 @@ static int ltc294x_property_is_writeable(
>  	struct power_supply *psy, enum power_supply_property psp)
>  {
>  	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +	case POWER_SUPPLY_PROP_CHARGE_EMPTY:
>  	case POWER_SUPPLY_PROP_CHARGE_NOW:
>  		return 1;
>  	default:
> @@ -377,7 +416,7 @@ static int ltc294x_property_is_writeable(
> =20
>  static void ltc294x_update(struct ltc294x_info *info)
>  {
> -	int charge =3D ltc294x_read_charge_register(info);
> +	int charge =3D ltc294x_read_charge_register(info, LTC294X_REG_ACC_CHARG=
E_MSB);
> =20
>  	if (charge !=3D info->charge) {
>  		info->charge =3D charge;
> @@ -396,6 +435,8 @@ static void ltc294x_work(struct work_struct *work)
> =20
>  static enum power_supply_property ltc294x_properties[] =3D {
>  	POWER_SUPPLY_PROP_CHARGE_COUNTER,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_EMPTY,
>  	POWER_SUPPLY_PROP_CHARGE_NOW,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  	POWER_SUPPLY_PROP_TEMP,
> --=20
> 2.15.1
>=20

--h5m7ojhyeauhvbwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp9k5oACgkQ2O7X88g7
+poRxRAAhkWV+TB9v2VTF0FsMf23a4UNaf7WznoTzXuz2pFRgCVn2GFqP0mfYOhL
KG33x+0VCBRiL9HmAoGOpHHn2i/DvKxrhZbjP2ez5oVZt4gncqWpIVdeGECT26oo
2MM1k75XDi5tNDH385C3hHdnVTV2i/EIPM5IQvNcH55yTQ7WeRCUZm1LKSf5o0DX
6kZoT0FfVHCbU1Qc3KS6/VAASiUL42K8Y9wO+li5pTXx4IQ8RyC4gmTw9SUoDm82
wzvupyc1X2JVZ2wRx+o3NWrMVqDcGEnACWWkHPgvvM19QMBNvniPgvdBTGyPA0rD
lSkrzn2iA20GUQ0JUTaZefffi3KrWSVFDrvXeDVCbxMoiZEMLqo2QtzSpzQBpgdG
kjARYfmg36LyFDEPxJPNVr9HhWR/Mv9TAri2ecBS/S7j24vDJeCPWQk8I/a0p6re
XUX8v7VEKdVs/g7IshJYlMiXJgxvh7qF+nLslF7bDFldcMNwPZV2ZnSROWMJc54r
t457uyd0GdT7UPL+l+aVPcJvFxkD++QaojoZt+UZtqQ1a1E4UeT/KPJWvDzhqTyJ
SScPp1IRqYX1M9eWkFCkKOCwzTNcuaiIKBeH0ISGo79OBnq26GG957f7vvlDZmNK
NG4cfi366E6ZKKdzt06rU4YijKgm1BLWO9R4xsnwAmByxjKer3I=
=Y/l4
-----END PGP SIGNATURE-----

--h5m7ojhyeauhvbwp--
