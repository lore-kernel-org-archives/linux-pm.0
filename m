From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2 7/7] thermal: export thermal_zone_parameters to sysfs
Date: Fri, 27 Feb 2015 17:19:05 +0000
Message-ID: <20150227171904.GA10658@e104805>
References: <1424977233-15965-1-git-send-email-javi.merino@arm.com>
 <1424977233-15965-8-git-send-email-javi.merino@arm.com>
 <20150226212958.GB29288@developer.amazonguestwifi.org>
 <20150226220423.GA5451@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43852 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069AbbB0RTJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 27 Feb 2015 12:19:09 -0500
Content-Disposition: inline
In-Reply-To: <20150226220423.GA5451@developer.amazonguestwifi.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, "tixy@linaro.org" <tixy@linaro.org>

On Thu, Feb 26, 2015 at 10:04:24PM +0000, Eduardo Valentin wrote:
> On Thu, Feb 26, 2015 at 05:30:00PM -0400, Eduardo Valentin wrote:
> > On Thu, Feb 26, 2015 at 07:00:33PM +0000, Javi Merino wrote:
> > > It's useful for tuning to be able to edit thermal_zone_parameters from
> > > userspace.  Export them to the thermal_zone sysfs so that they can be
> > > easily changed.
> > > 
> > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > Cc: Eduardo Valentin <edubezval@gmail.com>
> > > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > > ---
> > >  Documentation/thermal/sysfs-api.txt |  52 +++++++++++++++++
> > >  drivers/thermal/thermal_core.c      | 110 ++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 162 insertions(+)
> > > 
> > > diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> > > index fc7dfe10778b..7d44d7f1a71b 100644
> > > --- a/Documentation/thermal/sysfs-api.txt
> > > +++ b/Documentation/thermal/sysfs-api.txt
> > > @@ -184,6 +184,12 @@ Thermal zone device sys I/F, created once it's registered:
> > >      |---trip_point_[0-*]_type:	Trip point type
> > >      |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
> > >      |---emul_temp:		Emulated temperature set node
> > > +    |---sustainable_power:      Sustainable dissipatable power
> > > +    |---k_po:                   Proportional term during temperature overshoot
> > > +    |---k_pu:                   Proportional term during temperature undershoot
> > > +    |---k_i:                    PID's integral term in the power allocator gov
> > > +    |---k_d:                    PID's derivative term in the power allocator
> > > +    |---integral_cutoff:        Offset above which errors are accumulated
> > 
> > Can this be under a specific directory?
> > 
> > I thought of something like
> > /sys/class/thermal/thermal_zoneX/governor_params/<gov spec files>
> > 
> > The above node can be handled by the governor code.

I thought about doing that, but creating a sysfs directory was a lot
of boilerplate code that I thought didn't bring us anything.  That's
why I avoided it.

> > >  Thermal cooling device sys I/F, created once it's registered:
> > >  /sys/class/thermal/cooling_device[0-*]:
> > > @@ -307,6 +313,52 @@ emul_temp
> > >  	  because userland can easily disable the thermal policy by simply
> > >  	  flooding this sysfs node with low temperature values.
> > >  
> > > +sustainable_power
> > > +	An estimate of the sustained power that can be dissipated by
> > > +	the thermal zone. Used by the power allocator governor. For
> > > +	more information see Documentation/thermal/power_allocator.txt
> > > +	Unit: milliwatts
> > > +	RW, Optional
> > > +
> > > +k_po
> > > +	The proportional term of the power allocator governor's PID
> > > +	controller during temperature overshoot. Temperature overshoot
> > > +	is when the current temperature is above the "desired
> > > +	temperature" trip point. For more information see
> > > +	Documentation/thermal/power_allocator.txt
> > > +	RW, Optional
> > > +
> > > +k_pu
> > > +	The proportional term of the power allocator governor's PID
> > > +	controller during temperature undershoot. Temperature undershoot
> > > +	is when the current temperature is below the "desired
> > > +	temperature" trip point. For more information see
> > > +	Documentation/thermal/power_allocator.txt
> > > +	RW, Optional
> > > +
> > > +k_i
> > > +	The integral term of the power allocator governor's PID
> > > +	controller. This term allows the PID controller to compensate
> > > +	for long term drift. For more information see
> > > +	Documentation/thermal/power_allocator.txt
> > > +	RW, Optional
> > > +
> > > +k_d
> > > +	The derivative term of the power allocator governor's PID
> > > +	controller. For more information see
> > > +	Documentation/thermal/power_allocator.txt
> > > +	RW, Optional
> > > +
> > > +integral_cutoff
> > > +	Temperature offset from the desired temperature trip point
> > > +	above which the integral term of the power allocator
> > > +	governor's PID controller starts accumulating errors. For
> > > +	example, if integral_cutoff is 0, then the integral term only
> > > +	accumulates error when temperature is above the desired
> > > +	temperature trip point. For more information see
> > > +	Documentation/thermal/power_allocator.txt
> > > +	RW, Optional
> > > +
> > >  *****************************
> > >  * Cooling device attributes *
> > >  *****************************
> > > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > > index df9ba3bf55dc..228e93f8a146 100644
> > > --- a/drivers/thermal/thermal_core.c
> > > +++ b/drivers/thermal/thermal_core.c
> > > @@ -873,6 +873,111 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
> > >  static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
> > >  #endif/*CONFIG_THERMAL_EMULATION*/
> > >  
> > > +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
> 
> 
> What bugged me in the first place was the fact that we are doing this
> #ifdef here. But in fact, it is not really necessary, as the parameters
> are stored in tzp, and they will be there regardless of the config
> status.

My reasoning behind the ifdefs was because it seems we are putting a
number of files in sysfs that are not interesting if this was not
compiled in.  It's true that technically the ifdefs are not needed.
I'll remove them.

> > > +
> > > +static ssize_t
> > > +sustainable_power_show(struct device *dev, struct device_attribute *devattr,
> > > +		       char *buf)
> > > +{
> > > +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> > > +
> > > +	if (tz->tzp)
> > > +		return sprintf(buf, "%u\n", tz->tzp->sustainable_power);
> > > +	else
> > > +		return -EIO;
> > > +}
> > > +
> > > +static ssize_t
> > > +sustainable_power_store(struct device *dev, struct device_attribute *devattr,
> > > +			const char *buf, size_t count)
> > > +{
> > > +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> > > +	u32 sustainable_power;
> > > +
> > > +	if (!tz->tzp)
> > > +		return -EIO;
> > > +
> > > +	if (kstrtou32(buf, 10, &sustainable_power))
> > > +		return -EINVAL;
> > > +
> > > +	tz->tzp->sustainable_power = sustainable_power;
> > > +
> > > +	return count;
> > > +}
> > > +static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
> > > +		sustainable_power_store);
> > > +
> > > +#define create_s32_tzp_attr(name)					\
> > > +	static ssize_t							\
> > > +	name##_show(struct device *dev, struct device_attribute *devattr, \
> > > +		char *buf)						\
> > > +	{								\
> > > +	struct thermal_zone_device *tz = to_thermal_zone(dev);		\
> > > +									\
> > > +	if (tz->tzp)							\
> > > +		return sprintf(buf, "%u\n", tz->tzp->name);		\
> > > +	else								\
> > > +		return -EIO;						\
> > > +	}								\
> > > +									\
> > > +	static ssize_t							\
> > > +	name##_store(struct device *dev, struct device_attribute *devattr, \
> > > +		const char *buf, size_t count)				\
> > > +	{								\
> > > +		struct thermal_zone_device *tz = to_thermal_zone(dev);	\
> > > +		s32 value;						\
> > > +									\
> > > +		if (!tz->tzp)						\
> > > +			return -EIO;					\
> > > +									\
> > > +		if (kstrtos32(buf, 10, &value))				\
> > > +			return -EINVAL;					\
> > > +									\
> > > +		tz->tzp->name = value;					\
> > > +									\
> > > +		return count;						\
> > > +	}								\
> > > +	static DEVICE_ATTR(name, S_IWUSR | S_IRUGO, name##_show, name##_store)
> > > +
> > > +create_s32_tzp_attr(k_po);
> > > +create_s32_tzp_attr(k_pu);
> > > +create_s32_tzp_attr(k_i);
> > > +create_s32_tzp_attr(k_d);
> > > +create_s32_tzp_attr(integral_cutoff);
> > > +#undef create_s32_tzp_attr
> > > +
> > > +static struct device_attribute *dev_tzp_attrs[] = {
> > > +	&dev_attr_sustainable_power,
> > > +	&dev_attr_k_po,
> > > +	&dev_attr_k_pu,
> > > +	&dev_attr_k_i,
> > > +	&dev_attr_k_d,
> > > +	&dev_attr_integral_cutoff,
> > > +};
> > > +
> > > +static int create_power_allocator_tzp_attrs(struct device *dev)
> 
> I would rename this to thermal_create_zone_params_attrs and remove the
> ifdefiry.

Ok, I will remove them.

>           If you are not exposing the complete info under tzp, then make
> a comment about it.

There's nothing else worth populating.  The governor_name is not
interesting, you have the thermal zone policy for that.  Similar for
no_hwmon.  For tbps, weight and trip_mask are already exposed in the
instance.  The binding_limits is currently not available in sysfs, but
if we were to populate it, I would expose the ones that end up in the
instance, as we do with trips and weights.

Is it worth putting this in a comment in the code?

> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < ARRAY_SIZE(dev_tzp_attrs); i++) {
> > > +		int ret;
> > > +		struct device_attribute *dev_attr = dev_tzp_attrs[i];
> > > +
> > > +		ret = device_create_file(dev, dev_attr);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +#else  /* !CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
> > > +static int create_power_allocator_tzp_attrs(struct device *dev)
> > > +{
> > > +	return 0;
> > > +}
> > > +#endif
> > > +
> > 
> > It is better if this code is not part of thermal_core. The governor
> > specific code must be in the governor code. Durga has done a pretty good
> > job splitting governor code out of thermal_core.c. I don't think we want
> > to get them back.
> 
> Unless you really want to expose something that is only inside the
> governor data struture, you can ignore the above comment.

Ok

> > >  /**
> > >   * power_actor_get_max_power() - get the maximum power that a cdev can consume
> > >   * @cdev:	pointer to &thermal_cooling_device
> > > @@ -1712,6 +1817,11 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
> > >  	if (result)
> > >  		goto unregister;
> > >  
> > > +	/* Add power_allocator specific thermal zone params */
> > > +	result = create_power_allocator_tzp_attrs(&tz->device);
> > > +	if (result)
> > > +		goto unregister;
> > 
> > Here you could create the governor_params and have a callback from
> > governor to populate it.
> 
> ditto.
> 
> Of course, assuming all we are doing is exposing what is in
> thermal_zone_params, which is generic enough to be in thermal_core.c.

That's right.
