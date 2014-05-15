From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [Patch V1] thermal: Intel SoC DTS thermal
Date: Thu, 15 May 2014 17:04:03 +0800
Message-ID: <1400144643.2273.33.camel@rzhang1-toshiba>
References: <1396904235-23404-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1396904235-23404-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20445 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbaEOJEf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 May 2014 05:04:35 -0400
In-Reply-To: <1396904235-23404-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: eduardo.valentin@ti.com, linux-pm@vger.kernel.org

On =E4=B8=80, 2014-04-07 at 13:57 -0700, Srinivas Pandruvada wrote:
> In the Intel SoCs like Bay Trail, there are 2 additional digital temp=
erature
> sensors(DTS), in addition to the standard DTSs in the core. Also they=
 support
> 4 programmable thresholds, out of which two can be used by OSPM. Thes=
e
> thresholds can be used by OSPM thermal control. Out of these two thre=
sholds,
> one is used by driver and one user mode can change via thermal sysfs =
to get
> notifications on threshold violations.
>=20
> The driver defines one critical trip points, which is set to TJ MAX -=
 offset.
> The offset can be changed via module parameter (default 5C). Also it =
uses
> one of the thresholds to get notification for this temperature violat=
ion.
> This is very important for orderly shutdown as the many of these devi=
ces don't
> have ACPI thermal zone, and expects that there is some other thermal =
control
> mechanism present in OSPM. When a Linux distro is used without additi=
onal
> specialized thermal control program, BIOS can do force shutdown when =
thermals
> are not under control. When temperature reaches critical, the Linux t=
hermal
> core will initiate an orderly shutdown.
>=20
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c=
om>

applied.

thanks,
rui
> ---
>  drivers/thermal/Kconfig                 |  12 +
>  drivers/thermal/Makefile                |   1 +
>  drivers/thermal/intel_soc_dts_thermal.c | 479 ++++++++++++++++++++++=
++++++++++
>  3 files changed, 492 insertions(+)
>  create mode 100644 drivers/thermal/intel_soc_dts_thermal.c
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5f88d76..87117e5 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -222,6 +222,18 @@ config ACPI_INT3403_THERMAL
>  	  the Intel Thermal Daemon can use this information to allow the us=
er
>  	  to select his laptop to run without turning on the fans.
> =20
> +config INTEL_SOC_DTS_THERMAL
> +	tristate "Intel SoCs DTS thermal driver"
> +	depends on X86 && IOSF_MBI
> +	help
> +	  Enable this to register Intel SoCs (e.g. Bay Trail) platform digi=
tal
> +	  temperature sensor (DTS). These SoCs have two additional DTSs in
> +	  addition to DTSs on CPU cores. Each DTS will be registered as a
> +	  thermal zone. There are two trip points. One of the trip point ca=
n
> +	  be set by user mode programs to get notifications via Linux therm=
al
> +	  notification methods.The other trip is a critical trip point, whi=
ch
> +	  was set by the driver based on the TJ MAX temperature.
> +
>  menu "Texas Instruments thermal drivers"
>  source "drivers/thermal/ti-soc-thermal/Kconfig"
>  endmenu
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 54e4ec9..de0636a 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -29,5 +29,6 @@ obj-$(CONFIG_IMX_THERMAL)	+=3D imx_thermal.o
>  obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+=3D db8500_cpufreq_cooling.o
>  obj-$(CONFIG_INTEL_POWERCLAMP)	+=3D intel_powerclamp.o
>  obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+=3D x86_pkg_temp_thermal.o
> +obj-$(CONFIG_INTEL_SOC_DTS_THERMAL)	+=3D intel_soc_dts_thermal.o
>  obj-$(CONFIG_TI_SOC_THERMAL)	+=3D ti-soc-thermal/
>  obj-$(CONFIG_ACPI_INT3403_THERMAL)	+=3D int3403_thermal.o
> diff --git a/drivers/thermal/intel_soc_dts_thermal.c b/drivers/therma=
l/intel_soc_dts_thermal.c
> new file mode 100644
> index 0000000..a6a0a18
> --- /dev/null
> +++ b/drivers/thermal/intel_soc_dts_thermal.c
> @@ -0,0 +1,479 @@
> +/*
> + * intel_soc_dts_thermal.c
> + * Copyright (c) 2014, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WI=
THOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lic=
ense for
> + * more details.
> + *
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/thermal.h>
> +#include <asm/cpu_device_id.h>
> +#include <asm/iosf_mbi.h>
> +
> +#define SOC_DTS_OFFSET_ENABLE	0xB0
> +#define SOC_DTS_OFFSET_TEMP	0xB1
> +
> +#define SOC_DTS_OFFSET_PTPS	0xB2
> +#define SOC_DTS_OFFSET_PTTS	0xB3
> +#define SOC_DTS_OFFSET_PTTSS	0xB4
> +#define SOC_DTS_OFFSET_PTMC	0x80
> +#define SOC_DTS_TE_AUX0		0xB5
> +#define SOC_DTS_TE_AUX1		0xB6
> +
> +#define SOC_DTS_AUX0_ENABLE_BIT		BIT(0)
> +#define SOC_DTS_AUX1_ENABLE_BIT		BIT(1)
> +#define SOC_DTS_CPU_MODULE0_ENABLE_BIT	BIT(16)
> +#define SOC_DTS_CPU_MODULE1_ENABLE_BIT	BIT(17)
> +#define SOC_DTS_TE_SCI_ENABLE		BIT(9)
> +#define SOC_DTS_TE_SMI_ENABLE		BIT(10)
> +#define SOC_DTS_TE_MSI_ENABLE		BIT(11)
> +#define SOC_DTS_TE_APICA_ENABLE		BIT(14)
> +#define SOC_DTS_PTMC_APIC_DEASSERT_BIT	BIT(4)
> +
> +/* DTS encoding for TJ MAX temperature */
> +#define SOC_DTS_TJMAX_ENCODING	0x7F
> +
> +/* IRQ 86 is a fixed APIC interrupt for BYT DTS Aux threshold notifi=
cations */
> +#define BYT_SOC_DTS_APIC_IRQ	86
> +
> +/* Only 2 out of 4 is allowed for OSPM */
> +#define SOC_MAX_DTS_TRIPS	2
> +
> +/* Mask for two trips in status bits */
> +#define SOC_DTS_TRIP_MASK	0x03
> +
> +/* DTS0 and DTS 1 */
> +#define SOC_MAX_DTS_SENSORS	2
> +
> +#define CRITICAL_OFFSET_FROM_TJ_MAX	5000
> +
> +struct soc_sensor_entry {
> +	int id;
> +	u32 tj_max;
> +	u32 temp_mask;
> +	u32 temp_shift;
> +	u32 store_status;
> +	struct thermal_zone_device *tzone;
> +};
> +
> +static struct soc_sensor_entry *soc_dts[SOC_MAX_DTS_SENSORS];
> +
> +static int crit_offset =3D CRITICAL_OFFSET_FROM_TJ_MAX;
> +module_param(crit_offset, int, 0644);
> +MODULE_PARM_DESC(crit_offset,
> +	"Critical Temperature offset from tj max in millidegree Celsius.");
> +
> +static DEFINE_MUTEX(aux_update_mutex);
> +static spinlock_t intr_notify_lock;
> +static int soc_dts_thres_irq;
> +
> +static int get_tj_max(u32 *tj_max)
> +{
> +	u32 eax, edx;
> +	u32 val;
> +	int err;
> +
> +	err =3D rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
> +	if (err)
> +		goto err_ret;
> +	else {
> +		val =3D (eax >> 16) & 0xff;
> +		if (val)
> +			*tj_max =3D val * 1000;
> +		else {
> +			err =3D -EINVAL;
> +			goto err_ret;
> +		}
> +	}
> +
> +	return 0;
> +err_ret:
> +	*tj_max =3D 0;
> +
> +	return err;
> +}
> +
> +static int sys_get_trip_temp(struct thermal_zone_device *tzd,
> +					int trip, unsigned long *temp)
> +{
> +	int status;
> +	u32 out;
> +	struct soc_sensor_entry *aux_entry;
> +
> +	aux_entry =3D tzd->devdata;
> +
> +	if (!trip) {
> +		/* Just return the critical temp */
> +		*temp =3D aux_entry->tj_max - crit_offset;
> +		return 0;
> +	}
> +
> +	mutex_lock(&aux_update_mutex);
> +	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +					SOC_DTS_OFFSET_PTPS, &out);
> +	mutex_unlock(&aux_update_mutex);
> +	if (status)
> +		return status;
> +
> +	out =3D (out >> (trip * 8)) & SOC_DTS_TJMAX_ENCODING;
> +
> +	if (!out)
> +		*temp =3D 0;
> +	else
> +		*temp =3D aux_entry->tj_max - out * 1000;
> +
> +	return 0;
> +}
> +
> +static int update_trip_temp(struct soc_sensor_entry *aux_entry,
> +				int thres_index, unsigned long temp)
> +{
> +	int status;
> +	u32 temp_out;
> +	u32 out;
> +	u32 store_ptps;
> +	u32 store_ptmc;
> +	u32 store_te_out;
> +	u32 te_out;
> +
> +	u32 int_enable_bit =3D SOC_DTS_TE_APICA_ENABLE |
> +						SOC_DTS_TE_MSI_ENABLE;
> +
> +	temp_out =3D (aux_entry->tj_max - temp) / 1000;
> +
> +	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +				SOC_DTS_OFFSET_PTPS, &store_ptps);
> +	if (status)
> +		return status;
> +
> +	out =3D (store_ptps & ~(0xFF << (thres_index * 8)));
> +	out |=3D (temp_out & 0xFF) << (thres_index * 8);
> +	status =3D iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +				SOC_DTS_OFFSET_PTPS, out);
> +	if (status)
> +		return status;
> +	pr_debug("update_trip_temp PTPS =3D %x\n", out);
> +	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +					SOC_DTS_OFFSET_PTMC, &out);
> +	if (status)
> +		goto err_restore_ptps;
> +
> +	store_ptmc =3D out;
> +
> +	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +					SOC_DTS_TE_AUX0 + thres_index,
> +					&te_out);
> +	if (status)
> +		goto err_restore_ptmc;
> +
> +	store_te_out =3D te_out;
> +
> +	/* Enable for CPU module 0 and module 1 */
> +	out |=3D (SOC_DTS_CPU_MODULE0_ENABLE_BIT |
> +					SOC_DTS_CPU_MODULE1_ENABLE_BIT);
> +	if (temp) {
> +		if (thres_index)
> +			out |=3D SOC_DTS_AUX1_ENABLE_BIT;
> +		else
> +			out |=3D SOC_DTS_AUX0_ENABLE_BIT;
> +		te_out |=3D int_enable_bit;
> +	} else {
> +		if (thres_index)
> +			out &=3D ~SOC_DTS_AUX1_ENABLE_BIT;
> +		else
> +			out &=3D ~SOC_DTS_AUX0_ENABLE_BIT;
> +		te_out &=3D ~int_enable_bit;
> +	}
> +	status =3D iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +					SOC_DTS_OFFSET_PTMC, out);
> +	if (status)
> +		goto err_restore_te_out;
> +
> +	status =3D iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +					SOC_DTS_TE_AUX0 + thres_index,
> +					te_out);
> +	if (status)
> +		goto err_restore_te_out;
> +
> +	return 0;
> +
> +err_restore_te_out:
> +	iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +				SOC_DTS_OFFSET_PTMC, store_te_out);
> +err_restore_ptmc:
> +	iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +				SOC_DTS_OFFSET_PTMC, store_ptmc);
> +err_restore_ptps:
> +	iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +				SOC_DTS_OFFSET_PTPS, store_ptps);
> +	/* Nothing we can do if restore fails */
> +
> +	return status;
> +}
> +
> +static int sys_set_trip_temp(struct thermal_zone_device *tzd, int tr=
ip,
> +							unsigned long temp)
> +{
> +	struct soc_sensor_entry *aux_entry =3D tzd->devdata;
> +	int status;
> +
> +	if (temp > (aux_entry->tj_max - crit_offset))
> +		return -EINVAL;
> +
> +	mutex_lock(&aux_update_mutex);
> +	status =3D update_trip_temp(tzd->devdata, trip, temp);
> +	mutex_unlock(&aux_update_mutex);
> +
> +	return status;
> +}
> +
> +static int sys_get_trip_type(struct thermal_zone_device *thermal,
> +		int trip, enum thermal_trip_type *type)
> +{
> +	if (trip)
> +		*type =3D THERMAL_TRIP_PASSIVE;
> +	else
> +		*type =3D THERMAL_TRIP_CRITICAL;
> +
> +	return 0;
> +}
> +
> +static int sys_get_curr_temp(struct thermal_zone_device *tzd,
> +						unsigned long *temp)
> +{
> +	int status;
> +	u32 out;
> +	struct soc_sensor_entry *aux_entry;
> +
> +	aux_entry =3D tzd->devdata;
> +
> +	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +					SOC_DTS_OFFSET_TEMP, &out);
> +	if (status)
> +		return status;
> +
> +	out =3D (out & aux_entry->temp_mask) >> aux_entry->temp_shift;
> +	out -=3D SOC_DTS_TJMAX_ENCODING;
> +	*temp =3D aux_entry->tj_max - out * 1000;
> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_device_ops tzone_ops =3D {
> +	.get_temp =3D sys_get_curr_temp,
> +	.get_trip_temp =3D sys_get_trip_temp,
> +	.get_trip_type =3D sys_get_trip_type,
> +	.set_trip_temp =3D sys_set_trip_temp,
> +};
> +
> +static void free_soc_dts(struct soc_sensor_entry *aux_entry)
> +{
> +	if (aux_entry) {
> +		iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +			SOC_DTS_OFFSET_ENABLE, aux_entry->store_status);
> +		thermal_zone_device_unregister(aux_entry->tzone);
> +		kfree(aux_entry);
> +	}
> +}
> +
> +static int soc_dts_enable(int id)
> +{
> +	u32 out;
> +	int ret;
> +
> +	ret =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +					SOC_DTS_OFFSET_ENABLE, &out);
> +	if (ret)
> +		return ret;
> +
> +	if (!(out & BIT(id))) {
> +		out |=3D BIT(id);
> +		ret =3D iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +					SOC_DTS_OFFSET_ENABLE, out);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct soc_sensor_entry *alloc_soc_dts(int id, u32 tj_max)
> +{
> +	struct soc_sensor_entry *aux_entry;
> +	char name[10];
> +	int err;
> +
> +	aux_entry =3D kzalloc(sizeof(*aux_entry), GFP_KERNEL);
> +	if (!aux_entry) {
> +		err =3D -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/* Store status to restor on exit */
> +	err =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +					SOC_DTS_OFFSET_ENABLE,
> +					&aux_entry->store_status);
> +	if (err)
> +		goto err_ret;
> +
> +	aux_entry->id =3D id;
> +	aux_entry->tj_max =3D tj_max;
> +	aux_entry->temp_mask =3D 0x00FF << (id * 8);
> +	aux_entry->temp_shift =3D id * 8;
> +	snprintf(name, sizeof(name), "soc_dts%d", id);
> +	aux_entry->tzone =3D thermal_zone_device_register(name,
> +			SOC_MAX_DTS_TRIPS,
> +			0x02,
> +			aux_entry, &tzone_ops, NULL, 0, 0);
> +	if (IS_ERR(aux_entry->tzone)) {
> +		err =3D PTR_ERR(aux_entry->tzone);
> +		goto err_ret;
> +	}
> +
> +	err =3D soc_dts_enable(id);
> +	if (err)
> +		goto err_aux_status;
> +
> +	return aux_entry;
> +
> +err_aux_status:
> +	thermal_zone_device_unregister(aux_entry->tzone);
> +err_ret:
> +	kfree(aux_entry);
> +	return ERR_PTR(err);
> +}
> +
> +static void proc_thermal_interrupt(void)
> +{
> +	u32 sticky_out;
> +	int status;
> +	u32 ptmc_out;
> +
> +	/* Clear APIC interrupt */
> +	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +				SOC_DTS_OFFSET_PTMC, &ptmc_out);
> +
> +	ptmc_out |=3D SOC_DTS_PTMC_APIC_DEASSERT_BIT;
> +	status =3D iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +					SOC_DTS_OFFSET_PTMC, ptmc_out);
> +
> +	/* Read status here */
> +	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +					SOC_DTS_OFFSET_PTTSS, &sticky_out);
> +	pr_debug("status %d PTTSS %x\n", status, sticky_out);
> +	if (sticky_out & SOC_DTS_TRIP_MASK) {
> +		int i;
> +		/* reset sticky bit */
> +		status =3D iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +					SOC_DTS_OFFSET_PTTSS, sticky_out);
> +		for (i =3D 0; i < SOC_MAX_DTS_SENSORS; ++i) {
> +			pr_debug("TZD update for zone %d\n", i);
> +			thermal_zone_device_update(soc_dts[i]->tzone);
> +		}
> +	}
> +
> +}
> +
> +static irqreturn_t soc_irq_thread_fn(int irq, void *dev_data)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&intr_notify_lock, flags);
> +	proc_thermal_interrupt();
> +	spin_unlock_irqrestore(&intr_notify_lock, flags);
> +	pr_debug("proc_thermal_interrupt\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct x86_cpu_id soc_thermal_ids[] =3D {
> +	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, 0x37, 0, BYT_SOC_DTS_APIC_IRQ},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, soc_thermal_ids);
> +
> +static int __init intel_soc_thermal_init(void)
> +{
> +	u32 tj_max;
> +	int err =3D 0;
> +	int i;
> +	const struct x86_cpu_id *match_cpu;
> +
> +	match_cpu =3D x86_match_cpu(soc_thermal_ids);
> +	if (!match_cpu)
> +		return -ENODEV;
> +
> +	if (get_tj_max(&tj_max))
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < SOC_MAX_DTS_SENSORS; ++i) {
> +		soc_dts[i] =3D alloc_soc_dts(i, tj_max);
> +		if (IS_ERR(soc_dts[i])) {
> +			err =3D PTR_ERR(soc_dts[i]);
> +			goto err_free;
> +		}
> +	}
> +
> +	spin_lock_init(&intr_notify_lock);
> +
> +	soc_dts_thres_irq =3D (int)match_cpu->driver_data;
> +
> +	err =3D request_threaded_irq(soc_dts_thres_irq, NULL,
> +					soc_irq_thread_fn,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					"soc_dts", soc_dts);
> +	if (err) {
> +		pr_err("request_threaded_irq ret %d\n", err);
> +		goto err_free;
> +	}
> +
> +	for (i =3D 0; i < SOC_MAX_DTS_SENSORS; ++i) {
> +		err =3D update_trip_temp(soc_dts[i], 0, tj_max - crit_offset);
> +		if (err)
> +			goto err_trip_temp;
> +	}
> +
> +	return 0;
> +
> +err_trip_temp:
> +	i =3D SOC_MAX_DTS_SENSORS;
> +	free_irq(soc_dts_thres_irq, soc_dts);
> +err_free:
> +	while (--i >=3D 0)
> +		free_soc_dts(soc_dts[i]);
> +
> +	return err;
> +}
> +
> +static void __exit intel_soc_thermal_exit(void)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < SOC_MAX_DTS_SENSORS; ++i)
> +		update_trip_temp(soc_dts[i], 0, 0);
> +
> +	free_irq(soc_dts_thres_irq, soc_dts);
> +
> +	for (i =3D 0; i < SOC_MAX_DTS_SENSORS; ++i)
> +		free_soc_dts(soc_dts[i]);
> +
> +}
> +
> +module_init(intel_soc_thermal_init)
> +module_exit(intel_soc_thermal_exit)
> +
> +MODULE_DESCRIPTION("Intel SoC DTS Thermal Driver");
> +MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.=
com>");
> +MODULE_LICENSE("GPL v2");


