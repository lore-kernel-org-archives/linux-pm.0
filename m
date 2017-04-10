From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH v4] iio: adc: add support for
 X-Powers AXP20X and AXP22X PMICs ADCs
Date: Mon, 10 Apr 2017 15:54:45 +0100
Message-ID: <20170410145445.ngfjau2dtjvquspg@dell>
References: <20170404063441.7656-1-quentin.schulz@free-electrons.com>
 <cf07853a-4382-5172-b24f-5324fb4308d3@free-electrons.com>
Reply-To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBBOVZV3DQKGQEXPZTP5Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <cf07853a-4382-5172-b24f-5324fb4308d3-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, 10 Apr 2017, Quentin Schulz wrote:

> Hi Lee,
>=20
> Just to make sure you didn't miss that patch (can't find it in
> for-mfd-next and for-mfd-next-next).

It has not been missed, but is yet to be reviewed.

> On 04/04/2017 08:34, Quentin Schulz wrote:
> > The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose th=
e
> > battery voltage, battery charge and discharge currents, AC-in and VBUS
> > voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature=
.
> >=20
> > This adds support for most of AXP20X and AXP22X ADCs.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > Acked-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> > Reviewed-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >=20
> > Lee, could you merge this through the mfd tree please?
> >  =3D> https://lkml.org/lkml/2017/3/22/47
> >=20
> > v4:
> >  - added missing space at the beginning of a comment,
> >  - tidied axp20x_adc_offset_voltage and axp20x_write_raw to use switch =
case
> >  instead of if conditions,
> >  - added MODULE_DEVICE_TABLE for axp20x_adc_id_match for module autoloa=
ding,
> >  - merged two lines in axp20x_remove,
> >=20
> > v3:
> >  - moved from switch to if condition in axp20x_adc_raw and
> >  axp22x_adc_raw,
> >  - removed DT support as DT node has been dropped,
> >    - use of platform_device_id
> >  - correctly defined the name of the iio device (name used to probe the
> >  driver),
> >  - added goto for errors in probe,
> >  - added iio_map_array_unregister to the remove function,
> >=20
> > v2:
> >  - removed unused defines,
> >  - changed BIT(x) to 1 << x when describing bits purpose for which 2 <<
> >  x or 3 << x exists, to be consistent,
> >  - changed ADC rate defines to macro formulas,
> >  - reordered IIO channels, now different measures (current/voltage) of
> >  the same part of the PMIC (e.g. battery), have the same IIO channel in
> >  their respective IIO type. When a part of the PMIC have only one
> >  measure, a number is jumped,
> >  - left IIO channel mapping in DT to use iio_map structure,
> >  - removed indexing of ADC internal temperature,
> >  - removed unused iio_dev structure in axp20x_adc_iio,
> >  - added a structure for data specific to AXP20X or AXP22X PMICs instea=
d
> >  of using an ID and an if condition when needing to separate the
> >  behaviour of both,
> >  - added a comment on batt_chrg_i really being on 12bits rather than
> >  what the Chinese datasheets say (13 bits),
> >  - corrected the offset for AXP22X PMIC temperature,
> >  - set the ADC rate to a value (100Hz) shared by the AXP20X and AXP22X,
> >  - created macro formulas to compute the ADC rate for each,
> >  - added a condition on presence of ADC_EN2 reg before setting/resettin=
g
> >  it,
> >  - switched from devm_iio_device_unregister to the non-devm function
> >  because of the need for a remove function,
> >  - removed some dead code,
> >=20
> >  drivers/iio/adc/Kconfig      |  10 +
> >  drivers/iio/adc/Makefile     |   1 +
> >  drivers/iio/adc/axp20x_adc.c | 617 +++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 628 insertions(+)
> >  create mode 100644 drivers/iio/adc/axp20x_adc.c
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index d777a97..d15e1bd 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -154,6 +154,16 @@ config AT91_SAMA5D2_ADC
> >  	  To compile this driver as a module, choose M here: the module will =
be
> >  	  called at91-sama5d2_adc.
> > =20
> > +config AXP20X_ADC
> > +	tristate "X-Powers AXP20X and AXP22X ADC driver"
> > +	depends on MFD_AXP20X
> > +	help
> > +	  Say yes here to have support for X-Powers power management IC (PMIC=
)
> > +	  AXP20X and AXP22X ADC devices.
> > +
> > +	  To compile this driver as a module, choose M here: the module will =
be
> > +	  called axp20x_adc.
> > +
> >  config AXP288_ADC
> >  	tristate "X-Powers AXP288 ADC driver"
> >  	depends on MFD_AXP20X
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index b11bb57..17899b5 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -16,6 +16,7 @@ obj-$(CONFIG_AD7887) +=3D ad7887.o
> >  obj-$(CONFIG_AD799X) +=3D ad799x.o
> >  obj-$(CONFIG_AT91_ADC) +=3D at91_adc.o
> >  obj-$(CONFIG_AT91_SAMA5D2_ADC) +=3D at91-sama5d2_adc.o
> > +obj-$(CONFIG_AXP20X_ADC) +=3D axp20x_adc.o
> >  obj-$(CONFIG_AXP288_ADC) +=3D axp288_adc.o
> >  obj-$(CONFIG_BCM_IPROC_ADC) +=3D bcm_iproc_adc.o
> >  obj-$(CONFIG_BERLIN2_ADC) +=3D berlin2-adc.o
> > diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.=
c
> > new file mode 100644
> > index 0000000..11e1771
> > --- /dev/null
> > +++ b/drivers/iio/adc/axp20x_adc.c
> > @@ -0,0 +1,617 @@
> > +/* ADC driver for AXP20X and AXP22X PMICs
> > + *
> > + * Copyright (c) 2016 Free Electrons NextThing Co.
> > + *	Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it under
> > + * the terms of the GNU General Public License version 2 as published =
by the
> > + * Free Software Foundation.
> > + */
> > +
> > +#include <linux/completion.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <linux/thermal.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/driver.h>
> > +#include <linux/iio/machine.h>
> > +#include <linux/mfd/axp20x.h>
> > +
> > +#define AXP20X_ADC_EN1_MASK			GENMASK(7, 0)
> > +
> > +#define AXP20X_ADC_EN2_MASK			(GENMASK(3, 2) | BIT(7))
> > +#define AXP22X_ADC_EN1_MASK			(GENMASK(7, 5) | BIT(0))
> > +
> > +#define AXP20X_GPIO10_IN_RANGE_GPIO0		BIT(0)
> > +#define AXP20X_GPIO10_IN_RANGE_GPIO1		BIT(1)
> > +#define AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(x)	((x) & BIT(0))
> > +#define AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(x)	(((x) & BIT(0)) << 1)
> > +
> > +#define AXP20X_ADC_RATE_MASK			GENMASK(7, 6)
> > +#define AXP20X_ADC_RATE_HZ(x)			((ilog2((x) / 25) << 6) & AXP20X_ADC_R=
ATE_MASK)
> > +#define AXP22X_ADC_RATE_HZ(x)			((ilog2((x) / 100) << 6) & AXP20X_ADC_=
RATE_MASK)
> > +
> > +#define AXP20X_ADC_CHANNEL(_channel, _name, _type, _reg)	\
> > +	{							\
> > +		.type =3D _type,					\
> > +		.indexed =3D 1,					\
> > +		.channel =3D _channel,				\
> > +		.address =3D _reg,				\
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |	\
> > +				      BIT(IIO_CHAN_INFO_SCALE),	\
> > +		.datasheet_name =3D _name,			\
> > +	}
> > +
> > +#define AXP20X_ADC_CHANNEL_OFFSET(_channel, _name, _type, _reg) \
> > +	{							\
> > +		.type =3D _type,					\
> > +		.indexed =3D 1,					\
> > +		.channel =3D _channel,				\
> > +		.address =3D _reg,				\
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |	\
> > +				      BIT(IIO_CHAN_INFO_SCALE) |\
> > +				      BIT(IIO_CHAN_INFO_OFFSET),\
> > +		.datasheet_name =3D _name,			\
> > +	}
> > +
> > +struct axp_data;
> > +
> > +struct axp20x_adc_iio {
> > +	struct regmap		*regmap;
> > +	struct axp_data		*data;
> > +};
> > +
> > +enum axp20x_adc_channel_v {
> > +	AXP20X_ACIN_V =3D 0,
> > +	AXP20X_VBUS_V,
> > +	AXP20X_TS_IN,
> > +	AXP20X_GPIO0_V,
> > +	AXP20X_GPIO1_V,
> > +	AXP20X_IPSOUT_V,
> > +	AXP20X_BATT_V,
> > +};
> > +
> > +enum axp20x_adc_channel_i {
> > +	AXP20X_ACIN_I =3D 0,
> > +	AXP20X_VBUS_I,
> > +	AXP20X_BATT_CHRG_I,
> > +	AXP20X_BATT_DISCHRG_I,
> > +};
> > +
> > +enum axp22x_adc_channel_v {
> > +	AXP22X_TS_IN =3D 0,
> > +	AXP22X_BATT_V,
> > +};
> > +
> > +enum axp22x_adc_channel_i {
> > +	AXP22X_BATT_CHRG_I =3D 1,
> > +	AXP22X_BATT_DISCHRG_I,
> > +};
> > +
> > +static struct iio_map axp20x_maps[] =3D {
> > +	{
> > +		.consumer_dev_name =3D "axp20x-usb-power-supply",
> > +		.consumer_channel =3D "vbus_v",
> > +		.adc_channel_label =3D "vbus_v",
> > +	}, {
> > +		.consumer_dev_name =3D "axp20x-usb-power-supply",
> > +		.consumer_channel =3D "vbus_i",
> > +		.adc_channel_label =3D "vbus_i",
> > +	}, {
> > +		.consumer_dev_name =3D "axp20x-ac-power-supply",
> > +		.consumer_channel =3D "acin_v",
> > +		.adc_channel_label =3D "acin_v",
> > +	}, {
> > +		.consumer_dev_name =3D "axp20x-ac-power-supply",
> > +		.consumer_channel =3D "acin_i",
> > +		.adc_channel_label =3D "acin_i",
> > +	}, {
> > +		.consumer_dev_name =3D "axp20x-battery-power-supply",
> > +		.consumer_channel =3D "batt_v",
> > +		.adc_channel_label =3D "batt_v",
> > +	}, {
> > +		.consumer_dev_name =3D "axp20x-battery-power-supply",
> > +		.consumer_channel =3D "batt_chrg_i",
> > +		.adc_channel_label =3D "batt_chrg_i",
> > +	}, {
> > +		.consumer_dev_name =3D "axp20x-battery-power-supply",
> > +		.consumer_channel =3D "batt_dischrg_i",
> > +		.adc_channel_label =3D "batt_dischrg_i",
> > +	}, { /* sentinel */ }
> > +};
> > +
> > +static struct iio_map axp22x_maps[] =3D {
> > +	{
> > +		.consumer_dev_name =3D "axp20x-battery-power-supply",
> > +		.consumer_channel =3D "batt_v",
> > +		.adc_channel_label =3D "batt_v",
> > +	}, {
> > +		.consumer_dev_name =3D "axp20x-battery-power-supply",
> > +		.consumer_channel =3D "batt_chrg_i",
> > +		.adc_channel_label =3D "batt_chrg_i",
> > +	}, {
> > +		.consumer_dev_name =3D "axp20x-battery-power-supply",
> > +		.consumer_channel =3D "batt_dischrg_i",
> > +		.adc_channel_label =3D "batt_dischrg_i",
> > +	}, { /* sentinel */ }
> > +};
> > +
> > +/*
> > + * Channels are mapped by physical system. Their channels share the sa=
me index.
> > + * i.e. acin_i is in_current0_raw and acin_v is in_voltage0_raw.
> > + * The only exception is for the battery. batt_v will be in_voltage6_r=
aw and
> > + * charge current in_current6_raw and discharge current will be in_cur=
rent7_raw.
> > + */
> > +static const struct iio_chan_spec axp20x_adc_channels[] =3D {
> > +	AXP20X_ADC_CHANNEL(AXP20X_ACIN_V, "acin_v", IIO_VOLTAGE,
> > +			   AXP20X_ACIN_V_ADC_H),
> > +	AXP20X_ADC_CHANNEL(AXP20X_ACIN_I, "acin_i", IIO_CURRENT,
> > +			   AXP20X_ACIN_I_ADC_H),
> > +	AXP20X_ADC_CHANNEL(AXP20X_VBUS_V, "vbus_v", IIO_VOLTAGE,
> > +			   AXP20X_VBUS_V_ADC_H),
> > +	AXP20X_ADC_CHANNEL(AXP20X_VBUS_I, "vbus_i", IIO_CURRENT,
> > +			   AXP20X_VBUS_I_ADC_H),
> > +	{
> > +		.type =3D IIO_TEMP,
> > +		.address =3D AXP20X_TEMP_ADC_H,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> > +				      BIT(IIO_CHAN_INFO_OFFSET),
> > +		.datasheet_name =3D "pmic_temp",
> > +	},
> > +	AXP20X_ADC_CHANNEL_OFFSET(AXP20X_GPIO0_V, "gpio0_v", IIO_VOLTAGE,
> > +				  AXP20X_GPIO0_V_ADC_H),
> > +	AXP20X_ADC_CHANNEL_OFFSET(AXP20X_GPIO1_V, "gpio1_v", IIO_VOLTAGE,
> > +				  AXP20X_GPIO1_V_ADC_H),
> > +	AXP20X_ADC_CHANNEL(AXP20X_IPSOUT_V, "ipsout_v", IIO_VOLTAGE,
> > +			   AXP20X_IPSOUT_V_HIGH_H),
> > +	AXP20X_ADC_CHANNEL(AXP20X_BATT_V, "batt_v", IIO_VOLTAGE,
> > +			   AXP20X_BATT_V_H),
> > +	AXP20X_ADC_CHANNEL(AXP20X_BATT_CHRG_I, "batt_chrg_i", IIO_CURRENT,
> > +			   AXP20X_BATT_CHRG_I_H),
> > +	AXP20X_ADC_CHANNEL(AXP20X_BATT_DISCHRG_I, "batt_dischrg_i", IIO_CURRE=
NT,
> > +			   AXP20X_BATT_DISCHRG_I_H),
> > +};
> > +
> > +static const struct iio_chan_spec axp22x_adc_channels[] =3D {
> > +	{
> > +		.type =3D IIO_TEMP,
> > +		.address =3D AXP22X_PMIC_TEMP_H,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE) |
> > +				      BIT(IIO_CHAN_INFO_OFFSET),
> > +		.datasheet_name =3D "pmic_temp",
> > +	},
> > +	AXP20X_ADC_CHANNEL(AXP22X_BATT_V, "batt_v", IIO_VOLTAGE,
> > +			   AXP20X_BATT_V_H),
> > +	AXP20X_ADC_CHANNEL(AXP22X_BATT_CHRG_I, "batt_chrg_i", IIO_CURRENT,
> > +			   AXP20X_BATT_CHRG_I_H),
> > +	AXP20X_ADC_CHANNEL(AXP22X_BATT_DISCHRG_I, "batt_dischrg_i", IIO_CURRE=
NT,
> > +			   AXP20X_BATT_DISCHRG_I_H),
> > +};
> > +
> > +static int axp20x_adc_raw(struct iio_dev *indio_dev,
> > +			  struct iio_chan_spec const *chan, int *val)
> > +{
> > +	struct axp20x_adc_iio *info =3D iio_priv(indio_dev);
> > +	int size =3D 12;
> > +
> > +	/*
> > +	 * N.B.:  Unlike the Chinese datasheets tell, the charging current is
> > +	 * stored on 12 bits, not 13 bits. Only discharging current is on 13
> > +	 * bits.
> > +	 */
> > +	if (chan->type =3D=3D IIO_CURRENT && chan->channel =3D=3D AXP20X_BATT=
_DISCHRG_I)
> > +		size =3D 13;
> > +	else
> > +		size =3D 12;
> > +
> > +	*val =3D axp20x_read_variable_width(info->regmap, chan->address, size=
);
> > +	if (*val < 0)
> > +		return *val;
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int axp22x_adc_raw(struct iio_dev *indio_dev,
> > +			  struct iio_chan_spec const *chan, int *val)
> > +{
> > +	struct axp20x_adc_iio *info =3D iio_priv(indio_dev);
> > +	int size;
> > +
> > +	/*
> > +	 * N.B.: Unlike the Chinese datasheets tell, the charging current is
> > +	 * stored on 12 bits, not 13 bits. Only discharging current is on 13
> > +	 * bits.
> > +	 */
> > +	if (chan->type =3D=3D IIO_CURRENT && chan->channel =3D=3D AXP22X_BATT=
_DISCHRG_I)
> > +		size =3D 13;
> > +	else
> > +		size =3D 12;
> > +
> > +	*val =3D axp20x_read_variable_width(info->regmap, chan->address, size=
);
> > +	if (*val < 0)
> > +		return *val;
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int axp20x_adc_scale_voltage(int channel, int *val, int *val2)
> > +{
> > +	switch (channel) {
> > +	case AXP20X_ACIN_V:
> > +	case AXP20X_VBUS_V:
> > +		*val =3D 1;
> > +		*val2 =3D 700000;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	case AXP20X_GPIO0_V:
> > +	case AXP20X_GPIO1_V:
> > +		*val =3D 0;
> > +		*val2 =3D 500000;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	case AXP20X_BATT_V:
> > +		*val =3D 1;
> > +		*val2 =3D 100000;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	case AXP20X_IPSOUT_V:
> > +		*val =3D 1;
> > +		*val2 =3D 400000;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int axp20x_adc_scale_current(int channel, int *val, int *val2)
> > +{
> > +	switch (channel) {
> > +	case AXP20X_ACIN_I:
> > +		*val =3D 0;
> > +		*val2 =3D 625000;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	case AXP20X_VBUS_I:
> > +		*val =3D 0;
> > +		*val2 =3D 375000;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	case AXP20X_BATT_DISCHRG_I:
> > +	case AXP20X_BATT_CHRG_I:
> > +		*val =3D 0;
> > +		*val2 =3D 500000;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int axp20x_adc_scale(struct iio_chan_spec const *chan, int *val=
,
> > +			    int *val2)
> > +{
> > +	switch (chan->type) {
> > +	case IIO_VOLTAGE:
> > +		return axp20x_adc_scale_voltage(chan->channel, val, val2);
> > +
> > +	case IIO_CURRENT:
> > +		return axp20x_adc_scale_current(chan->channel, val, val2);
> > +
> > +	case IIO_TEMP:
> > +		*val =3D 100;
> > +		return IIO_VAL_INT;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int axp22x_adc_scale(struct iio_chan_spec const *chan, int *val=
,
> > +			    int *val2)
> > +{
> > +	switch (chan->type) {
> > +	case IIO_VOLTAGE:
> > +		if (chan->channel !=3D AXP22X_BATT_V)
> > +			return -EINVAL;
> > +
> > +		*val =3D 1;
> > +		*val2 =3D 100000;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	case IIO_CURRENT:
> > +		*val =3D 0;
> > +		*val2 =3D 500000;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	case IIO_TEMP:
> > +		*val =3D 100;
> > +		return IIO_VAL_INT;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int ch=
annel,
> > +				     int *val)
> > +{
> > +	struct axp20x_adc_iio *info =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret =3D regmap_read(info->regmap, AXP20X_GPIO10_IN_RANGE, val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	switch (channel) {
> > +	case AXP20X_GPIO0_V:
> > +		*val &=3D AXP20X_GPIO10_IN_RANGE_GPIO0;
> > +		break;
> > +
> > +	case AXP20X_GPIO1_V:
> > +		*val &=3D AXP20X_GPIO10_IN_RANGE_GPIO1;
> > +		break;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	*val =3D !!(*val) * 700000;
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int axp20x_adc_offset(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan, int *val)
> > +{
> > +	switch (chan->type) {
> > +	case IIO_VOLTAGE:
> > +		return axp20x_adc_offset_voltage(indio_dev, chan->channel, val);
> > +
> > +	case IIO_TEMP:
> > +		*val =3D -1447;
> > +		return IIO_VAL_INT;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int axp20x_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan, int *val,
> > +			   int *val2, long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		return axp20x_adc_offset(indio_dev, chan, val);
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		return axp20x_adc_scale(chan, val, val2);
> > +
> > +	case IIO_CHAN_INFO_RAW:
> > +		return axp20x_adc_raw(indio_dev, chan, val);
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int axp22x_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan, int *val,
> > +			   int *val2, long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		*val =3D -2677;
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		return axp22x_adc_scale(chan, val, val2);
> > +
> > +	case IIO_CHAN_INFO_RAW:
> > +		return axp22x_adc_raw(indio_dev, chan, val);
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int axp20x_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, int val, int val2,
> > +			    long mask)
> > +{
> > +	struct axp20x_adc_iio *info =3D iio_priv(indio_dev);
> > +	unsigned int reg, regval;
> > +
> > +	/*
> > +	 * The AXP20X PMIC allows the user to choose between 0V and 0.7V offs=
ets
> > +	 * for (independently) GPIO0 and GPIO1 when in ADC mode.
> > +	 */
> > +	if (mask !=3D IIO_CHAN_INFO_OFFSET)
> > +		return -EINVAL;
> > +
> > +	if (val !=3D 0 && val !=3D 700000)
> > +		return -EINVAL;
> > +
> > +	switch (chan->channel) {
> > +	case AXP20X_GPIO0_V:
> > +		reg =3D AXP20X_GPIO10_IN_RANGE_GPIO0;
> > +		regval =3D AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(!!val);
> > +		break;
> > +
> > +	case AXP20X_GPIO1_V:
> > +		reg =3D AXP20X_GPIO10_IN_RANGE_GPIO1;
> > +		regval =3D AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(!!val);
> > +		break;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, reg,
> > +				  regval);
> > +}
> > +
> > +static const struct iio_info axp20x_adc_iio_info =3D {
> > +	.read_raw =3D axp20x_read_raw,
> > +	.write_raw =3D axp20x_write_raw,
> > +	.driver_module =3D THIS_MODULE,
> > +};
> > +
> > +static const struct iio_info axp22x_adc_iio_info =3D {
> > +	.read_raw =3D axp22x_read_raw,
> > +	.driver_module =3D THIS_MODULE,
> > +};
> > +
> > +static int axp20x_adc_rate(int rate)
> > +{
> > +	return AXP20X_ADC_RATE_HZ(rate);
> > +}
> > +
> > +static int axp22x_adc_rate(int rate)
> > +{
> > +	return AXP22X_ADC_RATE_HZ(rate);
> > +}
> > +
> > +struct axp_data {
> > +	const struct iio_info		*iio_info;
> > +	int				num_channels;
> > +	struct iio_chan_spec const	*channels;
> > +	unsigned long			adc_en1_mask;
> > +	int				(*adc_rate)(int rate);
> > +	bool				adc_en2;
> > +	struct iio_map			*maps;
> > +};
> > +
> > +static const struct axp_data axp20x_data =3D {
> > +	.iio_info =3D &axp20x_adc_iio_info,
> > +	.num_channels =3D ARRAY_SIZE(axp20x_adc_channels),
> > +	.channels =3D axp20x_adc_channels,
> > +	.adc_en1_mask =3D AXP20X_ADC_EN1_MASK,
> > +	.adc_rate =3D axp20x_adc_rate,
> > +	.adc_en2 =3D true,
> > +	.maps =3D axp20x_maps,
> > +};
> > +
> > +static const struct axp_data axp22x_data =3D {
> > +	.iio_info =3D &axp22x_adc_iio_info,
> > +	.num_channels =3D ARRAY_SIZE(axp22x_adc_channels),
> > +	.channels =3D axp22x_adc_channels,
> > +	.adc_en1_mask =3D AXP22X_ADC_EN1_MASK,
> > +	.adc_rate =3D axp22x_adc_rate,
> > +	.adc_en2 =3D false,
> > +	.maps =3D axp22x_maps,
> > +};
> > +
> > +static const struct platform_device_id axp20x_adc_id_match[] =3D {
> > +	{ .name =3D "axp20x-adc", .driver_data =3D (kernel_ulong_t)&axp20x_da=
ta, },
> > +	{ .name =3D "axp22x-adc", .driver_data =3D (kernel_ulong_t)&axp22x_da=
ta, },
> > +	{ /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(platform, axp20x_adc_id_match);
> > +
> > +static int axp20x_probe(struct platform_device *pdev)
> > +{
> > +	struct axp20x_adc_iio *info;
> > +	struct iio_dev *indio_dev;
> > +	struct axp20x_dev *axp20x_dev;
> > +	int ret;
> > +
> > +	axp20x_dev =3D dev_get_drvdata(pdev->dev.parent);
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	info =3D iio_priv(indio_dev);
> > +	platform_set_drvdata(pdev, indio_dev);
> > +
> > +	info->regmap =3D axp20x_dev->regmap;
> > +	indio_dev->dev.parent =3D &pdev->dev;
> > +	indio_dev->dev.of_node =3D pdev->dev.of_node;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +	info->data =3D (struct axp_data *)platform_get_device_id(pdev)->drive=
r_data;
> > +
> > +	indio_dev->name =3D platform_get_device_id(pdev)->name;
> > +	indio_dev->info =3D info->data->iio_info;
> > +	indio_dev->num_channels =3D info->data->num_channels;
> > +	indio_dev->channels =3D info->data->channels;
> > +
> > +	/* Enable the ADCs on IP */
> > +	regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
> > +
> > +	if (info->data->adc_en2)
> > +		/* Enable GPIO0/1 and internal temperature ADCs */
> > +		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
> > +				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
> > +
> > +	/* Configure ADCs rate */
> > +	regmap_update_bits(info->regmap, AXP20X_ADC_RATE, AXP20X_ADC_RATE_MAS=
K,
> > +			   info->data->adc_rate(100));
> > +
> > +	ret =3D iio_map_array_register(indio_dev, info->data->maps);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to register IIO maps: %d\n", ret);
> > +		goto fail_map;
> > +	}
> > +
> > +	ret =3D iio_device_register(indio_dev);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "could not register the device\n");
> > +		goto fail_register;
> > +	}
> > +
> > +	return 0;
> > +
> > +fail_register:
> > +	iio_map_array_unregister(indio_dev);
> > +
> > +fail_map:
> > +	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
> > +
> > +	if (info->data->adc_en2)
> > +		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
> > +
> > +	return ret;
> > +}
> > +
> > +static int axp20x_remove(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> > +	struct axp20x_adc_iio *info =3D iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +	iio_map_array_unregister(indio_dev);
> > +
> > +	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
> > +
> > +	if (info->data->adc_en2)
> > +		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver axp20x_adc_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "axp20x-adc",
> > +	},
> > +	.id_table =3D axp20x_adc_id_match,
> > +	.probe =3D axp20x_probe,
> > +	.remove =3D axp20x_remove,
> > +};
> > +
> > +module_platform_driver(axp20x_adc_driver);
> > +
> > +MODULE_DESCRIPTION("ADC driver for AXP20X and AXP22X PMICs");
> > +MODULE_AUTHOR("Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>");
> > +MODULE_LICENSE("GPL");
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
