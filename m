From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [linux-pm] [RFC PATCH 1/2] thermal: Add a new trip type to use
 cooling device instance number
Date: Wed, 11 Jan 2012 02:12:59 -0600
Message-ID: <CAMXH7KG9JdxSxPERr4gG=nHFLdgUzqYBO=sUiDOp-G2bPcoVQw@mail.gmail.com>
References: <1323789196-4942-1-git-send-email-amit.kachhap@linaro.org>
	<1323789196-4942-2-git-send-email-amit.kachhap@linaro.org>
	<CAKfTPtCVtWfdUpW=Up6eWTsceBCfER5NcvjF1KRTNcqys2YArQ@mail.gmail.com>
	<CAK44p232PbvGRXKB7_3TYn0Q3iqgRJg6Qv81W_EwXCHL+79baA@mail.gmail.com>
	<CAK44p23apXmAUY3DR2rogeAwMQmOEdwW3SZbEpxApVkc9He+kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAK44p23apXmAUY3DR2rogeAwMQmOEdwW3SZbEpxApVkc9He+kg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Amit Kachhap <amit.kachhap@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hey Amit/Vincent,

It appears that with this implementation the STATE_ACTIVE trip number
used will also be the index of the cool_freq_tab used.  If that is
true, then perhaps a common structure would be beneficial that links
each STATE_ACTIVE trip point with its corresponding cooling data.

BR,
Rob

On Tue, Dec 20, 2011 at 11:11 PM, Amit Kachhap <amit.kachhap@linaro.org=
> wrote:
> =A0Hi Vincent,
>
> Thanks for the review.
> Well actually your are correct that current temperature and last
> temperature can be used to increase or decrease the cpu frequency. Bu=
t
> this has to be done again in cooling devices so to make the cooling
> devices generic and to avoid the temperature comparison again this ne=
w
> trip type passes the cooling device instance id.
> Also about your queries that this may add dependency between trip
> index and cooling state. This is actually needed and this dependency
> is created when the cooling device is binded with trip points(For
> cpufreq type cooling device just the instance of cooling device is
> associated with trip points). More over the existing PASSIVE cooling
> trip type does the same thing and iterates across all the cooling
> state.
>
> =A0Thanks,
> =A0Amit Daniel
>>
>> On 20 December 2011 18:07, Vincent Guittot <vincent.guittot@linaro.o=
rg> wrote:
>>>
>>> Hi Amit,
>>>
>>> I'm not sure that using the trip index for setting the state of a
>>> cooling device is a generic solution because you are adding a
>>> dependency between the trip index and the cooling device state that
>>> might be difficult to handle. This dependency implies that a coolin=
g
>>> device like cpufreq_cooling_device must be registered in the 1st tr=
ips
>>> of a thermal_zone which is not possible when we want to register 2
>>> cpufreq_cooling_devices in the same thermal_zone.
>>> You should only rely on the current and last temperatures to detect=
 if
>>> a trip_temp has been crossed and you should increase or decrease th=
e
>>> current state of the cooling device accordingly.
>>>
>>> something like below should work with cpufreq_cooling_device and wi=
ll
>>> not add any constraint on the trip index. The state of a cooling
>>> device is increased/decreased once for each trip
>>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case THERMAL_TRIP_STATE_ACTIVE:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(i=
nstance, &tz->cooling_devices,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 node) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i=
nstance->trip !=3D count)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 continue;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev =
=3D instance->cdev;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((=
temp >=3D trip_temp)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 && (trip_temp > tz->last_temperature)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 cdev->ops->get_max_state(cdev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &max_state);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 cdev->ops->get_cur_state(cdev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &current_state);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (++current_state <=3D max_state)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 cdev->ops->set_cur_state(cdev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current_state)=
;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else =
if ((temp < trip_temp)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 && (trip_temp <=3D tz->last_temperature)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 cdev->ops->get_cur_state(cdev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &current_state);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (current_state > 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 cdev->ops->set_cur_state(cdev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --current_stat=
e);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>
>>> Regards,
>>> Vincent
>>>
>>> On 13 December 2011 16:13, Amit Daniel Kachhap <amit.kachhap@linaro=
=2Eorg> wrote:
>>> > This patch adds a new trip type THERMAL_TRIP_STATE_ACTIVE. This
>>> > trip behaves same as THERMAL_TRIP_ACTIVE but also passes the cool=
ing
>>> > device instance number. This helps the cooling device registered =
as
>>> > different instances to perform appropriate cooling action decisio=
n in
>>> > the set_cur_state call back function.
>>> >
>>> > Also since the trip temperature's are in ascending order so some =
logic
>>> > is put in place to skip the un-necessary checks.
>>> >
>>> > Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>>> > ---
>>> > =A0Documentation/thermal/sysfs-api.txt | =A0 =A04 ++--
>>> > =A0drivers/thermal/thermal_sys.c =A0 =A0 =A0 | =A0 27 +++++++++++=
+++++++++++++++-
>>> > =A0include/linux/thermal.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>>> > =A03 files changed, 29 insertions(+), 3 deletions(-)
>>> >
>>> > diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/=
thermal/sysfs-api.txt
>>> > index b61e46f..5c1d44e 100644
>>> > --- a/Documentation/thermal/sysfs-api.txt
>>> > +++ b/Documentation/thermal/sysfs-api.txt
>>> > @@ -184,8 +184,8 @@ trip_point_[0-*]_temp
>>> >
>>> > =A0trip_point_[0-*]_type
>>> > =A0 =A0 =A0 =A0Strings which indicate the type of the trip point.
>>> > - =A0 =A0 =A0 E.g. it can be one of critical, hot, passive, activ=
e[0-*] for ACPI
>>> > - =A0 =A0 =A0 thermal zone.
>>> > + =A0 =A0 =A0 E.g. it can be one of critical, hot, passive, activ=
e[0-1],
>>> > + =A0 =A0 =A0 state-active[0-*] for ACPI thermal zone.
>>> > =A0 =A0 =A0 =A0RO, Optional
>>> >
>>> > =A0cdev[0-*]
>>> > diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/ther=
mal_sys.c
>>> > index dd9a574..72b1ab3 100644
>>> > --- a/drivers/thermal/thermal_sys.c
>>> > +++ b/drivers/thermal/thermal_sys.c
>>> > @@ -192,6 +192,8 @@ trip_point_type_show(struct device *dev, stru=
ct device_attribute *attr,
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return sprintf(buf, "passive\n");
>>> > =A0 =A0 =A0 =A0case THERMAL_TRIP_ACTIVE:
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return sprintf(buf, "active\n");
>>> > + =A0 =A0 =A0 case THERMAL_TRIP_STATE_ACTIVE:
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "state-active\n=
");
>>> > =A0 =A0 =A0 =A0default:
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return sprintf(buf, "unknown\n");
>>> > =A0 =A0 =A0 =A0}
>>> > @@ -1035,7 +1037,7 @@ EXPORT_SYMBOL(thermal_cooling_device_unregi=
ster);
>>> > =A0void thermal_zone_device_update(struct thermal_zone_device *tz=
)
>>> > =A0{
>>> > =A0 =A0 =A0 =A0int count, ret =3D 0;
>>> > - =A0 =A0 =A0 long temp, trip_temp;
>>> > + =A0 =A0 =A0 long temp, trip_temp, max_state, last_trip_change =3D=
 0;
>>> > =A0 =A0 =A0 =A0enum thermal_trip_type trip_type;
>>> > =A0 =A0 =A0 =A0struct thermal_cooling_device_instance *instance;
>>> > =A0 =A0 =A0 =A0struct thermal_cooling_device *cdev;
>>> > @@ -1086,6 +1088,29 @@ void thermal_zone_device_update(struct the=
rmal_zone_device *tz)
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0cdev->ops->set_cur_state(cdev, 0);
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case THERMAL_TRIP_STATE_ACTIVE:
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry=
(instance, &tz->cooling_devices,
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 node) {
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if =
(instance->trip !=3D count)
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 continue;
>>> > +
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if =
(temp <=3D last_trip_change)
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 continue;
>>> > +
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cde=
v =3D instance->cdev;
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cde=
v->ops->get_max_state(cdev, &max_state);
>>> > +
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if =
((temp >=3D trip_temp) &&
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((count + 1) <=3D max_state))
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 cdev->ops->set_cur_state(cdev,
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count + 1)=
;
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 els=
e if ((temp < trip_temp) &&
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (count <=3D max_state))
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 cdev->ops->set_cur_state(cdev, count);
>>> > +
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 las=
t_trip_change =3D trip_temp;
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case THERMAL_TRIP_PASSIVE:
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (temp >=3D trip=
_temp || tz->passive)
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0th=
ermal_zone_device_passive(tz, temp,
>>> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>> > index 47b4a27..d7d0a27 100644
>>> > --- a/include/linux/thermal.h
>>> > +++ b/include/linux/thermal.h
>>> > @@ -42,6 +42,7 @@ enum thermal_trip_type {
>>> > =A0 =A0 =A0 =A0THERMAL_TRIP_PASSIVE,
>>> > =A0 =A0 =A0 =A0THERMAL_TRIP_HOT,
>>> > =A0 =A0 =A0 =A0THERMAL_TRIP_CRITICAL,
>>> > + =A0 =A0 =A0 THERMAL_TRIP_STATE_ACTIVE,
>>> > =A0};
>>> >
>>> > =A0struct thermal_zone_device_ops {
>>> > --
>>> > 1.7.1
>>> >
>>> > _______________________________________________
>>> > linux-pm mailing list
>>> > linux-pm@lists.linux-foundation.org
>>> > https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
