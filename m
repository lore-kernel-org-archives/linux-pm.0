From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 09/14] power: supply: bq24190_charger: Export 5V boost
 converter as regulator
Date: Tue, 29 Aug 2017 13:28:42 +0200
Message-ID: <20170829112842.lvkzig6uwky6gjk5@earth>
References: <20170815200502.17339-1-hdegoede@redhat.com>
 <20170815200502.17339-10-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1664197205814527717=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170815200502.17339-10-hdegoede@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: devel@driverdev.osuosl.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--===============1664197205814527717==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7rctaprekpd3unjh"
Content-Disposition: inline


--7rctaprekpd3unjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 15, 2017 at 10:04:57PM +0200, Hans de Goede wrote:
> Register the 5V boost converter as a regulator named "usb_otg_vbus".
>=20
> This commit also adds support for bq24190_platform_data, through which
> non device-tree platforms can pass the regulator_init_data (containing
> mappings for the consumer amongst other things).
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Use "usb_otg_vbus" as default name for the regulator
> -Add support for passing regulator_init_data for non device-tree platforms
> -Register the regulator later, to avoid it showing up and shortly later
>  disappearing again on probe errors (e.g. -EPROBE_DEFER).
> ---
>  drivers/power/supply/bq24190_charger.c | 126 +++++++++++++++++++++++++++=
++++++
>  include/linux/power/bq24190_charger.h  |  18 +++++
>  2 files changed, 144 insertions(+)
>  create mode 100644 include/linux/power/bq24190_charger.h
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index d5a707e..073cd9d 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -16,6 +16,9 @@
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/power_supply.h>
> +#include <linux/power/bq24190_charger.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
>  #include <linux/workqueue.h>
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
> @@ -504,6 +507,125 @@ static int bq24190_sysfs_create_group(struct bq2419=
0_dev_info *bdi)
>  static inline void bq24190_sysfs_remove_group(struct bq24190_dev_info *b=
di) {}
>  #endif
> =20
> +#ifdef CONFIG_REGULATOR
> +
> +static int bq24190_vbus_enable(struct regulator_dev *dev)
> +{
> +	struct bq24190_dev_info *bdi =3D rdev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D pm_runtime_get_sync(bdi->dev);
> +	if (ret < 0) {
> +		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
> +		pm_runtime_put_noidle(bdi->dev);
> +		return ret;
> +	}
> +
> +	ret =3D bq24190_write_mask(bdi, BQ24190_REG_POC,
> +				 BQ24190_REG_POC_CHG_CONFIG_MASK,
> +				 BQ24190_REG_POC_CHG_CONFIG_SHIFT,
> +				 BQ24190_REG_POC_CHG_CONFIG_OTG);
> +
> +	pm_runtime_mark_last_busy(bdi->dev);
> +	pm_runtime_put_autosuspend(bdi->dev);
> +
> +	return ret;
> +}
> +
> +static int bq24190_vbus_disable(struct regulator_dev *dev)
> +{
> +	struct bq24190_dev_info *bdi =3D rdev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D pm_runtime_get_sync(bdi->dev);
> +	if (ret < 0) {
> +		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
> +		pm_runtime_put_noidle(bdi->dev);
> +		return ret;
> +	}
> +
> +	ret =3D bq24190_write_mask(bdi, BQ24190_REG_POC,
> +				 BQ24190_REG_POC_CHG_CONFIG_MASK,
> +				 BQ24190_REG_POC_CHG_CONFIG_SHIFT,
> +				 BQ24190_REG_POC_CHG_CONFIG_CHARGE);
> +
> +	pm_runtime_mark_last_busy(bdi->dev);
> +	pm_runtime_put_autosuspend(bdi->dev);
> +
> +	return ret;
> +}

Let's reduce code duplication:

static int bq24190_vbus_set(dev, val) {
    ...
}

static int bq24190_vbus_enable(dev) {
    return bq24190_vbus_set(dev, BQ24190_REG_POC_CHG_CONFIG_OTG);
}

static int bq24190_vbus_disable(dev) {
    return bq24190_vbus_set(dev, BQ24190_REG_POC_CHG_CONFIG_CHARGE);
}

> +static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
> +{
> +	struct bq24190_dev_info *bdi =3D rdev_get_drvdata(dev);
> +	int ret;
> +	u8 val;
> +
> +	ret =3D pm_runtime_get_sync(bdi->dev);
> +	if (ret < 0) {
> +		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
> +		pm_runtime_put_noidle(bdi->dev);
> +		return ret;
> +	}
> +
> +	ret =3D bq24190_read_mask(bdi, BQ24190_REG_POC,
> +				BQ24190_REG_POC_CHG_CONFIG_MASK,
> +				BQ24190_REG_POC_CHG_CONFIG_SHIFT, &val);
> +
> +	pm_runtime_mark_last_busy(bdi->dev);
> +	pm_runtime_put_autosuspend(bdi->dev);
> +
> +	return ret ? ret : val =3D=3D BQ24190_REG_POC_CHG_CONFIG_OTG;
> +}
> +
> +static const struct regulator_ops bq24190_vbus_ops =3D {
> +	.enable =3D bq24190_vbus_enable,
> +	.disable =3D bq24190_vbus_disable,
> +	.is_enabled =3D bq24190_vbus_is_enabled,
> +};
> +
> +static const struct regulator_desc bq24190_vbus_desc =3D {
> +	.name =3D "usb_otg_vbus",
> +	.type =3D REGULATOR_VOLTAGE,
> +	.owner =3D THIS_MODULE,
> +	.ops =3D &bq24190_vbus_ops,
> +	.fixed_uV =3D 5000000,
> +	.n_voltages =3D 1,
> +};
> +
> +static const struct regulator_init_data bq24190_vbus_init_data =3D {
> +	.constraints =3D {
> +		.valid_ops_mask =3D REGULATOR_CHANGE_STATUS,
> +	},
> +};
> +
> +static int bq24190_register_vbus_regulator(struct bq24190_dev_info *bdi)
> +{
> +	struct bq24190_platform_data *pdata =3D bdi->dev->platform_data;
> +	struct regulator_config cfg =3D { };
> +	struct regulator_dev *reg;
> +	int ret =3D 0;
> +
> +	cfg.dev =3D bdi->dev;
> +	if (pdata && pdata->regulator_init_data)
> +		cfg.init_data =3D pdata->regulator_init_data;
> +	else
> +		cfg.init_data =3D &bq24190_vbus_init_data;
> +	cfg.driver_data =3D bdi;
> +	reg =3D devm_regulator_register(bdi->dev, &bq24190_vbus_desc, &cfg);
> +	if (IS_ERR(reg)) {
> +		ret =3D PTR_ERR(reg);
> +		dev_err(bdi->dev, "Can't register regulator: %d\n", ret);
> +	}
> +
> +	return ret;
> +}
> +#else
> +static int bq24190_register_vbus_regulator(struct bq24190_dev_info *bdi)
> +{
> +	return 0;
> +}
> +#endif
> +
>  /*
>   * According to the "Host Mode and default Mode" section of the
>   * manual, a write to any register causes the bq24190 to switch
> @@ -1577,6 +1699,10 @@ static int bq24190_probe(struct i2c_client *client,
>  		goto out_sysfs;
>  	}
> =20
> +	ret =3D bq24190_register_vbus_regulator(bdi);
> +	if (ret < 0)
> +		goto out_sysfs;
> +
>  	if (bdi->extcon) {
>  		INIT_DELAYED_WORK(&bdi->extcon_work, bq24190_extcon_work);
>  		bdi->extcon_nb.notifier_call =3D bq24190_extcon_event;
> diff --git a/include/linux/power/bq24190_charger.h b/include/linux/power/=
bq24190_charger.h
> new file mode 100644
> index 0000000..45ce7f1
> --- /dev/null
> +++ b/include/linux/power/bq24190_charger.h
> @@ -0,0 +1,18 @@
> +/*
> + * Platform data for the TI bq24190 battery charger driver.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _BQ24190_CHARGER_H_
> +#define _BQ24190_CHARGER_H_
> +
> +#include <linux/regulator/machine.h>
> +
> +struct bq24190_platform_data {
> +	const struct regulator_init_data *regulator_init_data;
> +};
> +
> +#endif
> --=20
> 2.9.4
>=20

Otherwise looks fine to me.

-- Sebastian

--7rctaprekpd3unjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlT+cACgkQ2O7X88g7
+pq3RA//cGO9sncLQnOy1Z2Hd6nt62am2QwBvL1qNFMovez8CACOxGnlSE+P2Elt
fy2kA+p+KKDEfQAriL1yU0p50a9peewb9wZ8TpL7uF79vX4SedIvIg3tF7lZqYcQ
2KOBPvCbhbUaibOUsNe13V9b2nW2S209okNJXM9owqeo9TVDV0v2BVsvh5xz6/13
jyr1QTj5I9v76k41Rp33Yx2qL5k6NwrTceCRWvJPcr6qeUdc0zM2UHb9ZRJhYj2X
FtaSTE2FSpaonlNOiin5xem5iOjAxRHnkQs6Ykroiu4djaf+gr9U3GHJd08joMGX
gHGEKcwxF0hFYYnYJRM2yNEvcjumWwHizX5tI22EnA6wrS8vwDf564sqSwxnHeae
LcG+FqfPJsdenOCAya2CfwUDjFB7U5pVXElHq/DmpUFaR2Xb0HERQCnJHBK7+w/+
PCVW8hieOqniVSNW1A8iz0NXkoNNgBXukgvGw6mf5uWCb49ixD5/TdzBHEx/mlYh
i//hjuD2ZNOYyDlg8dkl9el7ZIfpAqo4QPsXWAR+HbZdG73PtXGe1jGeneYKDo6M
A8+uoxa0mfdMZmaP5eW6YOH+bgPQokxkPstZggiFNyTLDS8eQ1WJxr6gaatSPQtx
rehoVD8K6kgMFQAJRPaLRo0ZDiPJgvc9I2K08BPn3YV8fBSwBLA=
=b+HN
-----END PGP SIGNATURE-----

--7rctaprekpd3unjh--

--===============1664197205814527717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============1664197205814527717==--
