From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 1/4] mfd: rt5033: Add Richtek RT5033 driver core.
Date: Tue, 9 Dec 2014 14:01:02 +0000
Message-ID: <20141209140102.GZ3951@x1>
References: <1418126634-4781-1-git-send-email-beomho.seo@samsung.com>
 <1418126634-4781-2-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418126634-4781-2-git-send-email-beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, geunsik.lim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, 09 Dec 2014, Beomho Seo wrote:

> This patch adds a new driver for Richtek RT5033 driver.
> RT5033 is a Multifunction device which includes battery charger, fuel=
 gauge,
> flash LED current source, LDO and synchronous Buck converter. It is i=
nterfaced
> to host controller using I2C interface.
>=20
> Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Lee Jones <lee.jone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> Changes in v8
> - Add description of hardware.
> - Move structure.
>=20
> Changes in v7
> - Use small description.
> - Change some names for a variable.
> - Revise of_device_id struct style.
>=20
> Changes in v6
> - Fix white space issue in mfd cell struct.
>=20
> Changes in v5
> - Change possible built as a module.
> - Revise rt5033_dev mfd cell entry.
> - Fix incorrect typo.
> - Add module alias.
>=20
> Changes in v4
> - none.
>=20
> Changes in v3
> - Correct sentence errors.
> - Add author information the top of each drivers.
> - Remove unnecessary pre-initialise, struct member(rt5033->i2c) and b=
link.
> - Change some return check.
> - Use bool and of_match_ptr().
>=20
> Changes in v2
> - Remove volatile_reg callback. Because this driver not in use regmap=
 cache.
> - Revmoe unnecessary subnode of_compatible.
> - Add define for set_high impedance mode of charger.
> ---
>  drivers/mfd/Kconfig                |   12 ++
>  drivers/mfd/Makefile               |    1 +
>  drivers/mfd/rt5033.c               |  142 ++++++++++++++++++++
>  include/linux/mfd/rt5033-private.h |  260 ++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/rt5033.h         |   62 +++++++++
>  5 files changed, 477 insertions(+)
>  create mode 100644 drivers/mfd/rt5033.c
>  create mode 100644 include/linux/mfd/rt5033-private.h
>  create mode 100644 include/linux/mfd/rt5033.h

Much better.

=46or my own reference:

Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

So what's the plan with this set?

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2e6b731..9cd2af6 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -623,6 +623,18 @@ config MFD_RTSX_PCI
>  	  types of memory cards, such as Memory Stick, Memory Stick Pro,
>  	  Secure Digital and MultiMediaCard.
> =20
> +config MFD_RT5033
> +	tristate "Richtek RT5033 Power Management IC"
> +	depends on I2C=3Dy
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  This driver provides for the Richtek RT5033 Power Management IC,
> +	  which includes the I2C driver and the Core APIs. This driver prov=
ides
> +	  common support for accessing the device. The device supports mult=
iple
> +	  sub-devices like charger, fuel gauge, flash LED, current source,
> +	  LDO and Buck.
> +
>  config MFD_RTSX_USB
>  	tristate "Realtek USB card reader"
>  	depends on USB
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 53467e2..4059c24 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -176,6 +176,7 @@ obj-$(CONFIG_MFD_IPAQ_MICRO)	+=3D ipaq-micro.o
>  obj-$(CONFIG_MFD_MENF21BMC)	+=3D menf21bmc.o
>  obj-$(CONFIG_MFD_HI6421_PMIC)	+=3D hi6421-pmic-core.o
>  obj-$(CONFIG_MFD_DLN2)		+=3D dln2.o
> +obj-$(CONFIG_MFD_RT5033)	+=3D rt5033.o
> =20
>  intel-soc-pmic-objs		:=3D intel_soc_pmic_core.o intel_soc_pmic_crc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC)	+=3D intel-soc-pmic.o
> diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
> new file mode 100644
> index 0000000..db395a6
> --- /dev/null
> +++ b/drivers/mfd/rt5033.c
> @@ -0,0 +1,142 @@
> +/*
> + * MFD core driver for the Richtek RT5033.
> + *
> + * RT5033 comprises multiple sub-devices switcing charger, fuel gaug=
e,
> + * flash LED, current source, LDO and BUCK regulators.
> + *
> + * Copyright (C) 2014 Samsung Electronics, Co., Ltd.
> + * Author: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published bythe Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/rt5033.h>
> +#include <linux/mfd/rt5033-private.h>
> +
> +static const struct regmap_irq rt5033_irqs[] =3D {
> +	{ .mask =3D RT5033_PMIC_IRQ_BUCKOCP, },
> +	{ .mask =3D RT5033_PMIC_IRQ_BUCKLV, },
> +	{ .mask =3D RT5033_PMIC_IRQ_SAFELDOLV, },
> +	{ .mask =3D RT5033_PMIC_IRQ_LDOLV, },
> +	{ .mask =3D RT5033_PMIC_IRQ_OT, },
> +	{ .mask =3D RT5033_PMIC_IRQ_VDDA_UV, },
> +};
> +
> +static const struct regmap_irq_chip rt5033_irq_chip =3D {
> +	.name		=3D "rt5033",
> +	.status_base	=3D RT5033_REG_PMIC_IRQ_STAT,
> +	.mask_base	=3D RT5033_REG_PMIC_IRQ_CTRL,
> +	.mask_invert	=3D true,
> +	.num_regs	=3D 1,
> +	.irqs		=3D rt5033_irqs,
> +	.num_irqs	=3D ARRAY_SIZE(rt5033_irqs),
> +};
> +
> +static const struct mfd_cell rt5033_devs[] =3D {
> +	{ .name =3D "rt5033-regulator", },
> +	{
> +		.name =3D "rt5033-charger",
> +		.of_compatible =3D "richtek,rt5033-charger",
> +	}, {
> +		.name =3D "rt5033-battery",
> +		.of_compatible =3D "richtek,rt5033-battery",
> +	},
> +};
> +
> +static const struct regmap_config rt5033_regmap_config =3D {
> +	.reg_bits	=3D 8,
> +	.val_bits	=3D 8,
> +	.max_register	=3D RT5033_REG_END,
> +};
> +
> +static int rt5033_i2c_probe(struct i2c_client *i2c,
> +				const struct i2c_device_id *id)
> +{
> +	struct rt5033_dev *rt5033;
> +	unsigned int dev_id;
> +	int ret;
> +
> +	rt5033 =3D devm_kzalloc(&i2c->dev, sizeof(*rt5033), GFP_KERNEL);
> +	if (!rt5033)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, rt5033);
> +	rt5033->dev =3D &i2c->dev;
> +	rt5033->irq =3D i2c->irq;
> +	rt5033->wakeup =3D true;
> +
> +	rt5033->regmap =3D devm_regmap_init_i2c(i2c, &rt5033_regmap_config)=
;
> +	if (IS_ERR(rt5033->regmap)) {
> +		dev_err(&i2c->dev, "Failed to allocate register map.\n");
> +		return PTR_ERR(rt5033->regmap);
> +	}
> +
> +	ret =3D regmap_read(rt5033->regmap, RT5033_REG_DEVICE_ID, &dev_id);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Device not found\n");
> +		return -ENODEV;
> +	}
> +	dev_info(&i2c->dev, "Device found Device ID: %04x\n", dev_id);
> +
> +	ret =3D regmap_add_irq_chip(rt5033->regmap, rt5033->irq,
> +			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +			0, &rt5033_irq_chip, &rt5033->irq_data);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to request IRQ %d: %d\n",
> +							rt5033->irq, ret);
> +		return ret;
> +	}
> +
> +	ret =3D mfd_add_devices(rt5033->dev, -1, rt5033_devs,
> +			ARRAY_SIZE(rt5033_devs), NULL, 0,
> +			regmap_irq_get_domain(rt5033->irq_data));
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "Failed to add RT5033 child devices.\n");
> +		return ret;
> +	}
> +
> +	device_init_wakeup(rt5033->dev, rt5033->wakeup);
> +
> +	return 0;
> +}
> +
> +static int rt5033_i2c_remove(struct i2c_client *i2c)
> +{
> +	mfd_remove_devices(&i2c->dev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id rt5033_i2c_id[] =3D {
> +	{ "rt5033", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, rt5033_i2c_id);
> +
> +static const struct of_device_id rt5033_dt_match[] =3D {
> +	{ .compatible =3D "richtek,rt5033", },
> +	{ }
> +};
> +
> +static struct i2c_driver rt5033_driver =3D {
> +	.driver =3D {
> +		.name =3D "rt5033",
> +		.of_match_table =3D of_match_ptr(rt5033_dt_match),
> +	},
> +	.probe =3D rt5033_i2c_probe,
> +	.remove =3D rt5033_i2c_remove,
> +	.id_table =3D rt5033_i2c_id,
> +};
> +module_i2c_driver(rt5033_driver);
> +
> +MODULE_ALIAS("i2c:rt5033");
> +MODULE_DESCRIPTION("Richtek RT5033 multi-function core driver");
> +MODULE_AUTHOR("Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/rt5033-private.h b/include/linux/mfd/r=
t5033-private.h
> new file mode 100644
> index 0000000..1b63fc2
> --- /dev/null
> +++ b/include/linux/mfd/rt5033-private.h
> @@ -0,0 +1,260 @@
> +/*
> + * MFD core driver for Richtek RT5033
> + *
> + * Copyright (C) 2014 Samsung Electronics, Co., Ltd.
> + * Author: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published bythe Free Software Foundation.
> + */
> +
> +#ifndef __RT5033_PRIVATE_H__
> +#define __RT5033_PRIVATE_H__
> +
> +enum rt5033_reg {
> +	RT5033_REG_CHG_STAT		=3D 0x00,
> +	RT5033_REG_CHG_CTRL1		=3D 0x01,
> +	RT5033_REG_CHG_CTRL2		=3D 0x02,
> +	RT5033_REG_DEVICE_ID		=3D 0x03,
> +	RT5033_REG_CHG_CTRL3		=3D 0x04,
> +	RT5033_REG_CHG_CTRL4		=3D 0x05,
> +	RT5033_REG_CHG_CTRL5		=3D 0x06,
> +	RT5033_REG_RT_CTRL0		=3D 0x07,
> +	RT5033_REG_CHG_RESET		=3D 0x08,
> +	/* Reserved 0x09~0x18 */
> +	RT5033_REG_RT_CTRL1		=3D 0x19,
> +	/* Reserved 0x1A~0x20 */
> +	RT5033_REG_FLED_FUNCTION1	=3D 0x21,
> +	RT5033_REG_FLED_FUNCTION2	=3D 0x22,
> +	RT5033_REG_FLED_STROBE_CTRL1	=3D 0x23,
> +	RT5033_REG_FLED_STROBE_CTRL2	=3D 0x24,
> +	RT5033_REG_FLED_CTRL1		=3D 0x25,
> +	RT5033_REG_FLED_CTRL2		=3D 0x26,
> +	RT5033_REG_FLED_CTRL3		=3D 0x27,
> +	RT5033_REG_FLED_CTRL4		=3D 0x28,
> +	RT5033_REG_FLED_CTRL5		=3D 0x29,
> +	/* Reserved 0x2A~0x40 */
> +	RT5033_REG_CTRL			=3D 0x41,
> +	RT5033_REG_BUCK_CTRL		=3D 0x42,
> +	RT5033_REG_LDO_CTRL		=3D 0x43,
> +	/* Reserved 0x44~0x46 */
> +	RT5033_REG_MANUAL_RESET_CTRL	=3D 0x47,
> +	/* Reserved 0x48~0x5F */
> +	RT5033_REG_CHG_IRQ1		=3D 0x60,
> +	RT5033_REG_CHG_IRQ2		=3D 0x61,
> +	RT5033_REG_CHG_IRQ3		=3D 0x62,
> +	RT5033_REG_CHG_IRQ1_CTRL	=3D 0x63,
> +	RT5033_REG_CHG_IRQ2_CTRL	=3D 0x64,
> +	RT5033_REG_CHG_IRQ3_CTRL	=3D 0x65,
> +	RT5033_REG_LED_IRQ_STAT		=3D 0x66,
> +	RT5033_REG_LED_IRQ_CTRL		=3D 0x67,
> +	RT5033_REG_PMIC_IRQ_STAT	=3D 0x68,
> +	RT5033_REG_PMIC_IRQ_CTRL	=3D 0x69,
> +	RT5033_REG_SHDN_CTRL		=3D 0x6A,
> +	RT5033_REG_OFF_EVENT		=3D 0x6B,
> +
> +	RT5033_REG_END,
> +};
> +
> +/* RT5033 Charger state register */
> +#define RT5033_CHG_STAT_MASK		0x20
> +#define RT5033_CHG_STAT_DISCHARGING	0x00
> +#define RT5033_CHG_STAT_FULL		0x10
> +#define RT5033_CHG_STAT_CHARGING	0x20
> +#define RT5033_CHG_STAT_NOT_CHARGING	0x30
> +#define RT5033_CHG_STAT_TYPE_MASK	0x60
> +#define RT5033_CHG_STAT_TYPE_PRE	0x20
> +#define RT5033_CHG_STAT_TYPE_FAST	0x60
> +
> +/* RT5033 CHGCTRL1 register */
> +#define RT5033_CHGCTRL1_IAICR_MASK	0xe0
> +#define RT5033_CHGCTRL1_MODE_MASK	0x01
> +
> +/* RT5033 CHGCTRL2 register */
> +#define RT5033_CHGCTRL2_CV_MASK		0xfc
> +
> +/* RT5033 CHGCTRL3 register */
> +#define RT5033_CHGCTRL3_CFO_EN_MASK	0x40
> +#define RT5033_CHGCTRL3_TIMER_MASK	0x38
> +#define RT5033_CHGCTRL3_TIMER_EN_MASK	0x01
> +
> +/* RT5033 CHGCTRL4 register */
> +#define RT5033_CHGCTRL4_EOC_MASK	0x07
> +#define RT5033_CHGCTRL4_IPREC_MASK	0x18
> +
> +/* RT5033 CHGCTRL5 register */
> +#define RT5033_CHGCTRL5_VPREC_MASK	0x0f
> +#define RT5033_CHGCTRL5_ICHG_MASK	0xf0
> +#define RT5033_CHGCTRL5_ICHG_SHIFT	0x04
> +#define RT5033_CHG_MAX_CURRENT		0x0d
> +
> +/* RT5033 RT CTRL1 register */
> +#define RT5033_RT_CTRL1_UUG_MASK	0x02
> +#define RT5033_RT_HZ_MASK		0x01
> +
> +/* RT5033 control register */
> +#define RT5033_CTRL_FCCM_BUCK_MASK		0x00
> +#define RT5033_CTRL_BUCKOMS_MASK		0x01
> +#define RT5033_CTRL_LDOOMS_MASK			0x02
> +#define RT5033_CTRL_SLDOOMS_MASK		0x03
> +#define RT5033_CTRL_EN_BUCK_MASK		0x04
> +#define RT5033_CTRL_EN_LDO_MASK			0x05
> +#define RT5033_CTRL_EN_SAFE_LDO_MASK		0x06
> +#define RT5033_CTRL_LDO_SLEEP_MASK		0x07
> +
> +/* RT5033 BUCK control register */
> +#define RT5033_BUCK_CTRL_MASK			0x1f
> +
> +/* RT5033 LDO control register */
> +#define RT5033_LDO_CTRL_MASK			0x1f
> +
> +/* RT5033 charger property - model, manufacturer */
> +
> +#define RT5033_CHARGER_MODEL	"RT5033WSC Charger"
> +#define RT5033_MANUFACTURER	"Richtek Technology Corporation"
> +
> +/*
> + * RT5033 charger fast-charge current lmits (as in CHGCTRL1 register=
),
> + * AICR mode limits the input current for example,
> + * the AIRC 100 mode limits the input current to 100 mA.
> + */
> +#define RT5033_AICR_100_MODE			0x20
> +#define RT5033_AICR_500_MODE			0x40
> +#define RT5033_AICR_700_MODE			0x60
> +#define RT5033_AICR_900_MODE			0x80
> +#define RT5033_AICR_1500_MODE			0xc0
> +#define RT5033_AICR_2000_MODE			0xe0
> +#define RT5033_AICR_MODE_MASK			0xe0
> +
> +/* RT5033 use internal timer need to set time */
> +#define RT5033_FAST_CHARGE_TIMER4		0x00
> +#define RT5033_FAST_CHARGE_TIMER6		0x01
> +#define RT5033_FAST_CHARGE_TIMER8		0x02
> +#define RT5033_FAST_CHARGE_TIMER9		0x03
> +#define RT5033_FAST_CHARGE_TIMER12		0x04
> +#define RT5033_FAST_CHARGE_TIMER14		0x05
> +#define RT5033_FAST_CHARGE_TIMER16		0x06
> +
> +#define RT5033_INT_TIMER_ENABLE			0x01
> +
> +/* RT5033 charger termination enable mask */
> +#define RT5033_TE_ENABLE_MASK			0x08
> +
> +/*
> + * RT5033 charger opa mode. RT50300 have two opa mode charger mode
> + * and boost mode for OTG
> + */
> +
> +#define RT5033_CHARGER_MODE			0x00
> +#define RT5033_BOOST_MODE			0x01
> +
> +/* RT5033 charger termination enable */
> +#define RT5033_TE_ENABLE			0x08
> +
> +/* RT5033 charger CFO enable */
> +#define RT5033_CFO_ENABLE			0x40
> +
> +/* RT5033 charger constant charge voltage (as in CHGCTRL2 register),=
 uV */
> +#define RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MIN	3650000U
> +#define RT5033_CHARGER_CONST_VOLTAGE_STEP_NUM   25000U
> +#define RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MAX	4400000U
> +
> +/* RT5033 charger pre-charge current limits (as in CHGCTRL4 register=
), uA */
> +#define RT5033_CHARGER_PRE_CURRENT_LIMIT_MIN	350000U
> +#define RT5033_CHARGER_PRE_CURRENT_STEP_NUM	100000U
> +#define RT5033_CHARGER_PRE_CURRENT_LIMIT_MAX	650000U
> +
> +/* RT5033 charger fast-charge current (as in CHGCTRL5 register), uA =
*/
> +#define RT5033_CHARGER_FAST_CURRENT_MIN		700000U
> +#define RT5033_CHARGER_FAST_CURRENT_STEP_NUM	100000U
> +#define RT5033_CHARGER_FAST_CURRENT_MAX		2000000U
> +
> +/*
> + * RT5033 charger const-charge end of charger current (
> + * as in CHGCTRL4 register), uA
> + */
> +#define RT5033_CHARGER_EOC_MIN			150000U
> +#define RT5033_CHARGER_EOC_REF			300000U
> +#define RT5033_CHARGER_EOC_STEP_NUM1		50000U
> +#define RT5033_CHARGER_EOC_STEP_NUM2		100000U
> +#define RT5033_CHARGER_EOC_MAX			600000U
> +
> +/*
> + * RT5033 charger pre-charge threshold volt limits
> + * (as in CHGCTRL5 register), uV
> + */
> +
> +#define RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MIN	2300000U
> +#define RT5033_CHARGER_PRE_THRESHOLD_STEP_NUM	100000U
> +#define RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MAX	3800000U
> +
> +/*
> + * RT5033 charger enable UUG, If UUG enable MOS auto control by H/W =
charger
> + * circuit.
> + */
> +#define RT5033_CHARGER_UUG_ENABLE		0x02
> +
> +/* RT5033 charger High impedance mode */
> +#define RT5033_CHARGER_HZ_DISABLE		0x00
> +#define RT5033_CHARGER_HZ_ENABLE		0x01
> +
> +/* RT5033 regulator BUCK output voltage uV */
> +#define RT5033_REGULATOR_BUCK_VOLTAGE_MIN		1000000U
> +#define RT5033_REGULATOR_BUCK_VOLTAGE_MAX		3000000U
> +#define RT5033_REGULATOR_BUCK_VOLTAGE_STEP		100000U
> +#define RT5033_REGULATOR_BUCK_VOLTAGE_STEP_NUM		32
> +
> +/* RT5033 regulator LDO output voltage uV */
> +#define RT5033_REGULATOR_LDO_VOLTAGE_MIN		1200000U
> +#define RT5033_REGULATOR_LDO_VOLTAGE_MAX		3000000U
> +#define RT5033_REGULATOR_LDO_VOLTAGE_STEP		100000U
> +#define RT5033_REGULATOR_LDO_VOLTAGE_STEP_NUM		32
> +
> +/* RT5033 regulator SAFE LDO output voltage uV */
> +#define RT5033_REGULATOR_SAFE_LDO_VOLTAGE		4900000U
> +
> +enum rt5033_fuel_reg {
> +	RT5033_FUEL_REG_OCV_H		=3D 0x00,
> +	RT5033_FUEL_REG_OCV_L		=3D 0x01,
> +	RT5033_FUEL_REG_VBAT_H		=3D 0x02,
> +	RT5033_FUEL_REG_VBAT_L		=3D 0x03,
> +	RT5033_FUEL_REG_SOC_H		=3D 0x04,
> +	RT5033_FUEL_REG_SOC_L		=3D 0x05,
> +	RT5033_FUEL_REG_CTRL_H		=3D 0x06,
> +	RT5033_FUEL_REG_CTRL_L		=3D 0x07,
> +	RT5033_FUEL_REG_CRATE		=3D 0x08,
> +	RT5033_FUEL_REG_DEVICE_ID	=3D 0x09,
> +	RT5033_FUEL_REG_AVG_VOLT_H	=3D 0x0A,
> +	RT5033_FUEL_REG_AVG_VOLT_L	=3D 0x0B,
> +	RT5033_FUEL_REG_CONFIG_H	=3D 0x0C,
> +	RT5033_FUEL_REG_CONFIG_L	=3D 0x0D,
> +	/* Reserved 0x0E~0x0F */
> +	RT5033_FUEL_REG_IRQ_CTRL	=3D 0x10,
> +	RT5033_FUEL_REG_IRQ_FLAG	=3D 0x11,
> +	RT5033_FUEL_VMIN		=3D 0x12,
> +	RT5033_FUEL_SMIN		=3D 0x13,
> +	/* Reserved 0x14~0x1F */
> +	RT5033_FUEL_VGCOMP1		=3D 0x20,
> +	RT5033_FUEL_VGCOMP2		=3D 0x21,
> +	RT5033_FUEL_VGCOMP3		=3D 0x22,
> +	RT5033_FUEL_VGCOMP4		=3D 0x23,
> +	/* Reserved 0x24~0xFD */
> +	RT5033_FUEL_MFA_H		=3D 0xFE,
> +	RT5033_FUEL_MFA_L		=3D 0xFF,
> +
> +	RT5033_FUEL_REG_END,
> +};
> +
> +/* RT5033 fuel gauge battery present property */
> +#define RT5033_FUEL_BAT_PRESENT		0x02
> +
> +/* RT5033 PMIC interrupts */
> +#define RT5033_PMIC_IRQ_BUCKOCP		2
> +#define RT5033_PMIC_IRQ_BUCKLV		3
> +#define RT5033_PMIC_IRQ_SAFELDOLV	4
> +#define RT5033_PMIC_IRQ_LDOLV		5
> +#define RT5033_PMIC_IRQ_OT		6
> +#define RT5033_PMIC_IRQ_VDDA_UV		7
> +
> +#endif /* __RT5033_PRIVATE_H__ */
> diff --git a/include/linux/mfd/rt5033.h b/include/linux/mfd/rt5033.h
> new file mode 100644
> index 0000000..010cff4
> --- /dev/null
> +++ b/include/linux/mfd/rt5033.h
> @@ -0,0 +1,62 @@
> +/*
> + * MFD core driver for the RT5033
> + *
> + * Copyright (C) 2014 Samsung Electronics
> + * Author: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published bythe Free Software Foundation.
> + */
> +
> +#ifndef __RT5033_H__
> +#define __RT5033_H__
> +
> +#include <linux/regulator/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/power_supply.h>
> +
> +/* RT5033 regulator IDs */
> +enum rt5033_regulators {
> +	RT5033_BUCK =3D 0,
> +	RT5033_LDO,
> +	RT5033_SAFE_LDO,
> +
> +	RT5033_REGULATOR_NUM,
> +};
> +
> +struct rt5033_dev {
> +	struct device *dev;
> +
> +	struct regmap *regmap;
> +	struct regmap_irq_chip_data *irq_data;
> +	int irq;
> +	bool wakeup;
> +};
> +
> +struct rt5033_battery {
> +	struct i2c_client	*client;
> +	struct rt5033_dev	*rt5033;
> +	struct regmap		*regmap;
> +	struct power_supply	psy;
> +};
> +
> +/* RT5033 charger platform data */
> +struct rt5033_charger_data {
> +	unsigned int pre_uamp;
> +	unsigned int pre_uvolt;
> +	unsigned int const_uvolt;
> +	unsigned int eoc_uamp;
> +	unsigned int fast_uamp;
> +};
> +
> +struct rt5033_charger {
> +	struct device		*dev;
> +	struct rt5033_dev	*rt5033;
> +	struct power_supply	psy;
> +
> +	struct rt5033_charger_data	*chg;
> +};
> +
> +#endif /* __RT5033_H__ */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
