From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 1/4] thermal: uniphier: add UniPhier thermal driver
Date: Tue, 30 May 2017 18:21:42 +0900
Message-ID: <20170530182141.6865.4A936039@socionext.com>
References: <1496049345-14649-2-git-send-email-hayashi.kunihiko@socionext.com> <20170529164816.GA14822@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx.socionext.com ([202.248.49.38]:31800 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750902AbdE3JVp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 May 2017 05:21:45 -0400
In-Reply-To: <20170529164816.GA14822@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, yamada.masahiro@socionext.com, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org

Hi Eduardo,
Thank you for your comment.

On Mon, 29 May 2017 09:48:19 -0700 <edubezval@gmail.com> wrote:

> Knihiko,
> 
> On Mon, May 29, 2017 at 06:15:42PM +0900, Kunihiko Hayashi wrote:
> > Add a thermal driver for on-chip PVT (Process, Voltage and Temperature)
> > monitoring unit implemented on UniPhier SoCs. This driver supports
> > temperature monitoring and alert function.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  drivers/thermal/Kconfig            |   8 +
> >  drivers/thermal/Makefile           |   1 +
> >  drivers/thermal/uniphier_thermal.c | 390 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 399 insertions(+)
> >  create mode 100644 drivers/thermal/uniphier_thermal.c
> > 
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 776b343..93ccf25 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -453,4 +453,12 @@ config ZX2967_THERMAL
> >  	  the primitive temperature sensor embedded in zx2967 SoCs.
> >  	  This sensor generates the real time die temperature.
> >  
> > +config UNIPHIER_THERMAL
> > +	tristate "Socionext UniPhier thermal driver"
> > +	depends on ARCH_UNIPHIER || COMPILE_TEST
> > +	help
> > +	  Enable this to support thermal reporting on UniPhier SoC.
> > +	  This driver supports CPU thermal zone to reports the temperture
> > +	  and trip points.
> > +
> >  endif
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 7adae20..05b6e7c 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -58,3 +58,4 @@ obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> >  obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
> >  obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
> >  obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o
> > +obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
> > diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
> > new file mode 100644
> > index 0000000..ae7e5ce
> > --- /dev/null
> > +++ b/drivers/thermal/uniphier_thermal.c
> > @@ -0,0 +1,390 @@
> > +/**
> > + * uniphier_thermal.c - Socionext UniPhier thermal driver
> > + *
> > + * Copyright 2014 Panasonic Corporation
> > + * Copyright 2016 Socionext Inc.
> > + * All rights reserved.
> > + *
> > + * Author:
> > + *	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2  of
> > + * the License as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/thermal.h>
> > +
> > +#include "thermal_core.h"
> > +
> > +/*
> > + * block registers
> > + * addresses are the offset from .block_base
> > + */
> > +#define PVTCTLEN				0x0000
> > +#define PVTCTLEN_EN				BIT(0)
> > +
> > +#define PVTCTLMODE				0x0004
> > +#define PVTCTLMODE_MASK				0xf
> > +#define PVTCTLMODE_TEMPMON			0x5
> > +
> > +#define EMONREPEAT				0x0040
> > +#define EMONREPEAT_ENDLESS			BIT(24)
> > +#define EMONREPEAT_PERIOD			0xf
> > +#define EMONREPEAT_PERIOD_1000000		0x9
> > +
> > +/*
> > + * common registers
> > + * addresses are the offset from .map_base
> > + */
> > +#define PVTCTLSEL				0x0900
> > +#define PVTCTLSEL_MASK				0x7
> > +#define PVTCTLSEL_MONITOR			0
> > +
> > +#define SETALERT0				0x0910
> > +#define SETALERT1				0x0914
> > +#define SETALERT2				0x0918
> > +#define SETALERT_TEMP_OVF			(0xff << 16)
> > +#define SETALERT_TEMP_OVF_VALUE(val)		(((val) & 0xff) << 16)
> > +#define SETALERT_EN				BIT(0)
> > +
> > +#define PMALERTINTCTL				0x0920
> > +#define PMALERTINTCTL_CLR(ch)			BIT(4 * (ch) + 2)
> > +#define PMALERTINTCTL_SET(ch)			BIT(4 * (ch) + 1)
> > +#define PMALERTINTCTL_EN(ch)			BIT(4 * (ch) + 0)
> > +#define PMALERTINTCTL_MASK			0x777
> > +
> > +#define TMOD					0x0928
> > +#define TMOD_MASK				0x1ff
> > +
> > +#define TMODCOEF				0x0e5c
> > +
> > +#define TMODSETUP0_EN				BIT(30)
> > +#define TMODSETUP0_VAL(val)			(((val) & 0x3fff) << 16)
> > +#define TMODSETUP1_EN				BIT(15)
> > +#define TMODSETUP1_VAL(val)			((val) & 0x7fff)
> 
> 
> Maybe use use GENMASK for some of the above macros?

OK. I'll apply it.

> > +
> > +/* SoC critical temperature is 95 degrees Celsius */
> > +#define CRITICAL_TEMP_LIMIT			(95 * 1000)
> > +
> > +/* Max # of alert channels */
> > +#define ALERT_CH_NUM				3
> > +
> > +/* SoC specific thermal sensor data */
> > +struct uniphier_tm_soc_data {
> > +	u32 map_base;
> > +	u32 block_base;
> > +	u32 tmod_setup_addr;
> > +};
> > +
> > +struct uniphier_tm_dev {
> > +	struct regmap *regmap;
> > +	bool alert_en[ALERT_CH_NUM];
> > +	u32 tmod_calib0;
> > +	u32 tmod_calib1;
> > +	struct thermal_zone_device *tz_dev;
> > +	const struct uniphier_tm_soc_data *data;
> > +};
> > +
> > +static int uniphier_tm_initialize_sensor(struct uniphier_tm_dev *tdev)
> > +{
> > +	struct regmap *map = tdev->regmap;
> > +	u32 val;
> > +	int ret;
> > +
> > +	/* stop PVT */
> > +	regmap_write_bits(map,
> > +			  tdev->data->block_base + PVTCTLEN,
> > +			  PVTCTLEN_EN, 0);
> > +
> > +	/*
> > +	 * set default value if missing calibrated value
> > +	 *
> > +	 * Since SoC has a calibrated value that was set in advance,
> > +	 * TMODCOEF shows non-zero and PVT refers the value internally.
> > +	 *
> > +	 * However, there is the case that some SoCs might not have the
> > +	 * calibrated value. In that case, TMODCOEF shows zero and the driver
> > +	 * has to set default value manually.
> 
> Is this a common case or a corner case? Do we really need to care of it?
> 
> How accurate would be the sensor if it is missing calib values?
> 
> Should we let the user know?

It depends a kind of boards.

Production boards has always the calibrated value and PVT refers the value.
In this case, it isn't necessary that the driver sets the value.

Evaluation boards might not have the calibrated value, then
the driver should set the value.
In this case, the sensor can't work if the value isn't set.

> > +	 */
> > +	ret = regmap_read(map, tdev->data->map_base + TMODCOEF, &val);
> > +	if (ret)
> > +		return ret;
> > +	if (!val)
> > +		regmap_write(map,
> > +			     tdev->data->tmod_setup_addr,
> > +			     TMODSETUP0_EN |
> > +			     TMODSETUP0_VAL(tdev->tmod_calib0) |
> > +			     TMODSETUP1_EN |
> > +			     TMODSETUP1_VAL(tdev->tmod_calib1));
> > +
> > +	/* select temperature mode */
> > +	regmap_write_bits(map,
> > +			  tdev->data->block_base + PVTCTLMODE,
> > +			  PVTCTLMODE_MASK,
> > +			  PVTCTLMODE_TEMPMON);
> > +
> > +	/* set monitoring period */
> > +	regmap_write_bits(map,
> > +			  tdev->data->block_base + EMONREPEAT,
> > +			  EMONREPEAT_ENDLESS |
> > +			  EMONREPEAT_PERIOD,
> > +			  EMONREPEAT_ENDLESS |
> > +			  EMONREPEAT_PERIOD_1000000);
> > +
> > +	/* set monitor mode */
> > +	regmap_write_bits(map,
> > +			  tdev->data->map_base + PVTCTLSEL,
> > +			  PVTCTLSEL_MASK, PVTCTLSEL_MONITOR);
> > +
> > +	return 0;
> > +}
> > +
> > +static void uniphier_tm_set_alert(struct uniphier_tm_dev *tdev, u32 ch,
> > +				  u32 temp)
> 
> Does your sensor support negative values? The subsystem does.

The actual temperature value from the sensor can have negative value,
but "alert" temperature doesn't support negative value.

> > +{
> > +	struct regmap *map = tdev->regmap;
> > +
> > +	/* set alert temperature */
> > +	regmap_write_bits(map,
> > +			  tdev->data->map_base + SETALERT0 + (ch << 2),
> > +			  SETALERT_EN |
> > +			  SETALERT_TEMP_OVF,
> > +			  SETALERT_EN |
> > +			  SETALERT_TEMP_OVF_VALUE(temp / 1000));
> > +}
> > +
> > +static void uniphier_tm_enable_sensor(struct uniphier_tm_dev *tdev)
> > +{
> > +	struct regmap *map = tdev->regmap;
> > +	int i;
> > +	u32 bits = 0;
> > +
> > +	for (i = 0; i < ALERT_CH_NUM; i++)
> > +		if (tdev->alert_en[i])
> > +			bits |= PMALERTINTCTL_EN(i);
> > +
> > +	/* enable alert interrupt */
> > +	regmap_write_bits(map,
> > +			  tdev->data->map_base + PMALERTINTCTL,
> > +			  PMALERTINTCTL_MASK, bits);
> > +
> > +	/* start PVT */
> > +	regmap_write_bits(map,
> > +			  tdev->data->block_base + PVTCTLEN,
> > +			  PVTCTLEN_EN, PVTCTLEN_EN);
> > +}
> > +
> > +static void uniphier_tm_disable_sensor(struct uniphier_tm_dev *tdev)
> > +{
> > +	struct regmap *map = tdev->regmap;
> > +
> > +	/* disable alert interrupt */
> > +	regmap_write_bits(map,
> > +			  tdev->data->map_base + PMALERTINTCTL,
> > +			  PMALERTINTCTL_MASK, 0);
> > +
> > +	/* stop PVT */
> > +	regmap_write_bits(map,
> > +			  tdev->data->block_base + PVTCTLEN,
> > +			  PVTCTLEN_EN, 0);
> > +}
> > +
> > +static int uniphier_tm_get_temp(void *data, int *out_temp)
> > +{
> > +	struct uniphier_tm_dev *tdev = data;
> > +	struct regmap *map = tdev->regmap;
> > +	int ret;
> > +	u32 temp;
> > +
> > +	ret = regmap_read(map, tdev->data->map_base + TMOD, &temp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	temp &= TMOD_MASK;
> > +	*out_temp = temp * 1000;	/* millicelsius */
> > +
> 
> Are you sure you are not loosing in this conversion?

This sensor has only integer value of Celsius.
But this version doesn't consider negative value. I'll fix it.

> > +	return 0;
> > +}
> > +
> > +static const struct thermal_zone_of_device_ops uniphier_of_thermal_ops = {
> > +	.get_temp = uniphier_tm_get_temp,
> > +};
> > +
> > +static void uniphier_tm_irq_clear(struct uniphier_tm_dev *tdev)
> > +{
> > +	u32 mask = 0, bits = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < ALERT_CH_NUM; i++) {
> > +		mask |= (PMALERTINTCTL_CLR(i) |
> > +			 PMALERTINTCTL_SET(i));
> > +		bits |= PMALERTINTCTL_CLR(i);
> > +	}
> > +
> > +	/* clear alert interrupt */
> > +	regmap_write_bits(tdev->regmap,
> > +			  tdev->data->map_base + PMALERTINTCTL, mask, bits);
> > +}
> > +
> > +static irqreturn_t uniphier_tm_alarm_handler(int irq, void *_tdev)
> > +{
> > +	struct uniphier_tm_dev *tdev = _tdev;
> > +
> > +	uniphier_tm_irq_clear(tdev);
> > +	thermal_zone_device_update(tdev->tz_dev, THERMAL_EVENT_UNSPECIFIED);
> > +
> 
> This is executed in a top half, rigth? The above function uses mutexes
> and should not be called within atomic context.

I confirm other drivers again and I understand it.
I'll replace devm_request_irq() to devm_request_threaded_irq().

> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int uniphier_tm_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct regmap *regmap;
> > +	struct device_node *parent;
> > +	struct uniphier_tm_dev *tdev;
> > +	const struct thermal_trip *trips;
> > +	const u32 *calib;
> > +	int i, ret, irq, ntrips, crit_temp = INT_MAX;
> > +
> > +	tdev = devm_kzalloc(dev, sizeof(*tdev), GFP_KERNEL);
> > +	if (!tdev)
> > +		return -ENOMEM;
> > +
> > +	tdev->data = of_device_get_match_data(dev);
> > +	if (WARN_ON(!tdev->data))
> > +		return -EINVAL;
> > +
> > +	/* get irq */
> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq < 0)
> > +		return irq;
> > +
> > +	/* get tmod-calibration values */
> > +	calib = of_get_property(dev->of_node, "socionext,tmod-calibration",
> > +				NULL);
> > +	if (calib) {
> > +		tdev->tmod_calib0 = of_read_number(calib, 1);
> > +		tdev->tmod_calib1 = of_read_number(calib + 1, 1);
> > +	}
> > +
> > +	/* get regmap from syscon node */
> > +	parent = of_get_parent(dev->of_node); /* parent should be syscon node */
> > +	regmap = syscon_node_to_regmap(parent);
> > +	of_node_put(parent);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(dev, "failed to get regmap (error %ld)\n",
> > +			PTR_ERR(regmap));
> > +		return PTR_ERR(regmap);
> > +	}
> > +	tdev->regmap = regmap;
> > +
> > +	/* register sensor */
> > +	tdev->tz_dev = devm_thermal_zone_of_sensor_register(dev, 0, tdev,
> > +						&uniphier_of_thermal_ops);
> 
> From this point on, your driver should be ready to serve calls from the
> thermal subsystem. Looks like you are missing a lot of initialization,
> still to come from below, aren't you?. I would suggest moving the above
> registration further to a point when the sensor is ready to be used.

Indeed. I understand that all initialization to be used must be finished
before the driver calls devm_thermal_zone_of_sensor_register().


> > +	if (IS_ERR(tdev->tz_dev)) {
> > +		dev_err(dev, "failed to register sensor device\n");
> > +		return PTR_ERR(tdev->tz_dev);
> > +	}
> > +
> > +	/* get trip points */
> > +	trips = of_thermal_get_trip_points(tdev->tz_dev);
> > +	ntrips = of_thermal_get_ntrips(tdev->tz_dev);
> > +	if (ntrips > ALERT_CH_NUM) {
> > +		dev_err(dev, "thermal zone has too many trips\n");
> > +		return -E2BIG;
> > +	}
> > +
> > +	/* initialize sensor */
> > +	ret = uniphier_tm_initialize_sensor(tdev);
> > +	if (ret) {
> > +		dev_err(dev, "failed to initialize sensor\n");
> > +		return ret;
> > +	}
> > +	for (i = 0; i < ntrips; i++) {
> > +		if (trips[i].type == THERMAL_TRIP_CRITICAL &&
> > +		    trips[i].temperature < crit_temp)
> > +			crit_temp = trips[i].temperature;
> > +		uniphier_tm_set_alert(tdev, i, trips[i].temperature);
> > +		tdev->alert_en[i] = true;
> > +	}
> > +	if (crit_temp > CRITICAL_TEMP_LIMIT) {
> > +		dev_err(dev, "critical trip is over limit(>%d), or not set\n",
> > +			CRITICAL_TEMP_LIMIT);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = devm_request_irq(dev, irq, uniphier_tm_alarm_handler,
> > +			       0, "thermal", tdev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* enable sensor */
> > +	uniphier_tm_enable_sensor(tdev);
> > +
> > +	platform_set_drvdata(pdev, tdev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int uniphier_tm_remove(struct platform_device *pdev)
> > +{
> > +	struct uniphier_tm_dev *tdev = platform_get_drvdata(pdev);
> > +
> > +	/* disable sensor */
> > +	uniphier_tm_disable_sensor(tdev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct uniphier_tm_soc_data uniphier_pxs2_tm_data = {
> > +	.map_base        = 0xe000,
> > +	.block_base      = 0xe000,
> > +	.tmod_setup_addr = 0xe904,
> > +};
> > +
> > +static const struct uniphier_tm_soc_data uniphier_ld20_tm_data = {
> > +	.map_base        = 0xe000,
> > +	.block_base      = 0xe800,
> > +	.tmod_setup_addr = 0xe938,
> 
> Shouldn't these be in your device tree using the register properties?
> I see at least the map base as possible to be done in DT.

I think so.
However, the iomap of this device are included in sysctrl(simple-mfd),
and I can't find the method to express offset from base-address of sysctrl
on DT, instead of map_base, in resonable way.

I think that mfd node has register property then the lower node of mfd,
that is the thermal node, can't have register property.

If the driver gets offset address from DT, I'll define new property
like 'socionext,reg_offset' in the thermal node. But I'm not sure that.

> > +};
> > +
> > +static const struct of_device_id uniphier_tm_dt_ids[] = {
> > +	{
> > +		.compatible = "socionext,uniphier-pxs2-thermal",
> > +		.data       = &uniphier_pxs2_tm_data,
> > +	},
> > +	{
> > +		.compatible = "socionext,uniphier-ld20-thermal",
> > +		.data       = &uniphier_ld20_tm_data,
> > +	},
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, uniphier_tm_dt_ids);
> > +
> > +static struct platform_driver uniphier_tm_driver = {
> > +	.probe = uniphier_tm_probe,
> > +	.remove = uniphier_tm_remove,
> > +	.driver = {
> > +		.name = "uniphier-thermal",
> > +		.of_match_table = uniphier_tm_dt_ids,
> > +	},
> > +};
> > +module_platform_driver(uniphier_tm_driver);
> > +
> > +MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
> > +MODULE_DESCRIPTION("UniPhier thermal driver");
> > +MODULE_LICENSE("GPL v2");
> > -- 
> > 2.7.4
> > 

Best Regards,
Kunihiko Hayashi
