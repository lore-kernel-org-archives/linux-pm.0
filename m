From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3 4/7] max8903: adds requesting of gpios.
Date: Fri, 17 Jun 2016 08:30:15 +0200
Message-ID: <576398F7.4050704@samsung.com>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466139626-51434-1-git-send-email-chris@lapa.com.au>
 <1466139626-51434-5-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1466139626-51434-5-git-send-email-chris@lapa.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/17/2016 07:00 AM, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
> 
> This change ensures all gpios are available for the driver to use.
> 
> Signed-off-by: Chris Lapa <chris@lapa.com.au>
> ---
>  drivers/power/max8903_charger.c | 79 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 70 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
> index dbd911c4..c068efe 100644
> --- a/drivers/power/max8903_charger.c
> +++ b/drivers/power/max8903_charger.c
> @@ -212,6 +212,16 @@ static int max8903_probe(struct platform_device *pdev)
>  
>  	if (pdata->dc_valid) {
>  		if (pdata->dok && gpio_is_valid(pdata->dok)) {
> +			ret = devm_gpio_request(dev,
> +						pdata->dok,

No need to split these two arguments. They fit in 80 chars.

> +						data->psy_desc.name);
> +			if (ret) {
> +				dev_err(dev,
> +						"Failed GPIO request for dok: %d err %d\n",
> +						pdata->dok, ret);

Indentation here is wrong. These should be aligned to first argument (dev).

> +				return -EINVAL;

Return 'ret'.

All these three comments apply also to code below.

Anyway the probe function is getting bigger and more difficult to read.
Consider factoring out some code to a separate function. For example all
the GPIO handling stuff could be factored.

Best regards,
Krzysztof

> +			}
> +
>  			gpio = pdata->dok; /* PULL_UPed Interrupt */
>  			ta_in = gpio_get_value(gpio) ? 0 : 1;
>  		} else {
> @@ -223,6 +233,16 @@ static int max8903_probe(struct platform_device *pdev)
>  
>  	if (pdata->dcm) {
>  		if (gpio_is_valid(pdata->dcm)) {
> +			ret = devm_gpio_request(dev,
> +						pdata->dcm,
> +						data->psy_desc.name);
> +			if (ret) {
> +				dev_err(dev,
> +						"Failed GPIO request for dcm: %d err %d\n",
> +						pdata->dcm, ret);
> +				return -EINVAL;
> +			}
> +
>  			gpio = pdata->dcm; /* Output */
>  			gpio_set_value(gpio, ta_in);
>  		} else {
> @@ -233,6 +253,16 @@ static int max8903_probe(struct platform_device *pdev)
>  
>  	if (pdata->usb_valid) {
>  		if (pdata->uok && gpio_is_valid(pdata->uok)) {
> +			ret = devm_gpio_request(dev,
> +						pdata->uok,
> +						data->psy_desc.name);
> +			if (ret) {
> +				dev_err(dev,
> +						"Failed GPIO request for uok: %d err %d\n",
> +						pdata->uok, ret);
> +				return -EINVAL;
> +			}
> +
>  			gpio = pdata->uok;
>  			usb_in = gpio_get_value(gpio) ? 0 : 1;
>  		} else {
> @@ -244,6 +274,16 @@ static int max8903_probe(struct platform_device *pdev)
>  
>  	if (pdata->cen) {
>  		if (gpio_is_valid(pdata->cen)) {
> +			ret = devm_gpio_request(dev,
> +						pdata->cen,
> +						data->psy_desc.name);
> +			if (ret) {
> +				dev_err(dev,
> +						"Failed GPIO request for cen: %d err %d\n",
> +						pdata->cen, ret);
> +				return -EINVAL;
> +			}
> +
>  			gpio_set_value(pdata->cen, (ta_in || usb_in) ? 0 : 1);
>  		} else {
>  			dev_err(dev, "Invalid pin: cen.\n");
> @@ -252,23 +292,44 @@ static int max8903_probe(struct platform_device *pdev)
>  	}
>  
>  	if (pdata->chg) {
> -		if (!gpio_is_valid(pdata->chg)) {
> -			dev_err(dev, "Invalid pin: chg.\n");
> -			return -EINVAL;
> +		if (gpio_is_valid(pdata->chg)) {
> +			ret = devm_gpio_request(dev,
> +						pdata->chg,
> +						data->psy_desc.name);
> +			if (ret) {
> +				dev_err(dev,
> +						"Failed GPIO request for chg: %d err %d\n",
> +						pdata->chg, ret);
> +				return -EINVAL;
> +			}
>  		}
>  	}
>  
>  	if (pdata->flt) {
> -		if (!gpio_is_valid(pdata->flt)) {
> -			dev_err(dev, "Invalid pin: flt.\n");
> -			return -EINVAL;
> +		if (gpio_is_valid(pdata->flt)) {
> +			ret = devm_gpio_request(dev,
> +						pdata->flt,
> +						data->psy_desc.name);
> +			if (ret) {
> +				dev_err(dev,
> +						"Failed GPIO request for flt: %d err %d\n",
> +						pdata->flt, ret);
> +				return -EINVAL;
> +			}
>  		}
>  	}
>  
>  	if (pdata->usus) {
> -		if (!gpio_is_valid(pdata->usus)) {
> -			dev_err(dev, "Invalid pin: usus.\n");
> -			return -EINVAL;
> +		if (gpio_is_valid(pdata->usus)) {
> +			ret = devm_gpio_request(dev,
> +						pdata->usus,
> +						data->psy_desc.name);
> +			if (ret) {
> +				dev_err(dev,
> +						"Failed GPIO request for usus: %d err %d\n",
> +						pdata->usus, ret);
> +				return -EINVAL;
> +			}
>  		}
>  	}
>  
> 
