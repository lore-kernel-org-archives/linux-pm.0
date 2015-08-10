From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/6] mfd: da9150: Add support for Fuel-Gauge
Date: Mon, 10 Aug 2015 14:54:22 +0100
Message-ID: <20150810135422.GJ3249@x1>
References: <cover.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
 <27d84f4a77aa8bead37cec71bcd19ca8ad548c30.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:32859 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbbHJNy2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 09:54:28 -0400
Received: by wijp15 with SMTP id p15so136642085wij.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2015 06:54:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <27d84f4a77aa8bead37cec71bcd19ca8ad548c30.1438692348.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>

On Tue, 04 Aug 2015, Adam Thomson wrote:

> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>=20
> Changes in v4:
>  - Update compatible string of fuel-gauge to "dlg, da9150-fuel-gauge"=
=2E Also
>    made similar change to driver name to keep things consistent.
>=20
> Changes in v3:
>  - Use DEFINE_RES_IRQ_NAMED() helper for defining FG IRQ resource.
>  - Unwanted new line & comments removed.
>  - Remove gotos which can be replaced with straight forward return ca=
lls.
>  - Add enum for indexing MFD cells list, which is used to assign pdat=
a for FG
>    sub-device.
>  - Remove use of function pointers for QIF related read/write functio=
ns as
>    currently only I2C supported, so call I2C functions directly.
>  - Fold fg.h contents into core.h.

Assuming these have all been taken care of:

Acked-by: Lee Jones <lee.jones@linaro.org>

> Changes in v2:
>  - Moved temp callback function prototype to be part of power fuel-ga=
uge patch,
>    as requested by Lee Jones.
>=20
>  drivers/mfd/da9150-core.c       | 156 ++++++++++++++++++++++++++++++=
++++++++--
>  include/linux/mfd/da9150/core.h |  19 ++++-
>  2 files changed, 167 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
> index 94b9bbd..85ca4b5 100644
> --- a/drivers/mfd/da9150-core.c
> +++ b/drivers/mfd/da9150-core.c
> @@ -23,6 +23,77 @@
>  #include <linux/mfd/da9150/core.h>
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
> @@ -107,6 +178,28 @@ static const struct regmap_config da9150_regmap_=
config =3D {
>  	.volatile_reg =3D da9150_volatile_reg,
>  };
>=20
> +void da9150_read_qif(struct da9150 *da9150, u8 addr, int count, u8 *=
buf)
> +{
> +	int ret;
> +
> +	ret =3D da9150_i2c_read_device(da9150->core_qif, addr, count, buf);
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
> +	ret =3D da9150_i2c_write_device(da9150->core_qif, addr, count, buf)=
;
> +	if (ret < 0)
> +		dev_err(da9150->dev, "Failed to write to QIF 0x%x: %d\n",
> +			addr, ret);
> +}
> +EXPORT_SYMBOL_GPL(da9150_write_qif);
> +
>  u8 da9150_reg_read(struct da9150 *da9150, u16 reg)
>  {
>  	int val, ret;
> @@ -297,19 +390,35 @@ static struct resource da9150_charger_resources=
[] =3D {
>  	},
>  };
>=20
> +static struct resource da9150_fg_resources[] =3D {
> +	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_FG, "FG"),
> +};
> +
> +enum da9150_dev_idx {
> +	DA9150_GPADC_IDX =3D 0,
> +	DA9150_CHARGER_IDX,
> +	DA9150_FG_IDX,
> +};
> +
>  static struct mfd_cell da9150_devs[] =3D {
> -	{
> +	[DA9150_GPADC_IDX] =3D {
>  		.name =3D "da9150-gpadc",
>  		.of_compatible =3D "dlg,da9150-gpadc",
>  		.resources =3D da9150_gpadc_resources,
>  		.num_resources =3D ARRAY_SIZE(da9150_gpadc_resources),
>  	},
> -	{
> +	[DA9150_CHARGER_IDX] =3D {
>  		.name =3D "da9150-charger",
>  		.of_compatible =3D "dlg,da9150-charger",
>  		.resources =3D da9150_charger_resources,
>  		.num_resources =3D ARRAY_SIZE(da9150_charger_resources),
>  	},
> +	[DA9150_FG_IDX] =3D {
> +		.name =3D "da9150-fuel-gauge",
> +		.of_compatible =3D "dlg,da9150-fuel-gauge",
> +		.resources =3D da9150_fg_resources,
> +		.num_resources =3D ARRAY_SIZE(da9150_fg_resources),
> +	},
>  };
>=20
>  static int da9150_probe(struct i2c_client *client,
> @@ -317,6 +426,7 @@ static int da9150_probe(struct i2c_client *client=
,
>  {
>  	struct da9150 *da9150;
>  	struct da9150_pdata *pdata =3D dev_get_platdata(&client->dev);
> +	int qif_addr;
>  	int ret;
>=20
>  	da9150 =3D devm_kzalloc(&client->dev, sizeof(*da9150), GFP_KERNEL);
> @@ -335,16 +445,41 @@ static int da9150_probe(struct i2c_client *clie=
nt,
>  		return ret;
>  	}
>=20
> -	da9150->irq_base =3D pdata ? pdata->irq_base : -1;
> +	/* Setup secondary I2C interface for QIF access */
> +	qif_addr =3D da9150_reg_read(da9150, DA9150_CORE2WIRE_CTRL_A);
> +	qif_addr =3D (qif_addr & DA9150_CORE_BASE_ADDR_MASK) >> 1;
> +	qif_addr |=3D DA9150_QIF_I2C_ADDR_LSB;
> +	da9150->core_qif =3D i2c_new_dummy(client->adapter, qif_addr);
> +	if (!da9150->core_qif) {
> +		dev_err(da9150->dev, "Failed to attach QIF client\n");
> +		return -ENODEV;
> +	}
> +
> +	i2c_set_clientdata(da9150->core_qif, da9150);
> +
> +	if (pdata) {
> +		da9150->irq_base =3D pdata->irq_base;
> +
> +		da9150_devs[DA9150_FG_IDX].platform_data =3D pdata->fg_pdata;
> +		da9150_devs[DA9150_FG_IDX].pdata_size =3D
> +			sizeof(struct da9150_fg_pdata);
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
> @@ -352,11 +487,17 @@ static int da9150_probe(struct i2c_client *clie=
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
> +
> +	return ret;
>  }
>=20
>  static int da9150_remove(struct i2c_client *client)
> @@ -365,6 +506,7 @@ static int da9150_remove(struct i2c_client *clien=
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
> index 76e6689..1bf50ca 100644
> --- a/include/linux/mfd/da9150/core.h
> +++ b/include/linux/mfd/da9150/core.h
> @@ -15,6 +15,7 @@
>  #define __DA9150_CORE_H
>=20
>  #include <linux/device.h>
> +#include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/regmap.h>
>=20
> @@ -46,23 +47,39 @@
>  #define DA9150_IRQ_GPADC	19
>  #define DA9150_IRQ_WKUP		20
>=20
> +/* I2C sub-device address */
> +#define DA9150_QIF_I2C_ADDR_LSB		0x5
> +
> +struct da9150_fg_pdata {
> +	u32 update_interval;	/* msecs */
> +	u8 warn_soc_lvl;	/* % value */
> +	u8 crit_soc_lvl;	/* % value */
> +};
> +
>  struct da9150_pdata {
>  	int irq_base;
> +	struct da9150_fg_pdata *fg_pdata;
>  };
>=20
>  struct da9150 {
>  	struct device *dev;
>  	struct regmap *regmap;
> +	struct i2c_client *core_qif;
> +
>  	struct regmap_irq_chip_data *regmap_irq_data;
>  	int irq;
>  	int irq_base;
>  };
>=20
> -/* Device I/O */
> +/* Device I/O - Query Interface for FG and standard register access =
*/
> +void da9150_read_qif(struct da9150 *da9150, u8 addr, int count, u8 *=
buf);
> +void da9150_write_qif(struct da9150 *da9150, u8 addr, int count, con=
st u8 *buf);
> +
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

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
