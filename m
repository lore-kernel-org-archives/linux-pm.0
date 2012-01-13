From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [RFC PATCH 2/2] thermal: Add generic cpu cooling
	implementation
Date: Fri, 13 Jan 2012 09:20:38 +0530
Message-ID: <CAK44p203s3Eg8n2C_SXiFDEOsL3hQ2J34e0kFE9T=Um6kFZd1Q@mail.gmail.com>
References: <1323789196-4942-1-git-send-email-amit.kachhap@linaro.org>
	<1323789196-4942-3-git-send-email-amit.kachhap@linaro.org>
	<CAMXH7KEBCTWDsSFn+ZUsbetvbWXO3N9ZMpLBvLm0n0r2RH1wuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMXH7KEBCTWDsSFn+ZUsbetvbWXO3N9ZMpLBvLm0n0r2RH1wuQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rob Lee <rob.lee@linaro.org>
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 11 January 2012 13:32, Rob Lee <rob.lee@linaro.org> wrote:
> Hey Amit, I was able to use your code on an i.MX6Q thermal
> implementation and it seemed to work pretty well. =A0Thanks for adding
> this. =A0A couple of comments below.
Thanks for testing and reviewing the code.
>
> On Tue, Dec 13, 2011 at 9:13 AM, Amit Daniel Kachhap
> <amit.kachhap@linaro.org> wrote:
>> This patch adds support for generic cpu thermal cooling low level
>> implementations using frequency scaling and cpuhotplugg currently.
>> Different cpu related cooling devices can be registered by the
>> user and the binding of these cooling devices to the corresponding
>> trip points can be easily done as the registration API's return the
>> cooling device pointer.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> ---
>> =A0Documentation/thermal/cpu-cooling-api.txt | =A0 52 +++++
>> =A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +
>> =A0drivers/thermal/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 +
>> =A0drivers/thermal/cpu_cooling.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0302 ++++++=
+++++++++++++++++++++++
>> =A0include/linux/cpu_cooling.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 45 +++++
>> =A05 files changed, 411 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/thermal/cpu-cooling-api.txt
>> =A0create mode 100644 drivers/thermal/cpu_cooling.c
>> =A0create mode 100644 include/linux/cpu_cooling.h
>>
>> diff --git a/Documentation/thermal/cpu-cooling-api.txt b/Documentation/t=
hermal/cpu-cooling-api.txt
>> new file mode 100644
>> index 0000000..d30b4f2
>> --- /dev/null
>> +++ b/Documentation/thermal/cpu-cooling-api.txt
>> @@ -0,0 +1,52 @@
>> +CPU cooling api's How To
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Written by Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> +
>> +Updated: 13 Dec 2011
>> +
>> +Copyright (c) =A02011 Samsung Electronics Co., Ltd(http://www.samsung.c=
om)
>> +
>> +0. Introduction
>> +
>> +The generic cpu cooling(freq clipping, cpuhotplug) provides
>> +registration/unregistration api's to the user. The binding of the cooli=
ng
>> +devices to the trip types is left for the user. The registration api's =
returns
>> +the cooling device pointer.
>> +
>> +1. cpufreq cooling api's
>> +
>> +1.1 cpufreq registration api's
>> +1.1.1 struct thermal_cooling_device *cpufreq_cooling_register(
>> + =A0 =A0 =A0 struct freq_pctg_table *tab_ptr, unsigned int tab_size,
>> + =A0 =A0 =A0 const struct cpumask *mask_val)
>> +
>> + =A0 =A0This interface function registers the cpufreq cooling device wi=
th the name
>> + =A0 =A0 =A0 "thermal-cpufreq".
>> +
>> + =A0 =A0tab_ptr: The table containing the percentage of frequency to be=
 clipped for
>> + =A0 =A0each cooling state.
>> + =A0 =A0 =A0 .freq_clip_pctg[NR_CPUS]:Percentage of frequency to be cli=
pped for each
>> + =A0 =A0 =A0 =A0cpu.
>> + =A0 =A0 =A0 .polling_interval: polling interval for this cooling state.
>> + =A0 =A0tab_size: the total number of cooling state.
>> + =A0 =A0mask_val: all the allowed cpu's where frequency clipping can ha=
ppen.
>> +
>> +1.1.2 void cpufreq_cooling_unregister(void)
>> +
>> + =A0 =A0This interface function unregisters the "thermal-cpufreq" cooli=
ng device.
>> +
>> +
>> +1.2 cpuhotplug registration api's
>> +
>> +1.2.1 struct thermal_cooling_device *cpuhotplug_cooling_register(
>> + =A0 =A0 =A0 const struct cpumask *mask_val)
>> +
>> + =A0 =A0This interface function registers the cpuhotplug cooling device=
 with the name
>> + =A0 =A0 =A0 "thermal-cpuhotplug".
>> +
>> + =A0 =A0mask_val: all the allowed cpu's which can be hotplugged out.
>> +
>> +1.1.2 void cpuhotplug_cooling_unregister(void)
>> +
>> + =A0 =A0This interface function unregisters the "thermal-cpuhotplug" co=
oling device.
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index f7f71b2..298c1cd 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -18,3 +18,14 @@ config THERMAL_HWMON
>> =A0 =A0 =A0 =A0depends on THERMAL
>> =A0 =A0 =A0 =A0depends on HWMON=3Dy || HWMON=3DTHERMAL
>> =A0 =A0 =A0 =A0default y
>> +
>> +config CPU_THERMAL
>> + =A0 =A0 =A0 bool "generic cpu cooling support"
>> + =A0 =A0 =A0 depends on THERMAL
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 This implements the generic cpu cooling mechanism thro=
ugh frequency
>> + =A0 =A0 =A0 =A0 reduction, cpu hotplug and any other ways of reducing =
temperature. An
>> + =A0 =A0 =A0 =A0 ACPI version of this already exists(drivers/acpi/proce=
ssor_thermal.c).
>> + =A0 =A0 =A0 =A0 This will be useful for platforms using the generic th=
ermal interface
>> + =A0 =A0 =A0 =A0 and not the ACPI interface.
>> + =A0 =A0 =A0 =A0 If you want this support, you should say Y or M here.
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 31108a0..655cbc4 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -3,3 +3,4 @@
>> =A0#
>>
>> =A0obj-$(CONFIG_THERMAL) =A0 =A0 =A0 =A0 =A0+=3D thermal_sys.o
>> +obj-$(CONFIG_CPU_THERMAL) =A0 =A0 =A0+=3D cpu_cooling.o
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling=
.c
>> new file mode 100644
>> index 0000000..cdd148c
>> --- /dev/null
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -0,0 +1,302 @@
>> +/*
>> + * =A0linux/drivers/thermal/cpu_cooling.c
>> + *
>> + * =A0Copyright (C) 2011 Samsung Electronics Co., Ltd(http://www.samsun=
g.com)
>> + * =A0Copyright (C) 2011 =A0Amit Daniel <amit.kachhap@linaro.org>
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
>> + * =A0This program is free software; you can redistribute it and/or mod=
ify
>> + * =A0it under the terms of the GNU General Public License as published=
 by
>> + * =A0the Free Software Foundation; version 2 of the License.
>> + *
>> + * =A0This program is distributed in the hope that it will be useful, b=
ut
>> + * =A0WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the G=
NU
>> + * =A0General Public License for more details.
>> + *
>> + * =A0You should have received a copy of the GNU General Public License=
 along
>> + * =A0with this program; if not, write to the Free Software Foundation,=
 Inc.,
>> + * =A059 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
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
>> +#ifdef CONFIG_CPU_FREQ
>> +struct cpufreq_cooling_device {
>> + =A0 =A0 =A0 struct thermal_cooling_device *cool_dev;
>> + =A0 =A0 =A0 struct freq_pctg_table *tab_ptr;
>> + =A0 =A0 =A0 unsigned int tab_size;
>> + =A0 =A0 =A0 unsigned int cpufreq_state;
>> + =A0 =A0 =A0 const struct cpumask *allowed_cpus;
>> +};
>> +
>> +static struct cpufreq_cooling_device *cpufreq_device;
>> +
>> +/*Below codes defines functions to be used for cpufreq as cooling devic=
e*/
>> +static bool is_cpufreq_valid(int cpu)
>> +{
>> + =A0 =A0 =A0 struct cpufreq_policy policy;
>> + =A0 =A0 =A0 if (!cpufreq_get_policy(&policy, cpu))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
>> + =A0 =A0 =A0 return false;
>> +}
>> +
>> +static int cpufreq_apply_cooling(int cooling_state)
>> +{
>> + =A0 =A0 =A0 int cpuid, this_cpu =3D smp_processor_id();
>> +
>> + =A0 =A0 =A0 if (!is_cpufreq_valid(this_cpu))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 =A0 if (cooling_state > cpufreq_device->tab_size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 =A0 /*Check if last cooling level is same as current cooling l=
evel*/
>> + =A0 =A0 =A0 if (cpufreq_device->cpufreq_state =3D=3D cooling_state)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 =A0 cpufreq_device->cpufreq_state =3D cooling_state;
>> +
>> + =A0 =A0 =A0 for_each_cpu(cpuid, cpufreq_device->allowed_cpus) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (is_cpufreq_valid(cpuid))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_update_policy(cpui=
d);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int thermal_cpufreq_notifier(struct notifier_block *nb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 unsigned long event, void *data)
>> +{
>> + =A0 =A0 =A0 struct cpufreq_policy *policy =3D data;
>> + =A0 =A0 =A0 struct freq_pctg_table *th_table;
>> + =A0 =A0 =A0 unsigned long max_freq =3D 0;
>> + =A0 =A0 =A0 unsigned int cpu =3D policy->cpu, th_pctg =3D 0, level;
>> +
>> + =A0 =A0 =A0 if (event !=3D CPUFREQ_ADJUST)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 =A0 level =3D cpufreq_device->cpufreq_state;
>> +
>> + =A0 =A0 =A0 if (level > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 th_table =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &(cpufreq_device->tab_ptr[=
level - 1]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 th_pctg =3D th_table->freq_clip_pctg[cpu];
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 max_freq =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (policy->cpuinfo.max_freq * (100 - th_pctg=
)) / 100;
>> +
>> + =A0 =A0 =A0 cpufreq_verify_within_limits(policy, 0, max_freq);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * cpufreq cooling device callback functions
>> + */
>> +static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigne=
d long *state)
>> +{
>> + =A0 =A0 =A0 *state =3D cpufreq_device->tab_size;
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigne=
d long *state)
>> +{
>> + =A0 =A0 =A0 *state =3D cpufreq_device->cpufreq_state;
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +/*This cooling may be as PASSIVE/STATE_ACTIVE type*/
>> +static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigne=
d long state)
>> +{
>> + =A0 =A0 =A0 cpufreq_apply_cooling(state);
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +/* bind cpufreq callbacks to cpufreq cooling device */
>> +static struct thermal_cooling_device_ops cpufreq_cooling_ops =3D {
>> + =A0 =A0 =A0 .get_max_state =3D cpufreq_get_max_state,
>> + =A0 =A0 =A0 .get_cur_state =3D cpufreq_get_cur_state,
>> + =A0 =A0 =A0 .set_cur_state =3D cpufreq_set_cur_state,
>> +};
>> +
>> +static struct notifier_block thermal_cpufreq_notifier_block =3D {
>> + =A0 =A0 =A0 .notifier_call =3D thermal_cpufreq_notifier,
>> +};
>> +
>> +struct thermal_cooling_device *cpufreq_cooling_register(
>> + =A0 =A0 =A0 struct freq_pctg_table *tab_ptr, unsigned int tab_size,
>> + =A0 =A0 =A0 const struct cpumask *mask_val)
>> +{
>> + =A0 =A0 =A0 struct thermal_cooling_device *cool_dev;
>> +
>> + =A0 =A0 =A0 if (tab_ptr =3D=3D NULL || tab_size =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
>> +
>> + =A0 =A0 =A0 cpufreq_device =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kzalloc(sizeof(struct cpufreq_cooling_devi=
ce), GFP_KERNEL);
>> +
>> + =A0 =A0 =A0 if (!cpufreq_device)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);
>> +
>> + =A0 =A0 =A0 cool_dev =3D thermal_cooling_device_register("thermal-cpuf=
req", NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 &cpufreq_cooling_ops);
>> + =A0 =A0 =A0 if (!cool_dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_device);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 cpufreq_device->tab_ptr =3D tab_ptr;
>> + =A0 =A0 =A0 cpufreq_device->tab_size =3D tab_size;
>> + =A0 =A0 =A0 cpufreq_device->cool_dev =3D cool_dev;
>> + =A0 =A0 =A0 cpufreq_device->allowed_cpus =3D mask_val;
>> +
>> + =A0 =A0 =A0 cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 CPUFREQ_POLICY_NOTIFIER);
>> + =A0 =A0 =A0 return cool_dev;
>> +}
>> +EXPORT_SYMBOL(cpufreq_cooling_register);
>> +
>> +void cpufreq_cooling_unregister(void)
>> +{
>> + =A0 =A0 =A0 cpufreq_unregister_notifier(&thermal_cpufreq_notifier_bloc=
k,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 CPUFREQ_POLICY_NOTIFIER);
>> + =A0 =A0 =A0 thermal_cooling_device_unregister(cpufreq_device->cool_dev=
);
>> + =A0 =A0 =A0 kfree(cpufreq_device);
>> +}
>> +EXPORT_SYMBOL(cpufreq_cooling_unregister);
>> +#else /*!CONFIG_CPU_FREQ*/
>> +struct thermal_cooling_device *cpufreq_cooling_register(
>> + =A0 =A0 =A0 struct freq_pctg_table *tab_ptr, unsigned int tab_size)
>
> Need to add the "const struct cpumask *mask_val" parameter
> to this function like it's used above and prototyped in the heard
> or else it causes a build error when building
> without CONFIG_CPU_FREQ defined.
Yes sure somehow missed adding this. Thanks for pointing this out.
>
>> +{
>> + =A0 =A0 =A0 return NULL;
>> +}
>> +EXPORT_SYMBOL(cpufreq_cooling_register);
>> +void cpufreq_cooling_unregister(void)
>> +{
>> + =A0 =A0 =A0 return;
>> +}
>> +EXPORT_SYMBOL(cpufreq_cooling_unregister);
>> +#endif /*CONFIG_CPU_FREQ*/
>> +
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +
>> +struct hotplug_cooling_device {
>> + =A0 =A0 =A0 struct thermal_cooling_device *cool_dev;
>> + =A0 =A0 =A0 unsigned int hotplug_state;
>> + =A0 =A0 =A0 const struct cpumask *allowed_cpus;
>> +};
>> +static struct hotplug_cooling_device *hotplug_device;
>> +
>> +/*
>> + * cpu hotplug cooling device callback functions
>> + */
>> +static int cpuhotplug_get_max_state(struct thermal_cooling_device *cdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigne=
d long *state)
>> +{
>> + =A0 =A0 =A0 *state =3D 1;
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int cpuhotplug_get_cur_state(struct thermal_cooling_device *cdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigne=
d long *state)
>> +{
>> + =A0 =A0 =A0 /*This cooling device may be of type ACTIVE, so state field
>> + =A0 =A0 =A0 can be 0 or 1*/
>> + =A0 =A0 =A0 *state =3D hotplug_device->hotplug_state;
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +/*This cooling may be as PASSIVE/STATE_ACTIVE type*/
>> +static int cpuhotplug_set_cur_state(struct thermal_cooling_device *cdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigne=
d long state)
>> +{
>> + =A0 =A0 =A0 int cpuid, this_cpu =3D smp_processor_id();
>> +
>> + =A0 =A0 =A0 if (hotplug_device->hotplug_state =3D=3D state)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 =A0 /*This cooling device may be of type ACTIVE, so state field
>> + =A0 =A0 =A0 can be 0 or 1*/
>> + =A0 =A0 =A0 if (state =3D=3D 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_cpu(cpuid, hotplug_device->allowe=
d_cpus) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_online(cpuid) && (=
cpuid !=3D this_cpu))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_down(c=
puid);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 } else if (state =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_cpu(cpuid, hotplug_device->allowe=
d_cpus) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cpu_online(cpuid) && =
(cpuid !=3D this_cpu))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_up(cpu=
id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>
> I don't like how ACTIVE does not have available notification callbacks
> like HOT and CRITICAL do. =A0Perhaps I fail to grasp why they aren't there
> but besides just applying a cooling device, one might want to do something
> else as well upon hitting these trip points. =A0So that said, it might be=
 nice
> to add a notification to STATE_ACTIVE as well.
Well I added ACTIVE_STATE trip type as just some additional features
over trip type ACTIVE. Also each thermal zone can have more then one
trip types so HOT notifications can still be used. But I like your
suggestion of putting notfications in all the trip types. Lets see if
the maintainers agree to this idea.
>
>> + =A0 =A0 =A0 hotplug_device->hotplug_state =3D state;
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +/* bind hotplug callbacks to cpu hotplug cooling device */
>> +static struct thermal_cooling_device_ops cpuhotplug_cooling_ops =3D {
>> + =A0 =A0 =A0 .get_max_state =3D cpuhotplug_get_max_state,
>> + =A0 =A0 =A0 .get_cur_state =3D cpuhotplug_get_cur_state,
>> + =A0 =A0 =A0 .set_cur_state =3D cpuhotplug_set_cur_state,
>> +};
>> +
>> +struct thermal_cooling_device *cpuhotplug_cooling_register(
>> + =A0 =A0 =A0 const struct cpumask *mask_val)
>> +{
>> + =A0 =A0 =A0 struct thermal_cooling_device *cool_dev;
>> +
>> + =A0 =A0 =A0 hotplug_device =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kzalloc(sizeof(struct hotplug_cooling_devi=
ce), GFP_KERNEL);
>> +
>> + =A0 =A0 =A0 if (!hotplug_device)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);
>> +
>> + =A0 =A0 =A0 cool_dev =3D thermal_cooling_device_register("thermal-cpuh=
otplug", NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 &cpuhotplug_cooling_ops);
>> + =A0 =A0 =A0 if (!cool_dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(hotplug_device);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 hotplug_device->cool_dev =3D cool_dev;
>> + =A0 =A0 =A0 hotplug_device->hotplug_state =3D 0;
>> + =A0 =A0 =A0 hotplug_device->allowed_cpus =3D mask_val;
>> +
>> + =A0 =A0 =A0 return cool_dev;
>> +}
>> +EXPORT_SYMBOL(cpuhotplug_cooling_register);
>> +
>> +void cpuhotplug_cooling_unregister(void)
>> +{
>> + =A0 =A0 =A0 thermal_cooling_device_unregister(hotplug_device->cool_dev=
);
>> + =A0 =A0 =A0 kfree(hotplug_device);
>> +}
>> +EXPORT_SYMBOL(cpuhotplug_cooling_unregister);
>> +#else /*!CONFIG_HOTPLUG_CPU*/
>> +struct thermal_cooling_device *cpuhotplug_cooling_register(
>> + =A0 =A0 =A0 const struct cpumask *mask_val)
>> +{
>> + =A0 =A0 =A0 return NULL;
>> +}
>> +EXPORT_SYMBOL(cpuhotplug_cooling_register);
>> +void cpuhotplug_cooling_unregister(void)
>> +{
>> + =A0 =A0 =A0 return;
>> +}
>> +EXPORT_SYMBOL(cpuhotplug_cooling_unregister);
>> +#endif /*CONFIG_HOTPLUG_CPU*/
>> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
>> new file mode 100644
>> index 0000000..0c57375
>> --- /dev/null
>> +++ b/include/linux/cpu_cooling.h
>> @@ -0,0 +1,45 @@
>> +/*
>> + * =A0linux/include/linux/cpu_cooling.h
>> + *
>> + * =A0Copyright (C) 2011 Samsung Electronics Co., Ltd(http://www.samsun=
g.com)
>> + * =A0Copyright (C) 2011 =A0Amit Daniel <amit.kachhap@linaro.org>
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
>> + * =A0This program is free software; you can redistribute it and/or mod=
ify
>> + * =A0it under the terms of the GNU General Public License as published=
 by
>> + * =A0the Free Software Foundation; version 2 of the License.
>> + *
>> + * =A0This program is distributed in the hope that it will be useful, b=
ut
>> + * =A0WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the G=
NU
>> + * =A0General Public License for more details.
>> + *
>> + * =A0You should have received a copy of the GNU General Public License=
 along
>> + * =A0with this program; if not, write to the Free Software Foundation,=
 Inc.,
>> + * =A059 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
>> + */
>> +
>> +#ifndef __CPU_COOLING_H__
>> +#define __CPU_COOLING_H__
>> +
>> +#include <linux/thermal.h>
>> +
>> +struct freq_pctg_table {
>> + =A0 =A0 =A0 unsigned int freq_clip_pctg[NR_CPUS];
>> + =A0 =A0 =A0 unsigned int polling_interval;
>> +};
>> +
>> +extern struct thermal_cooling_device *cpufreq_cooling_register(
>> + =A0 =A0 =A0 struct freq_pctg_table *tab_ptr, unsigned int tab_size,
>> + =A0 =A0 =A0 const struct cpumask *mask_val);
>> +
>> +extern void cpufreq_cooling_unregister(void);
>> +
>> +extern struct thermal_cooling_device *cpuhotplug_cooling_register(
>> + =A0 =A0 =A0 const struct cpumask *mask_val);
>> +
>> +extern void cpuhotplug_cooling_unregister(void);
>> +
>> +#endif /* __CPU_COOLING_H__ */
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at =A0http://www.tux.org/lkml/
