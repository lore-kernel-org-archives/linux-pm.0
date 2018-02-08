From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v13 2/4] pm: add to_power_supply macro to the API
Date: Thu, 8 Feb 2018 22:57:04 +0100
Message-ID: <20180208215704.imzbxsnv6hhfh73n@earth.universe>
References: <20180207145827.yvramuiotxguff2a@thinkpad>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sehlbxocdbg3nkqm"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180207145827.yvramuiotxguff2a@thinkpad>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org


--sehlbxocdbg3nkqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 07, 2018 at 03:58:27PM +0100, Ognjen Galic wrote:
> This patch adds the to_power_supply macro to upcast
> a device to a power_supply struct.
>=20
> This is needed because the same piece of code using
> container_of is used in various other places, so we
> abstract away such low-level operations via a macro.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Ognjen Galic <smclt30p@gmail.com>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

I suggest I provide an immutable branch for this one,
so that it can be used by the acpi subsystem for the
4.17 cycle.

-- Sebastian

> ---
>=20
> Notes:
>     v9:
>     * Split the pm changes from the thinkpad_acpi patch
>       into its own patch
>    =20
>     v10:
>     * No changes in this patch in v10
>    =20
>     v11:
>     * Fix changelog formatting
>    =20
>     v12:
>     * Fix build issues in ds2781 and ds2780 battery driver
>    =20
>     v13:
>     * No changes in this patch in v13
>=20
>  drivers/power/supply/ds2780_battery.c    | 5 -----
>  drivers/power/supply/ds2781_battery.c    | 5 -----
>  drivers/power/supply/power_supply_core.c | 2 +-
>  include/linux/power_supply.h             | 2 ++
>  4 files changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply=
/ds2780_battery.c
> index e5d81b493..370e91093 100644
> --- a/drivers/power/supply/ds2780_battery.c
> +++ b/drivers/power/supply/ds2780_battery.c
> @@ -56,11 +56,6 @@ to_ds2780_device_info(struct power_supply *psy)
>  	return power_supply_get_drvdata(psy);
>  }
> =20
> -static inline struct power_supply *to_power_supply(struct device *dev)
> -{
> -	return dev_get_drvdata(dev);
> -}
> -
>  static inline int ds2780_battery_io(struct ds2780_device_info *dev_info,
>  	char *buf, int addr, size_t count, int io)
>  {
> diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply=
/ds2781_battery.c
> index efe83ef86..d1b5a19aa 100644
> --- a/drivers/power/supply/ds2781_battery.c
> +++ b/drivers/power/supply/ds2781_battery.c
> @@ -54,11 +54,6 @@ to_ds2781_device_info(struct power_supply *psy)
>  	return power_supply_get_drvdata(psy);
>  }
> =20
> -static inline struct power_supply *to_power_supply(struct device *dev)
> -{
> -	return dev_get_drvdata(dev);
> -}
> -
>  static inline int ds2781_battery_io(struct ds2781_device_info *dev_info,
>  	char *buf, int addr, size_t count, int io)
>  {
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 82f998ab5..feac7b066 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -668,7 +668,7 @@ EXPORT_SYMBOL_GPL(power_supply_powers);
> =20
>  static void power_supply_dev_release(struct device *dev)
>  {
> -	struct power_supply *psy =3D container_of(dev, struct power_supply, dev=
);
> +	struct power_supply *psy =3D to_power_supply(dev);
>  	dev_dbg(dev, "%s\n", __func__);
>  	kfree(psy);
>  }
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 79e90b3d3..f0139b460 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -371,6 +371,8 @@ devm_power_supply_register_no_ws(struct device *paren=
t,
>  extern void power_supply_unregister(struct power_supply *psy);
>  extern int power_supply_powers(struct power_supply *psy, struct device *=
dev);
> =20
> +#define to_power_supply(device) container_of(device, struct power_supply=
, dev)
> +
>  extern void *power_supply_get_drvdata(struct power_supply *psy);
>  /* For APM emulation, think legacy userspace. */
>  extern struct class *power_supply_class;
> --=20
> 2.14.1
>=20

--sehlbxocdbg3nkqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp8x68ACgkQ2O7X88g7
+poQPA/+K++NjqbV65Vr9NQo83/dp8rxGIjc2nVuhLJDmOpq5ycwm2Y1XK9FTMeW
r7z4XamLRreIlg+LN1BzgSJulXmzvSAAgsZ4vQcLc9OSZWo2FWV/DRJxMD+9De1o
fDBbJLXlkOKwxDfdkOv3553kjmr9/mCfD+6XKPB8JuI6ZyZJqPUa+FDM+dp/jOBc
CJ7zI0FfQjAwboXL72vScdEQlZv5fo7Q93cx125hiVaHoKJwDFH++0bJd+VDbBhG
BUi8peUEEVH5yfvTkxeXxevw8AnLTb1BV9uP4TXxX3eAF4hMk/kU6Thh+XM6PNzo
h6ndJ+k/X5zdWLa3ucAdgW5Nu5nxXQLdCciM1c4ciUZmzVlK70sDMqm0NQ4ZRdTR
gR2uWvkOCl+UaUfmm+x0YMEt8yE15stzIiHXKORIpAyV2vmD5JR0AUICIBc72UjT
ECqXqjkjDX1BRPp+cC+29ADO0KqJFHtpyVuFHFYvStKZcf0sg8xanY6rbxOwcl1y
I5zh1baLSfYAKkJOqNfR92frWXCND8nJHoHY/mFb7HrQmkj1phVsiDL6soRbhT0V
UifcKIQ4VCgfEaS02B25TSJQey+dvK69iEm9m90LCCDKRdwLBmVPl9QNaUdpQEjV
GpZdF6SceTfL8WIWvkb2fay5EsSYWlB6HMBTEj2xPJ5ZPKZQusY=
=nh/C
-----END PGP SIGNATURE-----

--sehlbxocdbg3nkqm--
