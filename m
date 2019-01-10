From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 02/11] thermal: add irq-mode configuration for trip
 point
Date: Thu, 10 Jan 2019 22:20:15 +0800
Message-ID: <1547130015.10666.17.camel@intel.com>
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
         <CGME20181107171036eucas1p13253d56b463c8f888ab8f8e418635297@eucas1p1.samsung.com>
         <1541610593-28542-3-git-send-email-l.luba@partner.samsung.com>
         <1544022595.2841.45.camel@intel.com>
         <2ac425fc-7c32-6e2f-7086-c14f85b0bbfd@partner.samsung.com>
         <3314da31-1b8b-ec19-4aee-38d98aa8adbf@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3314da31-1b8b-ec19-4aee-38d98aa8adbf@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com, krzk@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi, Lukasz,

On 四, 2018-12-06 at 20:55 +0100, Lukasz Luba wrote:
> 
> On 12/6/18 8:18 PM, Lukasz Luba wrote:
> > 
> > Hi Rui,
> > 
> > On 12/5/18 4:09 PM, Zhang Rui wrote:
> > > 
> > > On 三, 2018-11-07 at 18:09 +0100, Lukasz Luba wrote:
> > > > 
> > > > This patch adds support irq mode in trip point.
> > > > When that flag is set in DT, there is no need for polling
> > > > in thermal framework. Crossing the trip point will rise an IRQ.
> > > > The naming convention for tip point 'type' can be confussing
> > > > and 'passive' (whic is passive cooling) might be interpretted
> > > > wrongly.
> > > > 
> > > > This mechanism prevents from missue and adds explicit setting
> > > > for hardware which support interrupts for pre-configured
> > > > temperature
> > > > threshold.
> > > > 
> > > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > > Cc: Eduardo Valentin <edubezval@gmail.com>
> > > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> > > > ---
> > > >   drivers/thermal/of-thermal.c   | 17 +++++++++++++++++
> > > >   drivers/thermal/thermal_core.c | 10 ++++++++--
> > > >   include/linux/thermal.h        |  5 +++++
> > > >   3 files changed, 30 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-
> > > > thermal.c
> > > > index 4bfdb4a..1a75946a 100644
> > > > --- a/drivers/thermal/of-thermal.c
> > > > +++ b/drivers/thermal/of-thermal.c
> > > > @@ -312,6 +312,20 @@ static int of_thermal_get_trip_type(struct
> > > > thermal_zone_device *tz, int trip,
> > > >       return 0;
> > > >   }
> > > > +static int
> > > > +of_thermal_get_trip_irq_mode(struct thermal_zone_device *tz,
> > > > int
> > > > trip,
> > > > +                 bool *mode)
> > > > +{
> > > > +    struct __thermal_zone *data = tz->devdata;
> > > > +
> > > > +    if (trip >= data->ntrips || trip < 0)
> > > > +        return -EDOM;
> > > > +
> > > > +    *mode = data->trips[trip].irq_mode;
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > >   static int of_thermal_get_trip_temp(struct
> > > > thermal_zone_device *tz,
> > > > int trip,
> > > >                       int *temp)
> > > >   {
> > > > @@ -394,6 +408,7 @@ static struct thermal_zone_device_ops
> > > > of_thermal_ops = {
> > > >       .set_mode = of_thermal_set_mode,
> > > >       .get_trip_type = of_thermal_get_trip_type,
> > > > +    .get_trip_irq_mode = of_thermal_get_trip_irq_mode,
> > > >       .get_trip_temp = of_thermal_get_trip_temp,
> > > >       .set_trip_temp = of_thermal_set_trip_temp,
> > > >       .get_trip_hyst = of_thermal_get_trip_hyst,
> > > > @@ -827,6 +842,8 @@ static int thermal_of_populate_trip(struct
> > > > device_node *np,
> > > >           return ret;
> > > >       }
> > > > +    trip->irq_mode = of_property_read_bool(np, "irq-mode");
> > > > +
> > > >       /* Required for cooling map matching */
> > > >       trip->np = np;
> > > >       of_node_get(np);
> > > > diff --git a/drivers/thermal/thermal_core.c
> > > > b/drivers/thermal/thermal_core.c
> > > > index 39fc812..6d41e08 100644
> > > > --- a/drivers/thermal/thermal_core.c
> > > > +++ b/drivers/thermal/thermal_core.c
> > > > @@ -406,6 +406,7 @@ static void handle_critical_trips(struct
> > > > thermal_zone_device *tz,
> > > >   static void handle_thermal_trip(struct thermal_zone_device
> > > > *tz, int
> > > > trip)
> > > >   {
> > > >       enum thermal_trip_type type;
> > > > +    bool irq_mode = false;
> > > >       /* Ignore disabled trip points */
> > > >       if (test_bit(trip, &tz->trips_disabled))
> > > > @@ -419,9 +420,14 @@ static void handle_thermal_trip(struct
> > > > thermal_zone_device *tz, int trip)
> > > >           handle_non_critical_trips(tz, trip);
> > > >       /*
> > > >        * Alright, we handled this trip successfully.
> > > > -     * So, start monitoring again.
> > > > +     * So, start monitoring in polling mode if
> > > > +     * trip is not using irq HW support.
> > > >        */
> > > > -    monitor_thermal_zone(tz);
> > > > +    if (tz->ops->get_trip_irq_mode)
> > > > +        tz->ops->get_trip_irq_mode(tz, trip, &irq_mode);
> > > > +
> > > > +    if (!irq_mode)
> > > > +        monitor_thermal_zone(tz);
> > > >   }
> > > handle_thermal_trip() is called from
> > > thermal_zone_device_update(), and
> > > it is invoked for every trip points.
> > > say, you have a passive trip point 1 that supports irq_mode, and
> > > another passive trip point 2 that does not support irq_mode,
> > > monitor_thermal_zone() is still called in handle_thermal_trip(tz,
> > > 2),
> > > and the passive timer will be activated anyway, do I miss
> > > something?

sorry that I missed this thread.

> > Yes, the passive timer will be activated in your example. It is
> > correct
> > behavior and does not break anything.
> > case 1: there is 'k' passive trip points which have irq_mode and 1
> > additional which does not have 'irq_mode', the framework will start
> > polling but skip check for those 'k' trip points.
> > case 2: all of the passive trip points have irq_mode set, the
> > framework
> > will not register 'scheduled_work' because it will not call 
> > 'monitor_thermal_zone()'.
> > This is the case of most Exynos platforms, but there is one
> > exception 
> > which has 'case 1' with 2 trip points not supporting irq_mode.
> Do you suggest to cover the 'case 1'?

So this solution does not cover case 1.
And for case 2, why not set passive_delay to 0? are they sharing the
same DT file?

> It would be possible after adding a new enum THERMAL_FRAMEWORK_POLL, 
> then function:

hmmm, I think we can
1. use tz->passive to count the passive trip points that need passive
polling.
2. count tz->passive properly in the governors
3. always do passive polling when tz->passive > 0.

This will cover both cases, right?

some sample code to handle this in step_wise governor attached below,

what do you think?

thanks,
rui

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index ee047ca..59d9a1d 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -121,8 +121,15 @@ static void update_passive_instance(struct
thermal_zone_device *tz,
         * If value is +1, activate a passive instance.
         * If value is -1, deactivate a passive instance.
         */
-       if (type == THERMAL_TRIP_PASSIVE || type == THERMAL_TRIPS_NONE)
-               tz->passive += value;
+       if (type != THERMAL_TRIP_PASSIVE && type != THERMAL_TRIPS_NONE)
+               return;
+       if (tz->ops->get_trip_irq_mode) {
+               if (tz->ops->get_trip_irq_mode(tz, trip, &irq_mode))
+                               return;
+               if (irq_mode)
+                               return;
+       }
+       tz->passive += value;
 }


> thermal_zone_device_check() will call
> thermal_zone_device_update(tz, THERMAL_FRAMEWORK_POLL)
> and in handle_thermal_trip() implement something like:
> --------------8<----------------
> static void handle_thermal_trip(struct thermal_zone_device *tz, int
> trip)
> {
> 	enum thermal_trip_type type;
> 	bool irq_mode = false;
> 
> 	/* Ignore disabled trip points */
> 	if (test_bit(trip, &tz->trips_disabled))
> 		return;
> 
> 	if (tz->ops->get_trip_irq_mode)
> 		tz->ops->get_trip_irq_mode(tz, trip, &irq_mode)
> 
> 	if (tz->notify_event == THERMAL_FRAMEWORK_POLL && irq_mode)
> 		return;
> ...
> 
> 	if (!irq_mode)
> 		monitor_thermal_zone(tz);
> }
> 
> ---------->8-----------------------
> 
> I could implement it in v3 if you don't see that it add too much of
> mess 
> and agree for this approach.
> 
> Regards,
> Lukasz
> 
> > 
> > 
> > Regards,
> > Lukasz
> > 
> > > 
> > > 
> > > thanks,
> > > rui
> > > 
> > > > 
> > > >   static void update_temperature(struct thermal_zone_device
> > > > *tz)
> > > > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > > > index 5f4705f..b064565 100644
> > > > --- a/include/linux/thermal.h
> > > > +++ b/include/linux/thermal.h
> > > > @@ -103,6 +103,7 @@ struct thermal_zone_device_ops {
> > > >           enum thermal_device_mode);
> > > >       int (*get_trip_type) (struct thermal_zone_device *, int,
> > > >           enum thermal_trip_type *);
> > > > +    int (*get_trip_irq_mode) (struct thermal_zone_device *,
> > > > int,
> > > > bool *);
> > > >       int (*get_trip_temp) (struct thermal_zone_device *, int,
> > > > int
> > > > *);
> > > >       int (*set_trip_temp) (struct thermal_zone_device *, int,
> > > > int);
> > > >       int (*get_trip_hyst) (struct thermal_zone_device *, int,
> > > > int
> > > > *);
> > > > @@ -196,6 +197,7 @@ struct thermal_zone_device {
> > > >       struct thermal_attr *trip_temp_attrs;
> > > >       struct thermal_attr *trip_type_attrs;
> > > >       struct thermal_attr *trip_hyst_attrs;
> > > > +    struct thermal_attr *trip_irq_mode_attrs;
> > > >       void *devdata;
> > > >       int trips;
> > > >       unsigned long trips_disabled;    /* bitmap for disabled
> > > > trips */
> > > > @@ -364,6 +366,8 @@ struct thermal_zone_of_device_ops {
> > > >    * @temperature: temperature value in miliCelsius
> > > >    * @hysteresis: relative hysteresis in miliCelsius
> > > >    * @type: trip point type
> > > > + * @irq_mode: to not use polling in framework set support of
> > > > HW irq
> > > > (which will
> > > > + *          be triggered when temperature reaches this level).
> > > >    */
> > > >   struct thermal_trip {
> > > > @@ -371,6 +375,7 @@ struct thermal_trip {
> > > >       int temperature;
> > > >       int hysteresis;
> > > >       enum thermal_trip_type type;
> > > > +    bool irq_mode;
> > > >   };
> > > >   /* Function declarations */
> > > 
