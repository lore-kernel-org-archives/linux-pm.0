From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 3/4] power: Add support for DA9150 Fuel-Gauge
Date: Fri, 3 Jul 2015 16:22:17 +0100
Message-ID: <20150703152217.GC10500@x1>
References: <cover.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
 <596f44407759e2047a02594367116f9c92afee56.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33499 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727AbbGCPWX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 11:22:23 -0400
Received: by wgck11 with SMTP id k11so91115289wgc.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2015 08:22:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <596f44407759e2047a02594367116f9c92afee56.1435308209.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>

On Fri, 26 Jun 2015, Adam Thomson wrote:

> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  drivers/power/Kconfig         |  10 +
>  drivers/power/Makefile        |   1 +
>  drivers/power/da9150-fg.c     | 589 ++++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/da9150/fg.h |  10 +
>  4 files changed, 610 insertions(+)
>  create mode 100644 drivers/power/da9150-fg.c
>=20
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 4091fb0..8054f1a 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -204,6 +204,16 @@ config CHARGER_DA9150
>  	  This driver can also be built as a module. If so, the module will=
 be
>  	  called da9150-charger.
>=20
> +config FG_DA9150
> +	tristate "Dialog Semiconductor DA9150 Fuel Gauge support"
> +	depends on CHARGER_DA9150
> +	help
> +	  Say Y here to enable support for the Fuel-Gauge unit of the DA915=
0
> +	  Integrated Charger & Fuel-Gauge IC
> +
> +	  This driver can also be built as a module. If so, the module will=
 be
> +	  called da9150-fg.
> +
>  config AXP288_FUEL_GAUGE
>  	tristate "X-Powers AXP288 Fuel Gauge"
>  	depends on MFD_AXP20X && IIO
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index b7b0181..b421b54 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_BATTERY_BQ27x00)	+=3D bq27x00_battery.=
o
>  obj-$(CONFIG_BATTERY_DA9030)	+=3D da9030_battery.o
>  obj-$(CONFIG_BATTERY_DA9052)	+=3D da9052-battery.o
>  obj-$(CONFIG_CHARGER_DA9150)	+=3D da9150-charger.o
> +obj-$(CONFIG_FG_DA9150)		+=3D da9150-fg.o
>  obj-$(CONFIG_BATTERY_MAX17040)	+=3D max17040_battery.o
>  obj-$(CONFIG_BATTERY_MAX17042)	+=3D max17042_battery.o
>  obj-$(CONFIG_BATTERY_Z2)	+=3D z2_battery.o
> diff --git a/drivers/power/da9150-fg.c b/drivers/power/da9150-fg.c
> new file mode 100644
> index 0000000..8dee156
> --- /dev/null
> +++ b/drivers/power/da9150-fg.c
> @@ -0,0 +1,589 @@
> +/*
> + * DA9150 Fuel-Gauge Driver
> + *
> + * Copyright (c) 2015 Dialog Semiconductor
> + *
> + * Author: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> + *
> + * This program is free software; you can redistribute  it and/or mo=
dify it
> + * under  the terms of  the GNU General  Public License as published=
 by the
> + * Free Software Foundation;  either version 2 of the  License, or (=
at your
> + * option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/power_supply.h>
> +#include <linux/list.h>
> +#include <asm/div64.h>
> +#include <linux/mfd/da9150/core.h>
> +#include <linux/mfd/da9150/registers.h>
> +#include <linux/mfd/da9150/fg.h>
> +
> +/* Core2Wire */
> +#define DA9150_QIF_READ		(0x0 << 7)
> +#define DA9150_QIF_WRITE	(0x1 << 7)
> +#define DA9150_QIF_CODE_MASK	0x7F
> +
> +#define DA9150_QIF_BYTE_SIZE	8
> +#define DA9150_QIF_BYTE_MASK	0xFF
> +#define DA9150_QIF_SHORT_SIZE	2
> +#define DA9150_QIF_LONG_SIZE	4
> +
> +/* QIF Codes */
> +#define DA9150_QIF_UAVG			6
> +#define DA9150_QIF_UAVG_SIZE		DA9150_QIF_LONG_SIZE
> +#define DA9150_QIF_IAVG			8
> +#define DA9150_QIF_IAVG_SIZE		DA9150_QIF_LONG_SIZE
> +#define DA9150_QIF_NTCAVG		12
> +#define DA9150_QIF_NTCAVG_SIZE		DA9150_QIF_LONG_SIZE
> +#define DA9150_QIF_SHUNT_VAL		36
> +#define DA9150_QIF_SHUNT_VAL_SIZE	DA9150_QIF_SHORT_SIZE
> +#define DA9150_QIF_SD_GAIN		38
> +#define DA9150_QIF_SD_GAIN_SIZE		DA9150_QIF_LONG_SIZE
> +#define DA9150_QIF_FCC_MAH		40
> +#define DA9150_QIF_FCC_MAH_SIZE		DA9150_QIF_SHORT_SIZE
> +#define DA9150_QIF_SOC_PCT		43
> +#define DA9150_QIF_SOC_PCT_SIZE		DA9150_QIF_SHORT_SIZE
> +#define DA9150_QIF_CHARGE_LIMIT		44
> +#define DA9150_QIF_CHARGE_LIMIT_SIZE	DA9150_QIF_SHORT_SIZE
> +#define DA9150_QIF_DISCHARGE_LIMIT	45
> +#define DA9150_QIF_DISCHARGE_LIMIT_SIZE	DA9150_QIF_SHORT_SIZE
> +#define DA9150_QIF_FW_MAIN_VER		118
> +#define DA9150_QIF_FW_MAIN_VER_SIZE	DA9150_QIF_SHORT_SIZE
> +#define DA9150_QIF_E_FG_STATUS		126
> +#define DA9150_QIF_E_FG_STATUS_SIZE	DA9150_QIF_SHORT_SIZE
> +#define DA9150_QIF_SYNC			127
> +#define DA9150_QIF_SYNC_SIZE		DA9150_QIF_SHORT_SIZE
> +#define DA9150_QIF_MAX_CODES		128
> +
> +/* QIF Sync Timeout */
> +#define DA9150_QIF_SYNC_TIMEOUT		1000
> +#define DA9150_QIF_SYNC_RETRIES		10
> +
> +/* QIF E_FG_STATUS */
> +#define DA9150_FG_IRQ_LOW_SOC_MASK	(1 << 0)
> +#define DA9150_FG_IRQ_HIGH_SOC_MASK	(1 << 1)
> +
> +/* Private data */
> +struct da9150_fg {
> +	struct da9150 *da9150;
> +	struct device *dev;
> +
> +	struct mutex io_lock;
> +
> +	struct power_supply *battery;
> +	struct delayed_work work;
> +	u32 interval;
> +
> +	da9150_read_temp_t read_bat_temp;
> +	void *bat_temp_context;
> +
> +	int warn_soc;
> +	int crit_soc;
> +	int soc;
> +};
> +
> +/* Battery Properties */
> +static u32 da9150_fg_read_attr(struct da9150_fg *fg, u8 code, u8 siz=
e)
> +
> +{
> +	u8 buf[size];
> +	u8 read_addr;
> +	u32 res =3D 0;
> +	int i;
> +
> +	/* Set QIF code (READ mode) */
> +	read_addr =3D (code & DA9150_QIF_CODE_MASK) | DA9150_QIF_READ;
> +
> +	da9150_read_qif(fg->da9150, read_addr, size, buf);
> +	for (i =3D 0; i < size; ++i)
> +		res |=3D (buf[i] << (i * DA9150_QIF_BYTE_SIZE));
> +
> +	return res;
> +}
> +
> +static void da9150_fg_write_attr(struct da9150_fg *fg, u8 code, u8 s=
ize,
> +				 u32 val)
> +
> +{
> +	u8 buf[size];
> +	u8 write_addr;
> +	int i;
> +
> +	/* Set QIF code (WRITE mode) */
> +	write_addr =3D (code & DA9150_QIF_CODE_MASK) | DA9150_QIF_WRITE;
> +
> +	for (i =3D 0; i < size; ++i) {
> +		buf[i] =3D (val >> (i * DA9150_QIF_BYTE_SIZE)) &
> +			 DA9150_QIF_BYTE_MASK;
> +	}
> +	da9150_write_qif(fg->da9150, write_addr, size, buf);
> +}
> +
> +/* Trigger QIF Sync to update QIF readable data */
> +static void da9150_fg_read_sync_start(struct da9150_fg *fg)
> +{
> +	int i =3D 0;
> +	u32 res =3D 0;
> +
> +	mutex_lock(&fg->io_lock);
> +
> +	/* Check if QIF sync already requested, and write to sync if not */
> +	res =3D da9150_fg_read_attr(fg, DA9150_QIF_SYNC,
> +				  DA9150_QIF_SYNC_SIZE);
> +	if (res > 0)
> +		da9150_fg_write_attr(fg, DA9150_QIF_SYNC,
> +				     DA9150_QIF_SYNC_SIZE, 0);
> +
> +	/* Wait for sync to complete */
> +	res =3D 0;
> +	while ((res =3D=3D 0) && (i++ < DA9150_QIF_SYNC_RETRIES)) {
> +		usleep_range(DA9150_QIF_SYNC_TIMEOUT,
> +			     DA9150_QIF_SYNC_TIMEOUT * 2);
> +		res =3D da9150_fg_read_attr(fg, DA9150_QIF_SYNC,
> +					  DA9150_QIF_SYNC_SIZE);
> +	}
> +
> +	/* Check if sync completed */
> +	if (res =3D=3D 0)
> +		dev_err(fg->dev, "Failed to perform QIF read sync!\n");
> +}
> +
> +/*
> + * Should always be called after QIF sync read has been performed, a=
nd all
> + * attributes required have been accessed.
> + */
> +static inline void da9150_fg_read_sync_end(struct da9150_fg *fg)
> +{
> +	mutex_unlock(&fg->io_lock);
> +}
> +
> +/* Wait for QIF Sync, write QIF data and wait for ack */
> +static void da9150_fg_write_attr_sync(struct da9150_fg *fg, u8 code,=
 u8 size,
> +				      u32 val)
> +{
> +	int i =3D 0;
> +	u32 res =3D 0, sync_val;
> +
> +	mutex_lock(&fg->io_lock);
> +
> +	/* Check if QIF sync already requested */
> +	res =3D da9150_fg_read_attr(fg, DA9150_QIF_SYNC,
> +				  DA9150_QIF_SYNC_SIZE);
> +
> +	/* Wait for an existing sync to complete */
> +	while ((res =3D=3D 0) && (i++ < DA9150_QIF_SYNC_RETRIES)) {
> +		usleep_range(DA9150_QIF_SYNC_TIMEOUT,
> +			     DA9150_QIF_SYNC_TIMEOUT * 2);
> +		res =3D da9150_fg_read_attr(fg, DA9150_QIF_SYNC,
> +					  DA9150_QIF_SYNC_SIZE);
> +	}
> +
> +	if (res =3D=3D 0) {
> +		dev_err(fg->dev, "Timeout waiting for existing QIF sync!\n");
> +		mutex_unlock(&fg->io_lock);
> +		return;
> +	}
> +
> +	/* Write value for QIF code */
> +	da9150_fg_write_attr(fg, code, size, val);
> +
> +	/* Wait for write acknowledgment */
> +	i =3D 0;
> +	sync_val =3D res;
> +	while ((res =3D=3D sync_val) && (i++ < DA9150_QIF_SYNC_RETRIES)) {
> +		usleep_range(DA9150_QIF_SYNC_TIMEOUT,
> +			     DA9150_QIF_SYNC_TIMEOUT * 2);
> +		res =3D da9150_fg_read_attr(fg, DA9150_QIF_SYNC,
> +					  DA9150_QIF_SYNC_SIZE);
> +	}
> +
> +	mutex_unlock(&fg->io_lock);
> +
> +	/* Check write was actually successful */
> +	if (res !=3D (sync_val + 1))
> +		dev_err(fg->dev, "Error performing QIF sync write for code %d\n",
> +			code);
> +}
> +
> +/* Power Supply attributes */
> +static int da9150_fg_capacity(struct da9150_fg *fg,
> +			      union power_supply_propval *val)
> +{
> +	da9150_fg_read_sync_start(fg);
> +	val->intval =3D da9150_fg_read_attr(fg, DA9150_QIF_SOC_PCT,
> +					  DA9150_QIF_SOC_PCT_SIZE);
> +	da9150_fg_read_sync_end(fg);
> +
> +	if (val->intval > 100)
> +		val->intval =3D 100;
> +
> +	return 0;
> +}
> +
> +static int da9150_fg_current_avg(struct da9150_fg *fg,
> +				 union power_supply_propval *val)
> +{
> +	u32 iavg, sd_gain, shunt_val;
> +	u64 div, res;
> +
> +	da9150_fg_read_sync_start(fg);
> +	iavg =3D da9150_fg_read_attr(fg, DA9150_QIF_IAVG,
> +				   DA9150_QIF_IAVG_SIZE);
> +	shunt_val =3D da9150_fg_read_attr(fg, DA9150_QIF_SHUNT_VAL,
> +					DA9150_QIF_SHUNT_VAL_SIZE);
> +	sd_gain =3D da9150_fg_read_attr(fg, DA9150_QIF_SD_GAIN,
> +				      DA9150_QIF_SD_GAIN_SIZE);
> +	da9150_fg_read_sync_end(fg);
> +
> +	div =3D (u64) (sd_gain * shunt_val * 65536ULL);
> +	do_div(div, 1000000);
> +	res =3D (u64) (iavg * 1000000ULL);
> +	do_div(res, div);
> +
> +	val->intval =3D (int) res;
> +
> +	return 0;
> +}
> +
> +static int da9150_fg_voltage_avg(struct da9150_fg *fg,
> +				 union power_supply_propval *val)
> +{
> +	u64 res;
> +
> +	da9150_fg_read_sync_start(fg);
> +	val->intval =3D da9150_fg_read_attr(fg, DA9150_QIF_UAVG,
> +					  DA9150_QIF_UAVG_SIZE);
> +	da9150_fg_read_sync_end(fg);
> +
> +	res =3D (u64) (val->intval * 186ULL);
> +	do_div(res, 10000);
> +	val->intval =3D (int) res;
> +
> +	return 0;
> +}
> +
> +static int da9150_fg_charge_full(struct da9150_fg *fg,
> +				 union power_supply_propval *val)
> +{
> +	da9150_fg_read_sync_start(fg);
> +	val->intval =3D da9150_fg_read_attr(fg, DA9150_QIF_FCC_MAH,
> +					  DA9150_QIF_FCC_MAH_SIZE);
> +	da9150_fg_read_sync_end(fg);
> +
> +	val->intval =3D val->intval * 1000;
> +
> +	return 0;
> +}
> +
> +static int da9150_fg_temp(struct da9150_fg *fg,
> +			  union power_supply_propval *val)
> +{
> +	if (!fg->read_bat_temp) {
> +		da9150_fg_read_sync_start(fg);
> +		val->intval =3D da9150_fg_read_attr(fg, DA9150_QIF_NTCAVG,
> +						  DA9150_QIF_NTCAVG_SIZE);
> +		da9150_fg_read_sync_end(fg);
> +
> +		val->intval =3D (val->intval * 10) / 1048576;
> +	} else {
> +		val->intval =3D fg->read_bat_temp(fg->bat_temp_context);
> +	}
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property da9150_fg_props[] =3D {
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	POWER_SUPPLY_PROP_VOLTAGE_AVG,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_TEMP,
> +};
> +
> +static int da9150_fg_get_prop(struct power_supply *psy,
> +			      enum power_supply_property psp,
> +			      union power_supply_propval *val)
> +{
> +	struct da9150_fg *fg =3D dev_get_drvdata(psy->dev.parent);
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		ret =3D da9150_fg_capacity(fg, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_AVG:
> +		ret =3D da9150_fg_current_avg(fg, val);
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> +		ret =3D da9150_fg_voltage_avg(fg, val);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		ret =3D da9150_fg_charge_full(fg, val);
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		ret =3D da9150_fg_temp(fg, val);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/* Repeated SOC check */
> +static bool da9150_fg_soc_changed(struct da9150_fg *fg)
> +{
> +	union power_supply_propval val;
> +
> +	da9150_fg_capacity(fg, &val);
> +	if (val.intval !=3D fg->soc) {
> +		fg->soc =3D val.intval;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void da9150_fg_work(struct work_struct *work)
> +{
> +	struct da9150_fg *fg =3D container_of(work, struct da9150_fg, work.=
work);
> +
> +	/* Report if SOC has changed */
> +	if (da9150_fg_soc_changed(fg))
> +		power_supply_changed(fg->battery);
> +
> +	schedule_delayed_work(&fg->work, msecs_to_jiffies(fg->interval));
> +}
> +
> +/* Register external function to give battery temperature */
> +void da9150_fg_register_temp_cb(struct power_supply *psy, da9150_rea=
d_temp_t cb,
> +				void *cb_context)
> +{
> +	struct da9150_fg *fg =3D dev_get_drvdata(psy->dev.parent);
> +
> +	fg->read_bat_temp =3D cb;
> +	fg->bat_temp_context =3D cb_context;
> +}
> +EXPORT_SYMBOL_GPL(da9150_fg_register_temp_cb);
> +
> +/* SOC level event configuration */
> +static void da9150_fg_soc_event_config(struct da9150_fg *fg)
> +{
> +	int soc;
> +
> +	da9150_fg_read_sync_start(fg);
> +	soc =3D da9150_fg_read_attr(fg, DA9150_QIF_SOC_PCT,
> +				  DA9150_QIF_SOC_PCT_SIZE);
> +	da9150_fg_read_sync_end(fg);
> +
> +	if (soc > fg->warn_soc) {
> +		/* If SOC > warn level, set discharge warn level event */
> +		da9150_fg_write_attr_sync(fg, DA9150_QIF_DISCHARGE_LIMIT,
> +					  DA9150_QIF_DISCHARGE_LIMIT_SIZE,
> +					  fg->warn_soc + 1);
> +	} else if ((soc <=3D fg->warn_soc) && (soc > fg->crit_soc)) {
> +		/*
> +		 * If SOC <=3D warn level, set discharge crit level event,
> +		 * and set charge warn level event.
> +		 */
> +		da9150_fg_write_attr_sync(fg, DA9150_QIF_DISCHARGE_LIMIT,
> +					  DA9150_QIF_DISCHARGE_LIMIT_SIZE,
> +					  fg->crit_soc + 1);
> +
> +		da9150_fg_write_attr_sync(fg, DA9150_QIF_CHARGE_LIMIT,
> +					  DA9150_QIF_CHARGE_LIMIT_SIZE,
> +					  fg->warn_soc);
> +	} else if (soc <=3D fg->crit_soc) {
> +		/* If SOC <=3D crit level, set charge crit level event */
> +		da9150_fg_write_attr_sync(fg, DA9150_QIF_CHARGE_LIMIT,
> +					  DA9150_QIF_CHARGE_LIMIT_SIZE,
> +					  fg->crit_soc);
> +	}
> +}
> +
> +static irqreturn_t da9150_fg_irq(int irq, void *data)
> +{
> +	struct da9150_fg *fg =3D data;
> +	u32 e_fg_status;
> +
> +	/* Read FG IRQ status info */
> +	e_fg_status =3D da9150_fg_read_attr(fg, DA9150_QIF_E_FG_STATUS,
> +					  DA9150_QIF_E_FG_STATUS_SIZE);
> +
> +	/* Handle warning/critical threhold events */
> +	if ((DA9150_FG_IRQ_LOW_SOC_MASK | DA9150_FG_IRQ_HIGH_SOC_MASK) &
> +	    e_fg_status)
> +		da9150_fg_soc_event_config(fg);
> +
> +	/* Clear any FG IRQs */
> +	da9150_fg_write_attr(fg, DA9150_QIF_E_FG_STATUS,
> +			     DA9150_QIF_E_FG_STATUS_SIZE, e_fg_status);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct da9150_fg_pdata *da9150_fg_dt_pdata(struct device *dev=
)
> +{
> +	struct device_node *fg_node =3D dev->of_node;
> +	struct da9150_fg_pdata *pdata;
> +
> +	pdata =3D devm_kzalloc(dev, sizeof(struct da9150_fg_pdata), GFP_KER=
NEL);
> +	if (!pdata)
> +		return NULL;
> +
> +	of_property_read_u32(fg_node, "dlg,update-interval",
> +			     &pdata->update_interval);
> +	of_property_read_u8(fg_node, "dlg,warn-soc-level",
> +			    &pdata->warn_soc_lvl);
> +	of_property_read_u8(fg_node, "dlg,crit-soc-level",
> +			    &pdata->crit_soc_lvl);
> +
> +	return pdata;
> +}
> +
> +static const struct power_supply_desc fg_desc =3D {
> +	.name		=3D "da9150-fg",
> +	.type		=3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties	=3D da9150_fg_props,
> +	.num_properties	=3D ARRAY_SIZE(da9150_fg_props),
> +	.get_property	=3D da9150_fg_get_prop,
> +};
> +
> +static int da9150_fg_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct da9150 *da9150 =3D dev_get_drvdata(dev->parent);
> +	struct da9150_fg_pdata *fg_pdata =3D dev_get_platdata(dev);
> +	struct da9150_fg *fg;
> +	int ver, irq, ret;
> +
> +	fg =3D devm_kzalloc(dev, sizeof(*fg), GFP_KERNEL);
> +	if (fg =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, fg);
> +	fg->da9150 =3D da9150;
> +	fg->dev =3D dev;
> +
> +	mutex_init(&fg->io_lock);
> +
> +	/* Enable QIF */
> +	da9150_set_bits(da9150, DA9150_CORE2WIRE_CTRL_A, DA9150_FG_QIF_EN_M=
ASK,
> +			DA9150_FG_QIF_EN_MASK);
> +
> +	fg->battery =3D power_supply_register(dev, &fg_desc, NULL);
> +	if (IS_ERR(fg->battery)) {
> +		ret =3D PTR_ERR(fg->battery);
> +		return ret;
> +	}
> +
> +	ver =3D da9150_fg_read_attr(fg, DA9150_QIF_FW_MAIN_VER,
> +				  DA9150_QIF_FW_MAIN_VER_SIZE);
> +	dev_info(dev, "Version: 0x%x\n", ver);
> +
> +	/* Handle DT data if provided */
> +	if (dev->of_node) {
> +		fg_pdata =3D da9150_fg_dt_pdata(dev);
> +		dev->platform_data =3D fg_pdata;
> +	}
> +
> +	/* Handle any pdata provided */
> +	if (fg_pdata) {
> +		fg->interval =3D fg_pdata->update_interval;
> +
> +		if (fg_pdata->warn_soc_lvl > 100)
> +			dev_warn(dev, "Invalid SOC warning level provided, Ignoring");
> +		else
> +			fg->warn_soc =3D fg_pdata->warn_soc_lvl;
> +
> +		if ((fg_pdata->crit_soc_lvl > 100) ||
> +		    (fg_pdata->crit_soc_lvl >=3D fg_pdata->warn_soc_lvl))
> +			dev_warn(dev, "Invalid SOC critical level provided, Ignoring");
> +		else
> +			fg->crit_soc =3D fg_pdata->crit_soc_lvl;
> +
> +
> +	}
> +
> +	/* Configure initial SOC level events */
> +	da9150_fg_soc_event_config(fg);
> +
> +	/*
> +	 * If an interval period has been provided then setup repeating
> +	 * work for reporting data updates.
> +	 */
> +	if (fg->interval) {
> +		INIT_DELAYED_WORK(&fg->work, da9150_fg_work);
> +		schedule_delayed_work(&fg->work,
> +				      msecs_to_jiffies(fg->interval));
> +	}
> +
> +	/* Register IRQ */
> +	irq =3D platform_get_irq_byname(pdev, "FG");
> +	ret =3D request_threaded_irq(irq, NULL, da9150_fg_irq, IRQF_ONESHOT=
, "FG",
> +				   fg);
> +	if (ret)
> +		goto irq_fail;
> +
> +	return ret;
> +
> +irq_fail:
> +	cancel_delayed_work(&fg->work);
> +	power_supply_unregister(fg->battery);
> +
> +	return ret;
> +}
> +
> +static int da9150_fg_remove(struct platform_device *pdev)
> +{
> +	struct da9150_fg *fg =3D platform_get_drvdata(pdev);
> +	int irq;
> +
> +	irq =3D platform_get_irq_byname(pdev, "FG");
> +	free_irq(irq, fg);
> +
> +	if (fg->interval)
> +		cancel_delayed_work(&fg->work);
> +
> +	power_supply_unregister(fg->battery);
> +
> +	return 0;
> +}
> +
> +static int da9150_fg_resume(struct platform_device *pdev)
> +{
> +	struct da9150_fg *fg =3D platform_get_drvdata(pdev);
> +
> +	/*
> +	 * Trigger SOC check to happen now so as to indicate any value chan=
ge
> +	 * since last check before suspend.
> +	 */
> +	if (fg->interval)
> +		flush_delayed_work(&fg->work);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver da9150_fg_driver =3D {
> +	.driver =3D {
> +		.name =3D "da9150-fuelgauge",
> +	},
> +	.probe =3D da9150_fg_probe,
> +	.remove =3D da9150_fg_remove,
> +	.resume =3D da9150_fg_resume,
> +};
> +
> +module_platform_driver(da9150_fg_driver);
> +
> +MODULE_DESCRIPTION("Fuel-Gauge Driver for DA9150");
> +MODULE_AUTHOR("Adam Thomson <Adam.Thomson.Opensource@diasemi.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/da9150/fg.h b/include/linux/mfd/da9150=
/fg.h
> index 0ff52ab..2cff203 100644
> --- a/include/linux/mfd/da9150/fg.h
> +++ b/include/linux/mfd/da9150/fg.h
> @@ -26,4 +26,14 @@ struct da9150_fg_pdata {
>  	u8 crit_soc_lvl;	/* % value */
>  };
>=20
> +/*
> + * Function template to provide battery temperature. Should provide
> + * 0.1 degrees C resolution return values.
> + */
> +typedef int (*da9150_read_temp_t)(void *context);
> +
> +/* Register temp callback function */
> +void da9150_fg_register_temp_cb(struct power_supply *psy, da9150_rea=
d_temp_t cb,
> +				void *cb_context);
> +
>  #endif /* __DA9150_FG_H */

I still don't get why you think pointers are better than just calling
the function directly.  Can the *fn() ever point to different functions=
?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
