From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] power: max77693_charger: Better sysfs creation and using
 devm APIs
Date: Sat, 10 Dec 2016 09:48:54 +0200
Message-ID: <20161210074854.GB2991@kozik-lap>
References: <1481273498-4957-1-git-send-email-s.ritolia@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36575 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbcLJHtL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Dec 2016 02:49:11 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so990283wma.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Dec 2016 23:49:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1481273498-4957-1-git-send-email-s.ritolia@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srikant Ritolia <s.ritolia@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, d.wadhawan@samsung.com, vidushi.koul@samsung.com, srikant.ritolia@gmail.com

On Fri, Dec 09, 2016 at 02:21:38PM +0530, Srikant Ritolia wrote:
> Creating sysfs group instead of creating each attribute one by one
> and then handling its remove and error condition.
> 
> Also using manged resource function devm_power_supply_register API
> instead of power_supply_register which automatically does
> unregister on error and remove.
> 
> Signed-off-by: Srikant Ritolia <s.ritolia@samsung.com>
> ---
>  drivers/power/supply/max77693_charger.c |   51 +++++++++++--------------------
>  1 file changed, 18 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
> index 6c78884..f8f7188 100644
> --- a/drivers/power/supply/max77693_charger.c
> +++ b/drivers/power/supply/max77693_charger.c
> @@ -445,6 +445,17 @@ static ssize_t top_off_timer_store(struct device *dev,
>  static DEVICE_ATTR_RW(top_off_threshold_current);
>  static DEVICE_ATTR_RW(top_off_timer);
>  
> +static struct attribute *max77693_charger_attribute[] = {
> +	&dev_attr_fast_charge_timer.attr,
> +	&dev_attr_top_off_threshold_current.attr,
> +	&dev_attr_top_off_timer.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group max77693_attr_group = {
> +	.attrs = max77693_charger_attribute,
> +};
> +
>  static int max77693_set_constant_volt(struct max77693_charger *chg,
>  		unsigned int uvolt)
>  {
> @@ -699,53 +710,27 @@ static int max77693_charger_probe(struct platform_device *pdev)
>  
>  	psy_cfg.drv_data = chg;
>  
> -	ret = device_create_file(&pdev->dev, &dev_attr_fast_charge_timer);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed: create fast charge timer sysfs entry\n");
> -		goto err;
> -	}
> -
> -	ret = device_create_file(&pdev->dev,
> -			&dev_attr_top_off_threshold_current);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed: create top off current sysfs entry\n");
> -		goto err;
> -	}
> -
> -	ret = device_create_file(&pdev->dev, &dev_attr_top_off_timer);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed: create top off timer sysfs entry\n");
> -		goto err;
> +	ret = sysfs_create_group(&pdev->dev.kobj, &max77693_attr_group);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "Can't create sysfs entries\n");
> +		return ret;
>  	}
>  
> -	chg->charger = power_supply_register(&pdev->dev,
> +	chg->charger = devm_power_supply_register(&pdev->dev,

I would prefer splitting this into separate patche. You are altering
the order of cleanup in unbind. Previously power supply was unregistered
before sysfs, now it will be after. I don't see a problem with that but
these as separate ideas with different possible outcomes.

>  						&max77693_charger_desc,
>  						&psy_cfg);
>  	if (IS_ERR(chg->charger)) {
>  		dev_err(&pdev->dev, "failed: power supply register\n");
>  		ret = PTR_ERR(chg->charger);
> -		goto err;

Missing sysfs cleanup.

Best regards,
Krzysztof

> +		return ret;
>  	}
>  
>  	return 0;
> -
> -err:
> -	device_remove_file(&pdev->dev, &dev_attr_top_off_timer);
> -	device_remove_file(&pdev->dev, &dev_attr_top_off_threshold_current);
> -	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
> -
> -	return ret;
>  }
>  
>  static int max77693_charger_remove(struct platform_device *pdev)
>  {
> -	struct max77693_charger *chg = platform_get_drvdata(pdev);
> -
> -	device_remove_file(&pdev->dev, &dev_attr_top_off_timer);
> -	device_remove_file(&pdev->dev, &dev_attr_top_off_threshold_current);
> -	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
> -
> -	power_supply_unregister(chg->charger);
> +	sysfs_remove_group(&pdev->dev.kobj, &max77693_attr_group);
>  
>  	return 0;
>  }
> -- 
> 1.7.9.5
> 
