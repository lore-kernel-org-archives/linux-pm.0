From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [PATCH 2/4] thermal: Add generic cpufreq cooling implementation
Date: Mon, 27 Feb 2012 10:02:41 +0530
Message-ID: <CAK44p225KyQPUCfZuYamPDHFL+do-T819vviq+Z7UwHqj9JJfA@mail.gmail.com>
References: <1329905650-30161-1-git-send-email-amit.kachhap@linaro.org>
	<1329905650-30161-3-git-send-email-amit.kachhap@linaro.org>
	<4D68720C2E767A4AA6A8796D42C8EB590442F2@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB590442F2@BGSMSX101.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "rob.lee@linaro.org" <rob.lee@linaro.org>, "patches@linaro.org" <patches@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Durgadoss,

Thanks for the detailed review comments.

On 24 February 2012 16:34, R, Durgadoss <durgadoss.r@intel.com> wrote:
> Hi Amit,
>
>> -----Original Message-----
>> From: amit kachhap [mailto:amitdanielk@gmail.com] On Behalf Of Amit =
Daniel
>> Kachhap
>> Sent: Wednesday, February 22, 2012 3:44 PM
>> To: linux-pm@lists.linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org; mjg59@srcf.ucam.org; linux-
>> acpi@vger.kernel.org; lenb@kernel.org; linaro-dev@lists.linaro.org;
>> amit.kachhap@linaro.org; R, Durgadoss; rob.lee@linaro.org; patches@l=
inaro.org
>> Subject: [PATCH 2/4] thermal: Add generic cpufreq cooling implementa=
tion
>>
>> This patch adds support for generic cpu thermal cooling low level
>> implementations using frequency scaling up/down based on the request
>> from user. Different cpu related cooling devices can be registered b=
y the
>
> I believe what you mean by 'user' is another Driver using this code..=
 right ??
Yes.
>
>> user and the binding of these cooling devices to the corresponding
>> trip points can be easily done as the registration API's return the
>> cooling device pointer. The user of these api's are responsible for
>> passing clipping frequency in percentages.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> ---
>> =A0Documentation/thermal/cpu-cooling-api.txt | =A0 40 ++++
>> =A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 11 +
>> =A0drivers/thermal/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 +
>> =A0drivers/thermal/cpu_cooling.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0310 ++=
+++++++++++++++++++++++++++
>> =A0include/linux/cpu_cooling.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 54 =
+++++
>> =A05 files changed, 416 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/thermal/cpu-cooling-api.txt
>> =A0create mode 100644 drivers/thermal/cpu_cooling.c
>> =A0create mode 100644 include/linux/cpu_cooling.h
>>
>> diff --git a/Documentation/thermal/cpu-cooling-api.txt
>> b/Documentation/thermal/cpu-cooling-api.txt
>> new file mode 100644
>> index 0000000..04de67c
>> --- /dev/null
>> +++ b/Documentation/thermal/cpu-cooling-api.txt
>> @@ -0,0 +1,40 @@
>> +CPU cooling api's How To
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Written by Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> +
>> +Updated: 13 Dec 2011
>> +
>> +Copyright (c) =A02011 Samsung Electronics Co., Ltd(http://www.samsu=
ng.com)
>> +
>> +0. Introduction
>> +
>> +The generic cpu cooling(freq clipping, cpuhotplug) provides
>> +registration/unregistration api's to the user. The binding of the c=
ooling
>> +devices to the trip point is left for the user. The registration ap=
i's returns
>> +the cooling device pointer.
>> +
>> +1. cpufreq cooling api's
>> +
>> +1.1 cpufreq registration api's
>> +1.1.1 struct thermal_cooling_device *cpufreq_cooling_register(
>> + =A0 =A0 struct freq_pctg_table *tab_ptr, unsigned int tab_size,
>> + =A0 =A0 const struct cpumask *mask_val)
>> +
>> + =A0 =A0This interface function registers the cpufreq cooling devic=
e with the name
>> + =A0 =A0"thermal-cpufreq-%x". This api can support multiple instanc=
e of cpufreq
>> cooling
>> + =A0 =A0devices.
>> +
>> + =A0 =A0tab_ptr: The table containing the percentage of frequency t=
o be clipped
>> for
>> + =A0 =A0each cooling state.
>> + =A0 =A0 .freq_clip_pctg: Percentage of frequency to be clipped for=
 each allowed
>> + =A0 =A0 =A0cpus.
>> + =A0 =A0 .polling_interval: polling interval for this cooling state=
=2E
>> + =A0 =A0tab_size: the total number of cooling state.
>
> Although I can understand that the table size is equal to
> the total number of cooling states, it is better to name it 'num_cool=
ing_states'
> (or something) that means what it is..
Yes your idea makes more sense. Will accept it in the next version.
>
>> + =A0 =A0mask_val: all the allowed cpu's where frequency clipping ca=
n happen.
>> +
>> +1.1.2 void cpufreq_cooling_unregister(struct thermal_cooling_device=
 *cdev)
>> +
>> + =A0 =A0This interface function unregisters the "thermal-cpufreq-%x=
" cooling
>> device.
>> +
>> + =A0 =A0cdev: Cooling device pointer which has to be unregistered.
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index f7f71b2..298c1cd 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -18,3 +18,14 @@ config THERMAL_HWMON
>> =A0 =A0 =A0 depends on THERMAL
>> =A0 =A0 =A0 depends on HWMON=3Dy || HWMON=3DTHERMAL
>> =A0 =A0 =A0 default y
>> +
>> +config CPU_THERMAL
>> + =A0 =A0 bool "generic cpu cooling support"
>> + =A0 =A0 depends on THERMAL
>> + =A0 =A0 help
>> + =A0 =A0 =A0 This implements the generic cpu cooling mechanism thro=
ugh frequency
>> + =A0 =A0 =A0 reduction, cpu hotplug and any other ways of reducing =
temperature. An
>> + =A0 =A0 =A0 ACPI version of this already exists(drivers/acpi/proce=
ssor_thermal.c).
>> + =A0 =A0 =A0 This will be useful for platforms using the generic th=
ermal interface
>> + =A0 =A0 =A0 and not the ACPI interface.
>> + =A0 =A0 =A0 If you want this support, you should say Y or M here.
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 31108a0..655cbc4 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -3,3 +3,4 @@
>> =A0#
>>
>> =A0obj-$(CONFIG_THERMAL) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D thermal=
_sys.o
>> +obj-$(CONFIG_CPU_THERMAL) =A0 =A0+=3D cpu_cooling.o
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_coo=
ling.c
>> new file mode 100644
>> index 0000000..298f550
>> --- /dev/null
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -0,0 +1,310 @@
>> +/*
>> + * =A0linux/drivers/thermal/cpu_cooling.c
>> + *
>> + * =A0Copyright (C) 2011 =A0 =A0 =A0 Samsung Electronics Co., Ltd(h=
ttp://www.samsung.com)
>> + * =A0Copyright (C) 2011 =A0Amit Daniel <amit.kachhap@linaro.org>
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
>> +#ifdef CONFIG_CPU_FREQ
>
> Except the _idr methods, all the code is inside this #ifdef.
> So, I think it is better to add this dependency in Kconfig,
> and leave this code clean w/o many #ifdef's.
ok
>
>> +struct cpufreq_cooling_device {
>> + =A0 =A0 int id;
>> + =A0 =A0 struct thermal_cooling_device *cool_dev;
>> + =A0 =A0 struct freq_pctg_table *tab_ptr;
>> + =A0 =A0 unsigned int tab_size;
>> + =A0 =A0 unsigned int cpufreq_state;
>> + =A0 =A0 const struct cpumask *allowed_cpus;
>> + =A0 =A0 struct list_head node;
>> +};
>> +
>> +static LIST_HEAD(cooling_cpufreq_list);
>> +static DEFINE_MUTEX(cooling_cpufreq_lock);
>> +static DEFINE_IDR(cpufreq_idr);
>> +static struct cpufreq_cooling_device *notify_cpufreq;
>
> Please move this after the DEFINE_PER_CPU.
> Hard to notice here..
ok
>
>> +static DEFINE_PER_CPU(unsigned int, max_policy_freq);
>> +#endif /*CONFIG_CPU_FREQ*/
>> +
>> +static int get_idr(struct idr *idr, struct mutex *lock, int *id)
>> +{
>> + =A0 =A0 int err;
>> +again:
>> + =A0 =A0 if (unlikely(idr_pre_get(idr, GFP_KERNEL) =3D=3D 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 if (lock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(lock);
>> + =A0 =A0 err =3D idr_get_new(idr, NULL, id);
>> + =A0 =A0 if (lock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(lock);
>> + =A0 =A0 if (unlikely(err =3D=3D -EAGAIN))
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto again;
>> + =A0 =A0 else if (unlikely(err))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> +
>> + =A0 =A0 *id =3D *id & MAX_ID_MASK;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void release_idr(struct idr *idr, struct mutex *lock, int id=
)
>> +{
>> + =A0 =A0 if (lock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(lock);
>> + =A0 =A0 idr_remove(idr, id);
>> + =A0 =A0 if (lock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(lock);
>> +}
>> +
>> +#ifdef CONFIG_CPU_FREQ
>> +/*Below codes defines functions to be used for cpufreq as cooling d=
evice*/
>> +static bool is_cpufreq_valid(int cpu)
>> +{
>> + =A0 =A0 struct cpufreq_policy policy;
>> + =A0 =A0 if (!cpufreq_get_policy(&policy, cpu))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return true;
>> + =A0 =A0 return false;
>
> Why not just do a return !cpufreq_get_policy(&policy, cpu);
ok
>
>> +}
>> +
>> +static int cpufreq_apply_cooling(struct cpufreq_cooling_device
>> *cpufreq_device,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned l=
ong cooling_state)
>> +{
>> + =A0 =A0 int cpuid, this_cpu =3D smp_processor_id();
>> +
>> + =A0 =A0 if (!is_cpufreq_valid(this_cpu))
>
> You are not using this_cpu anywhere else..so, directly use
> Smp_processor_id() here..
>
Ok agreed.
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 if (cooling_state > cpufreq_device->tab_size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /*Check if last cooling level is same as current cooling l=
evel*/
>
> Use either 'state' or 'level' in comments as well as the variable nam=
e
> Makes it easy to read..

Ok, will use state.
>
>> + =A0 =A0 if (cpufreq_device->cpufreq_state =3D=3D cooling_state)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 cpufreq_device->cpufreq_state =3D cooling_state;
>> +
>> + =A0 =A0 /*cpufreq thermal notifier uses this cpufreq device pointe=
r*/
>> + =A0 =A0 notify_cpufreq =3D cpufreq_device;
>> +
>> + =A0 =A0 for_each_cpu(cpuid, cpufreq_device->allowed_cpus) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (is_cpufreq_valid(cpuid))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_update_policy(cpui=
d);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int thermal_cpufreq_notifier(struct notifier_block *nb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 unsigned long event, void *data)
>> +{
>> + =A0 =A0 struct cpufreq_policy *policy =3D data;
>> + =A0 =A0 struct freq_pctg_table *th_table;
>> + =A0 =A0 unsigned long max_freq =3D 0;
>> + =A0 =A0 unsigned int th_pctg =3D 0, level;
>> +
>> + =A0 =A0 if (event !=3D CPUFREQ_ADJUST)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 if (!notify_cpufreq)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> Why not combine both if's with an || ?
Ok
>
>> +
>> + =A0 =A0 level =3D notify_cpufreq->cpufreq_state;
>
> Yes..here it is..please use level/state..
Ok, will use  state
>
>> +
>> + =A0 =A0 if (level > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 th_table =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &(notify_cpufreq->tab_ptr[=
level - 1]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 th_pctg =3D th_table->freq_clip_pctg;
>> + =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 (policy->cpuinfo.max_freq * (100 - th_pctg=
)) / 100;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (per_cpu(max_policy_freq, policy->cpu) =
=3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_cpu(max_policy_freq, p=
olicy->cpu) =3D policy->max;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (per_cpu(max_policy_freq, policy->cpu) =
!=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D per_cpu(max_p=
olicy_freq, policy->cpu);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_cpu(max_policy_freq, p=
olicy->cpu) =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D policy->max;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 cpufreq_verify_within_limits(policy, 0, max_freq);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * cpufreq cooling device callback functions
>> + */
>> +static int cpufreq_get_max_state(struct thermal_cooling_device *cde=
v,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigne=
d long *state)
>> +{
>> + =A0 =A0 struct cpufreq_cooling_device *cpufreq_device =3D NULL;
>
> Why assigning NULL ?
yes it is not needed.
>
>> +
>> + =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 list_for_each_entry(cpufreq_device, &cooling_cpufreq_list,=
 node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_device && cpufreq_device->cool=
_dev =3D=3D cdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> + =A0 =A0 if (!cpufreq_device || cpufreq_device->cool_dev !=3D cdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 *state =3D cpufreq_device->tab_size;
>> + =A0 =A0 return 0;
>> +}
>
> The above can be simplified this way:
> =A0 =A0 =A0 =A0int ret =3D -EINVAL;
> =A0 =A0 =A0 =A0mutex_lock(&cooling_cpufreq_lock);
> =A0 =A0 =A0 =A0list_for_each_entry(cpufreq_device, &cooling_cpufreq_l=
ist, node)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cpufreq_device->cool_dev =3D=3D cd=
ev) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*state =3D cpufreq_dev=
ice->tab_size;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0mutex_unlock(&cooling_cpufreq_lock);
> =A0 =A0 =A0 =A0return ret;
>
> I think the same can be done for the get_ function below..and similar=
 ones
> in the patch 3/4.

Ok accepted.
>
>> +
>> +static int cpufreq_get_cur_state(struct thermal_cooling_device *cde=
v,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigne=
d long *state)
>> +{
>> + =A0 =A0 struct cpufreq_cooling_device *cpufreq_device =3D NULL;
>> +
>> + =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 list_for_each_entry(cpufreq_device, &cooling_cpufreq_list,=
 node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_device && cpufreq_device->cool=
_dev =3D=3D cdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> + =A0 =A0 if (!cpufreq_device || cpufreq_device->cool_dev !=3D cdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 *state =3D cpufreq_device->cpufreq_state;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*This cooling may be as PASSIVE/ACTIVE type*/
>> +static int cpufreq_set_cur_state(struct thermal_cooling_device *cde=
v,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigne=
d long state)
>> +{
>> + =A0 =A0 struct cpufreq_cooling_device *cpufreq_device =3D NULL;
>> +
>> + =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 list_for_each_entry(cpufreq_device, &cooling_cpufreq_list,=
 node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_device && cpufreq_device->cool=
_dev =3D=3D cdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> + =A0 =A0 if (!cpufreq_device || cpufreq_device->cool_dev !=3D cdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 cpufreq_apply_cooling(cpufreq_device, state);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/* bind cpufreq callbacks to cpufreq cooling device */
>> +static struct thermal_cooling_device_ops cpufreq_cooling_ops =3D {
>> + =A0 =A0 .get_max_state =3D cpufreq_get_max_state,
>> + =A0 =A0 .get_cur_state =3D cpufreq_get_cur_state,
>> + =A0 =A0 .set_cur_state =3D cpufreq_set_cur_state,
>> +};
>> +
>> +static struct notifier_block thermal_cpufreq_notifier_block =3D {
>> + =A0 =A0 .notifier_call =3D thermal_cpufreq_notifier,
>> +};
>> +
>> +struct thermal_cooling_device *cpufreq_cooling_register(
>> + =A0 =A0 struct freq_pctg_table *tab_ptr, unsigned int tab_size,
>> + =A0 =A0 const struct cpumask *mask_val)
>> +{
>> + =A0 =A0 struct thermal_cooling_device *cool_dev;
>> + =A0 =A0 struct cpufreq_cooling_device *cpufreq_dev =3D NULL;
>> + =A0 =A0 unsigned int count =3D 0;
>> + =A0 =A0 char dev_name[THERMAL_NAME_LENGTH];
>> + =A0 =A0 int ret =3D 0, id =3D 0;
>> +
>> + =A0 =A0 if (tab_ptr =3D=3D NULL || tab_size =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
>> +
>> + =A0 =A0 list_for_each_entry(cpufreq_dev, &cooling_cpufreq_list, no=
de)
>> + =A0 =A0 =A0 =A0 =A0 =A0 count++;
>> +
>> + =A0 =A0 cpufreq_dev =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 kzalloc(sizeof(struct cpufreq_cooling_devi=
ce), GFP_KERNEL);
>> +
>> + =A0 =A0 if (!cpufreq_dev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);
>> +
>> + =A0 =A0 cpufreq_dev->tab_ptr =3D tab_ptr;
>> + =A0 =A0 cpufreq_dev->tab_size =3D tab_size;
>> + =A0 =A0 cpufreq_dev->allowed_cpus =3D mask_val;
>> +
>> + =A0 =A0 ret =3D get_idr(&cpufreq_idr, &cooling_cpufreq_lock, &cpuf=
req_dev->id);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 sprintf(dev_name, "thermal-cpufreq-%d", cpufreq_dev->id);
>> +
>> + =A0 =A0 cool_dev =3D thermal_cooling_device_register(dev_name, cpu=
freq_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 &cpufreq_cooling_ops);
>> + =A0 =A0 if (!cool_dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 release_idr(&cpufreq_idr, &cooling_cpufreq=
_lock,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 cpufreq_dev->id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
>> + =A0 =A0 }
>> + =A0 =A0 cpufreq_dev->id =3D id;
>> + =A0 =A0 cpufreq_dev->cool_dev =3D cool_dev;
>> + =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 list_add_tail(&cpufreq_dev->node, &cooling_cpufreq_list);
>> + =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> +
>> + =A0 =A0 if (count =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_register_notifier(&thermal_cpufreq=
_notifier_block,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 CPUFREQ_POLICY_NOTIFIER);
>
> Why do we register only when count is 0 ?
> Or should this be 'if (count > 0)' ?
Count represents the number of cpufreq type cooling devices. So for
the first call of this API ,  cpufreq_register_notifier is called.
Other call to cpufreq_cooling_register will use the same notifier. May
be using bool flag instead of count variable is better.
>
>> + =A0 =A0 return cool_dev;
>> +}
>> +EXPORT_SYMBOL(cpufreq_cooling_register);
>> +
>> +void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev=
)
>> +{
>> + =A0 =A0 struct cpufreq_cooling_device *cpufreq_dev =3D NULL;
>> + =A0 =A0 unsigned int count =3D 0;
>> +
>> + =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 list_for_each_entry(cpufreq_dev, &cooling_cpufreq_list, no=
de) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_dev && cpufreq_dev->cool_dev =3D=
=3D cdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 count++;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!cpufreq_dev || cpufreq_dev->cool_dev !=3D cdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 list_del(&cpufreq_dev->node);
>> + =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> +
>> + =A0 =A0 if (count =3D=3D 1)
>
> Same here..I do not get the idea behind this..
> Shouldn't this be 'if (count > 0)' ?
Same as above.
>
> In general,
> I would like to see a real driver using these API's. This will help
> everybody to understand the working of these API's much better.
Actually RFC version of the driver is already posted which uses these
api's. (https://lkml.org/lkml/2011/12/21/169). I forgot to add this
link in this patchset.
I will post the new version of the driver shortly.
>
> Thanks,
> Durga
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_unregister_notifier(&thermal_cpufr=
eq_notifier_block,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 CPUFREQ_POLICY_NOTIFIER);
>> +
>> + =A0 =A0 thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
>> + =A0 =A0 release_idr(&cpufreq_idr, &cooling_cpufreq_lock, cpufreq_d=
ev->id);
>> + =A0 =A0 kfree(cpufreq_dev);
>> +}
>> +EXPORT_SYMBOL(cpufreq_cooling_unregister);
>> +#endif /*CONFIG_CPU_FREQ*/
>> diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling=
=2Eh
>> new file mode 100644
>> index 0000000..5dc5632
>> --- /dev/null
>> +++ b/include/linux/cpu_cooling.h
>> @@ -0,0 +1,54 @@
>> +/*
>> + * =A0linux/include/linux/cpu_cooling.h
>> + *
>> + * =A0Copyright (C) 2011 =A0 =A0 =A0 Samsung Electronics Co., Ltd(h=
ttp://www.samsung.com)
>> + * =A0Copyright (C) 2011 =A0Amit Daniel <amit.kachhap@linaro.org>
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
>> +struct freq_pctg_table {
>> + =A0 =A0 unsigned int freq_clip_pctg;
>> + =A0 =A0 unsigned int polling_interval;
>> +};
>> +
>> +#ifdef CONFIG_CPU_FREQ
>> +struct thermal_cooling_device *cpufreq_cooling_register(
>> + =A0 =A0 struct freq_pctg_table *tab_ptr, unsigned int tab_size,
>> + =A0 =A0 const struct cpumask *mask_val);
>> +
>> +void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev=
);
>> +#else /*!CONFIG_CPU_FREQ*/
>> +static inline struct thermal_cooling_device *cpufreq_cooling_regist=
er(
>> + =A0 =A0 struct freq_pctg_table *tab_ptr, unsigned int tab_size,
>> + =A0 =A0 const struct cpumask *mask_val)
>> +{
>> + =A0 =A0 return NULL;
>> +}
>> +static inline void cpufreq_cooling_unregister(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct the=
rmal_cooling_device *cdev)
>> +{
>> + =A0 =A0 return;
>> +}
>> +#endif =A0 =A0 =A0 /*CONFIG_CPU_FREQ*/
>> +
>> +#endif /* __CPU_COOLING_H__ */
>> --
>> 1.7.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
