From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 4/8] power: power_supply: add battery info platform
 data retrieval
Date: Sun, 29 Jan 2017 19:28:17 +0100
Message-ID: <20170129182817.7xw4a3a7l6caigjx@earth>
References: <20170122071404.9654-1-matt@ranostay.consulting>
 <20170122071404.9654-5-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ghvkl5hmfdw6c3q2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170122071404.9654-5-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--ghvkl5hmfdw6c3q2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 21, 2017 at 11:14:00PM -0800, Matt Ranostay wrote:
> Add power_supply_get_battery_info() to get battery platform data
>=20
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> ---
>  drivers/power/supply/power_supply_core.c | 41 ++++++++++++++++++++++++++=
++++++
>  include/linux/power_supply.h             |  4 ++++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 1e0960b646e8..21490b5e233f 100644
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
> @@ -487,6 +488,46 @@ struct power_supply *devm_power_supply_get_by_phandl=
e(struct device *dev,
>  EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
>  #endif /* CONFIG_OF */
> =20
> +int power_supply_get_battery_info(struct power_supply *psy,
> +				  struct power_supply_battery_info *info,
> +				  const char *property)
> +{
> +	struct device_node *np =3D psy->of_node;
> +	struct device_node *power_supply_battery_info_np;
> +	struct property *p;
> +	char *prefix =3D "fixed-battery";
> +	int ret;
> +
> +	if (!np)
> +		return -ENXIO;

I guess we can print a warning here, that fixed-battery is
currently only supported for DT.

> +	power_supply_battery_info_np =3D of_parse_phandle(np, property, 0);
> +	if (!power_supply_battery_info_np)
> +		return -ENODEV;

Let's enforce the "monitored-battery" name and remove the property
name as parameter. Iff we need another name, it could be added later.

-- Sebastian

--ghvkl5hmfdw6c3q2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliONEEACgkQ2O7X88g7
+pq/jg/6A/lL/Nux6jYKmL3DM4G6LGH7FsLUSSXbv/VM25gS6QLJtK5VehI9/LHP
ZiHft9s/I8kj3mucjRPksbCqgSn9BEr26OXQnDGw4V+OhGke7YPRbZ5kplOHEONs
VkRzneWAZyAXCuHwuU9oXzxhBQq2OoVwV27+DQGvZZk5G1AwzSWFvPhIENLEASa5
iweALNCpsLqLiiEXgXkohHhy41YKma7mzjLaxwFfaFuRIT8a7wRKMY6uCugcwVtg
O42jHFv4nn7LJKm5JSUPbeiThMMllu6F8QZ/RK0tckTSjkAqfzYh61vdFUB8evV8
SUoGIyRbTN6LvAVaQEx3tMG2P2TJhBNfEkMYLZIFW8lqu8YRoKJlh8STDNsVCiPn
cGMNZrlLJuPihAjKt5hmCksvVe86c1K3gxwKzmjJKJqXUxQiYiFSR2nNc3IZC1X1
u2VrESrv3Fh3HdZaDp95URKujVdo6YcEFSWzGShNhr0XgEnmuhF7z1HVJX4mvL3s
0eQBtidtGLuFjMv6r0/1eZ0iki2h+bq68ZLKeAClEFJLZjb5a9Exw728o7p8hNHB
LmBbbkXeytmP+L8CIYr+3aGcWKvm/xfs9DgNDYxDtcCesRcrsTumenCfFqqaJ+qD
4Pi8fbIWmyKBh5U21Buold30+DMx/oV2PnB16MmcJMNb5RznGkY=
=2R0C
-----END PGP SIGNATURE-----

--ghvkl5hmfdw6c3q2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
