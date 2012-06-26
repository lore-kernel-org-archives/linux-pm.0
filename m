From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [PATCH v4 1/5] thermal: Add generic cpufreq cooling implementation
Date: Tue, 26 Jun 2012 10:42:43 +0300
Message-ID: <CAGF5oy9Dd1YUCbG8BGKVeYEZ7q2UP0HQ3oz+0cnABuFb-sBP6g@mail.gmail.com>
References: <1336815645-29625-1-git-send-email-amit.kachhap@linaro.org>
	<1336815645-29625-2-git-send-email-amit.kachhap@linaro.org>
	<CAMXH7KHMccn71-4-6QSZ8k98QZhF2yNXpDkZ5Cs4nf5Y-wd3gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAMXH7KHMccn71-4-6QSZ8k98QZhF2yNXpDkZ5Cs4nf5Y-wd3gw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Rob Lee <rob.lee@linaro.org>
Cc: Amit Daniel Kachhap <amit.kachhap@linaro.org>, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, linux-samsung-soc@vger.kernel.org, durgadoss.r@intel.com, patches@linaro.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, khali@linux-fr.org, linaro-dev@lists.linaro.org, rui.zhang@intel.com, guenter.roeck@ericsson.com, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org

Hey Rob and Amit,

On Tue, Jun 26, 2012 at 6:12 AM, Rob Lee <rob.lee@linaro.org> wrote:
> Hey Amit,
>
> I was just re-organizing the imx thermal driver that uses this cpu
> cooling interface and noticed a couple of small issues here. =A0 If

While rewriting the OMAP BG driver on top of this series I noticed
similar issues. Apart from those pointed by Rob, I have another minor
fix.

> these suggestions are agreed upon and if it's too late for these
> issues be changed with this patchset, I can submit them separately
> unless you'd prefer to.
>
> On Sat, May 12, 2012 at 4:40 AM, Amit Daniel Kachhap
> <amit.kachhap@linaro.org> wrote:
>> This patch adds support for generic cpu thermal cooling low level
>> implementations using frequency scaling up/down based on the registr=
ation
>> parameters. Different cpu related cooling devices can be registered =
by the
>> user and the binding of these cooling devices to the corresponding
>> trip points can be easily done as the registration APIs return the
>> cooling device pointer. The user of these APIs are responsible for
>> passing clipping frequency . The drivers can also register to reciev=
e
>> notification about any cooling action called.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> ---
>> =A0Documentation/thermal/cpu-cooling-api.txt | =A0 60 ++++
>> =A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 11 +
>> =A0drivers/thermal/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A03 +-
>> =A0drivers/thermal/cpu_cooling.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0483 ++=
+++++++++++++++++++++++++++
>> =A0include/linux/cpu_cooling.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 99 =
++++++
>> =A05 files changed, 655 insertions(+), 1 deletions(-)
>> =A0create mode 100644 Documentation/thermal/cpu-cooling-api.txt
>> =A0create mode 100644 drivers/thermal/cpu_cooling.c
>> =A0create mode 100644 include/linux/cpu_cooling.h
>>
>> diff --git a/Documentation/thermal/cpu-cooling-api.txt b/Documentati=
on/thermal/cpu-cooling-api.txt
>> new file mode 100644
>> index 0000000..557adb8
>> --- /dev/null
>> +++ b/Documentation/thermal/cpu-cooling-api.txt
>> @@ -0,0 +1,60 @@
>> +CPU cooling APIs How To
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Written by Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> +
>> +Updated: 12 May 2012
>> +
>> +Copyright (c) =A02012 Samsung Electronics Co., Ltd(http://www.samsu=
ng.com)
>> +
>> +0. Introduction
>> +
>> +The generic cpu cooling(freq clipping, cpuhotplug etc) provides
>> +registration/unregistration APIs to the caller. The binding of the =
cooling
>> +devices to the trip point is left for the user. The registration AP=
Is returns
>> +the cooling device pointer.
>> +
>> +1. cpu cooling APIs
>> +
>> +1.1 cpufreq registration/unregistration APIs
>> +1.1.1 struct thermal_cooling_device *cpufreq_cooling_register(
>> + =A0 =A0 =A0 struct freq_clip_table *tab_ptr, unsigned int tab_size=
)
>> +
>> + =A0 =A0This interface function registers the cpufreq cooling devic=
e with the name
>> + =A0 =A0"thermal-cpufreq-%x". This api can support multiple instanc=
es of cpufreq
>> + =A0 =A0cooling devices.
>> +
>> + =A0 =A0tab_ptr: The table containing the maximum value of frequenc=
y to be clipped
>> + =A0 =A0for each cooling state.
>> + =A0 =A0 =A0 .freq_clip_max: Value of frequency to be clipped for e=
ach allowed
>> + =A0 =A0 =A0 =A0cpus.
>> + =A0 =A0 =A0 .temp_level: Temperature level at which the frequency =
clamping will
>> + =A0 =A0 =A0 happen.
>> + =A0 =A0 =A0 .mask_val: cpumask of the allowed cpu's
>> + =A0 =A0tab_size: the total number of cpufreq cooling states.
>> +
>> +1.1.2 void cpufreq_cooling_unregister(struct thermal_cooling_device=
 *cdev)
>> +
>> + =A0 =A0This interface function unregisters the "thermal-cpufreq-%x=
" cooling device.
>> +
>> + =A0 =A0cdev: Cooling device pointer which has to be unregistered.
>> +
>> +
>> +1.2 CPU cooling action notifier register/unregister interface
>> +1.2.1 int cputherm_register_notifier(struct notifier_block *nb,
>> + =A0 =A0 =A0 unsigned int list)
>> +
>> + =A0 =A0This interface registers a driver with cpu cooling layer. T=
he driver will
>> + =A0 =A0be notified when any cpu cooling action is called.
>> +
>> + =A0 =A0nb: notifier function to register
>> + =A0 =A0list: CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP
>> +
>> +1.2.2 int cputherm_unregister_notifier(struct notifier_block *nb,
>> + =A0 =A0 =A0 unsigned int list)
>> +
>> + =A0 =A0This interface registers a driver with cpu cooling layer. T=
he driver will
>> + =A0 =A0be notified when any cpu cooling action is called.
>> +
>> + =A0 =A0nb: notifier function to register
>> + =A0 =A0list: CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 514a691..d9c529f 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -19,6 +19,17 @@ config THERMAL_HWMON
>> =A0 =A0 =A0 =A0depends on HWMON=3Dy || HWMON=3DTHERMAL
>> =A0 =A0 =A0 =A0default y
>>
>> +config CPU_THERMAL
>
> Perhaps the name CPU_COOLING or CPUFREQ_COOLING would more accurately
> describe this functionality? =A0I like the latter since now this
> mechanism only supports cooling by using cpufreq.
>
>> + =A0 =A0 =A0 bool "generic cpu cooling support"
>
> If we use CPUFREQ_COOLING, then perhaps this could say:
>
> bool "cpu cooling through cpufreq frequency limiting"
>
>> + =A0 =A0 =A0 depends on THERMAL && CPU_FREQ
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 This implements the generic cpu cooling mechanism =
through frequency
>> + =A0 =A0 =A0 =A0 reduction, cpu hotplug and any other ways of reduc=
ing temperature. An
>> + =A0 =A0 =A0 =A0 ACPI version of this already exists(drivers/acpi/p=
rocessor_thermal.c).
>> + =A0 =A0 =A0 =A0 This will be useful for platforms using the generi=
c thermal interface
>> + =A0 =A0 =A0 =A0 and not the ACPI interface.
>> + =A0 =A0 =A0 =A0 If you want this support, you should say Y or M he=
re.
>> +
>
> Currently, only the "frequency reduction" method exists so perhaps
> it's best to remove mention of "cpu hotplug and any other ways of
> reducing temperature"? =A0Here'as a version for cpufreq only:
>
> config CPUFREQ_COOLING
> =A0 =A0 =A0 =A0bool "cpu cooling through cpufreq frequency limiting"
> =A0 =A0 =A0 =A0depends on THERMAL && CPU_FREQ
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This implements a generic cpu cooling mechanism th=
rough cpufreq
> =A0 =A0 =A0 =A0 =A0frequency limiting. An ACPI version of this alread=
y exists
> =A0 =A0 =A0 =A0 =A0(drivers/acpi/processor_thermal.c). =A0This will b=
e useful for
> =A0 =A0 =A0 =A0 =A0platforms using the generic thermal interface and =
not the ACPI
> =A0 =A0 =A0 =A0 =A0interface.
> =A0 =A0 =A0 =A0 =A0If you want this support, you should say Y or M he=
re.
>
>> =A0config SPEAR_THERMAL
>> =A0 =A0 =A0 =A0bool "SPEAr thermal sensor driver"
>> =A0 =A0 =A0 =A0depends on THERMAL
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index a9fff0b..30c456c 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -3,4 +3,5 @@
>> =A0#
>>
>> =A0obj-$(CONFIG_THERMAL) =A0 =A0 =A0 =A0 =A0+=3D thermal_sys.o
>> -obj-$(CONFIG_SPEAR_THERMAL) =A0 =A0 =A0 =A0 =A0 =A0+=3D spear_therm=
al.o
>> \ No newline at end of file
>> +obj-$(CONFIG_CPU_THERMAL) =A0 =A0 =A0 +=3D cpu_cooling.o
>> +obj-$(CONFIG_SPEAR_THERMAL) =A0 =A0 =A0 =A0 =A0 =A0+=3D spear_therm=
al.o
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_coo=
ling.c
>> new file mode 100644
>> index 0000000..c40d9a0
>> --- /dev/null
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -0,0 +1,483 @@
>> +/*
>> + * =A0linux/drivers/thermal/cpu_cooling.c
>> + *
>> + * =A0Copyright (C) 2012 Samsung Electronics Co., Ltd(http://www.sa=
msung.com)
>> + * =A0Copyright (C) 2012 =A0Amit Daniel <amit.kachhap@linaro.org>
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
>> + * =A0This program is free software; you can redistribute it and/or=
 modify
>> + * =A0it under the terms of the GNU General Public License as publi=
shed by
>> + * =A0the Free Software Foundation; version 2 of the License.
>> + *
>> + * =A0This program is distributed in the hope that it will be usefu=
l, but
>> + * =A0WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See t=
he GNU
>> + * =A0General Public License for more details.
>> + *
>> + * =A0You should have received a copy of the GNU General Public Lic=
ense along
>> + * =A0with this program; if not, write to the Free Software Foundat=
ion, Inc.,
>> + * =A059 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/thermal.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/cpufreq.h>
>> +#include <linux/err.h>
>> +#include <linux/slab.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpu_cooling.h>
>> +
>> +/**
>> + * struct cpufreq_cooling_device
>> + * @id: unique integer value corresponding to each cpufreq_cooling_=
device
>> + * =A0 =A0 registered.
>> + * @cool_dev: thermal_cooling_device pointer to keep track of the t=
he
>> + * =A0 =A0 egistered cooling device.
>> + * @tab_ptr: freq_clip_table table containing the maximum value of =
frequency to
>> + * =A0 =A0 be set for different cooling state.
>> + * @tab_size: integer value representing a count of the above table=
=2E
>> + * @cpufreq_state: integer value representing the current state of =
cpufreq
>> + * =A0 =A0 cooling devices.
>> + * @allowed_cpus: all the cpus involved for this cpufreq_cooling_de=
vice.
>> + * @node: list_head to link all cpufreq_cooling_device together.
>> + *
>> + * This structure is required for keeping information of each
>> + * cpufreq_cooling_device registered as a list whose head is repres=
ented by
>> + * cooling_cpufreq_list. In order to prevent corruption of this lis=
t a
>> + * mutex lock cooling_cpufreq_lock is used.
>> + */
>> +struct cpufreq_cooling_device {
>> + =A0 =A0 =A0 int id;
>> + =A0 =A0 =A0 struct thermal_cooling_device *cool_dev;
>> + =A0 =A0 =A0 struct freq_clip_table *tab_ptr;
>> + =A0 =A0 =A0 unsigned int tab_size;
>> + =A0 =A0 =A0 unsigned int cpufreq_state;
>> + =A0 =A0 =A0 struct cpumask allowed_cpus;
>> + =A0 =A0 =A0 struct list_head node;
>> +};
>> +static LIST_HEAD(cooling_cpufreq_list);
>> +static DEFINE_MUTEX(cooling_cpufreq_lock);
>> +static DEFINE_IDR(cpufreq_idr);
>> +
>> +/*per cpu variable to store the previous max frequency allowed*/
>> +static DEFINE_PER_CPU(unsigned int, max_policy_freq);
>> +
>> +/*notify_table passes value to the CPUFREQ_ADJUST callback function=
=2E*/
>> +#define NOTIFY_INVALID NULL
>> +static struct freq_clip_table *notify_table;
>> +
>> +/*Head of the blocking notifier chain to inform about frequency cla=
mping*/
>> +static BLOCKING_NOTIFIER_HEAD(cputherm_state_notifier_list);
>> +
>> +/**
>> + * get_idr - function to get a unique id.
>> + * @idr: struct idr * handle used to create a id.
>> + * @id: int * value generated by this function.
>> + */
>> +static int get_idr(struct idr *idr, int *id)
>> +{
>> + =A0 =A0 =A0 int err;
>> +again:
>> + =A0 =A0 =A0 if (unlikely(idr_pre_get(idr, GFP_KERNEL) =3D=3D 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 =A0 err =3D idr_get_new(idr, NULL, id);
>> + =A0 =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> +
>> + =A0 =A0 =A0 if (unlikely(err =3D=3D -EAGAIN))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto again;
>> + =A0 =A0 =A0 else if (unlikely(err))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> +
>> + =A0 =A0 =A0 *id =3D *id & MAX_ID_MASK;
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +/**
>> + * release_idr - function to free the unique id.
>> + * @idr: struct idr * handle used for creating the id.
>> + * @id: int value representing the unique id.
>> + */
>> +static void release_idr(struct idr *idr, int id)
>> +{
>> + =A0 =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 =A0 idr_remove(idr, id);
>> + =A0 =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> +}
>> +
>> +/**
>> + * cputherm_register_notifier - Register a notifier with cpu coolin=
g interface.
>> + * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info.
>> + * @list: integer value for which notification is needed. possible =
values are
>> + * =A0 =A0 CPUFREQ_COOLING_START and CPUFREQ_COOLING_STOP.
>> + *
>> + * This exported function registers a driver with cpu cooling layer=
=2E The driver
>> + * will be notified when any cpu cooling action is called.
>> + */
>> +int cputherm_register_notifier(struct notifier_block *nb, unsigned =
int list)
>> +{
>> + =A0 =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 =A0 switch (list) {
>> + =A0 =A0 =A0 case CPUFREQ_COOLING_START:
>> + =A0 =A0 =A0 case CPUFREQ_COOLING_STOP:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D blocking_notifier_chain_regist=
er(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &cputh=
erm_state_notifier_list, nb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 return ret;
>> +}
>> +EXPORT_SYMBOL(cputherm_register_notifier);
>> +
>> +/**
>> + * cputherm_unregister_notifier - Un-register a notifier.
>> + * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info.
>> + * @list: integer value for which notification is needed. values po=
ssible are
>> + * =A0 =A0 CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP.
>> + *
>> + * This exported function un-registers a driver with cpu cooling la=
yer.
>> + */
>> +int cputherm_unregister_notifier(struct notifier_block *nb, unsigne=
d int list)
>> +{
>> + =A0 =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 =A0 switch (list) {
>> + =A0 =A0 =A0 case CPUFREQ_COOLING_START:
>> + =A0 =A0 =A0 case CPUFREQ_COOLING_STOP:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D blocking_notifier_chain_unregi=
ster(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &cputh=
erm_state_notifier_list, nb);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 return ret;
>> +}
>> +EXPORT_SYMBOL(cputherm_unregister_notifier);
>> +
>> +/*Below codes defines functions to be used for cpufreq as cooling d=
evice*/
>> +
>> +/**
>> + * is_cpufreq_valid - function to check if a cpu has frequency tran=
sition policy.
>> + * @cpu: cpu for which check is needed.
>> + */
>> +static int is_cpufreq_valid(int cpu)
>> +{
>> + =A0 =A0 =A0 struct cpufreq_policy policy;
>> + =A0 =A0 =A0 return !cpufreq_get_policy(&policy, cpu);
>> +}
>> +
>> +/**
>> + * cpufreq_apply_cooling - function to apply frequency clipping.
>> + * @cpufreq_device: cpufreq_cooling_device pointer containing frequ=
ency
>> + * =A0 =A0 clipping data.
>> + * @cooling_state: value of the cooling state.
>> + */
>> +static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpu=
freq_device,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsign=
ed long cooling_state)
>> +{
>> + =A0 =A0 =A0 unsigned int event, cpuid, state;
>> + =A0 =A0 =A0 struct freq_clip_table *th_table, *table_ptr;
>> + =A0 =A0 =A0 const struct cpumask *maskPtr =3D &cpufreq_device->all=
owed_cpus;
>> + =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_ptr;
>> +
>> + =A0 =A0 =A0 if (cooling_state > cpufreq_device->tab_size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 /*Check if the old cooling action is same as new cooli=
ng action*/
>> + =A0 =A0 =A0 if (cpufreq_device->cpufreq_state =3D=3D cooling_state=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 =A0 /*pass cooling table info to the cpufreq_thermal_notif=
ier callback*/
>> + =A0 =A0 =A0 notify_table =3D NOTIFY_INVALID;
>> +
>> + =A0 =A0 =A0 if (cooling_state > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 th_table =3D &(cpufreq_device->tab_ptr=
[cooling_state - 1]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_table =3D th_table;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /*check if any lower clip frequency active in other cp=
ufreq_device's*/
>> + =A0 =A0 =A0 list_for_each_entry(cpufreq_ptr, &cooling_cpufreq_list=
, node) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D cpufreq_ptr->cpufreq_state;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (state =3D=3D 0 || cpufreq_ptr =3D=3D=
 cpufreq_device)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpumask_equal(&cpufreq_ptr->allow=
ed_cpus,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &cpufr=
eq_device->allowed_cpus))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 table_ptr =3D &(cpufreq_ptr->tab_ptr[s=
tate - 1]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (notify_table =3D=3D NULL ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (table=
_ptr->freq_clip_max <
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify=
_table->freq_clip_max))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_table =3D =A0ta=
ble_ptr;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 cpufreq_device->cpufreq_state =3D cooling_state;
>> +
>> + =A0 =A0 =A0 if (notify_table !=3D NOTIFY_INVALID) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 event =3D CPUFREQ_COOLING_START;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 maskPtr =3D notify_table->mask_val;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 event =3D CPUFREQ_COOLING_STOP;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 blocking_notifier_call_chain(&cputherm_state_notifier_=
list,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 event, notify_table);
>> +
>> + =A0 =A0 =A0 for_each_cpu(cpuid, maskPtr) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_cpufreq_valid(cpuid))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_update_policy(=
cpuid);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 notify_table =3D NOTIFY_INVALID;
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +/**
>> + * cpufreq_thermal_notifier - notifier callback for cpufreq policy =
change.
>> + * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info.
>> + * @event: value showing cpufreq event for which this function invo=
ked.
>> + * @data: callback-specific data
>> + */
>> +static int cpufreq_thermal_notifier(struct notifier_block *nb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 unsigned long event, void *data)
>> +{
>> + =A0 =A0 =A0 struct cpufreq_policy *policy =3D data;
>> + =A0 =A0 =A0 unsigned long max_freq =3D 0;
>> +
>> + =A0 =A0 =A0 if (event !=3D CPUFREQ_ADJUST)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 =A0 if (notify_table !=3D NOTIFY_INVALID) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D notify_table->freq_clip_m=
ax;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!per_cpu(max_policy_freq, policy->=
cpu))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_cpu(max_policy_fre=
q, policy->cpu) =3D policy->max;
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (per_cpu(max_policy_freq, policy->c=
pu)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D per_cpu(m=
ax_policy_freq, policy->cpu);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_cpu(max_policy_fre=
q, policy->cpu) =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D policy->m=
ax;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* Never exceed user_policy.max*/
>> + =A0 =A0 =A0 if (max_freq > policy->user_policy.max)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D policy->user_policy.max;
>> +
>> + =A0 =A0 =A0 if (policy->max !=3D max_freq)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_verify_within_limits(policy, 0=
, max_freq);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * cpufreq cooling device callback functions are defined below
>> + */
>> +
>> +/**
>> + * cpufreq_get_max_state - callback function to get the max cooling=
 state.
>> + * @cdev: thermal cooling device pointer.
>> + * @state: fill this variable with the max cooling state.
>> + */
>> +static int cpufreq_get_max_state(struct thermal_cooling_device *cde=
v,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uns=
igned long *state)
>> +{
>> + =A0 =A0 =A0 int ret =3D -EINVAL;
>> + =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_device;
>> +
>> + =A0 =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 =A0 list_for_each_entry(cpufreq_device, &cooling_cpufreq_l=
ist, node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_device && cpufreq_device->=
cool_dev =3D=3D cdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *state =3D cpufreq_dev=
ice->tab_size;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +/**
>> + * cpufreq_get_cur_state - callback function to get the current coo=
ling state.
>> + * @cdev: thermal cooling device pointer.
>> + * @state: fill this variable with the current cooling state.
>> + */
>> +static int cpufreq_get_cur_state(struct thermal_cooling_device *cde=
v,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uns=
igned long *state)
>> +{
>> + =A0 =A0 =A0 int ret =3D -EINVAL;
>> + =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_device;
>> +
>> + =A0 =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 =A0 list_for_each_entry(cpufreq_device, &cooling_cpufreq_l=
ist, node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_device && cpufreq_device->=
cool_dev =3D=3D cdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *state =3D cpufreq_dev=
ice->cpufreq_state;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +/**
>> + * cpufreq_set_cur_state - callback function to set the current coo=
ling state.
>> + * @cdev: thermal cooling device pointer.
>> + * @state: set this variable to the current cooling state.
>> + */
>> +static int cpufreq_set_cur_state(struct thermal_cooling_device *cde=
v,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uns=
igned long state)
>> +{
>> + =A0 =A0 =A0 int ret =3D -EINVAL;
>> + =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_device;
>> +
>> + =A0 =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 =A0 list_for_each_entry(cpufreq_device, &cooling_cpufreq_l=
ist, node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_device && cpufreq_device->=
cool_dev =3D=3D cdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cpufreq_apply_cooling(cpufreq_=
device, state);
>> +
>> + =A0 =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +/*Bind cpufreq callbacks to thermal cooling device ops*/
>> +static struct thermal_cooling_device_ops const cpufreq_cooling_ops =
=3D {
>> + =A0 =A0 =A0 .get_max_state =3D cpufreq_get_max_state,
>> + =A0 =A0 =A0 .get_cur_state =3D cpufreq_get_cur_state,
>> + =A0 =A0 =A0 .set_cur_state =3D cpufreq_set_cur_state,
>> +};
>> +
>> +/*Notifier for cpufreq policy change*/
>> +static struct notifier_block thermal_cpufreq_notifier_block =3D {
>> + =A0 =A0 =A0 .notifier_call =3D cpufreq_thermal_notifier,
>> +};
>> +
>> +/**
>> + * cpufreq_cooling_register - function to create cpufreq cooling de=
vice.
>> + * @tab_ptr: table ptr containing the maximum value of frequency to=
 be clipped
>> + * =A0 =A0 for each cooling state.
>> + * @tab_size: count of entries in the above table.
>> + * =A0 =A0 happen.
>> + */
>> +struct thermal_cooling_device *cpufreq_cooling_register(
>> + =A0 =A0 =A0 struct freq_clip_table *tab_ptr, unsigned int tab_size=
)
>> +{
>> + =A0 =A0 =A0 struct thermal_cooling_device *cool_dev;
>> + =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_dev =3D NULL;
>> + =A0 =A0 =A0 struct freq_clip_table *clip_tab;
>> + =A0 =A0 =A0 unsigned int cpufreq_dev_count =3D 0;
>> + =A0 =A0 =A0 char dev_name[THERMAL_NAME_LENGTH];
>> + =A0 =A0 =A0 int ret =3D 0, id =3D 0, i;
>> +
>> + =A0 =A0 =A0 if (tab_ptr =3D=3D NULL || tab_size =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
>> +
>> + =A0 =A0 =A0 list_for_each_entry(cpufreq_dev, &cooling_cpufreq_list=
, node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_dev_count++;
>> +
>> + =A0 =A0 =A0 cpufreq_dev =3D kzalloc(sizeof(struct cpufreq_cooling_=
device),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
>> + =A0 =A0 =A0 if (!cpufreq_dev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);
>> +
>> + =A0 =A0 =A0 /*Verify that all the entries of freq_clip_table are p=
resent*/
>> + =A0 =A0 =A0 for (i =3D 0; i < tab_size; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clip_tab =3D ((struct freq_clip_table =
*)&tab_ptr[i]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!clip_tab->freq_clip_max || !clip_=
tab->mask_val
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 || !clip_tab->temp_level) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*Consolidate all the cpumask for al=
l the individual entries
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*of the trip table. This is useful =
in resetting all the
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*clipped frequencies to the normal =
level for each cpufreq
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*cooling device.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpumask_or(&cpufreq_dev->allowed_cpus,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &cpufreq_dev->allowed_=
cpus, clip_tab->mask_val);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 cpufreq_dev->tab_ptr =3D tab_ptr;
>> + =A0 =A0 =A0 cpufreq_dev->tab_size =3D tab_size;
>> +
>> + =A0 =A0 =A0 ret =3D get_idr(&cpufreq_idr, &cpufreq_dev->id);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 sprintf(dev_name, "thermal-cpufreq-%d", cpufreq_dev->i=
d);
>> +
>> + =A0 =A0 =A0 cool_dev =3D thermal_cooling_device_register(dev_name,=
 cpufreq_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &cpufreq_cooling_ops);
>> + =A0 =A0 =A0 if (!cool_dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_idr(&cpufreq_idr, cpufreq_dev-=
>id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 cpufreq_dev->id =3D id;
>> + =A0 =A0 =A0 cpufreq_dev->cool_dev =3D cool_dev;
>> + =A0 =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 =A0 list_add_tail(&cpufreq_dev->node, &cooling_cpufreq_lis=
t);
>> +
>> + =A0 =A0 =A0 /*Register the notifier for first cpufreq cooling devi=
ce*/
>> + =A0 =A0 =A0 if (cpufreq_dev_count =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_register_notifier(&thermal_cpu=
freq_notifier_block,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 CPUFREQ_POLICY_NOTIFIER);
>> +
>> + =A0 =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> + =A0 =A0 =A0 return cool_dev;
>> +}
>> +EXPORT_SYMBOL(cpufreq_cooling_register);
>> +
>> +/**
>> + * cpufreq_cooling_unregister - function to remove cpufreq cooling =
device.
>> + * @cdev: thermal cooling device pointer.
>> + */
>> +void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev=
)
>> +{
>> + =A0 =A0 =A0 struct cpufreq_cooling_device *cpufreq_dev =3D NULL;
>> + =A0 =A0 =A0 unsigned int cpufreq_dev_count =3D 0;
>> +
>> + =A0 =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 =A0 list_for_each_entry(cpufreq_dev, &cooling_cpufreq_list=
, node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_dev && cpufreq_dev->cool_d=
ev =3D=3D cdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_dev_count++;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (!cpufreq_dev || cpufreq_dev->cool_dev !=3D cdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 list_del(&cpufreq_dev->node);
>> +
>> + =A0 =A0 =A0 /*Unregister the notifier for the last cpufreq cooling=
 device*/
>> + =A0 =A0 =A0 if (cpufreq_dev_count =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_unregister_notifier(&thermal_c=
pufreq_notifier_block,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 CPUFREQ_POLICY_NOTIFIER);
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> + =A0 =A0 =A0 thermal_cooling_device_unregister(cpufreq_dev->cool_de=
v);
>> + =A0 =A0 =A0 release_idr(&cpufreq_idr, cpufreq_dev->id);
>> + =A0 =A0 =A0 kfree(cpufreq_dev);
>> +}
>> +EXPORT_SYMBOL(cpufreq_cooling_unregister);
>> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling=
=2Eh
>> new file mode 100644
>> index 0000000..ed6c096
>> --- /dev/null
>> +++ b/include/linux/cpu_cooling.h
>> @@ -0,0 +1,99 @@
>> +/*
>> + * =A0linux/include/linux/cpu_cooling.h
>> + *
>> + * =A0Copyright (C) 2012 Samsung Electronics Co., Ltd(http://www.sa=
msung.com)
>> + * =A0Copyright (C) 2012 =A0Amit Daniel <amit.kachhap@linaro.org>
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
>> + * =A0This program is free software; you can redistribute it and/or=
 modify
>> + * =A0it under the terms of the GNU General Public License as publi=
shed by
>> + * =A0the Free Software Foundation; version 2 of the License.
>> + *
>> + * =A0This program is distributed in the hope that it will be usefu=
l, but
>> + * =A0WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See t=
he GNU
>> + * =A0General Public License for more details.
>> + *
>> + * =A0You should have received a copy of the GNU General Public Lic=
ense along
>> + * =A0with this program; if not, write to the Free Software Foundat=
ion, Inc.,
>> + * =A059 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
>> + */
>> +
>> +#ifndef __CPU_COOLING_H__
>> +#define __CPU_COOLING_H__
>> +
>> +#include <linux/thermal.h>
>> +
>> +#define CPUFREQ_COOLING_START =A0 =A0 =A0 =A0 =A00
>> +#define CPUFREQ_COOLING_STOP =A0 =A0 =A0 =A0 =A0 1
>> +
>> +/**
>> + * struct freq_clip_table
>> + * @freq_clip_max: maximum frequency allowed for this cooling state=
=2E
>> + * @temp_level: Temperature level at which the temperature clipping=
 will
>> + * =A0 =A0 happen.
>> + * @mask_val: cpumask of the allowed cpu's where the clipping will =
take place.
>> + *
>> + * This structure is required to be filled and passed to the
>> + * cpufreq_cooling_unregister function.
>> + */
>> +struct freq_clip_table {
>> + =A0 =A0 =A0 unsigned int freq_clip_max;
>> + =A0 =A0 =A0 unsigned int temp_level;
>> + =A0 =A0 =A0 const struct cpumask *mask_val;
>> +};
>> +
>> +/**
>> + * cputherm_register_notifier - Register a notifier with cpu coolin=
g interface.
>> + * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info.
>> + * @list: integer value for which notification is needed. possible =
values are
>> + * =A0 =A0 CPUFREQ_COOLING_TYPE and CPUHOTPLUG_COOLING_TYPE.
>
> CPUFREQ_COOLING_TYPE and CPUHOTPLUG_COOLING_TYPE should be changed to
> CPUFREQ_COOLING_START CPUFREQ_COOLING_STOP, right?
>
>> + *
>> + * This exported function registers a driver with cpu cooling layer=
=2E The driver
>> + * will be notified when any cpu cooling action is called.
>> + */
>> +int cputherm_register_notifier(struct notifier_block *nb, unsigned =
int list);
>> +
>> +/**
>> + * cputherm_unregister_notifier - Un-register a notifier.
>> + * @nb: =A0 =A0 =A0 =A0struct notifier_block * with callback info.
>> + * @list: integer value for which notification is needed. values po=
ssible are
>> + * =A0 =A0 CPUFREQ_COOLING_TYPE.
>
> Should be changed to CPUFREQ_COOLING_START, CPUFREQ_COOLING_STOP, rig=
ht?
>
>> + *
>> + * This exported function un-registers a driver with cpu cooling la=
yer.
>> + */
>> +int cputherm_unregister_notifier(struct notifier_block *nb, unsigne=
d int list);
>> +
>> +#ifdef CONFIG_CPU_FREQ
>
> Consider changing this to "#ifdef CPU_THERMAL" =A0A platform thermal
> driver may want to always call this function as its cpu cooling
> mechanism but it should still function without the cpu_cooling being
> enabled. =A0In this case, the platform thermal driver would only prov=
ide
> temperature readings and critical trip point handling. =A0But if the
> platform happened may have CONFIG_CPU_FREQ enabled, a build error
> would occur in the current implementation.

I agree here. It makes more sense to have the check against CPU_THERMAL

>
> (the CONFIG_CPU_FREQ requirement will be met by CPU_THERMAL being
> enabled since it also implies CONFIG_CPU_FREQ being enabled per the
> Kconfig dependency)

True.

>
>> +/**
>> + * cpufreq_cooling_register - function to create cpufreq cooling de=
vice.
>> + * @tab_ptr: table ptr containing the maximum value of frequency to=
 be clipped
>> + * =A0 =A0 for each cooling state.
>> + * @tab_size: count of entries in the above table.
>> + * @mask_val: cpumask containing the allowed cpu's where frequency =
clipping can
>> + * =A0 =A0 happen.
>> + */
>> +struct thermal_cooling_device *cpufreq_cooling_register(
>> + =A0 =A0 =A0 struct freq_clip_table *tab_ptr, unsigned int tab_size=
);
>> +
>> +/**
>> + * cpufreq_cooling_unregister - function to remove cpufreq cooling =
device.
>> + * @cdev: thermal cooling device pointer.
>> + */
>> +void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev=
);
>> +#else /*!CONFIG_CPU_FREQ*/
>
> Modify comment if above suggestion is taken.
>
>> +static inline struct thermal_cooling_device *cpufreq_cooling_regist=
er(
>> + =A0 =A0 =A0 struct freq_clip_table *tab_ptr, unsigned int tab_size=
);

The above semicollon will cause a build error in case this path of the
ifdef is taken.

>> +{
>> + =A0 =A0 =A0 return NULL;
>> +}
>> +static inline void cpufreq_cooling_unregister(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct thermal_cooling_device *cdev)
>> +{
>> + =A0 =A0 =A0 return;
>> +}
>> +#endif /*CONFIG_CPU_FREQ*/
>
> Modify comment if above suggestion is taken.
>
>> +
>> +#endif /* __CPU_COOLING_H__ */
>> --
>> 1.7.1
>>
>>
>> _______________________________________________
>> linaro-dev mailing list
>> linaro-dev@lists.linaro.org
>> http://lists.linaro.org/mailman/listinfo/linaro-dev
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20

Eduardo Valentin
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
