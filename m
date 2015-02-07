From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2 5/5] thermal: fair_share: generalize the weight concept
Date: Sat, 7 Feb 2015 12:45:53 +0000
Message-ID: <20150207124553.GA2298@e104805>
References: <1422881490-14695-1-git-send-email-javi.merino@arm.com>
 <1422881490-14695-6-git-send-email-javi.merino@arm.com>
 <1423214994.1729.37.camel@rzhang1-mobl4>
 <20150206124239.GB2977@e104805>
 <1423231592.1729.51.camel@rzhang1-mobl4>
 <20150206144349.GC2977@e104805>
 <1423274245.1729.62.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:42552 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbbBGMqE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 7 Feb 2015 07:46:04 -0500
Content-Disposition: inline
In-Reply-To: <1423274245.1729.62.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, Kapileshwar Singh <Kapileshwar.Singh@arm.com>, Eduardo Valentin <edubezval@gmail.com>, durga <durgadoss.r@intel.com>

On Sat, Feb 07, 2015 at 01:57:25AM +0000, Zhang Rui wrote:
> On Fri, 2015-02-06 at 14:43 +0000, Javi Merino wrote:
> > Hi Rui,
> >
> > On Fri, Feb 06, 2015 at 02:06:32PM +0000, Zhang Rui wrote:
> > > On Fri, 2015-02-06 at 12:42 +0000, Javi Merino wrote:
> > > > On Fri, Feb 06, 2015 at 09:29:54AM +0000, Zhang Rui wrote:
> > > > > On Mon, 2015-02-02 at 12:51 +0000, Javi Merino wrote:
> > > > > > The fair share governor has the concept of weights, which is the
> > > > > > influence of each cooling device in a thermal zone.  The current
> > > > > > implementation forces the weights of all cooling devices in a thermal
> > > > > > zone to add up to a 100.  This complicates setups, as you need to know
> > > > > > in advance how many cooling devices you are going to have.  If you bind a
> > > > > > new cooling device, you have to modify all the other cooling devices
> > > > > > weights, which is error prone.  Furthermore, you can't specify a
> > > > > > "default" weight for platforms since that default value depends on the
> > > > > > number of cooling devices in the platform.
> > > > > >
> > > > > > This patch generalizes the concept of weight by allowing any number to
> > > > > > be a "weight".  Weights are now relative to each other.  Platforms that
> > > > > > don't specify weights get the same default value for all their cooling
> > > > > > devices, so all their cdevs are considered to be equally influential.
> > > > > >
> > > > > I don't think we have covered these two cases.
> > > > >
> > > > > First of all. for the thermal zones that bind using tz->tbp, and all the
> > > > > weights equals 0, it actually means THERMAL_WEIGHT_DEFAULT instead of
> > > > > zero.
> > > > > IMO, I think we should
> > > > > 1. leave THERMAL_WEIGHT_DEFAULT as 0
> > > > > 2. remove
> > > > >         if (!total_weight)
> > > > >                 return -EINVAL;
> > > > > 3. when calculating percentage,
> > > > >         if (!total_weight)
> > > > >                 percentage = 100 / total_instances_of_the_current_trip;
> > > > >
> > > > > Second, for the thermal zones that don't specify the weight for all of
> > > > > its cooling devices. In this case, I think only the cooling devices with
> > > > > weight should be used. Thus, we should
> > > > > 1. leave THERMAL_WEIGHT_DEFAULT as 0
> > > > > 2. for cooling devices do not have weight specified, we don't need to
> > > > > change any code and its percentage is zero.
> > > > >
> > > > > In all, I'd prefer to remove the change for THERMAL_WEIGHT_DEFAULT, and
> > > > > change fair_share_throttle() as below, what do you think?
> > > >
> > > > I think it makes it unnecessarily complicated as the default weight
> > > > will now have two different behaviours:
> > > >
> > > > 1. Cooling device not active if any devices have a weight and you are
> > > >    using the fair_share governor.
> > > > 2. Cooling device active if no other device have weights.
> > > >
> > > > It's hard to document. It should be either one or the other.  The
> > > > current implementation in this series make the cdevs do option 2
> > > > always.
> > >
> > > I just want to make thermal core intelligent and simplify the platform
> > > thermal driver. Because in most cases, an uninitialized value (zero)
> > > means the driver does not care and it wants to follow the default
> > > behavior.
> > > With your change in patch 5/5, for a driver that uses tz->tzp->tbp
> > > directly (not the of_thermal way), in order to use fair_share governor,
> > > it needs to set tbp[i].weight to THERMAL_WEIGHT_DEFAULT explicitly, like
> > > you do in of_thermal.c in patch 1/5, right?
> >
> > Right.  You have a valid point, not specifying anything should give you the
> > default behavior.  THERMAL_WEIGHT_DEFAULT must stay 0.
> >
> > Now, I'm still a bit uncomfortable with your proposal.  Imagine that a
> > platform has three cooling devices with default weight (0).  That
> > means that each would be getting 33%.  The developer sees that and
> > changes one of the cooling devices' weight to 50.  That has the
> > unintuitive effect of disabling the other two cooling devices.
> >
> If the developer wants to customize the weight, it means he/she wants to
> specify the proper weight for every cooling devices, rather than setting
> one to 50 and leaving the others 0, right?

Ok, I think that we have both stated our points of view regarding this
and this discussion is going nowhere.  At the end of the day the
patches won't be accepted unless you are happy with them and I don't
think rephrasing what I've already said will help in any way.

I'll send a v3 implementing your proposed changes next week. 

Cheers,
Javi

> > Should we just say weight=0 is "cooling device disabled for the
> > fair_share governor".
> >
> > > CC Durgadoss, the author of the fair_share governor.
> >
> > I forgot to add him because scripts/get_maintainer.pl didn't show
> > him.  I'll add him to the patches that touch the fair_share governor
> > from now on.
> >
> > Cheers,
> > Javi
> >
> > > > > @@ -77,7 +77,7 @@ static long get_target_state(struct
> > > > > thermal_zone_device *tz,
> > > > >   *
> > > > >   * Parameters used for Throttling:
> > > > >   * P1. max_state: Maximum throttle state exposed by the cooling device.
> > > > > - * P2. weight[i]/100:
> > > > > + * P2. percentage[i]/100:
> > > > >   *     How 'effective' the 'i'th device is, in cooling the given zone.
> > > > >   * P3. cur_trip_level/max_no_of_trips:
> > > > >   *     This describes the extent to which the devices should be
> > > > > throttled.
> > > > > @@ -89,16 +89,31 @@ static long get_target_state(struct
> > > > > thermal_zone_device *tz,
> > > > >  static int fair_share_throttle(struct thermal_zone_device *tz, int
> > > > > trip)
> > > > >  {
> > > > >         struct thermal_instance *instance;
> > > > > +       int total_weight = 0;
> > > > > +       int total_instance = 0;
> > > > >         int cur_trip_level = get_trip_level(tz);
> > > > >
> > > > >         list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> > > > > +               if (instance->trip != trip)
> > > > > +                       continue;
> > > > > +
> > > > > +               total_weight += instance->weight;
> > > > > +               total_instance++;
> > > > > +       }
> > > > > +
> > > > > +       list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> > > > > +               int percentage;
> > > > >                 struct thermal_cooling_device *cdev = instance->cdev;
> > > > >
> > > > >                 if (instance->trip != trip)
> > > > >                         continue;
> > > > >
> > > > > -               instance->target = get_target_state(tz, cdev,
> > > > > -                                       instance->weight,
> > > > > cur_trip_level);
> > > > > +               if (!total_weight)
> > > > > +                       percentage = 100 / total_instance;
> > > > > +               else
> > > > > +                       percentage = (instance->weight * 100) /
> > > > > total_weight;
> > > > > +               instance->target = get_target_state(tz, cdev,
> > > > > percentage,
> > > > > +                                                   cur_trip_level);
> > > > >
> > > > >                 instance->cdev->updated = false;
> > > > >                 thermal_cdev_update(cdev);
> > > > >
> > > > >
> > > > > > It's important to note that previous users of the weights don't need to
> > > > > > alter the code: percentages continue to work as they used to.  This
> > > > > > patch just removes the constraint of all the weights in a thermal zone
> > > > > > having to add up to a 100.  If they do, you get the same behavior as
> > > > > > before.  If they don't, fair share now works for that platform.
> > > > > >
> > > > > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > > > > Cc: Eduardo Valentin <edubezval@gmail.com>
> > > > > > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > > > > > ---
> > > > > >  Documentation/thermal/sysfs-api.txt |  8 +++++---
> > > > > >  drivers/thermal/fair_share.c        | 23 ++++++++++++++++++-----
> > > > > >  include/linux/thermal.h             | 17 ++++++++++++-----
> > > > > >  3 files changed, 35 insertions(+), 13 deletions(-)
> > > > > >
> > > > > > diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> > > > > > index 3625453ceef6..c9fd014f0c21 100644
> > > > > > --- a/Documentation/thermal/sysfs-api.txt
> > > > > > +++ b/Documentation/thermal/sysfs-api.txt
> > > > > > @@ -129,9 +129,11 @@ temperature) and throttle appropriate devices.
> > > > > >      This structure defines the following parameters that are used to bind
> > > > > >      a zone with a cooling device for a particular trip point.
> > > > > >      .cdev: The cooling device pointer
> > > > > > -    .weight: The 'influence' of a particular cooling device on this zone.
> > > > > > -             This is on a percentage scale. The sum of all these weights
> > > > > > -             (for a particular zone) cannot exceed 100.
> > > > > > +    .weight: The 'influence' of a particular cooling device on this
> > > > > > +             zone. This is relative to the rest of the cooling
> > > > > > +             devices. For example, if all cooling devices have a
> > > > > > +             weight of 1, then they all contribute the same. You can
> > > > > > +             use percentages if you want, but it's not mandatory.
> > > > > >      .trip_mask:This is a bit mask that gives the binding relation between
> > > > > >                 this thermal zone and cdev, for a particular trip point.
> > > > > >                 If nth bit is set, then the cdev and thermal zone are bound
> > > > > > diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
> > > > > > index 692f4053f08b..5cd6ff1d0a4c 100644
> > > > > > --- a/drivers/thermal/fair_share.c
> > > > > > +++ b/drivers/thermal/fair_share.c
> > > > > > @@ -59,13 +59,13 @@ static int get_trip_level(struct thermal_zone_device *tz)
> > > > > >  }
> > > > > >
> > > > > >  static long get_target_state(struct thermal_zone_device *tz,
> > > > > > -             struct thermal_cooling_device *cdev, int weight, int level)
> > > > > > +             struct thermal_cooling_device *cdev, int percentage, int level)
> > > > > >  {
> > > > > >       unsigned long max_state;
> > > > > >
> > > > > >       cdev->ops->get_max_state(cdev, &max_state);
> > > > > >
> > > > > > -     return (long)(weight * level * max_state) / (100 * tz->trips);
> > > > > > +     return (long)(percentage * level * max_state) / (100 * tz->trips);
> > > > > >  }
> > > > > >
> > > > > >  /**
> > > > > > @@ -77,7 +77,7 @@ static long get_target_state(struct thermal_zone_device *tz,
> > > > > >   *
> > > > > >   * Parameters used for Throttling:
> > > > > >   * P1. max_state: Maximum throttle state exposed by the cooling device.
> > > > > > - * P2. weight[i]/100:
> > > > > > + * P2. percentage[i]/100:
> > > > > >   *   How 'effective' the 'i'th device is, in cooling the given zone.
> > > > > >   * P3. cur_trip_level/max_no_of_trips:
> > > > > >   *   This describes the extent to which the devices should be throttled.
> > > > > > @@ -89,16 +89,29 @@ static long get_target_state(struct thermal_zone_device *tz,
> > > > > >  static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
> > > > > >  {
> > > > > >       struct thermal_instance *instance;
> > > > > > +     int total_weight = 0;
> > > > > >       int cur_trip_level = get_trip_level(tz);
> > > > > >
> > > > > >       list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> > > > > > +             if (instance->trip != trip)
> > > > > > +                     continue;
> > > > > > +
> > > > > > +             total_weight += instance->weight;
> > > > > > +     }
> > > > > > +
> > > > > > +     if (!total_weight)
> > > > > > +             return -EINVAL;
> > > > > > +
> > > > > > +     list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> > > > > > +             int percentage;
> > > > > >               struct thermal_cooling_device *cdev = instance->cdev;
> > > > > >
> > > > > >               if (instance->trip != trip)
> > > > > >                       continue;
> > > > > >
> > > > > > -             instance->target = get_target_state(tz, cdev,
> > > > > > -                                     instance->weight, cur_trip_level);
> > > > > > +             percentage = (instance->weight * 100) / total_weight;
> > > > > > +             instance->target = get_target_state(tz, cdev, percentage,
> > > > > > +                                                 cur_trip_level);
> > > > > >
> > > > > >               instance->cdev->updated = false;
> > > > > >               thermal_cdev_update(cdev);
> > > > > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > > > > index 2ed7062fac1d..2426426731ca 100644
> > > > > > --- a/include/linux/thermal.h
> > > > > > +++ b/include/linux/thermal.h
> > > > > > @@ -40,8 +40,12 @@
> > > > > >  /* No upper/lower limit requirement */
> > > > > >  #define THERMAL_NO_LIMIT     ((u32)~0)
> > > > > >
> > > > > > -/* Default weight of a bound cooling device */
> > > > > > -#define THERMAL_WEIGHT_DEFAULT 0
> > > > > > +/*
> > > > > > + * Default weight of a bound cooling device.  By setting it to 1024 we
> > > > > > + * give developers a range so that they can specify cooling devices
> > > > > > + * that are less or more "influential" than the default
> > > > > > + */
> > > > > > +#define THERMAL_WEIGHT_DEFAULT 1024
> > > > > >
> > > > > >  /* Unit conversion macros */
> > > > > >  #define KELVIN_TO_CELSIUS(t) (long)(((long)t-2732 >= 0) ?    \
> > > > > > @@ -217,9 +221,12 @@ struct thermal_bind_params {
> > > > > >
> > > > > >       /*
> > > > > >        * This is a measure of 'how effectively these devices can
> > > > > > -      * cool 'this' thermal zone. The shall be determined by platform
> > > > > > -      * characterization. This is on a 'percentage' scale.
> > > > > > -      * See Documentation/thermal/sysfs-api.txt for more information.
> > > > > > +      * cool 'this' thermal zone. It shall be determined by
> > > > > > +      * platform characterization. This value is relative to the
> > > > > > +      * rest of the weights so a cooling device whose weight is
> > > > > > +      * double that of another cooling device is twice as
> > > > > > +      * effective. See Documentation/thermal/sysfs-api.txt for more
> > > > > > +      * information.
> > > > > >        */
> > > > > >       int weight;
> > > > > >
> > > > >
> > > > >
> > > > >
> > >
> > >
> > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
