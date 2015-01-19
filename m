From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/7] mfd: Add support for DA9150 combined charger &
 fuel-gauge device
Date: Mon, 19 Jan 2015 11:33:32 +0000
Message-ID: <20150119113332.GP21886@x1>
References: <cover.1419264383.git.Adam.Thomson.Opensource@diasemi.com>
 <8768cf84babd1bc3e16dadc25bdbb50cebfb44b6.1419264383.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8768cf84babd1bc3e16dadc25bdbb50cebfb44b6.1419264383.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

On Mon, 22 Dec 2014, Adam Thomson wrote:

> DA9150 is a combined Charger and Fuel-Gauge IC, with additional
> GPIO and GPADC functionality.
>=20
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  drivers/mfd/Kconfig                  |   12 +
>  drivers/mfd/Makefile                 |    2 +-
>  drivers/mfd/da9150-core.c            |  413 ++++++++++++
>  include/linux/mfd/da9150/core.h      |   68 ++
>  include/linux/mfd/da9150/registers.h | 1155 ++++++++++++++++++++++++=
++++++++++
>  5 files changed, 1649 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mfd/da9150-core.c
>  create mode 100644 include/linux/mfd/da9150/core.h
>  create mode 100644 include/linux/mfd/da9150/registers.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2e6b731..56e80d2 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -195,6 +195,18 @@ config MFD_DA9063
>  	  Additional drivers must be enabled in order to use the functional=
ity
>  	  of the device.
>=20
> +config MFD_DA9150
> +	tristate "Dialog Semiconductor DA9150 Charger Fuel-Gauge chip"
> +	depends on I2C=3Dy
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  This adds support for the DA9150 integrated charger and fuel-gaug=
e
> +	  chip. This driver provides common support for accessing the devic=
e.
> +	  Additional drivers must be enabled in order to use the specific
> +	  features of the device.
> +
>  config MFD_DLN2
>  	tristate "Diolan DLN2 support"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 53467e2..f06f4c6 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -113,7 +113,7 @@ obj-$(CONFIG_MFD_DA9055)	+=3D da9055.o
>=20
>  da9063-objs			:=3D da9063-core.o da9063-irq.o da9063-i2c.o
>  obj-$(CONFIG_MFD_DA9063)	+=3D da9063.o
> -
> +obj-$(CONFIG_MFD_DA9150)	+=3D da9150-core.o
>  obj-$(CONFIG_MFD_MAX14577)	+=3D max14577.o
>  obj-$(CONFIG_MFD_MAX77686)	+=3D max77686.o
>  obj-$(CONFIG_MFD_MAX77693)	+=3D max77693.o
> diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
> new file mode 100644
> index 0000000..4d757b9
> --- /dev/null
> +++ b/drivers/mfd/da9150-core.c
> @@ -0,0 +1,413 @@
> +/*
> + * DA9150 Core MFD Driver
> + *
> + * Copyright (c) 2014 Dialog Semiconductor
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

[...]

> +u8 da9150_reg_read(struct da9150 *da9150, u16 reg)
> +{
> +	int val, ret;
> +
> +	ret =3D regmap_read(da9150->regmap, reg, &val);
> +	if (ret)
> +		dev_err(da9150->dev, "Failed to read from reg 0x%x: %d\n",
> +			reg, ret);
> +
> +	return (u8) val;
> +}
> +EXPORT_SYMBOL_GPL(da9150_reg_read);
> +
> +void da9150_reg_write(struct da9150 *da9150, u16 reg, u8 val)
> +{
> +	int ret;
> +
> +	ret =3D regmap_write(da9150->regmap, reg, val);
> +	if (ret)
> +		dev_err(da9150->dev, "Failed to write to reg 0x%x: %d\n",
> +			reg, ret);
> +}
> +EXPORT_SYMBOL_GPL(da9150_reg_write);
> +
> +void da9150_set_bits(struct da9150 *da9150, u16 reg, u8 mask, u8 val=
)
> +{
> +	int ret;
> +
> +	ret =3D regmap_update_bits(da9150->regmap, reg, mask, val);
> +	if (ret)
> +		dev_err(da9150->dev, "Failed to set bits in reg 0x%x: %d\n",
> +			reg, ret);
> +}
> +EXPORT_SYMBOL_GPL(da9150_set_bits);
> +
> +void da9150_bulk_read(struct da9150 *da9150, u16 reg, int count, u8 =
*buf)
> +{
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(da9150->regmap, reg, buf, count);
> +	if (ret)
> +		dev_err(da9150->dev, "Failed to bulk read from reg 0x%x: %d\n",
> +			reg, ret);
> +}
> +EXPORT_SYMBOL_GPL(da9150_bulk_read);
> +
> +void da9150_bulk_write(struct da9150 *da9150, u16 reg, int count, co=
nst u8 *buf)
> +{
> +	int ret;
> +
> +	ret =3D regmap_raw_write(da9150->regmap, reg, buf, count);
> +	if (ret)
> +		dev_err(da9150->dev, "Failed to bulk write to reg 0x%x %d\n",
> +			reg, ret);
> +}
> +EXPORT_SYMBOL_GPL(da9150_bulk_write);

I've never been a fan of this type of aggregation.  Can you explain to
me what the point of them is?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
