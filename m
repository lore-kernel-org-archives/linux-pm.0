From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] thermal: rcar: add .get_trip_type/temp and .notify
 support
Date: Mon, 26 Nov 2012 09:52:14 +0800
Message-ID: <1353894734.2299.16.camel@rzhang1-mobl4>
References: <87sj82uo7o.wl%kuninori.morimoto.gx@renesas.com>
	 <87pq36uo5v.wl%kuninori.morimoto.gx@renesas.com>
	 <1353652189.2111.7.camel@rzhang1-mobl4>
	 <87k3t9w39m.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37198 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501Ab2KZBwR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 25 Nov 2012 20:52:17 -0500
In-Reply-To: <87k3t9w39m.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, linux-pm@vger.kernel.org

On Sun, 2012-11-25 at 17:40 -0800, Kuninori Morimoto wrote:
> Hi Zhang
> 
> Thank you for your reply
> 
> > > +static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
> > > +				      int trip, unsigned long *temp)
> > > +{
> > > +	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> > > +
> > > +	/* see rcar_thermal_get_temp() */
> > > +	switch (trip) {
> > > +	case 0: /* -45 <= temp < +45 */
> > > +		*temp = -45 - 1;
> > > +		break;
> > 
> > does this mean you expect the thermal driver to take some action when
> > the temperature is higher than -45C?
> > 
> > > +	case 1: /* +45 <= temp < +90 */
> > > +		*temp = 45 - 1;
> > > +		break;
> > what do you expect to happen when the temperature is higher than 45C but
> > lower than 90C?
> > 
> > > +	case 2: /* +90 <= temp < +135 */
> > > +		*temp = 90 - 1;
> > > +		break;
> > > +	default:
> > > +		dev_err(priv->dev, "rcar driver trip error\n");
> > > +		return -EINVAL;
> > > +	}
> (snip)
> > >  static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
> > > -	.get_temp = rcar_thermal_get_temp,
> > > +	.get_temp	= rcar_thermal_get_temp,
> > > +	.get_trip_type	= rcar_thermal_get_trip_type,
> > > +	.get_trip_temp	= rcar_thermal_get_trip_temp,
> > > +	.notify		= rcar_thermal_notify,
> > >  };
> > >  
> > how does the active trip point work if you do not bind any cooling
> > devices to it?
> > 
> > >  /*
> > > @@ -212,8 +286,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
> > >  		goto error_free_priv;
> > >  	}
> > >  
> > > -	zone = thermal_zone_device_register("rcar_thermal", 0, 0, priv,
> > > -					    &rcar_thermal_zone_ops, 0, 0);
> > > +	zone = thermal_zone_device_register("rcar_thermal", 4, 0, priv,
> > > +					    &rcar_thermal_zone_ops, 0,
> > > +					    IDLE_INTERVAL);
> > 
> > there is no interrupt for any thermal changes on this platform,
> > including critical overheat, right?
> 
> Now, we need critical shutdown only at this point.
> Then, should I remove active/hot trip ?
> If yes, I can send v2 patch.
> 
yep, please remove active and hot trip points.

> BTW, does thermal frame work use 45C ? or 45*1000 mC ?
> Maybe A * 1000 mC is correct ?
> 

I'm not sure if I understand correctly.
The unit of trip point temperature is Milli-Celsius.

thanks,
rui

