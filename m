From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 5/7] power: supply: add Ingenic JZ47xx battery driver.
Date: Sun, 3 Mar 2019 16:53:03 +0000
Message-ID: <20190303165303.5e5c07bd@archlinux>
References: <20190217142914.17433-1-contact@artur-rojek.eu>
        <20190217142914.17433-5-contact@artur-rojek.eu>
        <20190220111441.585eb3eb@archlinux>
        <a53ba58dddea94c011d2ec839d438c51@artur-rojek.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a53ba58dddea94c011d2ec839d438c51@artur-rojek.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 21 Feb 2019 20:18:36 +0100
Artur Rojek <contact@artur-rojek.eu> wrote:

> On 2019-02-20 12:14, Jonathan Cameron wrote:
> > On Sun, 17 Feb 2019 15:29:14 +0100
> > Artur Rojek <contact@artur-rojek.eu> wrote:
> >   
> >> Add a driver for battery present on Ingenic JZ47xx SoCs.
> >> 
> >> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>  
> > A few things inline.
> > 
> > thanks,
> > 
> > Jonathan  
> Hi Jonathan.
> 
> One thing inline.
> 
> Artur
> >   
> >> ---
> >>  drivers/power/supply/Kconfig           |  11 ++
> >>  drivers/power/supply/Makefile          |   1 +
> >>  drivers/power/supply/ingenic-battery.c | 182 
> >> +++++++++++++++++++++++++
> >>  3 files changed, 194 insertions(+)
> >>  create mode 100644 drivers/power/supply/ingenic-battery.c
> >> 
> >> diff --git a/drivers/power/supply/Kconfig 
> >> b/drivers/power/supply/Kconfig
> >> index e901b9879e7e..9bfb1637ec28 100644
> >> --- a/drivers/power/supply/Kconfig
> >> +++ b/drivers/power/supply/Kconfig
> >> @@ -169,6 +169,17 @@ config BATTERY_COLLIE
> >>  	  Say Y to enable support for the battery on the Sharp Zaurus
> >>  	  SL-5500 (collie) models.
> >> 
> >> +config BATTERY_INGENIC
> >> +	tristate "Ingenic JZ47xx SoCs battery driver"
> >> +	depends on MIPS || COMPILE_TEST
> >> +	depends on INGENIC_ADC
> >> +	help
> >> +	  Choose this option if you want to monitor battery status on
> >> +	  Ingenic JZ47xx SoC based devices.
> >> +
> >> +	  This driver can also be built as a module. If so, the module will 
> >> be
> >> +	  called ingenic-battery.
> >> +
> >>  config BATTERY_IPAQ_MICRO
> >>  	tristate "iPAQ Atmel Micro ASIC battery driver"
> >>  	depends on MFD_IPAQ_MICRO
> >> diff --git a/drivers/power/supply/Makefile 
> >> b/drivers/power/supply/Makefile
> >> index b731c2a9b695..9e2c481d0187 100644
> >> --- a/drivers/power/supply/Makefile
> >> +++ b/drivers/power/supply/Makefile
> >> @@ -34,6 +34,7 @@ obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
> >>  obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
> >>  obj-$(CONFIG_BATTERY_TOSA)	+= tosa_battery.o
> >>  obj-$(CONFIG_BATTERY_COLLIE)	+= collie_battery.o
> >> +obj-$(CONFIG_BATTERY_INGENIC)	+= ingenic-battery.o
> >>  obj-$(CONFIG_BATTERY_IPAQ_MICRO) += ipaq_micro_battery.o
> >>  obj-$(CONFIG_BATTERY_WM97XX)	+= wm97xx_battery.o
> >>  obj-$(CONFIG_BATTERY_SBS)	+= sbs-battery.o
> >> diff --git a/drivers/power/supply/ingenic-battery.c 
> >> b/drivers/power/supply/ingenic-battery.c
> >> new file mode 100644
> >> index 000000000000..4ee75c1ac241
> >> --- /dev/null
> >> +++ b/drivers/power/supply/ingenic-battery.c
> >> @@ -0,0 +1,182 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Battery driver for the Ingenic JZ47xx SoCs
> >> + * Copyright (c) 2019 Artur Rojek <contact@artur-rojek.eu>
> >> + *
> >> + * based on drivers/power/supply/jz4740-battery.c  
> > 
> > What is the relationship between this driver and the older one?
> >   
> >> + */
> >> +
> >> +#include <linux/iio/consumer.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/power_supply.h>
> >> +#include <linux/property.h>
> >> +
> >> +struct ingenic_battery {
> >> +	struct device *dev;
> >> +	struct iio_channel *channel;
> >> +	struct power_supply_desc desc;
> >> +	struct power_supply *battery;
> >> +	struct power_supply_battery_info info;
> >> +};
> >> +
> >> +static int ingenic_battery_get_property(struct power_supply *psy,
> >> +					enum power_supply_property psp,
> >> +					union power_supply_propval *val)
> >> +{
> >> +	struct ingenic_battery *bat = power_supply_get_drvdata(psy);
> >> +	struct power_supply_battery_info *info = &bat->info;
> >> +	int ret = 0;
> >> +
> >> +	switch (psp) {
> >> +	case POWER_SUPPLY_PROP_HEALTH:
> >> +		ret = iio_read_channel_processed(bat->channel, &val->intval);
> >> +		val->intval *= 1000;
> >> +		if (val->intval < info->voltage_min_design_uv)
> >> +			val->intval = POWER_SUPPLY_HEALTH_DEAD;
> >> +		else if (val->intval > info->voltage_max_design_uv)
> >> +			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> >> +		else
> >> +			val->intval = POWER_SUPPLY_HEALTH_GOOD;
> >> +	break;
> >> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> >> +		ret = iio_read_channel_processed(bat->channel, &val->intval);
> >> +		val->intval *= 1000;
> >> +	break;
> >> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> >> +		val->intval = info->voltage_min_design_uv;
> >> +	break;
> >> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> >> +		val->intval = info->voltage_max_design_uv;
> >> +	break;
> >> +	default:
> >> +		return -EINVAL;
> >> +	};
> >> +  
> > Can't get here, so drop.  
> Execution actually does reach this point.
> Would you rather have me return in individual switch cases instead?
good point. I'm clearly blind ;)

Yes, return in each case would probably be cleaner for consistency
with the default case.  Either that or set ret and break in that
path as well.

> >   
> >> +	return ret;
> >> +}
> >> +
> >> +/* Set the most appropriate IIO channel voltage reference scale
> >> + * based on the battery's max voltage.
> >> + */
> >> +static int ingenic_battery_set_scale(struct ingenic_battery *bat)
> >> +{
> >> +	const int *scale_raw;
> >> +	int scale_len, scale_type, best_idx = -1, best_mV, max_raw, i, ret;
> >> +	u64 max_mV;
> >> +
> >> +	ret = iio_read_max_channel_raw(bat->channel, &max_raw);
> >> +	if (ret) {
> >> +		dev_err(bat->dev, "Unable to read max raw channel value\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = iio_read_avail_channel_attribute(bat->channel, &scale_raw,
> >> +					       &scale_type, &scale_len,
> >> +					       IIO_CHAN_INFO_SCALE);
> >> +	if (ret < 0) {
> >> +		dev_err(bat->dev, "Unable to read channel avail scale\n");
> >> +		return ret;
> >> +	}  
> > This works under the constraints of knowing what ADC we are talking to, 
> > but
> > this isn't generic.  The relationship between scale and the range isn't 
> > always
> > direct.  i.e. there are devices where you sample the same range at a 
> > lower
> > scale to be able to read it faster (can be thought of as oversampling, 
> > or
> > just not running the last stages of a pipelined ADC).
> > Anyhow, doesn't matter here as I assume this is fine on this part.
> >   
> >> +	if (ret != IIO_AVAIL_LIST || scale_type != IIO_VAL_FRACTIONAL_LOG2)
> >> +		return -EINVAL;
> >> +
> >> +	max_mV = bat->info.voltage_max_design_uv / 1000;
> >> +
> >> +	for (i = 1; i < scale_len; i += 2) {
> >> +		u64 scale_mV = (max_raw * scale_raw[i - 1]) >> scale_raw[i];  
> > Not keen on the offset in the index being backwards.
> > 
> > This would be clearer I think as
> > 
> > for (i = 0; i < scale_len; i+= 2) {
> > 	u64 scale_mv = (max_raw * scale_raw[i]) >> scale_raw[i + 1];
> > 	...
> > 	best_idx = i;
> > }
> >   
> >> +
> >> +		if (scale_mV < max_mV)
> >> +			continue;
> >> +
> >> +		if (best_idx >= 0 && scale_mV > best_mV)
> >> +			continue;
> >> +
> >> +		best_mV = scale_mV;
> >> +		best_idx = i - 1;
> >> +	}
> >> +
> >> +	if (best_idx < 0) {
> >> +		dev_err(bat->dev, "Unable to find matching voltage scale\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return iio_write_channel_attribute(bat->channel,
> >> +					   scale_raw[best_idx],
> >> +					   scale_raw[best_idx+1],  
> > 
> > Spacing around that +.
> >   
> >> +					   IIO_CHAN_INFO_SCALE);
> >> +}
> >> +
> >> +static enum power_supply_property ingenic_battery_properties[] = {
> >> +	POWER_SUPPLY_PROP_HEALTH,
> >> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> >> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> >> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> >> +};
> >> +
> >> +static int ingenic_battery_probe(struct platform_device *pdev)
> >> +{
> >> +	struct device *dev = &pdev->dev;
> >> +	struct ingenic_battery *bat;
> >> +	struct power_supply_config psy_cfg = {};
> >> +	struct power_supply_desc *desc;
> >> +	int ret;
> >> +
> >> +	bat = devm_kzalloc(dev, sizeof(*bat), GFP_KERNEL);
> >> +	if (!bat)
> >> +		return -ENOMEM;
> >> +
> >> +	bat->dev = dev;
> >> +	bat->channel = devm_iio_channel_get(dev, "battery");
> >> +	if (IS_ERR(bat->channel))
> >> +		return PTR_ERR(bat->channel);
> >> +
> >> +	desc = &bat->desc;
> >> +	desc->name = "jz-battery";
> >> +	desc->type = POWER_SUPPLY_TYPE_BATTERY;
> >> +	desc->properties = ingenic_battery_properties;
> >> +	desc->num_properties = ARRAY_SIZE(ingenic_battery_properties);
> >> +	desc->get_property = ingenic_battery_get_property;
> >> +	psy_cfg.drv_data = bat;
> >> +	psy_cfg.of_node = dev->of_node;
> >> +
> >> +	bat->battery = devm_power_supply_register(dev, desc, &psy_cfg);
> >> +	if (IS_ERR(bat->battery)) {
> >> +		dev_err(dev, "Unable to register battery\n");
> >> +		return PTR_ERR(bat->battery);
> >> +	}
> >> +
> >> +	ret = power_supply_get_battery_info(bat->battery, &bat->info);
> >> +	if (ret) {
> >> +		dev_err(dev, "Unable to get battery info: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +	if (bat->info.voltage_min_design_uv < 0) {
> >> +		dev_err(dev, "Unable to get voltage min design\n");
> >> +		return bat->info.voltage_min_design_uv;
> >> +	}
> >> +	if (bat->info.voltage_max_design_uv < 0) {
> >> +		dev_err(dev, "Unable to get voltage max design\n");
> >> +		return bat->info.voltage_max_design_uv;
> >> +	}
> >> +
> >> +	return ingenic_battery_set_scale(bat);
> >> +}
> >> +
> >> +#ifdef CONFIG_OF
> >> +static const struct of_device_id ingenic_battery_of_match[] = {
> >> +	{ .compatible = "ingenic,jz4740-battery", },
> >> +	{ },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, ingenic_battery_of_match);
> >> +#endif
> >> +
> >> +static struct platform_driver ingenic_battery_driver = {
> >> +	.driver = {
> >> +		.name = "ingenic-battery",
> >> +		.of_match_table = of_match_ptr(ingenic_battery_of_match),
> >> +	},
> >> +	.probe = ingenic_battery_probe,
> >> +};
> >> +module_platform_driver(ingenic_battery_driver);  
> 
