From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: rcar_thermal: don't call
 thermal_zone_device_unregister when USE_OF_THERMAL
Date: Mon, 22 Aug 2016 15:52:53 +0800
Message-ID: <1471852373.2188.23.camel@intel.com>
References: <8760qtv6on.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:49437 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750839AbcHVHw6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Aug 2016 03:52:58 -0400
In-Reply-To: <8760qtv6on.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, PhucBui <bd-phuc@jinso.co.jp>

On 一, 2016-08-22 at 03:19 +0000, Kuninori Morimoto wrote:
> From: Bui Duc Phuc <bd-phuc@jinso.co.jp>
> 
> devm_thermal_zone_of_sensor_register() case doesn't need to call
> thermal_zone_device_unregister().
> Otherwise, rcar-thermal can't register thermal zone again after
> rebind.
> This patch fixes it.
> 
> Signed-off-by: Bui Duc Phuc <bd-phuc@jinso.co.jp>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Patch applied.

thanks,
rui
> ---
>  drivers/thermal/rcar_thermal.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c
> b/drivers/thermal/rcar_thermal.c
> index 4d07644..b5c6442 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -419,9 +419,10 @@ static int rcar_thermal_remove(struct
> platform_device *pdev)
>  
>  	rcar_thermal_for_each_priv(priv, common) {
>  		rcar_thermal_irq_disable(priv);
> -		thermal_zone_device_unregister(priv->zone);
>  		if (rcar_use_of_thermal(dev))
>  			thermal_remove_hwmon_sysfs(priv->zone);
> +		else
> +			thermal_zone_device_unregister(priv->zone);
>  	}
>  
>  	pm_runtime_put(dev);
