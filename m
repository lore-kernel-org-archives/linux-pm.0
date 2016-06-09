From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/2] max8903: adds support for initiation via device tree.
Date: Thu, 9 Jun 2016 12:35:53 +0200
Message-ID: <CAJKOXPdNZbY6=sUbu2Q+pR-PwAD92H5jm5JzmwnBdCbvk3F6KQ@mail.gmail.com>
References: <1464849897-21527-1-git-send-email-chris@lapa.com.au> <1464849897-21527-2-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35031 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbcFIKfz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 06:35:55 -0400
In-Reply-To: <1464849897-21527-2-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: chris@lapa.com.au
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi,

Thanks for your contribution. Few comments below:

On Thu, Jun 2, 2016 at 8:44 AM,  <chris@lapa.com.au> wrote:
> From: Chris Lapa <chris@lapa.com.au>
>
> This commit also adds requesting gpio's via devm_gpio_request() to ensure
> the gpio is available for usage by the driver.
>
> Signed-off-by: Chris Lapa <chris@lapa.com.au>
> ---
>  .../devicetree/bindings/power/max8903-charger.txt  |  28 ++
>  drivers/power/max8903_charger.c                    | 281 ++++++++++++++++-----
>  2 files changed, 250 insertions(+), 59 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/max8903-charger.txt

Please put the bindings documentation in separate, first patch.

>
> diff --git a/Documentation/devicetree/bindings/power/max8903-charger.txt b/Documentation/devicetree/bindings/power/max8903-charger.txt
> new file mode 100644
> index 0000000..7207731
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/max8903-charger.txt
> @@ -0,0 +1,28 @@
> +Maxim Semiconductor MAX8903 Battery Charger bindings
> +
> +Required properties:
> +- compatible: "max8903-charger" for MAX8903 Battery Charger

Needs a 'maxim,' prefix.

> +- dc_valid:
> +       - dok: DC power OK pin
> +- usb_valid:
> +       - uok: USB power OK pin

I don't understand the explanation of them - dok/uok. What do you want
to say here?

> +
> +Optional properties:
> +- cen: Charge enable pin
> +- chg: Charger status pin
> +- flt: Fault pin
> +- dcm: Current limit mode setting (DC or USB)
> +- usus: USB suspend pin

Each gpio should be suffixed with '-gpios' (see
Documentation/devicetree/bindings/gpio/gpio.txt).

> +
> +
> +Example:
> +
> +       max8903-charger {
> +               compatible = "max8903-charger";
> +               dok = <&gpio2 3 GPIO_ACTIVE_LOW>;
> +               flt = <&gpio2 2 GPIO_ACTIVE_LOW>;
> +               chg = <&gpio3 15 GPIO_ACTIVE_LOW>;
> +               cen = <&gpio2 5 GPIO_ACTIVE_LOW>;
> +               dc_valid;
> +               status = "okay";
> +       };
> diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
> index 17876ca..1989c10 100644
> --- a/drivers/power/max8903_charger.c
> +++ b/drivers/power/max8903_charger.c
> @@ -23,13 +23,16 @@
>  #include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
>  #include <linux/slab.h>
>  #include <linux/power_supply.h>
>  #include <linux/platform_device.h>
>  #include <linux/power/max8903_charger.h>
>
>  struct max8903_data {
> -       struct max8903_pdata pdata;
> +       struct max8903_pdata *pdata;
>         struct device *dev;
>         struct power_supply *psy;
>         struct power_supply_desc psy_desc;
> @@ -53,8 +56,8 @@ static int max8903_get_property(struct power_supply *psy,
>         switch (psp) {
>         case POWER_SUPPLY_PROP_STATUS:
>                 val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
> -               if (data->pdata.chg) {
> -                       if (gpio_get_value(data->pdata.chg) == 0)
> +               if (data->pdata->chg) {
> +                       if (gpio_get_value(data->pdata->chg) == 0)
>                                 val->intval = POWER_SUPPLY_STATUS_CHARGING;
>                         else if (data->usb_in || data->ta_in)
>                                 val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> @@ -75,13 +78,14 @@ static int max8903_get_property(struct power_supply *psy,
>         default:
>                 return -EINVAL;
>         }
> +
>         return 0;
>  }
>
>  static irqreturn_t max8903_dcin(int irq, void *_data)
>  {
>         struct max8903_data *data = _data;
> -       struct max8903_pdata *pdata = &data->pdata;
> +       struct max8903_pdata *pdata = data->pdata;
>         bool ta_in;
>         enum power_supply_type old_type;
>
> @@ -122,7 +126,7 @@ static irqreturn_t max8903_dcin(int irq, void *_data)
>  static irqreturn_t max8903_usbin(int irq, void *_data)
>  {
>         struct max8903_data *data = _data;
> -       struct max8903_pdata *pdata = &data->pdata;
> +       struct max8903_pdata *pdata = data->pdata;
>         bool usb_in;
>         enum power_supply_type old_type;
>
> @@ -161,7 +165,7 @@ static irqreturn_t max8903_usbin(int irq, void *_data)
>  static irqreturn_t max8903_fault(int irq, void *_data)
>  {
>         struct max8903_data *data = _data;
> -       struct max8903_pdata *pdata = &data->pdata;
> +       struct max8903_pdata *pdata = data->pdata;
>         bool fault;
>
>         fault = gpio_get_value(pdata->flt) ? false : true;
> @@ -179,34 +183,135 @@ static irqreturn_t max8903_fault(int irq, void *_data)
>         return IRQ_HANDLED;
>  }
>
> +static struct max8903_pdata *max8903_parse_dt_data(
> +               struct device *dev)
> +{
> +       struct device_node *of_node = dev->of_node;
> +       struct max8903_pdata *pdata = NULL;
> +
> +       if (!of_node) {
> +               return pdata;
> +       }

Run a scripts/checkpatch.pl. In general the {} are not needed for
single statements.

> +
> +       pdata = devm_kzalloc(dev, sizeof(struct max8903_pdata),
> +                               GFP_KERNEL);
> +       if (!pdata) {
> +               return pdata;

ditto

> +       }
> +
> +       if (of_get_property(of_node, "dc_valid", NULL)) {
> +               pdata->dc_valid = true;
> +       }
> +
> +       if (of_get_property(of_node, "usb_valid", NULL)) {
> +               pdata->usb_valid = true;
> +       }
> +
> +       pdata->cen = of_get_named_gpio(of_node, "cen", 0);
> +       if (!gpio_is_valid(pdata->cen)) {
> +               pdata->cen = 0;
> +       }
> +
> +       pdata->chg = of_get_named_gpio(of_node, "chg", 0);
> +       if (!gpio_is_valid(pdata->chg)) {
> +               pdata->chg = 0;
> +       }
> +
> +       pdata->flt = of_get_named_gpio(of_node, "flt", 0);
> +       if (!gpio_is_valid(pdata->flt)) {
> +               pdata->flt = 0;
> +       }
> +
> +       pdata->usus = of_get_named_gpio(of_node, "usus", 0);
> +       if (!gpio_is_valid(pdata->usus)) {
> +               pdata->usus = 0;
> +       }
> +
> +       pdata->dcm = of_get_named_gpio(of_node, "dcm", 0);
> +       if (!gpio_is_valid(pdata->dcm)) {
> +               pdata->dcm = 0;
> +       }
> +
> +       pdata->dok = of_get_named_gpio(of_node, "dok", 0);
> +       if (!gpio_is_valid(pdata->dok)) {
> +               pdata->dok = 0;
> +       }
> +
> +       pdata->uok = of_get_named_gpio(of_node, "uok", 0);
> +       if (!gpio_is_valid(pdata->uok)) {
> +               pdata->uok = 0;
> +       }
> +
> +       return pdata;
> +}
> +
>  static int max8903_probe(struct platform_device *pdev)
>  {
> -       struct max8903_data *data;
> +       struct max8903_data *charger;
>         struct device *dev = &pdev->dev;
> -       struct max8903_pdata *pdata = pdev->dev.platform_data;
>         struct power_supply_config psy_cfg = {};
>         int ret = 0;
>         int gpio;
>         int ta_in = 0;
>         int usb_in = 0;
>
> -       data = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
> -       if (data == NULL) {
> +       charger = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
> +       if (charger == NULL) {
>                 dev_err(dev, "Cannot allocate memory.\n");

In a separate patch - you can get rid of error message.

I didn't perform a thorough review. First fix some easy ones. :)

Best regards,
Krzysztof
