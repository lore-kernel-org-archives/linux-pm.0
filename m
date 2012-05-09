From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [PATCH v3 0/6] thermal: exynos: Add kernel thermal support for
 exynos platform
Date: Wed, 9 May 2012 18:14:51 +0530
Message-ID: <CAK44p23=Xo2NC_XyCDxEDicQc0SuMm9DHCrpUXfU4pi_1i68Pg@mail.gmail.com>
References: <1336493898-7039-1-git-send-email-amit.kachhap@linaro.org>
	<744357E9AAD1214791ACBA4B0B90926310025F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <744357E9AAD1214791ACBA4B0B90926310025F@SHSMSX101.ccr.corp.intel.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "R, Durgadoss" <durgadoss.r@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 9 May 2012 01:36, Zhang, Rui <rui.zhang@intel.com> wrote:
> Hi, Amit,
>
> Sorry for the late response as I'm in a travel recently.
>
> I think the generic cpufreq cooling patches are good.
>
> But about the THERMAL_TRIP_STATE_INSTANCE patch, what I'd like to see=
 is that
> 1. from thermal zone point of view, when the temperature is higher th=
an a trip point, either ACTIVE or PASSIVE, what we should do is to set =
device cooling state to cur_state+1, right?
> =A0The only difference is that if we should take passive cooling acti=
ons or active cooling actions based on the policy.
> =A0So my question would be if it is possible to combine these two kin=
d of trip points together. Maybe something like this:
>
> =A0In thermal_zone_device_update(),
>
> =A0...
> =A0case THERMAL_TRIP_PASSIVE:
> =A0 =A0 =A0if (passive cooling not allowed)
> =A0 =A0 =A0 =A0 =A0 continue;
> =A0 =A0 =A0if (tc1)
> =A0 =A0 =A0 =A0 =A0 thermal_zone_device_passive();
> =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 thermal_set_cooling_state();
> =A0 =A0 =A0break;
> =A0case THERMAL_TRIP_ACTIVE:
> =A0 =A0 if (active cooling not allowed)
> =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 thermal_set_cooling_state();
> =A0 =A0 break;
> =A0...
>
> and thermal_set_cooling_state() {
> =A0 list_for_each_entry(instance, &tz->cooling_devices, node) {
> =A0 =A0 =A0if (instance->trip !=3D count)
> =A0 =A0 =A0 =A0 continue;
>
> =A0 =A0 =A0cdev =3D instance->cdev;
>
> =A0 =A0 =A0if (temp >=3D trip_temp)
> =A0 =A0 =A0 =A0 =A0cdev->ops->set_cur_state(cdev, 1);
> =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0cdev->ops->set_cur_state(cdev, 0);
> =A0 }
> }
>
> 2. use only one cooling_device instance for a thermal_zone, and intro=
duce cdev->trips which shows the trip points this cooling device is bin=
d to.
> =A0And we may use multiple cooling devices states for one active trip=
 point.
>
> Then, thermal_set_cooling_state() would be look like
>
> list_for_each_entry(instance, &tz->cooling_devices, node) {
> =A0 cdev =3D instance->cdev;
> =A0 /* check whether this cooling device is bind to the trip point */
> =A0 if (!(cdev->trips & 1<<count))
> =A0 =A0 =A0continue;
> =A0 cdev->ops->get_max_state(cdev, &max_state);
> =A0 cdev->ops->get_cur_state(cdev, &cur_state);
>
> =A0 if (temp >=3D trip_temp) {
> =A0 =A0 =A0if (cur_state++ <=3D max_state))
> =A0 =A0 =A0 =A0cdev->ops->set_cur_state(cdev, cur_state);
> =A0 } else if ((temp < trip_temp) && (cur_state-- >=3D 0))
> =A0 =A0 =A0cdev->ops->set_cur_state(cdev, cur_state);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> }

Hi Rui,

The above implementation  also cools instance based cooling devices
like passive trip type. I need some changes on top of your
implementation such as,
thermal_set_cooling_state() {
    list_for_each_entry(instance, &tz->cooling_devices,
                                     node) {
        cdev =3D instance->cdev;
        if (!cdev->trips & 1<<count)
                  continue;

        inst_id =3D 0;
        for_each_bit_set(i, cdev->trips, count)
                   inst_id++;
         cdev->ops->get_max_state(cdev, &max_state);
         if ((temp >=3D trip_temp) && (inst_id <=3D max_state))
              cdev->ops->set_cur_state(cdev, inst_id);
         else if ((temp < trip_temp) && (--inst_id >=3D 0))
               cdev->ops->set_cur_state(cdev, inst_id);
     }
}

I agree with you that the instance based trip types violates the
concept like reading the cur_state and do cur_state++/cur_state--
depending upon threshold increase or decrease because it needs the
state_id/inst_id.
I am actually thinking of dropping this new trip type and use the
existing THERMAL_TRIP_ACTIVE because there is so much logic in
calculating the state_id. The only flip side of using TRIP_ACTIVE is
that I need to create so many cooling devices.

Thanks,
Amit D
>
> With these two things, I think the WARN_ZONE AND MONITOR_ZONE can be =
registered as two PASSIVE trip points in the generic thermal layer, rig=
ht?
> Actually, this is one thing in my TODO list. And I'd glad to make it =
high priority if this solves the problem you have.
>
> Thanks,
> rui
>
> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.=
kernel.org] On Behalf Of Amit Daniel Kachhap
> Sent: Tuesday, May 08, 2012 9:18 AM
> To: akpm@linux-foundation.org; linux-pm@lists.linux-foundation.org
> Cc: R, Durgadoss; linux-acpi@vger.kernel.org; lenb@kernel.org; Zhang,=
 Rui; amit.kachhap@linaro.org; linaro-dev@lists.linaro.org; linux-kerne=
l@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-samsung-=
soc@vger.kernel.org; patches@linaro.org
> Subject: [PATCH v3 0/6] thermal: exynos: Add kernel thermal support f=
or exynos platform
> Importance: High
>
> Hi Andrew,
>
> This patchset introduces a new generic cooling device based on cpufre=
q that can be used on non-ACPI platforms. As a proof of concept, we hav=
e drivers for the following platforms using this mechanism now:
>
> =A0* TI OMAP (git://git.linaro.org/people/amitdanielk/linux.git omap4=
460_thermal)
> =A0* Samsung Exynos (Exynos4 and Exynos5) in the current patchset.
> =A0* Freescale i.MX (git://git.linaro.org/people/amitdanielk/linux.gi=
t imx6q_thermal)
>
> These patches have been reviewed by Rui Zhang (https://lkml.org/lkml/=
2012/4/9/448)
> who seems to agree with them in principle, but I haven't had any luck=
 getting them merged, perhaps a lack of maintainer bandwidth.
>
> ACPI platforms currently have such a mechanism but it is wrapped in A=
CPI'isms that we don't have on ARM platforms. If this is accepted, I'm =
proposing to convert over the ACPI thermal driver to use this common co=
de too.
>
> Can you please merge these patches for 3.5?
>
> Thanks,
> Amit Daniel
>
>
> Changes since V2:
> *Added Exynos5 TMU sensor support by enhancing the exynos4 tmu driver=
=2E Exynos5 TMU =A0driver was internally developed by SangWook Ju <sw.j=
u@samsung.com>.
> *Removed cpuhotplug cooling code in this patchset.
> *Rebased the patches against 3.4-rc6 kernel.
>
> Changes since V1:
> *Moved the sensor driver to driver/thermal folder from driver/hwmon f=
older =A0as suggested by Mark Brown and Guenter Roeck *Added notifier s=
upport to notify the registered drivers of any cpu cooling =A0action. T=
he driver can modify the default cooling behaviour(eg set different =A0=
max clip frequency).
> *The percentage based frequency replaced with absolute clipped freque=
ncy.
> *Some more conditional checks when setting max frequency.
> *Renamed the new trip type THERMAL_TRIP_STATE_ACTIVE to =A0THERMAL_TR=
IP_STATE_INSTANCE *Many review comments from R, Durgadoss <durgadoss.r@=
intel.com> and =A0eduardo.valentin@ti.com implemented.
> *Removed cooling stats through debugfs patch *The V1 based can be fou=
nd here,
> =A0https://lkml.org/lkml/2012/2/22/123
> =A0http://lkml.org/lkml/2012/3/3/32
>
> Changes since RFC:
> *Changed the cpu cooling registration/unregistration API's to instanc=
e based *Changed the STATE_ACTIVE trip type to pass correct instance id=
 *Adding support to restore back the policy->max_freq after doing frequ=
ency
> =A0clipping.
> *Moved the trip cooling stats from sysfs node to debugfs node as sugg=
ested
> =A0by Greg KH greg@kroah.com
> *Incorporated several review comments from eduardo.valentin@ti.com *M=
oved the Temperature sensor driver from driver/hwmon/ to driver/mfd =A0=
as discussed with Guenter Roeck <guenter.roeck@ericsson.com> and =A0Don=
ggeun Kim <dg77.kim@samsung.com> (https://lkml.org/lkml/2012/1/5/7)
> *Some changes according to the changes in common cpu cooling APIs *Th=
e RFC based patches can be found here,
> =A0https://lkml.org/lkml/2011/12/13/186
> =A0https://lkml.org/lkml/2011/12/21/169
>
>
> Brief Description:
>
> 1) The generic cooling devices code is placed inside driver/thermal/*=
 as placing inside acpi folder will need un-necessary enabling of acpi =
code. This codes is architecture independent.
>
> 2) This patchset adds a new trip type THERMAL_TRIP_STATE_INSTANCE whi=
ch passes cooling device instance number and may be helpful for cpufreq=
 cooling devices to take the correct cooling action. This trip type avo=
ids the temperature comparision check again inside the cooling handler.
>
> 3) This patchset adds generic cpu cooling low level implementation th=
rough frequency clipping and cpu hotplug. In future, other cpu related =
cooling devices may be added here. An ACPI version of this already exis=
ts (drivers/acpi/processor_thermal.c). But this will be useful for plat=
forms like ARM using the generic thermal interface along with the gener=
ic cpu cooling devices. The cooling device registration API's return co=
oling device pointers which can be easily binded with the thermal zone =
trip points.
> The important APIs exposed are,
> =A0 a)struct thermal_cooling_device *cpufreq_cooling_register(
> =A0 =A0 =A0 =A0struct freq_clip_table *tab_ptr, unsigned int tab_size=
,
> =A0 =A0 =A0 =A0const struct cpumask *mask_val)
> =A0 b)void cpufreq_cooling_unregister(struct thermal_cooling_device *=
cdev)
>
> 4) Samsung exynos platform thermal implementation is done using the g=
eneric cpu cooling APIs and the new trip type. The temperature sensor d=
river present in the hwmon folder(registered as hwmon driver) is moved =
to thermal folder and registered as a thermal driver.
>
> All this patchset is based on Kernel version 3.4-rc6
>
> A simple data/control flow diagrams is shown below,
>
> Core Linux thermal <-----> =A0Exynos thermal interface <----- Tempera=
ture Sensor
> =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 |
> =A0 =A0 =A0 =A0 \|/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0|
> =A0Cpufreq cooling device <---------------
>
> TODO:
> *Will send the DT enablement patches later after the driver is merged=
=2E
>
>
> Amit Daniel Kachhap (6):
> =A0thermal: Add a new trip type to use cooling device instance number
> =A0thermal: Add generic cpufreq cooling implementation
> =A0hwmon: exynos4: Move thermal sensor driver to driver/thermal
> =A0 =A0directory
> =A0thermal: exynos5: Add exynos5 thermal sensor driver support
> =A0thermal: exynos: Register the tmu sensor with the kernel thermal
> =A0 =A0layer
> =A0ARM: exynos: Add thermal sensor driver platform data support
>
> =A0Documentation/hwmon/exynos4_tmu =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 8=
1 ---
> =A0Documentation/thermal/cpu-cooling-api.txt =A0 =A0| =A0 60 ++
> =A0Documentation/thermal/exynos_thermal =A0 =A0 =A0 =A0 | =A0 52 ++
> =A0Documentation/thermal/sysfs-api.txt =A0 =A0 =A0 =A0 =A0| =A0 =A04 =
+-
> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 10 -
> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A01 -
> =A0drivers/hwmon/exynos4_tmu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
514 --------------
> =A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 20 +
> =A0drivers/thermal/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A04 +-
> =A0drivers/thermal/cpu_cooling.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
359 ++++++++++
> =A0drivers/thermal/exynos_thermal.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0933 =
++++++++++++++++++++++++++
> =A0drivers/thermal/thermal_sys.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 62 ++-
> =A0include/linux/cpu_cooling.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 62 ++
> =A0include/linux/platform_data/exynos4_tmu.h =A0 =A0| =A0 83 ---
> =A0include/linux/platform_data/exynos_thermal.h | =A0100 +++
> =A0include/linux/thermal.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 +
> =A016 files changed, 1651 insertions(+), 695 deletions(-) =A0delete m=
ode 100644 Documentation/hwmon/exynos4_tmu =A0create mode 100644 Docume=
ntation/thermal/cpu-cooling-api.txt
> =A0create mode 100644 Documentation/thermal/exynos_thermal
> =A0delete mode 100644 drivers/hwmon/exynos4_tmu.c =A0create mode 1006=
44 drivers/thermal/cpu_cooling.c =A0create mode 100644 drivers/thermal/=
exynos_thermal.c =A0create mode 100644 include/linux/cpu_cooling.h =A0d=
elete mode 100644 include/linux/platform_data/exynos4_tmu.h
> =A0create mode 100644 include/linux/platform_data/exynos_thermal.h
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at =A0http://vger.kernel.org/majordomo-info.html
