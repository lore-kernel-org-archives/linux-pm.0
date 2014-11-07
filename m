From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 04/21] thermal: of: Extend current of-thermal.c code to
 allow setting emulated temp
Date: Fri, 07 Nov 2014 12:20:35 +0100
Message-ID: <20141107122035.2973ad20@amdc2363>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-5-git-send-email-l.majewski@samsung.com>
 <20141107014448.GE10180@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20141107014448.GE10180@developer>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

> Hello,
> 
> On Thu, Oct 09, 2014 at 06:38:40PM +0200, Lukasz Majewski wrote:
> > Before this change it was only possible to set get_temp() and
> > get_trend() methods to be used in the common code handling passing
> > parameters via device tree to "cpu-thermal" CPU thermal zone device.
> > 
> > Now it is possible to also set emulated value of temperature for
> > debug purposes.
> > 
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> >  drivers/thermal/of-thermal.c | 25 ++++++++++++++++++++++---
> >  include/linux/thermal.h      |  6 ++++--
> >  2 files changed, 26 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/thermal/of-thermal.c
> > b/drivers/thermal/of-thermal.c index cd74e64..f206375 100644
> > --- a/drivers/thermal/of-thermal.c
> > +++ b/drivers/thermal/of-thermal.c
> > @@ -98,10 +98,22 @@ struct __thermal_zone {
> >  	void *sensor_data;
> >  	int (*get_temp)(void *, long *);
> >  	int (*get_trend)(void *, long *);
> > +	int (*set_emul_temp)(void *, unsigned long);
> >  };
> >  
> >  /***   DT thermal zone device callbacks   ***/
> >  
> > +static int of_thermal_set_emul_temp(struct thermal_zone_device *tz,
> > +				    unsigned long temp)
> > +{
> > +	struct __thermal_zone *data = tz->devdata;
> > +
> > +	if (!data->set_emul_temp)
> > +		return -EINVAL;
> > +
> > +	return data->set_emul_temp(data->sensor_data, temp);
> > +}
> > +
> >  static int of_thermal_get_temp(struct thermal_zone_device *tz,
> >  			       unsigned long *temp)
> >  {
> > @@ -352,7 +364,8 @@ static struct thermal_zone_device *
> >  thermal_zone_of_add_sensor(struct device_node *zone,
> >  			   struct device_node *sensor, void *data,
> >  			   int (*get_temp)(void *, long *),
> > -			   int (*get_trend)(void *, long *))
> > +			   int (*get_trend)(void *, long *),
> > +			   int (*set_emul_temp)(void *, unsigned
> > long))
> 
> Thanks for improving the API. However, looking at what is above, it
> starts to be pretty ugly. And for sure, this is not the last callback
> to be added.

Presumably there would be some more callbacks.

> I believe it is time to add a .ops in the of-thermal.
> While in here, do you mind adding the .ops in a separated patch, then
> add the .set_emul_temp in the .ops field?

I will add an option to pass .ops with thermal_zone_of_add_sensor().

I'm only concerned a bit about testing other users of of-thermal. 
I have only beaglebone black (BBB) for testing, which on-soc bandgap
thermal sensor is very inaccurate and hence not supported even at BBB
github linux kernel repository (v3.14).

Because of above I would need your support for testing.

> 
> >  {
> >  	struct thermal_zone_device *tzd;
> >  	struct __thermal_zone *tz;
> > @@ -366,10 +379,12 @@ thermal_zone_of_add_sensor(struct device_node
> > *zone, mutex_lock(&tzd->lock);
> >  	tz->get_temp = get_temp;
> >  	tz->get_trend = get_trend;
> > +	tz->set_emul_temp = set_emul_temp;
> >  	tz->sensor_data = data;
> >  
> >  	tzd->ops->get_temp = of_thermal_get_temp;
> >  	tzd->ops->get_trend = of_thermal_get_trend;
> > +	tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
> >  	mutex_unlock(&tzd->lock);
> >  
> >  	return tzd;
> > @@ -411,7 +426,8 @@ thermal_zone_of_add_sensor(struct device_node
> > *zone, struct thermal_zone_device *
> >  thermal_zone_of_sensor_register(struct device *dev, int sensor_id,
> >  				void *data, int (*get_temp)(void
> > *, long *),
> > -				int (*get_trend)(void *, long *))
> > +				int (*get_trend)(void *, long *),
> > +				int (*set_emul_temp)(void *,
> > unsigned long)) {
> >  	struct device_node *np, *child, *sensor_np;
> >  
> > @@ -453,7 +469,8 @@ thermal_zone_of_sensor_register(struct device
> > *dev, int sensor_id, return thermal_zone_of_add_sensor(child,
> > sensor_np, data,
> >  							  get_temp,
> > -
> > get_trend);
> > +
> > get_trend,
> > +
> > set_emul_temp); }
> >  	}
> >  	of_node_put(np);
> > @@ -494,9 +511,11 @@ void thermal_zone_of_sensor_unregister(struct
> > device *dev, mutex_lock(&tzd->lock);
> >  	tzd->ops->get_temp = NULL;
> >  	tzd->ops->get_trend = NULL;
> > +	tzd->ops->set_emul_temp = NULL;
> >  
> >  	tz->get_temp = NULL;
> >  	tz->get_trend = NULL;
> > +	tz->set_emul_temp = NULL;
> >  	tz->sensor_data = NULL;
> >  	mutex_unlock(&tzd->lock);
> >  }
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index 0305cde..36010e9 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -290,14 +290,16 @@ struct thermal_genl_event {
> >  struct thermal_zone_device *
> >  thermal_zone_of_sensor_register(struct device *dev, int id,
> >  				void *data, int (*get_temp)(void
> > *, long *),
> > -				int (*get_trend)(void *, long *));
> > +				int (*get_trend)(void *, long *),
> > +				int (*set_emul_temp)(void *,
> > unsigned long)); void thermal_zone_of_sensor_unregister(struct
> > device *dev, struct thermal_zone_device *tz);
> >  #else
> >  static inline struct thermal_zone_device *
> >  thermal_zone_of_sensor_register(struct device *dev, int id,
> >  				void *data, int (*get_temp)(void
> > *, long *),
> > -				int (*get_trend)(void *, long *))
> > +				int (*get_trend)(void *, long *),
> > +				int (*set_emul_temp)(void *,
> > unsigned long)) {
> >  	return NULL;
> >  }
> > -- 
> > 2.0.0.rc2
> > 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
