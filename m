From: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
Subject: Re: Re: [PATCH 1/4] power: Add an axp20x-ac-power driver
Date: Wed, 6 Apr 2016 08:26:20 +0200
Message-ID: <5704AC0C.3040603@computerlinguist.org>
References: <1459689307-8501-1-git-send-email-haas@computerlinguist.org>
 <20160404213851.GQ4227@lukather> <570348E6.5060107@computerlinguist.org>
 <CAGb2v66fsdSMCULLtuFC=YEkdOOQRLh2knjjFvatbJhaKu9KWg@mail.gmail.com>
Reply-To: haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCD4V7EG6QFRBFGYSK4AKGQEPXH7GWI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v66fsdSMCULLtuFC=YEkdOOQRLh2knjjFvatbJhaKu9KWg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: wens-jdAy2FN1RRM@public.gmane.org
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 04/05/2016 08:05 AM, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, Apr 4, 2016 at 10:11 PM, Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org> wrote:
>> Hi Maxime,
>>
>> thanks for taking the time to review this.
>>
>> On 04/04/2016 11:38 PM, Maxime Ripard wrote:
>>> Hi,
>>>>
>>>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>>>> index a57d6e9..9351c0e 100644
>>>> --- a/drivers/mfd/axp20x.c
>>>> +++ b/drivers/mfd/axp20x.c
>>>> @@ -178,6 +178,12 @@ static struct resource axp288_power_button_resources[] = {
>>>>      },
>>>>  };
>>>>
>>>> +static struct resource axp20x_ac_power_supply_resources[] = {
>>>> +    DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_PLUGIN, "ACIN_PLUGIN"),
>>>> +    DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_REMOVAL, "ACIN_REMOVAL"),
>>>> +    DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_OVER_V, "ACIN_OVER_V"),
>>>> +};
>>>> +
>>>>  static struct resource axp288_fuel_gauge_resources[] = {
>>>>      {
>>>>              .start = AXP288_IRQ_QWBTU,
>>>> @@ -440,6 +446,11 @@ static struct mfd_cell axp20x_cells[] = {
>>>>              .of_compatible  = "x-powers,axp202-usb-power-supply",
>>>>              .num_resources  = ARRAY_SIZE(axp20x_usb_power_supply_resources),
>>>>              .resources      = axp20x_usb_power_supply_resources,
>>>> +    }, {
>>>> +            .name           = "axp20x-ac-power-supply",
>>>> +            .of_compatible  = "x-powers,axp202-ac-power-supply",
>>>> +            .num_resources  = ARRAY_SIZE(axp20x_ac_power_supply_resources),
>>>> +            .resources      = axp20x_ac_power_supply_resources,
>>>>      },
>>>>  };
>>>>
>>>
>>> These changes should be in a separate patch.
>>
>> Will do!
>>>
>>
>>>> +
>>>> +static irqreturn_t axp20x_irq_ac_removal(int irq, void *devid)
>>>> +{
>>>> +    struct axp20x_ac_power *power = devid;
>>>> +
>>>> +    dev_info(&power->supply->dev, "IRQ#%d AC disconnected\n", irq);
>>>> +    power_supply_changed(power->supply);
>>>> +
>>>> +    return IRQ_HANDLED;
>>>> +}
>>>
>>> Logging in the interrupt handler is usually a bad idea, for several
>>> reasons:
>>>    - If you have a console, it's going to be output on the console,
>>>      which might take quite some time. And you don't want to take
>>>      quite some time in the interrupt handler.
>>>    - printk might not even work in the interrupt context in some
>>>      scenarios.
>>>
>>> Removing that handler, you can register the same interrupt handler on
>>> all the interrupts.
>>>
>>
>> Oops. Yes, I will fix that!
>>
>>>> +static int axp20x_ac_power_probe(struct platform_device *pdev)
>>>> +{
>>>> +    struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
>>>> +    struct power_supply_config psy_cfg = {};
>>>> +    struct axp20x_ac_power *power;
>>>> +    static const char * const irq_names[] = { "ACIN_PLUGIN",
>>>> +            "ACIN_REMOVAL", "ACIN_OVER_V" };
>>>> +    irqreturn_t (*irq_funcs[])(int, void *) = { axp20x_irq_ac_plugin,
>>>> +            axp20x_irq_ac_removal, axp20x_irq_ac_over_v };
>>>> +    int i, irq, r, input;
>>>> +
>>>> +    if (!of_device_is_available(pdev->dev.of_node))
>>>> +            return -ENODEV;
>>>
>>> That's useless. If the device is not available, you're not going to be
>>> probed in the first place.
>>
>> Ok.
>>
>>>
>>>> +    power = devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
>>>> +    if (!power)
>>>> +            return -ENOMEM;
>>>> +
>>>> +    power->regmap = axp20x->regmap;
>>>> +
>>>> +    r = regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &input);
>>>> +    if (r < 0)
>>>> +            return r;
>>>> +
>>>> +    if (!!(input & AXP20X_PWR_STATUS_AC_VBUS_SHORT)) {
>>>> +            dev_err(&pdev->dev, "AC is connected to VBUS. Use axp20x_usb_power-supply driver instead!");
>>>> +            return -ENODEV;
>>>> +    }
>>>
>>> Can't that change over time? Can't we support both drivers at the same time?
>>
>> Both drivers are supported at the same time. I did even try with both
>> AC and USB connected and both return meaningful values, at least for
>> voltage. The AXP20x can drawn power from both sources at the same time.
>>
>> The check above fires in a specific scenario where ACIN and VBUS are
>> physically connected on the PCB. The Datasheet states for that
>> particular register:
>>
>> "Indicates whether ACIN/VBUS short circuits on PCB or not"
>>
>> So, assuming the chip detects the condition correctly, this does not
>> change over that. But you can switch from ACIN to VBUS and vice-versa
>> just fine if they are not short-circuited. If they are connected
>> together, I'd prefer the DTS to only enable the usb driver. The check
>> above is a last resort there.
>>
>> Then again, with the quality of those data sheets, one never knows.
> 
> If they are short circuited, does that mean the PMIC will only
> draw power from one source? If both are still used, then the
> current and voltage readings still make sense. Then it makes
> sense to have both drivers enabled, no?
> 
> Or would something bad happen?
> 
> ChenYu
> 
>>>

Hi ChenYu,

I can think of two possible cases here where ACIN/VBUS are
short-circuited on the PCB.

1) Only one of ACIN xor VBUS can be physically connected and the AXP209
cannot distinguish between the two. Since there is only one input, it
makes sense to only expose one power supply node. Here, we don't
necessarily know which one.
2) Both ACIN and VBUS are connected but the AXP209 cannot distinguish
one from the other. The AXP209 may still choose to draw power over both
its ACIN and VBUS pins so we may get two readings. The sum of both
readings then yields the total power consumption of the system, even if
we don't know the individual contribution of ACIN or VBUS.

I just went over the data sheet again and I did not find a further
clarification of the short-circuit register. But I get your point now:
as I described above, we currently have no way of knowing if only one
(which one?) or both inputs will be used on the chip even if the short
circuit condition is detected.

I guess I could take a look at the driver provided by Allwinner
themselves in their old kernel drop. But for now, it may make sense to
ignore the condition alltogether.

Thanks for your input!

Michael
