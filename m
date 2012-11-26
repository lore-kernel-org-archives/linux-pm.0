From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/3] thermal: rcar: add rcar_zone_to_priv() macro
Date: Mon, 26 Nov 2012 10:59:32 +0800
Message-ID: <1353898772.2299.30.camel@rzhang1-mobl4>
References: <87sj82uo7o.wl%kuninori.morimoto.gx@renesas.com>
	 <87pq36uo5v.wl%kuninori.morimoto.gx@renesas.com>
	 <1353652189.2111.7.camel@rzhang1-mobl4>
	 <87k3t9w39m.wl%kuninori.morimoto.gx@renesas.com>
	 <1353894734.2299.16.camel@rzhang1-mobl4>
	 <87ip8tw0x1.wl%kuninori.morimoto.gx@renesas.com>
	 <87fw3xw0um.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8328 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753393Ab2KZC7f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 25 Nov 2012 21:59:35 -0500
In-Reply-To: <87fw3xw0um.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

On Sun, 2012-11-25 at 18:32 -0800, Kuninori Morimoto wrote:
> This patch adds rcar_zone_to_priv()
> which is a helper macro for gettign private data.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

applied.

thanks,
rui
> ---
>  drivers/thermal/rcar_thermal.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index f2678ff..90db951 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -44,6 +44,7 @@ struct rcar_thermal_priv {
>  };
>  
>  #define MCELSIUS(temp)			((temp) * 1000)
> +#define rcar_zone_to_priv(zone)		(zone->devdata)
>  
>  /*
>   *		basic functions
> @@ -98,7 +99,7 @@ static void rcar_thermal_bset(struct rcar_thermal_priv *priv, u32 reg,
>  static int rcar_thermal_get_temp(struct thermal_zone_device *zone,
>  			   unsigned long *temp)
>  {
> -	struct rcar_thermal_priv *priv = zone->devdata;
> +	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
>  	int val, min, max, tmp;
>  
>  	tmp = -200; /* default */


