From: Liam Breck <liam@networkimprov.net>
Subject: Re: [05/15] power: supply: bq24190_charger: Limit charging voltage to 4.3V
Date: Sat, 18 Mar 2017 00:10:14 -0700
Message-ID: <20170318071019.4561-2-liam@networkimprov.net>
References: <20170317095527.10487-6-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33808 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdCRHLa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Mar 2017 03:11:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id o126so10954098pfb.1
        for <linux-pm@vger.kernel.org>; Sat, 18 Mar 2017 00:11:23 -0700 (PDT)
In-Reply-To: <20170317095527.10487-6-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

On Fri, 17 Mar 2017 10:55:17 +0100, Hans de Goede wrote:

> When the platform data asks us to not reset the charger to its default
> values and instead trust the firmware set values check the charging
> voltage and clamp it to 4.304V.
> 
> Some firmwares set really too high voltages, e.g. the GPD-win I've been
> working on uses 4.384V. New LiHV (High Voltage) batteries may be charged
> upto 4.35V but that significantly impacts their lifetime, limit charging
> to 4.304V for safety and lifetime reasons.

See comments on patch 04; pls specify the offending firmwares and exactly how they 
misconfigure the charger. Include URLs to datasheets, etc.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/bq24190_charger.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index c92a40e4..7bca8d0 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -504,11 +504,32 @@ static int bq24190_set_mode_host(struct bq24190_dev_info *bdi)
>  
>  static int bq24190_register_reset(struct bq24190_dev_info *bdi)
>  {
> -	int ret, limit = 100;
> +	int ret, voltage, limit = 100;
>  	u8 v;
>  
> -	if (bdi->pdata && bdi->pdata->no_register_reset)
> -		return 0;
> +	if (bdi->pdata && bdi->pdata->no_register_reset) {

See comments on patch 04. Invoke this in set_mode_host() using value from settings config.

> +		/*
> +		 * We've been asked to keep the firmware settings as is, but
> +		 * some firmwares set really too high voltages (e.g. 4.384V).
> +		 * New LiHV (High Voltage) batteries may be charged upto 4.35V
> +		 * but that significantly impacts their lifetime, limit
> +		 * charging to 4.304V for safety and lifetime reasons.
> +		 */

Docs which belong in external config.

> +		ret = bq24190_get_field_val(bdi, BQ24190_REG_CVC,
> +			BQ24190_REG_CVC_VREG_MASK, BQ24190_REG_CVC_VREG_SHIFT,
> +			bq24190_cvc_vreg_values,
> +			ARRAY_SIZE(bq24190_cvc_vreg_values), &voltage);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (voltage <= 4304000)
> +			return 0;

The limit value should come from settings config.

> +		return bq24190_set_field_val(bdi, BQ24190_REG_CVC,
> +			BQ24190_REG_CVC_VREG_MASK, BQ24190_REG_CVC_VREG_SHIFT,
> +			bq24190_cvc_vreg_values,
> +			ARRAY_SIZE(bq24190_cvc_vreg_values), 4304000);
> +	}
>  
>  	/* Reset the registers */
>  	ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
