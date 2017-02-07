From: Wojciech Ziemba <wo.ziemba@gmail.com>
Subject: [PATCH] power: supply: Add driver for TI BQ2416X battery charger
Date: Tue,  7 Feb 2017 01:09:09 +0000
Message-ID: <1486429749-12973-1-git-send-email-wojciech.ziemba@verifone.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32836 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbdBGBLB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 20:11:01 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, wojciech.ziemba@verifone.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

There is interest in adding a Linux driver for TI BQ2416X battery
charger. The driver supports BQ24160 chip, thus can be easily extended
for other BQ2416X family chargers.
Device exposes 'POWER_SUPPLY_PROP_*' properties and a number of knobs
for controlling the charging process as well as sends power supply change
notification via power-supply subsystem.

Signed-off-by: Wojciech Ziemba <wojciech.ziemba@verifone.com>
---
 .../devicetree/bindings/power/supply/bq2416x.txt   |   71 +
 drivers/power/supply/Kconfig                       |    7 +
 drivers/power/supply/Makefile                      |    1 +
 drivers/power/supply/bq2416x_charger.c             | 1871 ++++++++++++++++++++
 include/dt-bindings/power/bq2416x_charger.h        |   23 +
 include/linux/power/bq2416x_charger.h              |   80 +
 6 files changed, 2053 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2416x.txt
 create mode 100644 drivers/power/supply/bq2416x_charger.c
 create mode 100644 include/dt-bindings/power/bq2416x_charger.h
 create mode 100644 include/linux/power/bq2416x_charger.h

diff --git a/Documentation/devicetree/bindings/power/supply/bq2416x.txt b/Documentation/devicetree/bindings/power/supply/bq2416x.txt
new file mode 100644
index 0000000..8f4b814
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq2416x.txt
@@ -0,0 +1,71 @@
+Binding for TI bq2416x Li-Ion Charger
+
+Required properties:
+===================
+- compatible: one of the following:
+ * "ti,bq24160"
+ * "ti,bq24160a"
+ * "ti,bq24161"
+ * "ti,bq24161b"
+ * "ti,bq24163"
+ * "ti,bq24168"
+
+- reg:			I2c address of the device.
+- interrupt-parent:	The irq controller(phandle) connected to INT pin on BQ2416x
+- interrupts:		The irq number assigned for INT pin.
+
+Optional properties:
+===================
+- interrupt-names:		Meanigfull irq name.
+- ti,charge-voltage:		Charge volatge [mV].
+- ti,charge-current:		Charge current [mA].
+- ti,termination-current:	Termination current [mA}.
+- ti,in-current-limit:		IN source current limit. enum:
+				- IN_CURR_LIM_1500MA (0)
+				- IN_CURR_LIM_2500MA (1)
+
+- ti,usb-current-limit:		USB source current limit. enum:
+				- USB_CURR_LIM_100MA (0)
+				- USB_CURR_LIM_150MA (1)
+				- USB_CURR_LIM_500MA (2)
+				- USB_CURR_LIM_800MA (3)
+				- USB_CURR_LIM_900MA (4)
+				- USB_CURR_LIM_1500MA (5)
+
+- ti,status-pin-enable:		0 or 1. Enable charge status output STAT pin.
+- ti,current-termination-enable:0 or 1. Enable charge current termination.
+- ti,usb-dpm-voltage:		USB dpm voltage [mV]. Refer to datasheet.
+- ti,in-dpm-voltage:		IN dpm voltage [mV].
+- ti,safety-timer:		Safety timer. enum:
+			- TMR_27MIN (0)
+			- TMR_6H (1)
+			- TMR_9H (2)
+			- TMR_OFF (3)
+
+- ti,supplied-to:	string array: max 4. Names of devices to which
+			the charger supplies.
+
+Example:
+=======
+#include <dt-bindings/power/bq2416x_charger.h>
+
+bq24160@6b {
+	compatible = "ti,bq24160";
+	reg = <0x6b>;
+
+	interrupt-parent = <&gpio5>;
+	interrupts = <31 IRQ_TYPE_EDGE_RISING>;
+	interrupt-names = "bq24160-charge-status-change";
+
+	ti,charge-voltage = <4300>;
+	ti,charge-current = <1300>;
+	ti,termination-current = <100>;
+	ti,in-current-limit = <IN_CURR_LIM_1500MA>;
+	ti,usb-current-limit = <USB_CURR_LIM_1500MA>;
+	ti,status-pin-enable = <1>;
+	ti,current-termination-enable = <1>;
+	ti,usb-dpm-voltage = <4300>;
+	ti,in-dpm-voltage = <4300>;
+	ti,safety-timer = <TMR_6H>; /* charge max 6h */
+	ti,supplied-to = "bq27621-0";
+};
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 76806a0..575096e 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -413,6 +413,13 @@ config CHARGER_BQ2415X
 	  You'll need this driver to charge batteries on e.g. Nokia
 	  RX-51/N900.
 
+config CHARGER_BQ2416X
+	tristate "TI BQ2416x Dual-Input, Single Cell Switch-Mode Li-Ion charger"
+	depends on I2C
+	help
+	  Say Y here to enable support for the TI BQ2416x battery charger.
+	  The driver is configured to operate with a single lithium cell.
+
 config CHARGER_BQ24190
 	tristate "TI BQ24190 battery charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 36c599d..73711e0 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
 obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
 obj-$(CONFIG_CHARGER_QCOM_SMBB)	+= qcom_smbb.o
 obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
+obj-$(CONFIG_CHARGER_BQ2416X)	+= bq2416x_charger.o
 obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
 obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
 obj-$(CONFIG_CHARGER_BQ24735)	+= bq24735-charger.o
diff --git a/drivers/power/supply/bq2416x_charger.c b/drivers/power/supply/bq2416x_charger.c
new file mode 100644
index 0000000..fa13e55
--- /dev/null
+++ b/drivers/power/supply/bq2416x_charger.c
@@ -0,0 +1,1871 @@
+/*
+ * Driver for BQ2416X Li-Ion Battery Charger
+ *
+ * Copyright (C) 2015 Verifone, Inc.
+ *
+ * Author: Wojciech Ziemba <wojciech.ziemba@verifone.com>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED AS IS AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * The bq2416x series is a 2.5A, Dual-Input, Single-Cell Switched-Mode
+ * Li-Ion Battery Charger with Power
+ * Path Management and I2C Interface
+ *
+ * This driver was tested on BQ24160.
+ *
+ * Datasheets:
+ * http://www.ti.com/product/bq24160
+ * http://www.ti.com/product/bq24160a
+ * http://www.ti.com/product/bq24161
+ * http://www.ti.com/product/bq24161b
+ * http://www.ti.com/product/bq24163
+ * http://www.ti.com/product/bq24168
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/pm_runtime.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/regmap.h>
+#include <linux/power_supply.h>
+#include <linux/power/bq2416x_charger.h>
+
+/* Get the value of bitfield */
+#define BF_GET(_y, _mask) (((_y) & _mask) >> (__builtin_ffs((int) _mask) - 1))
+/* Shift the value of bitfield. Mask based */
+#define BF_SHIFT(_x, _mask) ((_x) << (__builtin_ffs((int) _mask) - 1))
+/* Watchdog timer. 3 second in reserve */
+#define BQ2416X_WATCHDOG_TIMER		(30 - 3)
+/* Register numbers */
+#define BQ2416X_REG_STATUS		0x00
+#define BQ2416X_REG_SUP_STATUS		0x01
+#define BQ2416X_REG_CONTROL		0x02
+#define BQ2416X_REG_BAT_VOLT		0x03
+#define BQ2416X_REG_VENDOR		0x04
+#define BQ2416X_REG_TERM		0x05
+#define BQ2416X_REG_DPM			0x06
+#define BQ2416X_REG_NTC			0x07
+#define BQ2416X_REG_MAX			0x08
+
+/* status/control register */
+#define BQ2416X_REG_STATUS_TMR_RST_MASK	BIT(7)
+#define BQ2416X_REG_STATUS_STAT_MASK		(BIT(6) | BIT(5) | BIT(4))
+#define BQ2416X_REG_STATUS_SUPPLY_SEL_MASK	BIT(3)
+#define BQ2416X_REG_STATUS_FAULT_MASK		(BIT(2) | BIT(1) | BIT(0))
+
+/* battery/supply status register */
+#define BQ2416X_REG_SUP_STATUS_INSTAT_MASK	(BIT(7) | BIT(6))
+#define BQ2416X_REG_SUP_STATUS_USBSTAT_MASK	(BIT(5) | BIT(4))
+#define BQ2416X_REG_SUP_STATUS_OTG_LOCK_MASK	BIT(3)
+#define BQ2416X_REG_SUP_STATUS_BATSTAT_MASK	(BIT(2) | BIT(1))
+#define BQ2416X_REG_SUP_STATUS_EN_NOBATOP_MASK	BIT(0)
+
+/* control register */
+#define BQ2416X_REG_CONTROL_RESET_MASK		BIT(7)
+#define BQ2416X_REG_CONTROL_USB_CURR_LIM_MASK	(BIT(6) | BIT(5) | BIT(4))
+#define BQ2416X_REG_CONTROL_EN_STAT_MASK	BIT(3)
+#define BQ2416X_REG_CONTROL_TE_MASK		BIT(2)
+#define BQ2416X_REG_CONTROL_CE_MASK		BIT(1)
+#define BQ2416X_REG_CONTROL_HZ_MODE_MASK	BIT(0)
+
+/* control/battery voltage register */
+#define BQ2416X_REG_BAT_VOLT_MASK		(BIT(7) | BIT(6) | BIT(5) | \
+						BIT(4) | BIT(3) | BIT(2))
+#define BQ2416X_REG_BAT_VOLT_IN_CURR_LIM_MASK	BIT(1)
+
+/* vendor/part/revision register */
+#define BQ2416X_REG_VENDOR_REV_MASK		(BIT(2) | BIT(1) | BIT(0))
+#define BQ2416X_REG_VENDOR_CODE_MASK		(BIT(7) | BIT(6) | BIT(5))
+
+/* battery termination fast charge current register */
+#define BQ2416X_REG_TERM_CHRG_CURR_MASK	(BIT(7) | BIT(6) | BIT(5) | \
+						BIT(4) | BIT(3))
+#define BQ2416X_REG_TERM_TERM_CURR_MASK	(BIT(2) | BIT(1) | BIT(0))
+
+/* VIN-DPM voltage/DPPM status register */
+#define BQ2416X_REG_DPM_MINSYS_STATUS_MASK	BIT(7)
+#define BQ2416X_REG_DPM_STATUS_MASK		BIT(6)
+#define BQ2416X_REG_DPM_USB_VOLT_MASK		(BIT(5) | BIT(4) | BIT(3))
+#define BQ2416X_REG_DPM_IN_VOLT_MASK		(BIT(2) | BIT(1) | BIT(0))
+
+/* Safety timer/NTC monitor register */
+#define BQ2416X_REG_NTC_TMRX2_MASK		BIT(7)
+#define BQ2416X_REG_NTC_TMR_MASK		(BIT(6) | BIT(5))
+#define BQ2416X_REG_NTC_TS_EN_MASK		BIT(3)
+#define BQ2416X_REG_NTC_TS_FAULT_MASK		(BIT(2) | BIT(1))
+#define BQ2416X_REG_NTC_LOW_CHARGE_MASK	BIT(0)
+
+/* Charge voltage [mV] */
+#define BQ2416X_CHARGE_VOLTAGE_MIN	3500
+#define BQ2416X_CHARGE_VOLTAGE_MAX	4440
+#define BQ2416X_CHARGE_VOLTAGE_STEP	20
+
+/* IN current limit */
+#define BQ2416X_IN_CURR_LIM_1500	0
+#define BQ2416X_IN_CURR_LIM_2500	1
+
+/* Charge current [mA] */
+#define BQ2416X_CHARGE_CURRENT_MIN	550
+#define BQ2416X_CHARGE_CURRENT_MAX	2500
+#define BQ2416X_CHARGE_CURRENT_STEP	75
+
+/* Charge termination current in mA */
+#define BQ2416X_CHARGE_TERM_CURRENT_MIN		50
+#define BQ2416X_CHARGE_TERM_CURRENT_MAX		400
+#define BQ2416X_CHARGE_TERM_CURRENT_STEP	50
+
+/* USB DPM voltage [mV] */
+#define BQ2416X_DPM_USB_VOLTAGE_MIN	4200
+#define BQ2416X_DPM_USB_VOLTAGE_MAX	4760
+#define BQ2416X_DPM_USB_VOLTAGE_STEP	80
+
+/* IN DPM voltage [mV] */
+#define BQ2416X_DPM_IN_VOLTAGE_MIN	4200
+#define BQ2416X_DPM_IN_VOLTAGE_MAX	4760
+#define BQ2416X_DPM_IN_VOLTAGE_STEP	80
+
+/* Supported chips */
+enum  bq2416x_type {
+	BQ24160,
+	BQ24160A,
+	BQ24161,
+	BQ24161B,
+	BQ24163,
+	BQ24168,
+};
+
+/* Charger status */
+enum {
+	STAT_NO_VALID_SOURCE,
+	STAT_IN_READY,
+	STAT_USB_READY,
+	STAT_CHARGING_FROM_IN,
+	STAT_CHARGING_FROM_USB,
+	STAT_CHARGE_DONE,
+	STAT_NA,
+	STAT_FAULT,
+};
+
+/* Charger status to string/power subsys status map */
+static const struct {
+	const char * const str;
+	const int id;
+} bq2416x_charge_status[] = {
+	[STAT_NO_VALID_SOURCE] = {"No valid source",
+				POWER_SUPPLY_STATUS_NOT_CHARGING},
+	[STAT_IN_READY] = {"IN ready", POWER_SUPPLY_STATUS_NOT_CHARGING},
+	[STAT_USB_READY] = {"USB ready", POWER_SUPPLY_STATUS_NOT_CHARGING},
+	[STAT_CHARGING_FROM_IN] = {"Charging from IN",
+				POWER_SUPPLY_STATUS_CHARGING},
+	[STAT_CHARGING_FROM_USB] = {"Charging from USB",
+				POWER_SUPPLY_STATUS_CHARGING},
+	[STAT_CHARGE_DONE] = {"Charge done", POWER_SUPPLY_STATUS_FULL},
+	[STAT_NA] = {"N/A", POWER_SUPPLY_STATUS_UNKNOWN},
+	[STAT_FAULT] = {"Fault", POWER_SUPPLY_STATUS_NOT_CHARGING},
+};
+
+/* Charger fault */
+enum {
+	FAULT_NORMAL,
+	FAULT_THERMAL_SHUTDOWN,
+	FAULT_BATT_TEMP_FAULT,
+	FAULT_WDOG_TIMER_EXPIRED,
+	FAULT_SAFETY_TIMER_EXPIRED,
+	FAULT_IN_SUPPLY_FAULT,
+	FAULT_USB_SUPPLY_FAULT,
+	FAULT_BATTERY_FAULT,
+};
+
+/* Charger fault to string/power subsys fault map */
+static const struct {
+	const char * const str;
+	const int id;
+} bq2416x_charge_fault[] = {
+	[FAULT_NORMAL] = {"Normal", POWER_SUPPLY_HEALTH_GOOD},
+	[FAULT_THERMAL_SHUTDOWN] = {"Thermal shutdown",
+				POWER_SUPPLY_HEALTH_OVERHEAT},
+	[FAULT_BATT_TEMP_FAULT] = {"Battery temp fault",
+				POWER_SUPPLY_HEALTH_OVERHEAT},
+	[FAULT_WDOG_TIMER_EXPIRED] = {"Watchdog timer expired",
+				POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE},
+	[FAULT_SAFETY_TIMER_EXPIRED] = {"Safety timer expired",
+				POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE},
+	[FAULT_IN_SUPPLY_FAULT] = {"IN Supply fault",
+				POWER_SUPPLY_HEALTH_UNSPEC_FAILURE},
+	[FAULT_USB_SUPPLY_FAULT] = {"USB Supply fault",
+				POWER_SUPPLY_HEALTH_UNSPEC_FAILURE},
+	[FAULT_BATTERY_FAULT] = {"Battery fault", POWER_SUPPLY_HEALTH_DEAD},
+};
+
+/* IN(Wall) source status */
+enum {
+	INSTAT_NORMAL,
+	INSTAT_SUPPLY_OVP,
+	INSTAT_WEAK_SOURCE_CONNECTED,
+	INSTAT_FAULTY_ADAPTER,
+};
+
+/* IN(Wall) source status to string map */
+static const char * const bq2416x_in_status[] = {
+	[INSTAT_NORMAL] = "Normal",
+	[INSTAT_SUPPLY_OVP] = "OVP",
+	[INSTAT_WEAK_SOURCE_CONNECTED] = "Weak source",
+	[INSTAT_FAULTY_ADAPTER] = "Faulty adapter",
+};
+
+/* Battery status */
+enum {
+	BATSTAT_BATTERY_PRESENT,
+	BATSTAT_BATTERY_OVP,
+	BATSTAT_BATTERY_NOT_PRESENT,
+	BATSTAT_BATTERY_NA,
+};
+
+/* Battery status to string map */
+static const char * const bq2416x_bat_status[] = {
+	[BATSTAT_BATTERY_PRESENT] = "present",
+	[BATSTAT_BATTERY_OVP] = "OVP",
+	[BATSTAT_BATTERY_NOT_PRESENT] = "not present",
+	[BATSTAT_BATTERY_NA] = "NA",
+};
+
+static const int bq2416x_usb_curr_lim[] = {
+	[USB_CURR_LIM_100MA] = 100,
+	[USB_CURR_LIM_150MA] = 150,
+	[USB_CURR_LIM_500MA] = 500,
+	[USB_CURR_LIM_800MA] = 800,
+	[USB_CURR_LIM_900MA] = 900,
+	[USB_CURR_LIM_1500MA] = 1500,
+};
+
+static const int const bq24160_in_lim[] = {
+	[IN_CURR_LIM_1500MA] = 1500,
+	[IN_CURR_LIM_2500MA] = 2500,
+};
+
+static const char * const bq2416x_tmr[] = {
+	[TMR_27MIN] = "27min",
+	[TMR_6H] = "6h",
+	[TMR_9H] = "9h",
+	[TMR_OFF] = "off",
+};
+
+/* External NTC Monitoring(TS) fault */
+enum {
+	TS_FAULT_NORMAL,
+	TS_FAULT_COLD_HOT,
+	TS_FAULT_COOL,
+	TS_FAULT_WARM,
+};
+
+static const char * const bq2416x_ts_fault[] = {
+	[TS_FAULT_NORMAL] = "normal",
+	[TS_FAULT_COLD_HOT] = "cold/hot(charge suspended)",
+	[TS_FAULT_COOL] = "cool(half current charge)",
+	[TS_FAULT_WARM] = "warm(voltage reduced)",
+};
+
+/* Firmware response: chip revision */
+enum {
+	VENDOR_REV_10,
+	VENDOR_REV_11,
+	VENDOR_REV_20,
+	VENDOR_REV_21,
+	VENDOR_REV_22,
+	VENDOR_REV_23,
+};
+
+static const char * const bq2416x_revision[] = {
+	[VENDOR_REV_10] = "1.0",
+	[VENDOR_REV_11] = "1.1",
+	[VENDOR_REV_20] = "2.0",
+	[VENDOR_REV_21] = "2.1",
+	[VENDOR_REV_22] = "2.2",
+	[VENDOR_REV_23] = "2.3",
+};
+
+/**
+ * struct bq2416x_priv - this device private data
+ * @dev: this device
+ * @regmap: register map for bq2416x
+ * @pdata: platform data
+ * @psy: power-supply-class for this device
+ * @watchdog: watchdog worker
+ * @model: model of this device
+ * @name: the name of this device instance
+ * @idr: the id of this chip
+ */
+struct bq2416x_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	struct bq2416x_pdata pdata;
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+	struct delayed_work watchdog;
+	char *model;
+	char *name;
+	int idr;
+};
+
+/* each registered chip must have unique id */
+static DEFINE_IDR(bq2416x_idr);
+static DEFINE_MUTEX(bq2416x_idr_mutex);
+
+/**
+ * conv2bit_repr - converts value to its regulation binary representation
+ * @val: value to convert
+ * @min: offset - regulation minimum
+ * @max: regulation maximum
+ * @step: regulation step
+ */
+static inline unsigned int conv2bit_repr(unsigned int val, unsigned int min,
+					unsigned int max, unsigned int step)
+{
+	return (clamp_val(val, min, max) - min) / step;
+}
+
+/* regmap callbacks and configuration */
+static bool bq2416x_writeable(struct device *dev, unsigned int reg)
+{
+	return !(reg == BQ2416X_REG_VENDOR);
+}
+
+static bool bq2416x_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BQ2416X_REG_BAT_VOLT:
+	case BQ2416X_REG_VENDOR:
+		return false;
+	}
+
+	return true;
+}
+
+static struct regmap_config bq2416x_i2c_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.writeable_reg = bq2416x_writeable,
+	.volatile_reg = bq2416x_volatile,
+	.cache_type = REGCACHE_RBTREE,
+	.max_register = BQ2416X_REG_MAX,
+};
+
+/* power-supply-class callbacks and configuration */
+static int bq2416x_property_is_writeable(struct power_supply *psy,
+		enum power_supply_property psp)
+{
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = 1;
+		break;
+	default:
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static enum power_supply_property bq2416x_power_supply_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_SCOPE
+};
+
+/**
+ * bq2416x_get_status - get charger status
+ * @bq2416x: the charger device
+ * @status: the pointer to the return value
+ *
+ * Returns 0 if there is no error or negative on error.
+ */
+static int bq2416x_get_status(struct bq2416x_priv *bq2416x, int *status)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_STATUS, &reg_val);
+	if (unlikely(ret))
+		return ret;
+
+	reg_val = BF_GET(reg_val, BQ2416X_REG_STATUS_STAT_MASK);
+	*status = bq2416x_charge_status[reg_val].id;
+
+	return ret;
+}
+
+/**
+ * bq2416x_get_charge_type - Returns charge type
+ * @bq2416x: the charger device
+ * @charge_type: the pointer to the return value
+ *
+ * Returns 0 if there is no error or negative on error.
+ */
+static int bq2416x_get_charge_type(struct bq2416x_priv *bq2416x,
+					int *charge_type)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_STATUS, &reg_val);
+	if (unlikely(ret))
+		return ret;
+
+	reg_val = BF_GET(reg_val, BQ2416X_REG_STATUS_STAT_MASK);
+	if (bq2416x_charge_status[reg_val].id != POWER_SUPPLY_STATUS_CHARGING)
+		*charge_type = POWER_SUPPLY_CHARGE_TYPE_NONE;
+	else {
+		ret = regmap_read(bq2416x->regmap, BQ2416X_REG_NTC, &reg_val);
+		if (unlikely(ret))
+			return ret;
+
+		if (reg_val & BQ2416X_REG_NTC_LOW_CHARGE_MASK)
+			*charge_type = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		else
+			*charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
+	}
+
+	return ret;
+}
+
+/**
+ * bq2416x_set_charge_type - sets charge type
+ * @bq2416x: the charger device
+ * @type: new charge type
+ *
+ * Returns 0 if there is no error or negative on error.
+ */
+static int bq2416x_set_charge_type(struct bq2416x_priv *bq2416x,
+					int type)
+{
+	int ret;
+	unsigned int charge_disable;
+	unsigned int low_charge;
+
+	switch (type) {
+	case POWER_SUPPLY_CHARGE_TYPE_NONE:
+		charge_disable = BQ2416X_REG_CONTROL_CE_MASK;
+		low_charge = 0;
+		break;
+	case POWER_SUPPLY_CHARGE_TYPE_TRICKLE:
+		charge_disable = 0;
+		low_charge = BQ2416X_REG_NTC_LOW_CHARGE_MASK;
+		break;
+	case POWER_SUPPLY_CHARGE_TYPE_FAST:
+		charge_disable = 0;
+		low_charge = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(bq2416x->regmap,
+				BQ2416X_REG_CONTROL,
+				BQ2416X_REG_CONTROL_RESET_MASK |
+				BQ2416X_REG_CONTROL_CE_MASK,
+				charge_disable);
+	if (unlikely(ret))
+		return ret;
+
+	ret = regmap_update_bits(bq2416x->regmap,
+				BQ2416X_REG_NTC,
+				BQ2416X_REG_NTC_LOW_CHARGE_MASK,
+				low_charge);
+
+	return ret;
+}
+
+/**
+ * bq2416x_get_health - returns charger health
+ * @bq2416x: this charger device
+ * @health: the pointer to the return value
+ *
+ * Returns 0 if there is no error or negative on error.
+ */
+static int bq2416x_get_health(struct bq2416x_priv *bq2416x, int *health)
+{
+	unsigned int reg_val;
+	int ret;
+
+	/* check supply status */
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_STATUS, &reg_val);
+	if (unlikely(ret))
+		return ret;
+
+	reg_val = BF_GET(reg_val, BQ2416X_REG_STATUS_FAULT_MASK);
+	*health = bq2416x_charge_fault[reg_val].id;
+
+	return ret;
+}
+
+/**
+ * bq2416x_get_online - returns online status
+ * @bq2416x: this charger device
+ * @online: the pointer to the return value
+ *
+ * Returns 0 if there is no error or negative on error.
+ */
+static int bq2416x_get_online(struct bq2416x_priv *bq2416x, int *online)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_STATUS, &reg_val);
+	if (unlikely(ret))
+		return ret;
+
+	reg_val = BF_GET(reg_val, BQ2416X_REG_STATUS_STAT_MASK);
+	*online = ((reg_val > STAT_NO_VALID_SOURCE) && (reg_val < STAT_NA));
+
+	return ret;
+}
+
+/**
+ * bq2416x_get_charge_current - returns charge current
+ * @bq2416x: the charger device
+ * @curr: the pointer to the return current value in [mA]
+ *
+ * Returns 0 if there is no error or negative on error.
+ */
+static int bq2416x_get_charge_current(struct bq2416x_priv *bq2416x,
+					int *curr)
+{
+	int ret;
+	unsigned int low_charge;
+
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_TERM, curr);
+	if (unlikely(ret))
+		return ret;
+
+	*curr = BF_GET(*curr, BQ2416X_REG_TERM_CHRG_CURR_MASK) *
+		BQ2416X_CHARGE_CURRENT_STEP +
+		BQ2416X_CHARGE_CURRENT_MIN;
+
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_NTC, &low_charge);
+	if (unlikely(ret))
+		return ret;
+
+	/* halve the current value if in low_charge state */
+	*curr >>= low_charge & BQ2416X_REG_NTC_LOW_CHARGE_MASK;
+
+	return ret;
+}
+
+/**
+ * bq2416x_set_charge_current - sets charge current
+ * @bq2416x: the charger device
+ * @curr: new current value in [mA]
+ *
+ * Returns 0 if there is no error or negative on error.
+ */
+static int bq2416x_set_charge_current(struct bq2416x_priv *bq2416x,
+					int curr)
+
+{
+	int ret;
+	unsigned int reg_bits;
+
+	reg_bits = conv2bit_repr(curr, BQ2416X_CHARGE_CURRENT_MIN,
+			BQ2416X_CHARGE_CURRENT_MAX,
+			BQ2416X_CHARGE_CURRENT_STEP);
+
+	ret = regmap_update_bits(bq2416x->regmap,
+				BQ2416X_REG_TERM,
+				BQ2416X_REG_TERM_CHRG_CURR_MASK,
+				BF_SHIFT(reg_bits,
+				BQ2416X_REG_TERM_CHRG_CURR_MASK));
+	if (unlikely(ret))
+		return ret;
+
+	/* unset low charge */
+	ret = regmap_update_bits(bq2416x->regmap,
+				BQ2416X_REG_NTC,
+				BQ2416X_REG_NTC_LOW_CHARGE_MASK,
+				0);
+	return ret;
+}
+
+/**
+ * bq2416x_get_charge_voltage - returns charge voltage
+ * @bq2416x: the charger device
+ * @voltage: the pointer to the return voltage value in [mV]
+ *
+ * Returns 0 if there is no error or negative on error.
+ */
+static int bq2416x_get_charge_voltage(struct bq2416x_priv *bq2416x,
+					int *voltage)
+{
+	int ret;
+
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_BAT_VOLT, voltage);
+	if (unlikely(ret))
+		return ret;
+
+	*voltage = BF_GET(*voltage, BQ2416X_REG_BAT_VOLT_MASK) *
+		BQ2416X_CHARGE_VOLTAGE_STEP +
+		BQ2416X_CHARGE_VOLTAGE_MIN;
+
+	return ret;
+}
+
+/**
+ * bq2416x_set_charge_voltage - sets charge voltage
+ * @bq2416x: the charger device
+ * @voltage: new voltage value in [mV]
+ *
+ * Returns 0 if there is no error or negative on error.
+ */
+static int bq2416x_set_charge_voltage(struct bq2416x_priv *bq2416x,
+					int voltage)
+{
+	int ret;
+	unsigned int reg_bits;
+
+	reg_bits = conv2bit_repr(voltage, BQ2416X_CHARGE_VOLTAGE_MIN,
+			BQ2416X_CHARGE_VOLTAGE_MAX,
+			BQ2416X_CHARGE_VOLTAGE_STEP);
+
+	ret = regmap_update_bits(bq2416x->regmap,
+				BQ2416X_REG_BAT_VOLT,
+				BQ2416X_REG_BAT_VOLT_MASK,
+				BF_SHIFT(reg_bits, BQ2416X_REG_BAT_VOLT_MASK));
+	return ret;
+}
+
+/**
+ * bq2416x_set_term_current - sets charge termination current
+ * @bq2416x: the charger device
+ * @term_curr: new charge termination current value in [mA]
+ *
+ * Returns 0 if there is no error or negative on error.
+ */
+static int bq2416x_set_term_current(struct bq2416x_priv *bq2416x,
+					int term_curr)
+{
+	int ret;
+	unsigned int reg_bits;
+
+	reg_bits = conv2bit_repr(term_curr, BQ2416X_CHARGE_TERM_CURRENT_MIN,
+			BQ2416X_CHARGE_TERM_CURRENT_MAX,
+			BQ2416X_CHARGE_TERM_CURRENT_STEP);
+
+	ret = regmap_update_bits(bq2416x->regmap,
+				BQ2416X_REG_TERM,
+				BQ2416X_REG_TERM_TERM_CURR_MASK,
+				BF_SHIFT(reg_bits,
+				BQ2416X_REG_TERM_TERM_CURR_MASK));
+	if (unlikely(ret))
+		return ret;
+
+	ret = regmap_update_bits(bq2416x->regmap,
+				BQ2416X_REG_NTC,
+				BQ2416X_REG_NTC_LOW_CHARGE_MASK,
+				0);
+	return ret;
+}
+
+/**
+ * bq2416x_set_usb_dpm_voltage - sets USB DPM voltage
+ * @bq2416x: the charger device
+ * @dpm_volt: new USB DPM voltage in [mV]
+ *
+ * Returns 0 if there is no error or negative on error.
+ */
+static int bq2416x_set_usb_dpm_voltage(struct bq2416x_priv *bq2416x,
+					int dpm_volt)
+{
+	int ret;
+	unsigned int reg_bits;
+
+	reg_bits = conv2bit_repr(dpm_volt, BQ2416X_DPM_USB_VOLTAGE_MIN,
+			BQ2416X_DPM_USB_VOLTAGE_MAX,
+			BQ2416X_DPM_USB_VOLTAGE_STEP);
+
+	ret = regmap_update_bits(bq2416x->regmap,
+			BQ2416X_REG_DPM,
+			BQ2416X_REG_DPM_USB_VOLT_MASK,
+			BF_SHIFT(reg_bits, BQ2416X_REG_DPM_USB_VOLT_MASK));
+
+	return ret;
+}
+
+/**
+ * bq2416x_set_in_dpm_voltage - sets IN(Wall) DPM voltage
+ * @bq2416x: the charger device
+ * @dpm_volt: new IN DPM voltage in [mV]
+ *
+ * Returns 0 if there is no error or negative on error.
+ */
+static int bq2416x_set_in_dpm_voltage(struct bq2416x_priv *bq2416x,
+					int dpm_volt)
+{
+	int ret;
+	unsigned int reg_bits;
+
+	reg_bits = conv2bit_repr(dpm_volt, BQ2416X_DPM_IN_VOLTAGE_MIN,
+			BQ2416X_DPM_IN_VOLTAGE_MAX,
+			BQ2416X_DPM_IN_VOLTAGE_STEP);
+
+	ret = regmap_update_bits(bq2416x->regmap,
+			BQ2416X_REG_DPM,
+			BQ2416X_REG_DPM_IN_VOLT_MASK,
+			BF_SHIFT(reg_bits, BQ2416X_REG_DPM_IN_VOLT_MASK));
+	return ret;
+}
+
+/**
+ * bq2416x_reset_watchdog_tmr - resets watchdog timer
+ * @bq2416x: the charger device
+ *
+ * Returns 0 if there is no error or negative on error.
+ */
+static int bq2416x_reset_watchdog_tmr(struct bq2416x_priv *bq2416x)
+{
+	int ret;
+
+	ret = regmap_update_bits(bq2416x->regmap,
+			BQ2416X_REG_STATUS,
+			BQ2416X_REG_STATUS_TMR_RST_MASK,
+			BQ2416X_REG_STATUS_TMR_RST_MASK);
+	if (unlikely(ret))
+		dev_err(bq2416x->dev, "Can't reset watchdog timer\n");
+
+	return ret;
+}
+
+/**
+ * bq2416x_configure - configures charger per DT/platform data
+ * @bq2416x: the charger device
+ *
+ * Returns 0 if there is no error or negative on error.
+ */
+static int bq2416x_configure(struct bq2416x_priv *bq2416x)
+{
+	struct bq2416x_pdata *pdata = &bq2416x->pdata;
+	int ret;
+	unsigned int mask, bits;
+
+	ret = bq2416x_reset_watchdog_tmr(bq2416x);
+	if (unlikely(ret))
+		return ret;
+
+	ret = bq2416x_set_charge_voltage(bq2416x, pdata->charge_voltage);
+	if (unlikely(ret))
+		return ret;
+
+	ret = regmap_update_bits(bq2416x->regmap,
+			BQ2416X_REG_BAT_VOLT,
+			BQ2416X_REG_BAT_VOLT_IN_CURR_LIM_MASK,
+			BF_SHIFT(pdata->in_curr_limit,
+			BQ2416X_REG_BAT_VOLT_IN_CURR_LIM_MASK));
+	if (unlikely(ret))
+		return ret;
+
+	ret = regmap_update_bits(bq2416x->regmap,
+			BQ2416X_REG_CONTROL, BQ2416X_REG_CONTROL_RESET_MASK |
+			BQ2416X_REG_CONTROL_USB_CURR_LIM_MASK,
+			BF_SHIFT(pdata->usb_curr_limit,
+			BQ2416X_REG_CONTROL_USB_CURR_LIM_MASK));
+	if (unlikely(ret))
+		return ret;
+
+	mask =  BQ2416X_REG_CONTROL_RESET_MASK |
+		BQ2416X_REG_CONTROL_EN_STAT_MASK |
+		BQ2416X_REG_CONTROL_TE_MASK |
+		BQ2416X_REG_CONTROL_CE_MASK;
+
+	bits =  BF_SHIFT(pdata->stat_pin_en,
+			BQ2416X_REG_CONTROL_EN_STAT_MASK) |
+		BF_SHIFT(pdata->curr_term_en,
+			BQ2416X_REG_CONTROL_TE_MASK);
+
+	ret = regmap_update_bits(bq2416x->regmap,
+			BQ2416X_REG_CONTROL,
+			mask,
+			bits);
+	if (unlikely(ret))
+		return ret;
+
+	ret = bq2416x_set_charge_current(bq2416x, pdata->charge_current);
+	if (unlikely(ret))
+		return ret;
+
+	ret = bq2416x_set_term_current(bq2416x, pdata->term_current);
+	if (unlikely(ret))
+		return ret;
+
+	ret = bq2416x_set_usb_dpm_voltage(bq2416x, pdata->usb_dpm_voltage);
+	if (unlikely(ret))
+		return ret;
+
+	ret = bq2416x_set_in_dpm_voltage(bq2416x, pdata->in_dpm_voltage);
+	if (unlikely(ret))
+		return ret;
+
+	ret = regmap_update_bits(bq2416x->regmap,
+			BQ2416X_REG_NTC, BQ2416X_REG_NTC_TMR_MASK,
+			BF_SHIFT(pdata->safety_timer,
+			BQ2416X_REG_NTC_TMR_MASK));
+
+	return ret;
+}
+
+/**
+ * Status pin interrupt handler. It sends uevent upon charger status change
+ */
+static irqreturn_t bq2416x_thread_irq(int irq, void *priv)
+{
+	struct bq2416x_priv *bq2416x = priv;
+
+	/* Give registers some time */
+	msleep(300);
+
+	power_supply_changed(bq2416x->psy);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * Worker for watchdog timer reset.
+ */
+static void bq2416x_watchdog_work(struct work_struct *work)
+{
+	struct bq2416x_priv *bq2416x = container_of(work, struct bq2416x_priv,
+						 watchdog.work);
+
+	pm_runtime_get_sync(bq2416x->dev);
+	bq2416x_reset_watchdog_tmr(bq2416x);
+	pm_runtime_put_sync(bq2416x->dev);
+
+	schedule_delayed_work(&bq2416x->watchdog, BQ2416X_WATCHDOG_TIMER * HZ);
+}
+
+/**
+ * power-supply class get property callback
+ */
+static int bq2416x_psy_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+
+	pm_runtime_get_sync(bq2416x->dev);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = bq2416x_get_status(bq2416x, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = bq2416x->model;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "Texas Instruments";
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		ret = bq2416x_get_charge_type(bq2416x, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret = bq2416x_get_health(bq2416x, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = bq2416x_get_online(bq2416x, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		ret = bq2416x_get_charge_current(bq2416x, &val->intval);
+		val->intval *= 1000;
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		val->intval = BQ2416X_CHARGE_CURRENT_MAX;
+		val->intval *= 1000;
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = bq2416x_get_charge_voltage(bq2416x, &val->intval);
+		val->intval *= 1000;
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		val->intval = BQ2416X_CHARGE_VOLTAGE_MAX;
+		val->intval *= 1000;
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pm_runtime_put_sync(bq2416x->dev);
+	return ret;
+}
+
+/**
+ * power-supply class set property callback
+ */
+static int bq2416x_psy_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+
+	pm_runtime_get_sync(bq2416x->dev);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		ret = bq2416x_set_charge_type(bq2416x, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		ret = bq2416x_set_charge_current(bq2416x, val->intval / 1000);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = bq2416x_set_charge_voltage(bq2416x, val->intval / 1000);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	pm_runtime_put_sync(bq2416x->dev);
+	return ret;
+}
+
+/**
+ * device attributes callbacks
+ */
+static ssize_t bq2416x_sysfs_show_charge_status(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int val;
+	const char *str;
+
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_STATUS, &val);
+	if (unlikely(ret != 0))
+		return ret;
+
+	if (strcmp(attr->attr.name, "charge_status") == 0) {
+		val = BF_GET(val, BQ2416X_REG_STATUS_STAT_MASK);
+		str = bq2416x_charge_status[val].str;
+	} else if (strcmp(attr->attr.name, "charge_fault") == 0) {
+		val = BF_GET(val, BQ2416X_REG_STATUS_FAULT_MASK);
+		str = bq2416x_charge_fault[val].str;
+	} else if (strcmp(attr->attr.name, "supply_sel") == 0) {
+		if (val & BQ2416X_REG_STATUS_SUPPLY_SEL_MASK)
+			str = "usb";
+		else
+			str = "in";
+	} else
+		return -EINVAL;
+
+	return sprintf(buf, "%s\n", str);
+}
+
+static ssize_t bq2416x_sysfs_store_supply_sel(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+
+	if (strncmp(buf, "usb", 3) == 0)
+		ret = regmap_update_bits(bq2416x->regmap,
+			BQ2416X_REG_STATUS,
+			BQ2416X_REG_STATUS_SUPPLY_SEL_MASK,
+			BQ2416X_REG_STATUS_SUPPLY_SEL_MASK);
+	else if (strncmp(buf, "in", 2) == 0)
+		ret = regmap_update_bits(bq2416x->regmap,
+			BQ2416X_REG_STATUS,
+			BQ2416X_REG_STATUS_SUPPLY_SEL_MASK,
+			0);
+	else
+		ret = -EINVAL;
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t bq2416x_sysfs_show_supply_status(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int val;
+	const char *str;
+
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_SUP_STATUS, &val);
+	if (unlikely(ret != 0))
+		return ret;
+
+	if (strcmp(attr->attr.name, "in_status") == 0) {
+		val = BF_GET(val, BQ2416X_REG_SUP_STATUS_INSTAT_MASK);
+		str = bq2416x_in_status[val];
+	} else if (strcmp(attr->attr.name, "usb_status") == 0) {
+		val = BF_GET(val, BQ2416X_REG_SUP_STATUS_USBSTAT_MASK);
+		str = bq2416x_in_status[val];
+	} else if (strcmp(attr->attr.name, "bat_status") == 0) {
+		val = BF_GET(val, BQ2416X_REG_SUP_STATUS_BATSTAT_MASK);
+		str = bq2416x_bat_status[val];
+	} else
+		return -EINVAL;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", str);
+}
+
+static ssize_t bq2416x_sysfs_show_charge_voltage(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int voltage;
+
+	ret = bq2416x_get_charge_voltage(bq2416x, &voltage);
+	if (unlikely(ret))
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", voltage);
+}
+
+static ssize_t bq2416x_sysfs_store_charge_voltage(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int voltage;
+
+	ret = kstrtouint(buf, 0, &voltage);
+	if (unlikely(ret))
+		return -EINVAL;
+
+	ret = bq2416x_set_charge_voltage(bq2416x, voltage);
+	if (unlikely(ret))
+		return ret;
+
+	return count;
+}
+
+static ssize_t bq2416x_sysfs_show_in_curr_limit(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int limit;
+
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_BAT_VOLT, &limit);
+	if (unlikely(ret))
+		return ret;
+
+	limit = BF_GET(limit, BQ2416X_REG_BAT_VOLT_IN_CURR_LIM_MASK);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", bq24160_in_lim[limit]);
+
+}
+
+static ssize_t bq2416x_sysfs_store_in_curr_limit(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int reg_bits, limit;
+
+	ret = kstrtouint(buf, 0, &limit);
+	if (unlikely(ret))
+		return -EINVAL;
+
+	if (limit < 2500)
+		reg_bits = BQ2416X_IN_CURR_LIM_1500;
+	else
+		reg_bits = BQ2416X_IN_CURR_LIM_2500;
+
+	ret = regmap_update_bits(bq2416x->regmap,
+				BQ2416X_REG_BAT_VOLT,
+				BQ2416X_REG_BAT_VOLT_IN_CURR_LIM_MASK,
+				BF_SHIFT(reg_bits,
+				BQ2416X_REG_BAT_VOLT_IN_CURR_LIM_MASK));
+	if (unlikely(ret))
+		return ret;
+
+	return count;
+}
+
+static ssize_t bq2416x_sysfs_show_usb_curr_limit(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int limit;
+
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_CONTROL, &limit);
+	if (unlikely(ret != 0))
+		return ret;
+
+	limit = BF_GET(limit, BQ2416X_REG_CONTROL_USB_CURR_LIM_MASK);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", bq2416x_usb_curr_lim[limit]);
+}
+
+static ssize_t bq2416x_sysfs_store_usb_curr_limit(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int curr, reg_bits;
+
+	ret = kstrtouint(buf, 0, &curr);
+	if (unlikely(ret))
+		return -EINVAL;
+
+	if (curr < 150)
+		reg_bits = USB_CURR_LIM_100MA;
+	else if (curr < 500)
+		reg_bits = USB_CURR_LIM_150MA;
+	else if (curr < 800)
+		reg_bits = USB_CURR_LIM_500MA;
+	else if (curr < 900)
+		reg_bits = USB_CURR_LIM_800MA;
+	else if (curr < 1500)
+		reg_bits = USB_CURR_LIM_900MA;
+	else
+		reg_bits = USB_CURR_LIM_1500MA;
+
+	ret = regmap_update_bits(bq2416x->regmap,
+			BQ2416X_REG_CONTROL, BQ2416X_REG_CONTROL_RESET_MASK |
+			BQ2416X_REG_CONTROL_USB_CURR_LIM_MASK,
+			BF_SHIFT(reg_bits,
+			BQ2416X_REG_CONTROL_USB_CURR_LIM_MASK));
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t bq2416x_sysfs_show_charge_current(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret, curr;
+
+	ret = bq2416x_get_charge_current(bq2416x, &curr);
+	if (unlikely(ret))
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", curr);
+}
+
+static ssize_t bq2416x_sysfs_store_charge_current(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int curr;
+
+	ret = kstrtouint(buf, 0, &curr);
+	if (unlikely(ret))
+		return -EINVAL;
+
+	ret = bq2416x_set_charge_current(bq2416x, curr);
+	if (unlikely(ret))
+		return ret;
+
+	return count;
+}
+
+static ssize_t bq2416x_sysfs_show_term_current(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int term_curr;
+
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_TERM, &term_curr);
+	if (unlikely(ret))
+		return ret;
+
+	term_curr = BF_GET(term_curr, BQ2416X_REG_TERM_TERM_CURR_MASK) *
+			BQ2416X_CHARGE_TERM_CURRENT_STEP +
+			BQ2416X_CHARGE_TERM_CURRENT_MIN;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", term_curr);
+}
+
+static ssize_t bq2416x_sysfs_store_term_current(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int term_curr;
+
+	ret = kstrtouint(buf, 0, &term_curr);
+	if (unlikely(ret))
+		return -EINVAL;
+
+	ret = bq2416x_set_term_current(bq2416x, term_curr);
+	if (unlikely(ret))
+		return ret;
+
+	return count;
+}
+
+static ssize_t bq2416x_sysfs_show_dpm_voltage(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int reg_val, dpm_volt;
+
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_DPM, &reg_val);
+	if (unlikely(ret != 0))
+		return ret;
+
+	if (strcmp(attr->attr.name, "usb_dpm_voltage") == 0)
+		dpm_volt = BF_GET(reg_val, BQ2416X_REG_DPM_USB_VOLT_MASK);
+	else if (strcmp(attr->attr.name, "in_dpm_voltage") == 0)
+		dpm_volt = BF_GET(reg_val, BQ2416X_REG_DPM_IN_VOLT_MASK);
+	else
+		return -EINVAL;
+
+	dpm_volt = dpm_volt * BQ2416X_DPM_IN_VOLTAGE_STEP +
+		   BQ2416X_DPM_IN_VOLTAGE_MIN;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", dpm_volt);
+}
+
+static ssize_t bq2416x_sysfs_store_dpm_voltage(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int dpm_volt;
+
+	ret = kstrtouint(buf, 0, &dpm_volt);
+	if (unlikely(ret))
+		return -EINVAL;
+
+	if (strcmp(attr->attr.name, "usb_dpm_voltage") == 0)
+		ret = bq2416x_set_usb_dpm_voltage(bq2416x, dpm_volt);
+	else if (strcmp(attr->attr.name, "in_dpm_voltage") == 0)
+		ret = bq2416x_set_in_dpm_voltage(bq2416x, dpm_volt);
+	else
+		ret =  -EINVAL;
+
+	if (ret)
+		return ret;
+
+	return count;
+
+}
+
+static ssize_t bq2416x_sysfs_show_safety_timer(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int val;
+	const char *str;
+
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_NTC, &val);
+	if (unlikely(ret != 0))
+		return ret;
+
+	if (strcmp(attr->attr.name, "safety_timer") == 0) {
+		val = BF_GET(val, BQ2416X_REG_NTC_TMR_MASK);
+		str = bq2416x_tmr[val];
+	} else if (strcmp(attr->attr.name, "ts_fault") == 0) {
+		val = BF_GET(val, BQ2416X_REG_NTC_TS_FAULT_MASK);
+		str = bq2416x_ts_fault[val];
+	} else
+		return -EINVAL;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", str);
+}
+
+static ssize_t bq2416x_sysfs_store_safety_timer(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int tmr;
+	bool found = false;
+
+	for (tmr = 0; tmr <= TMR_OFF; tmr++) {
+		if (strncmp(buf, bq2416x_tmr[tmr],
+		    strlen(bq2416x_tmr[tmr])) == 0) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	ret = regmap_update_bits(bq2416x->regmap,
+			BQ2416X_REG_NTC, BQ2416X_REG_NTC_TMR_MASK,
+			BF_SHIFT(tmr, BQ2416X_REG_NTC_TMR_MASK));
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t bq2416x_sysfs_show_bit(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	int ret;
+	unsigned int reg_val;
+	unsigned int reg = sattr->nr, mask = sattr->index;
+
+	ret = regmap_read(bq2416x->regmap, reg, &reg_val);
+	if (unlikely(ret != 0))
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(reg_val & mask));
+}
+
+static ssize_t bq2416x_sysfs_store_bit(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq2416x_priv *bq2416x = power_supply_get_drvdata(psy);
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+	int ret;
+	unsigned int bits;
+	unsigned int reg = sattr->nr, mask = sattr->index;
+
+	if (strncmp(buf, "1", 1) == 0)
+		bits = mask;
+	else if (strncmp(buf, "0", 1) == 0)
+		bits = 0;
+	else
+		return -EINVAL;
+
+	/* clear reset bit before writeback */
+	if (reg == BQ2416X_REG_CONTROL)
+		mask |= BQ2416X_REG_CONTROL_RESET_MASK;
+
+	ret = regmap_update_bits(bq2416x->regmap,
+			reg,
+			mask,
+			bits);
+	if (unlikely(ret))
+		return ret;
+
+	return count;
+}
+
+#define BIT_DEVICE_ATTR(_name, _mode, _reg, _bit)			\
+	SENSOR_DEVICE_ATTR_2(_name, _mode, bq2416x_sysfs_show_bit,	\
+	bq2416x_sysfs_store_bit, _reg, _bit)
+
+static DEVICE_ATTR(charge_status, 0444,
+			bq2416x_sysfs_show_charge_status, NULL);
+static DEVICE_ATTR(charge_fault, 0444,
+			bq2416x_sysfs_show_charge_status, NULL);
+static DEVICE_ATTR(supply_sel, 0644,
+			bq2416x_sysfs_show_charge_status,
+			bq2416x_sysfs_store_supply_sel);
+static BIT_DEVICE_ATTR(timer_rst, 0200,
+			BQ2416X_REG_STATUS, BQ2416X_REG_STATUS_TMR_RST_MASK);
+static DEVICE_ATTR(in_status, 0444,
+			bq2416x_sysfs_show_supply_status, NULL);
+static DEVICE_ATTR(usb_status, 0444,
+			bq2416x_sysfs_show_supply_status, NULL);
+static BIT_DEVICE_ATTR(otg_lock, 0644,
+			BQ2416X_REG_SUP_STATUS,
+			BQ2416X_REG_SUP_STATUS_OTG_LOCK_MASK);
+static BIT_DEVICE_ATTR(nobatop_en, 0644,
+			BQ2416X_REG_SUP_STATUS,
+			BQ2416X_REG_SUP_STATUS_EN_NOBATOP_MASK);
+static DEVICE_ATTR(bat_status, 0444,
+			bq2416x_sysfs_show_supply_status, NULL);
+static DEVICE_ATTR(charge_voltage, 0644,
+			bq2416x_sysfs_show_charge_voltage,
+			bq2416x_sysfs_store_charge_voltage);
+static DEVICE_ATTR(in_curr_limit, 0644,
+			bq2416x_sysfs_show_in_curr_limit,
+			bq2416x_sysfs_store_in_curr_limit);
+static DEVICE_ATTR(usb_curr_limit, 0644,
+			bq2416x_sysfs_show_usb_curr_limit,
+			bq2416x_sysfs_store_usb_curr_limit);
+static BIT_DEVICE_ATTR(stat_pin_en, 0644,
+			BQ2416X_REG_CONTROL,
+			BQ2416X_REG_CONTROL_EN_STAT_MASK);
+static BIT_DEVICE_ATTR(curr_term_en, 0644,
+			BQ2416X_REG_CONTROL,
+			BQ2416X_REG_CONTROL_TE_MASK);
+static BIT_DEVICE_ATTR(charging_disable, 0644,
+			BQ2416X_REG_CONTROL,
+			BQ2416X_REG_CONTROL_CE_MASK);
+static BIT_DEVICE_ATTR(hz_mode, 0644,
+			BQ2416X_REG_CONTROL,
+			BQ2416X_REG_CONTROL_HZ_MODE_MASK);
+static DEVICE_ATTR(charge_current, 0644,
+			bq2416x_sysfs_show_charge_current,
+			bq2416x_sysfs_store_charge_current);
+static DEVICE_ATTR(term_current, 0644,
+			bq2416x_sysfs_show_term_current,
+			bq2416x_sysfs_store_term_current);
+static BIT_DEVICE_ATTR(min_sys_stat, 0444,
+			BQ2416X_REG_DPM,
+			BQ2416X_REG_DPM_MINSYS_STATUS_MASK);
+static BIT_DEVICE_ATTR(dpm_status, 0444,
+			BQ2416X_REG_DPM,
+			BQ2416X_REG_DPM_STATUS_MASK);
+static DEVICE_ATTR(usb_dpm_voltage, 0644,
+			bq2416x_sysfs_show_dpm_voltage,
+			bq2416x_sysfs_store_dpm_voltage);
+static DEVICE_ATTR(in_dpm_voltage, 0644,
+			bq2416x_sysfs_show_dpm_voltage,
+			bq2416x_sysfs_store_dpm_voltage);
+static BIT_DEVICE_ATTR(safety_timer_x2, 0644,
+			BQ2416X_REG_NTC,
+			BQ2416X_REG_NTC_TMRX2_MASK);
+static DEVICE_ATTR(safety_timer, 0644,
+			bq2416x_sysfs_show_safety_timer,
+			bq2416x_sysfs_store_safety_timer);
+static BIT_DEVICE_ATTR(ts_enable, 0644,
+			BQ2416X_REG_NTC,
+			BQ2416X_REG_NTC_TS_EN_MASK);
+static DEVICE_ATTR(ts_fault, 0444,
+			bq2416x_sysfs_show_safety_timer, NULL);
+static BIT_DEVICE_ATTR(low_charge, 0644,
+			BQ2416X_REG_NTC,
+			BQ2416X_REG_NTC_LOW_CHARGE_MASK);
+
+static struct attribute *bq2416x_sysfs_attributes[] = {
+	&dev_attr_charge_status.attr,
+	&dev_attr_charge_fault.attr,
+	&dev_attr_supply_sel.attr,
+	&sensor_dev_attr_timer_rst.dev_attr.attr,
+	&dev_attr_in_status.attr,
+	&dev_attr_usb_status.attr,
+	&sensor_dev_attr_otg_lock.dev_attr.attr,
+	&sensor_dev_attr_nobatop_en.dev_attr.attr,
+	&dev_attr_bat_status.attr,
+	&dev_attr_charge_voltage.attr,
+	&dev_attr_in_curr_limit.attr,
+	&dev_attr_usb_curr_limit.attr,
+	&sensor_dev_attr_stat_pin_en.dev_attr.attr,
+	&sensor_dev_attr_curr_term_en.dev_attr.attr,
+	&sensor_dev_attr_charging_disable.dev_attr.attr,
+	&sensor_dev_attr_hz_mode.dev_attr.attr,
+	&dev_attr_charge_current.attr,
+	&dev_attr_term_current.attr,
+	&sensor_dev_attr_min_sys_stat.dev_attr.attr,
+	&sensor_dev_attr_dpm_status.dev_attr.attr,
+	&dev_attr_usb_dpm_voltage.attr,
+	&dev_attr_in_dpm_voltage.attr,
+	&sensor_dev_attr_safety_timer_x2.dev_attr.attr,
+	&dev_attr_safety_timer.attr,
+	&sensor_dev_attr_ts_enable.dev_attr.attr,
+	&dev_attr_ts_fault.attr,
+	&sensor_dev_attr_low_charge.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group bq2416x_sysfs_attr_group = {
+	.attrs = bq2416x_sysfs_attributes,
+};
+
+#if defined(CONFIG_OF)
+static const struct of_device_id bq2416x_of_match[] = {
+	{ .compatible = "ti,bq24160" },
+	{ .compatible = "ti,bq24160a" },
+	{ .compatible = "ti,bq24161" },
+	{ .compatible = "ti,bq24161b" },
+	{ .compatible = "ti,bq24163" },
+	{ .compatible = "ti,bq24168" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bq2416x_of_match);
+
+static void bq2416x_pdata_set_default(struct bq2416x_pdata *pdata)
+{
+	pdata->charge_voltage	= 4200;
+	pdata->in_curr_limit	= IN_CURR_LIM_1500MA;
+	pdata->usb_curr_limit	= USB_CURR_LIM_100MA;
+	pdata->stat_pin_en	= 1;
+	pdata->curr_term_en	= 1;
+	pdata->charge_current	= 1150;
+	pdata->term_current	= 100;
+	pdata->usb_dpm_voltage	= 4200;
+	pdata->in_dpm_voltage	= 4200;
+	pdata->safety_timer	= TMR_27MIN;
+	pdata->num_supplicants	= 1;
+	pdata->supplied_to[0]	= "main-battery";
+}
+
+static int bq2416x_pdata_from_of(struct bq2416x_priv *bq2416x)
+{
+	struct device_node *np = bq2416x->dev->of_node;
+	struct bq2416x_pdata *pdata = &bq2416x->pdata;
+	int ret, i, num_strings;
+	unsigned int prop;
+	const char *supplied_to[4];
+
+	bq2416x_pdata_set_default(pdata);
+
+	ret = of_property_read_u32(np, "ti,charge-voltage", &prop);
+	if (!ret)
+		pdata->charge_voltage = prop;
+
+	ret = of_property_read_u32(np, "ti,in-current-limit", &prop);
+	if (!ret)
+		pdata->in_curr_limit = prop;
+
+	ret = of_property_read_u32(np, "ti,usb-current-limit", &prop);
+	if (!ret)
+		pdata->usb_curr_limit = prop;
+
+	ret = of_property_read_u32(np, "ti,status-pin-enable", &prop);
+	if (!ret)
+		pdata->stat_pin_en = prop;
+
+	ret = of_property_read_u32(np, "ti,current-termination-enable", &prop);
+	if (!ret)
+		pdata->curr_term_en = prop;
+
+	ret = of_property_read_u32(np, "ti,charge-current", &prop);
+	if (!ret)
+		pdata->charge_current = prop;
+
+	ret = of_property_read_u32(np, "ti,termination-current", &prop);
+	if (!ret)
+		pdata->term_current = prop;
+
+	ret = of_property_read_u32(np, "ti,usb-dpm-voltage", &prop);
+	if (!ret)
+		pdata->usb_dpm_voltage = prop;
+
+	ret = of_property_read_u32(np, "ti,in-dpm-voltage", &prop);
+	if (!ret)
+		pdata->in_dpm_voltage = prop;
+
+	ret = of_property_read_u32(np, "ti,safety-timer", &prop);
+	if (!ret)
+		pdata->safety_timer = prop;
+
+	ret = of_property_read_string_array(np, "ti,supplied-to",
+				supplied_to, prop);
+	if (ret > 0) {
+		num_strings = ret;
+		if (num_strings > 4)
+			return -EINVAL;
+
+		pdata->num_supplicants = num_strings;
+		for (i = 0; i < num_strings; i++)
+			pdata->supplied_to[i] = supplied_to[i];
+	}
+
+	return ret;
+}
+#else /* CONFIG_OF */
+static int bq2416x_pdata_from_of(struct bq2416x_priv *bq2416x)
+{
+	return 0;
+}
+#endif /* CONFIG_OF */
+
+#ifdef CONFIG_PM_SLEEP
+static int bq2416x_suspend(struct device *dev)
+{
+	struct bq2416x_priv *bq2416x = dev_get_drvdata(dev);
+
+	cancel_delayed_work(&bq2416x->watchdog);
+
+	pm_runtime_get_sync(bq2416x->dev);
+	bq2416x_set_charge_type(bq2416x, POWER_SUPPLY_CHARGE_TYPE_NONE);
+	pm_runtime_put_sync(bq2416x->dev);
+
+	return 0;
+}
+
+static int bq2416x_resume(struct device *dev)
+{
+	struct bq2416x_priv *bq2416x = dev_get_drvdata(dev);
+
+	pm_runtime_get_sync(bq2416x->dev);
+	bq2416x_reset_watchdog_tmr(bq2416x);
+	bq2416x_set_charge_type(bq2416x, POWER_SUPPLY_CHARGE_TYPE_FAST);
+	pm_runtime_put_sync(bq2416x->dev);
+
+	schedule_delayed_work(&bq2416x->watchdog, BQ2416X_WATCHDOG_TIMER * HZ);
+
+	power_supply_changed(bq2416x->psy);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(bq2416x_pm_ops, bq2416x_suspend, bq2416x_resume);
+
+static int bq2416x_device_init(struct bq2416x_priv *bq2416x)
+{
+	int ret;
+	unsigned int vendor_reg, vendor_code, revision;
+	struct power_supply_config psy_cfg = { .drv_data = bq2416x };
+	struct bq2416x_pdata *pdata = &bq2416x->pdata;
+
+	dev_set_drvdata(bq2416x->dev, bq2416x);
+
+	if (dev_get_platdata(bq2416x->dev))
+		memcpy(pdata, dev_get_platdata(bq2416x->dev),
+			sizeof(*pdata));
+	else if (bq2416x->dev->of_node) {
+		ret = bq2416x_pdata_from_of(bq2416x);
+		if (ret < 0) {
+			dev_err(bq2416x->dev, "OF: not able to process DT\n");
+			return ret;
+		}
+	}
+
+	pm_runtime_get_sync(bq2416x->dev);
+	ret = regmap_read(bq2416x->regmap, BQ2416X_REG_VENDOR, &vendor_reg);
+	if (unlikely(ret)) {
+		dev_err(bq2416x->dev, "Can't read vendor code\n");
+		return ret;
+	}
+	pm_runtime_put_sync(bq2416x->dev);
+
+	vendor_code = BF_GET(vendor_reg, BQ2416X_REG_VENDOR_CODE_MASK);
+	revision = BF_GET(vendor_reg, BQ2416X_REG_VENDOR_REV_MASK);
+
+	dev_info(bq2416x->dev, "Found BQ2416X, code: 0x%02x rev: %s\n",
+			vendor_code, bq2416x_revision[revision]);
+
+	bq2416x->psy_desc.name = bq2416x->name;
+	bq2416x->psy_desc.type = POWER_SUPPLY_TYPE_USB;
+	bq2416x->psy_desc.properties = bq2416x_power_supply_props;
+	bq2416x->psy_desc.get_property = bq2416x_psy_get_property;
+	bq2416x->psy_desc.set_property = bq2416x_psy_set_property;
+	bq2416x->psy_desc.num_properties =
+					ARRAY_SIZE(bq2416x_power_supply_props);
+	psy_cfg.supplied_to = (char **) pdata->supplied_to;
+	psy_cfg.num_supplicants = pdata->num_supplicants;
+	bq2416x->psy_desc.property_is_writeable = bq2416x_property_is_writeable;
+
+	bq2416x->psy = power_supply_register(bq2416x->dev, &bq2416x->psy_desc,
+						&psy_cfg);
+	if (unlikely(IS_ERR(bq2416x->psy))) {
+		dev_err(bq2416x->dev, "Can't register power supply\n");
+		return PTR_ERR(bq2416x->psy);
+	}
+
+	return ret;
+}
+
+int bq2416x_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(i2c->dev.parent);
+	struct bq2416x_priv *bq2416x;
+	int ret, idr;
+	char *model, *name;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+		dev_err(&i2c->dev, "No support for SMBUS_BYTE_DATA\n");
+		return -ENODEV;
+	}
+
+	/* Get id for the new charger device */
+	mutex_lock(&bq2416x_idr_mutex);
+	idr = idr_alloc(&bq2416x_idr, i2c, 0, 0, GFP_KERNEL);
+	mutex_unlock(&bq2416x_idr_mutex);
+
+	if (IS_ERR_VALUE((unsigned long) idr))
+		return idr;
+
+	model = devm_kzalloc(&i2c->dev, strlen(id->name), GFP_KERNEL);
+	if (unlikely(!model)) {
+		dev_err(&i2c->dev, "Failed to allocate name\n");
+		ret = -ENOMEM;
+		goto err_rel_id;
+	}
+	strncpy(model, id->name, strlen(id->name));
+
+	bq2416x = devm_kzalloc(&i2c->dev, sizeof(*bq2416x), GFP_KERNEL);
+	if (unlikely(!bq2416x)) {
+		dev_err(&i2c->dev, "Failed to allocate private data\n");
+		ret = -ENOMEM;
+		goto err_rel_id;
+	}
+
+	bq2416x->regmap = devm_regmap_init_i2c(i2c, &bq2416x_i2c_regmap);
+	if (IS_ERR(bq2416x->regmap)) {
+		ret = PTR_ERR(bq2416x->regmap);
+		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+			ret);
+		goto err_rel_id;
+	}
+
+	name = kasprintf(GFP_KERNEL, "%s-%d", id->name, idr);
+	if (unlikely(!name)) {
+		dev_err(&i2c->dev, "Failed to allocate device name\n");
+		ret = -ENOMEM;
+		goto err_rel_id;
+	}
+
+	pm_runtime_enable(&i2c->dev);
+	pm_runtime_resume(&i2c->dev);
+
+	bq2416x->dev  = &i2c->dev;
+	bq2416x->idr  = idr;
+	bq2416x->model = model;
+	bq2416x->name  = name;
+
+	ret = bq2416x_device_init(bq2416x);
+	if (ret)
+		goto err_free_name;
+
+	ret = bq2416x_configure(bq2416x);
+	if (unlikely(ret)) {
+		dev_err(bq2416x->dev, "Inital configuration failed\n");
+		goto err_unregister_psy;
+	}
+
+	ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
+				bq2416x_thread_irq, IRQF_TRIGGER_RISING |
+				IRQF_ONESHOT, "bq2416xinterrupt", bq2416x);
+	if (ret) {
+		dev_err(&i2c->dev, "Can't request IRQ\n");
+		goto err_unregister_psy;
+	}
+
+	ret = sysfs_create_group(&bq2416x->psy->dev.kobj,
+			&bq2416x_sysfs_attr_group);
+	if (unlikely(ret)) {
+		dev_err(bq2416x->dev, "Can't create sysfs entries\n");
+		goto err_unregister_psy;
+	}
+
+	INIT_DELAYED_WORK(&bq2416x->watchdog, bq2416x_watchdog_work);
+	schedule_delayed_work(&bq2416x->watchdog, BQ2416X_WATCHDOG_TIMER * HZ);
+
+	return 0;
+
+err_unregister_psy:
+	power_supply_unregister(bq2416x->psy);
+err_free_name:
+	pm_runtime_disable(&i2c->dev);
+	kfree(name);
+err_rel_id:
+	mutex_lock(&bq2416x_idr_mutex);
+	idr_remove(&bq2416x_idr, idr);
+	mutex_unlock(&bq2416x_idr_mutex);
+
+	return ret;
+}
+
+static int bq2416x_i2c_remove(struct i2c_client *i2c)
+{
+	struct bq2416x_priv *bq2416x = i2c_get_clientdata(i2c);
+
+	cancel_delayed_work_sync(&bq2416x->watchdog);
+	sysfs_remove_group(&bq2416x->psy->dev.kobj, &bq2416x_sysfs_attr_group);
+	power_supply_unregister(bq2416x->psy);
+	pm_runtime_disable(bq2416x->dev);
+
+	mutex_lock(&bq2416x_idr_mutex);
+	idr_remove(&bq2416x_idr, bq2416x->idr);
+	mutex_unlock(&bq2416x_idr_mutex);
+
+	kfree(bq2416x->name);
+
+	return 0;
+}
+
+static const struct i2c_device_id  bq2416x_i2c_id[] = {
+	{ "bq24160",  BQ24160 },
+	{ "bq24160a", BQ24160A },
+	{ "bq24161",  BQ24161 },
+	{ "bq24161b", BQ24161B },
+	{ "bq24163",  BQ24163 },
+	{ "bq24168",  BQ24168 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, bq2416x_i2c_id);
+
+static struct i2c_driver bq2416x_i2c_driver = {
+	.driver = {
+		.name	= "bq2416x-charger",
+		.of_match_table = of_match_ptr(bq2416x_of_match),
+		.pm     = &bq2416x_pm_ops,
+	},
+	.probe		= bq2416x_i2c_probe,
+	.remove		= bq2416x_i2c_remove,
+	.id_table	= bq2416x_i2c_id,
+};
+
+module_i2c_driver(bq2416x_i2c_driver);
+
+MODULE_DESCRIPTION("TI BQ2416x battery charger driver");
+MODULE_AUTHOR("Wojciech Ziemba <wojciech.ziemba@verifone.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/dt-bindings/power/bq2416x_charger.h b/include/dt-bindings/power/bq2416x_charger.h
new file mode 100644
index 0000000..67363fd
--- /dev/null
+++ b/include/dt-bindings/power/bq2416x_charger.h
@@ -0,0 +1,23 @@
+/*
+ * This header provides constants for bq2416x bindings.
+ */
+
+#ifndef _DT_BINDINGS_POWER_H
+#define _DT_BINDINGS_POWER_H
+
+#define IN_CURR_LIM_1500MA	(0)
+#define IN_CURR_LIM_2500MA	(1)
+
+#define USB_CURR_LIM_100MA	(0)
+#define USB_CURR_LIM_150MA	(1)
+#define USB_CURR_LIM_500MA	(2)
+#define USB_CURR_LIM_800MA	(3)
+#define USB_CURR_LIM_900MA	(4)
+#define USB_CURR_LIM_1500MA	(5)
+
+#define TMR_27MIN	(0)
+#define TMR_6H		(1)
+#define TMR_9H		(2)
+#define TMR_OFF		(3)
+
+#endif /* _DT_BINDINGS_POWER_H */
diff --git a/include/linux/power/bq2416x_charger.h b/include/linux/power/bq2416x_charger.h
new file mode 100644
index 0000000..c561666
--- /dev/null
+++ b/include/linux/power/bq2416x_charger.h
@@ -0,0 +1,80 @@
+/*
+ * Driver for BQ2416X Li-Ion Battery Charger
+ *
+ * Copyright (C) 2015 Verifone, Inc.
+ *
+ * Author: Wojciech Ziemba <wojciech.ziemba@verifone.com>
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED AS IS AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * The bq2416x series is a 2.5A, Dual-Input, Single-Cell Switched-Mode
+ * Li-Ion Battery Charger with Power
+ * Path Management and I2C Interface
+ *
+ */
+
+#ifndef _BQ2416X_CHARGER_H
+#define _BQ2416X_CHARGER_H
+
+/* IN(Wall) source limit */
+enum in_curr_lim {
+	IN_CURR_LIM_1500MA,
+	IN_CURR_LIM_2500MA,
+};
+
+/* USB source current limit */
+enum usb_curr_lim {
+	USB_CURR_LIM_100MA,
+	USB_CURR_LIM_150MA,
+	USB_CURR_LIM_500MA,
+	USB_CURR_LIM_800MA,
+	USB_CURR_LIM_900MA,
+	USB_CURR_LIM_1500MA,
+};
+
+/* Safety timer settings */
+enum safe_tmr {
+	TMR_27MIN,
+	TMR_6H,
+	TMR_9H,
+	TMR_OFF,
+};
+
+/**
+ * struct bq2416x_pdata - Platform data for bq2416x chip. It contains default
+ *			  board voltages and currents.
+ * @charge_voltage: charge voltage in [mV]
+ * @charge_current: charge current in [mA]
+ * @in_curr_limit: Current limit for IN source . Enum 1.5A or 2.5A
+ * @usb_curr_limit: Current limit for USB source Enum 100mA - 1500mA
+ * @curr_term_en: enable charge terination by current
+ * @term_current: charge termination current in [mA]
+ * @usb_dpm_voltage: USB DPM voltage [mV]
+ * @in_dpm_voltage: IN DPM voltage [mV]
+ * @stat_pin_en: status pin enable
+ * @safety_timer: safety timer enum: 27min, 6h, 9h, off.
+ * @num_supplicants: number of notify devices. Max 4.
+ * @supplied_to: array of names of supplied to devices
+ */
+struct bq2416x_pdata {
+	int charge_voltage;
+	int charge_current;
+	enum in_curr_lim in_curr_limit;
+	enum usb_curr_lim usb_curr_limit;
+	int curr_term_en;
+	int term_current;
+	int usb_dpm_voltage;
+	int in_dpm_voltage;
+	int stat_pin_en;
+	enum safe_tmr safety_timer;
+	int num_supplicants;
+	const char *supplied_to[4];
+};
+
+#endif /* _BQ2416X_CHARGER_H */
-- 
1.9.1

