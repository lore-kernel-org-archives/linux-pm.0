From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/3] Thermal: rcar: Convert to devm_ioremap_resource()
Date: Mon, 11 Mar 2013 22:35:32 +0800
Message-ID: <1363012532.2291.76.camel@rzhang1-mobl4>
References: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
	 <1362379534-30662-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26808 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686Ab3CKOf6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Mar 2013 10:35:58 -0400
In-Reply-To: <1362379534-30662-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, thierry.reding@avionic-design.de, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Mon, 2013-03-04 at 12:15 +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
> 
> devm_ioremap_resource() provides its own error messages; so all explicit
> error messages can be removed from the failure code paths.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

applied to thermal -next tree.

thanks,
rui
> ---
>  drivers/thermal/rcar_thermal.c |   16 ++++++----------
>  1 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 28f0919..b28990a 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -399,11 +399,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  		/*
>  		 * rcar_has_irq_support() will be enabled
>  		 */
> -		common->base = devm_request_and_ioremap(dev, res);
> -		if (!common->base) {
> -			dev_err(dev, "Unable to ioremap thermal register\n");
> -			return -ENOMEM;
> -		}
> +		common->base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(common->base))
> +			return PTR_ERR(common->base);
>  
>  		/* enable temperature comparation */
>  		rcar_thermal_common_write(common, ENR, 0x00030303);
> @@ -422,11 +420,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  			return -ENOMEM;
>  		}
>  
> -		priv->base = devm_request_and_ioremap(dev, res);
> -		if (!priv->base) {
> -			dev_err(dev, "Unable to ioremap priv register\n");
> -			return -ENOMEM;
> -		}
> +		priv->base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(priv->base))
> +			return PTR_ERR(priv->base);
>  
>  		priv->common = common;
>  		priv->id = i;


