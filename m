From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 3/3] thermal: rcar: add .get_trip_type/temp and .notify
 support
Date: Mon, 03 Dec 2012 09:02:36 +0800
Message-ID: <1354496556.1936.7.camel@rzhang1-mobl4>
References: <87sj82uo7o.wl%kuninori.morimoto.gx@renesas.com>
	 <87pq36uo5v.wl%kuninori.morimoto.gx@renesas.com>
	 <1353652189.2111.7.camel@rzhang1-mobl4>
	 <87k3t9w39m.wl%kuninori.morimoto.gx@renesas.com>
	 <1353894734.2299.16.camel@rzhang1-mobl4>
	 <87ip8tw0x1.wl%kuninori.morimoto.gx@renesas.com>
	 <87ehjhw0ty.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:21519 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224Ab2LCBCq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 20:02:46 -0500
In-Reply-To: <87ehjhw0ty.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

On Sun, 2012-11-25 at 18:32 -0800, Kuninori Morimoto wrote:
> This patch adds .get_trip_type(), .get_trip_temp(), and .notify()
> on rcar_thermal_zone_ops.
> Driver will try platform power OFF if it reached to
> critical temperature.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/thermal/rcar_thermal.c |   68 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 90db951..e1aedcc 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -22,10 +22,13 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/reboot.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/thermal.h>
>  
> +#define IDLE_INTERVAL	5000
> +
>  #define THSCR	0x2c
>  #define THSSR	0x30
>  
> @@ -176,8 +179,66 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone,
>  	return 0;
>  }
>  
> +static int rcar_thermal_get_trip_type(struct thermal_zone_device *zone,
> +				      int trip, enum thermal_trip_type *type)
> +{
> +	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> +
> +	/* see rcar_thermal_get_temp() */
> +	switch (trip) {
> +	case 0: /* +90 <= temp < +135 */
> +		*type = THERMAL_TRIP_CRITICAL;
> +		break;
> +	default:
> +		dev_err(priv->dev, "rcar driver trip error\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
> +				      int trip, unsigned long *temp)
> +{
> +	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> +
> +	/* see rcar_thermal_get_temp() */
> +	switch (trip) {
> +	case 0: /* +90 <= temp < +135 */
> +		*temp = MCELSIUS(90 - 1);

what does the comment above mean?
the system is supposed to run from 90C to 135C? but you're setting the
critical trip point to 89C.

thanks,
rui

