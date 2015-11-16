From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/2] thermal: rcar_thermal: remove redundant operation
Date: Mon, 16 Nov 2015 10:42:44 -0800
Message-ID: <20151116184242.GA6349@localhost.localdomain>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
 <87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>
 <87egfylia4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34421 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbbKPSmr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 13:42:47 -0500
Content-Disposition: inline
In-Reply-To: <87egfylia4.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, cm-hiep@jinso.co.jp, nv-dung@jinso.co.jp

On Tue, Nov 10, 2015 at 02:12:06AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Probe error operation and remove operation are same.
> Let's use same function.

I am picking this one and sending for next rc cycle. The second  patch
is still under discussion and the issue may be solved differently,
so for now I wont get that. 

BR,

> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/thermal/rcar_thermal.c | 49 ++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 5d4ae7d..13d01ed 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -361,6 +361,24 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
>  /*
>   *		platform functions
>   */
> +static int rcar_thermal_remove(struct platform_device *pdev)
> +{
> +	struct rcar_thermal_common *common = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	struct rcar_thermal_priv *priv;
> +
> +	rcar_thermal_for_each_priv(priv, common) {
> +		if (rcar_has_irq_support(priv))
> +			rcar_thermal_irq_disable(priv);
> +		thermal_zone_device_unregister(priv->zone);
> +	}
> +
> +	pm_runtime_put(dev);
> +	pm_runtime_disable(dev);
> +
> +	return 0;
> +}
> +
>  static int rcar_thermal_probe(struct platform_device *pdev)
>  {
>  	struct rcar_thermal_common *common;
> @@ -377,6 +395,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	if (!common)
>  		return -ENOMEM;
>  
> +	platform_set_drvdata(pdev, common);
> +
>  	INIT_LIST_HEAD(&common->head);
>  	spin_lock_init(&common->lock);
>  	common->dev = dev;
> @@ -454,43 +474,16 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  		rcar_thermal_common_write(common, ENR, enr_bits);
>  	}
>  
> -	platform_set_drvdata(pdev, common);
> -
>  	dev_info(dev, "%d sensor probed\n", i);
>  
>  	return 0;
>  
>  error_unregister:
> -	rcar_thermal_for_each_priv(priv, common) {
> -		if (rcar_has_irq_support(priv))
> -			rcar_thermal_irq_disable(priv);
> -		thermal_zone_device_unregister(priv->zone);
> -	}
> -
> -	pm_runtime_put(dev);
> -	pm_runtime_disable(dev);
> +	rcar_thermal_remove(pdev);
>  
>  	return ret;
>  }
>  
> -static int rcar_thermal_remove(struct platform_device *pdev)
> -{
> -	struct rcar_thermal_common *common = platform_get_drvdata(pdev);
> -	struct device *dev = &pdev->dev;
> -	struct rcar_thermal_priv *priv;
> -
> -	rcar_thermal_for_each_priv(priv, common) {
> -		if (rcar_has_irq_support(priv))
> -			rcar_thermal_irq_disable(priv);
> -		thermal_zone_device_unregister(priv->zone);
> -	}
> -
> -	pm_runtime_put(dev);
> -	pm_runtime_disable(dev);
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id rcar_thermal_dt_ids[] = {
>  	{ .compatible = "renesas,rcar-thermal", },
>  	{},
> -- 
> 1.9.1
> 
