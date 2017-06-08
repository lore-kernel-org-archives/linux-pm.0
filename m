From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 1/4] power: supply: axp20x_battery: add support for DT
 battery
Date: Thu, 8 Jun 2017 17:58:21 +0200
Message-ID: <20170608155821.n5uuobjpv2gmbl5t@earth>
References: <20170511134221.5569-1-quentin.schulz@free-electrons.com>
 <20170511134221.5569-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qugtk37hf4ozahms"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170511134221.5569-2-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--qugtk37hf4ozahms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 11, 2017 at 03:42:17PM +0200, Quentin Schulz wrote:
> This adds support in X-Powers AXP20X and AXP22X battery driver for a
> fixed battery in DT.
>=20
> It will take the minimum supported voltage by the battery as defined in
> the battery DT node and set the V_OFF register to this value, telling
> the system to shut down if the supplied power is below this value.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks, queued.

-- Sebastian

>  drivers/power/supply/axp20x_battery.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> index 5d29b2eab8fc..66f530541735 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -433,6 +433,7 @@ static int axp20x_power_probe(struct platform_device =
*pdev)
>  {
>  	struct axp20x_batt_ps *axp20x_batt;
>  	struct power_supply_config psy_cfg =3D {};
> +	struct power_supply_battery_info info;
> =20
>  	if (!of_device_is_available(pdev->dev.of_node))
>  		return -ENODEV;
> @@ -484,6 +485,15 @@ static int axp20x_power_probe(struct platform_device=
 *pdev)
>  		return PTR_ERR(axp20x_batt->batt);
>  	}
> =20
> +	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
> +		int vmin =3D info.voltage_min_design_uv;
> +
> +		if (vmin > 0 && axp20x_set_voltage_min_design(axp20x_batt,
> +							      vmin))
> +			dev_err(&pdev->dev,
> +				"couldn't set voltage_min_design\n");
> +	}
> +
>  	return 0;
>  }
> =20
> --=20
> 2.11.0
>=20

--qugtk37hf4ozahms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5dBoACgkQ2O7X88g7
+poADQ/+KQ6wBbg0J/zvsBXsQPQcy7bMbb54eWB273q9u/v7UG1tI73ZK2hpri6O
dH57r+LDoLY0AqK5rfUA6GUVvs79ULV+u5aCINhpgzZzRM3NyIq+AQkCS/11ty7D
e9BcTjah9pYwLAr2VMzg4D4i+F6w20Zifywqv9q/rmh4w4LXLQLT+cOFiE8dCgEu
oGnf18R1WAMI576LATtiYNTNujPbU2rBkr2TmMWSEmdETA2AzNTN1Zeb1hh6ty8n
bkWYOJo0+OZkUWn0sjSLqBZdntCzDOexUBGKo/sdbSMfLT5xXB40w5RPIdHnBW2o
yMTx03PLURArfZ6jJBPUV/wqjYJVmq76LrbNM9Kp/vJkaBrR3WTohPzHTBHGfbM3
pthQ6fTslfPSCl/PrSasr1Z9RipGacILJjFaZjJB4mvwr4tugml6eydXT7jGfP0P
N6v+2PuxoBq8ptxYy9+65oDs3b48A/ClQiqI8xvWWoUte/1Hy4FXRIibaNYKRe5v
Fe6Vni7BGiR2ms4wrCdBBUbZWA2hmcllFhHYd90qpX0pSNUeCQ2L1hvxwODo5z6w
M+ZvZVTMXw92BxU/Zyu0aQbagwGwjjo/MpMkA9Igg5OO7lyCzTVGsn0AJStqy0mm
o0t/loYV3NzRymGqjb9YElLMHaWaIRCkE5v0OMUiRwvZ+EpCBkg=
=39H9
-----END PGP SIGNATURE-----

--qugtk37hf4ozahms--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
