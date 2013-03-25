From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] thermal: rcar: tidyup registration failure case
Date: Mon, 25 Mar 2013 16:40:56 +0800
Message-ID: <1364200856.2465.48.camel@rzhang1-mobl4>
References: <87620gqbbe.wl%kuninori.morimoto.gx@renesas.com>
	 <874ng0qb9f.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46722 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755325Ab3CYIlA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Mar 2013 04:41:00 -0400
In-Reply-To: <874ng0qb9f.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

On Sun, 2013-03-24 at 22:49 -0700, Kuninori Morimoto wrote:
> Current rcar_thermal driver didn't care about rcar_theraml_irq_disable()
> when registration failure case on _probe(), and _remove().
> And, it returns without unregistering thermal zone when
> registration failure case on _probe().
> This patch fixes these issue.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/thermal/rcar_thermal.c |   20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 28f0919..359e943 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -419,13 +419,15 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  		if (!priv) {
>  			dev_err(dev, "Could not allocate priv\n");
> -			return -ENOMEM;
> +			ret = -ENOMEM;
> +			goto error_unregister;
>  		}
>  
>  		priv->base = devm_request_and_ioremap(dev, res);
>  		if (!priv->base) {
>  			dev_err(dev, "Unable to ioremap priv register\n");
> -			return -ENOMEM;
> +			ret = -ENOMEM;
> +			goto error_unregister;
>  		}
>  
>  		priv->common = common;
> @@ -444,10 +446,10 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  			goto error_unregister;
>  		}
>  
> -		list_move_tail(&priv->list, &common->head);
> -
>  		if (rcar_has_irq_support(priv))
>  			rcar_thermal_irq_enable(priv);
> +
> +		list_move_tail(&priv->list, &common->head);
>  	}
>  
why do you need this change for the rcar_thermal_irq_disable issue?

thanks,
rui
>  	platform_set_drvdata(pdev, common);
> @@ -457,8 +459,11 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	return 0;
>  
>  error_unregister:
> -	rcar_thermal_for_each_priv(priv, common)
> +	rcar_thermal_for_each_priv(priv, common) {
>  		thermal_zone_device_unregister(priv->zone);
> +		if (rcar_has_irq_support(priv))
> +			rcar_thermal_irq_disable(priv);
> +	}
>  
>  	return -ENODEV;
>  }
> @@ -468,8 +473,11 @@ static int rcar_thermal_remove(struct platform_device *pdev)
>  	struct rcar_thermal_common *common = platform_get_drvdata(pdev);
>  	struct rcar_thermal_priv *priv;
>  
> -	rcar_thermal_for_each_priv(priv, common)
> +	rcar_thermal_for_each_priv(priv, common) {
>  		thermal_zone_device_unregister(priv->zone);
> +		if (rcar_has_irq_support(priv))
> +			rcar_thermal_irq_disable(priv);
> +	}
>  
>  	platform_set_drvdata(pdev, NULL);
>  


