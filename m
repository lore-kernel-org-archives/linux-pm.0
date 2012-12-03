From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 3/3] thermal: rcar: add .get_trip_type/temp and .notify
 support
Date: Mon, 03 Dec 2012 09:09:31 +0800
Message-ID: <1354496971.1936.12.camel@rzhang1-mobl4>
References: <87sj82uo7o.wl%kuninori.morimoto.gx@renesas.com>
	 <87pq36uo5v.wl%kuninori.morimoto.gx@renesas.com>
	 <1353652189.2111.7.camel@rzhang1-mobl4>
	 <87k3t9w39m.wl%kuninori.morimoto.gx@renesas.com>
	 <1353894734.2299.16.camel@rzhang1-mobl4>
	 <87ip8tw0x1.wl%kuninori.morimoto.gx@renesas.com>
	 <87ehjhw0ty.wl%kuninori.morimoto.gx@renesas.com>
	 <87obicq9c6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10570 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224Ab2LCBJh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 20:09:37 -0500
In-Reply-To: <87obicq9c6.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

Hi, Kuninori,

On Sun, 2012-12-02 at 16:15 -0800, Kuninori Morimoto wrote:
> Hi Zhang
> 
> I couldn't find this patch on v3.8 list.
> Is this patch not good ?
> 
No, the patch looks okay.
This patch set is sent too late for 3.8. Usually patches need to stay in
linux-next for at least two weeks before they are pushing upstream,
especially when there are some big changes made in the patch.
so I just picked up the first two, and leave this one for 3.9.

thanks,
rui

> > This patch adds .get_trip_type(), .get_trip_temp(), and .notify()
> > on rcar_thermal_zone_ops.
> > Driver will try platform power OFF if it reached to
> > critical temperature.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  drivers/thermal/rcar_thermal.c |   68 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 65 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> > index 90db951..e1aedcc 100644
> > --- a/drivers/thermal/rcar_thermal.c
> > +++ b/drivers/thermal/rcar_thermal.c
> > @@ -22,10 +22,13 @@
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/reboot.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/thermal.h>
> >  
> > +#define IDLE_INTERVAL	5000
> > +
> >  #define THSCR	0x2c
> >  #define THSSR	0x30
> >  
> > @@ -176,8 +179,66 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone,
> >  	return 0;
> >  }
> >  
> > +static int rcar_thermal_get_trip_type(struct thermal_zone_device *zone,
> > +				      int trip, enum thermal_trip_type *type)
> > +{
> > +	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> > +
> > +	/* see rcar_thermal_get_temp() */
> > +	switch (trip) {
> > +	case 0: /* +90 <= temp < +135 */
> > +		*type = THERMAL_TRIP_CRITICAL;
> > +		break;
> > +	default:
> > +		dev_err(priv->dev, "rcar driver trip error\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
> > +				      int trip, unsigned long *temp)
> > +{
> > +	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> > +
> > +	/* see rcar_thermal_get_temp() */
> > +	switch (trip) {
> > +	case 0: /* +90 <= temp < +135 */
> > +		*temp = MCELSIUS(90 - 1);
> > +		break;
> > +	default:
> > +		dev_err(priv->dev, "rcar driver trip error\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int rcar_thermal_notify(struct thermal_zone_device *zone,
> > +			       int trip, enum thermal_trip_type type)
> > +{
> > +	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> > +
> > +	switch (type) {
> > +	case THERMAL_TRIP_CRITICAL:
> > +		/* FIXME */
> > +		dev_warn(priv->dev,
> > +			 "Thermal reached to critical temperature\n");
> > +		machine_power_off();
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
> > -	.get_temp = rcar_thermal_get_temp,
> > +	.get_temp	= rcar_thermal_get_temp,
> > +	.get_trip_type	= rcar_thermal_get_trip_type,
> > +	.get_trip_temp	= rcar_thermal_get_trip_temp,
> > +	.notify		= rcar_thermal_notify,
> >  };
> >  
> >  /*
> > @@ -211,8 +272,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	}
> >  
> > -	zone = thermal_zone_device_register("rcar_thermal", 0, 0, priv,
> > -				    &rcar_thermal_zone_ops, NULL, 0, 0);
> > +	zone = thermal_zone_device_register("rcar_thermal", 1, 0, priv,
> > +					    &rcar_thermal_zone_ops, NULL, 0,
> > +					    IDLE_INTERVAL);
> >  	if (IS_ERR(zone)) {
> >  		dev_err(&pdev->dev, "thermal zone device is NULL\n");
> >  		return PTR_ERR(zone);
> > -- 
> > 1.7.9.5
> > 
> 
> 
> Best regards
> ---
> Kuninori Morimoto


