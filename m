From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [RFC PATCH] power: bq24261_charger: Add support for TI BQ24261
 charger
Date: Tue, 18 Aug 2015 09:24:44 -0500
Message-ID: <20150818142442.GA11344@borg>
References: <1439920175-12049-1-git-send-email-ramakrishna.pallala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38773 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240AbbHROe0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 18 Aug 2015 10:34:26 -0400
Content-Disposition: inline
In-Reply-To: <1439920175-12049-1-git-send-email-ramakrishna.pallala@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Jenny Tc <jenny.tc@intel.com>

Hi,

On Tue, Aug 18, 2015 at 11:19:35PM +0530, Ramakrishna Pallala wrote:
> Add new charger driver support for BQ24261 charger IC.
> 
> Signed-off-by: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
> ---
>  drivers/power/Kconfig                 |    6 +
>  drivers/power/Makefile                |    1 +
>  drivers/power/bq24261_charger.c       | 1127 +++++++++++++++++++++++++++++++++
>  include/linux/power/bq24261_charger.h |   26 +
>  4 files changed, 1160 insertions(+)
>  create mode 100644 drivers/power/bq24261_charger.c
>  create mode 100644 include/linux/power/bq24261_charger.h
> 
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 08beeed..9bda940 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -395,6 +395,12 @@ config CHARGER_BQ24190
>  	help
>  	  Say Y to enable support for the TI BQ24190 battery charger.
>  
> +config CHARGER_BQ24261
> +	tristate "TI BQ24261 charger driver"
> +	depends on I2C && EXTCON
> +	help
> +	  Say Y here to enable support for TI BQ24261 battery charger.
> +
>  config CHARGER_BQ24257
>  	tristate "TI BQ24257 battery charger driver"
>  	depends on I2C && GPIOLIB
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index 5752ce8..bec8409 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
>  obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
>  obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
>  obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
> +obj-$(CONFIG_CHARGER_BQ24261)	+= bq24261_charger.o
>  obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
>  obj-$(CONFIG_CHARGER_BQ24735)	+= bq24735-charger.o
>  obj-$(CONFIG_CHARGER_BQ25890)	+= bq25890_charger.o
> diff --git a/drivers/power/bq24261_charger.c b/drivers/power/bq24261_charger.c
> new file mode 100644
> index 0000000..b96d7a3
> --- /dev/null
> +++ b/drivers/power/bq24261_charger.c
> @@ -0,0 +1,1127 @@
> +/*
> + * bq24261_charger.c - BQ24261 Charger driver
> + *
> + * Copyright (C) 2014 Intel Corporation
> + * Author:	Jenny TC <jenny.tc@intel.com>
> + *		Ramakrishna Pallala <ramakrishna.pallala@intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/version.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/power_supply.h>
> +#include <linux/extcon.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/io.h>
> +#include <linux/sched.h>
> +#include <linux/delay.h>
> +#include <linux/power/bq24261_charger.h>
> +
> +#define DEV_NAME "bq24261_charger"
> +
> +#define EXCEPTION_MONITOR_DELAY		(60 * HZ)
> +#define WDT_RESET_DELAY			(15 * HZ)
> +
> +/* BQ24261 registers */
> +#define BQ24261_STAT_CTRL0_ADDR		0x00
> +#define BQ24261_CTRL_ADDR		0x01
> +#define BQ24261_BATT_VOL_CTRL_ADDR	0x02
> +#define BQ24261_VENDOR_REV_ADDR		0x03
> +#define BQ24261_TERM_FCC_ADDR		0x04
> +#define BQ24261_VINDPM_STAT_ADDR	0x05
> +#define BQ24261_ST_NTC_MON_ADDR		0x06
> +
> +#define BQ24261_RESET_MASK		(0x01 << 7)
> +#define BQ24261_RESET_ENABLE		(0x01 << 7)
> +
> +#define BQ24261_FAULT_MASK		0x07
> +#define BQ24261_STAT_MASK		(0x03 << 4)
> +#define BQ24261_BOOST_MASK		(0x01 << 6)
> +#define BQ24261_TMR_RST_MASK		(0x01 << 7)
> +#define BQ24261_TMR_RST			(0x01 << 7)
> +
> +#define BQ24261_ENABLE_BOOST		(0x01 << 6)
> +
> +#define BQ24261_VOVP			0x01
> +#define BQ24261_LOW_SUPPLY		0x02
> +#define BQ24261_THERMAL_SHUTDOWN	0x03
> +#define BQ24261_BATT_TEMP_FAULT		0x04
> +#define BQ24261_TIMER_FAULT		0x05
> +#define BQ24261_BATT_OVP		0x06
> +#define BQ24261_NO_BATTERY		0x07
> +#define BQ24261_STAT_READY		0x00
> +
> +#define BQ24261_STAT_CHRG_PRGRSS	(0x01 << 4)
> +#define BQ24261_STAT_CHRG_DONE		(0x02 << 4)
> +#define BQ24261_STAT_FAULT		(0x03 << 4)
> +
> +#define BQ24261_CE_MASK			(0x01 << 1)
> +#define BQ24261_CE_DISABLE		(0x01 << 1)
> +
> +#define BQ24261_HiZ_MASK			(0x01)
> +#define BQ24261_HiZ_ENABLE		(0x01)
> +
> +#define BQ24261_ICHRG_MASK		(0x1F << 3)
> +
> +#define BQ24261_ITERM_MASK		(0x03)
> +#define BQ24261_MIN_ITERM		50 /* 50 mA */
> +#define BQ24261_MAX_ITERM		300 /* 300 mA */
> +
> +#define BQ24261_VBREG_MASK		(0x3F << 2)
> +#define BQ24261_VBREG_MIN_CV		3500
> +#define BQ24261_VBREG_MAX_CV		4440
> +#define BQ24261_VBREG_CV_DIV		20
> +#define BQ24261_VBREG_CV_BIT_POS	2
> +
> +#define BQ24261_INLMT_MASK		(0x07 << 4)
> +#define BQ24261_INLMT_100		0x00
> +#define BQ24261_INLMT_150		(0x01 << 4)
> +#define BQ24261_INLMT_500		(0x02 << 4)
> +#define BQ24261_INLMT_900		(0x03 << 4)
> +#define BQ24261_INLMT_1500		(0x04 << 4)
> +#define BQ24261_INLMT_2000		(0x05 << 4)
> +#define BQ24261_INLMT_2500		(0x06 << 4)
> +
> +#define BQ24261_TE_MASK			(0x01 << 2)
> +#define BQ24261_TE_ENABLE		(0x01 << 2)
> +#define BQ24261_STAT_ENABLE_MASK	(0x01 << 3)
> +#define BQ24261_STAT_ENABLE		(0x01 << 3)
> +
> +#define BQ24261_VENDOR_MASK		(0x07 << 5)
> +#define BQ24261_PART_MASK		(0x03 << 3)
> +#define BQ24261_REV_MASK		(0x07)
> +#define VENDOR_BQ2426X			(0x02 << 5)
> +#define REV_BQ24261			(0x06)
> +
> +#define BQ24261_TS_MASK			(0x01 << 3)
> +#define BQ24261_TS_ENABLED		(0x01 << 3)
> +#define BQ24261_BOOST_ILIM_MASK		(0x01 << 4)
> +#define BQ24261_BOOST_ILIM_500ma	(0x0)
> +#define BQ24261_BOOST_ILIM_1A		(0x01 << 4)
> +#define BQ24261_VINDPM_OFF_MASK		(0x01 << 0)
> +#define BQ24261_VINDPM_OFF_5V		(0x0)
> +#define BQ24261_VINDPM_OFF_12V		(0x01 << 0)
> +
> +#define BQ24261_SAFETY_TIMER_MASK	(0x03 << 5)
> +#define BQ24261_SAFETY_TIMER_40MIN	0x00
> +#define BQ24261_SAFETY_TIMER_6HR	(0x01 << 5)
> +#define BQ24261_SAFETY_TIMER_9HR	(0x02 << 5)
> +#define BQ24261_SAFETY_TIMER_DISABLED	(0x03 << 5)
> +
> +/* 1% above voltage max design to report over voltage */
> +#define BQ24261_OVP_MULTIPLIER			1010
> +#define BQ24261_OVP_RECOVER_MULTIPLIER		990
> +#define BQ24261_DEF_BAT_VOLT_MAX_DESIGN		4200000
> +
> +/* Settings for Voltage / DPPM Register (05) */
> +#define BQ24261_VBATT_LEVEL1		3700000
> +#define BQ24261_VBATT_LEVEL2		3960000
> +#define BQ24261_VINDPM_MASK		(0x07)
> +#define BQ24261_VINDPM_320MV		(0x01 << 2)
> +#define BQ24261_VINDPM_160MV		(0x01 << 1)
> +#define BQ24261_VINDPM_80MV		(0x01 << 0)
> +#define BQ24261_CD_STATUS_MASK		(0x01 << 3)
> +#define BQ24261_DPM_EN_MASK		(0x01 << 4)
> +#define BQ24261_DPM_EN_FORCE		(0x01 << 4)
> +#define BQ24261_LOW_CHG_MASK		(0x01 << 5)
> +#define BQ24261_LOW_CHG_EN		(0x01 << 5)
> +#define BQ24261_LOW_CHG_DIS		(~BQ24261_LOW_CHG_EN)
> +#define BQ24261_DPM_STAT_MASK		(0x01 << 6)
> +#define BQ24261_MINSYS_STAT_MASK	(0x01 << 7)
> +
> +#define BQ24261_MIN_CC			500	/* 500mA */
> +#define BQ24261_MAX_CC			3000	/* 3A */
> +#define BQ24261_DEF_CC			1300	/* 1300mA */
> +#define BQ24261_MAX_CV			4350	/*4350mV */
> +#define BQ24261_DEF_CV			4350	/* 4350mV */
> +#define BQ24261_DEF_ITERM		128	/* 128mA */
> +#define BQ24261_MIN_TEMP		0	/* 0 degC */
> +#define BQ24261_MAX_TEMP		60	/* 60 DegC */
> +
> +#define ILIM_100MA			100	/* 100mA */
> +#define ILIM_500MA			500	/* 500mA */
> +#define ILIM_900MA			900	/* 900mA */
> +#define ILIM_1500MA			1500	/* 1500mA */
> +#define ILIM_2000MA			2000	/* 2000mA */
> +#define ILIM_2500MA			2500	/* 2500mA */
> +#define ILIM_3000MA			3000	/* 3000mA */
> +
> +u16 bq24261_inlmt[][2] = {
> +	{100, BQ24261_INLMT_100},
> +	{150, BQ24261_INLMT_150},
> +	{500, BQ24261_INLMT_500},
> +	{900, BQ24261_INLMT_900},
> +	{1500, BQ24261_INLMT_1500},
> +	{2000, BQ24261_INLMT_2000},
> +	{2500, BQ24261_INLMT_2500},
> +};
> +
> +
> +enum bq24261_status {
> +	BQ24261_CHRGR_STAT_UNKNOWN,
> +	BQ24261_CHRGR_STAT_READY,
> +	BQ24261_CHRGR_STAT_CHARGING,
> +	BQ24261_CHRGR_STAT_FULL,
> +	BQ24261_CHRGR_STAT_FAULT,
> +};
> +
> +enum bq2426x_model {
> +	BQ2426X = 0,
> +	BQ24260,
> +	BQ24261,
> +};
> +
> +struct bq24261_charger {
> +	struct i2c_client *client;
> +	struct bq24261_platform_data *pdata;
> +	struct power_supply *psy_usb;
> +	struct delayed_work fault_mon_work;
> +	struct mutex lock;
> +	enum bq2426x_model model;
> +	struct delayed_work wdt_work;
> +	struct work_struct irq_work;
> +	struct list_head irq_queue;
> +
> +	/* extcon charger cables */
> +	struct {
> +		struct work_struct work;
> +		struct notifier_block nb;
> +		struct extcon_specific_cable_nb sdp;
> +		struct extcon_specific_cable_nb cdp;
> +		struct extcon_specific_cable_nb dcp;
> +		struct extcon_specific_cable_nb otg;
> +		enum power_supply_type chg_type;
> +		bool boost;
> +		bool connected;
> +	} cable;
> +
> +	bool online;
> +	bool present;
> +	int chg_health;
> +	enum bq24261_status chg_status;
> +	int cc;
> +	int cv;
> +	int inlmt;
> +	int max_cc;
> +	int max_cv;
> +	int iterm;
> +	int max_temp;
> +	int min_temp;
> +	bool is_charging_enabled;
> +};
> +
> +static inline int bq24261_read_reg(struct i2c_client *client, u8 reg)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, reg);
> +	if (ret < 0)
> +		dev_err(&client->dev,
> +			"error(%d) in reading reg %d\n", ret, reg);
> +	return ret;
> +}
> +
> +static inline int bq24261_write_reg(struct i2c_client *client, u8 reg, u8 data)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, reg, data);
> +	if (ret < 0)
> +		dev_err(&client->dev,
> +			"error(%d) in writing %d to reg %d\n", ret, data, reg);
> +	return ret;
> +}
> +
> +static inline int bq24261_update_reg(struct i2c_client *client, u8 reg,
> +					  u8 mask, u8 val)
> +{
> +	int ret;
> +
> +	ret = bq24261_read_reg(client, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = (ret & ~mask) | (mask & val);
> +	return bq24261_write_reg(client, reg, ret);
> +}
> +
> +static void lookup_regval(u16 tbl[][2], size_t size, u16 in_val, u8 *out_val)
> +{
> +	int i;
> +
> +	for (i = 1; i < size; ++i) {
> +		if (in_val < tbl[i][0])
> +			break;
> +	}
> +
> +	*out_val = (u8) tbl[i - 1][1];
> +}
> +
> +void bq24261_cc_to_reg(int cc, u8 *reg_val)
> +{
> +	/* Ichrg bits are B3-B7
> +	 * Icharge = 500mA + IchrgCode * 100mA
> +	 */
> +	cc = clamp_t(int, cc, BQ24261_MIN_CC, BQ24261_MAX_CC);
> +	cc = cc - BQ24261_MIN_CC;
> +	*reg_val = (cc / 100) << 3;
> +}
> +
> +void bq24261_cv_to_reg(int cv, u8 *reg_val)
> +{
> +	int val;
> +
> +	val = clamp_t(int, cv, BQ24261_VBREG_MIN_CV, BQ24261_VBREG_MAX_CV);
> +	*reg_val = (((val - BQ24261_VBREG_MIN_CV) / BQ24261_VBREG_CV_DIV)
> +			<< BQ24261_VBREG_CV_BIT_POS);
> +}
> +
> +void bq24261_inlmt_to_reg(int inlmt, u8 *regval)
> +{
> +	return lookup_regval(bq24261_inlmt, ARRAY_SIZE(bq24261_inlmt),
> +			     inlmt, regval);
> +}
> +
> +static inline void bq24261_iterm_to_reg(int iterm, u8 *regval)
> +{
> +	/* Iterm bits are B0-B2
> +	 * Icharge = 50mA + ItermCode * 50mA
> +	 */
> +	iterm = clamp_t(int, iterm, BQ24261_MIN_ITERM,  BQ24261_MAX_ITERM);
> +	iterm = iterm - BQ24261_MIN_ITERM;
> +	*regval =  iterm / 50;
> +}
> +
> +static inline int bq24261_init_timers(struct bq24261_charger *chip)
> +{
> +	u8 reg_val;
> +	int ret;
> +
> +	reg_val = BQ24261_SAFETY_TIMER_9HR;
> +
> +	if (chip->pdata->thermal_sensing)
> +		reg_val |= BQ24261_TS_ENABLED;
> +
> +	ret = bq24261_update_reg(chip->client, BQ24261_ST_NTC_MON_ADDR,
> +			BQ24261_TS_MASK | BQ24261_SAFETY_TIMER_MASK |
> +			BQ24261_BOOST_ILIM_MASK, reg_val);
> +
> +	return ret;
> +}
> +
> +static inline int bq24261_reset_wdt_timer(struct bq24261_charger *chip)
> +{
> +	u8 mask = BQ24261_TMR_RST_MASK, val = BQ24261_TMR_RST;
> +
> +	if (chip->cable.boost) {
> +		mask |= BQ24261_BOOST_MASK;
> +		val |= BQ24261_ENABLE_BOOST;
> +	}
> +
> +	return bq24261_update_reg(chip->client, BQ24261_STAT_CTRL0_ADDR,
> +							mask, val);
> +}
> +
> +static inline int bq24261_set_cc(struct bq24261_charger *chip, int cc_mA)
> +{
> +	u8 reg_val;
> +	int ret;
> +
> +	dev_dbg(&chip->client->dev, "%s=%d\n", __func__, cc_mA);
> +
> +	if (cc_mA && (cc_mA < BQ24261_MIN_CC)) {
> +		dev_dbg(&chip->client->dev, "Set LOW_CHG bit\n");
> +		reg_val = BQ24261_LOW_CHG_EN;
> +		ret = bq24261_update_reg(chip->client,
> +				BQ24261_VINDPM_STAT_ADDR,
> +				BQ24261_LOW_CHG_MASK, reg_val);
> +		return ret;
> +	}
> +
> +	reg_val = BQ24261_LOW_CHG_DIS;
> +	ret = bq24261_update_reg(chip->client, BQ24261_VINDPM_STAT_ADDR,
> +					BQ24261_LOW_CHG_MASK, reg_val);
> +
> +	bq24261_cc_to_reg(cc_mA, &reg_val);
> +
> +	return bq24261_update_reg(chip->client, BQ24261_TERM_FCC_ADDR,
> +			BQ24261_ICHRG_MASK, reg_val);
> +}
> +
> +static inline int bq24261_set_cv(struct bq24261_charger *chip, int cv_mV)
> +{
> +	u8 reg_val;
> +
> +	dev_dbg(&chip->client->dev, "%s=%d\n", __func__, cv_mV);
> +
> +	bq24261_cv_to_reg(cv_mV, &reg_val);
> +
> +	return bq24261_update_reg(chip->client, BQ24261_BATT_VOL_CTRL_ADDR,
> +				       BQ24261_VBREG_MASK, reg_val);
> +}
> +
> +static inline int bq24261_set_inlmt(struct bq24261_charger *chip, int inlmt)
> +{
> +	u8 reg_val;
> +
> +	dev_dbg(&chip->client->dev, "%s=%d\n", __func__, inlmt);
> +
> +	bq24261_inlmt_to_reg(inlmt, &reg_val);
> +
> +	/*
> +	 * Don't enable reset bit. Setting this
> +	 * bit will reset all the registers/
> +	 */
> +	reg_val &= ~BQ24261_RESET_MASK;
> +
> +	return bq24261_update_reg(chip->client, BQ24261_CTRL_ADDR,
> +		       BQ24261_RESET_MASK|BQ24261_INLMT_MASK, reg_val);
> +
> +}
> +
> +static inline int bq24261_set_iterm(struct bq24261_charger *chip, int iterm)
> +{
> +	u8 reg_val;
> +
> +	bq24261_iterm_to_reg(iterm, &reg_val);
> +
> +	return bq24261_update_reg(chip->client, BQ24261_TERM_FCC_ADDR,
> +				       BQ24261_ITERM_MASK, reg_val);
> +}
> +
> +static inline int bq24261_enable_charging(struct bq24261_charger *chip,
> +								bool enable)
> +{
> +	int ret;
> +	u8 reg_val;
> +
> +	if (enable) {
> +		reg_val = (~BQ24261_CE_DISABLE & BQ24261_CE_MASK);
> +		reg_val |= BQ24261_TE_ENABLE;
> +	} else {
> +		reg_val = BQ24261_CE_DISABLE;
> +	}
> +
> +	reg_val |=  BQ24261_STAT_ENABLE;
> +
> +	/*
> +	 * Don't enable reset bit. Setting this
> +	 * bit will reset all the registers/
> +	 */
> +	reg_val &= ~BQ24261_RESET_MASK;
> +
> +	ret = bq24261_update_reg(chip->client, BQ24261_CTRL_ADDR,
> +		       BQ24261_STAT_ENABLE_MASK|BQ24261_RESET_MASK|
> +				BQ24261_CE_MASK|BQ24261_TE_MASK,
> +					reg_val);
> +	if (ret || !enable)
> +		return ret;
> +
> +	/* Set termination current */
> +	ret = bq24261_set_iterm(chip, chip->iterm);
> +	if (ret < 0)
> +		dev_err(&chip->client->dev, "failed to set iTerm(%d)\n", ret);
> +
> +	/* Start WDT and Safety timers */
> +	ret = bq24261_init_timers(chip);
> +	if (ret)
> +		dev_err(&chip->client->dev, "failed to set timers(%d)\n", ret);
> +
> +	return ret;
> +}
> +
> +static inline int bq24261_enable_charger(struct bq24261_charger *chip,
> +								int enable)
> +{
> +	u8 reg_val;
> +	int ret;
> +
> +	reg_val = enable ? (~BQ24261_HiZ_ENABLE & BQ24261_HiZ_MASK) :
> +			BQ24261_HiZ_ENABLE;
> +
> +	/*
> +	 * Don't enable reset bit. Setting this
> +	 * bit will reset all the registers/
> +	 */
> +	reg_val &= ~BQ24261_RESET_MASK;
> +
> +	ret = bq24261_update_reg(chip->client, BQ24261_CTRL_ADDR,
> +		       BQ24261_HiZ_MASK|BQ24261_RESET_MASK, reg_val);
> +	if (ret)
> +		return ret;
> +
> +	return bq24261_reset_wdt_timer(chip);
> +}
> +
> +static void bq24261_handle_health(struct bq24261_charger *chip, u8 stat_reg)
> +{
> +	struct i2c_client *client = chip->client;
> +	bool fault_worker = false;
> +
> +	switch (stat_reg & BQ24261_FAULT_MASK) {
> +	case BQ24261_VOVP:
> +		chip->chg_health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		fault_worker = true;
> +		dev_err(&client->dev, "Charger Over Voltage Fault\n");
> +		break;
> +	case BQ24261_LOW_SUPPLY:
> +		chip->chg_health = POWER_SUPPLY_HEALTH_DEAD;
> +		fault_worker = true;
> +		dev_err(&client->dev, "Charger Low Supply Fault\n");
> +		break;
> +	case BQ24261_THERMAL_SHUTDOWN:
> +		chip->chg_health = POWER_SUPPLY_HEALTH_OVERHEAT;
> +		dev_err(&client->dev, "Charger Thermal Fault\n");
> +		break;
> +	case BQ24261_BATT_TEMP_FAULT:
> +		dev_err(&client->dev, "Battery Temperature Fault\n");
> +		break;
> +	case BQ24261_TIMER_FAULT:
> +		chip->chg_health = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> +		dev_err(&client->dev, "Charger Timer Fault\n");
> +		break;
> +	case BQ24261_BATT_OVP:
> +		chip->chg_health = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> +		dev_err(&client->dev, "Battery Over Voltage Fault\n");
> +		break;
> +	case BQ24261_NO_BATTERY:
> +		dev_err(&client->dev, "No Battery Connected\n");
> +		break;
> +	default:
> +		chip->chg_health = POWER_SUPPLY_HEALTH_GOOD;
> +	}
> +
> +	if (fault_worker)
> +		schedule_delayed_work(&chip->fault_mon_work,
> +					EXCEPTION_MONITOR_DELAY);
> +}
> +
> +static void bq24261_handle_status(struct bq24261_charger *chip, u8 stat_reg)
> +{
> +	struct i2c_client *client = chip->client;
> +
> +	switch (stat_reg & BQ24261_STAT_MASK) {
> +	case BQ24261_STAT_READY:
> +		chip->chg_status = BQ24261_CHRGR_STAT_READY;
> +		dev_info(&client->dev, "Charger Status: Ready\n");
> +		break;
> +	case BQ24261_STAT_CHRG_PRGRSS:
> +		chip->chg_status = BQ24261_CHRGR_STAT_CHARGING;
> +		dev_info(&client->dev, "Charger Status: Charge Progress\n");
> +		break;
> +	case BQ24261_STAT_CHRG_DONE:
> +		chip->chg_status = BQ24261_CHRGR_STAT_FULL;
> +		dev_info(&client->dev, "Charger Status: Charge Done\n");
> +		break;
> +	case BQ24261_STAT_FAULT:
> +		chip->chg_status = BQ24261_CHRGR_STAT_FAULT;
> +		dev_warn(&client->dev, "Charger Status: Fault\n");
> +		break;
> +	default:
> +		dev_info(&client->dev, "Invalid\n");
> +	}
> +}
> +
> +static int bq24261_get_charger_health(struct bq24261_charger *chip)
> +{
> +	if (!chip->present)
> +		return POWER_SUPPLY_HEALTH_UNKNOWN;
> +
> +	return chip->chg_health;
> +}
> +
> +static int bq24261_get_charging_status(struct bq24261_charger *chip)
> +{
> +	int status;
> +
> +	if (!chip->present)
> +		return POWER_SUPPLY_STATUS_DISCHARGING;
> +
> +	switch (chip->chg_status) {
> +	case BQ24261_CHRGR_STAT_READY:
> +		status = POWER_SUPPLY_STATUS_DISCHARGING;
> +		break;
> +	case BQ24261_CHRGR_STAT_CHARGING:
> +		status = POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case BQ24261_CHRGR_STAT_FULL:
> +		status = POWER_SUPPLY_STATUS_FULL;
> +		break;
> +	case BQ24261_CHRGR_STAT_FAULT:
> +		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	default:
> +		status = POWER_SUPPLY_STATUS_DISCHARGING;
> +	}
> +
> +	return status;
> +}
> +
> +static int bq24261_usb_get_property(struct power_supply *psy,
> +		enum power_supply_property psp, union power_supply_propval *val)
> +{
> +	struct bq24261_charger *chip = power_supply_get_drvdata(psy);
> +
> +	mutex_lock(&chip->lock);
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval = chip->present;
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval = chip->online;
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		val->intval = bq24261_get_charger_health(chip);
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval = bq24261_get_charging_status(chip);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		val->intval = chip->pdata->max_cc * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		val->intval = chip->pdata->max_cv * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		val->intval = chip->cc * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		val->intval = chip->cv * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		val->intval = chip->inlmt * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		val->intval = chip->iterm * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP_MAX:
> +		val->intval = chip->pdata->max_temp * 10;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP_MIN:
> +		val->intval = chip->pdata->min_temp * 10;
> +		break;
> +	default:
> +		mutex_unlock(&chip->lock);
> +		return -EINVAL;
> +	}
> +	mutex_unlock(&chip->lock);
> +
> +	return 0;
> +}
> +
> +static int bq24261_usb_set_property(struct power_supply *psy,
> +	enum power_supply_property psp, const union power_supply_propval *val)
> +{
> +	struct bq24261_charger *chip = power_supply_get_drvdata(psy);
> +	int ret = 0;
> +
> +	mutex_lock(&chip->lock);
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret = bq24261_set_cc(chip, (val->intval / 1000));
> +		if (!ret)
> +			chip->cc = val->intval;
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret = bq24261_set_cv(chip, (val->intval / 1000));
> +		if (!ret)
> +			chip->cv = val->intval;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&chip->lock);
> +
> +	return ret;
> +}
> +
> +static int bq24261_property_is_writeable(struct power_supply *psy,
> +		enum power_supply_property psp)
> +{
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret = 1;
> +		break;
> +	default:
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}

Thanks Ram for submitting your driver. I think it's a good base to
merge my (unplished) work supporting the bq24261M and bq24262.

Laurentiu and I were having an offline discussion whether to make the
above constant charge current / voltage writable through sysfs on the
bq24257_charger.c driver as I'm merging my bq24250/bq24251 work there.
While helpful for debugging and to empower certain user-space
applications those properties also are somewhat dangerous to expose at
the same time if an unskilled user gets hold of them...

(Thanks Laurentiu for digging up below thread)
http://marc.info/?l=linux-pm&m=143080413218161&w=2

In this context I was thinking, what about introducing a DT property for
this and other charger drivers called "batt_param_write_enable" that by
default is OFF and controls the writability of above two parameters? I
think this would add one layer of safety while at the same time allowing
more flexibility for where it's needed.

(more comments below)

> +
> +static enum power_supply_property bq24261_usb_props[] = {
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_TYPE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +	POWER_SUPPLY_PROP_TEMP_MAX,
> +	POWER_SUPPLY_PROP_TEMP_MIN,
> +};
> +
> +static char *bq24261_charger_supplied_to[] = {
> +	"main-battery",
> +};
> +
> +static struct power_supply_desc bq24261_charger_desc = {
> +	.name			= DEV_NAME,
> +	.type			= POWER_SUPPLY_TYPE_USB,
> +	.properties		= bq24261_usb_props,
> +	.num_properties		= ARRAY_SIZE(bq24261_usb_props),
> +	.get_property		= bq24261_usb_get_property,
> +	.set_property		= bq24261_usb_set_property,
> +	.property_is_writeable	= bq24261_property_is_writeable,
> +};
> +
> +static void bq24261_wdt_reset_worker(struct work_struct *work)
> +{
> +
> +	struct bq24261_charger *chip = container_of(work,
> +			    struct bq24261_charger, wdt_work.work);
> +	int ret;
> +
> +	ret = bq24261_reset_wdt_timer(chip);
> +	if (ret)
> +		dev_err(&chip->client->dev, "WDT timer reset error(%d)\n", ret);
> +
> +	schedule_delayed_work(&chip->wdt_work, WDT_RESET_DELAY);
> +}
> +
> +static void bq24261_irq_worker(struct work_struct *work)
> +{
> +	struct bq24261_charger *chip =
> +	    container_of(work, struct bq24261_charger, irq_work);
> +	int ret;
> +
> +	/*
> +	 * Lock to ensure that interrupt register readings are done
> +	 * and processed sequentially. The interrupt Fault registers
> +	 * are read on clear and without sequential processing double
> +	 * fault interrupts or fault recovery cannot be handlled propely
> +	 */
> +
> +	mutex_lock(&chip->lock);
> +
> +	ret = bq24261_read_reg(chip->client, BQ24261_STAT_CTRL0_ADDR);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"Error (%d) in reading BQ24261_STAT_CTRL0_ADDR\n", ret);
> +		goto irq_out;
> +	}
> +
> +	if (!chip->cable.boost) {
> +		bq24261_handle_status(chip, ret);
> +		bq24261_handle_health(chip, ret);
> +		power_supply_changed(chip->psy_usb);
> +	}
> +
> +irq_out:
> +	mutex_unlock(&chip->lock);
> +}
> +
> +static irqreturn_t bq24261_thread_handler(int id, void *data)
> +{
> +	struct bq24261_charger *chip = (struct bq24261_charger *)data;
> +
> +	queue_work(system_highpri_wq, &chip->irq_work);
> +	return IRQ_HANDLED;
> +}
> +
> +static void bq24261_fault_mon_work(struct work_struct *work)
> +{
> +	struct bq24261_charger *chip = container_of(work,
> +			struct bq24261_charger, fault_mon_work.work);
> +	int ret;
> +
> +	if ((chip->chg_health == POWER_SUPPLY_HEALTH_OVERVOLTAGE) ||
> +		(chip->chg_health == POWER_SUPPLY_HEALTH_DEAD)) {
> +
> +		mutex_lock(&chip->lock);
> +		ret = bq24261_read_reg(chip->client, BQ24261_STAT_CTRL0_ADDR);
> +		if (ret < 0) {
> +			dev_err(&chip->client->dev,
> +				"Status register read failed(%d)\n", ret);
> +			goto fault_mon_out;
> +		}
> +
> +		if ((ret & BQ24261_STAT_MASK) == BQ24261_STAT_READY) {
> +			dev_info(&chip->client->dev,
> +					"Charger fault recovered\n");
> +			bq24261_handle_status(chip, ret);
> +			bq24261_handle_health(chip, ret);
> +			power_supply_changed(chip->psy_usb);
> +		}
> +fault_mon_out:
> +		mutex_unlock(&chip->lock);
> +	}
> +}
> +
> +static void bq24261_boost_control(struct bq24261_charger *chip, bool enable)
> +{
> +	int ret;
> +
> +	if (enable)
> +		ret = bq24261_write_reg(chip->client, BQ24261_STAT_CTRL0_ADDR,
> +				BQ24261_TMR_RST | BQ24261_ENABLE_BOOST);
> +	else
> +		ret = bq24261_write_reg(chip->client,
> +						BQ24261_STAT_CTRL0_ADDR, 0x0);
> +
> +	if (ret < 0)
> +		dev_err(&chip->client->dev,
> +			"stat cntl0 reg access error(%d)\n", ret);
> +}
> +
> +static void bq24261_extcon_event_work(struct work_struct *work)
> +{
> +	struct bq24261_charger *chip =
> +			container_of(work, struct bq24261_charger, cable.work);
> +	int ret, current_limit = 0;
> +	bool old_connected = chip->cable.connected;
> +
> +	/* Determine cable/charger type */
> +	if (extcon_get_cable_state(chip->cable.sdp.edev,
> +					"SLOW-CHARGER") > 0) {
> +		chip->cable.connected = true;
> +		current_limit = ILIM_500MA;
> +		chip->cable.chg_type = POWER_SUPPLY_TYPE_USB;
> +		dev_dbg(&chip->client->dev, "USB SDP charger is connected");
> +	} else if (extcon_get_cable_state(chip->cable.cdp.edev,
> +					"CHARGE-DOWNSTREAM") > 0) {
> +		chip->cable.connected = true;
> +		current_limit = ILIM_1500MA;
> +		chip->cable.chg_type = POWER_SUPPLY_TYPE_USB_CDP;
> +		dev_dbg(&chip->client->dev, "USB CDP charger is connected");
> +	} else if (extcon_get_cable_state(chip->cable.dcp.edev,
> +					"FAST-CHARGER") > 0) {
> +		chip->cable.connected = true;
> +		current_limit = ILIM_1500MA;
> +		chip->cable.chg_type = POWER_SUPPLY_TYPE_USB_DCP;
> +		dev_dbg(&chip->client->dev, "USB DCP charger is connected");
> +	} else if (extcon_get_cable_state(chip->cable.otg.edev,
> +					"USB-Host") > 0) {
> +		chip->cable.boost = true;
> +		chip->cable.connected = true;
> +		dev_dbg(&chip->client->dev, "USB-Host cable is connected");
> +	} else {
> +		if (old_connected)
> +			dev_dbg(&chip->client->dev, "USB Cable disconnected");
> +		chip->cable.connected = false;
> +		chip->cable.boost = false;
> +		chip->cable.chg_type = POWER_SUPPLY_TYPE_USB;
> +	}
> +
> +	/* Cable status changed */
> +	if (old_connected == chip->cable.connected)
> +		return;
> +
> +	mutex_lock(&chip->lock);
> +	if (chip->cable.connected && !chip->cable.boost) {
> +		chip->inlmt = current_limit;
> +		/* Set up charging */
> +		ret = bq24261_set_cc(chip, chip->cc);
> +		if (ret < 0)
> +			dev_err(&chip->client->dev, "set CC failed(%d)", ret);
> +		ret = bq24261_set_cv(chip, chip->cv);
> +		if (ret < 0)
> +			dev_err(&chip->client->dev, "set CV failed(%d)", ret);
> +		ret = bq24261_set_inlmt(chip, chip->inlmt);
> +		if (ret < 0)
> +			dev_err(&chip->client->dev, "set ILIM failed(%d)", ret);
> +		ret = bq24261_enable_charger(chip, true);
> +		if (ret < 0)
> +			dev_err(&chip->client->dev,
> +					"enable charger failed(%d)", ret);
> +		ret = bq24261_enable_charging(chip, true);
> +		if (ret < 0)
> +			dev_err(&chip->client->dev,
> +					"enable charging failed(%d)", ret);
> +
> +		chip->is_charging_enabled = true;
> +		chip->present = true;
> +		chip->online = true;
> +		schedule_delayed_work(&chip->wdt_work, 0);
> +	} else if (chip->cable.connected && chip->cable.boost) {
> +		/* Enable VBUS for Host Mode */
> +		bq24261_boost_control(chip, true);
> +		schedule_delayed_work(&chip->wdt_work, 0);
> +	} else {
> +		dev_info(&chip->client->dev, "Cable disconnect event\n");
> +		cancel_delayed_work_sync(&chip->wdt_work);
> +		cancel_delayed_work_sync(&chip->fault_mon_work);
> +		bq24261_boost_control(chip, false);
> +		ret = bq24261_enable_charging(chip, false);
> +		if (ret < 0)
> +			dev_err(&chip->client->dev,
> +					"charger disable failed(%d)", ret);
> +
> +		chip->is_charging_enabled = false;
> +		chip->present = false;
> +		chip->online = false;
> +		chip->inlmt = 0;
> +	}
> +	bq24261_charger_desc.type = chip->cable.chg_type;
> +	mutex_unlock(&chip->lock);
> +	power_supply_changed(chip->psy_usb);
> +}
> +
> +static int bq24261_handle_extcon_events(struct notifier_block *nb,
> +				   unsigned long event, void *param)
> +{
> +	struct bq24261_charger *chip =
> +		container_of(nb, struct bq24261_charger, cable.nb);
> +
> +	dev_dbg(&chip->client->dev, "external connector event(%ld)\n", event);
> +
> +	schedule_work(&chip->cable.work);
> +	return NOTIFY_OK;
> +}
> +
> +static int bq24261_extcon_register(struct bq24261_charger *chip)
> +{
> +	int ret;
> +
> +	INIT_WORK(&chip->cable.work, bq24261_extcon_event_work);
> +	chip->cable.nb.notifier_call = bq24261_handle_extcon_events;
> +
> +	ret = extcon_register_interest(&chip->cable.sdp, NULL,
> +				"SLOW-CHARGER", &chip->cable.nb);
> +	if (ret < 0) {
> +		dev_warn(&chip->client->dev,
> +				"extcon SDP registration failed(%d)\n", ret);
> +		goto sdp_reg_failed;
> +	}
> +
> +	ret = extcon_register_interest(&chip->cable.cdp, NULL,
> +				"CHARGE-DOWNSTREAM", &chip->cable.nb);
> +	if (ret < 0) {
> +		dev_warn(&chip->client->dev,
> +				"extcon CDP registration failed(%d)\n", ret);
> +		goto cdp_reg_failed;
> +	}
> +
> +	ret = extcon_register_interest(&chip->cable.dcp, NULL,
> +				"FAST-CHARGER", &chip->cable.nb);
> +	if (ret < 0) {
> +		dev_warn(&chip->client->dev,
> +				"extcon DCP registration failed(%d)\n", ret);
> +		goto dcp_reg_failed;
> +	}
> +
> +	ret = extcon_register_interest(&chip->cable.otg, NULL,
> +				"USB-Host", &chip->cable.nb);
> +	if (ret < 0) {
> +		dev_warn(&chip->client->dev,
> +			"extcon USB-Host registration failed(%d)\n", ret);
> +		goto otg_reg_failed;
> +	}
> +
> +	return 0;
> +
> +otg_reg_failed:
> +	extcon_unregister_interest(&chip->cable.dcp);
> +dcp_reg_failed:
> +	extcon_unregister_interest(&chip->cable.cdp);
> +cdp_reg_failed:
> +	extcon_unregister_interest(&chip->cable.sdp);
> +sdp_reg_failed:
> +	return -EPROBE_DEFER;
> +}
> +
> +static int bq24261_get_model(struct i2c_client *client,
> +			enum bq2426x_model *model)
> +{
> +	int ret;
> +
> +	ret = bq24261_read_reg(client, BQ24261_VENDOR_REV_ADDR);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((ret & BQ24261_VENDOR_MASK) != VENDOR_BQ2426X)
> +		return -EINVAL;
> +
> +	switch (ret & BQ24261_REV_MASK) {
> +	case REV_BQ24261:
> +		*model = BQ24261;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bq24261_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct power_supply_config charger_cfg = {};
> +	struct bq24261_charger *chip;
> +	int ret;
> +	enum bq2426x_model model;
> +
> +	adapter = to_i2c_adapter(client->dev.parent);
> +
> +	if (!client->dev.platform_data && !id) {
> +		dev_err(&client->dev, "platform data is null");
> +		return -EFAULT;
> +	}
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> +		dev_err(&client->dev,
> +			"I2C adapter %s doesn'tsupport BYTE DATA transfer\n",
> +			adapter->name);
> +		return -EIO;
> +	}
> +
> +	ret = bq24261_get_model(client, &model);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "chip detection error (%d)\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->client = client;
> +	if (client->dev.platform_data)
> +		chip->pdata = client->dev.platform_data;
> +	else
> +		chip->pdata = (struct bq24261_platform_data *)id->driver_data;
> +	i2c_set_clientdata(client, chip);
> +	mutex_init(&chip->lock);
> +	chip->model = model;
> +
> +	/* Initialize charger parameters */
> +	chip->cc = chip->pdata->def_cc;
> +	chip->cv = chip->pdata->def_cv;
> +	chip->iterm = chip->pdata->iterm;
> +	chip->chg_status = BQ24261_CHRGR_STAT_UNKNOWN;
> +	chip->chg_health = POWER_SUPPLY_HEALTH_UNKNOWN;
> +
> +	charger_cfg.drv_data = chip;
> +	charger_cfg.supplied_to = bq24261_charger_supplied_to;
> +	charger_cfg.num_supplicants = ARRAY_SIZE(bq24261_charger_supplied_to);
> +	chip->psy_usb = power_supply_register(&client->dev,
> +				&bq24261_charger_desc, &charger_cfg);
> +	if (IS_ERR(chip->psy_usb)) {
> +		dev_err(&client->dev,
> +			"power supply registration failed(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	INIT_DELAYED_WORK(&chip->wdt_work, bq24261_wdt_reset_worker);
> +	INIT_DELAYED_WORK(&chip->fault_mon_work, bq24261_fault_mon_work);
> +
> +	ret = bq24261_extcon_register(chip);
> +	if (ret < 0)
> +		goto extcon_reg_failed;
> +
> +	if (chip->client->irq) {
> +		ret = request_threaded_irq(chip->client->irq,
> +					   NULL, bq24261_thread_handler,
> +					   IRQF_SHARED | IRQF_NO_SUSPEND,
> +					   DEV_NAME, chip);
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"irq request failed (%d)\n", ret);
> +			goto irq_reg_failed;
> +		}
> +		INIT_WORK(&chip->irq_work, bq24261_irq_worker);
> +	}
> +
> +	/* Check for charger connecetd boot case */
> +	schedule_work(&chip->cable.work);
> +
> +	return 0;
> +
> +irq_reg_failed:
> +	extcon_unregister_interest(&chip->cable.sdp);
> +	extcon_unregister_interest(&chip->cable.cdp);
> +	extcon_unregister_interest(&chip->cable.dcp);
> +	extcon_unregister_interest(&chip->cable.otg);
> +extcon_reg_failed:
> +	power_supply_unregister(chip->psy_usb);
> +	return ret;
> +}
> +
> +static int bq24261_remove(struct i2c_client *client)
> +{
> +	struct bq24261_charger *chip = i2c_get_clientdata(client);
> +
> +	free_irq(client->irq, chip);
> +	flush_scheduled_work();
> +	extcon_unregister_interest(&chip->cable.sdp);
> +	extcon_unregister_interest(&chip->cable.cdp);
> +	extcon_unregister_interest(&chip->cable.dcp);
> +	extcon_unregister_interest(&chip->cable.otg);
> +	power_supply_unregister(chip->psy_usb);
> +	return 0;
> +}
> +
> +static int bq24261_suspend(struct device *dev)
> +{
> +	struct bq24261_charger *chip = dev_get_drvdata(dev);
> +
> +	dev_dbg(&chip->client->dev, "bq24261 suspend\n");
> +	return 0;
> +}
> +
> +static int bq24261_resume(struct device *dev)
> +{
> +	struct bq24261_charger *chip = dev_get_drvdata(dev);
> +
> +	dev_dbg(&chip->client->dev, "bq24261 resume\n");
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(bq24261_pm_ops, bq24261_suspend,
> +			bq24261_resume);
> +
> +static const struct i2c_device_id bq24261_id[] = {
> +	{DEV_NAME, 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, bq24261_id);
> +
> +static struct i2c_driver bq24261_driver = {
> +	.driver = {
> +		   .name = DEV_NAME,
> +		   .pm = &bq24261_pm_ops,
> +		   },
> +	.probe = bq24261_probe,
> +	.remove = bq24261_remove,
> +	.id_table = bq24261_id,

I just noticed this driver doesn't yet support DT which is probably
something that should be added. When I start merging my work I will
certainly need to do that but I'm curious if there are plans from your
end to add this as well (and I had seen Laurentiu's bq24257_charger.c
driver uses ACPI for this which seems to be some kind of superset of DT
- forgive my simplification I'm not too familiar with ACPI yet).

--
Andreas Dannenberg
Texas Instruments

> +};
> +
> +module_i2c_driver(bq24261_driver);
> +
> +MODULE_AUTHOR("Jenny TC <jenny.tc@intel.com>");
> +MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
> +MODULE_DESCRIPTION("BQ24261 Charger Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/power/bq24261_charger.h b/include/linux/power/bq24261_charger.h
> new file mode 100644
> index 0000000..656db58
> --- /dev/null
> +++ b/include/linux/power/bq24261_charger.h
> @@ -0,0 +1,26 @@
> +/*
> + * bq24261_charger.h: platform data structure for bq24261 driver
> + *
> + * Copyright (C) 2014 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2
> + * of the License.
> + */
> +
> +#ifndef __BQ24261_CHARGER_H__
> +#define __BQ24261_CHARGER_H__
> +
> +struct bq24261_platform_data {
> +	int def_cc;
> +	int def_cv;
> +	int iterm;
> +	int max_cc;
> +	int max_cv;
> +	int min_temp;
> +	int max_temp;
> +	bool thermal_sensing;
> +};
> +
> +#endif
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
