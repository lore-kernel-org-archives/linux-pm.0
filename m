From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 1/4] power: Add an axp20x-ac-power driver
Date: Mon, 4 Apr 2016 23:05:29 -0700
Message-ID: <CAGb2v66fsdSMCULLtuFC=YEkdOOQRLh2knjjFvatbJhaKu9KWg@mail.gmail.com>
References: <1459689307-8501-1-git-send-email-haas@computerlinguist.org>
 <20160404213851.GQ4227@lukather> <570348E6.5060107@computerlinguist.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCMILY6JWQBBBQFLRW4AKGQESTIW5JQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <570348E6.5060107-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Mon, Apr 4, 2016 at 10:11 PM, Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org> w=
rote:
> Hi Maxime,
>
> thanks for taking the time to review this.
>
> On 04/04/2016 11:38 PM, Maxime Ripard wrote:
>> Hi,
>>>
>>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>>> index a57d6e9..9351c0e 100644
>>> --- a/drivers/mfd/axp20x.c
>>> +++ b/drivers/mfd/axp20x.c
>>> @@ -178,6 +178,12 @@ static struct resource axp288_power_button_resourc=
es[] =3D {
>>>      },
>>>  };
>>>
>>> +static struct resource axp20x_ac_power_supply_resources[] =3D {
>>> +    DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_PLUGIN, "ACIN_PLUGIN"),
>>> +    DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_REMOVAL, "ACIN_REMOVAL"),
>>> +    DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_ACIN_OVER_V, "ACIN_OVER_V"),
>>> +};
>>> +
>>>  static struct resource axp288_fuel_gauge_resources[] =3D {
>>>      {
>>>              .start =3D AXP288_IRQ_QWBTU,
>>> @@ -440,6 +446,11 @@ static struct mfd_cell axp20x_cells[] =3D {
>>>              .of_compatible  =3D "x-powers,axp202-usb-power-supply",
>>>              .num_resources  =3D ARRAY_SIZE(axp20x_usb_power_supply_res=
ources),
>>>              .resources      =3D axp20x_usb_power_supply_resources,
>>> +    }, {
>>> +            .name           =3D "axp20x-ac-power-supply",
>>> +            .of_compatible  =3D "x-powers,axp202-ac-power-supply",
>>> +            .num_resources  =3D ARRAY_SIZE(axp20x_ac_power_supply_reso=
urces),
>>> +            .resources      =3D axp20x_ac_power_supply_resources,
>>>      },
>>>  };
>>>
>>
>> These changes should be in a separate patch.
>
> Will do!
>>
>
>>> +
>>> +static irqreturn_t axp20x_irq_ac_removal(int irq, void *devid)
>>> +{
>>> +    struct axp20x_ac_power *power =3D devid;
>>> +
>>> +    dev_info(&power->supply->dev, "IRQ#%d AC disconnected\n", irq);
>>> +    power_supply_changed(power->supply);
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>
>> Logging in the interrupt handler is usually a bad idea, for several
>> reasons:
>>    - If you have a console, it's going to be output on the console,
>>      which might take quite some time. And you don't want to take
>>      quite some time in the interrupt handler.
>>    - printk might not even work in the interrupt context in some
>>      scenarios.
>>
>> Removing that handler, you can register the same interrupt handler on
>> all the interrupts.
>>
>
> Oops. Yes, I will fix that!
>
>>> +static int axp20x_ac_power_probe(struct platform_device *pdev)
>>> +{
>>> +    struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.parent);
>>> +    struct power_supply_config psy_cfg =3D {};
>>> +    struct axp20x_ac_power *power;
>>> +    static const char * const irq_names[] =3D { "ACIN_PLUGIN",
>>> +            "ACIN_REMOVAL", "ACIN_OVER_V" };
>>> +    irqreturn_t (*irq_funcs[])(int, void *) =3D { axp20x_irq_ac_plugin=
,
>>> +            axp20x_irq_ac_removal, axp20x_irq_ac_over_v };
>>> +    int i, irq, r, input;
>>> +
>>> +    if (!of_device_is_available(pdev->dev.of_node))
>>> +            return -ENODEV;
>>
>> That's useless. If the device is not available, you're not going to be
>> probed in the first place.
>
> Ok.
>
>>
>>> +    power =3D devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
>>> +    if (!power)
>>> +            return -ENOMEM;
>>> +
>>> +    power->regmap =3D axp20x->regmap;
>>> +
>>> +    r =3D regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &input);
>>> +    if (r < 0)
>>> +            return r;
>>> +
>>> +    if (!!(input & AXP20X_PWR_STATUS_AC_VBUS_SHORT)) {
>>> +            dev_err(&pdev->dev, "AC is connected to VBUS. Use axp20x_u=
sb_power-supply driver instead!");
>>> +            return -ENODEV;
>>> +    }
>>
>> Can't that change over time? Can't we support both drivers at the same t=
ime?
>
> Both drivers are supported at the same time. I did even try with both
> AC and USB connected and both return meaningful values, at least for
> voltage. The AXP20x can drawn power from both sources at the same time.
>
> The check above fires in a specific scenario where ACIN and VBUS are
> physically connected on the PCB. The Datasheet states for that
> particular register:
>
> "Indicates whether ACIN/VBUS short circuits on PCB or not"
>
> So, assuming the chip detects the condition correctly, this does not
> change over that. But you can switch from ACIN to VBUS and vice-versa
> just fine if they are not short-circuited. If they are connected
> together, I'd prefer the DTS to only enable the usb driver. The check
> above is a last resort there.
>
> Then again, with the quality of those data sheets, one never knows.

If they are short circuited, does that mean the PMIC will only
draw power from one source? If both are still used, then the
current and voltage readings still make sense. Then it makes
sense to have both drivers enabled, no?

Or would something bad happen?

ChenYu

>>
>>> +    /* Enable ac voltage and current measurement */
>>> +    r =3D regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
>>> +                    AXP20X_ADC_EN1_ACIN_CURR | AXP20X_ADC_EN1_ACIN_VOL=
T,
>>> +                    AXP20X_ADC_EN1_ACIN_CURR | AXP20X_ADC_EN1_ACIN_VOL=
T);
>>> +    if (r)
>>> +            return r;
>>> +
>>> +    psy_cfg.of_node =3D pdev->dev.of_node;
>>> +    psy_cfg.drv_data =3D power;
>>> +
>>> +    power->supply =3D devm_power_supply_register(&pdev->dev,
>>> +                                    &axp20x_ac_power_desc, &psy_cfg);
>>> +    if (IS_ERR(power->supply))
>>> +            return PTR_ERR(power->supply);
>>> +
>>> +    /* Request irqs after registering, as irqs may trigger immediately=
 */
>>> +    for (i =3D 0; i < ARRAY_SIZE(irq_names); i++) {
>>> +            irq =3D platform_get_irq_byname(pdev, irq_names[i]);
>>> +            if (irq < 0) {
>>> +                    dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
>>> +                             irq_names[i], irq);
>>> +                    continue;
>>> +            }
>>> +            irq =3D regmap_irq_get_virq(axp20x->regmap_irqc, irq);
>>> +            r =3D devm_request_any_context_irq(&pdev->dev, irq,
>>> +                            irq_funcs[i], 0, DRVNAME, power);
>>> +            if (r < 0)
>>> +                    dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\=
n",
>>> +                             irq_names[i], r);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct of_device_id axp20x_ac_power_match[] =3D {
>>> +    { .compatible =3D "x-powers,axp202-ac-power-supply" },
>>> +    { }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
>>> +
>>> +static struct platform_driver axp20x_ac_power_driver =3D {
>>> +    .probe =3D axp20x_ac_power_probe,
>>> +    .driver =3D {
>>> +            .name =3D DRVNAME,
>>> +            .of_match_table =3D axp20x_ac_power_match,
>>> +    },
>>> +};
>>> +
>>> +module_platform_driver(axp20x_ac_power_driver);
>>> +
>>> +MODULE_AUTHOR("Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>");
>>> +MODULE_DESCRIPTION("AXP20x PMIC AC power supply status driver");
>>> +MODULE_LICENSE("GPL");
>>> --
>>> 2.8.0
>>
>> Thanks!
>> Maxime
>>
>
>

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
