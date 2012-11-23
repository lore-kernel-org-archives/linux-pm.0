From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] thermal: rcar: add .get_trip_type/temp and .notify
 support
Date: Fri, 23 Nov 2012 14:29:49 +0800
Message-ID: <1353652189.2111.7.camel@rzhang1-mobl4>
References: <87sj82uo7o.wl%kuninori.morimoto.gx@renesas.com>
	 <87pq36uo5v.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:54007 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754616Ab2KWG3w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 23 Nov 2012 01:29:52 -0500
In-Reply-To: <87pq36uo5v.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, linux-pm@vger.kernel.org

On Wed, 2012-11-21 at 22:50 -0800, Kuninori Morimoto wrote:
> This patch adds .get_trip_type(), .get_trip_temp(), and .notify()
> on rcar_thermal_zone_ops.
> Driver will try platform power OFF if it reached to
> critical temperature.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/thermal/rcar_thermal.c |   81 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 78 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 454035c..16723ba 100644
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
> @@ -172,11 +175,82 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone,
>  	}
>  
>  	*temp = tmp;
> +
> +	return 0;
> +}
> +
> +static int rcar_thermal_get_trip_type(struct thermal_zone_device *zone,
> +				      int trip, enum thermal_trip_type *type)
> +{
> +	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> +
> +	/* see rcar_thermal_get_temp() */
> +	switch (trip) {
> +	case 0: /* -45 <= temp < +45 */
> +		*type = THERMAL_TRIP_ACTIVE;
> +		break;
> +	case 1: /* +45 <= temp < +90 */
> +		*type = THERMAL_TRIP_HOT;
> +		break;
> +	case 2: /* +90 <= temp < +135 */
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
> +	case 0: /* -45 <= temp < +45 */
> +		*temp = -45 - 1;
> +		break;

does this mean you expect the thermal driver to take some action when
the temperature is higher than -45C?

> +	case 1: /* +45 <= temp < +90 */
> +		*temp = 45 - 1;
> +		break;
what do you expect to happen when the temperature is higher than 45C but
lower than 90C?

> +	case 2: /* +90 <= temp < +135 */
> +		*temp = 90 - 1;
> +		break;
> +	default:
> +		dev_err(priv->dev, "rcar driver trip error\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rcar_thermal_notify(struct thermal_zone_device *zone,
> +			       int trip, enum thermal_trip_type type)
> +{
> +	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> +
> +	switch (type) {
> +	case THERMAL_TRIP_CRITICAL:
> +		/* FIXME */
> +		dev_warn(priv->dev,
> +			 "Thermal reached to critical temperature\n");
> +		machine_power_off();
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	return 0;
>  }
>  
>  static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
> -	.get_temp = rcar_thermal_get_temp,
> +	.get_temp	= rcar_thermal_get_temp,
> +	.get_trip_type	= rcar_thermal_get_trip_type,
> +	.get_trip_temp	= rcar_thermal_get_trip_temp,
> +	.notify		= rcar_thermal_notify,
>  };
>  
how does the active trip point work if you do not bind any cooling
devices to it?

>  /*
> @@ -212,8 +286,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  		goto error_free_priv;
>  	}
>  
> -	zone = thermal_zone_device_register("rcar_thermal", 0, 0, priv,
> -					    &rcar_thermal_zone_ops, 0, 0);
> +	zone = thermal_zone_device_register("rcar_thermal", 4, 0, priv,
> +					    &rcar_thermal_zone_ops, 0,
> +					    IDLE_INTERVAL);

there is no interrupt for any thermal changes on this platform,
including critical overheat, right?

thanks,
rui

