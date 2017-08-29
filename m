From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 08/14] power: supply: Add
 power_supply_set_input_current_limit_from_supplier helper
Date: Tue, 29 Aug 2017 12:54:47 +0200
Message-ID: <20170829105447.icwb5fjwnivnbtts@earth>
References: <20170815200502.17339-1-hdegoede@redhat.com>
 <20170815200502.17339-9-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kukzqbsxlhlacb6h"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170815200502.17339-9-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org


--kukzqbsxlhlacb6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 15, 2017 at 10:04:56PM +0200, Hans de Goede wrote:
> On some devices the USB Type-C port power (USB PD 2.0) negotiation is
> done by a separate port-controller IC, while the current limit is
> controlled through another (charger) IC.
>=20
> It has been decided to model this by modelling the external Type-C
> power brick (adapter/charger) as a power-supply class device which
> supplies the charger-IC, with its voltage-now and current-max representing
> the negotiated voltage and max current draw.
>=20
> This commit adds a power_supply_set_input_current_limit_from_supplier
> helper function which charger power-supply drivers can call to get
> the max-current from their supplier and have this applied
> through their set_property call-back to their input-current-limit.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 41 ++++++++++++++++++++++++++=
++++++
>  include/linux/power_supply.h             |  2 ++
>  2 files changed, 43 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 0741fce..3f92574 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -375,6 +375,47 @@ int power_supply_is_system_supplied(void)
>  }
>  EXPORT_SYMBOL_GPL(power_supply_is_system_supplied);
> =20
> +static int __power_supply_get_supplier_max_current(struct device *dev,
> +						   void *data)
> +{
> +	union power_supply_propval ret =3D {0,};
> +	struct power_supply *epsy =3D dev_get_drvdata(dev);
> +	struct power_supply *psy =3D data;
> +
> +	if (__power_supply_is_supplied_by(epsy, psy))
> +		if (!epsy->desc->get_property(epsy,
> +					      POWER_SUPPLY_PROP_CURRENT_MAX,
> +					      &ret))
> +			return ret.intval;
> +
> +	return 0;
> +}
> +
> +int power_supply_set_input_current_limit_from_supplier(struct power_supp=
ly *psy)
> +{
> +	union power_supply_propval val =3D {0,};
> +	int curr;
> +
> +	if (!psy->desc->set_property)
> +		return -EINVAL;
> +
> +	/*
> +	 * This function is not intended for use with a supply with multiple
> +	 * suppliers, we simply pick the first supply to report a non 0
> +	 * max-current.
> +	 */
> +	curr =3D class_for_each_device(power_supply_class, NULL, psy,
> +				      __power_supply_get_supplier_max_current);
> +	if (curr <=3D 0)
> +		return (curr =3D=3D 0) ? -ENODEV : curr;
> +
> +	val.intval =3D curr;
> +
> +	return psy->desc->set_property(psy,
> +				POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_set_input_current_limit_from_supplier);
> +
>  int power_supply_set_battery_charged(struct power_supply *psy)
>  {
>  	if (atomic_read(&psy->use_cnt) >=3D 0 &&
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index de89066..79e90b3 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -332,6 +332,8 @@ extern int power_supply_get_battery_info(struct power=
_supply *psy,
>  					 struct power_supply_battery_info *info);
>  extern void power_supply_changed(struct power_supply *psy);
>  extern int power_supply_am_i_supplied(struct power_supply *psy);
> +extern int power_supply_set_input_current_limit_from_supplier(
> +					 struct power_supply *psy);
>  extern int power_supply_set_battery_charged(struct power_supply *psy);
> =20
>  #ifdef CONFIG_POWER_SUPPLY
> --=20
> 2.9.4
>=20

--kukzqbsxlhlacb6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlR/cACgkQ2O7X88g7
+pphgQ/+NCzJfHFapIZvnNiB1l6sMqydvkxVw6wVdCTFm6bxpYr3WDYm7+YdiR9R
fVdSy2XYage7CeFdp9LWiVJw9CH+QJnu+UPZERudXwysXbcOknrMkS9zPSAaXJyr
qHvchada9GsfEzZCIx2raCZuPEwzL/NEDBv1LwGxfB11djJM/JL49ydAoVMTfWWT
SQUc8hYzwqcjWFBA+D3Y5TtVCCEpS/HAmgh8tb1km1xcN9k0J9pQ9A8SC66WdLaD
nk5erb8WQGwwTT58whkjP/95mjJAbCRQyuKFURS3b3ZVEH7jduyw8Ldkf+UZtwj4
T9f0RE7Uf0y8DNFBJAaU+ZDhOd0uEop+h8S11w5HimMxrQf0rUpqYuOLqtmn5MMS
rfIe9hWBZSHBe7+6v3th1HGB1NUFe370mcQx5sE8U7flYf/lvlhivai5dj7/eTUQ
omGtohX+VHYlm7H7j2Z6ZKRqon+TpAODieeNGWv+h4ZtPxZY3iMY0kupHHzkvqxG
Xw3lxWN9V1dOtVKqWoJRONi/nkLESidQHJd1JC4IREAEUnOwkNfXDZ/tSanP6Z04
8liRpIgp4I7THtFoIaz0zKqHNQiaEi/MbUfPl06ozRtOoQ+7ehgW1VkHQwYymRCZ
VwkycJ955vnrdH0oGmDAyWF3j1yagIyokWRz00Bm4ApLxgdgJHE=
=pqTw
-----END PGP SIGNATURE-----

--kukzqbsxlhlacb6h--
