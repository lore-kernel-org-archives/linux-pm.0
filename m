From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] thermal: fix multiple disbalanced device node counters
Date: Wed, 8 Oct 2014 09:08:26 -0400
Message-ID: <20141008130824.GA16170@developer>
References: <1411948066-9118-1-git-send-email-vz@mleia.com>
 <1412818737.13621.3.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412818737.13621.3.camel@rzhang1-toshiba>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 09, 2014 at 09:38:57AM +0800, Zhang Rui wrote:
> Hi, Eduardo,
> 
> On Mon, 2014-09-29 at 02:47 +0300, Vladimir Zapolskiy wrote:
> > Here on function return all temporarily used device nodes shall
> > decrement their usage counter. The problems are found with device
> > nodes allocated by for_each_child_of_node(), of_parse_phandle()
> > and of_find_node_by_name(), fix all problems at once.
> > 
> can you please take this patch?

Yes, Applied. Thanks.

> 
> thanks,
> rui
> > Signed-off-by: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
> > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/thermal/of-thermal.c |   40 ++++++++++++++++++++++++++++++++--------
> >  1 file changed, 32 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> > index f8eb625..62143ba 100644
> > --- a/drivers/thermal/of-thermal.c
> > +++ b/drivers/thermal/of-thermal.c
> > @@ -387,15 +387,18 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id,
> >  				int (*get_trend)(void *, long *))
> >  {
> >  	struct device_node *np, *child, *sensor_np;
> > +	struct thermal_zone_device *tzd = ERR_PTR(-ENODEV);
> >  
> >  	np = of_find_node_by_name(NULL, "thermal-zones");
> >  	if (!np)
> >  		return ERR_PTR(-ENODEV);
> >  
> > -	if (!dev || !dev->of_node)
> > +	if (!dev || !dev->of_node) {
> > +		of_node_put(np);
> >  		return ERR_PTR(-EINVAL);
> > +	}
> >  
> > -	sensor_np = dev->of_node;
> > +	sensor_np = of_node_get(dev->of_node);
> >  
> >  	for_each_child_of_node(np, child) {
> >  		struct of_phandle_args sensor_specs;
> > @@ -422,16 +425,21 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id,
> >  		}
> >  
> >  		if (sensor_specs.np == sensor_np && id == sensor_id) {
> > -			of_node_put(np);
> > -			return thermal_zone_of_add_sensor(child, sensor_np,
> > -							  data,
> > -							  get_temp,
> > -							  get_trend);
> > +			tzd = thermal_zone_of_add_sensor(child, sensor_np,
> > +							 data,
> > +							 get_temp,
> > +							 get_trend);
> > +			of_node_put(sensor_specs.np);
> > +			of_node_put(child);
> > +			goto exit;
> >  		}
> > +		of_node_put(sensor_specs.np);
> >  	}
> > +exit:
> > +	of_node_put(sensor_np);
> >  	of_node_put(np);
> >  
> > -	return ERR_PTR(-ENODEV);
> > +	return tzd;
> >  }
> >  EXPORT_SYMBOL_GPL(thermal_zone_of_sensor_register);
> >  
> > @@ -623,6 +631,7 @@ static int thermal_of_populate_trip(struct device_node *np,
> >  
> >  	/* Required for cooling map matching */
> >  	trip->np = np;
> > +	of_node_get(np);
> >  
> >  	return 0;
> >  }
> > @@ -730,9 +739,14 @@ finish:
> >  	return tz;
> >  
> >  free_tbps:
> > +	for (i = 0; i < tz->num_tbps; i++)
> > +		of_node_put(tz->tbps[i].cooling_device);
> >  	kfree(tz->tbps);
> >  free_trips:
> > +	for (i = 0; i < tz->ntrips; i++)
> > +		of_node_put(tz->trips[i].np);
> >  	kfree(tz->trips);
> > +	of_node_put(gchild);
> >  free_tz:
> >  	kfree(tz);
> >  	of_node_put(child);
> > @@ -742,7 +756,13 @@ free_tz:
> >  
> >  static inline void of_thermal_free_zone(struct __thermal_zone *tz)
> >  {
> > +	int i;
> > +
> > +	for (i = 0; i < tz->num_tbps; i++)
> > +		of_node_put(tz->tbps[i].cooling_device);
> >  	kfree(tz->tbps);
> > +	for (i = 0; i < tz->ntrips; i++)
> > +		of_node_put(tz->trips[i].np);
> >  	kfree(tz->trips);
> >  	kfree(tz);
> >  }
> > @@ -814,10 +834,13 @@ int __init of_parse_thermal_zones(void)
> >  			/* attempting to build remaining zones still */
> >  		}
> >  	}
> > +	of_node_put(np);
> >  
> >  	return 0;
> >  
> >  exit_free:
> > +	of_node_put(child);
> > +	of_node_put(np);
> >  	of_thermal_free_zone(tz);
> >  
> >  	/* no memory available, so free what we have built */
> > @@ -859,4 +882,5 @@ void of_thermal_destroy_zones(void)
> >  		kfree(zone->ops);
> >  		of_thermal_free_zone(zone->devdata);
> >  	}
> > +	of_node_put(np);
> >  }
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
