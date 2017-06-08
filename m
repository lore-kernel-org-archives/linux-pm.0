From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 4/4] power: supply: axp20x_battery: add DT support for
 battery max constant charge current
Date: Thu, 8 Jun 2017 17:58:46 +0200
Message-ID: <20170608155846.nqp7asg2zxuoxpoq@earth>
References: <20170511134221.5569-1-quentin.schulz@free-electrons.com>
 <20170511134221.5569-5-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hfb6b6ttz2klo3hp"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170511134221.5569-5-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--hfb6b6ttz2klo3hp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 11, 2017 at 03:42:20PM +0200, Quentin Schulz wrote:
> This adds the ability to set the maximum constant charge current,
> supported by the battery, delivered by this battery power supply to the
> battery.
>=20
> The maximum constant charge current set in DT will also set the default
> constant charge current supplied by this supply.
>=20
> The actual user can modify the constant charge current within the range
> of 0 to maximum constant charge current via sysfs.
> The user can also modify the maximum constant charge current to widen
> the range of possible constant charge current. While this seems quite
> risky, a message is printed on the console to warn the user this might
> damage the battery. The reason for letting the user change the maximum
> constant charge current is for letting users change the battery and
> thus, let them adjust the maximum constant charge current according to
> what the battery can support.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks, queued.

-- Sebastian

> ---
>  drivers/power/supply/axp20x_battery.c | 78 +++++++++++++++++++++++++++++=
++----
>  1 file changed, 70 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> index 66f530541735..7494f0f0eadb 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -60,6 +60,8 @@ struct axp20x_batt_ps {
>  	struct iio_channel *batt_chrg_i;
>  	struct iio_channel *batt_dischrg_i;
>  	struct iio_channel *batt_v;
> +	/* Maximum constant charge current */
> +	unsigned int max_ccc;
>  	u8 axp_id;
>  };
> =20
> @@ -129,6 +131,14 @@ static void raw_to_constant_charge_current(struct ax=
p20x_batt_ps *axp, int *val)
>  		*val =3D *val * 150000 + 300000;
>  }
> =20
> +static void constant_charge_current_to_raw(struct axp20x_batt_ps *axp, i=
nt *val)
> +{
> +	if (axp->axp_id =3D=3D AXP209_ID)
> +		*val =3D (*val - 300000) / 100000;
> +	else
> +		*val =3D (*val - 300000) / 150000;
> +}
> +
>  static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
>  					      int *val)
>  {
> @@ -221,9 +231,7 @@ static int axp20x_battery_get_prop(struct power_suppl=
y *psy,
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> -		val->intval =3D AXP20X_CHRG_CTRL1_TGT_CURR;
> -		raw_to_constant_charge_current(axp20x_batt, &val->intval);
> -
> +		val->intval =3D axp20x_batt->max_ccc;
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
> @@ -340,10 +348,10 @@ static int axp20x_battery_set_max_voltage(struct ax=
p20x_batt_ps *axp20x_batt,
>  static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp=
_batt,
>  					      int charge_current)
>  {
> -	if (axp_batt->axp_id =3D=3D AXP209_ID)
> -		charge_current =3D (charge_current - 300000) / 100000;
> -	else
> -		charge_current =3D (charge_current - 300000) / 150000;
> +	if (charge_current > axp_batt->max_ccc)
> +		return -EINVAL;
> +
> +	constant_charge_current_to_raw(axp_batt, &charge_current);
> =20
>  	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
>  		return -EINVAL;
> @@ -352,6 +360,36 @@ static int axp20x_set_constant_charge_current(struct=
 axp20x_batt_ps *axp_batt,
>  				  AXP20X_CHRG_CTRL1_TGT_CURR, charge_current);
>  }
> =20
> +static int axp20x_set_max_constant_charge_current(struct axp20x_batt_ps =
*axp,
> +						  int charge_current)
> +{
> +	bool lower_max =3D false;
> +
> +	constant_charge_current_to_raw(axp, &charge_current);
> +
> +	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
> +		return -EINVAL;
> +
> +	raw_to_constant_charge_current(axp, &charge_current);
> +
> +	if (charge_current > axp->max_ccc)
> +		dev_warn(axp->dev,
> +			 "Setting max constant charge current higher than previously defined.=
 Note that increasing the constant charge current may damage your battery.\=
n");
> +	else
> +		lower_max =3D true;
> +
> +	axp->max_ccc =3D charge_current;
> +
> +	if (lower_max) {
> +		int current_cc;
> +
> +		axp20x_get_constant_charge_current(axp, &current_cc);
> +		if (current_cc > charge_current)
> +			axp20x_set_constant_charge_current(axp, charge_current);
> +	}
> +
> +	return 0;
> +}
>  static int axp20x_set_voltage_min_design(struct axp20x_batt_ps *axp_batt,
>  					 int min_voltage)
>  {
> @@ -380,6 +418,9 @@ static int axp20x_battery_set_prop(struct power_suppl=
y *psy,
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>  		return axp20x_set_constant_charge_current(axp20x_batt,
>  							  val->intval);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		return axp20x_set_max_constant_charge_current(axp20x_batt,
> +							      val->intval);
> =20
>  	default:
>  		return -EINVAL;
> @@ -405,7 +446,8 @@ static int axp20x_battery_prop_writeable(struct power=
_supply *psy,
>  {
>  	return psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
>  	       psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
> -	       psp =3D=3D POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT;
> +	       psp =3D=3D POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT ||
> +	       psp =3D=3D POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
>  }
> =20
>  static const struct power_supply_desc axp20x_batt_ps_desc =3D {
> @@ -487,13 +529,33 @@ static int axp20x_power_probe(struct platform_devic=
e *pdev)
> =20
>  	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
>  		int vmin =3D info.voltage_min_design_uv;
> +		int ccc =3D info.constant_charge_current_max_ua;
> =20
>  		if (vmin > 0 && axp20x_set_voltage_min_design(axp20x_batt,
>  							      vmin))
>  			dev_err(&pdev->dev,
>  				"couldn't set voltage_min_design\n");
> +
> +		/* Set max to unverified value to be able to set CCC */
> +		axp20x_batt->max_ccc =3D ccc;
> +
> +		if (ccc <=3D 0 || axp20x_set_constant_charge_current(axp20x_batt,
> +								   ccc)) {
> +			dev_err(&pdev->dev,
> +				"couldn't set constant charge current from DT: fallback to minimum v=
alue\n");
> +			ccc =3D 300000;
> +			axp20x_batt->max_ccc =3D ccc;
> +			axp20x_set_constant_charge_current(axp20x_batt, ccc);
> +		}
>  	}
> =20
> +	/*
> +	 * Update max CCC to a valid value if battery info is present or set it
> +	 * to current register value by default.
> +	 */
> +	axp20x_get_constant_charge_current(axp20x_batt,
> +					   &axp20x_batt->max_ccc);
> +
>  	return 0;
>  }
> =20
> --=20
> 2.11.0
>=20

--hfb6b6ttz2klo3hp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5dDYACgkQ2O7X88g7
+pqDGw/+PmyhxXtUQi+URdAbqQFVH2x1fFmAlbbSiOa9GwpC5Tvljj8IDbUAmc/d
/mYUw+pZrihgBwbwNN4H0JYgEaRNbU6BBhINcbhSC2Wm0U0ggU7VbAOMvMvYJTHF
zDhEPSLXWCkXgeHu85fM9VLDnDY6hF3zUiXsMzezNKmSWpDxT2qRRpa3/KbxJQGa
uEvtwKFy6hrBSkPuZqY0FwoN8GMRefOPW/OBMDW6aoJw2Tc+xIQRgspaxTqrWaqA
XxL8tOPe1YHcbKihm0ljfy5OOBEpD1KB6viEdZpHHVRVSTvr3Rka4sswVlQi6cZZ
GNakI4gRGs6W46F5K2LWVOj3fcflPZ37RZbZY7hHfFnUcsiaKVtrm4DrTXT/+/JO
SANCAaEmyvxu/6KIne+TD+XM5nuVSmu/i7o9I3GPKAV0YkT6IghIzE5NdNDze03S
A+9GJ4p0YB3tID0e/D9YDyVDzKfS6oOUUs8dVycORDczA22PuCTFgy2Pj7c4IJeU
e762bqwbPUCww06Bly+N2CzcmG+yn4Tcl/Z8SfMzyW2T228Ch9zXYbtMuZJcjKnk
iK66ovwc1ZQfL+PLUMZR6frzlBiwtvOBTeiRq0n1GjaIHbW5nLD6zZvVYkoEYBmJ
ymsGUneSh19TD3QhHr2QbpW1XC3cDID20Db5f+vKB0L0BV+rToM=
=p8MN
-----END PGP SIGNATURE-----

--hfb6b6ttz2klo3hp--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
