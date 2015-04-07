From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] power: add poodle battery driver
Date: Tue, 7 Apr 2015 15:34:30 +0300
Message-ID: <CALT56yOH-rc1RG=xQhcGT-FKJz7D9qKd+rO+8s4PdYrK0weCGQ@mail.gmail.com>
References: <1427714679-27472-1-git-send-email-dbaryshkov@gmail.com>
	<20150406164428.GB18145@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38441 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbbDGMec (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2015 08:34:32 -0400
Received: by igbqf9 with SMTP id qf9so9710642igb.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2015 05:34:31 -0700 (PDT)
In-Reply-To: <20150406164428.GB18145@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Andrea Adami <andrea.adami@gmail.com>

Hello,

2015-04-06 19:44 GMT+03:00, Sebastian Reichel <sre@kernel.org>:
> Hi Dmitry,
>
> On Mon, Mar 30, 2015 at 02:24:39PM +0300, Dmitry Eremin-Solenikov wrote:
>> Add a driver supporting battery charging on Sharp SL-5600 (poodle).
>> Voltage and temperature readings are provided through add7846 hwmon
>> interface. Battery voltage is in1_input (mV) and temp in in0_input
>> (values unknown, but should be less than 2441).
>
> You may want to convert add7846 to iio interface, which can be
> exposed via hwmon and requested by other kernel drivers (e.g. this
> one).

This needs a more careful thought. I have several devices in mind,
which provide touchscreen + ADC interfaces, where ADC is used
for battery voltage and temperature sensing. Sometimes additional
GPIOs are in play. Thus I'd like for now to sustain from changing
ads7846 driver. Or, at least to delay such changes, iff there will be
no real design/ideas how to handle such devices in a generic enough
way.

>
>> [...]
>> +struct poodle_bat {
>> + int status;
>> + struct power_supply psy;
>> +
>> + struct mutex work_lock; /* protects data */
>> +
>> + bool (*is_present)(struct poodle_bat *bat);
>> + int technology;
>
> why do you need this for a static type? You can simply set the type
> directly in the get_property function?

ack

>
>> +};
>
>> [...]
>
>> +static struct gpio poodle_batt_gpios[] = {
>> + { POODLE_GPIO_BAT_COVER,    GPIOF_IN, "main battery cover" },
>> + { POODLE_GPIO_CHRG_FULL,    GPIOF_IN, "main battery full" },
>> + { POODLE_GPIO_JK_B,    GPIOF_OUT_INIT_LOW, "main charge on" },
>> + { POODLE_GPIO_CHRG_ON,    GPIOF_OUT_INIT_LOW, "main charge on" },
>> + { POODLE_GPIO_BYPASS_ON,    GPIOF_OUT_INIT_LOW, "main charge bypass" },
>> + /* on for now */
>> + { POODLE_GPIO_ADC_TEMP_ON,  GPIOF_OUT_INIT_HIGH, "main battery temp" },
>> +};
>
> I would prefer if you use the "new" gpiod interface, see
> include/linux/gpio/consumer.h
>
> This obviously refers to the whole driver.
>
>> [...]
>
>> +static int poodle_battery_probe(struct platform_device *dev)
>> +{
>> + int ret;
>> +
>> + ret = gpio_request_array(poodle_batt_gpios,
>> + ARRAY_SIZE(poodle_batt_gpios));
>> + if (ret)
>> + return ret;
>> +
>> + mutex_init(&poodle_bat_main.work_lock);
>> +
>> + INIT_WORK(&bat_work, poodle_bat_work);
>> +
>> + ret = power_supply_register(&dev->dev, &poodle_bat_main.psy);
>> + if (ret)
>> + goto err_psy_reg_main;
>
> we have devm_power_supply_register() now.

Not so sure about it. I'd like to cancel work after unregistering power_supply.
I think I'll even switch from devm_request_irq back to request_irq to be able
to cancel IRQs before canceling work.

>> + ret = devm_request_irq(&dev->dev, gpio_to_irq(POODLE_GPIO_CHRG_FULL),
>> + poodle_bat_gpio_isr,
>> + IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> + "main full", NULL);
>> + if (ret)
>> + goto err_psy_irq;
>> +
>> + ret = devm_request_irq(&dev->dev, gpio_to_irq(POODLE_GPIO_BAT_COVER),
>> + poodle_bat_gpio_isr,
>> + IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> + "battery cover", NULL);
>> + if (ret)
>> + goto err_psy_irq;
>> +
>> + return 0;
>> +
>> +err_psy_irq:
>> + power_supply_unregister(&poodle_bat_main.psy);
>> +
>> + cancel_work_sync(&bat_work);
>> +err_psy_reg_main:
>> + gpio_free_array(poodle_batt_gpios, ARRAY_SIZE(poodle_batt_gpios));
>> +
>> + return ret;
>> +}
>
>> [...]
>
> -- Sebastian
>


-- 
With best wishes
Dmitry
