From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 2/2] Thermal: CPU Package temperature thermal
Date: Mon, 13 May 2013 15:30:40 -0400
Message-ID: <51913F60.6060405@ti.com>
References: <1367953065-2729-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1367953065-2729-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2HTKLKJGWUKUOWJPKJQEQ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51700 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885Ab3EMTbI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 May 2013 15:31:08 -0400
In-Reply-To: <1367953065-2729-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, tony.luck@intel.com, linux-edac@vger.kernel.org, eduardo.valentin@ti.com

------enig2HTKLKJGWUKUOWJPKJQEQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Srinivas,

On 07-05-2013 14:57, Srinivas Pandruvada wrote:
> This driver register CPU digital temperature sensor as a thermal
> zone at package level.
> Each package will show up as one zone with at max two trip points.
> These trip points can be both read and updated. Once a non zero
> value is set in the trip point, if the package package temperature
> goes above or below this setting, a thermal notification is
> generated.
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
> ---
>  drivers/thermal/Kconfig                |  12 +
>  drivers/thermal/Makefile               |   2 +-
>  drivers/thermal/x86_pkg_temp_thermal.c | 633 +++++++++++++++++++++++++=
++++++++
>  3 files changed, 646 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/thermal/x86_pkg_temp_thermal.c
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index a764f16..ed9b983 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -165,4 +165,16 @@ config INTEL_POWERCLAMP
>  	  enforce idle time which results in more package C-state residency. =
The
>  	  user interface is exposed via generic thermal framework.
> =20
> +config X86_PKG_TEMP_THERMAL
> +	tristate "X86 package temperature thermal driver"
> +	depends on THERMAL
> +	depends on X86
> +	select THERMAL_GOV_USER_SPACE

I understand based on you patch 0/2 description, that this is a combined
solution, with the userspace thermal daemon.

Do you know if there is any limitation by using this driver with
existing in-kernel governors?

> +	default m
> +	help
> +	  Enable this to register CPU digital sensor for package temperature =
as
> +	  thermal zone. Each package will have its own thermal zone. There ar=
e
> +	  two trip points which can be set by user to get notifications via t=
hermal
> +	  notification methods.
> +
>  endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index d3a2b38..fd137ce 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -21,4 +21,4 @@ obj-$(CONFIG_DOVE_THERMAL)  	+=3D dove_thermal.o
>  obj-$(CONFIG_DB8500_THERMAL)	+=3D db8500_thermal.o
>  obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+=3D db8500_cpufreq_cooling.o
>  obj-$(CONFIG_INTEL_POWERCLAMP)	+=3D intel_powerclamp.o
> -
> +obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+=3D x86_pkg_temp_thermal.o
> diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x=
86_pkg_temp_thermal.c
> new file mode 100644
> index 0000000..120ad39
> --- /dev/null
> +++ b/drivers/thermal/x86_pkg_temp_thermal.c
> @@ -0,0 +1,633 @@
> +/*
> + * x86_pkg_temp_thermal driver
> + * Copyright (c) 2013, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITH=
OUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License a=
long with
> + * this program; if not, write to the Free Software Foundation, Inc.
> + *
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/param.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/cpu.h>
> +#include <linux/smp.h>
> +#include <linux/slab.h>
> +#include <linux/pm.h>
> +#include <linux/thermal.h>
> +#include <asm/cpu_device_id.h>
> +#include <asm/mce.h>
> +#include <linux/debugfs.h>

nit: add first the includes starting with linux/, then those starting
with asm/.

> +
> +/*
> +* Rate control delay: Idea is to introduce denounce effect
> +* This should be long enough to avoid reduce events, when
> +* threshold is set to a temperature, which is constantly
> +* violated, but at the short enough to take any action.
> +* The action can be remove threshold or change it to next
> +* interesting setting. Based on experiments, in around
> +* every 5 seconds under load will give us a significant
> +* temperature change.
> +*/
> +#define PKG_TEMP_THERMAL_NOTIFY_DELAY	msecs_to_jiffies(5000)

Shouldnt this be configurable? I d suggest to leave to system integrator
to optimize this, based on the fact that his is a worst case estimation,
as stated above.

> +
> +/* Number of trip points in thermal zone */
> +#define MAX_NUMBER_OF_TRIPS	2
> +

ditto..

> +struct phy_dev_entry {
> +	struct list_head list;
> +	u16 phys_proc_id;
> +	u16 first_cpu;
> +	u32 tj_max;
> +	int ref_cnt;
> +	u32 start_pkg_therm_low;
> +	u32 start_pkg_therm_high;
> +	struct thermal_zone_device *tzone;
> +};
> +
> +/* List maintaining number of package instances */
> +static LIST_HEAD(phy_dev_list);
> +static DEFINE_MUTEX(phy_dev_list_mutex);
> +
> +/* Interrupt to work function schedule queue */
> +static DEFINE_PER_CPU(struct delayed_work, pkg_temp_thermal_threshold_=
work);
> +
> +/* To track if the work is already scheduled on a package */
> +static u8 *pkg_work_scheduled;
> +
> +/* Spin lock to prevent races with pkg_work_scheduled */
> +static spinlock_t pkg_work_lock;
> +static u16 max_phy_id;
> +
> +/* Thermal zone parameters */
> +static struct thermal_zone_params tz_params;
> +
> +/* Debug counters to show using debugfs */
> +static struct dentry *debugfs;
> +static unsigned int pkg_interrupt_cnt;
> +static unsigned int pkg_work_cnt;
> +
> +static int pkg_temp_debugfs_init(void)
> +{
> +	struct dentry *d;
> +
> +	debugfs =3D debugfs_create_dir("pkg_temp_thermal", NULL);
> +	if (!debugfs)
> +		return -ENOMEM;
> +
> +	d =3D debugfs_create_u32("pkg_thres_interrupt", S_IRUGO, debugfs,
> +				(u32 *)&pkg_interrupt_cnt);
> +	if (!d)
> +		goto err_out;
> +
> +	d =3D debugfs_create_u32("pkg_thres_work", S_IRUGO, debugfs,
> +				(u32 *)&pkg_work_cnt);
> +	if (!d)
> +		goto err_out;
> +
> +	return 0;
> +
> +err_out:
> +	debugfs_remove_recursive(debugfs);
> +	return -ENOMEM;

you may want to propagate the error code, no?

> +}
> +
> +static struct phy_dev_entry
> +			*pkg_temp_thermal_get_phy_entry(unsigned int cpu)
> +{
> +	u16 phys_proc_id =3D topology_physical_package_id(cpu);
> +	struct phy_dev_entry *phy_ptr;
> +
> +	mutex_lock(&phy_dev_list_mutex);
> +
> +	list_for_each_entry(phy_ptr, &phy_dev_list, list)
> +		if (phy_ptr->phys_proc_id =3D=3D phys_proc_id) {
> +			mutex_unlock(&phy_dev_list_mutex);
> +			return phy_ptr;
> +		}
> +
> +	mutex_unlock(&phy_dev_list_mutex);
> +
> +	return NULL;
> +}
> +
> +/*
> +* tj-max is is interesting because threshold is set relative to this
> +* temperature.
> +*/
> +static int get_tj_max(int cpu, u32 *tj_max)
> +{
> +	u32 eax, edx;
> +	u32 val;
> +	int err;
> +
> +	err =3D rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &eax, &ed=
x);
> +	if (err)
> +		goto err_ret;
> +	else {
> +		val =3D (eax >> 16) & 0xff;
> +		if (val)
> +			*tj_max =3D val * 1000;
> +		else
> +			goto err_ret;
> +	}
> +
> +	return 0;
> +err_ret:
> +	*tj_max =3D 0;

I believe it is safer just not to touch your return parameter in case of
failure.

> +	return -EINVAL;
> +}
> +
> +static int sys_get_curr_temp(struct thermal_zone_device *tzd, unsigned=
 long *temp)
> +{
> +	u32 eax, edx;
> +	struct phy_dev_entry *phy_dev_entry;
> +
> +	WARN_ON(tzd =3D=3D NULL);
> +	WARN_ON(tzd->devdata =3D=3D NULL);
> +

Can the above ever happen?

> +	phy_dev_entry =3D tzd->devdata;
> +	rdmsr_on_cpu(phy_dev_entry->first_cpu, MSR_IA32_PACKAGE_THERM_STATUS,=

> +			&eax, &edx);
> +	if (eax & 0x80000000) {
> +		*temp =3D phy_dev_entry->tj_max -
> +				((eax >> 16) & 0x7f) * 1000;
> +		pr_debug("sys_get_curr_temp %ld\n", *temp);
> +		return 0;
> +	}
> +
> +	return -EINVAL;

why invalid?

> +}
> +
> +static int sys_get_trip_temp(struct thermal_zone_device *tzd,
> +		int trip, unsigned long *temp)
> +{
> +	u32 eax, edx;
> +	struct phy_dev_entry *phy_dev_entry;
> +	u32 mask, shift;
> +	unsigned long thres_reg_value;
> +	int ret;
> +
> +	WARN_ON(tzd =3D=3D NULL);
> +	WARN_ON(tzd->devdata =3D=3D NULL);
> +

can the above ever happen?

> +	if (trip >=3D MAX_NUMBER_OF_TRIPS)
> +		return -EINVAL;
> +
> +	phy_dev_entry =3D tzd->devdata;
> +
> +	if (trip) {
> +		mask =3D THERM_MASK_THRESHOLD1;
> +		shift =3D THERM_SHIFT_THRESHOLD1;
> +	} else {
> +		mask =3D THERM_MASK_THRESHOLD0;
> +		shift =3D THERM_SHIFT_THRESHOLD0;
> +	}
> +
> +	ret =3D rdmsr_on_cpu(phy_dev_entry->first_cpu,
> +				MSR_IA32_PACKAGE_THERM_INTERRUPT, &eax, &edx);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	thres_reg_value =3D (eax & mask) >> shift;
> +	if (thres_reg_value)
> +		*temp =3D phy_dev_entry->tj_max - thres_reg_value * 1000;
> +	else
> +		*temp =3D 0;
> +	pr_debug("sys_get_trip_temp %ld\n", *temp);
> +
> +	return 0;
> +}
> +
> +int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
> +							unsigned long temp)
> +{
> +	u32 l, h;
> +	struct phy_dev_entry *phy_dev_entry;
> +	u32 mask, shift, intr;
> +	int ret;
> +
> +	WARN_ON(tzd =3D=3D NULL);
> +	WARN_ON(tzd->devdata =3D=3D NULL);
> +
> +	phy_dev_entry =3D tzd->devdata;
> +
> +	if (trip >=3D MAX_NUMBER_OF_TRIPS || temp >=3D phy_dev_entry->tj_max)=

> +		return -EINVAL;
> +
> +	mask =3D (trip =3D=3D 0) ? THERM_MASK_THRESHOLD0 : THERM_MASK_THRESHO=
LD1;
> +	shift =3D (trip =3D=3D 0) ? THERM_SHIFT_THRESHOLD0 : THERM_SHIFT_THRE=
SHOLD1;
> +	intr =3D (trip =3D=3D 0) ?
> +		THERM_INT_THRESHOLD0_ENABLE : THERM_INT_THRESHOLD0_ENABLE;
> +

Can the amount of trips ever increase in future? If yes, you might
consider a different approach for the above code.

> +	ret =3D rdmsr_on_cpu(phy_dev_entry->first_cpu,
> +					MSR_IA32_PACKAGE_THERM_INTERRUPT,
> +					&l, &h);
> +	if (ret < 0)
> +		return -EINVAL;
> +	l &=3D ~mask;
> +	/* Disable threshold interrupt for value =3D=3D 0 */

Better to document the above statement..

> +	if (!temp)
> +		l &=3D ~intr;
> +	else {
> +		l |=3D (phy_dev_entry->tj_max - temp)/1000 << shift;
> +		l |=3D intr;
> +	}
> +	ret =3D wrmsr_on_cpu(phy_dev_entry->first_cpu,
> +					MSR_IA32_PACKAGE_THERM_INTERRUPT,
> +					l, h);
> +
> +	return ret;

how about simply:
	return wrmsr_on_cpu(...
> +}
> +
> +static int sys_get_trip_type(struct thermal_zone_device *thermal,
> +		int trip, enum thermal_trip_type *type)
> +{
> +
> +	*type =3D THERMAL_TRIP_PASSIVE;
> +
> +	return 0;
> +}
> +
> +/* Thermal zone callback registry */
> +static struct thermal_zone_device_ops tzone_ops =3D {
> +	.get_temp =3D sys_get_curr_temp,
> +	.get_trip_temp =3D sys_get_trip_temp,
> +	.get_trip_type =3D sys_get_trip_type,
> +	.set_trip_temp =3D sys_set_trip_temp,
> +};
> +
> +static bool pkg_temp_thermal_platform_thermal_rate_control(void)
> +{
> +	return true;
> +}
> +

Why the above function is needed?

> +/* Enable threshold interrupt on local package/cpu */
> +static inline void enable_pkg_thres_interrupt(void)
> +{
> +	u32 l, h;
> +
> +	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
> +	wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
> +			l | (THERM_INT_THRESHOLD0_ENABLE |
> +				THERM_INT_THRESHOLD1_ENABLE), h);
> +
> +}
> +
> +/* Disable threshold interrupt on local package/cpu */
> +static inline void disable_pkg_thres_interrupt(void)
> +{
> +	u32 l, h;
> +	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
> +	wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
> +			l & (~THERM_INT_THRESHOLD0_ENABLE) &
> +				(~THERM_INT_THRESHOLD1_ENABLE), h);
> +}
> +
> +static void pkg_temp_thermal_threshold_work_fn(struct work_struct *wor=
k)
> +{
> +	__u64 msr_val;
> +	int cpu =3D smp_processor_id();
> +	struct phy_dev_entry *phdev =3D
> +			pkg_temp_thermal_get_phy_entry(
> +				topology_physical_package_id(cpu));
> +	bool notify =3D false;
> +
> +	++pkg_work_cnt;
> +

Is it correct to update this counter even if the condition below fails?
In case negative answer, move it. Similar question is if you want to
hold pkg_work_lock before updating the counter..

> +	if (!phdev)
> +		return;
> +
> +	spin_lock(&pkg_work_lock);
> +	if (unlikely(topology_physical_package_id(cpu) > max_phy_id)) {
> +		spin_unlock(&pkg_work_lock);
> +		return;
> +	}
> +	*(pkg_work_scheduled + topology_physical_package_id(cpu)) =3D 0;

I know notation is a matter of taste most of the time. IMO, the above
statement is written in a strange way, unnecessarily.

> +	spin_unlock(&pkg_work_lock);
> +
> +	enable_pkg_thres_interrupt();
> +	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
> +	if (msr_val & THERM_LOG_THRESHOLD0) {
> +		wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS,
> +				msr_val & ~THERM_LOG_THRESHOLD0);
> +		notify =3D true;
> +	}
> +	if (msr_val & THERM_LOG_THRESHOLD1) {
> +		wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS,
> +				msr_val & ~THERM_LOG_THRESHOLD1);
> +		notify =3D true;
> +	}
> +	if (notify) {
> +		pr_debug("thermal_zone_device_update\n");
> +		thermal_zone_device_update(phdev->tzone);
> +	}
> +}
> +
> +static int pkg_temp_thermal_platform_thermal_notify(__u64 msr_val)
> +{
> +	unsigned long flags;
> +	int cpu =3D smp_processor_id();
> +
> +	++pkg_interrupt_cnt;

Do you need locking for the above?

> +
> +	/*
> +	* When a package is in interrupted state, all CPU's in that package
> +	* are in the same interrupt state. So scheduling on any one CPU in
> +	* the package is enough and simply return for others.
> +	*/
> +	spin_lock_irqsave(&pkg_work_lock, flags);
> +	if (unlikely(topology_physical_package_id(cpu) > max_phy_id) ||
> +		unlikely(!pkg_work_scheduled) ||
> +		(*(pkg_work_scheduled + topology_physical_package_id(cpu)))) {
> +		disable_pkg_thres_interrupt();
> +		spin_unlock_irqrestore(&pkg_work_lock, flags);
> +		return -EINVAL;
> +	}
> +	*(pkg_work_scheduled + topology_physical_package_id(cpu)) =3D 1;
> +	spin_unlock_irqrestore(&pkg_work_lock, flags);
> +
> +	disable_pkg_thres_interrupt();
> +	schedule_delayed_work_on(cpu,
> +				&per_cpu(pkg_temp_thermal_threshold_work, cpu),
> +				PKG_TEMP_THERMAL_NOTIFY_DELAY);


What happens if you get several of same irqs/ get called several times
before PKG_TEMP_THERMAL_NOTIFY_DELAY?

> +	return 0;
> +}
> +
> +static int find_siblings_cpu(int cpu)
> +{
> +	int i;
> +	int id =3D topology_physical_package_id(cpu);
> +
> +	for_each_online_cpu(i)
> +		if (i !=3D cpu && topology_physical_package_id(i) =3D=3D id)
> +			return i;
> +
> +	return 0;
> +}
> +
> +static int pkg_temp_thermal_device_add(unsigned int cpu)
> +{
> +	int err;
> +	u32 tj_max;
> +	struct phy_dev_entry *phy_dev_entry;
> +	char buffer[30];
> +	int thres_count;
> +	u32 eax, ebx, ecx, edx;
> +
> +	cpuid(6, &eax, &ebx, &ecx, &edx);
> +	thres_count =3D ebx & 0x07;
> +	if (!thres_count)
> +		return -ENODEV;
> +
> +	thres_count =3D clamp_val(thres_count, 0, MAX_NUMBER_OF_TRIPS);
> +
> +	err =3D get_tj_max(cpu, &tj_max);
> +	if (err)
> +		goto err_ret;
> +
> +	mutex_lock(&phy_dev_list_mutex);
> +
> +	phy_dev_entry =3D kzalloc(sizeof(struct phy_dev_entry), GFP_KERNEL);

How about using sizeof(*phy_dev_entry)?

> +	if (!phy_dev_entry) {
> +		err =3D -ENOMEM;
> +		goto err_ret_unlock;
> +	}
> +
> +	spin_lock(&pkg_work_lock);
> +	if (topology_physical_package_id(cpu) > max_phy_id)
> +		max_phy_id =3D topology_physical_package_id(cpu);
> +	pkg_work_scheduled =3D krealloc(pkg_work_scheduled,
> +				(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
> +	if (!pkg_work_scheduled) {
> +		spin_unlock(&pkg_work_lock);
> +		err =3D -ENOMEM;
> +		goto err_ret_free;
> +	}
> +	*(pkg_work_scheduled + topology_physical_package_id(cpu)) =3D 0;
> +	spin_unlock(&pkg_work_lock);
> +
> +	phy_dev_entry->phys_proc_id =3D topology_physical_package_id(cpu);
> +	phy_dev_entry->first_cpu =3D cpu;
> +	phy_dev_entry->tj_max =3D tj_max;
> +	phy_dev_entry->ref_cnt =3D 1;
> +	sprintf(buffer, "pkg-temp-%d\n", phy_dev_entry->phys_proc_id);

how about using snprintf?

> +	phy_dev_entry->tzone =3D thermal_zone_device_register(buffer,
> +			thres_count,
> +			(thres_count =3D=3D MAX_NUMBER_OF_TRIPS) ?
> +				0x03 : 0x01,
> +			phy_dev_entry, &tzone_ops, &tz_params, 0, 0);
> +	if (IS_ERR(phy_dev_entry->tzone)) {
> +		err =3D -ENODEV;


How about casting back the ptr err returned by thermal_zone_device_regist=
er?

> +		goto err_ret_free;
> +	}
> +	/* Store MSR value for package thermal interrupt, to restore at exit =
*/
> +	rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
> +				&phy_dev_entry->start_pkg_therm_low,
> +				&phy_dev_entry->start_pkg_therm_high);
> +
> +	list_add_tail(&phy_dev_entry->list, &phy_dev_list);
> +
> +	mutex_unlock(&phy_dev_list_mutex);
> +
> +	return 0;
> +
> +err_ret_free:
> +	kfree(phy_dev_entry);
> +err_ret_unlock:
> +	mutex_unlock(&phy_dev_list_mutex);
> +
> +err_ret:
> +	return err;
> +}
> +
> +static int pkg_temp_thermal_device_remove(unsigned int cpu)
> +{
> +	struct phy_dev_entry *phdev =3D
> +			pkg_temp_thermal_get_phy_entry(
> +					topology_physical_package_id(cpu));
> +	struct phy_dev_entry *n;
> +	u16 phys_proc_id =3D topology_physical_package_id(cpu);
> +
> +	if (!phdev)
> +		return -ENODEV;
> +
> +	mutex_lock(&phy_dev_list_mutex);
> +	/* If we are loosing the first cpu for this package, we need change *=
/
> +	if (phdev->first_cpu =3D=3D cpu)
> +		phdev->first_cpu =3D find_siblings_cpu(cpu);
> +	/*
> +	* It is possible that no siblings left as this was the last cpu
> +	* going offline. We don't need to worry about this assignment
> +	* as the phydev entry will be removed in this case and
> +	* thermal zone is removed.
> +	*/
> +	--phdev->ref_cnt;
> +	pr_debug("thermal_device_remove: cpu %d ref_cnt %d\n",
> +						cpu, phdev->ref_cnt);
> +	if (!phdev->ref_cnt)
> +		list_for_each_entry_safe(phdev, n, &phy_dev_list, list) {
> +			if (phdev->phys_proc_id =3D=3D phys_proc_id) {
> +				sys_set_trip_temp(phdev->tzone, 0, 0);
> +				sys_set_trip_temp(phdev->tzone, 1, 0);
> +				thermal_zone_device_unregister(phdev->tzone);
> +				list_del(&phdev->list);
> +				kfree(phdev);
> +				break;
> +			}
> +		}
> +	mutex_unlock(&phy_dev_list_mutex);
> +
> +	return 0;
> +}
> +
> +static int get_core_online(unsigned int cpu)
> +{
> +	struct cpuinfo_x86 *c =3D &cpu_data(cpu);
> +	struct phy_dev_entry *phdev =3D pkg_temp_thermal_get_phy_entry(cpu);
> +
> +	/* Check if there is already an instance for this package */
> +	if (!phdev) {
> +		if (!cpu_has(c, X86_FEATURE_DTHERM) &&
> +					!cpu_has(c, X86_FEATURE_PTS))
> +			return -ENODEV;
> +		if (pkg_temp_thermal_device_add(cpu))
> +			return -ENODEV;
> +	} else {
> +		mutex_lock(&phy_dev_list_mutex);
> +		++phdev->ref_cnt;
> +		pr_debug("get_core_online: cpu %d ref_cnt %d\n",
> +						cpu, phdev->ref_cnt);
> +		mutex_unlock(&phy_dev_list_mutex);
> +	}
> +	INIT_DELAYED_WORK(&per_cpu(pkg_temp_thermal_threshold_work, cpu),
> +			pkg_temp_thermal_threshold_work_fn);
> +
> +	pr_debug("get_core_online: cpu %d successful\n", cpu);
> +
> +	return 0;
> +}
> +
> +static void put_core_offline(unsigned int cpu)
> +{
> +	if (!pkg_temp_thermal_device_remove(cpu))
> +		cancel_delayed_work_sync(
> +			&per_cpu(pkg_temp_thermal_threshold_work, cpu));
> +
> +	pr_debug("put_core_offline: cpu %d\n", cpu);
> +}
> +
> +static int pkg_temp_thermal_cpu_callback(struct notifier_block *nfb,
> +				 unsigned long action, void *hcpu)
> +{
> +	unsigned int cpu =3D (unsigned long) hcpu;
> +
> +	switch (action) {
> +	case CPU_ONLINE:
> +	case CPU_DOWN_FAILED:
> +		get_core_online(cpu);
> +		break;
> +	case CPU_DOWN_PREPARE:
> +		put_core_offline(cpu);
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block pkg_temp_thermal_notifier __refdata =3D {=

> +	.notifier_call =3D pkg_temp_thermal_cpu_callback,
> +};
> +
> +static const struct x86_cpu_id __initconst pkg_temp_thermal_ids[] =3D =
{
> +	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_DTHERM=
 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, pkg_temp_thermal_ids);
> +
> +static int __init pkg_temp_thermal_init(void)
> +{
> +	int i;
> +
> +	if (!x86_match_cpu(pkg_temp_thermal_ids))
> +		return -ENODEV;
> +
> +	strncpy(tz_params.governor_name, "user_space", THERMAL_NAME_LENGTH);
> +	spin_lock_init(&pkg_work_lock);
> +	platform_thermal_package_notify =3D
> +			pkg_temp_thermal_platform_thermal_notify;
> +	platform_thermal_package_rate_control =3D
> +			pkg_temp_thermal_platform_thermal_rate_control;
> +
> +	get_online_cpus();
> +	for_each_online_cpu(i)
> +		if (get_core_online(i))
> +			goto err_ret;
> +	register_hotcpu_notifier(&pkg_temp_thermal_notifier);
> +	put_online_cpus();
> +
> +	pkg_temp_debugfs_init(); /* Don't care if fails */
> +
> +	return 0;
> +
> +err_ret:
> +	get_online_cpus();
> +	for_each_online_cpu(i)
> +		put_core_offline(i);
> +	put_online_cpus();
> +	kfree(pkg_work_scheduled);
> +	platform_thermal_package_notify =3D NULL;
> +	platform_thermal_package_rate_control =3D NULL;
> +
> +	return -ENODEV;
> +}
> +
> +static void __exit pkg_temp_thermal_exit(void)
> +{
> +	struct phy_dev_entry *phdev, *n;
> +	int i;
> +
> +	get_online_cpus();
> +	unregister_hotcpu_notifier(&pkg_temp_thermal_notifier);
> +	mutex_lock(&phy_dev_list_mutex);
> +	list_for_each_entry_safe(phdev, n, &phy_dev_list, list) {
> +		/* Retore old MSR value for package thermal interrupt */
> +		wrmsr_on_cpu(phdev->first_cpu,
> +			MSR_IA32_PACKAGE_THERM_INTERRUPT,
> +			phdev->start_pkg_therm_low,
> +			phdev->start_pkg_therm_high);
> +		thermal_zone_device_unregister(phdev->tzone);
> +		list_del(&phdev->list);
> +		kfree(phdev);
> +	}
> +	mutex_unlock(&phy_dev_list_mutex);
> +	platform_thermal_package_notify =3D NULL;
> +	platform_thermal_package_rate_control =3D NULL;
> +	for_each_online_cpu(i)
> +		cancel_delayed_work_sync(
> +			&per_cpu(pkg_temp_thermal_threshold_work, i));
> +	put_online_cpus();
> +
> +	kfree(pkg_work_scheduled);
> +
> +	debugfs_remove_recursive(debugfs);
> +}
> +
> +module_init(pkg_temp_thermal_init)
> +module_exit(pkg_temp_thermal_exit)
> +
> +MODULE_DESCRIPTION("X86 PKG TEMP Thermal Driver");
> +MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.co=
m>");
> +MODULE_LICENSE("GPL");
>=20
GPL v2 ?



------enig2HTKLKJGWUKUOWJPKJQEQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGRP2AACgkQCXcVR3XQvP0kIQD/Swp/z4mX6tP+G+NA8E5ArbSv
5CTK1aBpWTLCJnj/dn8A+wSInitBIkwgVI3nK/crJ4CFyGnSqMZV4hRQqQapgfzC
=zchr
-----END PGP SIGNATURE-----

------enig2HTKLKJGWUKUOWJPKJQEQ--
