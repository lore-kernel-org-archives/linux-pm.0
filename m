From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] thermal: rcar: remove unnecessary OOM messages
Date: Sun, 11 May 2014 09:49:22 +0900
Message-ID: <20140511004922.GX31760@verge.net.au>
References: <01a401cf69ba$0f1b88d0$2d529a70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:52927 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758036AbaEKIgt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 11 May 2014 04:36:49 -0400
Content-Disposition: inline
In-Reply-To: <01a401cf69ba$0f1b88d0$2d529a70$%han@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Zhang Rui' <rui.zhang@intel.com>, 'Eduardo Valentin' <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, 'Kuninori Morimoto' <kuninori.morimoto.gx@renesas.com>

On Wed, May 07, 2014 at 03:03:25PM +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/thermal/rcar_thermal.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 5a37940..105ab5e 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -374,10 +374,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  	int idle = IDLE_INTERVAL;
>  
>  	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
> -	if (!common) {
> -		dev_err(dev, "Could not allocate common\n");
> +	if (!common)
>  		return -ENOMEM;
> -	}
>  
>  	INIT_LIST_HEAD(&common->head);
>  	spin_lock_init(&common->lock);
> @@ -423,7 +421,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  
>  		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  		if (!priv) {
> -			dev_err(dev, "Could not allocate priv\n");
>  			ret = -ENOMEM;
>  			goto error_unregister;
>  		}
> -- 
> 1.7.10.4
> 
> 
