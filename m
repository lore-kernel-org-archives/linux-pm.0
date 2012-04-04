From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/4] thermal: Add a new trip type to use
 cooling device instance number
Date: Wed, 4 Apr 2012 09:27:19 +0300
Message-ID: <20120404062719.GA6785@besouro>
References: <1329905650-30161-1-git-send-email-amit.kachhap@linaro.org>
	<1329905650-30161-2-git-send-email-amit.kachhap@linaro.org>
	<4D68720C2E767A4AA6A8796D42C8EB59043B20@BGSMSX101.gar.corp.intel.com>
	<CAK44p233Gsh3WavAEJPRcyAHERYttnJFDXsOAmAGK7tv6jhNGQ@mail.gmail.com>
	<20120403141545.GA27497@besouro>
	<CAK44p20MOu+6qFpwwta+ttbKXgHxsDKyG06EFZBSNFO0aLMDag@mail.gmail.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAK44p20MOu+6qFpwwta+ttbKXgHxsDKyG06EFZBSNFO0aLMDag@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Amit Kachhap <amit.kachhap@linaro.org>
Cc: "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "rob.lee@linaro.org" <rob.lee@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On Wed, Apr 04, 2012 at 09:53:15AM +0530, Amit Kachhap wrote:
> Hi Eduardo,
> =

> On 3 April 2012 19:45, Eduardo Valentin <eduardo.valentin@ti.com> wrote:
> > Hello,
> >
> > On Thu, Feb 23, 2012 at 04:50:14PM +0530, Amit Kachhap wrote:
> >> On 23 February 2012 12:16, R, Durgadoss <durgadoss.r@intel.com> wrote:
> >> > Hi Amit,
> >> >
> >> >> -----Original Message-----
> >> >> From: amit kachhap [mailto:amitdanielk@gmail.com] On Behalf Of Amit=
 Daniel
> >> >> Kachhap
> >> >> Sent: Wednesday, February 22, 2012 3:44 PM
> >> >> To: linux-pm@lists.linux-foundation.org
> >> >> Cc: linux-kernel@vger.kernel.org; mjg59@srcf.ucam.org; linux-
> >> >> acpi@vger.kernel.org; lenb@kernel.org; linaro-dev@lists.linaro.org;
> >> >> amit.kachhap@linaro.org; R, Durgadoss; rob.lee@linaro.org; patches@=
linaro.org
> >> >> Subject: [PATCH 1/4] thermal: Add a new trip type to use cooling de=
vice
> >> >> instance number
> >> >>
> >> >> This patch adds a new trip type THERMAL_TRIP_STATE_ACTIVE. This
> >> >> trip behaves same as THERMAL_TRIP_ACTIVE but also passes the cooling
> >> >> device instance number. This helps the cooling device registered as
> >> >> different instances to perform appropriate cooling action decision =
in
> >> >> the set_cur_state call back function.
> >> >>
> >> >> Also since the trip temperature's are in ascending order so some lo=
gic
> >> >> is put in place to skip the un-necessary checks.
> >> >>
> >> >> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> >> >> ---
> >> >> =A0Documentation/thermal/sysfs-api.txt | =A0 =A04 +-
> >> >> =A0drivers/thermal/thermal_sys.c =A0 =A0 =A0 | =A0 45 +++++++++++++=
+++++++++++++++++++--
> >> >> =A0include/linux/thermal.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> >> >> =A03 files changed, 45 insertions(+), 5 deletions(-)
> >> >>
> >> >> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/th=
ermal/sysfs-
> >> >> api.txt
> >> >> index 1733ab9..7a0c080 100644
> >> >> --- a/Documentation/thermal/sysfs-api.txt
> >> >> +++ b/Documentation/thermal/sysfs-api.txt
> >> >> @@ -184,8 +184,8 @@ trip_point_[0-*]_temp
> >> >>
> >> >> =A0trip_point_[0-*]_type
> >> >> =A0 =A0 =A0 Strings which indicate the type of the trip point.
> >> >> - =A0 =A0 E.g. it can be one of critical, hot, passive, active[0-*]=
 for ACPI
> >> >> - =A0 =A0 thermal zone.
> >> >> + =A0 =A0 E.g. it can be one of critical, hot, passive, active[0-1],
> >> >> + =A0 =A0 state-active[0-*] for ACPI thermal zone.
> >> >> =A0 =A0 =A0 RO, Optional
> >> >>
> >> >> =A0cdev[0-*]
> >> >> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/therma=
l_sys.c
> >> >> index 220ce7e..d4c9b20 100644
> >> >> --- a/drivers/thermal/thermal_sys.c
> >> >> +++ b/drivers/thermal/thermal_sys.c
> >> >> @@ -192,6 +192,8 @@ trip_point_type_show(struct device *dev, struct
> >> >> device_attribute *attr,
> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "passive\n");
> >> >> =A0 =A0 =A0 case THERMAL_TRIP_ACTIVE:
> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "active\n");
> >> >> + =A0 =A0 case THERMAL_TRIP_STATE_ACTIVE:
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "state-active\n");
> >> >> =A0 =A0 =A0 default:
> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "unknown\n");
> >> >> =A0 =A0 =A0 }
> >> >> @@ -1034,10 +1036,10 @@ EXPORT_SYMBOL(thermal_cooling_device_unregi=
ster);
> >> >>
> >> >> =A0void thermal_zone_device_update(struct thermal_zone_device *tz)
> >> >> =A0{
> >> >> - =A0 =A0 int count, ret =3D 0;
> >> >> - =A0 =A0 long temp, trip_temp;
> >> >> + =A0 =A0 int count, ret =3D 0, inst_id;
> >> >> + =A0 =A0 long temp, trip_temp, max_state, last_trip_change =3D 0;
> >> >> =A0 =A0 =A0 enum thermal_trip_type trip_type;
> >> >> - =A0 =A0 struct thermal_cooling_device_instance *instance;
> >> >> + =A0 =A0 struct thermal_cooling_device_instance *instance, *state_=
instance;
> >> >> =A0 =A0 =A0 struct thermal_cooling_device *cdev;
> >> >>
> >> >> =A0 =A0 =A0 mutex_lock(&tz->lock);
> >> >> @@ -1086,6 +1088,43 @@ void thermal_zone_device_update(struct
> >> >> thermal_zone_device *tz)
> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 cdev->ops->set_cur_state(cdev, 0);
> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 case THERMAL_TRIP_STATE_ACTIVE:
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(insta=
nce, &tz->cooling_devices,
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 node) {
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (insta=
nce->trip !=3D count)
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 continue;
> >> >> +
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (temp =
<=3D last_trip_change)
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 continue;
> >> >> +
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 inst_id =
=3D 0;
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *For this=
 instance how many instance of same
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *cooling =
device occured before
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> >> >> +
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_=
each_entry(state_instance,
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 &tz->cooling_devices, node) {
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if (instance->cdev =3D=3D
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state_instance->cdev)
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 inst_id++;
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if (state_instance->trip =3D=3D count)
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >
> >> > Can you explain a bit more on this loop and the set_cur_state below ?
> >> > Sorry, I don't get the logic behind this..
> >>
> >> This loop is basically finding the instance id of the same cooling dev=
ice.
> >> Say we have done like this,
> >> thermal_zone_bind_cooling_device(thermal, 2, cdev);
> >> thermal_zone_bind_cooling_device(thermal, 3, cdev);
> >> thermal_zone_bind_cooling_device(thermal, 4, cdev);
> >>
> >> In above same cooling device cdev is binded to trip no 2,3 and 4 with
> >> inst_id generated as 1,2,3 respectively. so set_cur_state for those
> >> trip reached will be called as,
> >> set_cur_state(cdev, 1);
> >> set_cur_state(cdev, 2);
> >> set_cur_state(cdev, 3);
> >
> > In this case, why a simple state =3D get_cur_state() followed by a
> > set_cur_state(++state) / set_cur_state(--state) is not enough?
> =

> Thanks for looking into the patch. Well actually what you are
> suggesting is exactly happening in PASSIVE trip types where the states
> are incremented or decremented based on thermal trend. On the contrary
> what this part of code is doing is to jump to a fixed state as and
> when a trip point is reached.  The cooling effect of a frequency level
> is known beforehand and hence jumping into that is safe and also this
> does not cause performance degradation by going into a much lower
> frequency state just for temperature stablization.

Yeah, I see that you want to match an instance of the cooling device with
a cooling state for that cooling device.

> =

> >
> > Another thing is if we want to do jumps in the sequence?
> >
> > =A0set_cur_state(cdev, 1);
> > =A0set_cur_state(cdev, 3);
> > =A0set_cur_state(cdev, 6);
> >
> > But for that we need a table mapping, trip vs. state.
> >
> >
> > What do you think?
> In the current thermal_zone_device_update implementation all the
> checks are currently based on increase in temperature. So even though
> we want to go to  set_cur_state(cdev, 6) we have to follow
> set_cur_state(cdev, 1), set_cur_state(cdev, 2) ,..... and finally
> set_cur_state(cdev, 6). So mapping table may not be needed as state
> transition is one by one. This a type of limitation but I think there
> can be some kind of modification in the way the
> thermal_zone_device_update calls all the lower temperature cooling
> devices instead of jumping directly to the final trip point cooling
> devices.


But, because you also force the thing to be increasing / decreasing 1 by 1,
I don't understand why you don't have a similar implementation of the
PASSIVE type. Just get its cur state and set the next state based on the cu=
rr.
How that would be different than what you are currently doing?

If you want to have a 1 to 1 relation between cooling device instance and c=
ooling
device state, then you could do the jumps I mentioned, but only if you would
have the cooling state reference stored somewhere.

What bugs me is the fact that you have to be iterating in the cooling devic=
e list to determine
the next cooling state.

> >
> >>
> >> Thanks,
> >> Amit D
> >>
> >> >
> >> > Thanks,
> >> > Durga
> >> >
> >> >> +
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev =3D =
instance->cdev;
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev->ops=
->get_max_state(cdev, &max_state);
> >> >> +
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((temp=
 >=3D trip_temp) &&
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (inst_id <=3D max_state))
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 cdev->ops->set_cur_state(cdev, inst_id);
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (=
(temp < trip_temp) &&
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (--inst_id <=3D max_state))
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 cdev->ops->set_cur_state(cdev, inst_id);
> >> >> +
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_trip=
_change =3D trip_temp;
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case THERMAL_TRIP_PASSIVE:
> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (temp >=3D trip_temp=
 || tz->passive)
> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thermal=
_zone_device_passive(tz, temp,
> >> >> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> >> >> index 796f1ff..8df901f 100644
> >> >> --- a/include/linux/thermal.h
> >> >> +++ b/include/linux/thermal.h
> >> >> @@ -42,6 +42,7 @@ enum thermal_trip_type {
> >> >> =A0 =A0 =A0 THERMAL_TRIP_PASSIVE,
> >> >> =A0 =A0 =A0 THERMAL_TRIP_HOT,
> >> >> =A0 =A0 =A0 THERMAL_TRIP_CRITICAL,
> >> >> + =A0 =A0 THERMAL_TRIP_STATE_ACTIVE,
> >> >> =A0};
> >> >>
> >> >> =A0struct thermal_zone_device_ops {
> >> >> --
> >> >> 1.7.1
> >> >
> >> _______________________________________________
> >> linux-pm mailing list
> >> linux-pm@lists.linux-foundation.org
> >> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
