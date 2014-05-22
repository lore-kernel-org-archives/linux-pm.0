From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH 4/5] thermal: introduce the Power Allocator governor
Date: Thu, 22 May 2014 10:26:51 -0400
Message-ID: <20140522142651.GA4847@developer>
References: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
 <1399377998-14870-5-git-send-email-javi.merino@arm.com>
 <20140513232041.GC28174@developer>
 <20140515182444.GC3964@e102654-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:53620 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbaEVO1Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 10:27:25 -0400
Received: by mail-yh0-f42.google.com with SMTP id t59so3051731yho.29
        for <linux-pm@vger.kernel.org>; Thu, 22 May 2014 07:27:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140515182444.GC3964@e102654-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Zhang Rui <rui.zhang@intel.com>

Hello again Javi,

I will answer couple of your questions here. But I will also review your
V2, no worries.

On Thu, May 15, 2014 at 07:24:44PM +0100, Javi Merino wrote:
> Hi Eduardo,
> 
> On Wed, May 14, 2014 at 12:20:41AM +0100, Eduardo Valentin wrote:
> > Hello Javi,
> > 
> > Here are a series of initial comments. I will be probably reviewing the
> > code several times and coming back again with more questions.
> 
> Ok, we'll send updates regularly as we incorporate feedback and tune
> it.


great!

> 
> > On Tue, May 06, 2014 at 01:06:37PM +0100, Javi Merino wrote:
> > > The power allocator governor is a thermal governor that controls system
> > > and device power allocation to control temperature.  Conceptually, the
> > > implementation takes a system view of heat dissipation by managing
> > > multiple heat sources.
> > 
> > Can it be able to control several thermal zones then?
> 
> Yes, that's why we added bind_to_tz() and unbind_to_tz() to put the
> governor's private data in the struct thermal_zone_device.


I see. But I was more interested if you meant that this governor is
capable of controling several thermal zones at the same time. That is,
builds decision based on information taken from several thermal zones.
Was that what you meant?
> 
> > > This governor relies on power-aware cooling devices (power actors) to
> > > operate.  That is, cooling devices whose thermal_cooling_device_ops
> > > accept THERMAL_UNIT_POWER.
> > >
> > > It uses a Proportional Integral (PI) controller driven by the
> > > temperature of the thermal zone.  This budget is then allocated to
> > > each cooling device that can have bearing on the temperature we are
> > > trying to control.  It decides how much power to give each cooling
> > > device based on the performance they are requesting.  The PI
> > > controller ensures that the total power budget does not exceed the
> > > control temperature.
> > >
> > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > Cc: Eduardo Valentin <edubezval@gmail.com>
> > > Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> > > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > > ---
> > >  drivers/thermal/Kconfig           |   14 ++
> > >  drivers/thermal/Makefile          |    1 +
> > >  drivers/thermal/power_allocator.c |  403 +++++++++++++++++++++++++++++++++++++
> > >  drivers/thermal/thermal_core.c    |    7 +-
> > >  drivers/thermal/thermal_core.h    |    8 +
> > >  include/linux/thermal.h           |    5 +
> > 
> > We need documentation under Documentation/thermal to understand
> > how to use this governor. Specially on how to accomodate
> > several actors and domains under its control.
> 
> Sure, the next series will have some documentation on how to integrate
> it in a platform and how all the components interact.
> 

ok.

> > >  6 files changed, 437 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/thermal/power_allocator.c
> > >
> > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > index 2d51912a6e40..f5e6b693fc19 100644
> > > --- a/drivers/thermal/Kconfig
> > > +++ b/drivers/thermal/Kconfig
> > > @@ -71,6 +71,14 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
> > >         Select this if you want to let the user space manage the
> > >         platform thermals.
> > >
> > > +config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
> > > +     bool "power_allocator"
> > > +     select THERMAL_GOV_POWER_ALLOCATOR
> > > +     help
> > > +       Select this if you want to control temperature based on
> > > +       system and device power allocation. This governor relies on
> > > +       power-aware cooling devices (power actors) to operate.
> > > +
> > >  endchoice
> > >
> > >  config THERMAL_GOV_FAIR_SHARE
> > > @@ -89,6 +97,12 @@ config THERMAL_GOV_USER_SPACE
> > >       help
> > >         Enable this to let the user space manage the platform thermals.
> > >
> > > +config THERMAL_GOV_POWER_ALLOCATOR
> > > +     bool "Power allocator thermal governor"
> > > +     help
> > > +       Enable this to manage platform thermals by dynamically
> > > +       allocating and limiting power to devices.
> > > +
> > >  config CPU_THERMAL
> > >       bool "generic cpu cooling support"
> > >       depends on CPU_FREQ
> > > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > > index 54e4ec9eb5df..1cb7d5fec8dc 100644
> > > --- a/drivers/thermal/Makefile
> > > +++ b/drivers/thermal/Makefile
> > > @@ -13,6 +13,7 @@ thermal_sys-$(CONFIG_THERMAL_OF)            += of-thermal.o
> > >  thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE) += fair_share.o
> > >  thermal_sys-$(CONFIG_THERMAL_GOV_STEP_WISE)  += step_wise.o
> > >  thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE) += user_space.o
> > > +thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)    += power_allocator.o
> > >
> > >  # cpufreq cooling
> > >  thermal_sys-$(CONFIG_CPU_THERMAL)    += cpu_cooling.o
> > > diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
> > > new file mode 100644
> > > index 000000000000..39c425abf10a
> > > --- /dev/null
> > > +++ b/drivers/thermal/power_allocator.c
> > > @@ -0,0 +1,403 @@
> > > +/*
> > > + * A power allocator to manage temperature
> > > + *
> > > + * Copyright (C) 2014 ARM Ltd.
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License version 2 as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > > + * kind, whether express or implied; without even the implied warranty
> > > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > > + * GNU General Public License for more details.
> > > + */
> > > +
> > > +#define pr_fmt(fmt) "Power allocator: " fmt
> > > +
> > > +#include <linux/list.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/thermal.h>
> > > +
> > > +#include "thermal_core.h"
> > > +
> > > +#define MAX_NUM_ACTORS 8
> > 
> > hmm... Why do we need to limit the amount of actors?
> 
> Right, I could allocate the arrays dynamically.

good.

> 
> > > +
> > > +#define FRAC_BITS 8
> > > +#define int_to_frac(x) ((x) << FRAC_BITS)
> > > +#define frac_to_int(x) ((x) >> FRAC_BITS)
> > > +
> > > +/**
> > > + * mul_frac - multiply two fixed-point numbers
> > > + * @x:       first multiplicand
> > > + * @y:       second multiplicand
> > > + *
> > > + * Returns the result of multiplying two fixed-point numbers.  The
> > > + * result is also a fixed-point number.
> > > + */
> > > +static inline s64 mul_frac(s64 x, s64 y)
> > > +{
> > > +     return (x * y) >> FRAC_BITS;
> > > +}
> > > +
> > > +enum power_allocator_trip_levels {
> > > +     TRIP_SWITCH_ON = 0,     /* Switch on PI controller */
> > > +     TRIP_MAX_DESIRED_TEMPERATURE, /* Temperature we are controlling for */
> > > +};
> > 
> > Can we reuse the trip types we already have?
> 
> You mean using "passive" as a "switch on" and "active" as
> MAX_DESIRED_TEMPERATURE?  If you prefer it that way, I can do that.

hmmm.. well, "active", as per its original definition, targets points in
which the system performs (cooling) actions that burns more power to
remove heat. On the other hand, "passive" removes heat by reducing/modulating system's power consumption.

I believe you would need two passive trip points.

Another option is to use a passive trip point to map your switch on
event and a hot trip point to map your target temperature.


> 
> > > +
> > > +/**
> > > + * struct power_allocator_params - parameters for the power allocator governor
> > > + * @k_po:    P parameter of the PI controller when overshooting (i.e., when
> > > + *           temperature is below the target)
> > > + * @k_pi:    P parameter of the PI controller when undershooting
> > > + * @k_i:     I parameter of the PI controller
> > > + * @integral_cutoff: threshold below which the error is no longer accumulated
> > > +                     in the PI controller
> > > + * @err_integral:    Accumulated error in the PI controller.
> > > + */
> > > +struct power_allocator_params {
> > > +     s32 k_po;
> > > +     s32 k_pu;
> > > +     s32 k_i;
> > > +     s32 integral_cutoff;
> > > +     s32 err_integral;
> > > +};
> > 
> > We would need a documentation on how to define these values.
> 
> Originally I thought that this should not need to be exposed to the
> outside world and could have defaults that worked everywhere.  I guess
> people will like to fine tune them, so apart from the sane defaults,
> there should be a way for platforms to override this, and that would
> need documentation.

Can we achieve safe defaults applicable to every platforms?


> 
> > > +
> > > +/**
> > > + * pi_controller() - PI controller
> > > + * @tz:      thermal zone we are operating in
> > > + * @control_temp:    The target temperature
> > > + * @max_allocatable_power:   maximum allocatable power for this thermal zone
> > > + *
> > > + * This PI controller increases the available power budget so that the
> > > + * temperature of the thermal zone gets as close as possible to
> > > + * @control_temp and limits the power if it exceeds it.  k_po is the
> > > + * proportional term when we are overshooting, k_pu is the
> > > + * proportional term when we are undershooting.  integral_cutoff is a
> > > + * threshold below which we stop accumulating the error.  The
> > > + * accumulated error is only valid if the requested power will make
> > > + * the system warmer.  If the system is mostly idle, there's no point
> > > + * in accumulating positive error.
> > > + *
> > > + * It returns the power budget for the next period.
> > > + */
> > > +static u32 pi_controller(struct thermal_zone_device *tz,
> > > +                     unsigned long current_temp, unsigned long control_temp,
> > > +                     unsigned long max_allocatable_power)
> > > +{
> > > +     s64 p, i, power_range;
> > > +     s32 err;
> > > +     struct power_allocator_params *params = tz->governor_data;
> > > +
> > > +     err = ((s32)control_temp - (s32)current_temp) / 1000;
> > > +     err = int_to_frac(err);
> > > +
> > > +     /* Calculate the proportional term */
> > > +     p = mul_frac(err < 0 ? params->k_po : params->k_pu, err);
> > > +
> > > +     /*
> > > +      * Calculate the integral term
> > > +      *
> > > +      * if the error s less than cut off allow integration (but
> > > +      * the integral is limited to max power)
> > > +      */
> > > +     i = mul_frac(params->k_i, params->err_integral);
> > > +
> > > +     if (err < int_to_frac(params->integral_cutoff)) {
> > > +             s64 tmpi = mul_frac(params->k_i, err);
> > > +             tmpi += i;
> > > +             if (tmpi <= int_to_frac(max_allocatable_power)) {
> > > +                     i = tmpi;
> > > +                     params->err_integral += err;
> > > +             }
> > > +     }
> > > +
> > > +     power_range = p + i;
> > > +
> > > +     /* feed-forward the known maximum dissipatable power */
> > > +     power_range = tz->tzp->max_dissipatable_power +
> > > +             frac_to_int(power_range);
> > > +
> > > +     /* output should not exceed max power */
> > > +     if (power_range > max_allocatable_power)
> > > +             power_range = max_allocatable_power;
> > > +
> > > +     return power_range >= 0 ? power_range : 0;
> > 
> > What does it mean return 0? The above if does not make completelly sense
> > to me, as power_range can still be 0. power_range < 0 means error?
> 
> You return 0 if the calculated power range was negative.  I've
> rewritten the above code to be:
> 
>   return clamp(power_range, (s64)0, (s64)max_allocatable_power);
> 
> which I think it's clear.

sounds good to me.

> 
> > what if the value at power_range overflows the u32?
> 
> Its maximum value is max_allocatable_power which in sane systems
> shouldn't be greater than u32.  I could put a BUG() somewhere if
> max_allocatable_power > U32_MAX, do you think it's worth it?
> 

I agree to have a sane check at least in initialization phase to avoid
obscure overflow errors.

> > > +}
> > > +
> > > +static void divvy_up_power(struct thermal_zone_device *tz,
> > 
> > Can you please document how you perform this power split?
> 
> Will do.

good.

> 
> > > +                     unsigned long req_power[MAX_NUM_ACTORS],
> > > +                     unsigned long max_power[MAX_NUM_ACTORS],
> > > +                     int num_actors, unsigned long total_req_power,
> > > +                     u32 power_range,
> > > +                     unsigned long granted_power[MAX_NUM_ACTORS])
> > > +{
> > > +     unsigned long extra_power, capped_extra_power;
> > > +     unsigned long extra_actor_power[MAX_NUM_ACTORS];
> > > +     int i;
> > > +
> > > +     if (!total_req_power) {
> > > +             /*
> > > +              * Nobody requested anything, so just give everybody
> > > +              * the maximum power
> > > +              */
> > > +             for (i = 0; i < num_actors; i++)
> > > +                     granted_power[i] = max_power[i];
> > > +
> > > +             return;
> > > +     }
> > > +
> > > +     capped_extra_power = 0;
> > > +     extra_power = 0;
> > > +     for (i = 0; i < num_actors; i++) {
> > > +             u64 req_range = req_power[i] * power_range;
> > > +
> > > +             granted_power[i] = div_u64(req_range, total_req_power);
> > > +
> > > +             if (granted_power[i] > max_power[i]) {
> > > +                     extra_power += granted_power[i] - max_power[i];
> > > +                     granted_power[i] = max_power[i];
> > > +             }
> > > +
> > > +             extra_actor_power[i] = max_power[i] - granted_power[i];
> > > +             capped_extra_power += extra_actor_power[i];
> > > +     }
> > > +
> > > +     if (!extra_power)
> > > +             return;
> > > +
> > > +     /*
> > > +      * Re-divvy the reclaimed extra among actors based on
> > > +      * how far they are from the max
> > > +      */
> > > +     extra_power = min(extra_power, capped_extra_power);
> > > +     if (capped_extra_power > 0)
> > > +             for (i = 0; i < num_actors; i++)
> > > +                     granted_power[i] += (extra_actor_power[i] *
> > > +                                     extra_power) / capped_extra_power;
> > > +}
> > > +
> > > +static int allocate_power(struct thermal_zone_device *tz,
> > > +                     unsigned long current_temp, unsigned long control_temp)
> > > +{
> > > +     struct thermal_instance *instance;
> > > +     unsigned long req_power[MAX_NUM_ACTORS], max_power[MAX_NUM_ACTORS];
> > > +     unsigned long granted_power[MAX_NUM_ACTORS];
> > > +     unsigned long total_req_power, max_allocatable_power;
> > > +     u32 power_range;
> > > +     int i, num_actors, ret = 0;
> > > +
> > > +     i = 0;
> > > +     total_req_power = 0;
> > > +     max_allocatable_power = 0;
> > > +
> > > +     mutex_lock(&tz->lock);
> > > +
> > > +     list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> > > +             struct thermal_cooling_device *cdev = instance->cdev;
> > > +
> > > +             if (instance->trip != TRIP_MAX_DESIRED_TEMPERATURE)
> > 
> > How does one instance->trip gets the value of
> > TRIP_MAX_DESIRED_TEMPERATURE?
> 
> In power_allocator_bind() you fail to bind if the trip point doesn't
> exist.  This may be removed if we switch passive/active trip points.

yes, but you need a check while binding to a correct trip setup, I
agree.

> 
> > > +                     continue;
> > > +
> > > +             if (i >= MAX_NUM_ACTORS) {
> > > +                     pr_warn("Too many actors (%d) for this governor\n", i);
> > 
> > dev_* family is preferrable over pr_* family. Same applies to other
> > patches.
> 
> With the &tz->device as the device?  Sure.

yes, use the thermal zone device when possible. If thermal zone device
is unreliable, then use pr_* family.

> 
> > > +                     ret = -EINVAL;
> > > +                     goto unlock;
> > > +             }
> > > +
> > > +             ret = cdev->ops->get_cur(cdev, &req_power[i],
> > > +                                     THERMAL_UNIT_POWER);
> > > +             if (ret) {
> > > +                     pr_warn_once("Couldn't get current power for %s: %d\n",
> > > +                             cdev->type, ret);
> > > +                     goto unlock;
> > > +             }
> > > +
> > > +             total_req_power += req_power[i];
> > > +
> > > +             cdev->ops->get_max(cdev, &max_power[i], THERMAL_UNIT_POWER);
> > > +             max_allocatable_power += max_power[i];
> > > +
> > > +             i++;
> > > +     }
> > > +     num_actors = i;
> > > +
> > > +     power_range = pi_controller(tz, current_temp, control_temp,
> > > +                             max_allocatable_power);
> > > +
> > > +     divvy_up_power(tz, req_power, max_power, num_actors, total_req_power,
> > > +             power_range, granted_power);
> > > +
> > > +     i = 0;
> > > +     list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> > > +             struct thermal_cooling_device *cdev = instance->cdev;
> > > +
> > > +             if (instance->trip != TRIP_MAX_DESIRED_TEMPERATURE)
> > > +                     continue;
> > > +
> > > +             cdev->ops->set_cur(cdev, granted_power[i], THERMAL_UNIT_POWER);
> > > +             i++;
> > > +     }
> > > +
> > > +unlock:
> > > +     mutex_unlock(&tz->lock);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int check_trips(struct thermal_zone_device *tz)
> > > +{
> > > +     int ret;
> > > +     enum thermal_trip_type type;
> > > +
> > > +     if (tz->trips < 2)
> > > +             return -EINVAL;
> > > +
> > > +     ret = tz->ops->get_trip_type(tz, TRIP_SWITCH_ON, &type);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if ((type != THERMAL_TRIP_PASSIVE) && (type != THERMAL_TRIP_ACTIVE))
> > > +             return -EINVAL;
> > > +
> > > +     ret = tz->ops->get_trip_type(tz, TRIP_MAX_DESIRED_TEMPERATURE, &type);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if ((type != THERMAL_TRIP_PASSIVE) && (type != THERMAL_TRIP_ACTIVE))
> > > +             return -EINVAL;
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static void reset_pi_controller(struct power_allocator_params *params)
> > > +{
> > > +     params->err_integral = 0;
> > > +}
> > > +
> > > +/**
> > > + * power_allocator_bind - bind the power_allocator governor to a thermal zone
> > > + * @tz:      thermal zone to bind it to
> > > + *
> > > + * Check that the thermal zone is valid for this governor: has two
> > > + * thermal trips.  If so, initialize the PI controller parameters and
> > > + * bind it to the thermal zone.
> > > + *
> > > + * Returns 0 on success, -EINVAL if the trips were invalid or -ENOMEM
> > > + * if we ran out of memory.
> > > + */
> > > +static int power_allocator_bind(struct thermal_zone_device *tz)
> > > +{
> > > +     int ret;
> > > +     struct power_allocator_params *params;
> > > +     unsigned long switch_on_temp, control_temp;
> > > +     u32 temperature_threshold;
> > > +
> > > +     ret = check_trips(tz);
> > > +     if (ret) {
> > > +             pr_err("thermal zone %s has the wrong number of trips for this governor\n",
> > > +                     tz->type);
> > > +             return ret;
> > > +     }
> > > +
> > > +     if (!tz->tzp || !tz->tzp->max_dissipatable_power) {
> > > +             pr_err("Trying to bind the power_allocator governor to a thermal zone without the max_dissipatable_power parameter\n");
> > 
> > Can you please break the above line?
> 
> I prefer to keep it as it is.  From Documentation/CodingStyle:
> 
>   never break user-visible strings such as printk messages, because
>   that breaks the ability to grep for them.
> 
> The string could be improved though.

Yeah, but the above message is not too descriptive for the system
administrator. Think of it, it does mention an error situation, but does
not mention what is the thermal zone.

Maybe a smaller message like this would be more helpfull:

+	if (!tz->tzp || !tz->tzp->max_dissipatable_power) {
+		dev_err(tz->device,
+			"power_allocator: missing max_dissipatable_power\n");


The dev_err includes the name of the thermal zone device.

> 
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     params = kzalloc(sizeof(*params), GFP_KERNEL);
> > 
> > can we use devm_kzalloc?
> 
> Sure.
> 

good.


> > > +     if (!params)
> > > +             return -ENOMEM;
> > > +
> > > +     ret = tz->ops->get_trip_temp(tz, TRIP_SWITCH_ON, &switch_on_temp);
> > > +     if (ret)
> > > +             goto free;
> > > +
> > > +     ret = tz->ops->get_trip_temp(tz, TRIP_MAX_DESIRED_TEMPERATURE,
> > > +                             &control_temp);
> > 
> > thermal zone drivers are not aware of these trip types, are they?
> 
> I'll do what you suggested before and turn them into passive/active.

good.

>  
> > > +     if (ret)
> > > +             goto free;
> > > +
> > > +     temperature_threshold = (control_temp - switch_on_temp) / 1000;
> > > +
> > > +     params->k_po = int_to_frac(tz->tzp->max_dissipatable_power) /
> > > +             temperature_threshold;
> > > +     params->k_pu = int_to_frac(2 * tz->tzp->max_dissipatable_power) /
> > > +             temperature_threshold;
> > > +     params->k_i = int_to_frac(1);
> > 
> > I suppose we need a way to input k_po, k_pu and k_i parameters from
> > platform code to this governor right? Or are they always defined as the
> > above code? always based on max_dissipated_power?
> 
> As I said above, I thought that we could just provide defaults and not
> make life harder for platform code, but I guess we need to provide a
> way for platform to override them.
> 

I see. If we can achieve a single set of constants, then we can add
debugfs entries for k_{po,pu,i} constant values. That would allow for
debugging and fine tunning.



