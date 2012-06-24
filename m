From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 11/12] thermal: introduce cooling state
	arbitrator
Date: Sun, 24 Jun 2012 18:19:44 +0300
Message-ID: <CAGF5oy-ncSVLj55xCHV_WO3R8HkOZ6OPfaNkL09XKGq8z0Wv7A@mail.gmail.com>
References: <1339384839.1492.165.camel@rui.sh.intel.com>
	<20120613142316.GB16714@besouro>
	<1340174859.1682.21.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1340174859.1682.21.camel@rui.sh.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

On Wed, Jun 20, 2012 at 9:47 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> On =E4=B8=89, 2012-06-13 at 17:23 +0300, Eduardo Valentin wrote:
>> Hello Rui,
>>
>> On Mon, Jun 11, 2012 at 11:20:39AM +0800, Zhang Rui wrote:
>> >
>> > Introduce simple arbitrator for setting device cooling state,
>> > to fix the problem that a cooling device may be referenced by
>> > by multiple trip points in multiple thermal zones.
>> >
>> >
>> > With this patch, we have two stages for updating a thermal zone,
>> > 1. check if a thermal_instance needs to be updated or not
>> > 2. update the cooling device, based on the target cooling state
>> > =C2=A0 =C2=A0of all its instances.
>> >
>> > Note that, currently, the cooling device is set to the deepest
>> > cooling state required.
>> >
>> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>> > ---
>> > =C2=A0drivers/thermal/thermal_sys.c | =C2=A0 41 ++++++++++++++++++++++=
++++++++++++++++---
>> > =C2=A0include/linux/thermal.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
>> > =C2=A02 files changed, 39 insertions(+), 3 deletions(-)
>> >
>> > Index: rtd3/drivers/thermal/thermal_sys.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- rtd3.orig/drivers/thermal/thermal_sys.c
>> > +++ rtd3/drivers/thermal/thermal_sys.c
>> > @@ -54,6 +54,7 @@ struct thermal_instance {
>> > =C2=A0 =C2=A0 int trip;
>> > =C2=A0 =C2=A0 unsigned long upper; =C2=A0 =C2=A0/* Highest cooling sta=
te for this trip point */
>> > =C2=A0 =C2=A0 unsigned long lower; =C2=A0 =C2=A0/* Lowest cooling stat=
e for this trip point */
>> > + =C2=A0 unsigned long target; =C2=A0 /* expected cooling state */
>> > =C2=A0 =C2=A0 char attr_name[THERMAL_NAME_LENGTH];
>> > =C2=A0 =C2=A0 struct device_attribute attr;
>> > =C2=A0 =C2=A0 struct list_head tz_node; /* node in tz->instances */
>> > @@ -812,6 +813,7 @@ int thermal_zone_bind_cooling_device(str
>> > =C2=A0 =C2=A0 dev->trip =3D trip;
>> > =C2=A0 =C2=A0 dev->upper =3D upper;
>> > =C2=A0 =C2=A0 dev->lower =3D lower;
>> > + =C2=A0 dev->target =3D -1;
>> >
>> > =C2=A0 =C2=A0 result =3D get_idr(&tz->idr, &tz->lock, &dev->id);
>> > =C2=A0 =C2=A0 if (result)
>> > @@ -949,6 +951,7 @@ thermal_cooling_device_register(char *ty
>> > =C2=A0 =C2=A0 strcpy(cdev->type, type);
>> > =C2=A0 =C2=A0 INIT_LIST_HEAD(&cdev->instances);
>> > =C2=A0 =C2=A0 cdev->ops =3D ops;
>> > + =C2=A0 cdev->updated =3D 1;
>> > =C2=A0 =C2=A0 cdev->device.class =3D &thermal_class;
>> > =C2=A0 =C2=A0 cdev->devdata =3D devdata;
>> > =C2=A0 =C2=A0 dev_set_name(&cdev->device, "cooling_device%d", cdev->id=
);
>> > @@ -1040,6 +1043,32 @@ void thermal_cooling_device_unregister(s
>> > =C2=A0}
>> > =C2=A0EXPORT_SYMBOL(thermal_cooling_device_unregister);
>> >
>> > +static void thermal_zone_do_update(struct thermal_zone_device *tz)
>> > +{
>> > + =C2=A0 struct thermal_instance *instance1, *instance2;
>> > + =C2=A0 struct thermal_cooling_device *cdev;
>> > + =C2=A0 int target;
>> > +
>> > + =C2=A0 list_for_each_entry(instance1, &tz->instances, tz_node) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev =3D instance1->cdev;
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* cooling device has already bee=
n updated*/
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cdev->updated)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 conti=
nue;
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target =3D 0;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Make sure cdev enters the deep=
est cooling state */
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_for_each_entry(instance2, &c=
dev->instances, cdev_node) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i=
nstance2->target =3D=3D -1)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i=
nstance2->target > target)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 target =3D instance2->target;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev->ops->set_cur_state(cdev, ta=
rget);
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev->updated =3D 1;
>> > + =C2=A0 }
>> > +}
>>
>> I think the above arbitrator solution does not escalate. As I can see,
>> the arbitrator takes care of cooling device instances in the same therma=
l zone.
>>
> why?
> It parses the thermal instances in one thermal zone to find the cooling
> devices, and then parse all the thermal instances for the cooling
> devices, no matter which thermal zone it belongs to.

I think I got confused with the nomenclature change. So, yes, it does
go through all zones and cooling devices. But still, ideally it should
be a plist per device, don't you think? This way your search space is
reduced.

>
>> What if you have a device which expose cooling device instances in diffe=
rent
>> thermal zones?
>>
>> Besides, the thermal constraint might collide with pm QoS or with settin=
gs
>> coming from user space interfaces.
>>
>
>> That's actually why I was suggesting to have this 'arbitrator' or constr=
aint
>> management outside the thermal framework. And managed per device at some
>> other abstraction layer.
>>
> Yeah, but I think we can have an incremental patch to handle the pm Qos
> constrains. Especially Durga already has the governor patches to move
> this out of the thermal framework.
> what do you think?

I think it sounds like a plan. I also like incremental approach.

>
> thanks,
> rui
>
>> > +
>> > =C2=A0/*
>> > =C2=A0 * Cooling algorithm for active trip points
>> > =C2=A0 *
>> > @@ -1086,19 +1115,24 @@ static void thermal_zone_trip_update(str
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cur_state =3D cur_state > instance->lower ?
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (cur_state - 1) : instance->lower=
;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
}
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev-=
>ops->set_cur_state(cdev, cur_state);
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 insta=
nce->target =3D cur_state;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev-=
>updated =3D 0; /* cooling device needs update */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > =C2=A0 =C2=A0 } else { =C2=A0 =C2=A0 =C2=A0 =C2=A0/* below trip */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_for_each_entry(instance=
, &tz->instances, tz_node) {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
if (instance->trip !=3D trip)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> >
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Do=
 not use the deacitve thermal instance */
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i=
nstance->target =3D=3D -1)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
cdev =3D instance->cdev;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
cdev->ops->get_cur_state(cdev, &cur_state);
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
cur_state =3D cur_state > instance->lower ?
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (cur_state - 1) : instance->lower;
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev-=
>ops->set_cur_state(cdev, cur_state);
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (cur_state - 1) : -1;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 insta=
nce->target =3D cur_state;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cdev-=
>updated =3D 0; /* cooling device needs update */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > =C2=A0 =C2=A0 }
>> >
>> > @@ -1159,6 +1193,7 @@ void thermal_zone_device_update(struct t
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > =C2=A0 =C2=A0 }
>> >
>> > + =C2=A0 thermal_zone_do_update(tz);
>> > =C2=A0 =C2=A0 if (tz->forced_passive)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 thermal_zone_device_passive(=
tz, temp, tz->forced_passive,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 THERM=
AL_TRIPS_NONE);
>> > Index: rtd3/include/linux/thermal.h
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- rtd3.orig/include/linux/thermal.h
>> > +++ rtd3/include/linux/thermal.h
>> > @@ -86,6 +86,7 @@ struct thermal_cooling_device {
>> > =C2=A0 =C2=A0 struct device device;
>> > =C2=A0 =C2=A0 void *devdata;
>> > =C2=A0 =C2=A0 const struct thermal_cooling_device_ops *ops;
>> > + =C2=A0 int updated; /* 1 if the cooling device does not need update =
*/
>> > =C2=A0 =C2=A0 struct list_head instances;
>> > =C2=A0 =C2=A0 struct list_head node;
>> > =C2=A0};
>> >
>> >
>
>



--=20

Eduardo Valentin
