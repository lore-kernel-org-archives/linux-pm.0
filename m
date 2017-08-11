From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/3 v2] thermal: core: Add some new helper functions to
 free resources
Date: Fri, 11 Aug 2017 11:31:36 +0800
Message-ID: <1502422296.2598.17.camel@intel.com>
References: <cover.1502201798.git.christophe.jaillet@wanadoo.fr>
         <98e96edd53ea3109ec127f82608c8d5df5437c9c.1502201798.git.christophe.jaillet@wanadoo.fr>
         <1502421828.2598.13.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502421828.2598.13.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2017-08-11 at 11:23 +0800, Zhang Rui wrote:
> On Tue, 2017-08-08 at 16:39 +0200, Christophe JAILLET wrote:
> > 
> > In order to easily free resources allocated by
> > 'thermal_zone_create_device_groups()' we need 2 new helper
> > functions.
> > 
> > The first one undoes 'thermal_zone_create_device_groups()'.
> > The 2nd one undoes 'create_trip_attrs()', which is a function
> > called
> > by
> > 'thermal_zone_create_device_groups()'.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > These functions will be used in patch 2/3 in order to simplify
> > 'thermal_release()'
> > I've tried to implement it as close a possible as the way the
> > resources have
> > been allocated.
> > However, in 'thermal_release()', the code is simplier without some
> > additionnal 'if'.
> > No sure if we should prefer consistancy with allocation or
> > simplicity
> > of code.
> > ---
> >  drivers/thermal/thermal_core.h  |  1 +
> >  drivers/thermal/thermal_sysfs.c | 29 +++++++++++++++++++++++++++++
> >  2 files changed, 30 insertions(+)
> > 
> > diff --git a/drivers/thermal/thermal_core.h
> > b/drivers/thermal/thermal_core.h
> > index 2412b3759e16..27e3b1df7360 100644
> > --- a/drivers/thermal/thermal_core.h
> > +++ b/drivers/thermal/thermal_core.h
> > @@ -71,6 +71,7 @@ int thermal_build_list_of_policies(char *buf);
> >  
> >  /* sysfs I/F */
> >  int thermal_zone_create_device_groups(struct thermal_zone_device
> > *,
> > int);
> > +void thermal_zone_destroy_device_groups(struct thermal_zone_device
> > *);
> >  void thermal_cooling_device_setup_sysfs(struct
> > thermal_cooling_device *);
> >  /* used only at binding time */
> >  ssize_t
> > diff --git a/drivers/thermal/thermal_sysfs.c
> > b/drivers/thermal/thermal_sysfs.c
> > index a694de907a26..eb95d64b9446 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -605,6 +605,24 @@ static int create_trip_attrs(struct
> > thermal_zone_device *tz, int mask)
> >  	return 0;
> >  }
> >  
> > +/**
> > + * destroy_trip_attrs() - create attributes for trip points
> s/create/destroy
> 
> > 
> > + * @tz:		the thermal zone device
> > + *
> > + * helper function to free resources alocated by
> > create_trip_attrs()
> s/alocated/allocated
> 
as I have only two minor comments for this patch set, I will apply it
directly, with these two typos fixed.

thanks,
rui
> thanks,
> rui
> > 
> > + */
> > +static void destroy_trip_attrs(struct thermal_zone_device *tz)
> > +{
> > +	if (!tz)
> > +		return;
> > +
> > +	kfree(tz->trip_type_attrs);
> > +	kfree(tz->trip_temp_attrs);
> > +	if (tz->ops->get_trip_hyst)
> > +		kfree(tz->trip_hyst_attrs);
> > +	kfree(tz->trips_attribute_group.attrs);
> > +}
> > +
> >  int thermal_zone_create_device_groups(struct thermal_zone_device
> > *tz,
> >  				      int mask)
> >  {
> > @@ -637,6 +655,17 @@ int thermal_zone_create_device_groups(struct
> > thermal_zone_device *tz,
> >  	return 0;
> >  }
> >  
> > +void thermal_zone_destroy_device_groups(struct thermal_zone_device
> > *tz)
> > +{
> > +	if (!tz)
> > +		return;
> > +
> > +	if (tz->trips)
> > +		destroy_trip_attrs(tz);
> > +
> > +	kfree(tz->device.groups);
> > +}
> > +
> >  /* sys I/F for cooling device */
> >  static ssize_t
> >  thermal_cooling_device_type_show(struct device *dev,
