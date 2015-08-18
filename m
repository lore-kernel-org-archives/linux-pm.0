From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH v2 19/21] leds: leds-pasic3: Add support for PASIC3 LED
 controller
Date: Tue, 18 Aug 2015 23:48:34 +0200
Message-ID: <55D3A832.90705@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D25ADC.10703@tul.cz>
 <55D30875.3090103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <55D30875.3090103@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Dne 18.8.2015 v 12:27 Jacek Anaszewski napsal(a):
> Hi Petr,
> 
> On 08/18/2015 12:06 AM, Petr Cvek wrote:
>> +/*
>> + * AIC3 (or PASIC3) LED driver for HTC Magician/Alpine/.. (not Compaq ASIC3)
> 
> s/AIC3/ASIC3/
> 
> I am a bit confused. What's the relation between ASIC3 and PASIC3?

Actually both drivers should be renamed to AIC3 (or AIC only, as there is version 2). "HTC_AIC3" is written on the chip and "pasic3" is confusing with compaq asic3 driver, which claims in Kconfig help to be compatible with HTC machines. Compaq ASIC3 has much more functionality and from brief look it seems it has 16 bit registers (HTC_AIC3 has only LEDs, RESET and DS1WM and has 8 bit registers).

>> +spinlock_t lock;
> 
> Please move it to the struct pasic3_leds_data.

OK

> 
>> +
>> +static void brightness_set(struct led_classdev *cdev,
>> +    enum led_brightness value)
>> +{
>> +    struct platform_device *pdev = to_platform_device(cdev->dev->parent);
>> +    struct pasic3_led *led = dev_get_platdata(cdev->dev);
>> +    struct pasic3_leds_pdata *pdata = dev_get_platdata(&pdev->dev);
>> +    unsigned long flags;
>> +    u8 val;
>> +
>> +    spin_lock_irqsave(&lock, flags);
>> +
>> +    if (value == LED_OFF) {
>> +        val = pasic3_read_register(pdata->mfd_dev, PASIC3_CH_CONTROL);
>> +        pasic3_write_register(pdata->mfd_dev, PASIC3_CH_CONTROL,
>> +            val & ~(led->bit_blink_en | led->bit_force_on));
>> +
>> +        val = pasic3_read_register(pdata->mfd_dev, PASIC3_MASK_A);
>> +        pasic3_write_register(pdata->mfd_dev, PASIC3_MASK_A,
>> +            val & ~led->bit_mask);
>> +
>> +        if (pdata->power_gpio) {
>> +            pdata->power_gpio_users--;
> 
> Now it is possible that power_gpio_users will have negative value.
> You should check the value before decrementing it.

> Now you are setting power_gpio_users to 1 each time brightness is set,
> whereas it should be set to 1 only if it was 0.
> 
> This could be changed to:
> 
> if (pdata->power_gpio_users == 0)
>     gpio_set_value(pdata->power_gpio, 1);
> 
> pdata->power_gpio_users++;

> 
> Shouldn't you check if also power_gpio state doesn't need to be altered
> here?
> 


Can the same brightness_set() function be called multiple times with same value (like LED_ON)?

I think I will change it to a different code altogether, power_gpio is shared variable and power can be shut off when two of three leds are disabled (green LED does not use power_gpio). Something like:

enabled_leds |= BIT(hw_num);

or

enabled_leds &= ~BIT(hw_num);

>> +        ret = gpio_request(pdata->power_gpio,
>> +            "Red-Blue LED Power");
> 
> Please use devm_gpio_request. Then you will not need pasic3_led_remove.
> 

OK
