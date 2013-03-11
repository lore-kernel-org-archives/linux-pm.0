From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] thermal: rcar_thermal: propagate return value of
 thermal_zone_device_register
Date: Mon, 11 Mar 2013 22:47:09 +0800
Message-ID: <1363013229.2291.80.camel@rzhang1-mobl4>
References: <1362415968-2210-1-git-send-email-devendra.aaru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59311 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab3CKOrb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Mar 2013 10:47:31 -0400
In-Reply-To: <1362415968-2210-1-git-send-email-devendra.aaru@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Devendra Naga <devendra.aaru@gmail.com>
Cc: linux-pm@vger.kernel.org

On Mon, 2013-03-04 at 11:52 -0500, Devendra Naga wrote:
> thermal_zone_device_register returns a value contained in the pointer itself
> use PTR_ERR to obtain the address and return it at the end.
> 
> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>

Applied to thermal -next.

thanks,
rui

> ---
>  drivers/thermal/rcar_thermal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 28f0919..f1726c9 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -363,6 +363,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	struct resource *res, *irq;
>  	int mres = 0;
>  	int i;
> +	int ret = -ENODEV;
>  	int idle = IDLE_INTERVAL;
>  
>  	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
> @@ -441,6 +442,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  						idle);
>  		if (IS_ERR(priv->zone)) {
>  			dev_err(dev, "can't register thermal zone\n");
> +			ret = PTR_ERR(priv->zone);
>  			goto error_unregister;
>  		}
>  
> @@ -460,7 +462,7 @@ error_unregister:
>  	rcar_thermal_for_each_priv(priv, common)
>  		thermal_zone_device_unregister(priv->zone);
>  
> -	return -ENODEV;
> +	return ret;
>  }
>  
>  static int rcar_thermal_remove(struct platform_device *pdev)


