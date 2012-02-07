From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [linux-pm] [RFC PATCH 2/2] thermal: Add generic cpu cooling
 implementation
Date: Tue, 7 Feb 2012 21:34:44 +0200
Message-ID: <20120207193444.GB8589@besouro>
References: <1323789196-4942-1-git-send-email-amit.kachhap@linaro.org>
 <1323789196-4942-3-git-send-email-amit.kachhap@linaro.org>
 <20120207082559.GA5558@besouro>
 <CAK44p20Y5bLU-cUEvZqvzt300ZhtJ8z5KbRfLc8b2B=d3G=FsA@mail.gmail.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK44p20Y5bLU-cUEvZqvzt300ZhtJ8z5KbRfLc8b2B=d3G=FsA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Amit Kachhap <amit.kachhap@linaro.org>
Cc: eduardo.valentin@ti.com, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Amit,

On Tue, Feb 07, 2012 at 10:21:15AM -0800, Amit Kachhap wrote:
> Hi eduardo,
>=20
> Again thanks for the review.
>=20
> On 7 February 2012 00:25, Eduardo Valentin <eduardo.valentin@ti.com> =
wrote:
> > Hello Amit,
> >
> > On Tue, Dec 13, 2011 at 08:43:16PM +0530, Amit Daniel Kachhap wrote=
:
> >> This patch adds support for generic cpu thermal cooling low level
> >> implementations using frequency scaling and cpuhotplugg currently.
> >> Different cpu related cooling devices can be registered by the
> >> user and the binding of these cooling devices to the corresponding
> >> trip points can be easily done as the registration API's return th=
e
> >> cooling device pointer.
> >>
> >> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> >> ---
> >> =A0Documentation/thermal/cpu-cooling-api.txt | =A0 52 +++++
> >> =A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 11 +
> >> =A0drivers/thermal/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 +
> >> =A0drivers/thermal/cpu_cooling.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0302 =
+++++++++++++++++++++++++++++
> >> =A0include/linux/cpu_cooling.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 4=
5 +++++
> >> =A05 files changed, 411 insertions(+), 0 deletions(-)
> >> =A0create mode 100644 Documentation/thermal/cpu-cooling-api.txt
> >> =A0create mode 100644 drivers/thermal/cpu_cooling.c
> >> =A0create mode 100644 include/linux/cpu_cooling.h
> >>
> >> diff --git a/Documentation/thermal/cpu-cooling-api.txt b/Documenta=
tion/thermal/cpu-cooling-api.txt
> >> new file mode 100644
> >> index 0000000..d30b4f2
> >> --- /dev/null
> >> +++ b/Documentation/thermal/cpu-cooling-api.txt
> >> @@ -0,0 +1,52 @@
> >> +CPU cooling api's How To
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +Written by Amit Daniel Kachhap <amit.kachhap@linaro.org>
> >> +
> >> +Updated: 13 Dec 2011
> >> +
> >> +Copyright (c) =A02011 Samsung Electronics Co., Ltd(http://www.sam=
sung.com)
> >> +
> >> +0. Introduction
> >> +
> >> +The generic cpu cooling(freq clipping, cpuhotplug) provides
> >> +registration/unregistration api's to the user. The binding of the=
 cooling
> >> +devices to the trip types is left for the user. The registration =
api's returns
> >> +the cooling device pointer.
> >> +
> >> +1. cpufreq cooling api's
> >> +
> >> +1.1 cpufreq registration api's
> >> +1.1.1 struct thermal_cooling_device *cpufreq_cooling_register(
> >> + =A0 =A0 struct freq_pctg_table *tab_ptr, unsigned int tab_size,
> >> + =A0 =A0 const struct cpumask *mask_val)
> >> +
> >> + =A0 =A0This interface function registers the cpufreq cooling dev=
ice with the name
> >> + =A0 =A0 "thermal-cpufreq".
> >> +
> >> + =A0 =A0tab_ptr: The table containing the percentage of frequency=
 to be clipped for
> >> + =A0 =A0each cooling state.
> >> + =A0 =A0 .freq_clip_pctg[NR_CPUS]:Percentage of frequency to be c=
lipped for each
> >> + =A0 =A0 =A0cpu.
> >> + =A0 =A0 .polling_interval: polling interval for this cooling sta=
te.
> >> + =A0 =A0tab_size: the total number of cooling state.
> >> + =A0 =A0mask_val: all the allowed cpu's where frequency clipping =
can happen.
> >> +
> >> +1.1.2 void cpufreq_cooling_unregister(void)
> >> +
> >> + =A0 =A0This interface function unregisters the "thermal-cpufreq"=
 cooling device.
> >> +
> >> +
> >> +1.2 cpuhotplug registration api's
> >> +
> >> +1.2.1 struct thermal_cooling_device *cpuhotplug_cooling_register(
> >> + =A0 =A0 const struct cpumask *mask_val)
> >> +
> >> + =A0 =A0This interface function registers the cpuhotplug cooling =
device with the name
> >> + =A0 =A0 "thermal-cpuhotplug".
> >> +
> >> + =A0 =A0mask_val: all the allowed cpu's which can be hotplugged o=
ut.
> >> +
> >> +1.1.2 void cpuhotplug_cooling_unregister(void)
> >> +
> >> + =A0 =A0This interface function unregisters the "thermal-cpuhotpl=
ug" cooling device.
> >> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> >> index f7f71b2..298c1cd 100644
> >> --- a/drivers/thermal/Kconfig
> >> +++ b/drivers/thermal/Kconfig
> >> @@ -18,3 +18,14 @@ config THERMAL_HWMON
> >> =A0 =A0 =A0 depends on THERMAL
> >> =A0 =A0 =A0 depends on HWMON=3Dy || HWMON=3DTHERMAL
> >> =A0 =A0 =A0 default y
> >> +
> >> +config CPU_THERMAL
> >> + =A0 =A0 bool "generic cpu cooling support"
> >> + =A0 =A0 depends on THERMAL
> >> + =A0 =A0 help
> >> + =A0 =A0 =A0 This implements the generic cpu cooling mechanism th=
rough frequency
> >> + =A0 =A0 =A0 reduction, cpu hotplug and any other ways of reducin=
g temperature. An
> >> + =A0 =A0 =A0 ACPI version of this already exists(drivers/acpi/pro=
cessor_thermal.c).
> >> + =A0 =A0 =A0 This will be useful for platforms using the generic =
thermal interface
> >> + =A0 =A0 =A0 and not the ACPI interface.
> >> + =A0 =A0 =A0 If you want this support, you should say Y or M here=
=2E
> >> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> >> index 31108a0..655cbc4 100644
> >> --- a/drivers/thermal/Makefile
> >> +++ b/drivers/thermal/Makefile
> >> @@ -3,3 +3,4 @@
> >> =A0#
> >>
> >> =A0obj-$(CONFIG_THERMAL) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D therm=
al_sys.o
> >> +obj-$(CONFIG_CPU_THERMAL) =A0 =A0+=3D cpu_cooling.o
> >> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_c=
ooling.c
> >> new file mode 100644
> >> index 0000000..cdd148c
> >> --- /dev/null
> >> +++ b/drivers/thermal/cpu_cooling.c
> >> @@ -0,0 +1,302 @@
> >> +/*
> >> + * =A0linux/drivers/thermal/cpu_cooling.c
> >> + *
> >> + * =A0Copyright (C) 2011 =A0 =A0 =A0 Samsung Electronics Co., Ltd=
(http://www.samsung.com)
> >> + * =A0Copyright (C) 2011 =A0Amit Daniel <amit.kachhap@linaro.org>
> >> + *
> >> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
> >> + * =A0This program is free software; you can redistribute it and/=
or modify
> >> + * =A0it under the terms of the GNU General Public License as pub=
lished by
> >> + * =A0the Free Software Foundation; version 2 of the License.
> >> + *
> >> + * =A0This program is distributed in the hope that it will be use=
ful, but
> >> + * =A0WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See=
 the GNU
> >> + * =A0General Public License for more details.
> >> + *
> >> + * =A0You should have received a copy of the GNU General Public L=
icense along
> >> + * =A0with this program; if not, write to the Free Software Found=
ation, Inc.,
> >> + * =A059 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> >> + *
> >> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
> >> + */
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/thermal.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/cpufreq.h>
> >> +#include <linux/err.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/cpu.h>
> >> +#include <linux/cpu_cooling.h>
> >> +
> >> +#ifdef CONFIG_CPU_FREQ
> >> +struct cpufreq_cooling_device {
> >> + =A0 =A0 struct thermal_cooling_device *cool_dev;
> >> + =A0 =A0 struct freq_pctg_table *tab_ptr;
> >> + =A0 =A0 unsigned int tab_size;
> >> + =A0 =A0 unsigned int cpufreq_state;
> >> + =A0 =A0 const struct cpumask *allowed_cpus;
> >> +};
> >> +
> >> +static struct cpufreq_cooling_device *cpufreq_device;
> >> +
> >> +/*Below codes defines functions to be used for cpufreq as cooling=
 device*/
> >> +static bool is_cpufreq_valid(int cpu)
> >> +{
> >> + =A0 =A0 struct cpufreq_policy policy;
> >> + =A0 =A0 if (!cpufreq_get_policy(&policy, cpu))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return true;
> >> + =A0 =A0 return false;
> >> +}
> >> +
> >> +static int cpufreq_apply_cooling(int cooling_state)
> >> +{
> >
> > Why do you need cooling_state to be signed? You used it always agai=
nst
> > unsigned values. Besides, the thermal api imposes unsigned long.
> Yes, unsigned long is a better way.
> >
> >> + =A0 =A0 int cpuid, this_cpu =3D smp_processor_id();
> >> +
> >> + =A0 =A0 if (!is_cpufreq_valid(this_cpu))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >> +
> >> + =A0 =A0 if (cooling_state > cpufreq_device->tab_size)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> +
> >> + =A0 =A0 /*Check if last cooling level is same as current cooling=
 level*/
> >> + =A0 =A0 if (cpufreq_device->cpufreq_state =3D=3D cooling_state)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >> +
> >> + =A0 =A0 cpufreq_device->cpufreq_state =3D cooling_state;
> >> +
> >> + =A0 =A0 for_each_cpu(cpuid, cpufreq_device->allowed_cpus) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (is_cpufreq_valid(cpuid))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_update_policy(cp=
uid);
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 return 0;
> >> +}
> >> +
> >> +static int thermal_cpufreq_notifier(struct notifier_block *nb,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 unsigned long event, void *data)
> >> +{
> >> + =A0 =A0 struct cpufreq_policy *policy =3D data;
> >> + =A0 =A0 struct freq_pctg_table *th_table;
> >> + =A0 =A0 unsigned long max_freq =3D 0;
> >> + =A0 =A0 unsigned int cpu =3D policy->cpu, th_pctg =3D 0, level;
> >> +
> >> + =A0 =A0 if (event !=3D CPUFREQ_ADJUST)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >> +
> >> + =A0 =A0 level =3D cpufreq_device->cpufreq_state;
> >> +
> >> + =A0 =A0 if (level > 0) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 th_table =3D
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &(cpufreq_device->tab_pt=
r[level - 1]);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 th_pctg =3D th_table->freq_clip_pctg[cpu=
];
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 max_freq =3D
> >> + =A0 =A0 =A0 =A0 =A0 =A0 (policy->cpuinfo.max_freq * (100 - th_pc=
tg)) / 100;
> >
> >
> > Might be interesting to extend this a bit. You could have the
> > above as default policy setup, but you could also allow people
> > to change this behavior. For instance, adding some callback option
> > while registering the cooling device (or a notifier), which would
> > determine the max_freq for the generic layer. The mechanism to
> > deploy max_freq into the system must be generic enough with cpufreq
> > APIs, but the decision to which max_freq to use, could be specific.
> > Don't you think?
> I agree that there will always some constraints on the system to cap
> the max frequency. But these thermal clippings is called for rare
> scenarios. Anyway, Your idea is worth considering. I will check if
> cpufreq has any generic way of achieving this.

Yeah, well, the idea was to have the max_freq value coming from some
registered callback in your code, not really on cpufreq.

> >
> >> +
> >> + =A0 =A0 cpufreq_verify_within_limits(policy, 0, max_freq);
> >> +
> >> + =A0 =A0 return 0;
> >> +}
> >> +
> >> +/*
> >> + * cpufreq cooling device callback functions
> >> + */
> >> +static int cpufreq_get_max_state(struct thermal_cooling_device *c=
dev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsig=
ned long *state)
> >> +{
> >> + =A0 =A0 *state =3D cpufreq_device->tab_size;
> >> + =A0 =A0 return 0;
> >> +}
> >> +
> >> +static int cpufreq_get_cur_state(struct thermal_cooling_device *c=
dev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsig=
ned long *state)
> >> +{
> >> + =A0 =A0 *state =3D cpufreq_device->cpufreq_state;
> >> + =A0 =A0 return 0;
> >> +}
> >> +
> >> +/*This cooling may be as PASSIVE/STATE_ACTIVE type*/
> >> +static int cpufreq_set_cur_state(struct thermal_cooling_device *c=
dev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsig=
ned long state)
> >> +{
> >> + =A0 =A0 cpufreq_apply_cooling(state);
> >> + =A0 =A0 return 0;
> >> +}
> >> +
> >> +/* bind cpufreq callbacks to cpufreq cooling device */
> >> +static struct thermal_cooling_device_ops cpufreq_cooling_ops =3D =
{
> >> + =A0 =A0 .get_max_state =3D cpufreq_get_max_state,
> >> + =A0 =A0 .get_cur_state =3D cpufreq_get_cur_state,
> >> + =A0 =A0 .set_cur_state =3D cpufreq_set_cur_state,
> >> +};
> >> +
> >> +static struct notifier_block thermal_cpufreq_notifier_block =3D {
> >> + =A0 =A0 .notifier_call =3D thermal_cpufreq_notifier,
> >> +};
> >> +
> >> +struct thermal_cooling_device *cpufreq_cooling_register(
> >> + =A0 =A0 struct freq_pctg_table *tab_ptr, unsigned int tab_size,
> >> + =A0 =A0 const struct cpumask *mask_val)
> >> +{
> >> + =A0 =A0 struct thermal_cooling_device *cool_dev;
> >> +
> >> + =A0 =A0 if (tab_ptr =3D=3D NULL || tab_size =3D=3D 0)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
> >> +
> >> + =A0 =A0 cpufreq_device =3D
> >> + =A0 =A0 =A0 =A0 =A0 =A0 kzalloc(sizeof(struct cpufreq_cooling_de=
vice), GFP_KERNEL);
> >> +
> >> + =A0 =A0 if (!cpufreq_device)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);
> >> +
> >> + =A0 =A0 cool_dev =3D thermal_cooling_device_register("thermal-cp=
ufreq", NULL,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 &cpufreq_cooling_ops);
> >> + =A0 =A0 if (!cool_dev) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_device);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 cpufreq_device->tab_ptr =3D tab_ptr;
> >> + =A0 =A0 cpufreq_device->tab_size =3D tab_size;
> >> + =A0 =A0 cpufreq_device->cool_dev =3D cool_dev;
> >> + =A0 =A0 cpufreq_device->allowed_cpus =3D mask_val;
> >> +
> >> + =A0 =A0 cpufreq_register_notifier(&thermal_cpufreq_notifier_bloc=
k,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 CPUFREQ_POLICY_NOTIFIER);
> >> + =A0 =A0 return cool_dev;
> >> +}
> >> +EXPORT_SYMBOL(cpufreq_cooling_register);
> >> +
> >> +void cpufreq_cooling_unregister(void)
> >> +{
> >> + =A0 =A0 cpufreq_unregister_notifier(&thermal_cpufreq_notifier_bl=
ock,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 CPUFREQ_POLICY_NOTIFIER);
> >> + =A0 =A0 thermal_cooling_device_unregister(cpufreq_device->cool_d=
ev);
> >> + =A0 =A0 kfree(cpufreq_device);
> >> +}
> >> +EXPORT_SYMBOL(cpufreq_cooling_unregister);
> >> +#else /*!CONFIG_CPU_FREQ*/
> >> +struct thermal_cooling_device *cpufreq_cooling_register(
> >> + =A0 =A0 struct freq_pctg_table *tab_ptr, unsigned int tab_size)
> >> +{
> >> + =A0 =A0 return NULL;
> >> +}
> >> +EXPORT_SYMBOL(cpufreq_cooling_register);
> >> +void cpufreq_cooling_unregister(void)
> >> +{
> >> + =A0 =A0 return;
> >> +}
> >> +EXPORT_SYMBOL(cpufreq_cooling_unregister);
> >> +#endif /*CONFIG_CPU_FREQ*/
> >> +
> >> +#ifdef CONFIG_HOTPLUG_CPU
> >> +
> >> +struct hotplug_cooling_device {
> >> + =A0 =A0 struct thermal_cooling_device *cool_dev;
> >> + =A0 =A0 unsigned int hotplug_state;
> >> + =A0 =A0 const struct cpumask *allowed_cpus;
> >> +};
> >> +static struct hotplug_cooling_device *hotplug_device;
> >> +
> >> +/*
> >> + * cpu hotplug cooling device callback functions
> >> + */
> >> +static int cpuhotplug_get_max_state(struct thermal_cooling_device=
 *cdev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsig=
ned long *state)
> >> +{
> >> + =A0 =A0 *state =3D 1;
> >> + =A0 =A0 return 0;
> >> +}
> >> +
> >> +static int cpuhotplug_get_cur_state(struct thermal_cooling_device=
 *cdev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsig=
ned long *state)
> >> +{
> >> + =A0 =A0 /*This cooling device may be of type ACTIVE, so state fi=
eld
> >> + =A0 =A0 can be 0 or 1*/
> >> + =A0 =A0 *state =3D hotplug_device->hotplug_state;
> >> + =A0 =A0 return 0;
> >> +}
> >> +
> >> +/*This cooling may be as PASSIVE/STATE_ACTIVE type*/
> >> +static int cpuhotplug_set_cur_state(struct thermal_cooling_device=
 *cdev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsig=
ned long state)
> >> +{
> >> + =A0 =A0 int cpuid, this_cpu =3D smp_processor_id();
> >> +
> >> + =A0 =A0 if (hotplug_device->hotplug_state =3D=3D state)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >> +
> >> + =A0 =A0 /*This cooling device may be of type ACTIVE, so state fi=
eld
> >> + =A0 =A0 can be 0 or 1*/
> >
> > /*
> > =A0* Small thing. Check the style for multi line comments.
> > =A0* This is also an example.
> > =A0*/
> Ok.
> >
> >> + =A0 =A0 if (state =3D=3D 1) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 for_each_cpu(cpuid, hotplug_device->allo=
wed_cpus) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_online(cpuid) &&=
 (cpuid !=3D this_cpu))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_down=
(cpuid);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 } else if (state =3D=3D 0) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 for_each_cpu(cpuid, hotplug_device->allo=
wed_cpus) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_online(cpuid) &=
& (cpuid !=3D this_cpu))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_up(c=
puid);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 } else
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> +
> >> + =A0 =A0 hotplug_device->hotplug_state =3D state;
> >> +
> >> + =A0 =A0 return 0;
> >> +}
> >> +/* bind hotplug callbacks to cpu hotplug cooling device */
> >> +static struct thermal_cooling_device_ops cpuhotplug_cooling_ops =3D=
 {
> >> + =A0 =A0 .get_max_state =3D cpuhotplug_get_max_state,
> >> + =A0 =A0 .get_cur_state =3D cpuhotplug_get_cur_state,
> >> + =A0 =A0 .set_cur_state =3D cpuhotplug_set_cur_state,
> >> +};
> >> +
> >> +struct thermal_cooling_device *cpuhotplug_cooling_register(
> >> + =A0 =A0 const struct cpumask *mask_val)
> >> +{
> >> + =A0 =A0 struct thermal_cooling_device *cool_dev;
> >> +
> >> + =A0 =A0 hotplug_device =3D
> >> + =A0 =A0 =A0 =A0 =A0 =A0 kzalloc(sizeof(struct hotplug_cooling_de=
vice), GFP_KERNEL);
> >> +
> >> + =A0 =A0 if (!hotplug_device)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);
> >> +
> >> + =A0 =A0 cool_dev =3D thermal_cooling_device_register("thermal-cp=
uhotplug", NULL,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 &cpuhotplug_cooling_ops);
> >> + =A0 =A0 if (!cool_dev) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(hotplug_device);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 hotplug_device->cool_dev =3D cool_dev;
> >> + =A0 =A0 hotplug_device->hotplug_state =3D 0;
> >> + =A0 =A0 hotplug_device->allowed_cpus =3D mask_val;
> >> +
> >> + =A0 =A0 return cool_dev;
> >> +}
> >> +EXPORT_SYMBOL(cpuhotplug_cooling_register);
> >> +
> >> +void cpuhotplug_cooling_unregister(void)
> >> +{
> >> + =A0 =A0 thermal_cooling_device_unregister(hotplug_device->cool_d=
ev);
> >> + =A0 =A0 kfree(hotplug_device);
> >> +}
> >> +EXPORT_SYMBOL(cpuhotplug_cooling_unregister);
> >> +#else /*!CONFIG_HOTPLUG_CPU*/
> >> +struct thermal_cooling_device *cpuhotplug_cooling_register(
> >> + =A0 =A0 const struct cpumask *mask_val)
> >> +{
> >> + =A0 =A0 return NULL;
> >> +}
> >> +EXPORT_SYMBOL(cpuhotplug_cooling_register);
> >> +void cpuhotplug_cooling_unregister(void)
> >> +{
> >> + =A0 =A0 return;
> >> +}
> >> +EXPORT_SYMBOL(cpuhotplug_cooling_unregister);
> >> +#endif /*CONFIG_HOTPLUG_CPU*/
> >> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooli=
ng.h
> >> new file mode 100644
> >> index 0000000..0c57375
> >> --- /dev/null
> >> +++ b/include/linux/cpu_cooling.h
> >> @@ -0,0 +1,45 @@
> >> +/*
> >> + * =A0linux/include/linux/cpu_cooling.h
> >> + *
> >> + * =A0Copyright (C) 2011 =A0 =A0 =A0 Samsung Electronics Co., Ltd=
(http://www.samsung.com)
> >> + * =A0Copyright (C) 2011 =A0Amit Daniel <amit.kachhap@linaro.org>
> >> + *
> >> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
> >> + * =A0This program is free software; you can redistribute it and/=
or modify
> >> + * =A0it under the terms of the GNU General Public License as pub=
lished by
> >> + * =A0the Free Software Foundation; version 2 of the License.
> >> + *
> >> + * =A0This program is distributed in the hope that it will be use=
ful, but
> >> + * =A0WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See=
 the GNU
> >> + * =A0General Public License for more details.
> >> + *
> >> + * =A0You should have received a copy of the GNU General Public L=
icense along
> >> + * =A0with this program; if not, write to the Free Software Found=
ation, Inc.,
> >> + * =A059 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> >> + *
> >> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
> >> + */
> >> +
> >> +#ifndef __CPU_COOLING_H__
> >> +#define __CPU_COOLING_H__
> >> +
> >> +#include <linux/thermal.h>
> >> +
> >> +struct freq_pctg_table {
> >> + =A0 =A0 unsigned int freq_clip_pctg[NR_CPUS];
> >> + =A0 =A0 unsigned int polling_interval;
> >> +};
> >> +
> >> +extern struct thermal_cooling_device *cpufreq_cooling_register(
> >> + =A0 =A0 struct freq_pctg_table *tab_ptr, unsigned int tab_size,
> >> + =A0 =A0 const struct cpumask *mask_val);
> >
> > I suppose your original idea was to have this function called only =
once right?
> > I'd suggest to add some documentation on this header file to specif=
y this.
> >
> > Besides, the fact that you receive a cpumask may suggest you could =
register
> > different cooling device for subsets of your system cpus.
> >
> > In any case, if you call this function more than once, you may end =
with memory leaks
> > and the last call will be the one acting in the system.
> >
> yes these api's are meant to be called once. I am working on a new
> version where all these function will be multi-instance and hence
> different cpus can support different frequency clipping.


OK.=20

Another point, is about the fact that this implementation is clipping t=
he frequency silently.
I mean, by changing the policy.max_freq, we may conflict with what the =
user defines as max freq.

> >
> >
> >> +
> >> +extern void cpufreq_cooling_unregister(void);
> >> +
> >> +extern struct thermal_cooling_device *cpuhotplug_cooling_register=
(
> >> + =A0 =A0 const struct cpumask *mask_val);
> >> +
> >> +extern void cpuhotplug_cooling_unregister(void);
> >> +
> >> +#endif /* __CPU_COOLING_H__ */
> >
> > Another thing, I have the impression that solving the config select=
ion in the
> > header file instead of in .c files is cleaner. If you want to solve=
 the config
> > selection in .c files, better to do so with Makefiles.
> >
> > If you keep the ifdefery ( THERMAL vs. HOTPLUG_CPU vs. CPU_FREQ ) h=
ere in the
> > header file, it is easier to read.
> Ok will move them in .h
> >
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
