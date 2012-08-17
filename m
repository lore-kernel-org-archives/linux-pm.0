From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [PATCH v6 1/6] thermal: add generic cpufreq cooling
	implementation
Date: Fri, 17 Aug 2012 13:28:35 +0530
Message-ID: <CAK44p21qxbpvi0Qtu89ac8ciuJRWDvn44Z8=DggMMxiwjKcczw@mail.gmail.com>
References: <1345117305-8299-1-git-send-email-amit.kachhap@linaro.org>
	<1345117305-8299-2-git-send-email-amit.kachhap@linaro.org>
	<1345188250.1682.887.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1345188250.1682.887.camel@rui.sh.intel.com>
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
Cc: linux-samsung-soc@vger.kernel.org, SangWook Ju <sw.ju@samsung.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Jean Delvare <khali@linux-fr.org>, Kyungmin Park <kmpark@infradead.org>, linux-pm@lists.linux-foundation.org, Guenter Roeck <guenter.roeck@ericsson.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 17 August 2012 12:54, Zhang Rui <rui.zhang@intel.com> wrote:
> On =E5=9B=9B, 2012-08-16 at 17:11 +0530, Amit Daniel Kachhap wrote:
>> This patchset introduces a new generic cooling device based on cpufreq
>> that can be used on non-ACPI platforms.  As a proof of concept, we have
>> drivers for the following platforms using this mechanism now:
>>
>>  * Samsung Exynos (Exynos4 and Exynos5) in the current patchset.
>>  * Freescale i.MX (git://git.linaro.org/people/amitdanielk/linux.git imx=
6q_thermal)
>>
>> There is a small change in cpufreq cooling registration APIs, so a minor
>> change is needed for Freescale platforms.
>>
>> Brief Description:
>>
>> 1) The generic cooling devices code is placed inside driver/thermal/*
>>    as placing inside acpi folder will need un-necessary enabling of acpi
>>    code.  This code is architecture independent.
>>
>> 2) This patchset adds generic cpu cooling low level implementation
>>    through frequency clipping.  In future, other cpu related cooling
>>    devices may be added here.  An ACPI version of this already exists
>>    (drivers/acpi/processor_thermal.c) .But this will be useful for
>>    platforms like ARM using the generic thermal interface along with the
>>    generic cpu cooling devices.  The cooling device registration API's
>>    return cooling device pointers which can be easily binded with the
>>    thermal zone trip points.  The important APIs exposed are,
>>
>>    a) struct thermal_cooling_device *cpufreq_cooling_register(
>>         struct cpumask *clip_cpus)
>>    b) void cpufreq_cooling_unregister(struct thermal_cooling_device *cde=
v)
>>
>> 3) Samsung exynos platform thermal implementation is done using the
>>    generic cpu cooling APIs and the new trip type.  The temperature sens=
or
>>    driver present in the hwmon folder(registered as hwmon driver) is mov=
ed
>>    to thermal folder and registered as a thermal driver.
>>
>> A simple data/control flow diagrams is shown below,
>>
>> Core Linux thermal <----->  Exynos thermal interface <----- Temperature =
Sensor
>>           |                             |
>>          \|/                            |
>>   Cpufreq cooling device <---------------
>>
>> TODO:
>> *Will send the DT enablement patches later after the driver is merged.
>>
>> This patch:
>>
>> Add support for generic cpu thermal cooling low level implementations
>> using frequency scaling up/down based on the registration parameters.
>> Different cpu related cooling devices can be registered by the user and
>> the binding of these cooling devices to the corresponding trip points ca=
n
>> be easily done as the registration APIs return the cooling device pointe=
r.
>> The user of these APIs are responsible for passing clipping frequency .
>> The drivers can also register to recieve notification about any cooling
>> action called.
>>
>> [akpm@linux-foundation.org: fix comment layout]
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
>> Cc: SangWook Ju <sw.ju@samsung.com>
>> Cc: Durgadoss <durgadoss.r@intel.com>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: Jean Delvare <khali@linux-fr.org>
>> Cc: Kyungmin Park <kmpark@infradead.org>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>>  Documentation/thermal/cpu-cooling-api.txt |   52 +++
>>  drivers/thermal/Kconfig                   |   11 +
>>  drivers/thermal/Makefile                  |    1 +
>>  drivers/thermal/cpu_cooling.c             |  512 ++++++++++++++++++++++=
+++++++
>>  include/linux/cpu_cooling.h               |   79 +++++
>>  5 files changed, 655 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/thermal/cpu-cooling-api.txt
>>  create mode 100644 drivers/thermal/cpu_cooling.c
>>  create mode 100644 include/linux/cpu_cooling.h
>>
>> diff --git a/Documentation/thermal/cpu-cooling-api.txt b/Documentation/t=
hermal/cpu-cooling-api.txt
>> new file mode 100644
>> index 0000000..a1f2a6b
>> --- /dev/null
>> +++ b/Documentation/thermal/cpu-cooling-api.txt
>> @@ -0,0 +1,52 @@
>> +CPU cooling APIs How To
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Written by Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> +
>> +Updated: 12 May 2012
>> +
>> +Copyright (c)  2012 Samsung Electronics Co., Ltd(http://www.samsung.com=
)
>> +
>> +0. Introduction
>> +
>> +The generic cpu cooling(freq clipping) provides registration/unregistra=
tion APIs
>> +to the caller. The binding of the cooling devices to the trip point is =
left for
>> +the user. The registration APIs returns the cooling device pointer.
>> +
>> +1. cpu cooling APIs
>> +
>> +1.1 cpufreq registration/unregistration APIs
>> +1.1.1 struct thermal_cooling_device *cpufreq_cooling_register(
>> +     struct cpumask *clip_cpus)
>> +
>> +    This interface function registers the cpufreq cooling device with t=
he name
>> +    "thermal-cpufreq-%x". This api can support multiple instances of cp=
ufreq
>> +    cooling devices.
>> +
>> +   clip_cpus: cpumask of cpus where the frequency constraints will happ=
en.
>> +
>> +1.1.2 void cpufreq_cooling_unregister(struct thermal_cooling_device *cd=
ev)
>> +
>> +    This interface function unregisters the "thermal-cpufreq-%x" coolin=
g device.
>> +
>> +    cdev: Cooling device pointer which has to be unregistered.
>> +
>> +
>> +1.2 CPU cooling action notifier register/unregister interface
>> +1.2.1 int cputherm_register_notifier(struct notifier_block *nb,
>> +     unsigned int list)
>> +
>> +    This interface registers a driver with cpu cooling layer. The drive=
r will
>> +    be notified when any cpu cooling action is called.
>> +
>> +    nb: notifier function to register
>> +    list: CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP
>> +
>> +1.2.2 int cputherm_unregister_notifier(struct notifier_block *nb,
>> +     unsigned int list)
>> +
>> +    This interface registers a driver with cpu cooling layer. The drive=
r will
>> +    be notified when any cpu cooling action is called.
>> +
>> +    nb: notifier function to register
>> +    list: CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP
>
> what are these two APIs used for?
> I did not see they are used in your patch set, do I miss something?
No currently they are not used by my patches. I added them on request
from Eduardo and others
>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 7dd8c34..996003b 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -19,6 +19,17 @@ config THERMAL_HWMON
>>       depends on HWMON=3Dy || HWMON=3DTHERMAL
>>       default y
>>
>> +config CPU_THERMAL
>> +     bool "generic cpu cooling support"
>> +     depends on THERMAL && CPU_FREQ
>> +     help
>> +       This implements the generic cpu cooling mechanism through freque=
ncy
>> +       reduction, cpu hotplug and any other ways of reducing temperatur=
e. An
>> +       ACPI version of this already exists(drivers/acpi/processor_therm=
al.c).
>> +       This will be useful for platforms using the generic thermal inte=
rface
>> +       and not the ACPI interface.
>> +       If you want this support, you should say Y here.
>> +
>>  config SPEAR_THERMAL
>>       bool "SPEAr thermal sensor driver"
>>       depends on THERMAL
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index fd9369a..aae59ad 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -3,5 +3,6 @@
>>  #
>>
>>  obj-$(CONFIG_THERMAL)                +=3D thermal_sys.o
>> +obj-$(CONFIG_CPU_THERMAL)            +=3D cpu_cooling.o
>>  obj-$(CONFIG_SPEAR_THERMAL)          +=3D spear_thermal.o
>>  obj-$(CONFIG_RCAR_THERMAL)   +=3D rcar_thermal.o
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling=
.c
>> new file mode 100644
>> index 0000000..c42e557
>> --- /dev/null
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -0,0 +1,512 @@
>> +/*
>> + *  linux/drivers/thermal/cpu_cooling.c
>> + *
>> + *  Copyright (C) 2012       Samsung Electronics Co., Ltd(http://www.sa=
msung.com)
>> + *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
>> + *  This program is free software; you can redistribute it and/or modif=
y
>> + *  it under the terms of the GNU General Public License as published b=
y
>> + *  the Free Software Foundation; version 2 of the License.
>> + *
>> + *  This program is distributed in the hope that it will be useful, but
>> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + *  General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU General Public License a=
long
>> + *  with this program; if not, write to the Free Software Foundation, I=
nc.,
>> + *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
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
>> + * @id: unique integer value corresponding to each cpufreq_cooling_devi=
ce
>> + *   registered.
>> + * @cool_dev: thermal_cooling_device pointer to keep track of the the
>> + *   egistered cooling device.
>> + * @cpufreq_state: integer value representing the current state of cpuf=
req
>> + *   cooling devices.
>> + * @cpufreq_val: integer value representing the absolute value of the c=
lipped
>> + *   frequency.
>> + * @allowed_cpus: all the cpus involved for this cpufreq_cooling_device=
.
>> + * @node: list_head to link all cpufreq_cooling_device together.
>> + *
>> + * This structure is required for keeping information of each
>> + * cpufreq_cooling_device registered as a list whose head is represente=
d by
>> + * cooling_cpufreq_list. In order to prevent corruption of this list a
>> + * mutex lock cooling_cpufreq_lock is used.
>> + */
>> +struct cpufreq_cooling_device {
>> +     int id;
>> +     struct thermal_cooling_device *cool_dev;
>> +     unsigned int cpufreq_state;
>> +     unsigned int cpufreq_val;
>> +     struct cpumask allowed_cpus;
>> +     struct list_head node;
>> +};
>> +static LIST_HEAD(cooling_cpufreq_list);
>> +static DEFINE_IDR(cpufreq_idr);
>> +
>> +static struct mutex cooling_cpufreq_lock;
>> +
>> +/* notify_table passes value to the CPUFREQ_ADJUST callback function. *=
/
>> +#define NOTIFY_INVALID NULL
>> +struct cpufreq_cooling_device *notify_device;
>> +
>> +/* Head of the blocking notifier chain to inform about frequency clampi=
ng */
>> +static BLOCKING_NOTIFIER_HEAD(cputherm_state_notifier_list);
>> +
>> +/**
>> + * get_idr - function to get a unique id.
>> + * @idr: struct idr * handle used to create a id.
>> + * @id: int * value generated by this function.
>> + */
>> +static int get_idr(struct idr *idr, int *id)
>> +{
>> +     int err;
>> +again:
>> +     if (unlikely(idr_pre_get(idr, GFP_KERNEL) =3D=3D 0))
>> +             return -ENOMEM;
>> +
>> +     mutex_lock(&cooling_cpufreq_lock);
>> +     err =3D idr_get_new(idr, NULL, id);
>> +     mutex_unlock(&cooling_cpufreq_lock);
>> +
>> +     if (unlikely(err =3D=3D -EAGAIN))
>> +             goto again;
>> +     else if (unlikely(err))
>> +             return err;
>> +
>> +     *id =3D *id & MAX_ID_MASK;
>> +     return 0;
>> +}
>> +
>> +/**
>> + * release_idr - function to free the unique id.
>> + * @idr: struct idr * handle used for creating the id.
>> + * @id: int value representing the unique id.
>> + */
>> +static void release_idr(struct idr *idr, int id)
>> +{
>> +     mutex_lock(&cooling_cpufreq_lock);
>> +     idr_remove(idr, id);
>> +     mutex_unlock(&cooling_cpufreq_lock);
>> +}
>> +
>> +/**
>> + * cputherm_register_notifier - Register a notifier with cpu cooling in=
terface.
>> + * @nb:      struct notifier_block * with callback info.
>> + * @list: integer value for which notification is needed. possible valu=
es are
>> + *   CPUFREQ_COOLING_START and CPUFREQ_COOLING_STOP.
>> + *
>> + * This exported function registers a driver with cpu cooling layer. Th=
e driver
>> + * will be notified when any cpu cooling action is called.
>> + */
>> +int cputherm_register_notifier(struct notifier_block *nb, unsigned int =
list)
>> +{
>> +     int ret =3D 0;
>> +
>> +     switch (list) {
>> +     case CPUFREQ_COOLING_START:
>> +     case CPUFREQ_COOLING_STOP:
>> +             ret =3D blocking_notifier_chain_register(
>> +                             &cputherm_state_notifier_list, nb);
>> +             break;
>> +     default:
>> +             ret =3D -EINVAL;
>> +     }
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL(cputherm_register_notifier);
>> +
>> +/**
>> + * cputherm_unregister_notifier - Un-register a notifier.
>> + * @nb:      struct notifier_block * with callback info.
>> + * @list: integer value for which notification is needed. values possib=
le are
>> + *   CPUFREQ_COOLING_START or CPUFREQ_COOLING_STOP.
>> + *
>> + * This exported function un-registers a driver with cpu cooling layer.
>> + */
>> +int cputherm_unregister_notifier(struct notifier_block *nb, unsigned in=
t list)
>> +{
>> +     int ret =3D 0;
>> +
>> +     switch (list) {
>> +     case CPUFREQ_COOLING_START:
>> +     case CPUFREQ_COOLING_STOP:
>> +             ret =3D blocking_notifier_chain_unregister(
>> +                             &cputherm_state_notifier_list, nb);
>> +             break;
>> +     default:
>> +             ret =3D -EINVAL;
>> +     }
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL(cputherm_unregister_notifier);
>> +
>> +/* Below code defines functions to be used for cpufreq as cooling devic=
e */
>> +
>> +/**
>> + * is_cpufreq_valid - function to check if a cpu has frequency transiti=
on policy.
>> + * @cpu: cpu for which check is needed.
>> + */
>> +static int is_cpufreq_valid(int cpu)
>> +{
>> +     struct cpufreq_policy policy;
>> +     return !cpufreq_get_policy(&policy, cpu);
>> +}
>> +
>> +/**
>> + * get_cpu_frequency - get the absolute value of frequency from level.
>> + * @cpu: cpu for which frequency is fetched.
>> + * @level: level of frequency of the CPU
>> + *   e.g level=3D1 --> 1st MAX FREQ, LEVEL=3D2 ---> 2nd MAX FREQ, .... =
etc
>> + */
>> +static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long l=
evel)
>> +{
>> +     int ret =3D 0, i =3D 0;
>> +     unsigned long level_index;
>> +     bool descend =3D false;
>> +     struct cpufreq_frequency_table *table =3D
>> +                                     cpufreq_frequency_get_table(cpu);
>> +     if (!table)
>> +             return ret;
>> +
>> +     while (table[i].frequency !=3D CPUFREQ_TABLE_END) {
>> +             if (table[i].frequency =3D=3D CPUFREQ_ENTRY_INVALID)
>> +                     continue;
>> +
>> +             /*check if table in ascending or descending order*/
>> +             if ((table[i + 1].frequency !=3D CPUFREQ_TABLE_END) &&
>> +                     (table[i + 1].frequency < table[i].frequency)
>> +                     && !descend) {
>> +                     descend =3D true;
>> +             }
>> +
>> +             /*return if level matched and table in descending order*/
>> +             if (descend && i =3D=3D level)
>> +                     return table[i].frequency;
>> +             i++;
>> +     }
>> +     i--;
>> +
>> +     if (level > i || descend)
>> +             return ret;
>> +     level_index =3D i - level;
>> +
>> +     /*Scan the table in reverse order and match the level*/
>> +     while (i >=3D 0) {
>> +             if (table[i].frequency =3D=3D CPUFREQ_ENTRY_INVALID)
>> +                     continue;
>> +             /*return if level matched*/
>> +             if (i =3D=3D level_index)
>> +                     return table[i].frequency;
>> +             i--;
>> +     }
>> +     return ret;
>> +}
>> +
>> +/**
>> + * cpufreq_apply_cooling - function to apply frequency clipping.
>> + * @cpufreq_device: cpufreq_cooling_device pointer containing frequency
>> + *   clipping data.
>> + * @cooling_state: value of the cooling state.
>> + */
>> +static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq=
_device,
>> +                             unsigned long cooling_state)
>> +{
>> +     unsigned int event, cpuid, clip_freq;
>> +     struct cpumask *maskPtr =3D &cpufreq_device->allowed_cpus;
>> +     unsigned int cpu =3D cpumask_any(maskPtr);
>> +
>> +
>> +     /* Check if the old cooling action is same as new cooling action *=
/
>> +     if (cpufreq_device->cpufreq_state =3D=3D cooling_state)
>> +             return 0;
>> +
>> +     clip_freq =3D get_cpu_frequency(cpu, cooling_state);
>> +     if (!clip_freq)
>> +             return -EINVAL;
>> +
>> +     cpufreq_device->cpufreq_state =3D cooling_state;
>> +     cpufreq_device->cpufreq_val =3D clip_freq;
>> +     notify_device =3D cpufreq_device;
>> +
>> +     if (cooling_state !=3D 0)
>> +             event =3D CPUFREQ_COOLING_START;
>> +     else
>> +             event =3D CPUFREQ_COOLING_STOP;
>> +
>> +     blocking_notifier_call_chain(&cputherm_state_notifier_list,
>> +                                             event, &clip_freq);
>> +
>> +     for_each_cpu(cpuid, maskPtr) {
>> +             if (is_cpufreq_valid(cpuid))
>> +                     cpufreq_update_policy(cpuid);
>> +     }
>> +
>> +     notify_device =3D NOTIFY_INVALID;
>> +
>> +     return 0;
>> +}
>> +
>> +/**
>> + * cpufreq_thermal_notifier - notifier callback for cpufreq policy chan=
ge.
>> + * @nb:      struct notifier_block * with callback info.
>> + * @event: value showing cpufreq event for which this function invoked.
>> + * @data: callback-specific data
>> + */
>> +static int cpufreq_thermal_notifier(struct notifier_block *nb,
>> +                                     unsigned long event, void *data)
>> +{
>> +     struct cpufreq_policy *policy =3D data;
>> +     unsigned long max_freq =3D 0;
>> +
>> +     if (event !=3D CPUFREQ_ADJUST || notify_device =3D=3D NOTIFY_INVAL=
ID)
>> +             return 0;
>> +
>> +     if (cpumask_test_cpu(policy->cpu, &notify_device->allowed_cpus))
>> +             max_freq =3D notify_device->cpufreq_val;
>> +
>> +     /* Never exceed user_policy.max*/
>> +     if (max_freq > policy->user_policy.max)
>> +             max_freq =3D policy->user_policy.max;
>> +
>> +     if (policy->max !=3D max_freq)
>> +             cpufreq_verify_within_limits(policy, 0, max_freq);
>> +
>> +     return 0;
>> +}
>> +
>> +/*
>> + * cpufreq cooling device callback functions are defined below
>> + */
>> +
>> +/**
>> + * cpufreq_get_max_state - callback function to get the max cooling sta=
te.
>> + * @cdev: thermal cooling device pointer.
>> + * @state: fill this variable with the max cooling state.
>> + */
>> +static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
>> +                              unsigned long *state)
>> +{
>> +     int ret =3D -EINVAL, i =3D 0;
>> +     struct cpufreq_cooling_device *cpufreq_device;
>> +     struct cpumask *maskPtr;
>> +     unsigned int cpu;
>> +     struct cpufreq_frequency_table *table;
>> +
>> +     mutex_lock(&cooling_cpufreq_lock);
>> +     list_for_each_entry(cpufreq_device, &cooling_cpufreq_list, node) {
>> +             if (cpufreq_device && cpufreq_device->cool_dev =3D=3D cdev=
)
>> +                     break;
>> +     }
>> +     if (cpufreq_device =3D=3D NULL)
>> +             goto return_get_max_state;
>> +
>> +     maskPtr =3D &cpufreq_device->allowed_cpus;
>> +     cpu =3D cpumask_any(maskPtr);
>> +     table =3D cpufreq_frequency_get_table(cpu);
>> +     if (!table) {
>> +             *state =3D 0;
>> +             ret =3D 0;
>> +             goto return_get_max_state;
>> +     }
>> +
>> +     while (table[i].frequency !=3D CPUFREQ_TABLE_END) {
>> +             if (table[i].frequency =3D=3D CPUFREQ_ENTRY_INVALID)
>> +                     continue;
>> +             i++;
>> +     }
>> +     if (i > 0) {
>> +             *state =3D --i;
>> +             ret =3D 0;
>> +     }
>> +
>> +return_get_max_state:
>> +     mutex_unlock(&cooling_cpufreq_lock);
>> +     return ret;
>> +}
>> +
>> +/**
>> + * cpufreq_get_cur_state - callback function to get the current cooling=
 state.
>> + * @cdev: thermal cooling device pointer.
>> + * @state: fill this variable with the current cooling state.
>> + */
>> +static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
>> +                              unsigned long *state)
>> +{
>> +     int ret =3D -EINVAL;
>> +     struct cpufreq_cooling_device *cpufreq_device;
>> +
>> +     mutex_lock(&cooling_cpufreq_lock);
>> +     list_for_each_entry(cpufreq_device, &cooling_cpufreq_list, node) {
>> +             if (cpufreq_device && cpufreq_device->cool_dev =3D=3D cdev=
) {
>> +                     *state =3D cpufreq_device->cpufreq_state;
>> +                     ret =3D 0;
>> +                     break;
>> +             }
>> +     }
>> +     mutex_unlock(&cooling_cpufreq_lock);
>> +
>
> as cpufreq may be changed in other places, e.g. via sysfs I/F, we should
> use the current cpu frequency to get the REAL cooling state, rather than
> using a cached value.

Yes agreed , I will repost with your suggestion.

Thanks,
Amit
>
> thanks,
> rui
>
>
