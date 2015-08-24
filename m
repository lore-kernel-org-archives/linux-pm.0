From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v3 1/4] thermal: power_allocator: relax the requirement
 of a sustainable_power in tzp
Date: Mon, 24 Aug 2015 19:37:49 +0100
Message-ID: <20150824183749.GB2718@e104805>
References: <1439288493-19740-1-git-send-email-javi.merino@arm.com>
 <1439833008-26440-1-git-send-email-javi.merino@arm.com>
 <1439833008-26440-2-git-send-email-javi.merino@arm.com>
 <20150820221651.GC5719@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:53584 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750942AbbHXSiA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2015 14:38:00 -0400
Content-Disposition: inline
In-Reply-To: <20150820221651.GC5719@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "cywang@chromium.org" <cywang@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, Zhang Rui <rui.zhang@intel.com>

On Thu, Aug 20, 2015 at 11:16:53PM +0100, Eduardo Valentin wrote:
> On Mon, Aug 17, 2015 at 06:36:45PM +0100, Javi Merino wrote:
> > The power allocator governor currently requires that a sustainable power
> > is passed as part of the thermal zone's thermal zone parameters.  If
> > that parameter is not provided, it doesn't register with the thermal
> > zone.
> > 
> > While this parameter is strongly recommended for optimal performance, it
> > doesn't need to be mandatory.  Relax the requirement and allow the
> > governor to bind to thermal zones that don't provide it by estimating it
> > from the cooling devices' power model.
> > 
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > ---
> >  drivers/thermal/power_allocator.c | 62 +++++++++++++++++++++++++++++++++------
> >  drivers/thermal/thermal_core.c    | 28 ++++++++++++++++++
> >  include/linux/thermal.h           |  6 ++++
> >  3 files changed, 87 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
> > index 63a448f9d93b..7ec459780dff 100644
> > --- a/drivers/thermal/power_allocator.c
> > +++ b/drivers/thermal/power_allocator.c
> > @@ -73,6 +73,39 @@ struct power_allocator_params {
> >  };
> >  
> >  /**
> > + * estimate_sustainable_power() - Estimate the sustainable power of a thermal zone
> > + * @tz: thermal zone we are operating in
> > + *
> > + * For thermal zones that don't provide a sustainable_power in their
> > + * thermal_zone_params, estimate one.  Calculate it using the minimum
> > + * power of all the cooling devices as that gives a valid value that
> > + * can give some degree of functionality.  For optimal performance of
> > + * this governor, provide a sustainable_power in the thermal zone's
> > + * thermal_zone_params.
> > + */
> > +static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
> > +{
> > +	u32 sustainable_power = 0;
> > +	struct thermal_instance *instance;
> > +	struct power_allocator_params *params = tz->governor_data;
> > +
> > +	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> > +		struct thermal_cooling_device *cdev = instance->cdev;
> > +		u32 min_power;
> > +
> > +		if (instance->trip != params->trip_max_desired_temperature)
> > +			continue;
> > +
> > +		if (power_actor_get_min_power(cdev, tz, &min_power))
> > +			continue;
> > +
> > +		sustainable_power += min_power;
> > +	}
> > +
> > +	return sustainable_power;
> > +}
> > +
> > +/**
> >   * pid_controller() - PID controller
> >   * @tz:	thermal zone we are operating in
> >   * @current_temp:	the current temperature in millicelsius
> > @@ -98,6 +131,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
> >  {
> >  	s64 p, i, d, power_range;
> >  	s32 err, max_power_frac;
> > +	u32 sustainable_power;
> >  	struct power_allocator_params *params = tz->governor_data;
> >  
> >  	max_power_frac = int_to_frac(max_allocatable_power);
> > @@ -138,8 +172,11 @@ static u32 pid_controller(struct thermal_zone_device *tz,
> >  
> >  	power_range = p + i + d;
> >  
> > +	sustainable_power = tz->tzp->sustainable_power ?:
> > +		estimate_sustainable_power(tz);
> > +
> >  	/* feed-forward the known sustainable dissipatable power */
> > -	power_range = tz->tzp->sustainable_power + frac_to_int(power_range);
> > +	power_range = sustainable_power + frac_to_int(power_range);
> >  
> >  	power_range = clamp(power_range, (s64)0, (s64)max_allocatable_power);
> >  
> > @@ -418,18 +455,18 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
> >  	int ret;
> >  	struct power_allocator_params *params;
> >  	unsigned long switch_on_temp, control_temp;
> > -	u32 temperature_threshold;
> > +	u32 sustainable_power, temperature_threshold;
> >  
> > -	if (!tz->tzp || !tz->tzp->sustainable_power) {
> > -		dev_err(&tz->device,
> > -			"power_allocator: missing sustainable_power\n");
> > +	if (!tz->tzp)
> >  		return -EINVAL;
> > -	}
> >  
> >  	params = devm_kzalloc(&tz->device, sizeof(*params), GFP_KERNEL);
> >  	if (!params)
> >  		return -ENOMEM;
> >  
> > +	if (!tz->tzp->sustainable_power)
> > +		dev_warn(&tz->device, "power_allocator: sustainable_power will be estimated\n");
> > +
> >  	ret = get_governor_trips(tz, params);
> >  	if (ret) {
> >  		dev_err(&tz->device,
> > @@ -448,13 +485,20 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
> >  	if (ret)
> >  		goto free;
> >  
> > +	/*
> > +	 * Provide an arbitrary sustainable_power to set the default
> > +	 * values of k_po and k_pu.  We can not estimate sustainable_power
> > +	 * at this point because no cooling devices have been
> > +	 * registered yet.  By providing an arbitrary value we get
> > +	 * better defaults than setting k_po and k_pu to 0.
> > +	 */
> > +	sustainable_power = tz->tzp->sustainable_power ?: 2500;
> 
> I think having 2500 here may produce constants that are not sane for
> most thermal zones.
> 
> >  	temperature_threshold = control_temp - switch_on_temp;
> >  
> >  	tz->tzp->k_po = tz->tzp->k_po ?:
> > -		int_to_frac(tz->tzp->sustainable_power) / temperature_threshold;
> > +		int_to_frac(sustainable_power) / temperature_threshold;
> >  	tz->tzp->k_pu = tz->tzp->k_pu ?:
> > -		int_to_frac(2 * tz->tzp->sustainable_power) /
> > -		temperature_threshold;
> > +		int_to_frac(2 * sustainable_power) / temperature_threshold;
> >  	tz->tzp->k_i = tz->tzp->k_i ?: int_to_frac(10) / 1000;
> 
> I would prefer you move the constants estimations to where you have a
> sane sustainable_power.

Ok, I'll factor it to a function so that they can be estimated here if
you provide sustainable_power or they can be re-estimated in
pid_controller() if there is no sustainable_power.

Cheers,
Javi
