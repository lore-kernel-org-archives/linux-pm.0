From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/3] thermal: rcar: fixup the unit of temperature
Date: Mon, 26 Nov 2012 10:59:04 +0800
Message-ID: <1353898744.2299.29.camel@rzhang1-mobl4>
References: <87sj82uo7o.wl%kuninori.morimoto.gx@renesas.com>
	 <87pq36uo5v.wl%kuninori.morimoto.gx@renesas.com>
	 <1353652189.2111.7.camel@rzhang1-mobl4>
	 <87k3t9w39m.wl%kuninori.morimoto.gx@renesas.com>
	 <1353894734.2299.16.camel@rzhang1-mobl4>
	 <87ip8tw0x1.wl%kuninori.morimoto.gx@renesas.com>
	 <87haodw0v0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:25012 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379Ab2KZC7N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 25 Nov 2012 21:59:13 -0500
In-Reply-To: <87haodw0v0.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

On Sun, 2012-11-25 at 18:32 -0800, Kuninori Morimoto wrote:
> The unit of temperature is Milli-Celsius.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

applied.

thanks,
rui
> ---
>  drivers/thermal/rcar_thermal.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 81dce23..f2678ff 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -43,6 +43,8 @@ struct rcar_thermal_priv {
>  	u32 comp;
>  };
>  
> +#define MCELSIUS(temp)			((temp) * 1000)
> +
>  /*
>   *		basic functions
>   */
> @@ -169,7 +171,7 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone,
>  		}
>  	}
>  
> -	*temp = tmp;
> +	*temp = MCELSIUS(tmp);
>  	return 0;
>  }
>  


