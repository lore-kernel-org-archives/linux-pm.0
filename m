From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v10 4/8] power: power_supply: Add
 power_supply_battery_info and API
Date: Wed, 15 Mar 2017 23:07:02 +0100
Message-ID: <20170315220702.mesuaquxg6apzjpr@earth>
References: <20170315192653.26799-1-liam@networkimprov.net>
 <20170315192653.26799-5-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ndtuwtux2qwszabo"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752035AbdCOWHI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Mar 2017 18:07:08 -0400
Content-Disposition: inline
In-Reply-To: <20170315192653.26799-5-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>


--ndtuwtux2qwszabo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 15, 2017 at 12:26:49PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> power_supply_get_battery_info() reads battery data from devicetree.
> struct power_supply_battery_info provides battery data to drivers.
> Drivers may surface battery data in sysfs via corresponding
> POWER_SUPPLY_PROP_* fields.
>=20
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

> ---
>  drivers/power/supply/power_supply_core.c | 40 ++++++++++++++++++++++++++=
++++++
>  include/linux/power_supply.h             | 18 ++++++++++++++
>  2 files changed, 58 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index a74d8ca..c121931 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -17,6 +17,7 @@
>  #include <linux/device.h>
>  #include <linux/notifier.h>
>  #include <linux/err.h>
> +#include <linux/of.h>
>  #include <linux/power_supply.h>
>  #include <linux/thermal.h>
>  #include "power_supply.h"
> @@ -487,6 +488,45 @@ struct power_supply *devm_power_supply_get_by_phandl=
e(struct device *dev,
>  EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
>  #endif /* CONFIG_OF */
> =20
> +int power_supply_get_battery_info(struct power_supply *psy,
> +				  struct power_supply_battery_info *info)
> +{
> +	struct device_node *battery_np;
> +	const char *value;
> +	int err;
> +
> +	info->energy_full_design_uwh =3D -EINVAL;
> +	info->charge_full_design_uah =3D -EINVAL;
> +	info->voltage_min_design_uv  =3D -EINVAL;
> +
> +	if (!psy->of_node) {
> +		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
> +			 __func__);
> +		return -ENXIO;
> +	}
> +
> +	battery_np =3D of_parse_phandle(psy->of_node, "monitored-battery", 0);
> +	if (!battery_np)
> +		return -ENODEV;
> +
> +	err =3D of_property_read_string(battery_np, "compatible", &value);
> +	if (err)
> +		return err;
> +
> +	if (strcmp("fixed-battery", value))
> +		return -ENODEV;
> +
> +	of_property_read_u32(battery_np, "energy-full-design-microwatt-hours",
> +			     &info->energy_full_design_uwh);
> +	of_property_read_u32(battery_np, "charge-full-design-microamp-hours",
> +			     &info->charge_full_design_uah);
> +	of_property_read_u32(battery_np, "voltage-min-design-microvolt",
> +			     &info->voltage_min_design_uv);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
> +
>  int power_supply_get_property(struct power_supply *psy,
>  			    enum power_supply_property psp,
>  			    union power_supply_propval *val)
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 3965503..e84f1d3 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -288,6 +288,21 @@ struct power_supply_info {
>  	int use_for_apm;
>  };
> =20
> +/*
> + * This is the recommended struct to manage static battery parameters,
> + * populated by power_supply_get_battery_info(). Most platform drivers s=
hould
> + * use these for consistency.
> + * Its field names must correspond to elements in enum power_supply_prop=
erty.
> + * The default field value is -EINVAL.
> + * Power supply class itself doesn't use this.
> + */
> +
> +struct power_supply_battery_info {
> +	int energy_full_design_uwh;	/* microWatt-hours */
> +	int charge_full_design_uah;	/* microAmp-hours */
> +	int voltage_min_design_uv;	/* microVolts */
> +};
> +
>  extern struct atomic_notifier_head power_supply_notifier;
>  extern int power_supply_reg_notifier(struct notifier_block *nb);
>  extern void power_supply_unreg_notifier(struct notifier_block *nb);
> @@ -306,6 +321,9 @@ static inline struct power_supply *
>  devm_power_supply_get_by_phandle(struct device *dev, const char *propert=
y)
>  { return NULL; }
>  #endif /* CONFIG_OF */
> +
> +extern int power_supply_get_battery_info(struct power_supply *psy,
> +					 struct power_supply_battery_info *info);
>  extern void power_supply_changed(struct power_supply *psy);
>  extern int power_supply_am_i_supplied(struct power_supply *psy);
>  extern int power_supply_set_battery_charged(struct power_supply *psy);
> --=20
> 2.9.3
>=20

--ndtuwtux2qwszabo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJuwYACgkQ2O7X88g7
+pr9/g//QhTn1RP8CfyGw4pD/dTijRSkzNzQ/wug2/VmRusTKo+xJrIVilkYT8MF
cqjqIPjR9PTqn7xYJ11EQF8zPgx3sKLOfbD/ScbUkWb3q/nHRL5F3Mu75zRmWFnp
f3KuV8cxssLWstjOMgcJVthHG4STbAyt0TnOD6yqPV2ITSEOzhFWWKsP5K0EoXGm
WVQJyXOKVJYXgTsFnyiB9SJ34NpFeB8+qBCK6tE3rAxHqoRL7yzpgvLnzYqAQDgg
iHzjogY26hJ+R31hbsUgJSlgyLmZOedIX6KzmjBUTt7DpPQ8xjMJI5uJP5hZY/0W
1vgJfP8aYXwf7ysNNMQ0h6T/XBvSG7wHeKDNlNXp16Vo2snMvQr2fXrWQ0TzQ7gL
9E68cc3BITCXM8kCYgQ0cYm3lP3tz3ygho9v3h8iHgDV7mJ4nfWnbgMNTWIEy+rd
zpb7csNtLUS1D2Wt/zBBRPpMqR5Uh/ylLYku8ciSe2gMbTNVNyldrbJlKFV212of
gnQkzgjjanTV2pvnVzB6VO4WHBGdaWR7d/6aEkE1GGYk4Vu4zH/b0meP9Vzjenx0
lMp6VNdkjKF2n/AqWosWZFDJB8R04HTXMe1cS1KmU+E+Onbaj9ion9Y/AtwrVfbo
G0w8kiDino7pRiJTlxGS8Bb/V4dxf0TfjSdpRL9R0TIDN5/TU8g=
=B0uo
-----END PGP SIGNATURE-----

--ndtuwtux2qwszabo--
