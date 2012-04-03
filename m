From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [linux-pm] [PATCH 1/4] thermal: Add a new trip type to use
 cooling device instance number
Date: Tue, 3 Apr 2012 17:15:45 +0300
Message-ID: <20120403141545.GA27497@besouro>
References: <1329905650-30161-1-git-send-email-amit.kachhap@linaro.org>
 <1329905650-30161-2-git-send-email-amit.kachhap@linaro.org>
 <4D68720C2E767A4AA6A8796D42C8EB59043B20@BGSMSX101.gar.corp.intel.com>
 <CAK44p233Gsh3WavAEJPRcyAHERYttnJFDXsOAmAGK7tv6jhNGQ@mail.gmail.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK44p233Gsh3WavAEJPRcyAHERYttnJFDXsOAmAGK7tv6jhNGQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Amit Kachhap <amit.kachhap@linaro.org>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "rob.lee@linaro.org" <rob.lee@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On Thu, Feb 23, 2012 at 04:50:14PM +0530, Amit Kachhap wrote:
> On 23 February 2012 12:16, R, Durgadoss <durgadoss.r@intel.com> wrote=
:
> > Hi Amit,
> >
> >> -----Original Message-----
> >> From: amit kachhap [mailto:amitdanielk@gmail.com] On Behalf Of Ami=
t Daniel
> >> Kachhap
> >> Sent: Wednesday, February 22, 2012 3:44 PM
> >> To: linux-pm@lists.linux-foundation.org
> >> Cc: linux-kernel@vger.kernel.org; mjg59@srcf.ucam.org; linux-
> >> acpi@vger.kernel.org; lenb@kernel.org; linaro-dev@lists.linaro.org=
;
> >> amit.kachhap@linaro.org; R, Durgadoss; rob.lee@linaro.org; patches=
@linaro.org
> >> Subject: [PATCH 1/4] thermal: Add a new trip type to use cooling d=
evice
> >> instance number
> >>
> >> This patch adds a new trip type THERMAL_TRIP_STATE_ACTIVE. This
> >> trip behaves same as THERMAL_TRIP_ACTIVE but also passes the cooli=
ng
> >> device instance number. This helps the cooling device registered a=
s
> >> different instances to perform appropriate cooling action decision=
 in
> >> the set_cur_state call back function.
> >>
> >> Also since the trip temperature's are in ascending order so some l=
ogic
> >> is put in place to skip the un-necessary checks.
> >>
> >> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> >> ---
> >> =A0Documentation/thermal/sysfs-api.txt | =A0 =A04 +-
> >> =A0drivers/thermal/thermal_sys.c =A0 =A0 =A0 | =A0 45 ++++++++++++=
++++++++++++++++++++--
> >> =A0include/linux/thermal.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> >> =A03 files changed, 45 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/t=
hermal/sysfs-
> >> api.txt
> >> index 1733ab9..7a0c080 100644
> >> --- a/Documentation/thermal/sysfs-api.txt
> >> +++ b/Documentation/thermal/sysfs-api.txt
> >> @@ -184,8 +184,8 @@ trip_point_[0-*]_temp
> >>
> >> =A0trip_point_[0-*]_type
> >> =A0 =A0 =A0 Strings which indicate the type of the trip point.
> >> - =A0 =A0 E.g. it can be one of critical, hot, passive, active[0-*=
] for ACPI
> >> - =A0 =A0 thermal zone.
> >> + =A0 =A0 E.g. it can be one of critical, hot, passive, active[0-1=
],
> >> + =A0 =A0 state-active[0-*] for ACPI thermal zone.
> >> =A0 =A0 =A0 RO, Optional
> >>
> >> =A0cdev[0-*]
> >> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/therm=
al_sys.c
> >> index 220ce7e..d4c9b20 100644
> >> --- a/drivers/thermal/thermal_sys.c
> >> +++ b/drivers/thermal/thermal_sys.c
> >> @@ -192,6 +192,8 @@ trip_point_type_show(struct device *dev, struc=
t
> >> device_attribute *attr,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "passive\n");
> >> =A0 =A0 =A0 case THERMAL_TRIP_ACTIVE:
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "active\n");
> >> + =A0 =A0 case THERMAL_TRIP_STATE_ACTIVE:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "state-active\n");
> >> =A0 =A0 =A0 default:
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "unknown\n");
> >> =A0 =A0 =A0 }
> >> @@ -1034,10 +1036,10 @@ EXPORT_SYMBOL(thermal_cooling_device_unreg=
ister);
> >>
> >> =A0void thermal_zone_device_update(struct thermal_zone_device *tz)
> >> =A0{
> >> - =A0 =A0 int count, ret =3D 0;
> >> - =A0 =A0 long temp, trip_temp;
> >> + =A0 =A0 int count, ret =3D 0, inst_id;
> >> + =A0 =A0 long temp, trip_temp, max_state, last_trip_change =3D 0;
> >> =A0 =A0 =A0 enum thermal_trip_type trip_type;
> >> - =A0 =A0 struct thermal_cooling_device_instance *instance;
> >> + =A0 =A0 struct thermal_cooling_device_instance *instance, *state=
_instance;
> >> =A0 =A0 =A0 struct thermal_cooling_device *cdev;
> >>
> >> =A0 =A0 =A0 mutex_lock(&tz->lock);
> >> @@ -1086,6 +1088,43 @@ void thermal_zone_device_update(struct
> >> thermal_zone_device *tz)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 cdev->ops->set_cur_state(cdev, 0);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 case THERMAL_TRIP_STATE_ACTIVE:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(inst=
ance, &tz->cooling_devices,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 node) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (inst=
ance->trip !=3D count)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 continue;
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (temp=
 <=3D last_trip_change)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 continue;
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inst_id =
=3D 0;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *For thi=
s instance how many instance of same
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cooling=
 device occured before
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for=
_each_entry(state_instance,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 &tz->cooling_devices, node) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if (instance->cdev =3D=3D
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state_instance->cdev)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 inst_id++;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if (state_instance->trip =3D=3D count)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >
> > Can you explain a bit more on this loop and the set_cur_state below=
 ?
> > Sorry, I don't get the logic behind this..
>=20
> This loop is basically finding the instance id of the same cooling de=
vice.
> Say we have done like this,
> thermal_zone_bind_cooling_device(thermal, 2, cdev);
> thermal_zone_bind_cooling_device(thermal, 3, cdev);
> thermal_zone_bind_cooling_device(thermal, 4, cdev);
>=20
> In above same cooling device cdev is binded to trip no 2,3 and 4 with
> inst_id generated as 1,2,3 respectively. so set_cur_state for those
> trip reached will be called as,
> set_cur_state(cdev, 1);
> set_cur_state(cdev, 2);
> set_cur_state(cdev, 3);

In this case, why a simple state =3D get_cur_state() followed by a
set_cur_state(++state) / set_cur_state(--state) is not enough?

Another thing is if we want to do jumps in the sequence?

 set_cur_state(cdev, 1);
 set_cur_state(cdev, 3);
 set_cur_state(cdev, 6);

But for that we need a table mapping, trip vs. state.


What do you think?

>=20
> Thanks,
> Amit D
>=20
> >
> > Thanks,
> > Durga
> >
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev =3D=
 instance->cdev;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev->op=
s->get_max_state(cdev, &max_state);
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((tem=
p >=3D trip_temp) &&
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (inst_id <=3D max_state))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 cdev->ops->set_cur_state(cdev, inst_id);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if =
((temp < trip_temp) &&
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (--inst_id <=3D max_state))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 cdev->ops->set_cur_state(cdev, inst_id);
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_tri=
p_change =3D trip_temp;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case THERMAL_TRIP_PASSIVE:
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (temp >=3D trip_tem=
p || tz->passive)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 therma=
l_zone_device_passive(tz, temp,
> >> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> >> index 796f1ff..8df901f 100644
> >> --- a/include/linux/thermal.h
> >> +++ b/include/linux/thermal.h
> >> @@ -42,6 +42,7 @@ enum thermal_trip_type {
> >> =A0 =A0 =A0 THERMAL_TRIP_PASSIVE,
> >> =A0 =A0 =A0 THERMAL_TRIP_HOT,
> >> =A0 =A0 =A0 THERMAL_TRIP_CRITICAL,
> >> + =A0 =A0 THERMAL_TRIP_STATE_ACTIVE,
> >> =A0};
> >>
> >> =A0struct thermal_zone_device_ops {
> >> --
> >> 1.7.1
> >
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
