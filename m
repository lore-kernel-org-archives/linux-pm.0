From: Srikar Srimath Tirumala <srikars@nvidia.com>
Subject: Re: [PATCHv2 3/3] thermal: improve hot trip handling
Date: Wed, 3 Feb 2016 23:24:44 +0000 (UTC)
Message-ID: <loom.20160203T220315-163@post.gmane.org>
References: <1450379609-7826-1-git-send-email-edubezval@gmail.com> <1450379609-7826-4-git-send-email-edubezval@gmail.com> <CAMuHMdXdyLgM11Em-Vt_Hxidx_T85iT21zk-AAshNxEpgw_5Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60136 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbcBCXaH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 3 Feb 2016 18:30:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1aR6s8-0008PV-Bg
	for linux-pm@vger.kernel.org; Thu, 04 Feb 2016 00:30:04 +0100
Received: from searspoint.nvidia.com ([216.228.112.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2016 00:30:04 +0100
Received: from srikars by searspoint.nvidia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2016 00:30:04 +0100
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi Eduardo and Rui,

Geert Uytterhoeven <geert <at> linux-m68k.org> writes:

> 
> Hi Eduardo,
> 
> On Thu, Dec 17, 2015 at 8:13 PM, Eduardo Valentin <edubezval <at> 
gmail.com> wrote:
> > The idea is to add the choice to be notified only when temperature
> > crosses trip points. The trip points affected are the non-passive
> > trip points.
> >

This is good, how about notifying for non critical trip points as well?  
This will allow userspace to do workload throttling based on passive 
thermal trips.

> > It will check last temperature and current temperature against
> > the trip point temperature and its hysteresis.
> > In case the check shows temperature has changed enought indicating
> > a trip point crossing, a uevent will be sent to userspace.
> >
> > The uevent contains the thermal zone type, the current temperature,
> > the last temperature and the trip point in which the current 
temperature
> > now resides.

How about adding sysfs_notify on some of the existing attributes like 
trip_point_*_type instead? Since notifying passive trip points using 
uevents feels expensive we could maybe use sysfs_notify, which would 
satisfy the requirements for all type of trip points.

> >
> > The behavior of ops->notify() callback remains the same.
> >
> > Cc: Zhang Rui <rui.zhang <at> intel.com>
> > Cc: linux-pm <at> vger.kernel.org
> > Cc: linux-kernel <at> vger.kernel.org
> > Signed-off-by: Eduardo Valentin <edubezval <at> gmail.com>
> > ---
> > V1->V2: none
> > ---
> >  drivers/thermal/thermal_core.c | 52 
++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_core.c 
b/drivers/thermal/thermal_core.c
> > index a229c84..e0f1f4e 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> >  <at>  <at>  -423,6 +423,56  <at>  <at>  static void 
handle_non_critical_trips(struct thermal_zone_device *tz,
> >                        def_governor->throttle(tz, trip);
> >  }
> >
> > +static void thermal_tripped_notify(struct thermal_zone_device *tz,
> > +                                  int trip, enum thermal_trip_type 
trip_type,
> > +                                  int trip_temp)
> > +{
> > +       char tuv_name[THERMAL_NAME_LENGTH + 15], tuv_temp[25],
> > +               tuv_ltemp[25], tuv_trip[25], tuv_type[25];
> > +       char *msg[6] = { tuv_name, tuv_temp, tuv_ltemp, tuv_trip, 
tuv_type,
> > +                       NULL };
> > +       int upper_trip_hyst, upper_trip_temp, trip_hyst = 0;
> > +       int ret = 0;
> > +
> > +       snprintf(tuv_name, sizeof(tuv_name), "THERMAL_ZONE=%s", tz-
>type);
> > +       snprintf(tuv_temp, sizeof(tuv_temp), "TEMP=%d", tz-
>temperature);
> > +       snprintf(tuv_ltemp, sizeof(tuv_ltemp), "LAST_TEMP=%d",
> > +                tz->last_temperature);
> > +       snprintf(tuv_trip, sizeof(tuv_trip), "TRIP=%d", trip);
> > +       snprintf(tuv_type, sizeof(tuv_type), "TRIP_TYPE=%d", 
trip_type);
> > +
> > +       mutex_lock(&tz->lock);
> > +
> > +       /* crossing up */
> > +       if (tz->last_temperature < trip_temp && trip_temp < tz-
>temperature)
> > +               kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, msg);
> > +
> > +       if (tz->ops->get_trip_hyst)
> > +               tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
> > +
> > +       /* crossing down, check for hyst */
> > +       trip_temp -= trip_hyst;
> > +       if (tz->last_temperature > trip_temp && trip_temp > tz-
>temperature) {
> > +               snprintf(tuv_trip, sizeof(tuv_trip), "TRIP=%d", trip - 
1);
> > +               kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, msg);
> > +       }
> > +
> > +       ret = tz->ops->get_trip_temp(tz, trip + 1, &upper_trip_temp);
> 
> "trip + 1" may be equal to thermal_zone_device.trips and thus out-of-
range,
> in which case rcar_thermal_get_trip_temp() will print an error message:
> 
>     rcar_thermal e61f0000.thermal: rcar driver trip error
> 
> Is the "+ 1" (also below) intentional?
> If yes, I think the related error messages in rcar_thermal.c should be 
reduced
> to debug messages.
> 
> > +       if (ret)
> > +               goto unlock;
> > +
> > +       if (tz->ops->get_trip_hyst)
> > +               tz->ops->get_trip_hyst(tz, trip + 1, &upper_trip_hyst);
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert <at> 
linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. 
But
> when I'm talking to journalists I just say "programmer" or something like 
that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Alternate Proposal: Initiate a sysfs_notify on cooling_dev*/cur_state from 
thermal_cdev_update and a sysfs_notify on thermal_zone*/temp from 
thermal_zone_device_update whenever there is new state or whenever 
temperature crosses a trip point. 

A userspace app implementing workload throttling would be waiting for these 
notifications using the poll() method. It could have chosen any combination 
thermal zone and cooling device cur state to wait on. Upon receiving a 
notification, it would initiate actions like lowering the frame rate of a 
camera.

Please let us know your thoughts on the subject.

Thanks,
Srikar


