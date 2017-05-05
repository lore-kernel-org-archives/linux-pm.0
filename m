From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] power: Add ltc3651-charger driver
Date: Fri, 5 May 2017 07:24:24 +0200
Message-ID: <bdcfdaab-6d3b-74f0-9315-c60232c12a57@topic.nl>
References: <1493732913-19025-1-git-send-email-mike.looijmans@topic.nl>
 <20170504153639.ubpemqn6pp7go2nt@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx5-04.smtp.antispamcloud.com ([95.211.112.140]:57267 "EHLO
        mx5-04.smtp.antispamcloud.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751254AbdEEGVY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 May 2017 02:21:24 -0400
In-Reply-To: <20170504153639.ubpemqn6pp7go2nt@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

﻿On 04-05-17 17:36, Sebastian Reichel wrote:
> Hi,
>
> On Tue, May 02, 2017 at 03:48:33PM +0200, Mike Looijmans wrote:
>> The LTC3651 reports its status via GPIO lines. This driver translates
>> the GPIO levels to battery charger status information via sysfs.
>> It relies on devicetree to supply the IO configuration.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>> I'll send the devicetree binding documentation in a separate patch.
>
> FYI: I will not merge the driver without the docs.

Of course. Was just a bit busy, but it'll arrive soon. Thank you for your 
feedback, i'll post a v2 for this patch and the DT docs soon.

>
>>  drivers/power/supply/Kconfig           |   7 ++
>>  drivers/power/supply/Makefile          |   1 +
>>  drivers/power/supply/ltc3651-charger.c | 224 +++++++++++++++++++++++++++++++++
>>  3 files changed, 232 insertions(+)
>>  create mode 100644 drivers/power/supply/ltc3651-charger.c
>> [...]
>> diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/supply/ltc3651-charger.c
>> new file mode 100644
>> index 0000000..cf73640
>> --- /dev/null
>> +++ b/drivers/power/supply/ltc3651-charger.c
>> @@ -0,0 +1,224 @@
>> +/*
>> + *  Copyright (C) 2017, Topic Embedded Products
>> + *  Driver for LTC3651 charger IC.
>> + *
>> + *  This program is free software; you can redistribute it and/or modify it
>> + *  under  the terms of the GNU General  Public License as published by the
>> + *  Free Software Foundation;  either version 2 of the License, or (at your
>> + *  option) any later version.
>> + *
>> + *  You should have received a copy of the GNU General Public License along
>> + *  with this program; if not, write to the Free Software Foundation, Inc.,
>> + *  675 Mass Ave, Cambridge, MA 02139, USA.
>
> Can you drop the second paragraph? That way we do not need to update
> their address every now and then.

Ok.

>
>> +#include <linux/device.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/power_supply.h>
>> +#include <linux/slab.h>
>> +#include <linux/of.h>
>> +#include <linux/of_gpio.h>
>
> Do you really need of_gpio.h?

Probably not, since gpio/consumer provides it all now. I'll remove it.

>
>> +struct ltc3651_charger {
>> +	struct power_supply *charger;
>> +	struct power_supply_desc charger_desc;
>> +	struct gpio_desc *acpr_gpio;
>> +	struct gpio_desc *fault_gpio;
>> +	struct gpio_desc *chrg_gpio;
>> +};
>
> [...]
>
>> +static int ltc3651_charger_get_property(struct power_supply *psy,
>> +		enum power_supply_property psp, union power_supply_propval *val)
>> +{
>> +	struct ltc3651_charger *ltc3651_charger = psy_to_ltc3651_charger(psy);
>> +
>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_STATUS:
>> +		if (!ltc3651_charger->chrg_gpio) {
>> +			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
>> +			break;
>> +		}
>> +		if (gpiod_get_value(ltc3651_charger->chrg_gpio))
>> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
>> +		else
>> +			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>> +		break;
>> +	case POWER_SUPPLY_PROP_ONLINE:
>> +		val->intval = gpiod_get_value(ltc3651_charger->acpr_gpio);
>> +		break;
>> +	case POWER_SUPPLY_PROP_HEALTH:
>> +		if (!ltc3651_charger->fault_gpio) {
>> +			val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
>> +			break;
>> +		}
>> +		if (!gpiod_get_value(ltc3651_charger->fault_gpio)) {
>> +			val->intval = POWER_SUPPLY_HEALTH_GOOD;
>> +			break;
>> +		}
>> +		/*
>> +		 * If the fault pin is active, the chrg pin explains the type
>> +		 * of failure.
>> +		 */
>> +		if (!ltc3651_charger->chrg_gpio) {
>> +			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
>> +			break;
>> +		}
>> +		val->intval = gpiod_get_value(ltc3651_charger->chrg_gpio) ?
>> +				POWER_SUPPLY_HEALTH_OVERHEAT :
>> +				POWER_SUPPLY_HEALTH_DEAD;
>> +		break;
>
> So reporting of status is incorrect with fault_gpio being set?

According to the datasheet, when both "fault" and "chrg" are active, the 
battery charging is only paused because of overheating and will resume once it 
cools down. For simplicity, I'll just report "charging" since there's no 
"charging paused" state.

>
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static enum power_supply_property ltc3651_charger_properties[] = {
>> +	POWER_SUPPLY_PROP_STATUS,
>> +	POWER_SUPPLY_PROP_ONLINE,
>> +	POWER_SUPPLY_PROP_HEALTH,
>> +};
>> +
>> +static int ltc3651_charger_probe(struct platform_device *pdev)
>> +{
>> +	struct power_supply_config psy_cfg = {};
>> +	struct ltc3651_charger *ltc3651_charger;
>> +	struct power_supply_desc *charger_desc;
>> +	int ret;
>> +
>> +	ltc3651_charger = devm_kzalloc(&pdev->dev, sizeof(*ltc3651_charger),
>> +					GFP_KERNEL);
>> +	if (!ltc3651_charger) {
>> +		dev_err(&pdev->dev, "Failed to alloc driver structure\n");
>
> Drop this. It won't happen on real systems and the memory allocation
> will print warnings itself.

Ok.

>
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ltc3651_charger->acpr_gpio = devm_gpiod_get(&pdev->dev,
>> +					"acpr", GPIOD_IN);
>> +	if (IS_ERR(ltc3651_charger->acpr_gpio)) {
>> +		ret = PTR_ERR(ltc3651_charger->charger);
>> +		dev_err(&pdev->dev, "Failed to acquire acpr GPIO: %d\n", ret);
>> +		return ret;
>> +	}
>> +	ltc3651_charger->fault_gpio = devm_gpiod_get_optional(&pdev->dev,
>> +					"fault", GPIOD_IN);
>> +	if (IS_ERR(ltc3651_charger->fault_gpio)) {
>> +		ret = PTR_ERR(ltc3651_charger->charger);
>> +		dev_err(&pdev->dev, "Failed to acquire fault GPIO: %d\n", ret);
>> +		return ret;
>> +	}
>> +	ltc3651_charger->chrg_gpio = devm_gpiod_get_optional(&pdev->dev,
>> +					"chrg", GPIOD_IN);
>> +	if (IS_ERR(ltc3651_charger->chrg_gpio)) {
>> +		ret = PTR_ERR(ltc3651_charger->charger);
>> +		dev_err(&pdev->dev, "Failed to acquire chrg GPIO: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	charger_desc = &ltc3651_charger->charger_desc;
>> +	charger_desc->name = pdev->dev.of_node->name;
>> +	charger_desc->type = POWER_SUPPLY_TYPE_MAINS;
>> +	charger_desc->properties = ltc3651_charger_properties;
>> +	charger_desc->num_properties = ARRAY_SIZE(ltc3651_charger_properties);
>> +	charger_desc->get_property = ltc3651_charger_get_property;
>> +	psy_cfg.of_node = pdev->dev.of_node;
>> +	psy_cfg.drv_data = ltc3651_charger;
>> +
>> +	ltc3651_charger->charger = power_supply_register(&pdev->dev,
>> +						      charger_desc, &psy_cfg);
>> +	if (IS_ERR(ltc3651_charger->charger)) {
>> +		ret = PTR_ERR(ltc3651_charger->charger);
>> +		dev_err(&pdev->dev, "Failed to register power supply: %d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Acquire IRQs for the GPIO pins if possible */
>> +	if (ltc3651_charger->acpr_gpio) {
>> +		ret = gpiod_to_irq(ltc3651_charger->acpr_gpio);
>> +		if (ret >= 0)
>> +			ret = devm_request_any_context_irq(&pdev->dev, ret,
>> +				ltc3651_charger_irq,
>> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> +				dev_name(&pdev->dev), ltc3651_charger->charger);
>> +		if (ret < 0)
>> +			dev_warn(&pdev->dev, "Failed to request acpr irq\n");
>> +	}
>> +	if (ltc3651_charger->fault_gpio) {
>> +		ret = gpiod_to_irq(ltc3651_charger->fault_gpio);
>> +		if (ret >= 0)
>> +			ret = devm_request_any_context_irq(&pdev->dev, ret,
>> +				ltc3651_charger_irq,
>> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> +				dev_name(&pdev->dev), ltc3651_charger->charger);
>> +		if (ret < 0)
>> +			dev_warn(&pdev->dev, "Failed to request fault irq\n");
>> +	}
>> +	if (ltc3651_charger->chrg_gpio) {
>> +		ret = gpiod_to_irq(ltc3651_charger->chrg_gpio);
>> +		if (ret >= 0)
>> +			ret = devm_request_any_context_irq(&pdev->dev, ret,
>> +				ltc3651_charger_irq,
>> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> +				dev_name(&pdev->dev), ltc3651_charger->charger);
>> +		if (ret < 0)
>> +			dev_warn(&pdev->dev, "Failed to request chrg irq\n");
>> +	}
>
> I think we should either require irq support or provide
> some kind of polling fallback.
>
>> +	platform_set_drvdata(pdev, ltc3651_charger);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ltc3651_charger_remove(struct platform_device *pdev)
>> +{
>> +	struct ltc3651_charger *ltc3651_charger = platform_get_drvdata(pdev);
>> +
>> +	power_supply_unregister(ltc3651_charger->charger);
>> +
>> +	return 0;
>> +}
>
> Use devm_power_supply_register() and kill remove function :)

Ok.

>
>> +static const struct of_device_id ltc3651_charger_match[] = {
>> +	{ .compatible = "ltc3651-charger" },
>
> Missing vendor prefix.

I'll change to "lltc,ltc3651-charger"

>
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, ltc3651_charger_match);
>> +
>> +static struct platform_driver ltc3651_charger_driver = {
>> +	.probe = ltc3651_charger_probe,
>> +	.remove = ltc3651_charger_remove,
>> +	.driver = {
>> +		.name = "ltc3651-charger",
>> +		.of_match_table = ltc3651_charger_match,
>> +	},
>> +};
>> +
>> +module_platform_driver(ltc3651_charger_driver);
>> +
>> +MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
>> +MODULE_DESCRIPTION("Driver for LTC3651 charger");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:ltc3651-charger");
>
> -- Sebastian
>



Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
