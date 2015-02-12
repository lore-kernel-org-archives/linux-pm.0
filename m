From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH] thermal: intel Quark SoC X1000 DTS thermal driver
Date: Thu, 12 Feb 2015 11:37:23 +0000
Message-ID: <54DC9073.7070701@nexus-software.ie>
References: <1423673509-11195-1-git-send-email-boon.leong.ong@intel.com> <1423673509-11195-2-git-send-email-boon.leong.ong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423673509-11195-2-git-send-email-boon.leong.ong@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ong Boon Leong <boon.leong.ong@intel.com>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/02/15 16:51, Ong Boon Leong wrote:
> In Intel Quark SoC X1000, there is one on-die digital temperature sensor(DTS).
> The DTS offers both hot & critical trip points.
>
> However, in current distribution of UEFI BIOS for Quark platform, only
the current
> critical trip point is configured to be 105 degree Celsius (based on Quark
> SW ver1.0.1 and hot trip point is not used due to lack of IRQ.
>
> There is no active cooling device for Quark SoC, so Quark SoC thermal
> management simply expects Linux distro to orderly power-off when temperature
-simply
+layer or +logic

> of DTS exceeds the configured critical trip point.
 >
the DTS
>
> Kernel param "polling_delay" in milli-second is used to control the frequency
parameter
milliseconds

> DTS temperature is read by thermal framework. It is default to 2-second. To
the DTS temperature
It defaults to two seconds.

> change it, use kernal boot param "intel_quark_dts_thermal.polling_delay=X".
kernel
>
> User interacts with Quark SoC DTS thermal driver through sysfs at:

small nitpick

-through sysfs at
+through sysfs via:

sounds better

> /sys/class/thermal/thermal_zone0/
>
> For examples:
-For examples:
+For example:

>   - to read DTS temperature
>     $ cat temp
>   - to read critical trip point
>     $ cat trip_point_0_temp
>   - to read trip point type
>     $ cat trip_point_0_type
>   - to emulate temperature raise to test orderly shutdown by Linux distro
>     $ echo 105 > emul_temp
>
> Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
> ---
>   drivers/thermal/Kconfig                   |   10 +
>   drivers/thermal/Makefile                  |    1 +
>   drivers/thermal/intel_quark_dts_thermal.c |  408 +++++++++++++++++++++++++++++
>   3 files changed, 419 insertions(+)
>   create mode 100644 drivers/thermal/intel_quark_dts_thermal.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index f554d25..b80f09f 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -229,6 +229,16 @@ config INTEL_SOC_DTS_THERMAL
>   	  notification methods.The other trip is a critical trip point, which
>   	  was set by the driver based on the TJ MAX temperature.
>
> +config INTEL_QUARK_DTS_THERMAL
> +	tristate "Intel Quark DTS thermal driver"
> +	depends on X86 && IOSF_MBI
> +	help
> +	  Enable this to register Intel Quark SoC (e.g. X1000) platform digital
> +	  temperature sensor (DTS). For X1000 SoC, it has one on-die DTS.
> +	  The DTS will be registered as a thermal zone. There are two trip points:
> +	  hot & critical. The critical trip point default value is set by
> +	  underlying BIOS/Firmware.
> +
>   config INT340X_THERMAL
>   	tristate "ACPI INT340X thermal drivers"
>   	depends on X86 && ACPI
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 39c4fe8..50c5991 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+= db8500_cpufreq_cooling.o
>   obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
>   obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+= x86_pkg_temp_thermal.o
>   obj-$(CONFIG_INTEL_SOC_DTS_THERMAL)	+= intel_soc_dts_thermal.o
> +obj-$(CONFIG_INTEL_QUARK_DTS_THERMAL)	+= intel_quark_dts_thermal.o
>   obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
>   obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
>   obj-$(CONFIG_ST_THERMAL)	+= st/
> diff --git a/drivers/thermal/intel_quark_dts_thermal.c b/drivers/thermal/intel_quark_dts_thermal.c
> new file mode 100644
> index 0000000..fe1e221
> --- /dev/null
> +++ b/drivers/thermal/intel_quark_dts_thermal.c
> @@ -0,0 +1,408 @@
> +/*
> + * intel_quark_dts_thermal.c
> + * Copyright (c) 2015, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * Quark DTS thermal driver is implemented by referencing
> + * intel_soc_dts_thermal.c.
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
> +#define X86_FAMILY_QUARK	0x5
> +#define X86_MODEL_QUARK_X1000	0x9
> +
> +/* DTS reset is programmed via QRK_MBI_UNIT_SOC */
> +#define QRK_DTS_REG_OFFSET_RESET	0x34
> +#define QRK_DTS_RESET_BIT		BIT(0)
> +
> +/* DTS enable is programmed via QRK_MBI_UNIT_RMU */
> +#define QRK_DTS_REG_OFFSET_ENABLE	0xB0
> +#define QRK_DTS_ENABLE_BIT		BIT(15)
> +
> +/* Temperature Register is read via QRK_MBI_UNIT_RMU */
> +#define QRK_DTS_REG_OFFSET_TEMP		0xB1
> +#define QRK_DTS_MASK_TEMP		0xFF
> +#define QRK_DTS_OFFSET_TEMP		0
> +#define QRK_DTS_OFFSET_REL_TEMP		16
> +#define QRK_DTS_TEMP_BASE		50
> +
> +/* Programmable Trip Point Register is configured via QRK_MBI_UNIT_RMU */
> +#define QRK_DTS_REG_OFFSET_PTPS		0xB2
> +#define QRK_DTS_MASK_TP_THRES		0xFF
> +#define QRK_DTS_SHIFT_TP		8
> +#define QRK_DTS_ID_TP_CRITICAL		0
> +
> +/* Thermal Sensor Register Lock */
> +#define QRK_DTS_REG_OFFSET_LOCK		0x71
> +#define QRK_DTS_LOCK_BIT		BIT(5)
> +
> +/* Quark DTS has 2 trip points: hot & catastrophic */
> +#define QRK_MAX_DTS_TRIPS	2
> +/* If DTS not locked, all trip points are configurable */
is not locked

> +#define QRK_DTS_WR_MASK_SET	0x3
> +/* If DTS locked, all trip points are not configurable */
is locked

> +#define QRK_DTS_WR_MASK_CLR	0
> +
> +#define DEFAULT_POLL_DELAY	2000
> +
> +struct soc_sensor_entry {
> +	bool locked;
> +	u32 store_ptps;
> +	u32 store_dts_enable;
> +	enum thermal_device_mode mode;
> +	struct thermal_zone_device *tzone;
> +};
> +
> +static struct soc_sensor_entry *soc_dts;
> +
> +static int polling_delay = DEFAULT_POLL_DELAY;
> +module_param(polling_delay, int, 0644);
> +MODULE_PARM_DESC(polling_delay,
> +	"Polling interval for checking trip points (in milliseconds)");
> +
> +static DEFINE_MUTEX(dts_update_mutex);
> +
> +static int soc_dts_enable(struct thermal_zone_device *tzd)
> +{
> +	u32 out;
> +	int ret;
> +	struct soc_sensor_entry *aux_entry = tzd->devdata;

ret declaration ought to come last in the list.

> +
> +	ret = iosf_mbi_read(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_READ,
> +					QRK_DTS_REG_OFFSET_ENABLE, &out);
> +	if (ret)
> +		return ret;
> +
> +	if (out & QRK_DTS_ENABLE_BIT) {
> +		aux_entry->mode = THERMAL_DEVICE_ENABLED;
> +		return 0;
> +	}
> +
> +	if (!aux_entry->locked) {
> +		out |= QRK_DTS_ENABLE_BIT;
> +		ret = iosf_mbi_write(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_WRITE,
> +					QRK_DTS_REG_OFFSET_ENABLE, out);
> +		if (ret)
> +			return ret;
> +
> +		aux_entry->mode = THERMAL_DEVICE_ENABLED;
> +	} else {
> +		aux_entry->mode = THERMAL_DEVICE_DISABLED;
> +		pr_info("DTS is locked. Cannot enable DTS\n");
> +		ret = -EPERM;
> +	}
> +
> +	return ret;
> +}
> +
> +static int soc_dts_disable(struct thermal_zone_device *tzd)
> +{
> +	u32 out;
> +	int ret;
> +	struct soc_sensor_entry *aux_entry = tzd->devdata;
> +
ret order

> +	ret = iosf_mbi_read(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_READ,
> +					QRK_DTS_REG_OFFSET_ENABLE, &out);
> +	if (ret)
> +		return ret;
> +
> +	if (!(out & QRK_DTS_ENABLE_BIT)) {
> +		aux_entry->mode = THERMAL_DEVICE_DISABLED;
> +		return 0;
> +	}
> +
> +	if (!aux_entry->locked) {
> +		out &= ~QRK_DTS_ENABLE_BIT;
> +		ret = iosf_mbi_write(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_WRITE,
> +					QRK_DTS_REG_OFFSET_ENABLE, out);
> +
> +		if (ret)
> +			return ret;
> +
> +		aux_entry->mode = THERMAL_DEVICE_DISABLED;
> +	} else {
> +		aux_entry->mode = THERMAL_DEVICE_ENABLED;
> +		pr_info("DTS is locked. Cannot disable DTS\n");
> +		ret = -EPERM;
> +	}
> +
> +	return ret;
> +}
> +
> +static int _get_trip_temp(int trip, unsigned long *temp)
> +{
> +	int status;
> +	u32 out;
> +
> +	mutex_lock(&dts_update_mutex);
> +	status = iosf_mbi_read(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_READ,
> +				QRK_DTS_REG_OFFSET_PTPS, &out);
> +	mutex_unlock(&dts_update_mutex);
> +
> +	if (status)
> +		return status;
> +
> +	*temp = (out >> (trip * QRK_DTS_SHIFT_TP)) & QRK_DTS_MASK_TP_THRES;
> +	*temp -= QRK_DTS_TEMP_BASE;

Bit-twiddling temp should describe why with a comment.

> +	return 0;
> +}
> +
> +static inline int sys_get_trip_temp(struct thermal_zone_device *tzd,
> +				int trip, unsigned long *temp)
> +{
> +	return _get_trip_temp(trip, temp);
> +}
> +
> +static inline int sys_get_crit_temp(struct thermal_zone_device *tzd,
> +				unsigned long *temp)
> +{
> +	return _get_trip_temp(QRK_DTS_ID_TP_CRITICAL, temp);
> +}
> +
> +static int update_trip_temp(struct soc_sensor_entry *aux_entry,
> +				int trip, unsigned long temp)
> +{
> +	int ret;
> +	u32 out;
> +	u32 temp_out;
> +	u32 store_ptps;
> +
ret order

> +	mutex_lock(&dts_update_mutex);
> +	if (aux_entry->locked) {
> +		ret = -EPERM;
> +		goto failed;
> +	}
> +
> +	ret = iosf_mbi_read(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_READ,
> +				QRK_DTS_REG_OFFSET_PTPS, &store_ptps);
> +	if (ret)
> +		goto failed;
> +
> +	temp_out = temp + QRK_DTS_TEMP_BASE;
> +
> +	out = (store_ptps & ~(QRK_DTS_MASK_TP_THRES <<
> +		(trip * QRK_DTS_SHIFT_TP)));
> +	out |= (temp_out & QRK_DTS_MASK_TP_THRES) <<
> +		(trip * QRK_DTS_SHIFT_TP);

The above block of code for bit-twiddling out - deserves a comment to 
describe.

> +	ret = iosf_mbi_write(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_WRITE,
> +				QRK_DTS_REG_OFFSET_PTPS, out);
> +
> +failed:
> +	mutex_unlock(&dts_update_mutex);
> +	return ret;
> +}
> +
> +static inline int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
> +				unsigned long temp)
> +{
> +	return update_trip_temp(tzd->devdata, trip, temp);
> +}
> +
> +static int sys_get_trip_type(struct thermal_zone_device *thermal,
> +		int trip, enum thermal_trip_type *type)
> +{
> +	if (trip)
> +		*type = THERMAL_TRIP_HOT;
> +	else
> +		*type = THERMAL_TRIP_CRITICAL;
> +
> +	return 0;
> +}
> +
> +static int sys_get_curr_temp(struct thermal_zone_device *tzd,
> +				unsigned long *temp)
> +{
> +	int ret;
> +	u32 out;
ret order

> +	mutex_lock(&dts_update_mutex);
> +	ret = iosf_mbi_read(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_READ,
> +					QRK_DTS_REG_OFFSET_TEMP, &out);
> +	mutex_unlock(&dts_update_mutex);
> +
> +	if (ret)
> +		return ret;
> +
> +	out = (out >> QRK_DTS_OFFSET_TEMP) & QRK_DTS_MASK_TEMP;
> +	*temp = out - QRK_DTS_TEMP_BASE;

Again - I think it would be a good idea to describe the shifts and masks 
and final calculation with a bit of text to describe what's going on and 
why.

> +	return 0;
> +}
> +
> +static int sys_get_mode(struct thermal_zone_device *tzd,
> +				enum thermal_device_mode *mode)
> +{
> +	struct soc_sensor_entry *aux_entry = tzd->devdata;
> +	*mode = aux_entry->mode;
> +	return 0;
> +}
> +
> +static int sys_set_mode(struct thermal_zone_device *tzd,
> +				enum thermal_device_mode mode)
> +{
> +	int ret;
> +	struct soc_sensor_entry *aux_entry = tzd->devdata;
ret order
> +	mutex_lock(&dts_update_mutex);
> +	if (mode == THERMAL_DEVICE_ENABLED)
> +		ret = soc_dts_enable(tzd);
> +	else
> +		ret = soc_dts_disable(tzd);
> +	mutex_unlock(&dts_update_mutex);
> +
> +	return ret;
> +}
> +
> +static struct thermal_zone_device_ops tzone_ops = {
> +	.get_temp = sys_get_curr_temp,
> +	.get_trip_temp = sys_get_trip_temp,
> +	.get_trip_type = sys_get_trip_type,
> +	.set_trip_temp = sys_set_trip_temp,
> +	.get_crit_temp = sys_get_crit_temp,
> +	.get_mode = sys_get_mode,
> +	.set_mode = sys_set_mode,
> +};
> +
> +static void free_soc_dts(struct soc_sensor_entry *aux_entry)
> +{
> +	if (aux_entry) {
> +		if (!aux_entry->locked) {
> +			mutex_lock(&dts_update_mutex);
> +			iosf_mbi_write(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_WRITE,
> +					QRK_DTS_REG_OFFSET_ENABLE,
> +					aux_entry->store_dts_enable);
> +
> +			iosf_mbi_write(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_WRITE,
> +					QRK_DTS_REG_OFFSET_PTPS,
> +					aux_entry->store_ptps);
> +			mutex_unlock(&dts_update_mutex);
> +		}
> +		thermal_zone_device_unregister(aux_entry->tzone);
> +		kfree(aux_entry);
> +	}
> +}
> +
> +static struct soc_sensor_entry *alloc_soc_dts(void)
> +{
> +	struct soc_sensor_entry *aux_entry;
> +	int err;
> +	u32 out;
> +	int wr_mask;
> +
> +	aux_entry = kzalloc(sizeof(*aux_entry), GFP_KERNEL);
> +	if (!aux_entry) {
> +		err = -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/* Check if DTS register is locked */
> +	err = iosf_mbi_read(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_READ,
> +					QRK_DTS_REG_OFFSET_LOCK,
> +					&out);
> +	if (err)
> +		goto err_ret;
> +
> +	if (out & QRK_DTS_LOCK_BIT) {
> +		aux_entry->locked = true;
> +		wr_mask = QRK_DTS_WR_MASK_CLR;
> +	} else {
> +		aux_entry->locked = false;
> +		wr_mask = QRK_DTS_WR_MASK_SET;
> +	}
> +
> +	/* Store DTS default state if DTS registers are not locked */
> +	if (!aux_entry->locked) {
> +		/* Store DTS default enable for restore on exit */
> +		err = iosf_mbi_read(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_READ,
> +					QRK_DTS_REG_OFFSET_ENABLE,
> +					&aux_entry->store_dts_enable);
> +		if (err)
> +			goto err_ret;
> +
> +		/* Store DTS default PTPS register for restore on exit */
> +		err = iosf_mbi_read(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_READ,
> +					QRK_DTS_REG_OFFSET_PTPS,
> +					&aux_entry->store_ptps);
> +		if (err)
> +			goto err_ret;
> +	}
> +
> +	aux_entry->tzone = thermal_zone_device_register("quark_dts",
> +			QRK_MAX_DTS_TRIPS,
> +			wr_mask,
> +			aux_entry, &tzone_ops, NULL, 0, polling_delay);
> +	if (IS_ERR(aux_entry->tzone)) {
> +		err = PTR_ERR(aux_entry->tzone);
> +		goto err_ret;
> +	}
> +
> +	mutex_lock(&dts_update_mutex);
> +	err = soc_dts_enable(aux_entry->tzone);
> +	mutex_unlock(&dts_update_mutex);
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
> +static const struct x86_cpu_id qrk_thermal_ids[] __initconst  = {
> +	{ X86_VENDOR_INTEL, X86_FAMILY_QUARK, X86_MODEL_QUARK_X1000 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, qrk_thermal_ids);
> +
> +static int __init intel_quark_thermal_init(void)
> +{
> +	int err = 0;
> +
> +	if (!x86_match_cpu(qrk_thermal_ids) || !iosf_mbi_available())
> +		return -ENODEV;
> +
> +	soc_dts = alloc_soc_dts();
> +	if (IS_ERR(soc_dts)) {
> +		err = PTR_ERR(soc_dts);
> +		goto err_free;
> +	}
> +
> +	return 0;
> +
> +err_free:
> +	free_soc_dts(soc_dts);
> +	return err;
> +}
> +
> +static void __exit intel_quark_thermal_exit(void)
> +{
> +	free_soc_dts(soc_dts);
> +}
> +
> +module_init(intel_quark_thermal_init)
> +module_exit(intel_quark_thermal_exit)
> +
> +MODULE_DESCRIPTION("Intel Quark DTS Thermal Driver");
> +MODULE_AUTHOR("Ong Boon Leong <boon.leong.ong@intel.com>");
> +MODULE_LICENSE("GPL v2");
If you are referencing the BSP thermal driver shouldn't the 
MODULE_LICENSE be ("Dual BSD/GPL"); ?

Assuming the nit-picks are addressed.

Reviewed-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
