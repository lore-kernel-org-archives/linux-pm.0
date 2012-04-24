From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [PATCH V2 0/6] thermal: exynos: Add kernel thermal support for
 exynos platform
Date: Tue, 24 Apr 2012 18:54:07 +0530
Message-ID: <CAK44p22u9Qgo9XLrTQL28xOrKAFCACsZ-6Nj9FqVM+=ZCKyWyg@mail.gmail.com>
References: <1332137864-12943-1-git-send-email-amit.kachhap@linaro.org>
	<CAK44p23jiXn6mn-VsdXr3h9J5FfKztXMiqu=XjaF6nqLnRQAmA@mail.gmail.com>
	<1334019502.2387.211.camel@rui.sh.intel.com>
	<CAK44p20Bw9QACRqJc_s4Ri8E46OKOD9O_XpC2Gtd6avSy50dJQ@mail.gmail.com>
	<1334542022.2387.325.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1334542022.2387.325.camel@rui.sh.intel.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: lenb@kernel.org, linux-pm@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linaro-dev@lists.linaro.org, lm-sensors@lm-sensors.org, patches@linaro.org, eduardo.valentin@ti.com, durgadoss.r@intel.com
List-Id: linux-pm@vger.kernel.org

On 16 April 2012 07:37, Zhang Rui <rui.zhang@intel.com> wrote:
> On =E4=B8=89, 2012-04-11 at 18:17 +0530, Amit Kachhap wrote:
>> Hi Rui,
>>
>> Thanks for looking into the patches.
>>
>> On 10 April 2012 06:28, Zhang Rui <rui.zhang@intel.com> wrote:
>> > Hi, Amit,
>> >
>> > On =E4=B8=89, 2012-04-04 at 10:02 +0530, Amit Kachhap wrote:
>> >> Hi Len/Rui,
>> >>
>> >> Any comment or feedback from your side about the status of this p=
atch?
>> >> Is it merge-able or major re-work is needed? I have fixed most of=
 the
>> >> comments in this patchset and currently working on some of the mi=
nor
>> >> comments received and will submit them shortly.
>> >>
>> > Sorry for the late response.
>> >
>> > First of all, it makes sense to me to introduce the generic cpufrq
>> > cooling implementation.
>> ok thanks
>> > But I still have some questions.
>> > I think the key reason why THERMAL_TRIP_STATE_INSTANCE is introduc=
ed is
>> > that the MONIROR_ZONE and WARN_ZONE on exynos4 can not fit into th=
e
>> > current passive handling in the generic thermal layer well, right?
>> > e.g. there is no tc1/tc2 on exynos4.
>> >
>> > If yes, is it possible that we can enhance the passive cooling to
>> > support the generic processor cooling?
>> > say, introduce another way to throttle the processor in
>> > thermal_zone_device_passive when tc1 and tc2 are not available?
>>
>> I agree that this new trip type code can be moved into passive trip
>> type when tc1 and tc2 are 0. but this is special type of cooling
>> devices behaviour where only instances of the same cooling device is
>> binded to a trip point. The order of mapping is the only
>> differentiating criteria and there are some checks used to implement
>> this like
>> 1) The trip points should be in ascending order.(This is missing in =
my
>> original patch, so I added below)
>> 2) The set_cur_state has to be called for the exact temp range so
>> get_cur_state(&state) and set_cur_state(state ++/state--) logic is n=
ot
>> possible.
>> 3) set_cur_state is called as set_cur_state(cdev_instance).
>
> Do you really need two THERMAL_TRIP_STATE_INSTANCE trip points?
Sorry for late reply as I was off for vacation.
Yes we need 2 trip points of type THERMAL_TRIP_STATE_INSTANCE as we
need different cooling for these 2 zones. Anyways Do you feel that
these whole/partial patch series(cpufreq cooling api's, new trip  type
etc) is ack-able or some modification is needed?
>
> I'm not sure if my understanding is right, but IMO, we can have one
> THERMAL_TRIP_STATE_INSTANCE only, for both MONIROR_ZONE and WARN_ZONE=
,
> and the trip temperature equals MONIROR_ZONE.
> The cpufreq cooling device will work in the same way, no?
>
> thanks,
> rui
>
>> There is a chance that people might confuse that these checks are
>> applicable for passive trip types also which is not the case here.
>>
>> @@ -1187,6 +1228,21 @@ struct thermal_zone_device
>> *thermal_zone_device_register(char *type,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tz->ops->get=
_trip_type(tz, count, &trip_type);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (trip_typ=
e =3D=3D THERMAL_TRIP_PASSIVE)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 passive =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* For THERM=
AL_TRIP_STATE_INSTANCE trips, thermal zone should
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* be in asc=
ending order.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (trip_type =3D=
=3D THERMAL_TRIP_STATE_INSTANCE) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tz->ops->get_trip_temp(tz, count, &trip_temp);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (first_trip_temp =3D=3D 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 first_trip_temp =3D trip_temp;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else if (first_trip_temp < trip_temp)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 first_trip_temp =3D trip_temp;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else if (first_trip_temp > trip_temp) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warn("Zone trip points should=
 be in
>> ascending order\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unregister;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!passive)
>>
>> Anyway there is other alternative where this new trip type is not
>> needed and I can just use the existing trip type THERMAL_TRIP_ACTIVE
>> and create 2 separate cooling devices for MONITOR_ZONE and WARN_ZONE=
=2E
>> I had thought to make this generic and just to manage with 1 cooling
>> device.
>> What is your view?
>>
>> Thanks,
>> Amit Daniel
>>
>>
>> >
>> > thanks,
>> > rui
>> >
>> >> Regards,
>> >> Amit Daniel
>> >>
>> >> On 19 March 2012 11:47, Amit Daniel Kachhap <amit.kachhap@linaro.=
org> wrote:
>> >> > Changes since V1:
>> >> > *Moved the sensor driver to driver/thermal folder from driver/h=
wmon folder
>> >> > =C2=A0as suggested by Mark Brown and Guenter Roeck
>> >> > *Added notifier support to notify the registered drivers of any=
 cpu cooling
>> >> > =C2=A0action. The driver can modify the default cooling behavio=
ur(eg set different
>> >> > =C2=A0max clip frequency).
>> >> > *The percentage based frequency replaced with absolute clipped =
frequency.
>> >> > *Some more conditional checks when setting max frequency.
>> >> > *Renamed the new trip type THERMAL_TRIP_STATE_ACTIVE to
>> >> > =C2=A0THERMAL_TRIP_STATE_INSTANCE
>> >> > *Many review comments from R, Durgadoss <durgadoss.r@intel.com>=
 and
>> >> > =C2=A0eduardo.valentin@ti.com implemented.
>> >> > *Removed cooling stats through debugfs patch
>> >> > *The V1 based can be found here,
>> >> > =C2=A0https://lkml.org/lkml/2012/2/22/123
>> >> > =C2=A0http://lkml.org/lkml/2012/3/3/32
>> >> >
>> >> > Changes since RFC:
>> >> > *Changed the cpu cooling registration/unregistration API's to i=
nstance based
>> >> > *Changed the STATE_ACTIVE trip type to pass correct instance id
>> >> > *Adding support to restore back the policy->max_freq after doin=
g frequency
>> >> > =C2=A0clipping.
>> >> > *Moved the trip cooling stats from sysfs node to debugfs node a=
s suggested
>> >> > =C2=A0by Greg KH greg@kroah.com
>> >> > *Incorporated several review comments from eduardo.valentin@ti.=
com
>> >> > *Moved the Temperature sensor driver from driver/hwmon/ to driv=
er/mfd
>> >> > =C2=A0as discussed with Guenter Roeck <guenter.roeck@ericsson.c=
om> and
>> >> > =C2=A0Donggeun Kim <dg77.kim@samsung.com> (https://lkml.org/lkm=
l/2012/1/5/7)
>> >> > *Some changes according to the changes in common cpu cooling AP=
Is
>> >> > *The RFC based patches can be found here,
>> >> > =C2=A0https://lkml.org/lkml/2011/12/13/186
>> >> > =C2=A0https://lkml.org/lkml/2011/12/21/169
>> >> >
>> >> >
>> >> > Brief Description:
>> >> >
>> >> > 1) The generic cooling devices code is placed inside driver/the=
rmal/* as
>> >> > placing inside acpi folder will need un-necessary enabling of a=
cpi code. This
>> >> > codes is architecture independent.
>> >> >
>> >> > 2) This patchset adds a new trip type THERMAL_TRIP_STATE_INSTAN=
CE which passes
>> >> > cooling device instance number and may be helpful for cpufreq c=
ooling devices
>> >> > to take the correct cooling action. This trip type avoids the t=
emperature
>> >> > comparision check again inside the cooling handler.
>> >> >
>> >> > 3) This patchset adds generic cpu cooling low level implementat=
ion through
>> >> > frequency clipping and cpu hotplug. In future, other cpu relate=
d cooling
>> >> > devices may be added here. An ACPI version of this already exis=
ts
>> >> > (drivers/acpi/processor_thermal.c). But this will be useful for=
 platforms
>> >> > like ARM using the generic thermal interface along with the gen=
eric cpu
>> >> > cooling devices. The cooling device registration API's return c=
ooling device
>> >> > pointers which can be easily binded with the thermal zone trip =
points.
>> >> > The important APIs exposed are,
>> >> > =C2=A0 a)struct thermal_cooling_device *cpufreq_cooling_registe=
r(
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct freq_clip_table *tab_ptr, uns=
igned int tab_size,
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct cpumask *mask_val)
>> >> > =C2=A0 b)void cpufreq_cooling_unregister(struct thermal_cooling=
_device *cdev)
>> >> >
>> >> > 4) Samsung exynos platform thermal implementation is done using=
 the generic
>> >> > cpu cooling APIs and the new trip type. The temperature sensor =
driver present
>> >> > in the hwmon folder(registered as hwmon driver) is moved to the=
rmal folder
>> >> > and registered as a thermal driver.
>> >> >
>> >> > All this patchset is based on Kernel version 3.3-rc7
>> >> >
>> >> > A simple data/control flow diagrams is shown below,
>> >> >
>> >> > Core Linux thermal <-----> =C2=A0Exynos thermal interface <----=
- Temperature Sensor
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|
>> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 \|/ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
>> >> > =C2=A0Cpufreq cooling device <---------------
>> >> >
>> >> >
>> >> > Amit Daniel Kachhap (6):
>> >> > =C2=A0thermal: Add a new trip type to use cooling device instan=
ce number
>> >> > =C2=A0thermal: Add generic cpufreq cooling implementation
>> >> > =C2=A0thermal: Add generic cpuhotplug cooling implementation
>> >> > =C2=A0hwmon: exynos4: Move thermal sensor driver to driver/ther=
mal
>> >> > =C2=A0 =C2=A0directory
>> >> > =C2=A0thermal: exynos4: Register the tmu sensor with the kernel=
 thermal
>> >> > =C2=A0 =C2=A0layer
>> >> > =C2=A0ARM: exynos4: Add thermal sensor driver platform device s=
upport
>> >> >
>> >> > =C2=A0Documentation/hwmon/exynos4_tmu =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 81 ---
>> >> > =C2=A0Documentation/thermal/cpu-cooling-api.txt | =C2=A0 76 +++
>> >> > =C2=A0Documentation/thermal/exynos4_tmu =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 52 ++
>> >> > =C2=A0Documentation/thermal/sysfs-api.txt =C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A04 +-
>> >> > =C2=A0arch/arm/mach-exynos/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 11 +
>> >> > =C2=A0arch/arm/mach-exynos/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
>> >> > =C2=A0arch/arm/mach-exynos/clock.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04 +
>> >> > =C2=A0arch/arm/mach-exynos/dev-tmu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 39 ++
>> >> > =C2=A0arch/arm/mach-exynos/include/mach/irqs.h =C2=A0| =C2=A0 =C2=
=A02 +
>> >> > =C2=A0arch/arm/mach-exynos/include/mach/map.h =C2=A0 | =C2=A0 =C2=
=A01 +
>> >> > =C2=A0arch/arm/mach-exynos/mach-origen.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A01 +
>> >> > =C2=A0arch/arm/plat-samsung/include/plat/devs.h | =C2=A0 =C2=A0=
1 +
>> >> > =C2=A0drivers/hwmon/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 10 -
>> >> > =C2=A0drivers/hwmon/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 -
>> >> > =C2=A0drivers/hwmon/exynos4_tmu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0514 -------------------
>> >> > =C2=A0drivers/thermal/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 21 +
>> >> > =C2=A0drivers/thermal/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +
>> >> > =C2=A0drivers/thermal/cpu_cooling.c =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0529 +++++++++++++++++++
>> >> > =C2=A0drivers/thermal/exynos4_thermal.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0790 +++++++++++++++++++++++++++++
>> >> > =C2=A0drivers/thermal/thermal_sys.c =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 45 ++-
>> >> > =C2=A0include/linux/cpu_cooling.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 78 +++
>> >> > =C2=A0include/linux/platform_data/exynos4_tmu.h | =C2=A0 =C2=A0=
7 +
>> >> > =C2=A0include/linux/thermal.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
>> >> > =C2=A023 files changed, 1660 insertions(+), 611 deletions(-)
>> >> > =C2=A0delete mode 100644 Documentation/hwmon/exynos4_tmu
>> >> > =C2=A0create mode 100644 Documentation/thermal/cpu-cooling-api.=
txt
>> >> > =C2=A0create mode 100644 Documentation/thermal/exynos4_tmu
>> >> > =C2=A0create mode 100644 arch/arm/mach-exynos/dev-tmu.c
>> >> > =C2=A0delete mode 100644 drivers/hwmon/exynos4_tmu.c
>> >> > =C2=A0create mode 100644 drivers/thermal/cpu_cooling.c
>> >> > =C2=A0create mode 100644 drivers/thermal/exynos4_thermal.c
>> >> > =C2=A0create mode 100644 include/linux/cpu_cooling.h
>> >> >
>> >
>> >
>
>
