From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 1/2] power: supply: move HDQ interface for bq27xxx
 from w1 to power/supply
Date: Tue, 25 Jul 2017 15:30:22 +0200
Message-ID: <20170725133022.xjxqas7xy24v3pqa@earth>
References: <20170719170407.14005-1-afd@ti.com>
 <20170719170407.14005-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qudec6p5m337mub"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33169 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdGYNa1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2017 09:30:27 -0400
Content-Disposition: inline
In-Reply-To: <20170719170407.14005-2-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Evgeniy Polyakov <zbr@ioremap.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--7qudec6p5m337mub
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 19, 2017 at 12:04:06PM -0500, Andrew F. Davis wrote:
> The HDQ interface driver should be in this folder just like the I2C
> interface driver. Move this driver out of drivers/w1/slave and into
> drivers/power/supply.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Acked-by: Pali Roh=E1r <pali.rohar@gmail.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>

Thanks, queued to power-supply's for-next branch. I prepared a
immutable branch/tag for the w1 tree and will send a pull request
for that in a minute.

-- Sebastian

>  drivers/power/supply/Kconfig                                     | 9 +++=
++++++
>  drivers/power/supply/Makefile                                    | 1 +
>  .../slaves/w1_bq27000.c =3D> power/supply/bq27xxx_battery_hdq.c}   | 2 --
>  drivers/w1/slaves/Kconfig                                        | 6 ---=
---
>  drivers/w1/slaves/Makefile                                       | 1 -
>  5 files changed, 10 insertions(+), 9 deletions(-)
>  rename drivers/{w1/slaves/w1_bq27000.c =3D> power/supply/bq27xxx_battery=
_hdq.c} (98%)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 969f5005669c..af6397224a82 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -198,6 +198,15 @@ config BATTERY_BQ27XXX_I2C
>  	  Say Y here to enable support for batteries with BQ27xxx chips
>  	  connected over an I2C bus.
> =20
> +config BATTERY_BQ27XXX_HDQ
> +	tristate "BQ27xxx HDQ support"
> +	depends on BATTERY_BQ27XXX
> +	depends on W1
> +	default y
> +	help
> +	  Say Y here to enable support for batteries with BQ27xxx chips
> +	  connected over an HDQ bus.
> +
>  config BATTERY_BQ27XXX_DT_UPDATES_NVM
>  	bool "BQ27xxx support for update of NVM/flash data memory"
>  	depends on BATTERY_BQ27XXX_I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index a41f40957847..946a5e6be860 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_BATTERY_SBS)	+=3D sbs-battery.o
>  obj-$(CONFIG_CHARGER_SBS)	+=3D sbs-charger.o
>  obj-$(CONFIG_BATTERY_BQ27XXX)	+=3D bq27xxx_battery.o
>  obj-$(CONFIG_BATTERY_BQ27XXX_I2C) +=3D bq27xxx_battery_i2c.o
> +obj-$(CONFIG_BATTERY_BQ27XXX_HDQ) +=3D bq27xxx_battery_hdq.o
>  obj-$(CONFIG_BATTERY_DA9030)	+=3D da9030_battery.o
>  obj-$(CONFIG_BATTERY_DA9052)	+=3D da9052-battery.o
>  obj-$(CONFIG_CHARGER_DA9150)	+=3D da9150-charger.o
> diff --git a/drivers/w1/slaves/w1_bq27000.c b/drivers/power/supply/bq27xx=
x_battery_hdq.c
> similarity index 98%
> rename from drivers/w1/slaves/w1_bq27000.c
> rename to drivers/power/supply/bq27xxx_battery_hdq.c
> index 8046ac45381a..f4df67eb9d2c 100644
> --- a/drivers/w1/slaves/w1_bq27000.c
> +++ b/drivers/power/supply/bq27xxx_battery_hdq.c
> @@ -1,6 +1,4 @@
>  /*
> - * drivers/w1/slaves/w1_bq27000.c
> - *
>   * Copyright (C) 2007 Texas Instruments, Inc.
>   *
>   * This file is licensed under the terms of the GNU General Public Licen=
se
> diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
> index fb68465908f2..dc4437683956 100644
> --- a/drivers/w1/slaves/Kconfig
> +++ b/drivers/w1/slaves/Kconfig
> @@ -140,10 +140,4 @@ config W1_SLAVE_DS28E04
> =20
>  	  If you are unsure, say N.
> =20
> -config W1_SLAVE_BQ27000
> -	tristate "BQ27000 slave support"
> -	help
> -	  Say Y here if you want to use a hdq
> -	  bq27000 slave support.
> -
>  endmenu
> diff --git a/drivers/w1/slaves/Makefile b/drivers/w1/slaves/Makefile
> index 54c63e420302..e59441a5e157 100644
> --- a/drivers/w1/slaves/Makefile
> +++ b/drivers/w1/slaves/Makefile
> @@ -15,5 +15,4 @@ obj-$(CONFIG_W1_SLAVE_DS2438)	+=3D w1_ds2438.o
>  obj-$(CONFIG_W1_SLAVE_DS2760)	+=3D w1_ds2760.o
>  obj-$(CONFIG_W1_SLAVE_DS2780)	+=3D w1_ds2780.o
>  obj-$(CONFIG_W1_SLAVE_DS2781)	+=3D w1_ds2781.o
> -obj-$(CONFIG_W1_SLAVE_BQ27000)	+=3D w1_bq27000.o
>  obj-$(CONFIG_W1_SLAVE_DS28E04)	+=3D w1_ds28e04.o
> --=20
> 2.13.0
>=20

--7qudec6p5m337mub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll3R+4ACgkQ2O7X88g7
+poOvw//RUMYq1AZXzkYpxEuUCpUf7u1xpFeSucUiFdjPZX2GMvE1/Wd/6zQ2mOr
Y1dIfHftzusFwq1tn1T0JVChM4RVUfP76GMWaHZWgoN2FEfZPSk4BvOrjk3hV07d
wJ3IblvlU7157uVArsQI6OQAaYAOvKk8mwLavmBvjwfJXYlTSfwtGf1Cz0/B13q/
ysobl98FtWGDZ4EZrHURKaQLrCLKXy/p7DOs7jO+4uVb6g+eB/kXStJlisbp6ZS1
nZdiKhfBKJH11FP3FwqXs/bYNuqNCr761WHe9lR11IOfRJz2K2yj3gsGbRsIg637
m08YQKW8NawbeQOArE841T/D11oMf8nbdFExuNjBTNVwkCaxS0AP/z4vhm3BFJ+A
i4+khzhdxOngkxVKR/8BbBSjiArEY+Ix8io3ex4IZSnmIlMoFcjjJSmvbLrF/aMr
VmCjvqgarE9TkVj3qOGZgTAVkjnyj56R2+9jfJdIZb6tHzeIXPw83yLLyI7mv39y
NsoA3Y+Y0ICMWaJTsLdU2r1BKuZib6kA7/FLbfH42D2/UM1Rjx/k/og3bcrFQRcM
Q8KpGA0WVdm7iOOgLF4vXxNOvuSkbJRyC93V+2S1MJnj39ZHQmFBvFEgvvYhiM6o
bhyojouMj6HniqyK7v7lXvxv8Im7lp+83vE5afcgwqc5GvkY9cA=
=ciNx
-----END PGP SIGNATURE-----

--7qudec6p5m337mub--
