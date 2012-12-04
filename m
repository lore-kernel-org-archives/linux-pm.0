From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [RFC PATCH 4/7] Thermal: Add Thermal_trip sysfs node
Date: Tue, 4 Dec 2012 08:41:32 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59231A7A@BGSMSX101.gar.corp.intel.com>
References: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com>
	<1353149158-19102-5-git-send-email-durgadoss.r@intel.com>
 <CAJLyvQyd=RTZx0GF6_SvPFSnqfPgh93vSvZERXMF50TzEYyobw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40764 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444Ab2LDIlh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Dec 2012 03:41:37 -0500
In-Reply-To: <CAJLyvQyd=RTZx0GF6_SvPFSnqfPgh93vSvZERXMF50TzEYyobw@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "wni@nvidia.com" <wni@nvidia.com>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>


> -----Original Message-----
> From: Hongbo Zhang [mailto:hongbo.zhang@linaro.org]
> Sent: Tuesday, December 04, 2012 2:01 PM
> To: R, Durgadoss
> Cc: Zhang, Rui; linux-pm@vger.kernel.org; wni@nvidia.com;
> eduardo.valentin@ti.com; amit.kachhap@linaro.org;
> sachin.kamat@linaro.org
> Subject: Re: [RFC PATCH 4/7] Thermal: Add Thermal_trip sysfs node
> 
> On 17 November 2012 18:45, Durgadoss R <durgadoss.r@intel.com> wrote:
> > This patch adds a thermal_trip directory under
> > /sys/class/thermal/zoneX. This directory contains
> > the trip point values for sensors bound to this
> > zone.
> >
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > ---
> >  drivers/thermal/thermal_sys.c |  244
> ++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/thermal.h       |   32 ++++++
> >  2 files changed, 274 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> > index 70e5f5a..011588a 100644
> > --- a/drivers/thermal/thermal_sys.c
> > +++ b/drivers/thermal/thermal_sys.c
> > @@ -480,9 +480,15 @@ static void remove_sensor_from_zone(struct
> thermal_zone *tz,
> >
> >         sysfs_remove_link(&tz->device.kobj, kobject_name(&ts-
> >device.kobj));
> >
> > +       /* Delete this sensor's trip Kobject */
> > +       kobject_del(tz->kobj_trip[indx]);
> > +
> >         /* Shift the entries in the tz->sensors array */
> > -       for (j = indx; j < MAX_SENSORS_PER_ZONE - 1; j++)
> > +       for (j = indx; j < MAX_SENSORS_PER_ZONE - 1; j++) {
> >                 tz->sensors[j] = tz->sensors[j + 1];
> > +               tz->trip[j] = tz->trip[j + 1];
> > +               tz->kobj_trip[j] = tz->kobj_trip[j + 1];
> > +       }
> >
> >         tz->sensor_indx--;
> >  }
> > @@ -505,6 +511,41 @@ static void remove_cdev_from_zone(struct
> thermal_zone *tz,
> >         tz->cdev_indx--;
> >  }
> >
> > +static struct thermal_zone *get_zone_by_trip_kobj(struct kobject *kobj)
> > +{
> > +       struct thermal_zone *pos;
> > +       struct thermal_zone *tz = NULL;
> > +
> > +       if (!kobj)
> > +               return NULL;
> > +
> > +       mutex_lock(&tz_list_lock);
> > +       for_each_thermal_zone(pos) {
> > +               if (pos->kobj_thermal_trip == kobj) {
> > +                       tz = pos;
> > +                       break;
> > +               }
> > +       }
> > +       mutex_unlock(&tz_list_lock);
> > +       return tz;
> > +}
> > +
> > +static struct thermal_sensor *get_sensor_by_kobj_name(const char
> *name)
> > +{
> > +       struct thermal_sensor *pos;
> > +       struct thermal_sensor *ts = NULL;
> > +
> > +       mutex_lock(&ts_list_lock);
> > +       for_each_thermal_sensor(pos) {
> > +               if (!strcmp(kobject_name(&pos->device.kobj), name)) {
> > +                       ts = pos;
> > +                       break;
> > +               }
> > +       }
> > +       mutex_unlock(&ts_list_lock);
> > +       return ts;
> > +}
> > +
> >  /* sys I/F for thermal zone */
> >
> >  #define to_thermal_zone(_dev) \
> > @@ -859,6 +900,113 @@ policy_show(struct device *dev, struct
> device_attribute *devattr, char *buf)
> >         return sprintf(buf, "%s\n", tz->governor->name);
> >  }
> >
> > +static ssize_t
> > +active_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> > +{
> > +       int i, indx, ret = 0;
> > +       struct thermal_sensor *ts;
> > +       struct thermal_zone *tz;
> > +
> > +       ts = get_sensor_by_kobj_name(kobject_name(kobj));
> > +       if (!ts)
> > +               return -EINVAL;
> > +
> > +       tz = get_zone_by_trip_kobj(kobj->parent);
> > +       if (!tz)
> > +               return -EINVAL;
> > +
> > +       indx = get_sensor_indx(tz, ts);
> > +       if (indx < 0)
> > +               return indx;
> > +
> > +       if (tz->trip[indx]->num_active_trips <= 0)
> > +               return sprintf(buf, "<Not available>\n");
> > +
> > +       ret += sprintf(buf, "0x%x", tz->trip[indx]->active_trip_mask);
> > +       for (i = 0; i < tz->trip[indx]->num_active_trips; i++) {
> > +               ret += sprintf(buf + ret, " %d",
> > +                       tz->trip[indx]->active_trips[i]);
> > +       }
> > +
> > +       ret += sprintf(buf + ret, "\n");
> > +       return ret;
> > +}
> > +
> > +static ssize_t
> > +ptrip_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> Just remind you it is better to use passive_show instead of ptrip_show
> when you remove the unused old codes.

Yes, you told the reason also :-)
I did that because we have another function named passive_show.
So, when we remove the old code, we will change this name also :-)

Thanks,
Durga
