From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2 1/3] thermal: Add support for hierarchical thermal
 zones
Date: Mon, 9 Nov 2015 15:20:35 +0000
Message-ID: <20151109152034.GB3120@e104805>
References: <1446658662-19582-1-git-send-email-javi.merino@arm.com>
 <1446658662-19582-2-git-send-email-javi.merino@arm.com>
 <20151104185101.GB12825@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51110 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbbKIPUi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 10:20:38 -0500
Content-Disposition: inline
In-Reply-To: <20151104185101.GB12825@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zang@intel.com, Zhang Rui <rui.zhang@intel.com>

On Wed, Nov 04, 2015 at 10:51:02AM -0800, Eduardo Valentin wrote:
> Javi,
> 
> First of all, thanks for taking the lead on implementing this.
> 
> It follows comments.
> 
> On Wed, Nov 04, 2015 at 05:37:40PM +0000, Javi Merino wrote:
> > Add the ability to stack thermal zones on top of each other, creating a
> > hierarchy of thermal zones.
> > 
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > ---
> >  Documentation/thermal/sysfs-api.txt |  35 +++++++++
> >  drivers/thermal/thermal_core.c      | 151 ++++++++++++++++++++++++++++++++++--
> >  include/linux/thermal.h             |  14 ++++
> >  3 files changed, 195 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> > index 10f062ea6bc2..5650b7eaaf7e 100644
> > --- a/Documentation/thermal/sysfs-api.txt
> > +++ b/Documentation/thermal/sysfs-api.txt
> > @@ -72,6 +72,41 @@ temperature) and throttle appropriate devices.
> >      It deletes the corresponding entry form /sys/class/thermal folder and
> >      unbind all the thermal cooling devices it uses.
> >  
> > +
> > +1.1.3 int thermal_zone_add_subtz(struct thermal_zone_device *tz,
> > +                                 struct thermal_zone_device *subtz)
> > +
> > +    Add subtz to the list of slaves of tz.  When calculating the
> > +    temperature of thermal zone tz, report the maximum of the slave
> > +    thermal zones.  This lets you create a hierarchy of thermal zones.
> > +    The hierarchy must be a Direct Acyclic Graph (DAG).  If a loop is
> > +    detected, thermal_zone_get_temp() will return -EDEADLK to prevent
> > +    the deadlock.  thermal_zone_add_subtz() does not affect subtz.
> > +
> > +    For example, if you have an SoC with a thermal sensor in each cpu
> > +    of the two cpus you could have a thermal zone to monitor each
> > +    sensor, let's call them cpu0_tz and cpu1_tz.  You could then have a
> > +    a SoC thermal zone (soc_tz) without a get_temp() op which can be
> > +    configured like this:
> > +
> > +    thermal_zone_add_subtz(soc_tz, cpu0_tz);
> > +    thermal_zone_add_subtz(soc_tz, cpu1_tz);
> > +
> > +    Now soc_tz's temperature is the maximum of cpu0_tz and cpu1_tz.
> > +    Furthermore, soc_tz could be combined with other thermal zones to
> > +    create a "device" thermal zone.
> > +
> > +
> > +1.1.4 int thermal_zone_del_subtz(struct thermal_zone_device *tz,
> > +                                 struct thermal_zone_device *subtz)
> > +
> > +    Delete subtz from the slave thermal zones of tz.  This basically
> > +    reverses what thermal_zone_add_subtz() does.  If tz still has
> > +    other slave thermal zones, its temperature would be the maximum of
> > +    the remaining slave thermal zones.  If tz no longer has slave
> > +    thermal zones, thermal_zone_get_temp() will return -EINVAL.
> > +
> > +
> >  1.2 thermal cooling device interface
> >  1.2.1 struct thermal_cooling_device *thermal_cooling_device_register(char *name,
> >  		void *devdata, struct thermal_cooling_device_ops *)
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index d9e525cc9c1c..a2ab482337f3 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -61,6 +61,11 @@ static DEFINE_MUTEX(thermal_governor_lock);
> >  
> >  static struct thermal_governor *def_governor;
> >  
> > +struct thermal_zone_link {
> > +	struct thermal_zone_device *slave;
> > +	struct list_head node;
> > +};
> > +
> >  static struct thermal_governor *__find_governor(const char *name)
> >  {
> >  	struct thermal_governor *pos;
> > @@ -465,6 +470,42 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
> >  }
> >  
> >  /**
> > + * get_subtz_temp() - get the maximum temperature of all the sub thermal zones
> > + * @tz:	thermal zone pointer
> > + * @temp: pointer in which to store the result
> > + *
> > + * Go through all the thermal zones listed in @tz slave_tzs and
> > + * calculate the maximum temperature of all of them.  The maximum
> > + * temperature is stored in @temp.
> > + *
> > + * Return: 0 on success, -EINVAL if there are no slave thermal zones,
> > + * -E* if thermal_zone_get_temp() fails for any of the slave thermal
> > + * zones.
> > + */
> > +static int get_subtz_temp(struct thermal_zone_device *tz, int *temp)
> > +{
> > +	struct thermal_zone_link *link;
> > +	int max_temp = INT_MIN;
> > +
> > +	if (list_empty(&tz->slave_tzs))
> > +		return -EINVAL;
> > +
> > +	list_for_each_entry(link, &tz->slave_tzs, node) {
> > +		int this_temp, ret;
> > +
> > +		ret = thermal_zone_get_temp(link->slave, &this_temp);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (this_temp > max_temp)
> > +			max_temp = this_temp;
> 
> I think we need a better design here. I do not like the fact that we are
> limited to max temp operation. Remember the LPC discussion? I believe
> the agreement was to have a set of aggregation functions. max temp is
> definetly one of them. Also the aggregation functions would be sysfs
> configurable.

I wasn't sure how to do this from device tree.  There's a coefficients
property but it's not really usable as it's defined as:

Z = c0 * x0 + c1 * x1 + ... + c(n-1) * x(n-1) + cn

Where all the c are integers.  As the x are temperatures, the result
can't be a temperature.  It could work if we said that we divide the
result byt the sum of the coefficients, making it a weighted sum.
something like:

Z = (c0 * x0 + c1 * x1 + ... + c(n-1) * x(n-1)) / (c0 + c1 + ... + c(n-1)) + cn

I guess we can skip the device tree specification for now and just let
userspace configure it using sysfs.  I'll add "weighted sum" as an
additional aggregation function for v3.

Cheers,
Javi
