From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 2/2] power: supply: bq27xxx: move platform driver code
 into bq27xxx_battery_hdq.c
Date: Tue, 25 Jul 2017 15:42:58 +0200
Message-ID: <20170725134258.gjhz5u3tklejebmw@earth>
References: <20170719170407.14005-1-afd@ti.com>
 <20170719170407.14005-3-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tcn55wqygyqx4i63"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170719170407.14005-3-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Evgeniy Polyakov <zbr@ioremap.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--tcn55wqygyqx4i63
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 19, 2017 at 12:04:07PM -0500, Andrew F. Davis wrote:
> When the BQ27xxx driver was originally written the w1 subsystem only
> allowed device drivers for w1 attached devices to live in the w1
> subsystem. Kernel driver subsystems expect that the driver for a device
> live in the directory of the subsystem for which it implements
> functionality, not in the directory of the bus that it is attached. To
> work around this, the BQ27xxx driver was implemented as a platform device
> driver and the interface driver would instantiate this device from within
> the w1 directory, then pass a w1 read callback as platform data.
>=20
> As we can now have the w1 interface driver in the power/supply directory
> (like we do already with the i2c interface driver) we can remove this
> middle-layer platform driver.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Acked-by: Pali Roh=E1r <pali.rohar@gmail.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c     | 104 ------------
>  drivers/power/supply/bq27xxx_battery_hdq.c | 250 ++++++++++++++++-------=
------
>  include/linux/power/bq27xxx_battery.h      |  17 --
>  3 files changed, 135 insertions(+), 236 deletions(-)
>  rewrite drivers/power/supply/bq27xxx_battery_hdq.c (72%)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index ed44439d0112..079083b31293 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1938,110 +1938,6 @@ void bq27xxx_battery_teardown(struct bq27xxx_devi=
ce_info *di)
>  }
>  EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
> =20
> -static int bq27xxx_battery_platform_read(struct bq27xxx_device_info *di,=
 u8 reg,
> -					 bool single)
> -{
> -	struct device *dev =3D di->dev;
> -	struct bq27xxx_platform_data *pdata =3D dev->platform_data;
> -	unsigned int timeout =3D 3;
> -	int upper, lower;
> -	int temp;
> -
> -	if (!single) {
> -		/* Make sure the value has not changed in between reading the
> -		 * lower and the upper part */
> -		upper =3D pdata->read(dev, reg + 1);
> -		do {
> -			temp =3D upper;
> -			if (upper < 0)
> -				return upper;
> -
> -			lower =3D pdata->read(dev, reg);
> -			if (lower < 0)
> -				return lower;
> -
> -			upper =3D pdata->read(dev, reg + 1);
> -		} while (temp !=3D upper && --timeout);
> -
> -		if (timeout =3D=3D 0)
> -			return -EIO;
> -
> -		return (upper << 8) | lower;
> -	}
> -
> -	return pdata->read(dev, reg);
> -}
> -
> -static int bq27xxx_battery_platform_probe(struct platform_device *pdev)
> -{
> -	struct bq27xxx_device_info *di;
> -	struct bq27xxx_platform_data *pdata =3D pdev->dev.platform_data;
> -
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "no platform_data supplied\n");
> -		return -EINVAL;
> -	}
> -
> -	if (!pdata->read) {
> -		dev_err(&pdev->dev, "no hdq read callback supplied\n");
> -		return -EINVAL;
> -	}
> -
> -	if (!pdata->chip) {
> -		dev_err(&pdev->dev, "no device supplied\n");
> -		return -EINVAL;
> -	}
> -
> -	di =3D devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
> -	if (!di)
> -		return -ENOMEM;
> -
> -	platform_set_drvdata(pdev, di);
> -
> -	di->dev =3D &pdev->dev;
> -	di->chip =3D pdata->chip;
> -	di->name =3D pdata->name ?: dev_name(&pdev->dev);
> -	di->bus.read =3D bq27xxx_battery_platform_read;
> -
> -	return bq27xxx_battery_setup(di);
> -}
> -
> -static int bq27xxx_battery_platform_remove(struct platform_device *pdev)
> -{
> -	struct bq27xxx_device_info *di =3D platform_get_drvdata(pdev);
> -
> -	bq27xxx_battery_teardown(di);
> -
> -	return 0;
> -}
> -
> -static const struct platform_device_id bq27xxx_battery_platform_id_table=
[] =3D {
> -	{ "bq27000-battery", },
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(platform, bq27xxx_battery_platform_id_table);
> -
> -#ifdef CONFIG_OF
> -static const struct of_device_id bq27xxx_battery_platform_of_match_table=
[] =3D {
> -	{ .compatible =3D "ti,bq27000" },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, bq27xxx_battery_platform_of_match_table);
> -#endif
> -
> -static struct platform_driver bq27xxx_battery_platform_driver =3D {
> -	.probe	=3D bq27xxx_battery_platform_probe,
> -	.remove =3D bq27xxx_battery_platform_remove,
> -	.driver =3D {
> -		.name =3D "bq27000-battery",
> -		.of_match_table =3D of_match_ptr(bq27xxx_battery_platform_of_match_tab=
le),
> -	},
> -	.id_table =3D bq27xxx_battery_platform_id_table,
> -};
> -module_platform_driver(bq27xxx_battery_platform_driver);
> -
> -MODULE_ALIAS("platform:bq27000-battery");
> -
>  MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
>  MODULE_DESCRIPTION("BQ27xxx battery monitor driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/power/supply/bq27xxx_battery_hdq.c b/drivers/power/s=
upply/bq27xxx_battery_hdq.c
> dissimilarity index 72%
> index f4df67eb9d2c..9aff896c9802 100644
> --- a/drivers/power/supply/bq27xxx_battery_hdq.c
> +++ b/drivers/power/supply/bq27xxx_battery_hdq.c
> @@ -1,115 +1,135 @@
> -/*
> - * Copyright (C) 2007 Texas Instruments, Inc.
> - *
> - * This file is licensed under the terms of the GNU General Public Licen=
se
> - * version 2. This program is licensed "as is" without any warranty of a=
ny
> - * kind, whether express or implied.
> - *
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/device.h>
> -#include <linux/types.h>
> -#include <linux/platform_device.h>
> -#include <linux/mutex.h>
> -#include <linux/power/bq27xxx_battery.h>
> -
> -#include <linux/w1.h>
> -
> -#define W1_FAMILY_BQ27000	0x01
> -
> -#define HDQ_CMD_READ	(0)
> -#define HDQ_CMD_WRITE	(1<<7)
> -
> -static int F_ID;
> -module_param(F_ID, int, S_IRUSR);
> -MODULE_PARM_DESC(F_ID, "1-wire slave FID for BQ device");
> -
> -static int w1_bq27000_read(struct device *dev, unsigned int reg)
> -{
> -	u8 val;
> -	struct w1_slave *sl =3D container_of(dev->parent, struct w1_slave, dev);
> -
> -	mutex_lock(&sl->master->bus_mutex);
> -	w1_write_8(sl->master, HDQ_CMD_READ | reg);
> -	val =3D w1_read_8(sl->master);
> -	mutex_unlock(&sl->master->bus_mutex);
> -
> -	return val;
> -}
> -
> -static struct bq27xxx_platform_data bq27000_battery_info =3D {
> -	.read   =3D w1_bq27000_read,
> -	.name   =3D "bq27000-battery",
> -	.chip   =3D BQ27000,
> -};
> -
> -static int w1_bq27000_add_slave(struct w1_slave *sl)
> -{
> -	int ret;
> -	struct platform_device *pdev;
> -
> -	pdev =3D platform_device_alloc("bq27000-battery", -1);
> -	if (!pdev) {
> -		ret =3D -ENOMEM;
> -		return ret;
> -	}
> -	ret =3D platform_device_add_data(pdev,
> -				       &bq27000_battery_info,
> -				       sizeof(bq27000_battery_info));
> -	if (ret)
> -		goto pdev_add_failed;
> -	pdev->dev.parent =3D &sl->dev;
> -
> -	ret =3D platform_device_add(pdev);
> -	if (ret)
> -		goto pdev_add_failed;
> -
> -	dev_set_drvdata(&sl->dev, pdev);
> -
> -	goto success;
> -
> -pdev_add_failed:
> -	platform_device_put(pdev);
> -success:
> -	return ret;
> -}
> -
> -static void w1_bq27000_remove_slave(struct w1_slave *sl)
> -{
> -	struct platform_device *pdev =3D dev_get_drvdata(&sl->dev);
> -
> -	platform_device_unregister(pdev);
> -}
> -
> -static struct w1_family_ops w1_bq27000_fops =3D {
> -	.add_slave	=3D w1_bq27000_add_slave,
> -	.remove_slave	=3D w1_bq27000_remove_slave,
> -};
> -
> -static struct w1_family w1_bq27000_family =3D {
> -	.fid =3D W1_FAMILY_BQ27000,
> -	.fops =3D &w1_bq27000_fops,
> -};
> -
> -static int __init w1_bq27000_init(void)
> -{
> -	if (F_ID)
> -		w1_bq27000_family.fid =3D F_ID;
> -
> -	return w1_register_family(&w1_bq27000_family);
> -}
> -
> -static void __exit w1_bq27000_exit(void)
> -{
> -	w1_unregister_family(&w1_bq27000_family);
> -}
> -
> -module_init(w1_bq27000_init);
> -module_exit(w1_bq27000_exit);
> -
> -MODULE_AUTHOR("Texas Instruments Ltd");
> -MODULE_DESCRIPTION("HDQ/1-wire slave driver bq27000 battery monitor chip=
");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS("w1-family-" __stringify(W1_FAMILY_BQ27000));
> +/*
> + * BQ27xxx battery monitor HDQ/1-wire driver
> + *
> + * Copyright (C) 2007-2017 Texas Instruments Incorporated - http://www.t=
i.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/types.h>
> +#include <linux/platform_device.h>
> +#include <linux/mutex.h>
> +#include <linux/power/bq27xxx_battery.h>
> +
> +#include <linux/w1.h>
> +
> +#define W1_FAMILY_BQ27000	0x01
> +
> +#define HDQ_CMD_READ	(0 << 7)
> +#define HDQ_CMD_WRITE	(1 << 7)
> +
> +static int F_ID;
> +module_param(F_ID, int, S_IRUSR);
> +MODULE_PARM_DESC(F_ID, "1-wire slave FID for BQ27xxx device");
> +
> +static int w1_bq27000_read(struct w1_slave *sl, unsigned int reg)
> +{
> +	u8 val;
> +
> +	mutex_lock(&sl->master->bus_mutex);
> +	w1_write_8(sl->master, HDQ_CMD_READ | reg);
> +	val =3D w1_read_8(sl->master);
> +	mutex_unlock(&sl->master->bus_mutex);
> +
> +	return val;
> +}
> +
> +static int bq27xxx_battery_hdq_read(struct bq27xxx_device_info *di, u8 r=
eg,
> +				    bool single)
> +{
> +	struct w1_slave *sl =3D dev_to_w1_slave(di->dev);
> +	unsigned int timeout =3D 3;
> +	int upper, lower;
> +	int temp;
> +
> +	if (!single) {
> +		/*
> +		 * Make sure the value has not changed in between reading the
> +		 * lower and the upper part
> +		 */
> +		upper =3D w1_bq27000_read(sl, reg + 1);
> +		do {
> +			temp =3D upper;
> +			if (upper < 0)
> +				return upper;
> +
> +			lower =3D w1_bq27000_read(sl, reg);
> +			if (lower < 0)
> +				return lower;
> +
> +			upper =3D w1_bq27000_read(sl, reg + 1);
> +		} while (temp !=3D upper && --timeout);
> +
> +		if (timeout =3D=3D 0)
> +			return -EIO;
> +
> +		return (upper << 8) | lower;
> +	}
> +
> +	return w1_bq27000_read(sl, reg);
> +}
> +
> +static int bq27xxx_battery_hdq_add_slave(struct w1_slave *sl)
> +{
> +	struct bq27xxx_device_info *di;
> +
> +	di =3D devm_kzalloc(&sl->dev, sizeof(*di), GFP_KERNEL);
> +	if (!di)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&sl->dev, di);
> +
> +	di->dev =3D &sl->dev;
> +	di->chip =3D BQ27000;
> +	di->name =3D "bq27000-battery";
> +	di->bus.read =3D bq27xxx_battery_hdq_read;
> +
> +	return bq27xxx_battery_setup(di);
> +}
> +
> +static void bq27xxx_battery_hdq_remove_slave(struct w1_slave *sl)
> +{
> +	struct bq27xxx_device_info *di =3D dev_get_drvdata(&sl->dev);
> +
> +	bq27xxx_battery_teardown(di);
> +}
> +
> +static struct w1_family_ops bq27xxx_battery_hdq_fops =3D {
> +	.add_slave	=3D bq27xxx_battery_hdq_add_slave,
> +	.remove_slave	=3D bq27xxx_battery_hdq_remove_slave,
> +};
> +
> +static struct w1_family bq27xxx_battery_hdq_family =3D {
> +	.fid =3D W1_FAMILY_BQ27000,
> +	.fops =3D &bq27xxx_battery_hdq_fops,
> +};
> +
> +static int __init bq27xxx_battery_hdq_init(void)
> +{
> +	if (F_ID)
> +		bq27xxx_battery_hdq_family.fid =3D F_ID;
> +
> +	return w1_register_family(&bq27xxx_battery_hdq_family);
> +}
> +module_init(bq27xxx_battery_hdq_init);
> +
> +static void __exit bq27xxx_battery_hdq_exit(void)
> +{
> +	w1_unregister_family(&bq27xxx_battery_hdq_family);
> +}
> +module_exit(bq27xxx_battery_hdq_exit);
> +
> +MODULE_AUTHOR("Texas Instruments Ltd");
> +MODULE_DESCRIPTION("BQ27xxx battery monitor HDQ/1-wire driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("w1-family-" __stringify(W1_FAMILY_BQ27000));
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index 11e11685dd1d..89890437f9ab 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -20,23 +20,6 @@ enum bq27xxx_chip {
>  	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
>  };
> =20
> -/**
> - * struct bq27xxx_plaform_data - Platform data for bq27xxx devices
> - * @name: Name of the battery.
> - * @chip: Chip class number of this device.
> - * @read: HDQ read callback.
> - *	This function should provide access to the HDQ bus the battery is
> - *	connected to.
> - *	The first parameter is a pointer to the battery device, the second the
> - *	register to be read. The return value should either be the content of
> - *	the passed register or an error value.
> - */
> -struct bq27xxx_platform_data {
> -	const char *name;
> -	enum bq27xxx_chip chip;
> -	int (*read)(struct device *dev, unsigned int);
> -};
> -
>  struct bq27xxx_device_info;
>  struct bq27xxx_access_methods {
>  	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
> --=20
> 2.13.0
>=20

--tcn55wqygyqx4i63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll3St8ACgkQ2O7X88g7
+poYMg/9GXJdnlFhMSg1fLIv1Jqo5KP4N9GG615oDIh/sP4cta5ht/WM8pp+WRi8
nSmxi97OfnRILWKPS5zIxuyfacvWc4DQ9HkVfAjMxWLsoINXLahlnqf5dCUpxaka
njRGO46mBW5YamIKQNVSAsVqF8Z0PSNA32KhzjhiNdlfkgpokatiofdgIiX7jjmY
ZU9VDjma3ZEhu7YuS36k74qwaDLJuSWqi9PUnYf/bTj3SSJVimjtGOHqm20967Ly
cm0ja9TWbIkhJlJvPfnXW8yQ9QboqV82aWXIsBfz0DcPCxm29cwmHrYfVAzAe5Go
srU2wj4F9XrGzXsJ1NLwVfZgMJlGdka4heCUXtsYkED5K2GudBdkkS/nRhKNd52a
h4dRIee8WGPolIixUr+DFY7XBHaqWK2did1w+BlkUYLU9qqnroEZjaJaz9IKMYIZ
2HmvBEgI/Is5V9xkrtpCADM4EmrXuc3jpey5o3ehnoh4vXJOayJomvQPiQF1IbGN
f+NHZB6LyO/wNCiesJbS00aBWTqSi3NJgY86OBr4+pPP/58RkIR8N/mGtoQLf3YN
fSGyNcg6zU93HeHES3UMGiAV/8rj4iXvG4PLVTVsHlsYOY1IKDplZOAT9RZwysg4
TMGT35GMgvdQnNRMm54WIUdg8/IIH0GMhRYNkwQQ2oLuiYlLQjg=
=Icl7
-----END PGP SIGNATURE-----

--tcn55wqygyqx4i63--
