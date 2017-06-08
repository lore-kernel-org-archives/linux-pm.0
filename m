From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v3 4/4] power: tps65217_charger: add support for NTC
 type, voltage and current charge
Date: Thu, 8 Jun 2017 18:11:37 +0200
Message-ID: <20170608161137.7kxkriaryr5m323h@earth>
References: <20170526110413.24836-1-enric.balletbo@collabora.com>
 <20170526110413.24836-4-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fmyal4pnucnwexfe"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170526110413.24836-4-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--fmyal4pnucnwexfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Fri, May 26, 2017 at 01:04:13PM +0200, Enric Balletbo i Serra wrote:
> Allow the possibility to configure the charge and the current voltage of
> the charger and also the NTC type for battery temperature measurement.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
> Changes since v2:
>  - Requested by Sebastian Reichel
>    - Use the simple-battery framework
>    - Use device_property_read_u32 instead of of_property_read_u32
> Changes since v1:
>  - None
>=20
>  drivers/power/supply/tps65217_charger.c | 194 ++++++++++++++++++++++++++=
++++--
>  include/linux/mfd/tps65217.h            |   2 +
>  2 files changed, 188 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supp=
ly/tps65217_charger.c
> index 1f52340..5939e77 100644
> --- a/drivers/power/supply/tps65217_charger.c
> +++ b/drivers/power/supply/tps65217_charger.c
>
> [...]
>
> +#ifdef CONFIG_OF

You can drop the #ifdef CONFIG_OF. device_properties can also be
added via ACPI or boardcode and power_supply_get_battery_info is
always available (but will return -EINVAL values for !OF at the
moment).

> +static struct tps65217_charger_platform_data *tps65217_charger_pdata_ini=
t(
> +		struct tps65217_charger *charger)
> +{
> +	struct tps65217_charger_platform_data *pdata;
> +	struct power_supply_battery_info info =3D {};
> +	int ret;
> +
> +	pdata =3D devm_kzalloc(charger->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * If battery info is not supplied just ignore and program default
> +	 * values.
> +	 */
> +	power_supply_get_battery_info(charger->psy, &info);
> +
> +	if (info.charge_voltage_uv > 0)
> +		pdata->charge_voltage_uv =3D info.charge_voltage_uv;
> +	else
> +		pdata->charge_voltage_uv =3D 4100000;
> +
> +	if (info.charge_current_ua > 0)
> +		pdata->charge_current_ua =3D info.charge_current_ua;
> +	else
> +		pdata->charge_current_ua =3D 500000;
> +
> +	ret =3D device_property_read_u32(charger->dev, "ti,ntc-type",
> +				       &pdata->ntc_type);
> +	if (ret)
> +		pdata->ntc_type =3D 1;	/* 10k  (curve 2, B =3D 3480) */
> +
> +	return pdata;
> +}
> +#else /* CONFIG_OF */
> +static struct tps65217_charger_platform_data *tps65217_charger_pdata_ini=
t(
> +		struct tps65217_charger *charger)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_OF */
> +
> [...]
>

Otherwise looks fine to me.

-- Sebastian

--fmyal4pnucnwexfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5dzYACgkQ2O7X88g7
+pq8bRAAnpmAEz34NFSfsTi3+hXmc72b6ytfDkX9REKTpqaMGNMxTctnkVla48B7
VgXdvMzebw0l8i0c++IXRxW5tD2VegPmNlc4d+tYYNJ4yflFwWCqyrnFrryBbo6k
j644TaOpPsz3nZgvvrWhlPNBR+dLAK1zZ934jvgIgOlwwwZYG79PEyWPxrLhz0OV
WsJE5whUTiGGGJnXJVGD+GVuYUJsiSjSYXloBlQcOd3+gw9m1wzQNiTRtnUnRFm9
ZqbX4QAgi2yCy/BImQeDADEqA8/51nuTuXrp1aNYl5t+bALw/4PqX3nE3DY7b4Ty
5rji8J/9RoV0WCxcC8tlW34ae6A1A5KNcwFesqhfXhZr6vpHQfFjqZ37KIkgxyox
bcnrjInjvy9BPQvaDcc1UG6xNwIAarVXQkc5bz2/HhpWKqgPOxSMoezK8pyglRb+
jMA+aqv4ZudugQ9XU9u9AWOuQ5BirON+SzpU0RD+fCNf04g137rJWEpmR/XFmLGR
j9CQ8s2tlCnQsa5UHim4C5FYhoV6wkmURz76ISgVv9ahwCMkBaHyJccMYf9JbfIa
IKw6aJ1X+6qB9k1qDLFtn9nFjOevd72oD3W4W/tCSYv+BSSCvFoWLzyRrfxhtG2v
HW9JNlGTOQN/45wo52R+Bp5Csk0FyOdBlRz7ShKwOsyxpKPq4os=
=rC/s
-----END PGP SIGNATURE-----

--fmyal4pnucnwexfe--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
