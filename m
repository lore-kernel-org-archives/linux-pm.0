From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 7/7] max8903: adds support for initiation via device
 tree.
Date: Fri, 17 Jun 2016 08:41:14 +0200
Message-ID: <57639B8A.1030109@samsung.com>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466139626-51434-1-git-send-email-chris@lapa.com.au>
 <1466139626-51434-8-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32863 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbcFQGlV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 02:41:21 -0400
In-reply-to: <1466139626-51434-8-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 06/17/2016 07:00 AM, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
> 
> Adds support for device tree to setup a max8903 battery charger. DC and USB
> validity are determined by looking the presence of the dok and uok gpios.
> 
> Signed-off-by: Chris Lapa <chris@lapa.com.au>
> ---
>  drivers/power/max8903_charger.c | 217 +++++++++++++++++++++++++++-------------
>  1 file changed, 145 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
> index 5ddc667..3c59213 100644
> --- a/drivers/power/max8903_charger.c
> +++ b/drivers/power/max8903_charger.c
> @@ -23,6 +23,9 @@
>  #include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
>  #include <linux/slab.h>
>  #include <linux/power_supply.h>
>  #include <linux/platform_device.h>
> @@ -75,6 +78,7 @@ static int max8903_get_property(struct power_supply *psy,
>  	default:
>  		return -EINVAL;
>  	}
> +
>  	return 0;
>  }
>  
> @@ -179,48 +183,116 @@ static irqreturn_t max8903_fault(int irq, void *_data)
>  	return IRQ_HANDLED;
>  }
>  
> +static struct max8903_pdata *max8903_parse_dt_data(
> +		struct device *dev)
> +{
> +	struct device_node *of_node = dev->of_node;

Common naming convention for device_node is just 'np':
	struct device_node *np = dev->of_node;

It is shorter and already spread in the kernel.

> +	struct max8903_pdata *pdata = NULL;
> +
> +	if (!of_node)
> +		return NULL;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata),
> +				GFP_KERNEL);

No need to break the line.

> +	if (!pdata)
> +		return NULL;
> +
> +	pdata->dc_valid = false;
> +	pdata->usb_valid = false;
> +
> +	pdata->cen = of_get_named_gpio(of_node, "cen-gpios", 0);
> +	if (!gpio_is_valid(pdata->cen))
> +		pdata->cen = -EINVAL;
> +
> +	pdata->chg = of_get_named_gpio(of_node, "chg-gpios", 0);
> +	if (!gpio_is_valid(pdata->chg))
> +		pdata->chg = -EINVAL;
> +
> +	pdata->flt = of_get_named_gpio(of_node, "flt-gpios", 0);
> +	if (!gpio_is_valid(pdata->flt))
> +		pdata->flt = -EINVAL;
> +
> +	pdata->usus = of_get_named_gpio(of_node, "usus-gpios", 0);
> +	if (!gpio_is_valid(pdata->usus))
> +		pdata->usus = -EINVAL;
> +
> +	pdata->dcm = of_get_named_gpio(of_node, "dcm-gpios", 0);
> +	if (!gpio_is_valid(pdata->dcm))
> +		pdata->dcm = -EINVAL;
> +
> +	pdata->dok = of_get_named_gpio(of_node, "dok-gpios", 0);
> +	if (!gpio_is_valid(pdata->dok))
> +		pdata->dok = -EINVAL;
> +	else
> +		pdata->dc_valid = true;
> +
> +	pdata->uok = of_get_named_gpio(of_node, "uok-gpios", 0);
> +	if (!gpio_is_valid(pdata->uok))
> +		pdata->uok = -EINVAL;
> +	else
> +		pdata->usb_valid = true;
> +
> +	return pdata;
> +}
> +
>  static int max8903_probe(struct platform_device *pdev)
>  {
> -	struct max8903_data *data;
> +	struct max8903_data *charger;
>  	struct device *dev = &pdev->dev;
> -	struct max8903_pdata *pdata = pdev->dev.platform_data;
>  	struct power_supply_config psy_cfg = {};
>  	int ret = 0;
>  	int gpio;
>  	int ta_in = 0;
>  	int usb_in = 0;
>  
> -	if (pdata == NULL) {
> +	charger = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	charger->pdata = pdev->dev.platform_data;
> +	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && dev->of_node)
> +		charger->pdata = max8903_parse_dt_data(dev);
> +
> +	if (!charger->pdata) {
>  		dev_err(dev, "No platform data.\n");
>  		return -EINVAL;
>  	}
>  
> -	data = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> +	charger->dev = dev;
>  
> -	data->pdata = pdev->dev.platform_data;
> -	data->dev = dev;
> -	platform_set_drvdata(pdev, data);
> +	charger->fault = false;
> +	charger->ta_in = ta_in;
> +	charger->usb_in = usb_in;
>  
> -	if (pdata->dc_valid == false && pdata->usb_valid == false) {
> +	charger->psy_desc.name = "max8903_charger";
> +	charger->psy_desc.type = (ta_in) ? POWER_SUPPLY_TYPE_MAINS :
> +			((usb_in) ? POWER_SUPPLY_TYPE_USB :
> +			 POWER_SUPPLY_TYPE_BATTERY);
> +	charger->psy_desc.get_property = max8903_get_property;
> +	charger->psy_desc.properties = max8903_charger_props;
> +	charger->psy_desc.num_properties = ARRAY_SIZE(max8903_charger_props);
> +
> +	platform_set_drvdata(pdev, charger);
> +
> +	if (charger->pdata->dc_valid == false && charger->pdata->usb_valid == false) {
>  		dev_err(dev, "No valid power sources.\n");
>  		return -EINVAL;
>  	}
>  
> -	if (pdata->dc_valid) {
> -		if (gpio_is_valid(pdata->dok)) {
> +
> +	if (charger->pdata->dc_valid) {
> +		if (gpio_is_valid(charger->pdata->dok)) {
>  			ret = devm_gpio_request(dev,
> -						pdata->dok,
> -						data->psy_desc.name);
> +						charger->pdata->dok,
> +						charger->psy_desc.name);
>  			if (ret) {
>  				dev_err(dev,
>  						"Failed GPIO request for dok: %d err %d\n",
> -						pdata->dok, ret);
> +						charger->pdata->dok, ret);


I pointed the weird indentation in 4/7. Just a reminder: after fixing it
in 4/7 you also have to adjust it in consecutive patches.

Best regards,
Krzysztof
