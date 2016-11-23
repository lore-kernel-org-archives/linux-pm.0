From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH 2/2] power: supply: add sbs-charger driver
Date: Wed, 23 Nov 2016 09:06:40 +0800
Message-ID: <d5340efc-b3b4-a247-ed85-b8f117294f40@electromag.com.au>
References: <1479751491-8849-1-git-send-email-nicolas.saenz@prodys.net>
 <1479751491-8849-3-git-send-email-nicolas.saenz@prodys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:44138 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751882AbcKWBOf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 20:14:35 -0500
In-Reply-To: <1479751491-8849-3-git-send-email-nicolas.saenz@prodys.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicola Saenz Julienne <nicolas.saenz@prodys.net>, sre@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

G'day Nicola,

On 22/11/2016 02:04, Nicola Saenz Julienne wrote:
> This adds support for sbs-charger compilant chips as defined here:
> http://sbs-forum.org/specs/sbc110.pdf
>

You may want to look at the series: power: supply: sbs-manager add driver.
http://www.spinics.net/lists/linux-i2c/msg26383.html

This is the same thing that Karl-Heinz and myself particpated on.

We've had some trouble getting the device tree binding approved thou.

In particular it handles multiple sbs-batteries thru an i2c mux.

Have a look and let me know what you think. Sebastians comment on the irq thing looks interesting
There does look to be some nice additional features in your driver.

I've been distracted with other things but if you want to progress it I'm happy to help with testing etc.

Dual battery support is a must for me thou.



> This was tested on a arm board connected to an LTC41000 battery charger
> chip.
>
> Signed-off-by: Nicola Saenz Julienne <nicolas.saenz@prodys.net>
> ---
>  drivers/power/supply/Kconfig       |   6 +
>  drivers/power/supply/Makefile      |   1 +
>  drivers/power/supply/sbs-charger.c | 312 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 319 insertions(+)
>  create mode 100644 drivers/power/supply/sbs-charger.c
>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 76806a0..42877ff 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -164,6 +164,12 @@ config BATTERY_SBS
>  	  Say Y to include support for SBS battery driver for SBS-compliant
>  	  gas gauges.
>
> +config CHARGER_SBS
> +        tristate "SBS Compliant charger"
> +        depends on I2C
> +        help
> +	  Say Y to include support for SBS compilant battery chargers.
> +
>  config BATTERY_BQ27XXX
>  	tristate "BQ27xxx battery driver"
>  	help
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 36c599d..06d9ef5 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_BATTERY_COLLIE)	+= collie_battery.o
>  obj-$(CONFIG_BATTERY_IPAQ_MICRO) += ipaq_micro_battery.o
>  obj-$(CONFIG_BATTERY_WM97XX)	+= wm97xx_battery.o
>  obj-$(CONFIG_BATTERY_SBS)	+= sbs-battery.o
> +obj-$(CONFIG_CHARGER_SBS)	+= sbs-charger.o
>  obj-$(CONFIG_BATTERY_BQ27XXX)	+= bq27xxx_battery.o
>  obj-$(CONFIG_BATTERY_BQ27XXX_I2C) += bq27xxx_battery_i2c.o
>  obj-$(CONFIG_BATTERY_DA9030)	+= da9030_battery.o
> diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
> new file mode 100644
> index 0000000..a0088b0
> --- /dev/null
> +++ b/drivers/power/supply/sbs-charger.c
> @@ -0,0 +1,312 @@
> +/*
> + * Copyright (c) 2016, Prodys S.L.
> + *
> + * Author: Nicolas Saenz Julienne <nicolas.saenz@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * based on sbs-battery.c
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/power_supply.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio.h>
> +#include <linux/regmap.h>
> +#include <linux/of_gpio.h>
> +#include <linux/bitops.h>
> +
> +#define SBS_CHARGER_REG_STATUS			0x13
> +
> +#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(1)
> +#define SBS_CHARGER_STATUS_RES_COLD		BIT(9)
> +#define SBS_CHARGER_STATUS_RES_HOT		BIT(10)
> +#define SBS_CHARGER_STATUS_BATTERY_PRESENT	BIT(14)
> +#define SBS_CHARGER_STATUS_AC_PRESENT		BIT(15)
> +
> +#define SBS_CHARGER_POLL_TIME			500
> +
> +struct sbs_info {
> +	struct i2c_client		*client;
> +	struct power_supply		*power_supply;
> +	struct regmap			*regmap;
> +	struct delayed_work		work;
> +	unsigned int			last_state;
> +
> +	int				gpio;
> +	int				irq;
> +};
> +
> +static int sbs_get_property(struct power_supply *psy,
> +			    enum power_supply_property psp,
> +			    union power_supply_propval *val)
> +{
> +	struct sbs_info *chip = power_supply_get_drvdata(psy);
> +	unsigned int reg;
> +
> +	reg = chip->last_state;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval = !!(reg & SBS_CHARGER_STATUS_BATTERY_PRESENT);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval = !!(reg & SBS_CHARGER_STATUS_AC_PRESENT);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
> +
> +		if (!(reg & SBS_CHARGER_STATUS_BATTERY_PRESENT))
> +			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		else if (reg & SBS_CHARGER_STATUS_AC_PRESENT &&
> +			 !(reg & SBS_CHARGER_STATUS_CHARGE_INHIBITED))
> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +		else
> +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +
> +		break;
> +
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		if (reg & SBS_CHARGER_STATUS_RES_COLD)
> +			val->intval = POWER_SUPPLY_HEALTH_COLD;
> +		if (reg & SBS_CHARGER_STATUS_RES_HOT)
> +			val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
> +		else
> +			val->intval = POWER_SUPPLY_HEALTH_GOOD;
> +
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sbs_check_state(struct sbs_info *chip)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(chip->regmap, SBS_CHARGER_REG_STATUS, &reg);
> +	if (!ret && reg != chip->last_state) {
> +		chip->last_state = reg;
> +		power_supply_changed(chip->power_supply);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sbs_delayed_work(struct work_struct *work)
> +{
> +	struct sbs_info *chip = container_of(work, struct sbs_info, work.work);
> +
> +	sbs_check_state(chip);
> +
> +	schedule_delayed_work(&chip->work,
> +			      msecs_to_jiffies(SBS_CHARGER_POLL_TIME));
> +}
> +
> +static irqreturn_t sbs_irq_thread(int irq, void *data)
> +{
> +	struct sbs_info *chip = data;
> +	int ret;
> +
> +	ret = sbs_check_state(chip);
> +
> +	return ret ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +static int sbs_parse_of(struct i2c_client *client, struct sbs_info *chip)
> +{
> +	struct device_node *np = client->dev.of_node;
> +	int ret;
> +
> +	chip->gpio = of_get_gpio(np, 0);
> +	if (chip->gpio < 0) {
> +		dev_warn(&client->dev,
> +			 "Failed to get gpio line, will default to polling\n");
> +		/*
> +		 * We don't consider this an error since sbs-charger spec states
> +		 * irq usage is optional, in this case we'll poll for the status
> +		 * changes.
> +		 */
> +		return 0;
> +	}
> +
> +	ret = gpio_direction_input(chip->gpio);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to set gpio as input: %d\n", ret);
> +		goto exit_gpio;
> +	}
> +
> +	chip->irq = gpio_to_irq(chip->gpio);
> +	if (chip->irq < 0) {
> +		ret = chip->irq;
> +		chip->irq = 0;
> +		dev_err(&client->dev, "Failed to get irq from gpio, %d\n", ret);
> +		goto exit_gpio;
> +	}
> +
> +	ret = devm_request_threaded_irq(&client->dev, chip->irq, NULL,
> +					sbs_irq_thread,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					dev_name(&client->dev), chip);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to request irq, %d\n", ret);
> +		chip->irq = 0;
> +		goto exit_gpio;
> +	}
> +
> +	return 0;
> +
> +exit_gpio:
> +	gpio_free(chip->gpio);
> +	return ret;
> +}
> +
> +static enum power_supply_property sbs_properties[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +};
> +
> +static bool sbs_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case SBS_CHARGER_REG_STATUS:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static const struct regmap_config sbs_regmap = {
> +	.reg_bits	= 8,
> +	.val_bits	= 16,
> +	.max_register	= SBS_CHARGER_REG_STATUS,
> +	.volatile_reg	= sbs_volatile_reg,
> +	.val_format_endian = REGMAP_ENDIAN_NATIVE,
> +};
> +
> +static const struct power_supply_desc sbs_desc = {
> +	.name = "sbs-charger",
> +	.type = POWER_SUPPLY_TYPE_MAINS,
> +	.properties = sbs_properties,
> +	.num_properties = ARRAY_SIZE(sbs_properties),
> +	.get_property = sbs_get_property,
> +};
> +
> +static char *sbs_battery[] = {
> +	"sbs-battery",
> +};
> +
> +static int sbs_probe(struct i2c_client *client,
> +		     const struct i2c_device_id *id)
> +{
> +	struct power_supply_config psy_cfg = {};
> +	struct sbs_info *chip;
> +	int ret, val;
> +
> +	chip = devm_kzalloc(&client->dev, sizeof(struct sbs_info), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->client = client;
> +	psy_cfg.of_node = client->dev.of_node;
> +	psy_cfg.drv_data = chip;
> +	psy_cfg.supplied_to = sbs_battery;
> +	psy_cfg.num_supplicants = ARRAY_SIZE(sbs_battery);
> +
> +	i2c_set_clientdata(client, chip);
> +
> +	chip->regmap = devm_regmap_init_i2c(client, &sbs_regmap);
> +	if (IS_ERR(chip->regmap))
> +		return PTR_ERR(chip->regmap);
> +
> +	ret = sbs_parse_of(client, chip);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to get platform data\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Before we register, we need to make sure we can actually talk
> +	 * to the battery.
> +	 */
> +	ret = regmap_read(chip->regmap, SBS_CHARGER_REG_STATUS, &val);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to get device status\n");
> +		return ret;
> +	}
> +	chip->last_state = val;
> +
> +	chip->power_supply = power_supply_register(&client->dev, &sbs_desc,
> +						   &psy_cfg);
> +	if (IS_ERR(chip->power_supply)) {
> +		dev_err(&client->dev, "Failed to register power supply\n");
> +		return PTR_ERR(chip->power_supply);
> +	}
> +
> +	if (!chip->irq) {
> +		INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
> +		schedule_delayed_work(&chip->work,
> +				      msecs_to_jiffies(SBS_CHARGER_POLL_TIME));
> +	}
> +
> +	dev_info(&client->dev,
> +		 "%s: smart charger device registered\n", client->name);
> +
> +	return 0;
> +}
> +
> +static int sbs_remove(struct i2c_client *client)
> +{
> +	struct sbs_info *chip = i2c_get_clientdata(client);
> +
> +	cancel_delayed_work_sync(&chip->work);
> +	power_supply_unregister(chip->power_supply);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id sbs_dt_ids[] = {
> +	{ .compatible = "sbs,sbs-charger" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, sbs_dt_ids);
> +#endif
> +
> +static const struct i2c_device_id sbs_id[] = {
> +	{ "sbs-charger", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sbs_id);
> +
> +static struct i2c_driver sbs_driver = {
> +	.probe		= sbs_probe,
> +	.remove		= sbs_remove,
> +	.id_table	= sbs_id,
> +	.driver = {
> +		.name	= "sbs-charger",
> +		.of_match_table = of_match_ptr(sbs_dt_ids),
> +	},
> +};
> +module_i2c_driver(sbs_driver);
> +
> +MODULE_AUTHOR("Nicolas Saenz Julienne <nicolassaenzj@gmail.com>");
> +MODULE_DESCRIPTION("SBS smart charger driver");
> +MODULE_LICENSE("GPL v2");
>


-- 
Regards
Phil Reid

ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au

3 The Avenue, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100
Email: preid@electromag.com.au
