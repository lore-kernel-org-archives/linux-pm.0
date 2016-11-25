From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 01/10] power: supply: axp20x_usb_power: use of_device_id
 data field instead of device_is_compatible
Date: Fri, 25 Nov 2016 17:23:01 +0800
Message-ID: <CAGb2v67O1ch7BvisEjW_=BL0BwHDmCtyuTXKtZpew5XKAWqxtA@mail.gmail.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com> <20161125090921.23138-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161125090921.23138-2-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Russell King <linux@armlinux.org.uk>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 25, 2016 at 5:09 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> This replaces calls to of_device_is_compatible to check data field of
> of_device_id matched when probing the driver.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/power/supply/axp20x_usb_power.c | 39 ++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> index 6af6feb..b19754e 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -17,6 +17,7 @@
>  #include <linux/mfd/axp20x.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/regmap.h>
> @@ -45,6 +46,7 @@ struct axp20x_usb_power {
>         struct device_node *np;
>         struct regmap *regmap;
>         struct power_supply *supply;
> +       int axp20x_id;
>  };
>
>  static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
> @@ -86,8 +88,7 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
>
>                 switch (v & AXP20X_VBUS_CLIMIT_MASK) {
>                 case AXP20X_VBUC_CLIMIT_100mA:
> -                       if (of_device_is_compatible(power->np,
> -                                       "x-powers,axp202-usb-power-supply")) {
> +                       if (power->axp20x_id == AXP202_ID) {
>                                 val->intval = 100000;
>                         } else {
>                                 val->intval = -1; /* No 100mA limit */
> @@ -130,8 +131,7 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
>
>                 val->intval = POWER_SUPPLY_HEALTH_GOOD;
>
> -               if (of_device_is_compatible(power->np,
> -                               "x-powers,axp202-usb-power-supply")) {
> +               if (power->axp20x_id == AXP202_ID) {
>                         ret = regmap_read(power->regmap,
>                                           AXP20X_USB_OTG_STATUS, &v);
>                         if (ret)
> @@ -189,6 +189,17 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
>         .get_property = axp20x_usb_power_get_property,
>  };
>
> +static const struct of_device_id axp20x_usb_power_match[] = {
> +       {
> +               .compatible = "x-powers,axp202-usb-power-supply",
> +               .data = (void *)AXP202_ID,
> +       }, {
> +               .compatible = "x-powers,axp221-usb-power-supply",
> +               .data = (void *)AXP221_ID,
> +       }, { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
> +

There's no need to move this. See why below.

>  static int axp20x_usb_power_probe(struct platform_device *pdev)
>  {
>         struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> @@ -200,11 +211,16 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>                 "VBUS_PLUGIN", "VBUS_REMOVAL", NULL };
>         static const char * const *irq_names;
>         const struct power_supply_desc *usb_power_desc;
> +       const struct of_device_id *of_id;
>         int i, irq, ret;
>
>         if (!of_device_is_available(pdev->dev.of_node))
>                 return -ENODEV;
>
> +       of_id = of_match_device(axp20x_usb_power_match, &pdev->dev);
> +       if (!of_id)
> +               return -ENODEV;
> +

You can use of_device_get_match_data() instead.

ChenYu

>         if (!axp20x) {
>                 dev_err(&pdev->dev, "Parent drvdata not set\n");
>                 return -EINVAL;
> @@ -214,11 +230,12 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>         if (!power)
>                 return -ENOMEM;
>
> +       power->axp20x_id = (int)of_id->data;
> +
>         power->np = pdev->dev.of_node;
>         power->regmap = axp20x->regmap;
>
> -       if (of_device_is_compatible(power->np,
> -                       "x-powers,axp202-usb-power-supply")) {
> +       if (power->axp20x_id == AXP202_ID) {
>                 /* Enable vbus valid checking */
>                 ret = regmap_update_bits(power->regmap, AXP20X_VBUS_MON,
>                                          AXP20X_VBUS_MON_VBUS_VALID,
> @@ -235,8 +252,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>
>                 usb_power_desc = &axp20x_usb_power_desc;
>                 irq_names = axp20x_irq_names;
> -       } else if (of_device_is_compatible(power->np,
> -                       "x-powers,axp221-usb-power-supply")) {
> +       } else if (power->axp20x_id == AXP221_ID) {
>                 usb_power_desc = &axp22x_usb_power_desc;
>                 irq_names = axp22x_irq_names;
>         } else {
> @@ -272,13 +288,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> -static const struct of_device_id axp20x_usb_power_match[] = {
> -       { .compatible = "x-powers,axp202-usb-power-supply" },
> -       { .compatible = "x-powers,axp221-usb-power-supply" },
> -       { }
> -};
> -MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
> -
>  static struct platform_driver axp20x_usb_power_driver = {
>         .probe = axp20x_usb_power_probe,
>         .driver = {
> --
> 2.9.3
>
