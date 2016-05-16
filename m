From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 1/3] power: axp20x_usb: Add support for usb
 power-supply on axp22x pmics
Date: Mon, 16 May 2016 15:07:55 +0800
Message-ID: <CAGb2v67N7R5U_+dZ4ZO+VuGKo6wbVALnrMq3=Ceec8J122LiDA@mail.gmail.com>
References: <1463248289-16456-1-git-send-email-hdegoede@redhat.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBYXD4W4QKGQEIHXVSKA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1463248289-16456-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Sun, May 15, 2016 at 1:51 AM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> The usb power-supply on the axp22x pmics is mostly identical to the
> one on the axp20x pmics. One significant difference is that it cannot
> measure / monitor the usb voltage / current.
>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/power/axp20x_usb_power.c | 99 +++++++++++++++++++++++++++++++---------
>  1 file changed, 77 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/power/axp20x_usb_power.c b/drivers/power/axp20x_usb_power.c
> index 421a90b..b3c1d8e 100644
> --- a/drivers/power/axp20x_usb_power.c
> +++ b/drivers/power/axp20x_usb_power.c
> @@ -42,6 +42,7 @@
>  #define AXP20X_VBUS_MON_VBUS_VALID     BIT(3)
>
>  struct axp20x_usb_power {
> +       struct axp20x_dev *axp20x;
>         struct regmap *regmap;
>         struct power_supply *supply;
>  };
> @@ -85,7 +86,15 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
>
>                 switch (v & AXP20X_VBUS_CLIMIT_MASK) {
>                 case AXP20X_VBUC_CLIMIT_100mA:
> -                       val->intval = 100000;
> +                       switch (power->axp20x->variant) {
> +                       case AXP202_ID:
> +                       case AXP209_ID:
> +                               val->intval = 100000;
> +                               break;
> +                       default:
> +                               val->intval = -1; /* No 100mA limit */
> +                               break;
> +                       }

Given this hardware actually has DT bindings, I'd prefer matching against the
compatible string, and keeping the variant part in axp20x_usb_power. You could
still use the AXPXXX_ID constants, but just the ones used in the bindings. This
could potentially make adding support for newer PMICs easier by only needing a
compatible DT entry.

>                         break;
>                 case AXP20X_VBUC_CLIMIT_500mA:
>                         val->intval = 500000;
> @@ -122,16 +131,23 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
>                         break;
>                 }
>
> -               ret = regmap_read(power->regmap, AXP20X_USB_OTG_STATUS, &v);
> -               if (ret)
> -                       return ret;
> +               val->intval = POWER_SUPPLY_HEALTH_GOOD;
>
> -               if (!(v & AXP20X_USB_STATUS_VBUS_VALID)) {
> -                       val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> +               switch (power->axp20x->variant) {
> +               case AXP202_ID:
> +               case AXP209_ID:
> +                       ret = regmap_read(power->regmap,
> +                                         AXP20X_USB_OTG_STATUS, &v);
> +                       if (ret)
> +                               return ret;
> +
> +                       if (!(v & AXP20X_USB_STATUS_VBUS_VALID))
> +                               val->intval =
> +                                       POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> +                       break;
> +               default:

It seems like you'd return only POWER_SUPPLY_HEALTH_GOOD for AXP22x, even if
VBUS is actually disconnected.

>                         break;
>                 }
> -
> -               val->intval = POWER_SUPPLY_HEALTH_GOOD;
>                 break;
>         case POWER_SUPPLY_PROP_PRESENT:
>                 val->intval = !!(input & AXP20X_PWR_STATUS_VBUS_PRESENT);
> @@ -156,6 +172,14 @@ static enum power_supply_property axp20x_usb_power_properties[] = {
>         POWER_SUPPLY_PROP_CURRENT_NOW,
>  };
>
> +static enum power_supply_property axp22x_usb_power_properties[] = {
> +       POWER_SUPPLY_PROP_HEALTH,
> +       POWER_SUPPLY_PROP_PRESENT,
> +       POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +       POWER_SUPPLY_PROP_CURRENT_MAX,
> +};
> +
>  static const struct power_supply_desc axp20x_usb_power_desc = {
>         .name = "axp20x-usb",
>         .type = POWER_SUPPLY_TYPE_USB,
> @@ -164,13 +188,25 @@ static const struct power_supply_desc axp20x_usb_power_desc = {
>         .get_property = axp20x_usb_power_get_property,
>  };
>
> +static const struct power_supply_desc axp22x_usb_power_desc = {
> +       .name = "axp20x-usb",
> +       .type = POWER_SUPPLY_TYPE_USB,
> +       .properties = axp22x_usb_power_properties,
> +       .num_properties = ARRAY_SIZE(axp22x_usb_power_properties),
> +       .get_property = axp20x_usb_power_get_property,
> +};
> +
>  static int axp20x_usb_power_probe(struct platform_device *pdev)
>  {
>         struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
>         struct power_supply_config psy_cfg = {};
>         struct axp20x_usb_power *power;
> -       static const char * const irq_names[] = { "VBUS_PLUGIN",
> -               "VBUS_REMOVAL", "VBUS_VALID", "VBUS_NOT_VALID" };
> +       static const char * const axp20x_irq_names[] = { "VBUS_PLUGIN",
> +               "VBUS_REMOVAL", "VBUS_VALID", "VBUS_NOT_VALID", NULL };
> +       static const char * const axp22x_irq_names[] = {
> +               "VBUS_PLUGIN", "VBUS_REMOVAL", NULL };
> +       static const char * const *irq_names;
> +       const struct power_supply_desc *usb_power_desc;
>         int i, irq, ret;
>
>         if (!of_device_is_available(pdev->dev.of_node))
> @@ -185,31 +221,50 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>         if (!power)
>                 return -ENOMEM;
>
> +       power->axp20x = axp20x;
>         power->regmap = axp20x->regmap;
>
> -       /* Enable vbus valid checking */
> -       ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
> -                   AXP20X_VBUS_MON_VBUS_VALID, AXP20X_VBUS_MON_VBUS_VALID);
> -       if (ret)
> -               return ret;
> +       switch (power->axp20x->variant) {
> +       case AXP202_ID:
> +       case AXP209_ID:
> +               /* Enable vbus valid checking */
> +               ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
> +                                        AXP20X_VBUS_MON_VBUS_VALID,
> +                                        AXP20X_VBUS_MON_VBUS_VALID);
> +               if (ret)
> +                       return ret;
>
> -       /* Enable vbus voltage and current measurement */
> -       ret = regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
> +               /* Enable vbus voltage and current measurement */
> +               ret = regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
>                         AXP20X_ADC_EN1_VBUS_CURR | AXP20X_ADC_EN1_VBUS_VOLT,
>                         AXP20X_ADC_EN1_VBUS_CURR | AXP20X_ADC_EN1_VBUS_VOLT);
> -       if (ret)
> -               return ret;
> +               if (ret)
> +                       return ret;
> +
> +               usb_power_desc = &axp20x_usb_power_desc;
> +               irq_names = axp20x_irq_names;
> +               break;
> +       case AXP221_ID:
> +       case AXP223_ID:
> +               usb_power_desc = &axp22x_usb_power_desc;
> +               irq_names = axp22x_irq_names;
> +               break;
> +       default:
> +               dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
> +                       axp20x->variant);
> +               return -EINVAL;
> +       }

As mentioned above, I'd prefer using the compatible string.

Regards
ChenYu

>
>         psy_cfg.of_node = pdev->dev.of_node;
>         psy_cfg.drv_data = power;
>
> -       power->supply = devm_power_supply_register(&pdev->dev,
> -                                       &axp20x_usb_power_desc, &psy_cfg);
> +       power->supply = devm_power_supply_register(&pdev->dev, usb_power_desc,
> +                                                  &psy_cfg);
>         if (IS_ERR(power->supply))
>                 return PTR_ERR(power->supply);
>
>         /* Request irqs after registering, as irqs may trigger immediately */
> -       for (i = 0; i < ARRAY_SIZE(irq_names); i++) {
> +       for (i = 0; irq_names[i]; i++) {
>                 irq = platform_get_irq_byname(pdev, irq_names[i]);
>                 if (irq < 0) {
>                         dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
> --
> 2.7.4
>
