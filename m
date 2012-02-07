From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [linux-pm] [RFC PATCH] thermal: Add support to report cooling
 statistics achieved by cooling devices
Date: Tue, 7 Feb 2012 21:29:03 +0200
Message-ID: <20120207192903.GA8589@besouro>
References: <1326878467-17766-1-git-send-email-amit.kachhap@linaro.org>
 <20120207070917.GA2616@besouro>
 <CAK44p20-3+Ndn1pJmX7tT=UtYE+876_iNtqR+S0==wTh=iwvzA@mail.gmail.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK44p20-3+Ndn1pJmX7tT=UtYE+876_iNtqR+S0==wTh=iwvzA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Amit Kachhap <amit.kachhap@linaro.org>
Cc: eduardo.valentin@ti.com, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rob.lee@linaro.org
List-Id: linux-pm@vger.kernel.org

Hello Amit,

On Tue, Feb 07, 2012 at 09:52:40AM -0800, Amit Kachhap wrote:
> Hi eduardo,
>=20
> Thanks for the detail review.
>=20
> On 6 February 2012 23:09, Eduardo Valentin <eduardo.valentin@ti.com> =
wrote:
> > Hello Amit,
> >
> > some comments embedded.
> >
> > On Wed, Jan 18, 2012 at 02:51:07PM +0530, Amit Daniel Kachhap wrote=
:
> >> Add a sysfs node code to report effective cooling of all cooling d=
evices
> >> attached to each trip points of a thermal zone. The cooling data r=
eported
> >> will be absolute if the higher temperature trip points are arrange=
d first
> >> otherwise the cooling stats is the cumulative effect of the earlie=
r
> >> invoked cooling handlers.
> >>
> >> The basic assumption is that cooling devices will bring down the t=
emperature
> >> in a symmetric manner and those statistics can be stored back and =
used for
> >> further tuning of the system.
> >>
> >> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> >> ---
> >> =A0Documentation/thermal/sysfs-api.txt | =A0 10 ++++
> >> =A0drivers/thermal/thermal_sys.c =A0 =A0 =A0 | =A0 96 ++++++++++++=
+++++++++++++++++++++++
> >> =A0include/linux/thermal.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 +++
> >> =A03 files changed, 114 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/t=
hermal/sysfs-api.txt
> >> index b61e46f..1db9a9d 100644
> >> --- a/Documentation/thermal/sysfs-api.txt
> >> +++ b/Documentation/thermal/sysfs-api.txt
> >> @@ -209,6 +209,13 @@ passive
> >> =A0 =A0 =A0 Valid values: 0 (disabled) or greater than 1000
> >> =A0 =A0 =A0 RW, Optional
> >>
> >> +trip_stats
> >> + =A0 =A0 This attribute presents the effective cooling generated =
from all the
> >> + =A0 =A0 cooling devices attached to a trip point. The output is =
a pair of value
> >> + =A0 =A0 for each trip point. Each pair represents
> >> + =A0 =A0 (trip index, cooling temperature difference in millidegr=
ee Celsius)
> >> + =A0 =A0 RO, Optional
> >> +
> >> =A0*****************************
> >> =A0* Cooling device attributes *
> >> =A0*****************************
> >> @@ -261,6 +268,9 @@ method, the sys I/F structure will be built li=
ke this:
> >> =A0 =A0 =A0|---cdev0_trip_point: =A0 =A01 =A0 =A0 =A0 /* cdev0 can=
 be used for passive */
> >> =A0 =A0 =A0|---cdev1: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
--->/sys/class/thermal/cooling_device3
> >> =A0 =A0 =A0|---cdev1_trip_point: =A0 =A02 =A0 =A0 =A0 /* cdev1 can=
 be used for active[0]*/
> >> + =A0 =A0|---trip_stats =A0 =A0 =A0 =A0 =A0 0 0
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 8000 =A0=
/*trip 1 causes 8 degree Celsius drop*/
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2 3000 =A0=
/*trip 2 causes 3 degree Celsius drop*/
> >>
> >> =A0|cooling_device0:
> >> =A0 =A0 =A0|---type: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
Processor
> >> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/therm=
al_sys.c
> >> index dd9a574..47e7b6e 100644
> >> --- a/drivers/thermal/thermal_sys.c
> >> +++ b/drivers/thermal/thermal_sys.c
> >> @@ -92,6 +92,64 @@ static void release_idr(struct idr *idr, struct=
 mutex *lock, int id)
> >> =A0 =A0 =A0 if (lock)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(lock);
> >> =A0}
> >> +static void update_cooling_stats(struct thermal_zone_device *tz, =
long cur_temp)
> >> +{
> >> + =A0 =A0 int count, max_index, cur_interval;
> >> + =A0 =A0 long trip_temp, max_temp =3D 0, cool_temp;
> >> + =A0 =A0 static int last_trip_level =3D -1;
> >
> > I got confused here. Are you sure using a static variable here is s=
afe? I suppose this function
> > is called for any thermal_zone_device, which in turns, may have dif=
ferent amount of trips, and
> > different update rate. You may be using last_trip_level as referenc=
e for a different tz. Meaning,
> > you would be screwing the stat buffers silently.
> >
> > If that is the case, I suggest you to move this to your stat struct=
ure.
>=20
> Agree. This looks a clear problem. Surely i will move last_trip_level
> inside structure tz.
>=20
> >
> >> +
> >> + =A0 =A0 if (cur_temp >=3D tz->last_temperature)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> +
> >> + =A0 =A0 /* find the trip according to last temperature */
> >> + =A0 =A0 for (count =3D 0; count < tz->trips; count++) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 tz->ops->get_trip_temp(tz, count, &trip_=
temp);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (tz->last_temperature >=3D trip_temp)=
 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (max_temp < trip_temp=
) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_temp=
 =3D trip_temp;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_inde=
x =3D count;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 if (!max_temp) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 last_trip_level =3D -1;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 cur_interval =3D tz->stat[max_index].interval_ptr;
> >> + =A0 =A0 cool_temp =3D tz->last_temperature - cur_temp;
> >> +
> >> + =A0 =A0 if (last_trip_level !=3D max_index) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (++cur_interval =3D=3D INTERVAL_HISTO=
RY)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_interval =3D 0;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 tz->stat[max_index].cool_temp[cur_interv=
al] =3D cool_temp;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 tz->stat[max_index].interval_ptr =3D cur=
_interval;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 last_trip_level =3D max_index;
> >> + =A0 =A0 } else {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 tz->stat[max_index].cool_temp[cur_interv=
al] +=3D cool_temp;
> >
> > Why do you need to sum up here? Wouldn't this break your statistics=
? (I may completely missed your idea for last_trip_level).
> This will be summed up because after applying cooling action there is
> some cooling happening but not enough to change the trip level. So
> unless there is cooling enough to change the trip level I keep summin=
g
> the temperature.

OK. You may want to add this explanation as a comment in the code.

> >
> >> + =A0 =A0 }
> >> +}
> >> +
> >> +static int calculate_cooling_temp_avg(struct thermal_zone_device =
*tz, int trip,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 int *avg_cool)
> >> +{
> >> + =A0 =A0 int result =3D 0, count =3D 0, used_data =3D 0;
> >> +
> >> + =A0 =A0 if (trip > THERMAL_MAX_TRIPS)
> >
> > Shouldn't this be checked against tz->trips ? At least you allocate=
 your *stat based on it.
> Correct.
> >
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> +
> >> + =A0 =A0 *avg_cool =3D 0;
> >> + =A0 =A0 for (count =3D 0; count < INTERVAL_HISTORY; count++) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (tz->stat[trip].cool_temp[count] > 0)=
 {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *avg_cool +=3D tz->stat[=
trip].cool_temp[count];
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 used_data++;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 }
> >> + =A0 =A0 if (used_data > 1)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 *avg_cool =3D (*avg_cool)/used_data;
> >
> > IIRC, the preferred operator style is (*avg_cool) / used_data
> OK.
> >
> >> + =A0 =A0 return result;
> >
> > result is used only to hold a 0 here?
> Ok This variable is not needed.
> >
> >> +}
> >>
> >> =A0/* sys I/F for thermal zone */
> >>
> >> @@ -493,6 +551,26 @@ temp_crit_show(struct device *dev, struct dev=
ice_attribute *attr,
> >> =A0 =A0 =A0 return sprintf(buf, "%ld\n", temperature);
> >> =A0}
> >>
> >> +static ssize_t
> >> +thermal_cooling_trip_stats_show(struct device *dev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct d=
evice_attribute *attr,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *bu=
f)
> >> +{
> >> + =A0 =A0 struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> >> + =A0 =A0 int avg_cool =3D 0, result, trip_index;
> >> + =A0 =A0 ssize_t len =3D 0;
> >> +
> >> + =A0 =A0 for (trip_index =3D 0; trip_index < tz->trips; trip_inde=
x++) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 result =A0=3D calculate_cooling_temp_avg=
(tz,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 trip_index, &avg_cool);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (!result)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len +=3D sprintf(buf + l=
en, "%d %d\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 trip_index, avg_cool);
> >> + =A0 =A0 }
> >> + =A0 =A0 return len;
> >> +}
> >> +static DEVICE_ATTR(trip_stats, 0444,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0thermal_cooling_trip_stats_show, =
NULL);
> >>
> >> =A0static struct thermal_hwmon_device *
> >> =A0thermal_hwmon_lookup_by_type(const struct thermal_zone_device *=
tz)
> >> @@ -1049,6 +1127,8 @@ void thermal_zone_device_update(struct therm=
al_zone_device *tz)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto leave;
> >> =A0 =A0 =A0 }
> >>
> >> + =A0 =A0 update_cooling_stats(tz, temp);
> >> +
> >> =A0 =A0 =A0 for (count =3D 0; count < tz->trips; count++) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tz->ops->get_trip_type(tz, count, &tri=
p_type);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tz->ops->get_trip_temp(tz, count, &tri=
p_temp);
> >> @@ -1181,6 +1261,13 @@ struct thermal_zone_device *thermal_zone_de=
vice_register(char *type,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(result);
> >> =A0 =A0 =A0 }
> >>
> >> + =A0 =A0 /*Allocate variables for cooling stats*/
> >> + =A0 =A0 tz->stat =A0=3D devm_kzalloc(&tz->device,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(s=
truct thermal_cooling_stats) * trips,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERN=
EL);
> >
> > You never free this memory here.
> yes because memory allocated with devm_kzalloc is freed automatically
> when the device is freed.

OK. missed the devm_ on your code. My bad.

> >
> >> + =A0 =A0 if (!tz->stat)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto unregister;
> >> +
> >> =A0 =A0 =A0 /* sys I/F */
> >> =A0 =A0 =A0 if (type) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D device_create_file(&tz->dev=
ice, &dev_attr_type);
> >> @@ -1207,6 +1294,12 @@ struct thermal_zone_device *thermal_zone_de=
vice_register(char *type,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 passive =3D 1;
> >> =A0 =A0 =A0 }
> >>
> >> + =A0 =A0 if (trips > 0) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 result =3D device_create_file(&tz->devic=
e, &dev_attr_trip_stats);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (result)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unregister;
> >
> > The failing paths after your allocation point must consider freeing=
 the memory you requested.
> >
> >> + =A0 =A0 }
> >> +
> >> =A0 =A0 =A0 if (!passive)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D device_create_file(&tz->dev=
ice,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 &dev_attr_passive);
> >> @@ -1282,6 +1375,9 @@ void thermal_zone_device_unregister(struct t=
hermal_zone_device *tz)
> >> =A0 =A0 =A0 for (count =3D 0; count < tz->trips; count++)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 TRIP_POINT_ATTR_REMOVE(&tz->device, co=
unt);
> >>
> >> + =A0 =A0 if (tz->trips > 0)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 device_remove_file(&tz->device, &dev_att=
r_trip_stats);
> >> +
> >
> > Amit,
> >
> > I think here it would be a good place to free the memory you alloca=
ted for *stat
> >
> >> =A0 =A0 =A0 thermal_remove_hwmon_sysfs(tz);
> >> =A0 =A0 =A0 release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id=
);
> >> =A0 =A0 =A0 idr_destroy(&tz->idr);
> >> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> >> index 47b4a27..47504c7 100644
> >> --- a/include/linux/thermal.h
> >> +++ b/include/linux/thermal.h
> >> @@ -72,6 +72,13 @@ struct thermal_cooling_device_ops {
> >> =A0#define THERMAL_TRIPS_NONE -1
> >> =A0#define THERMAL_MAX_TRIPS 12
> >> =A0#define THERMAL_NAME_LENGTH 20
> >> +#define INTERVAL_HISTORY 12
> >> +
> >> +struct thermal_cooling_stats {
> >> + =A0 =A0 int cool_temp[INTERVAL_HISTORY];
> >> + =A0 =A0 int interval_ptr;
> >> +};
> >> +
> >> =A0struct thermal_cooling_device {
> >> =A0 =A0 =A0 int id;
> >> =A0 =A0 =A0 char type[THERMAL_NAME_LENGTH];
> >> @@ -102,6 +109,7 @@ struct thermal_zone_device {
> >> =A0 =A0 =A0 struct list_head cooling_devices;
> >> =A0 =A0 =A0 struct idr idr;
> >> =A0 =A0 =A0 struct mutex lock; =A0 =A0 =A0/* protect cooling devic=
es list */
> >> + =A0 =A0 struct thermal_cooling_stats *stat;
> >> =A0 =A0 =A0 struct list_head node;
> >> =A0 =A0 =A0 struct delayed_work poll_queue;
> >> =A0};
> >> --
> >> 1.7.1
> >>
> >> _______________________________________________
> >> linux-pm mailing list
> >> linux-pm@lists.linux-foundation.org
> >> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
