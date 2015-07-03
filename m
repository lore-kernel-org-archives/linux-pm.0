From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/4] mfd: da9150: Add support for Fuel-Gauge
Date: Fri, 3 Jul 2015 16:16:08 +0100
Message-ID: <20150703151608.GA10500@x1>
References: <cover.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
 <11b930c87ee9728ce8911896aa673e2ad1dedf40.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11b930c87ee9728ce8911896aa673e2ad1dedf40.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 26 Jun 2015, Adam Thomson wrote:

> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---

Changelog v1 =3D> v2?

>  drivers/mfd/da9150-core.c       | 162 ++++++++++++++++++++++++++++++=
++++++++--
>  include/linux/mfd/da9150/core.h |  19 +++++
>  include/linux/mfd/da9150/fg.h   |  29 +++++++
>  3 files changed, 202 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/mfd/da9150/fg.h
>=20
> diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
> index 5549817..8feb75d 100644
> --- a/drivers/mfd/da9150-core.c
> +++ b/drivers/mfd/da9150-core.c
> @@ -21,8 +21,80 @@
>  #include <linux/interrupt.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/da9150/core.h>
> +#include <linux/mfd/da9150/fg.h>
>  #include <linux/mfd/da9150/registers.h>
>=20
> +/* Raw device access, used for QIF */
> +static int da9150_i2c_read_device(struct i2c_client *client, u8 addr=
, int count,
> +				  u8 *buf)
> +{
> +	struct i2c_msg xfer;
> +	int ret;
> +
> +	/*
> +	 * Read is split into two transfers as device expects STOP/START ra=
ther
> +	 * than repeated start to carry out this kind of access.
> +	 */
> +
> +	/* Write address */
> +	xfer.addr =3D client->addr;
> +	xfer.flags =3D 0;
> +	xfer.len =3D 1;
> +	xfer.buf =3D &addr;
> +
> +	ret =3D i2c_transfer(client->adapter, &xfer, 1);
> +	if (ret !=3D 1) {
> +		if (ret < 0)
> +			return ret;
> +		else
> +			return -EIO;
> +	}
> +
> +	/* Read data */
> +	xfer.addr =3D client->addr;
> +	xfer.flags =3D I2C_M_RD;
> +	xfer.len =3D count;
> +	xfer.buf =3D buf;
> +
> +	ret =3D i2c_transfer(client->adapter, &xfer, 1);
> +	if (ret =3D=3D 1)
> +		return 0;
> +	else if (ret < 0)
> +		return ret;
> +	else
> +		return -EIO;
> +}
> +
> +static int da9150_i2c_write_device(struct i2c_client *client, u8 add=
r,
> +				   int count, const u8 *buf)
> +{
> +	struct i2c_msg xfer;
> +	u8 *reg_data;
> +	int ret;
> +
> +	reg_data =3D kzalloc(1 + count, GFP_KERNEL);
> +	if (!reg_data)
> +		return -ENOMEM;
> +
> +	reg_data[0] =3D addr;
> +	memcpy(&reg_data[1], buf, count);
> +
> +	/* Write address & data */
> +	xfer.addr =3D client->addr;
> +	xfer.flags =3D 0;
> +	xfer.len =3D 1 + count;
> +	xfer.buf =3D reg_data;
> +
> +	ret =3D i2c_transfer(client->adapter, &xfer, 1);
> +	kfree(reg_data);
> +	if (ret =3D=3D 1)
> +		return 0;
> +	else if (ret < 0)
> +		return ret;
> +	else
> +		return -EIO;
> +}
> +
>  static bool da9150_volatile_reg(struct device *dev, unsigned int reg=
)
>  {
>  	switch (reg) {
> @@ -107,6 +179,28 @@ static const struct regmap_config da9150_regmap_=
config =3D {
>  	.volatile_reg =3D da9150_volatile_reg,
>  };
>=20
> +void da9150_read_qif(struct da9150 *da9150, u8 addr, int count, u8 *=
buf)
> +{
> +	int ret;
> +
> +	ret =3D da9150->read_dev(da9150->core_qif, addr, count, buf);
> +	if (ret < 0)
> +		dev_err(da9150->dev, "Failed to read from QIF 0x%x: %d\n",
> +			addr, ret);
> +}
> +EXPORT_SYMBOL_GPL(da9150_read_qif);
> +
> +void da9150_write_qif(struct da9150 *da9150, u8 addr, int count, con=
st u8 *buf)
> +{
> +	int ret;
> +
> +	ret =3D da9150->write_dev(da9150->core_qif, addr, count, buf);
> +	if (ret < 0)
> +		dev_err(da9150->dev, "Failed to write to QIF 0x%x: %d\n",
> +			addr, ret);
> +}
> +EXPORT_SYMBOL_GPL(da9150_write_qif);
> +
>  u8 da9150_reg_read(struct da9150 *da9150, u16 reg)
>  {
>  	int val, ret;
> @@ -297,6 +391,15 @@ static struct resource da9150_charger_resources[=
] =3D {
>  	},
>  };
>=20
> +static struct resource da9150_fg_resources[] =3D {
> +	{
> +		.name =3D "FG",
> +		.start =3D DA9150_IRQ_FG,
> +		.end =3D DA9150_IRQ_FG,
> +		.flags =3D IORESOURCE_IRQ,

Can you use the DEFINE_RES_* helpers?=20

> +	},
> +};
> +
>  static struct mfd_cell da9150_devs[] =3D {
>  	{
>  		.name =3D "da9150-gpadc",
> @@ -310,6 +413,12 @@ static struct mfd_cell da9150_devs[] =3D {
>  		.resources =3D da9150_charger_resources,
>  		.num_resources =3D ARRAY_SIZE(da9150_charger_resources),
>  	},
> +	{
> +		.name =3D "da9150-fuelgauge",
> +		.of_compatible =3D "dlg,da9150-fg",
> +		.resources =3D da9150_fg_resources,
> +		.num_resources =3D ARRAY_SIZE(da9150_fg_resources),
> +	},
>  };
>=20
>  static int da9150_probe(struct i2c_client *client,
> @@ -317,11 +426,14 @@ static int da9150_probe(struct i2c_client *clie=
nt,
>  {
>  	struct da9150 *da9150;
>  	struct da9150_pdata *pdata =3D dev_get_platdata(&client->dev);
> +	int qif_addr;
>  	int ret;
>=20
>  	da9150 =3D devm_kzalloc(&client->dev, sizeof(*da9150), GFP_KERNEL);
> -	if (!da9150)
> -		return -ENOMEM;
> +	if (!da9150) {
> +		ret =3D -ENOMEM;
> +		goto fail;

Don't do this.  'fail' doesn't do anything, just return here.

> +	}
>=20
>  	da9150->dev =3D &client->dev;
>  	da9150->irq =3D client->irq;
> @@ -332,19 +444,46 @@ static int da9150_probe(struct i2c_client *clie=
nt,
>  		ret =3D PTR_ERR(da9150->regmap);
>  		dev_err(da9150->dev, "Failed to allocate register map: %d\n",
>  			ret);
> -		return ret;
> +		goto fail;

It was better before.

> +	}
> +
> +	/* Setup secondary I2C interface for QIF access */
> +	qif_addr =3D da9150_reg_read(da9150, DA9150_CORE2WIRE_CTRL_A);
> +	qif_addr =3D (qif_addr & DA9150_CORE_BASE_ADDR_MASK) >> 1;
> +	qif_addr |=3D DA9150_QIF_I2C_ADDR_LSB;
> +	da9150->core_qif =3D i2c_new_dummy(client->adapter, qif_addr);
> +	if (!da9150->core_qif) {
> +		dev_err(da9150->dev, "Failed to attach QIF client\n");
> +		ret =3D -ENODEV;
> +		goto fail;

Same.

>  	}
>=20
> -	da9150->irq_base =3D pdata ? pdata->irq_base : -1;
> +	i2c_set_clientdata(da9150->core_qif, da9150);
> +	da9150->read_dev =3D (read_dev_t) da9150_i2c_read_device;
> +	da9150->write_dev =3D (write_dev_t) da9150_i2c_write_device;

Is it possible for read_dev to be set to anything other than
da9150_i2c_read_device?

> +	if (pdata) {
> +		da9150->irq_base =3D pdata->irq_base;
> +
> +		da9150_devs[2].platform_data =3D pdata->fg_pdata;
> +		da9150_devs[2].pdata_size =3D sizeof(struct da9150_fg_pdata);

This is fragile.

If another device gets inserted above the FG, this will break.

> +	} else {
> +		da9150->irq_base =3D -1;
> +	}
>=20
>  	ret =3D regmap_add_irq_chip(da9150->regmap, da9150->irq,
>  				  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  				  da9150->irq_base, &da9150_regmap_irq_chip,
>  				  &da9150->regmap_irq_data);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		dev_err(da9150->dev, "Failed to add regmap irq chip: %d\n",
> +			ret);
> +		goto regmap_irq_fail;
> +	}
> +
>=20
>  	da9150->irq_base =3D regmap_irq_chip_get_base(da9150->regmap_irq_da=
ta);
> +
>  	enable_irq_wake(da9150->irq);
>=20
>  	ret =3D mfd_add_devices(da9150->dev, -1, da9150_devs,
> @@ -352,11 +491,17 @@ static int da9150_probe(struct i2c_client *clie=
nt,
>  			      da9150->irq_base, NULL);
>  	if (ret) {
>  		dev_err(da9150->dev, "Failed to add child devices: %d\n", ret);
> -		regmap_del_irq_chip(da9150->irq, da9150->regmap_irq_data);
> -		return ret;
> +		goto mfd_fail;
>  	}
>=20
>  	return 0;
> +
> +mfd_fail:
> +	regmap_del_irq_chip(da9150->irq, da9150->regmap_irq_data);
> +regmap_irq_fail:
> +	i2c_unregister_device(da9150->core_qif);
> +fail:
> +	return ret;
>  }
>=20
>  static int da9150_remove(struct i2c_client *client)
> @@ -365,6 +510,7 @@ static int da9150_remove(struct i2c_client *clien=
t)
>=20
>  	regmap_del_irq_chip(da9150->irq, da9150->regmap_irq_data);
>  	mfd_remove_devices(da9150->dev);
> +	i2c_unregister_device(da9150->core_qif);
>=20
>  	return 0;
>  }
> diff --git a/include/linux/mfd/da9150/core.h b/include/linux/mfd/da91=
50/core.h
> index 76e6689..98ecfea 100644
> --- a/include/linux/mfd/da9150/core.h
> +++ b/include/linux/mfd/da9150/core.h
> @@ -15,9 +15,11 @@
>  #define __DA9150_CORE_H
>=20
>  #include <linux/device.h>
> +#include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/regmap.h>
>=20
> +

Please remove this.

>  /* I2C address paging */
>  #define DA9150_REG_PAGE_SHIFT	8
>  #define DA9150_REG_PAGE_MASK	0xFF
> @@ -46,23 +48,40 @@
>  #define DA9150_IRQ_GPADC	19
>  #define DA9150_IRQ_WKUP		20
>=20
> +/* Platform Data */

No need for this comment.  The pdata in the name give it away.

> +struct da9150_fg_pdata;

Why can't you just put the struct definition in here?

>  struct da9150_pdata {
>  	int irq_base;
> +	struct da9150_fg_pdata *fg_pdata;
>  };
>=20
> +/* I/O function typedefs for raw access */
> +typedef int (*read_dev_t)(void *client, u8 addr, int count, u8 *buf)=
;
> +typedef int (*write_dev_t)(void *client, u8 addr, int count, const u=
8 *buf);

No need to typedef, just pop them directly into the struct.  Although
I'm not convinced that need them at all really.

>  struct da9150 {
>  	struct device *dev;
>  	struct regmap *regmap;
> +	struct i2c_client *core_qif;
> +
> +	read_dev_t read_dev;
> +	write_dev_t write_dev;
> +
>  	struct regmap_irq_chip_data *regmap_irq_data;
>  	int irq;
>  	int irq_base;

Why are there 2 irq_bases?  That could get pretty confusing.

Why is it being stored?

Same with irq.

>  };
>=20
>  /* Device I/O */
> +void da9150_read_qif(struct da9150 *da9150, u8 addr, int count, u8 *=
buf);
> +void da9150_write_qif(struct da9150 *da9150, u8 addr, int count, con=
st u8 *buf);

What is qif?  The naming convention isn't very transparent.

>  u8 da9150_reg_read(struct da9150 *da9150, u16 reg);
>  void da9150_reg_write(struct da9150 *da9150, u16 reg, u8 val);
>  void da9150_set_bits(struct da9150 *da9150, u16 reg, u8 mask, u8 val=
);
>=20
>  void da9150_bulk_read(struct da9150 *da9150, u16 reg, int count, u8 =
*buf);
>  void da9150_bulk_write(struct da9150 *da9150, u16 reg, int count, co=
nst u8 *buf);
> +
>  #endif /* __DA9150_CORE_H */
> diff --git a/include/linux/mfd/da9150/fg.h b/include/linux/mfd/da9150=
/fg.h
> new file mode 100644
> index 0000000..0ff52ab
> --- /dev/null
> +++ b/include/linux/mfd/da9150/fg.h
> @@ -0,0 +1,29 @@
> +/*
> + * DA9150 MFD Driver - Fuel Gauge Data

Does it really require it's very own header file?

> + * Copyright (c) 2015 Dialog Semiconductor
> + *
> + * Author: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> + *
> + * This program is free software; you can redistribute  it and/or mo=
dify it
> + * under  the terms of  the GNU General  Public License as published=
 by the
> + * Free Software Foundation;  either version 2 of the  License, or (=
at your
> + * option) any later version.
> + */
> +
> +#ifndef __DA9150_FG_H
> +#define __DA9150_FG_H
> +
> +#include <linux/power_supply.h>
> +
> +/* I2C sub-device address */
> +#define DA9150_QIF_I2C_ADDR_LSB		0x5
> +
> +/* Platform data */
> +struct da9150_fg_pdata {
> +	u32 update_interval;	/* msecs */
> +	u8 warn_soc_lvl;	/* % value */
> +	u8 crit_soc_lvl;	/* % value */
> +};
> +
> +#endif /* __DA9150_FG_H */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
