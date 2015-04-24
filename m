From: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Subject: [PATCH] power_supply: Add support for Richtek rt9455 battery charger
Date: Fri, 24 Apr 2015 10:57:20 +0300
Message-ID: <1429862240-21619-1-git-send-email-anda-maria.nicolae@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Based on the datasheet found here:
http://www.richtek.com/download_ds.jsp?p=RT9455

Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
---
 .../devicetree/bindings/power/rt9455_charger.txt   |   38 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/power/Kconfig                              |    6 +
 drivers/power/Makefile                             |    1 +
 drivers/power/rt9455_charger.c                     | 1770 ++++++++++++++++++++
 5 files changed, 1816 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/rt9455_charger.txt
 create mode 100644 drivers/power/rt9455_charger.c

diff --git a/Documentation/devicetree/bindings/power/rt9455_charger.txt b/Documentation/devicetree/bindings/power/rt9455_charger.txt
new file mode 100644
index 0000000..f716cf6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/rt9455_charger.txt
@@ -0,0 +1,38 @@
+Binding for RT rt9455 battery charger
+
+Required properties:
+- compatible: Should contain one of the following:
+ * "rt,rt9455"
+
+- reg:			integer, i2c address of the device.
+- rt,ICHRG:		integer, output charge current in uA.
+- rt,IEOC_PERCENTAGE:	integer, the percent of the output charge current (ICHRG).
+			When the current in constant-voltage phase drops below
+			ICHRG x IEOC_PERCENTAGE, charge is terminated.
+- rt,VOREG:		integer, battery regulation voltage in uV.
+
+Optional properties:
+- rt,VMIVR:		integer, minimum input voltage regulation in uV.
+			Prevents input voltage drop due to insufficient current
+			provided by the power source.
+- rt,IAICR:		integer, input current regulation in uA.
+
+Example:
+
+rt9455@22 {
+	compatible = "rt,rt9455";
+	reg = <0x22>;
+
+	interrupt-parent = <&gpio1>;
+	interrupts = <0 1>;
+
+	interrupt-gpio = <&gpio1 0 1>;
+	reset-gpio = <&gpio1 1 1>;
+
+	rt,ICHRG = <500000>;
+	rt,IEOC_PERCENTAGE = <10>;
+	rt,VOREG = <4200000>;
+
+	rt,VMIVR = <4500000>;
+	rt,IAICR = <500000>;
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389ca13..dc868ed 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -148,6 +148,7 @@ raidsonic	RaidSonic Technology GmbH
 ralink	Mediatek/Ralink Technology Corp.
 ramtron	Ramtron International
 realtek Realtek Semiconductor Corp.
+rt	Richtek Technology Corporation
 renesas	Renesas Electronics Corporation
 ricoh	Ricoh Co. Ltd.
 rockchip	Fuzhou Rockchip Electronics Co., Ltd
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 4091fb0..39f208d 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -439,6 +439,12 @@ config BATTERY_RT5033
 	  The fuelgauge calculates and determines the battery state of charge
 	  according to battery open circuit voltage.
 
+config CHARGER_RT9455
+	tristate "Richtek RT9455 battery charger driver"
+	depends on I2C && GPIOLIB
+	help
+	Say Y to enable support for the Richtek RT9455 battery charger.
+
 source "drivers/power/reset/Kconfig"
 
 endif # POWER_SUPPLY
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index b7b0181..e49abbf 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_BATTERY_MAX17040)	+= max17040_battery.o
 obj-$(CONFIG_BATTERY_MAX17042)	+= max17042_battery.o
 obj-$(CONFIG_BATTERY_Z2)	+= z2_battery.o
 obj-$(CONFIG_BATTERY_RT5033)	+= rt5033_battery.o
+obj-$(CONFIG_CHARGER_RT9455)	+= rt9455_charger.o
 obj-$(CONFIG_BATTERY_S3C_ADC)	+= s3c_adc_battery.o
 obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
 obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
diff --git a/drivers/power/rt9455_charger.c b/drivers/power/rt9455_charger.c
new file mode 100644
index 0000000..57bb97d
--- /dev/null
+++ b/drivers/power/rt9455_charger.c
@@ -0,0 +1,1770 @@
+/*
+ * Driver for Richtek RT9455WSC battery charger.
+ *
+ * Copyright (C) 2015 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/of_irq.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/power_supply.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/acpi.h>
+#include <linux/usb/phy.h>
+
+#define RT9455_MANUFACTURER			"Richtek"
+#define RT9455_MODEL_NAME			"RT9455"
+#define RT9455_DRIVER_NAME			"rt9455-charger"
+
+#define RT9455_IRQ_NAME				"interrupt"
+
+#define RT9455_PWR_RDY_DELAY			1 /* 1 second */
+#define RT9455_MAX_CHARGING_TIME		21600 /* 6 hrs */
+#define RT9455_BATT_PRESENCE_DELAY		60 /* 60 seconds */
+
+#define RT9455_CHARGE_MODE			0x00
+#define RT9455_BOOST_MODE			0x01
+
+#define RT9455_FAULT				0x03
+
+#define RT9455_IAICR_100MA			0x00
+#define RT9455_IAICR_500MA			0x01
+#define RT9455_IAICR_NO_LIMIT			0x03
+
+#define RT9455_CHARGE_DISABLE			0x00
+#define RT9455_CHARGE_ENABLE			0x01
+
+#define RT9455_PWR_FAULT			0x00
+#define RT9455_PWR_GOOD				0x01
+
+#define RT9455_REG_CTRL1			0x00 /* Control1 */
+#define RT9455_REG_CTRL1_STAT_MASK		(BIT(5) | BIT(4))
+#define RT9455_REG_CTRL1_STAT_SHIFT		4
+#define RT9455_REG_CTRL1_BOOST_MASK		BIT(3)
+#define RT9455_REG_CTRL1_BOOST_SHIFT		3
+#define RT9455_REG_CTRL1_PWR_RDY_MASK		BIT(2)
+#define RT9455_REG_CTRL1_PWR_RDY_SHIFT		2
+#define RT9455_REG_CTRL1_OTG_PIN_POLARITY_MASK	BIT(1)
+#define RT9455_REG_CTRL1_OTG_PIN_POLARITY_SHIFT	1
+
+#define RT9455_REG_CTRL2			0x01 /* Control2 */
+#define RT9455_REG_CTRL2_IAICR_MASK		(BIT(7) | BIT(6))
+#define RT9455_REG_CTRL2_IAICR_SHIFT		6
+#define RT9455_REG_CTRL2_TE_SHDN_EN_MASK	BIT(5)
+#define RT9455_REG_CTRL2_TE_SHDN_EN_SHIFT	5
+#define RT9455_REG_CTRL2_HIGHER_OCP_MASK	BIT(4)
+#define RT9455_REG_CTRL2_HIGHER_OCP_SHIFT	4
+#define RT9455_REG_CTRL2_TE_MASK		BIT(3)
+#define RT9455_REG_CTRL2_TE_SHIFT		3
+#define RT9455_REG_CTRL2_IAICR_INT_MASK		BIT(2)
+#define RT9455_REG_CTRL2_IAICR_INT_SHIFT	2
+#define RT9455_REG_CTRL2_HIZ_MASK		BIT(1)
+#define RT9455_REG_CTRL2_HIZ_SHIFT		1
+#define RT9455_REG_CTRL2_OPA_MODE_MASK		BIT(0)
+#define RT9455_REG_CTRL2_OPA_MODE_SHIFT		0
+
+#define RT9455_REG_CTRL3			0x02 /* Control3 */
+#define RT9455_REG_CTRL3_VOREG_MASK		(BIT(7) | BIT(6) | BIT(5) | \
+						 BIT(4) | BIT(3) | BIT(2))
+#define RT9455_REG_CTRL3_VOREG_SHIFT		2
+#define RT9455_REG_CTRL3_OTG_PL_MASK		BIT(1)
+#define RT9455_REG_CTRL3_OTG_PL_SHIFT		1
+#define RT9455_REG_CTRL3_OTG_EN_MASK		BIT(0)
+#define RT9455_REG_CTRL3_OTG_EN_SHIFT		0
+
+#define RT9455_REG_DEV_ID			0x03 /* Device ID */
+#define RT9455_REG_DEV_ID_VENDOR_ID_MASK	(BIT(7) | BIT(6) | BIT(5) | \
+						 BIT(4))
+#define RT9455_REG_DEV_ID_VENDOR_ID_SHIFT	4
+#define RT9455_REG_DEV_ID_CHIP_REV_MASK		(BIT(3) | BIT(2) | BIT(1) | \
+						 BIT(0))
+#define RT9455_REG_DEV_ID_CHIP_REV_SHIFT		0
+
+#define RT9455_REG_CTRL4			0x04 /* Control4 */
+#define RT9455_REG_CTRL4_RST_MASK		BIT(7)
+#define RT9455_REG_CTRL4_RST_SHIFT		7
+
+#define RT9455_REG_CTRL5			0x05 /* Control5 */
+#define RT9455_REG_CTRL5_TMR_EN_MASK		BIT(7)
+#define RT9455_REG_CTRL5_TMR_EN_SHIFT		7
+#define RT9455_REG_CTRL5_VMIVR_MASK		(BIT(5) | BIT(4))
+#define RT9455_REG_CTRL5_VMIVR_SHIFT		4
+#define RT9455_REG_CTRL5_IPREC_MASK		(BIT(3) | BIT(2))
+#define RT9455_REG_CTRL5_IPREC_SHIFT		2
+#define RT9455_REG_CTRL5_IEOC_PERCENTAGE_MASK	(BIT(1) | BIT(0))
+#define RT9455_REG_CTRL5_IEOC_PERCENTAGE_SHIFT	0
+
+#define RT9455_REG_CTRL6			0x06 /* Control6 */
+#define RT9455_REG_CTRL6_IAICR_SEL_MASK		BIT(7)
+#define RT9455_REG_CTRL6_IAICR_SEL_SHIFT	7
+#define RT9455_REG_CTRL6_ICHRG_MASK		(BIT(6) | BIT(5) | BIT(4))
+#define RT9455_REG_CTRL6_ICHRG_SHIFT		4
+#define RT9455_REG_CTRL6_VPREC_MASK		(BIT(2) | BIT(1) | BIT(0))
+#define RT9455_REG_CTRL6_VPREC_SHIFT		0
+
+#define RT9455_REG_CTRL7			0x07 /* Control7 */
+#define RT9455_REG_CTRL7_BATD_EN_MASK		BIT(6)
+#define RT9455_REG_CTRL7_BATD_EN_SHIFT		6
+#define RT9455_REG_CTRL7_CHG_EN_MASK		BIT(4)
+#define RT9455_REG_CTRL7_CHG_EN_SHIFT		4
+#define RT9455_REG_CTRL7_VMREG_MASK		(BIT(3) | BIT(2) | BIT(1) | \
+						 BIT(0))
+#define RT9455_REG_CTRL7_VMREG_SHIFT		0
+
+#define RT9455_REG_IRQ1				0x08 /* IRQ1 */
+#define RT9455_REG_IRQ1_TSDI_MASK		BIT(7)
+#define RT9455_REG_IRQ1_TSDI_SHIFT		7
+#define RT9455_REG_IRQ1_VINOVPI_MASK		BIT(6)
+#define RT9455_REG_IRQ1_VINOVPI_SHIFT		6
+#define RT9455_REG_IRQ1_BATAB_MASK		BIT(0)
+#define RT9455_REG_IRQ1_BATAB_SHIFT		0
+
+#define RT9455_REG_IRQ2				0x09 /* IRQ2 */
+#define RT9455_REG_IRQ2_CHRVPI_MASK		BIT(7)
+#define RT9455_REG_IRQ2_CHRVPI_SHIFT		7
+#define RT9455_REG_IRQ2_CHBATOVI_MASK		BIT(5)
+#define RT9455_REG_IRQ2_CHBATOVI_SHIFT		5
+#define RT9455_REG_IRQ2_CHTERMI_MASK		BIT(4)
+#define RT9455_REG_IRQ2_CHTERMI_SHIFT		4
+#define RT9455_REG_IRQ2_CHRCHGI_MASK		BIT(3)
+#define RT9455_REG_IRQ2_CHRCHGI_SHIFT		3
+#define RT9455_REG_IRQ2_CH32MI_MASK		BIT(2)
+#define RT9455_REG_IRQ2_CH32MI_SHIFT		2
+#define RT9455_REG_IRQ2_CHTREGI_MASK		BIT(1)
+#define RT9455_REG_IRQ2_CHTREGI_SHIFT		1
+#define RT9455_REG_IRQ2_CHMIVRI_MASK		BIT(0)
+#define RT9455_REG_IRQ2_CHMIVRI_SHIFT		0
+
+#define RT9455_REG_IRQ3				0x0A /* IRQ3 */
+#define RT9455_REG_IRQ3_BSTBUSOVI_MASK		BIT(7)
+#define RT9455_REG_IRQ3_BSTBUSOVI_SHIFT		7
+#define RT9455_REG_IRQ3_BSTOLI_MASK		BIT(6)
+#define RT9455_REG_IRQ3_BSTOLI_SHIFT		6
+#define RT9455_REG_IRQ3_BSTLOWVI_MASK		BIT(5)
+#define RT9455_REG_IRQ3_BSTLOWVI_SHIFT		5
+#define RT9455_REG_IRQ3_BST32SI_MASK		BIT(3)
+#define RT9455_REG_IRQ3_BST32SI_SHIFT		3
+
+#define RT9455_REG_MASK1			0x0B /* MASK1 */
+#define RT9455_REG_MASK1_TSDM_MASK		BIT(7)
+#define RT9455_REG_MASK1_TSDM_SHIFT		7
+#define RT9455_REG_MASK1_VINOVPIM_MASK		BIT(6)
+#define RT9455_REG_MASK1_VINOVPIM_SHIFT		6
+#define RT9455_REG_MASK1_BATABM_MASK		BIT(0)
+#define RT9455_REG_MASK1_BATABM_SHIFT		0
+
+#define RT9455_REG_MASK2			0x0C /* MASK2 */
+#define RT9455_REG_MASK2_CHRVPIM_MASK		BIT(7)
+#define RT9455_REG_MASK2_CHRVPIM_SHIFT		7
+#define RT9455_REG_MASK2_CHBATOVIM_MASK		BIT(5)
+#define RT9455_REG_MASK2_CHBATOVIM_SHIFT	5
+#define RT9455_REG_MASK2_CHTERMIM_MASK		BIT(4)
+#define RT9455_REG_MASK2_CHTERMIM_SHIFT		4
+#define RT9455_REG_MASK2_CHRCHGIM_MASK		BIT(3)
+#define RT9455_REG_MASK2_CHRCHGIM_SHIFT		3
+#define RT9455_REG_MASK2_CH32MIM_MASK		BIT(2)
+#define RT9455_REG_MASK2_CH32MIM_SHIFT		2
+#define RT9455_REG_MASK2_CHTREGIM_MASK		BIT(1)
+#define RT9455_REG_MASK2_CHTREGIM_SHIFT		1
+#define RT9455_REG_MASK2_CHMIVRIM_MASK		BIT(0)
+#define RT9455_REG_MASK2_CHMIVRIM_SHIFT		0
+
+#define RT9455_REG_MASK3			0x0D /* MASK3 */
+#define RT9455_REG_MASK3_BSTVINOVIM_MASK	BIT(7)
+#define RT9455_REG_MASK3_BSTVINOVIM_SHIFT	7
+#define RT9455_REG_MASK3_BSTOLIM_MASK		BIT(6)
+#define RT9455_REG_MASK3_BSTOLIM_SHIFT		6
+#define RT9455_REG_MASK3_BSTLOWVIM_MASK		BIT(5)
+#define RT9455_REG_MASK3_BSTLOWVIM_SHIFT	5
+#define RT9455_REG_MASK3_BST32SIM_MASK		BIT(3)
+#define RT9455_REG_MASK3_BST32SIM_SHIFT		3
+
+/*
+ * Each array initialised below shows the possible real-world values for a
+ * group of bits belonging to RT9455 registers. The arrays are sorted in
+ * ascending order. The index of each real-world value represents the value
+ * that is encoded in the group of bits belonging to RT9455 registers.
+ */
+/* REG06[6:4] (ICHRG) in uAh */
+static const int rt9455_ichrg_values[] = {
+	 500000,  650000,  800000,  950000, 1100000, 1250000, 1400000, 1550000
+};
+
+/* REG02[7:2] (VOREG) in uV */
+static const int rt9455_voreg_values[] = {
+	3500000, 3520000, 3540000, 3560000, 3580000, 3600000, 3620000, 3640000,
+	3660000, 3680000, 3700000, 3720000, 3740000, 3760000, 3780000, 3800000,
+	3820000, 3840000, 3860000, 3880000, 3900000, 3920000, 3940000, 3960000,
+	3980000, 4000000, 4020000, 4040000, 4060000, 4080000, 4100000, 4120000,
+	4140000, 4160000, 4180000, 4200000, 4220000, 4240000, 4260000, 4280000,
+	4300000, 4330000, 4350000, 4370000, 4390000, 4410000, 4430000, 4450000,
+	4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000,
+	4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000
+};
+
+/* REG07[3:0] (VMREG) in uV */
+static const int rt9455_vmreg_values[] = {
+	4200000, 4220000, 4240000, 4260000, 4280000, 4300000, 4320000, 4340000,
+	4360000, 4380000, 4400000, 4430000, 4450000, 4450000, 4450000, 4450000
+};
+
+/* REG05[5:4] (IEOC_PERCENTAGE) */
+static const int rt9455_ieoc_percentage_values[] = {
+	10, 30, 20, 30
+};
+
+/* REG05[1:0] (VMIVR) in uV */
+static const int rt9455_vmivr_values[] = {
+	4000000, 4250000, 4500000, 5000000
+};
+
+/* REG05[1:0] (IAICR) in uA */
+static const int rt9455_iaicr_values[] = {
+	100000, 500000, 1000000, 2000000
+};
+
+struct rt9455_info {
+	struct i2c_client		*client;
+	struct power_supply		*charger;
+#if IS_ENABLED(CONFIG_USB_PHY)
+	struct usb_phy			*usb_phy;
+	struct notifier_block		nb;
+#endif
+	struct gpio_desc		*gpiod_irq;
+	unsigned int			gpio_irq;
+	struct delayed_work		pwr_rdy_work;
+	struct delayed_work		max_charging_time_work;
+	struct delayed_work		batt_presence_work;
+};
+
+/* I2C read/write API */
+static int rt9455_read(struct rt9455_info *info, u8 reg, u8 *data)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(info->client, reg);
+	if (ret < 0)
+		return ret;
+
+	*data = ret;
+	return 0;
+}
+
+static int rt9455_write(struct rt9455_info *info, u8 reg, u8 data)
+{
+	return i2c_smbus_write_byte_data(info->client, reg, data);
+}
+
+static int rt9455_read_mask(struct rt9455_info *info, u8 reg,
+			    u8 mask, u8 shift, u8 *data)
+{
+	u8 v;
+	int ret;
+
+	ret = rt9455_read(info, reg, &v);
+	if (ret < 0)
+		return ret;
+
+	v &= mask;
+	v >>= shift;
+	*data = v;
+
+	return 0;
+}
+
+static int rt9455_write_mask(struct rt9455_info *info, u8 reg,
+			     u8 mask, u8 shift, u8 data)
+{
+	u8 v;
+	int ret;
+
+	ret = rt9455_read(info, reg, &v);
+	if (ret < 0)
+		return ret;
+
+	v &= ~mask;
+	v |= ((data << shift) & mask);
+
+	return rt9455_write(info, reg, v);
+}
+
+/*
+ * Iterate through each element of the 'tbl' array until an element whose value
+ * is greater than v is found. Return the index of the respective element,
+ * or the index of the last element in the array, if no such element is found.
+ */
+static u8 rt9455_find_idx(const int tbl[], int tbl_size, int v)
+{
+	int i;
+
+	/* No need to iterate until the last index in the table because
+	 * if no element greater than v is found in the table,
+	 * or if only the last element is greater than v,
+	 * function returns the index of the last element.
+	 */
+	for (i = 0; i < tbl_size - 1; i++)
+		if (v <= tbl[i])
+			return i;
+
+	return (tbl_size - 1);
+}
+
+static int rt9455_get_field_val(struct rt9455_info *info,
+				u8 reg, u8 mask, u8 shift,
+				const int tbl[], int tbl_size,
+				int *val)
+{
+	u8 v;
+	int ret;
+
+	ret = rt9455_read_mask(info, reg, mask, shift, &v);
+	if (ret)
+		return ret;
+
+	v = (v >= tbl_size) ? (tbl_size - 1) : v;
+	*val = tbl[v];
+
+	return 0;
+}
+
+static int rt9455_set_field_val(struct rt9455_info *info,
+				u8 reg, u8 mask, u8 shift,
+				const int tbl[], int tbl_size,
+				int val)
+{
+	u8 idx;
+
+	idx = rt9455_find_idx(tbl, tbl_size, val);
+
+	return rt9455_write_mask(info, reg, mask, shift, idx);
+}
+
+static int rt9455_register_reset(struct rt9455_info *info)
+{
+	struct device *dev = &info->client->dev;
+	int ret, limit = 100;
+	u8 v;
+
+	ret = rt9455_write_mask(info, RT9455_REG_CTRL4,
+				RT9455_REG_CTRL4_RST_MASK,
+				RT9455_REG_CTRL4_RST_SHIFT,
+				0x1);
+	if (ret) {
+		dev_err(dev, "Failed to set RST bit\n");
+		return ret;
+	}
+
+	/* To make sure that reset operation has finished, loop until RST bit
+	 * is set to 0.
+	 */
+	do {
+		ret = rt9455_read_mask(info, RT9455_REG_CTRL4,
+				       RT9455_REG_CTRL4_RST_MASK,
+				       RT9455_REG_CTRL4_RST_SHIFT,
+				       &v);
+		if (ret) {
+			dev_err(dev, "Failed to read RST bit\n");
+			return ret;
+		}
+
+		if (!v)
+			break;
+
+		usleep_range(10, 100);
+	} while (--limit);
+
+	if (!limit)
+		return -EIO;
+
+	return 0;
+}
+
+/* Charger power supply property routines */
+static enum power_supply_property rt9455_charger_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static char *rt9455_charger_supplied_to[] = {
+	"main-battery",
+};
+
+static int rt9455_charger_get_status(struct rt9455_info *info,
+				     union power_supply_propval *val)
+{
+	int ret;
+	u8 v;
+
+	ret = rt9455_read_mask(info, RT9455_REG_CTRL1,
+			       RT9455_REG_CTRL1_STAT_MASK,
+			       RT9455_REG_CTRL1_STAT_SHIFT,
+			       &v);
+	if (ret) {
+		dev_err(&info->client->dev, "Failed to read STAT bits\n");
+		return ret;
+	}
+
+	switch (v) {
+	case 0:
+		val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+	break;
+	case 1:
+		val->intval = POWER_SUPPLY_STATUS_CHARGING;
+	break;
+	case 2:
+		val->intval = POWER_SUPPLY_STATUS_FULL;
+	break;
+	default:
+		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+	break;
+	}
+
+	return 0;
+}
+
+static int rt9455_charger_get_health(struct rt9455_info *info,
+				     union power_supply_propval *val)
+{
+	struct device *dev = &info->client->dev;
+	int ret;
+	u8 v;
+
+	val->intval = POWER_SUPPLY_HEALTH_GOOD;
+
+	ret = rt9455_read_mask(info, RT9455_REG_CTRL1,
+			       RT9455_REG_CTRL1_STAT_MASK,
+			       RT9455_REG_CTRL1_STAT_SHIFT,
+			       &v);
+	if (ret) {
+		dev_err(dev, "Failed to read STAT bits\n");
+		return ret;
+	}
+
+	if (v == RT9455_FAULT) {
+		val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+		return 0;
+	}
+
+	ret = rt9455_read(info, RT9455_REG_IRQ1, &v);
+	if (ret) {
+		dev_err(dev, "Failed to read IRQ1 register\n");
+		return ret;
+	}
+
+	if (v & RT9455_REG_IRQ1_TSDI_MASK) {
+		val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
+		return 0;
+	}
+	if (v & RT9455_REG_IRQ1_VINOVPI_MASK) {
+		val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		return 0;
+	}
+	if (v & RT9455_REG_IRQ1_BATAB_MASK) {
+		val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+		return 0;
+	}
+
+	ret = rt9455_read(info, RT9455_REG_IRQ2, &v);
+	if (ret) {
+		dev_err(dev, "Failed to read IRQ2 register\n");
+		return ret;
+	}
+
+	if (v & RT9455_REG_IRQ2_CHBATOVI_MASK) {
+		val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+		return 0;
+	}
+	if (v & RT9455_REG_IRQ2_CH32MI_MASK) {
+		val->intval = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
+		return 0;
+	}
+
+	ret = rt9455_read(info, RT9455_REG_IRQ3, &v);
+	if (ret) {
+		dev_err(dev, "Failed to read IRQ3 register\n");
+		return ret;
+	}
+
+	if (v & RT9455_REG_IRQ3_BSTBUSOVI_MASK) {
+		val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+		return 0;
+	}
+	if (v & RT9455_REG_IRQ3_BSTOLI_MASK) {
+		val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		return 0;
+	}
+	if (v & RT9455_REG_IRQ3_BSTLOWVI_MASK) {
+		val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+		return 0;
+	}
+	if (v & RT9455_REG_IRQ3_BST32SI_MASK) {
+		val->intval = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt9455_charger_get_battery_presence(struct rt9455_info *info,
+					       union power_supply_propval *val)
+{
+	int ret;
+	u8 v;
+
+	ret = rt9455_read_mask(info, RT9455_REG_IRQ1,
+			       RT9455_REG_IRQ1_BATAB_MASK,
+			       RT9455_REG_IRQ1_BATAB_SHIFT,
+			       &v);
+	if (ret) {
+		dev_err(&info->client->dev, "Failed to read BATAB bit\n");
+		return ret;
+	}
+
+	/* Since BATAB is 1 when battery is NOT present and 0 otherwise,
+	 * we return !BATAB.
+	 */
+	val->intval = !v;
+
+	return 0;
+}
+
+static int rt9455_charger_get_online(struct rt9455_info *info,
+				     union power_supply_propval *val)
+{
+	int ret;
+	u8 v;
+
+	ret = rt9455_read_mask(info, RT9455_REG_CTRL1,
+			       RT9455_REG_CTRL1_PWR_RDY_MASK,
+			       RT9455_REG_CTRL1_PWR_RDY_SHIFT,
+			       &v);
+	if (ret) {
+		dev_err(&info->client->dev, "Failed to read PWR_RDY bit\n");
+		return ret;
+	}
+
+	val->intval = v;
+
+	return 0;
+}
+
+static int rt9455_charger_get_current(struct rt9455_info *info,
+				      union power_supply_propval *val)
+{
+	int ret, curr;
+
+	ret = rt9455_get_field_val(info, RT9455_REG_CTRL6,
+				   RT9455_REG_CTRL6_ICHRG_MASK,
+				   RT9455_REG_CTRL6_ICHRG_SHIFT,
+				   rt9455_ichrg_values,
+				   ARRAY_SIZE(rt9455_ichrg_values),
+				   &curr);
+	if (ret) {
+		dev_err(&info->client->dev, "Failed to read ICHRG value\n");
+		return ret;
+	}
+
+	val->intval = curr;
+
+	return 0;
+}
+
+static int rt9455_charger_get_current_max(struct rt9455_info *info,
+					  union power_supply_propval *val)
+{
+	int idx = ARRAY_SIZE(rt9455_ichrg_values) - 1;
+
+	val->intval = rt9455_ichrg_values[idx];
+
+	return 0;
+}
+
+static int rt9455_charger_get_voltage(struct rt9455_info *info,
+				      union power_supply_propval *val)
+{
+	int voltage, ret;
+
+	ret = rt9455_get_field_val(info, RT9455_REG_CTRL3,
+				   RT9455_REG_CTRL3_VOREG_MASK,
+				   RT9455_REG_CTRL3_VOREG_SHIFT,
+				   rt9455_voreg_values,
+				   ARRAY_SIZE(rt9455_voreg_values),
+				   &voltage);
+	if (ret) {
+		dev_err(&info->client->dev, "Failed to read VOREG value\n");
+		return ret;
+	}
+
+	val->intval = voltage;
+
+	return 0;
+}
+
+static int rt9455_charger_get_voltage_max(struct rt9455_info *info,
+					  union power_supply_propval *val)
+{
+	int voltage_max, ret;
+
+	ret = rt9455_get_field_val(info, RT9455_REG_CTRL7,
+				   RT9455_REG_CTRL7_VMREG_MASK,
+				   RT9455_REG_CTRL7_VMREG_SHIFT,
+				   rt9455_vmreg_values,
+				   ARRAY_SIZE(rt9455_vmreg_values),
+				   &voltage_max);
+	if (ret) {
+		dev_err(&info->client->dev, "Failed to read VMREG value\n");
+		return ret;
+	}
+
+	val->intval = voltage_max;
+
+	return 0;
+}
+
+static int rt9455_charger_get_term_current(struct rt9455_info *info,
+					   union power_supply_propval *val)
+{
+	struct device *dev = &info->client->dev;
+	int ichrg, ieoc_percentage, ret;
+
+	ret = rt9455_get_field_val(info, RT9455_REG_CTRL6,
+				   RT9455_REG_CTRL6_ICHRG_MASK,
+				   RT9455_REG_CTRL6_ICHRG_SHIFT,
+				   rt9455_ichrg_values,
+				   ARRAY_SIZE(rt9455_ichrg_values),
+				   &ichrg);
+	if (ret) {
+		dev_err(dev, "Failed to read ICHRG value\n");
+		return ret;
+	}
+
+	ret = rt9455_get_field_val(info, RT9455_REG_CTRL5,
+				   RT9455_REG_CTRL5_IEOC_PERCENTAGE_MASK,
+				   RT9455_REG_CTRL5_IEOC_PERCENTAGE_SHIFT,
+				   rt9455_ieoc_percentage_values,
+				   ARRAY_SIZE(rt9455_ieoc_percentage_values),
+				   &ieoc_percentage);
+	if (ret) {
+		dev_err(dev, "Failed to read IEOC value\n");
+		return ret;
+	}
+
+	val->intval = ichrg * ieoc_percentage / 100;
+
+	return 0;
+}
+
+static int rt9455_charger_get_property(struct power_supply *psy,
+				       enum power_supply_property psp,
+				       union power_supply_propval *val)
+{
+	struct rt9455_info *info = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		return rt9455_charger_get_status(info, val);
+	case POWER_SUPPLY_PROP_HEALTH:
+		return rt9455_charger_get_health(info, val);
+	case POWER_SUPPLY_PROP_PRESENT:
+		return rt9455_charger_get_battery_presence(info, val);
+	case POWER_SUPPLY_PROP_ONLINE:
+		return rt9455_charger_get_online(info, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		return rt9455_charger_get_current(info, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		return rt9455_charger_get_current_max(info, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		return rt9455_charger_get_voltage(info, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		return rt9455_charger_get_voltage_max(info, val);
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
+		return 0;
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		return rt9455_charger_get_term_current(info, val);
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = RT9455_MODEL_NAME;
+		return 0;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = RT9455_MANUFACTURER;
+		return 0;
+	default:
+		return -ENODATA;
+	}
+}
+
+static int rt9455_charger_set_current(struct rt9455_info *info,
+				      const union power_supply_propval *val)
+{
+	return rt9455_set_field_val(info, RT9455_REG_CTRL6,
+				    RT9455_REG_CTRL6_ICHRG_MASK,
+				    RT9455_REG_CTRL6_ICHRG_SHIFT,
+				    rt9455_ichrg_values,
+				    ARRAY_SIZE(rt9455_ichrg_values),
+				    val->intval);
+}
+
+static int rt9455_charger_set_voltage(struct rt9455_info *info,
+				      const union power_supply_propval *val)
+{
+	return rt9455_set_field_val(info, RT9455_REG_CTRL3,
+				    RT9455_REG_CTRL3_VOREG_MASK,
+				    RT9455_REG_CTRL3_VOREG_SHIFT,
+				    rt9455_voreg_values,
+				    ARRAY_SIZE(rt9455_voreg_values),
+				    val->intval);
+}
+
+static int rt9455_charger_set_voltage_max(struct rt9455_info *info,
+					  const union power_supply_propval *val)
+{
+	return rt9455_set_field_val(info, RT9455_REG_CTRL7,
+				    RT9455_REG_CTRL7_VMREG_MASK,
+				    RT9455_REG_CTRL7_VMREG_SHIFT,
+				    rt9455_voreg_values,
+				    ARRAY_SIZE(rt9455_voreg_values),
+				    val->intval);
+}
+
+static int rt9455_charger_set_property(struct power_supply *psy,
+				       enum power_supply_property psp,
+				       const union power_supply_propval *val)
+{
+	struct rt9455_info *info = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		return rt9455_charger_set_current(info, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		return rt9455_charger_set_voltage(info, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		return rt9455_charger_set_voltage_max(info, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rt9455_charger_property_is_writeable(struct power_supply *psy,
+						enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int rt9455_hw_init(struct rt9455_info *info, u32 ichrg,
+			  u32 ieoc_percentage, u32 voreg,
+			  u32 vmivr, u32 iaicr)
+{
+	struct device *dev = &info->client->dev;
+	int ret;
+
+	ret = rt9455_register_reset(info);
+	if (ret) {
+		dev_err(dev, "Power On Reset failed\n");
+		return ret;
+	}
+
+	/* Set TE bit in order to enable end of charge detection */
+	ret = rt9455_write_mask(info, RT9455_REG_CTRL2,
+				RT9455_REG_CTRL2_TE_MASK,
+				RT9455_REG_CTRL2_TE_SHIFT,
+				0x01);
+	if (ret) {
+		dev_err(dev, "Failed to set TE bit\n");
+		return ret;
+	}
+
+	/* Set TE_SHDN_EN bit in order to enable end of charge detection */
+	ret = rt9455_write_mask(info, RT9455_REG_CTRL2,
+				RT9455_REG_CTRL2_TE_SHDN_EN_MASK,
+				RT9455_REG_CTRL2_TE_SHDN_EN_SHIFT,
+				0x01);
+	if (ret) {
+		dev_err(dev, "Failed to set TE_SHDN_EN bit\n");
+		return ret;
+	}
+
+	/* Set BATD_EN bit in order to enable battery detection
+	 * when charging is done
+	 */
+	ret = rt9455_write_mask(info, RT9455_REG_CTRL7,
+				RT9455_REG_CTRL7_BATD_EN_MASK,
+				RT9455_REG_CTRL7_BATD_EN_SHIFT,
+				0x01);
+	if (ret) {
+		dev_err(dev, "Failed to set BATD_EN bit\n");
+		return ret;
+	}
+
+	/* Disable Safety Timer. In charge mode, this timer terminates charging
+	 * if no read or write via I2C is done within 32 minutes. This timer
+	 * avoids overcharging the baterry when the OS is not loaded and the
+	 * charger is connected to a power source.
+	 * In boost mode, this timer triggers BST32SI interrupt if no read or
+	 * write via I2C is done within 32 seconds.
+	 * When the OS is loaded and the charger driver is inserted, we use
+	 * delayed_work, named max_charging_time_work, to avoid overcharging
+	 * the battery.
+	 */
+	ret = rt9455_write_mask(info, RT9455_REG_CTRL5,
+				RT9455_REG_CTRL5_TMR_EN_MASK,
+				RT9455_REG_CTRL5_TMR_EN_SHIFT,
+				0x00);
+	if (ret) {
+		dev_err(dev, "Failed to disable Safety Timer\n");
+		return ret;
+	}
+
+	/* Set ICHRG to value retrieved from device-specific data */
+	ret = rt9455_set_field_val(info, RT9455_REG_CTRL6,
+				   RT9455_REG_CTRL6_ICHRG_MASK,
+				   RT9455_REG_CTRL6_ICHRG_SHIFT,
+				   rt9455_ichrg_values,
+				   ARRAY_SIZE(rt9455_ichrg_values), ichrg);
+	if (ret) {
+		dev_err(dev, "Failed to set ICHRG value\n");
+		return ret;
+	}
+
+	/* Set IEOC Percentage to value retrieved from device-specific data */
+	ret = rt9455_set_field_val(info, RT9455_REG_CTRL5,
+				   RT9455_REG_CTRL5_IEOC_PERCENTAGE_MASK,
+				   RT9455_REG_CTRL5_IEOC_PERCENTAGE_SHIFT,
+				   rt9455_ieoc_percentage_values,
+				   ARRAY_SIZE(rt9455_ieoc_percentage_values),
+				   ieoc_percentage);
+	if (ret) {
+		dev_err(dev, "Failed to set IEOC Percentage value\n");
+		return ret;
+	}
+
+	/* Set VOREG to value retrieved from device-specific data */
+	ret = rt9455_set_field_val(info, RT9455_REG_CTRL3,
+				   RT9455_REG_CTRL3_VOREG_MASK,
+				   RT9455_REG_CTRL3_VOREG_SHIFT,
+				   rt9455_voreg_values,
+				   ARRAY_SIZE(rt9455_voreg_values), voreg);
+	if (ret) {
+		dev_err(dev, "Failed to set VOREG value\n");
+		return ret;
+	}
+
+	/* Set VMIVR to value retrieved from device-specific data.
+	 * If no value is specified, default value for VMIVR is 4.5V.
+	 */
+	if (vmivr == -1)
+		vmivr = 4500000;
+
+	ret = rt9455_set_field_val(info, RT9455_REG_CTRL5,
+				   RT9455_REG_CTRL5_VMIVR_MASK,
+				   RT9455_REG_CTRL5_VMIVR_SHIFT,
+				   rt9455_vmivr_values,
+				   ARRAY_SIZE(rt9455_vmivr_values), vmivr);
+	if (ret) {
+		dev_err(dev, "Failed to set VMIVR value\n");
+		return ret;
+	}
+
+	/* Set IAICR to value retrieved from device-specific data.
+	 * If no value is specified, default value for IAICR is 500 mA.
+	 */
+	if (iaicr == -1)
+		iaicr = 500000;
+
+	ret = rt9455_set_field_val(info, RT9455_REG_CTRL2,
+				   RT9455_REG_CTRL2_IAICR_MASK,
+				   RT9455_REG_CTRL2_IAICR_SHIFT,
+				   rt9455_iaicr_values,
+				   ARRAY_SIZE(rt9455_iaicr_values), iaicr);
+	if (ret) {
+		dev_err(dev, "Failed to set IAICR value\n");
+		return ret;
+	}
+
+	ret = rt9455_write_mask(info, RT9455_REG_CTRL2,
+				RT9455_REG_CTRL2_IAICR_INT_MASK,
+				RT9455_REG_CTRL2_IAICR_INT_SHIFT,
+				0x01);
+	if (ret) {
+		dev_err(dev, "Failed to set IAICR_INT bit\n");
+		return ret;
+	}
+
+	ret = rt9455_write_mask(info, RT9455_REG_MASK2,
+				RT9455_REG_MASK2_CHMIVRIM_MASK,
+				RT9455_REG_MASK2_CHMIVRIM_SHIFT,
+				0x01);
+	if (ret) {
+		dev_err(dev, "Failed to mask CHMIVRI interrupt\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rt9455_irq_handler_check_irq1_register(struct rt9455_info *info,
+						  bool *_is_battery_absent,
+						  bool *_alert_userspace)
+{
+	u8 irq1, mask1, mask2;
+	struct device *dev = &info->client->dev;
+	bool is_battery_absent = false;
+	bool alert_userspace = false;
+	int ret;
+
+	ret = rt9455_read(info, RT9455_REG_IRQ1, &irq1);
+	if (ret) {
+		dev_err(dev, "Failed to read IRQ1 register\n");
+		return ret;
+	}
+
+	ret = rt9455_read(info, RT9455_REG_MASK1, &mask1);
+	if (ret) {
+		dev_err(dev, "Failed to read MASK1 register\n");
+		return ret;
+	}
+
+	if (irq1 & RT9455_REG_IRQ1_TSDI_MASK) {
+		dev_err(dev, "Thermal shutdown fault occurred\n");
+		alert_userspace = true;
+	}
+
+	if (irq1 & RT9455_REG_IRQ1_VINOVPI_MASK) {
+		dev_err(dev, "Overvoltage input occurred\n");
+		alert_userspace = true;
+	}
+
+	if (irq1 & RT9455_REG_IRQ1_BATAB_MASK) {
+		dev_err(dev, "Battery absence occurred\n");
+		is_battery_absent = true;
+		alert_userspace = true;
+
+		if ((mask1 & RT9455_REG_MASK1_BATABM_MASK) == 0) {
+			ret = rt9455_write_mask(info, RT9455_REG_MASK1,
+						RT9455_REG_MASK1_BATABM_MASK,
+						RT9455_REG_MASK1_BATABM_SHIFT,
+						0x01);
+			if (ret) {
+				dev_err(dev, "Failed to mask BATAB interrupt\n");
+				return ret;
+			}
+		}
+
+		ret = rt9455_read(info, RT9455_REG_MASK2, &mask2);
+		if (ret) {
+			dev_err(dev, "Failed to read MASK2 register\n");
+			return ret;
+		}
+
+		if ((mask2 & RT9455_REG_MASK2_CHTERMIM_MASK)) {
+			ret = rt9455_write_mask(info, RT9455_REG_MASK2,
+						RT9455_REG_MASK2_CHTERMIM_MASK,
+						RT9455_REG_MASK2_CHTERMIM_SHIFT,
+						0x00);
+			if (ret) {
+				dev_err(dev, "Failed to unmask CHTERMI interrupt\n");
+				return ret;
+			}
+		}
+
+		if ((mask2 & RT9455_REG_MASK2_CHRCHGIM_MASK)) {
+			ret = rt9455_write_mask(info, RT9455_REG_MASK2,
+						RT9455_REG_MASK2_CHRCHGIM_MASK,
+						RT9455_REG_MASK2_CHRCHGIM_SHIFT,
+						0x00);
+			if (ret) {
+				dev_err(dev, "Failed to unmask CHRCHGI interrupt\n");
+				return ret;
+			}
+		}
+
+		/* When the battery is absent, max_charging_time_work is
+		 * cancelled, since no charging is done.
+		 */
+		cancel_delayed_work_sync(&info->max_charging_time_work);
+		/* Since no interrupt is triggered when the battery is
+		 * reconnected, max_charging_time_work is not rescheduled.
+		 * Therefore, batt_presence_work is scheduled to check whether
+		 * the battery is still absent or not.
+		 */
+		schedule_delayed_work(&info->batt_presence_work,
+				      RT9455_BATT_PRESENCE_DELAY * HZ);
+	}
+
+	*_is_battery_absent = is_battery_absent;
+
+	if (alert_userspace)
+		*_alert_userspace = alert_userspace;
+
+	return 0;
+}
+
+static int rt9455_irq_handler_check_irq2_register(struct rt9455_info *info,
+						  bool is_battery_absent,
+						  bool *_alert_userspace)
+{
+	u8 irq2, mask2;
+	struct device *dev = &info->client->dev;
+	bool alert_userspace = false;
+	int ret;
+
+	ret = rt9455_read(info, RT9455_REG_IRQ2, &irq2);
+	if (ret) {
+		dev_err(dev, "Failed to read IRQ2 register\n");
+		return ret;
+	}
+
+	ret = rt9455_read(info, RT9455_REG_MASK2, &mask2);
+	if (ret) {
+		dev_err(dev, "Failed to read MASK2 register\n");
+		return ret;
+	}
+
+	if (irq2 & RT9455_REG_IRQ2_CHRVPI_MASK) {
+		dev_dbg(dev, "Charger fault occurred\n");
+		alert_userspace = true;
+		/* CHRVPI bit is set in 2 cases:
+		 * 1. when the power source is connected to the charger.
+		 * 2. when the power source is disconnected from the charger.
+		 * To identify the case, PWR_RDY bit is checked. Because
+		 * PWR_RDY bit is set / cleared after CHRVPI interrupt is
+		 * triggered, we use delayed_work to later read PWR_RDY bit.
+		 */
+		schedule_delayed_work(&info->pwr_rdy_work,
+				      RT9455_PWR_RDY_DELAY * HZ);
+	}
+	if (irq2 & RT9455_REG_IRQ2_CHBATOVI_MASK) {
+		dev_err(dev, "Battery OVP occurred\n");
+		alert_userspace = true;
+	}
+	if (irq2 & RT9455_REG_IRQ2_CHTERMI_MASK) {
+		dev_dbg(dev, "Charge terminated\n");
+		alert_userspace = true;
+
+		if (!is_battery_absent) {
+			if ((mask2 & RT9455_REG_MASK2_CHTERMIM_MASK) == 0) {
+				ret = rt9455_write_mask(info, RT9455_REG_MASK2,
+						RT9455_REG_MASK2_CHTERMIM_MASK,
+						RT9455_REG_MASK2_CHTERMIM_SHIFT,
+						0x01);
+				if (ret) {
+					dev_err(dev, "Failed to mask CHTERMI interrupt\n");
+					return ret;
+				}
+			}
+			cancel_delayed_work_sync(&info->max_charging_time_work);
+		}
+	}
+	if (irq2 & RT9455_REG_IRQ2_CHRCHGI_MASK) {
+		dev_dbg(dev, "Recharge request\n");
+		ret = rt9455_write_mask(info, RT9455_REG_CTRL7,
+					RT9455_REG_CTRL7_CHG_EN_MASK,
+					RT9455_REG_CTRL7_CHG_EN_SHIFT,
+					0x01);
+		if (ret) {
+			dev_err(dev, "Failed to enable charging\n");
+			return ret;
+		}
+		if (mask2 & RT9455_REG_MASK2_CHTERMIM_MASK) {
+			ret = rt9455_write_mask(info, RT9455_REG_MASK2,
+						RT9455_REG_MASK2_CHTERMIM_MASK,
+						RT9455_REG_MASK2_CHTERMIM_SHIFT,
+						0x00);
+			if (ret) {
+				dev_err(dev, "Failed to unmask CHTERMI interrupt\n");
+				return ret;
+			}
+		}
+		if (!is_battery_absent) {
+			schedule_delayed_work(&info->max_charging_time_work,
+					      RT9455_MAX_CHARGING_TIME * HZ);
+			alert_userspace = true;
+		}
+	}
+	if (irq2 & RT9455_REG_IRQ2_CH32MI_MASK) {
+		dev_err(dev, "Charger fault. 32 mins timeout occurred\n");
+		alert_userspace = true;
+	}
+	if (irq2 & RT9455_REG_IRQ2_CHTREGI_MASK) {
+		dev_warn(dev,
+			 "Charger warning. Thermal regulation loop active\n");
+		alert_userspace = true;
+	}
+	if (irq2 & RT9455_REG_IRQ2_CHMIVRI_MASK) {
+		dev_dbg(dev,
+			"Charger warning. Input voltage MIVR loop active\n");
+	}
+
+	if (alert_userspace)
+		*_alert_userspace = alert_userspace;
+
+	return 0;
+}
+
+static int rt9455_irq_handler_check_irq3_register(struct rt9455_info *info,
+						  bool *_alert_userspace)
+{
+	u8 irq3, mask3;
+	struct device *dev = &info->client->dev;
+	bool alert_userspace = false;
+	int ret;
+
+	ret = rt9455_read(info, RT9455_REG_IRQ3, &irq3);
+	if (ret) {
+		dev_err(dev, "Failed to read IRQ3 register\n");
+		return ret;
+	}
+
+	ret = rt9455_read(info, RT9455_REG_MASK3, &mask3);
+	if (ret) {
+		dev_err(dev, "Failed to read MASK3 register\n");
+		return ret;
+	}
+
+	if (irq3 & RT9455_REG_IRQ3_BSTBUSOVI_MASK) {
+		dev_err(dev, "Boost fault. Overvoltage input occurred\n");
+		alert_userspace = true;
+	}
+	if (irq3 & RT9455_REG_IRQ3_BSTOLI_MASK) {
+		dev_err(dev, "Boost fault. Overload\n");
+		alert_userspace = true;
+	}
+	if (irq3 & RT9455_REG_IRQ3_BSTLOWVI_MASK) {
+		dev_err(dev, "Boost fault. Battery voltage too low\n");
+		alert_userspace = true;
+	}
+	if (irq3 & RT9455_REG_IRQ3_BST32SI_MASK) {
+		dev_err(dev, "Boost fault. 32 seconds timeout occurred.\n");
+		alert_userspace = true;
+	}
+
+	if (alert_userspace) {
+		dev_dbg(dev, "Boost fault occurred, therefore the charger goes into charge mode\n");
+		ret = rt9455_write_mask(info, RT9455_REG_CTRL2,
+					RT9455_REG_CTRL2_OPA_MODE_MASK,
+					RT9455_REG_CTRL2_OPA_MODE_SHIFT,
+					RT9455_CHARGE_MODE);
+		if (ret) {
+			dev_err(dev, "Failed to set charger in charge mode\n");
+			return ret;
+		}
+		*_alert_userspace = alert_userspace;
+	}
+
+	return 0;
+}
+
+static irqreturn_t rt9455_irq_handler_thread(int irq, void *data)
+{
+	struct rt9455_info *info = data;
+	struct device *dev = &info->client->dev;
+	bool alert_userspace = false;
+	bool is_battery_absent = false;
+	u8 status;
+	int ret;
+
+	ret = rt9455_read_mask(info, RT9455_REG_CTRL1,
+			       RT9455_REG_CTRL1_STAT_MASK,
+			       RT9455_REG_CTRL1_STAT_SHIFT,
+			       &status);
+	if (ret) {
+		dev_err(dev, "Failed to read STAT bits\n");
+		return IRQ_HANDLED;
+	}
+	dev_dbg(dev, "Charger status is %d\n", status);
+
+	/* Each function that processes an IRQ register receives as output
+	 * parameter alert_userspace pointer. alert_userspace is set to true
+	 * in such a function only if an interrupt has occurred in the
+	 * respective interrupt register. This way, we avoid the following
+	 * case: interrupt occurs only in IRQ1 register,
+	 * rt9455_irq_handler_check_irq1_register() function sets to true
+	 * alert_userspace, but rt9455_irq_handler_check_irq2_register()
+	 * and rt9455_irq_handler_check_irq3_register() functions set to false
+	 * alert_userspace and power_supply_changed() is never called.
+	 */
+	ret = rt9455_irq_handler_check_irq1_register(info, &is_battery_absent,
+						     &alert_userspace);
+	if (ret) {
+		dev_err(dev, "Failed to handle IRQ1 register\n");
+		return IRQ_HANDLED;
+	}
+
+	ret = rt9455_irq_handler_check_irq2_register(info, is_battery_absent,
+						     &alert_userspace);
+	if (ret) {
+		dev_err(dev, "Failed to handle IRQ2 register\n");
+		return IRQ_HANDLED;
+	}
+
+	ret = rt9455_irq_handler_check_irq3_register(info, &alert_userspace);
+	if (ret) {
+		dev_err(dev, "Failed to handle IRQ3 register\n");
+		return IRQ_HANDLED;
+	}
+
+	if (alert_userspace) {
+		/* Sometimes, an interrupt occurs while probe() function is
+		 * executing and power_supply_register() is not yet called.
+		 * Do not call power_supply_charged() in this case.
+		 */
+		if (!IS_ERR_OR_NULL(info->charger))
+			power_supply_changed(info->charger);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int rt9455_setup_irq(struct rt9455_info *info)
+{
+	struct device *dev = &info->client->dev;
+	int ret;
+
+	/* Obtain IRQ GPIO */
+	info->gpiod_irq = devm_gpiod_get_index(dev, RT9455_IRQ_NAME, 0);
+	if (IS_ERR(info->gpiod_irq)) {
+		dev_err(dev, "Failed to get IRQ GPIO\n");
+		return PTR_ERR(info->gpiod_irq);
+	}
+
+	/* Configure IRQ GPIO */
+	ret = gpiod_direction_input(info->gpiod_irq);
+	if (ret) {
+		dev_err(dev, "Failed to set IRQ GPIO direction err = %d\n",
+			ret);
+		return ret;
+	}
+
+	/* Map the pin to an IRQ */
+	ret = gpiod_to_irq(info->gpiod_irq);
+	if (ret < 0) {
+		dev_err(dev, "Failed to associate GPIO with an IRQ err = %d\n",
+			ret);
+		return ret;
+	}
+
+	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n",
+		desc_to_gpio(info->gpiod_irq), ret);
+	info->client->irq = ret;
+	info->gpio_irq = desc_to_gpio(info->gpiod_irq);
+
+	return 0;
+}
+
+static int rt9455_discover_charger(struct rt9455_info *info, u32 *ichrg,
+				   u32 *ieoc_percentage, u32 *voreg,
+				   u32 *vmivr, u32 *iaicr)
+{
+	struct device *dev = &info->client->dev;
+	int ret;
+
+	if (!dev->of_node && !ACPI_HANDLE(dev)) {
+		dev_err(dev, "No support for either device tree or ACPI\n");
+		return -EINVAL;
+	}
+	/* ICHRG, IEOC_PERCENTAGE and VOREG are mandatory parameters. */
+	ret = device_property_read_u32(dev, "rt,ICHRG", ichrg);
+	if (ret) {
+		dev_err(dev, "Error: missing \"ICHRG\" property\n");
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "rt,IEOC_PERCENTAGE",
+				       ieoc_percentage);
+	if (ret) {
+		dev_err(dev, "Error: missing \"IEOC_PERCENTAGE\" property\n");
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "rt,VOREG", voreg);
+	if (ret) {
+		dev_err(dev, "Error: missing \"VOREG\" property\n");
+		return ret;
+	}
+
+	/* MIVR and IAICR are optional parameters. Do not return error if one
+	 * of them is not present in ACPI table or device tree specification,
+	 */
+	device_property_read_u32(dev, "rt,VMIVR", vmivr);
+	device_property_read_u32(dev, "rt,IAICR", iaicr);
+
+	ret = rt9455_setup_irq(info);
+	if (ret) {
+		dev_err(dev, "Failed to allocate IRQ resource\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rt9455_usb_event_none(struct rt9455_info *info,
+				 u8 opa_mode, u8 iaicr)
+{
+	struct device *dev = &info->client->dev;
+	int ret;
+
+	if (opa_mode == RT9455_BOOST_MODE) {
+		/* If the charger is in boost mode, and it has received
+		 * USB_EVENT_NONE, this means the device powered by the
+		 * charger is not connected anymore.
+		 * In this case, the charger goes into charge mode.
+		 */
+		dev_dbg(dev, "USB_EVENT_NONE received, therefore the charger goes into charge mode\n");
+		ret = rt9455_write_mask(info, RT9455_REG_CTRL2,
+					RT9455_REG_CTRL2_OPA_MODE_MASK,
+					RT9455_REG_CTRL2_OPA_MODE_SHIFT,
+					RT9455_CHARGE_MODE);
+		if (ret) {
+			dev_err(dev, "Failed to set charger in charge mode\n");
+			return NOTIFY_DONE;
+		}
+	}
+
+	dev_dbg(dev, "USB_EVENT_NONE received, therefore IAICR is set to its minimum value\n");
+	if (iaicr != RT9455_IAICR_100MA) {
+		ret = rt9455_write_mask(info, RT9455_REG_CTRL2,
+					RT9455_REG_CTRL2_IAICR_MASK,
+					RT9455_REG_CTRL2_IAICR_SHIFT,
+					RT9455_IAICR_100MA);
+		if (ret) {
+			dev_err(dev, "Failed to set IAICR value\n");
+			return NOTIFY_DONE;
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static int rt9455_usb_event_vbus(struct rt9455_info *info,
+				 u8 opa_mode, u8 iaicr)
+{
+	struct device *dev = &info->client->dev;
+	int ret;
+
+	if (opa_mode == RT9455_BOOST_MODE) {
+		/* If the charger is in boost mode, and it has received
+		 * USB_EVENT_VBUS, this means the device powered by the
+		 * charger is not connected anymore.
+		 * In this case, the charger goes into charge mode.
+		 */
+		dev_dbg(dev, "USB_EVENT_VBUS received, therefore the charger goes into charge mode\n");
+		ret = rt9455_write_mask(info, RT9455_REG_CTRL2,
+					RT9455_REG_CTRL2_OPA_MODE_MASK,
+					RT9455_REG_CTRL2_OPA_MODE_SHIFT,
+					RT9455_CHARGE_MODE);
+		if (ret) {
+			dev_err(dev, "Failed to set charger in charge mode\n");
+			return NOTIFY_DONE;
+		}
+	}
+
+	dev_dbg(dev, "USB_EVENT_VBUS received, therefore IAICR is set to 500 mA\n");
+	if (iaicr != RT9455_IAICR_500MA) {
+		ret = rt9455_write_mask(info, RT9455_REG_CTRL2,
+					RT9455_REG_CTRL2_IAICR_MASK,
+					RT9455_REG_CTRL2_IAICR_SHIFT,
+					RT9455_IAICR_500MA);
+		if (ret) {
+			dev_err(dev, "Failed to set IAICR value\n");
+			return NOTIFY_DONE;
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static int rt9455_usb_event_id(struct rt9455_info *info,
+			       u8 opa_mode, u8 iaicr)
+{
+	struct device *dev = &info->client->dev;
+	int ret;
+
+	if (opa_mode == RT9455_CHARGE_MODE) {
+		/* If the charger is in charge mode, and it has received
+		 * USB_EVENT_ID, this means the device powered by the
+		 * charger is not connected anymore.
+		 * In this case, the charger goes into charge mode.
+		 */
+		dev_dbg(dev, "USB_EVENT_ID received, therefore the charger goes into boost mode\n");
+		ret = rt9455_write_mask(info, RT9455_REG_CTRL2,
+					RT9455_REG_CTRL2_OPA_MODE_MASK,
+					RT9455_REG_CTRL2_OPA_MODE_SHIFT,
+					RT9455_BOOST_MODE);
+		if (ret) {
+			dev_err(dev, "Failed to set charger in boost mode\n");
+			return NOTIFY_DONE;
+		}
+	}
+
+	dev_dbg(dev, "USB_EVENT_ID received, therefore IAICR is set to its minimum value\n");
+	if (iaicr != RT9455_IAICR_100MA) {
+		ret = rt9455_write_mask(info, RT9455_REG_CTRL2,
+					RT9455_REG_CTRL2_IAICR_MASK,
+					RT9455_REG_CTRL2_IAICR_SHIFT,
+					RT9455_IAICR_100MA);
+		if (ret) {
+			dev_err(dev, "Failed to set IAICR value\n");
+			return NOTIFY_DONE;
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static int rt9455_usb_event_charger(struct rt9455_info *info,
+				    u8 opa_mode, u8 iaicr)
+{
+	struct device *dev = &info->client->dev;
+	int ret;
+
+	if (opa_mode == RT9455_BOOST_MODE) {
+		/* If the charger is in boost mode, and it has received
+		 * USB_EVENT_CHARGER, this means the device powered by the
+		 * charger is not connected anymore.
+		 * In this case, the charger goes into charge mode.
+		 */
+		dev_dbg(dev, "USB_EVENT_CHARGER received, therefore the charger goes into charge mode\n");
+		ret = rt9455_write_mask(info, RT9455_REG_CTRL2,
+					RT9455_REG_CTRL2_OPA_MODE_MASK,
+					RT9455_REG_CTRL2_OPA_MODE_SHIFT,
+					RT9455_CHARGE_MODE);
+		if (ret) {
+			dev_err(dev, "Failed to set charger in charge mode\n");
+			return NOTIFY_DONE;
+		}
+	}
+
+	dev_dbg(dev, "USB_EVENT_CHARGER received, therefore IAICR is set to no current limit\n");
+	if (iaicr != RT9455_IAICR_NO_LIMIT) {
+		ret = rt9455_write_mask(info, RT9455_REG_CTRL2,
+					RT9455_REG_CTRL2_IAICR_MASK,
+					RT9455_REG_CTRL2_IAICR_SHIFT,
+					RT9455_IAICR_NO_LIMIT);
+		if (ret) {
+			dev_err(dev, "Failed to set IAICR value\n");
+			return NOTIFY_DONE;
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static int rt9455_usb_event(struct notifier_block *nb,
+			    unsigned long event, void *power)
+{
+	struct rt9455_info *info = container_of(nb, struct rt9455_info, nb);
+	struct device *dev = &info->client->dev;
+	u8 opa_mode, iaicr;
+	int ret;
+
+	if (!info)
+		return NOTIFY_DONE;
+
+	/* Determine whether the charger is in charge mode
+	 * or in boost mode.
+	 */
+	ret = rt9455_read_mask(info, RT9455_REG_CTRL2,
+			       RT9455_REG_CTRL2_OPA_MODE_MASK,
+			       RT9455_REG_CTRL2_OPA_MODE_SHIFT,
+			       &opa_mode);
+	if (ret) {
+		dev_err(dev, "Failed to read operation mode value\n");
+		return NOTIFY_DONE;
+	}
+
+	ret = rt9455_read_mask(info, RT9455_REG_CTRL2,
+			       RT9455_REG_CTRL2_IAICR_MASK,
+			       RT9455_REG_CTRL2_IAICR_SHIFT,
+			       &iaicr);
+	if (ret) {
+		dev_err(dev, "Failed to read IAICR value\n");
+		return NOTIFY_DONE;
+	}
+
+	dev_dbg(dev, "Received USB event %lu\n", event);
+	switch (event) {
+	case USB_EVENT_NONE:
+		return rt9455_usb_event_none(info, opa_mode, iaicr);
+	case USB_EVENT_VBUS:
+		return rt9455_usb_event_vbus(info, opa_mode, iaicr);
+	case USB_EVENT_ID:
+		return rt9455_usb_event_id(info, opa_mode, iaicr);
+	case USB_EVENT_CHARGER:
+		return rt9455_usb_event_charger(info, opa_mode, iaicr);
+	default:
+		dev_err(dev, "Unknown USB event\n");
+	}
+	return NOTIFY_DONE;
+}
+
+static void rt9455_pwr_rdy_work_callback(struct work_struct *work)
+{
+	struct rt9455_info *info = container_of(work, struct rt9455_info,
+						pwr_rdy_work.work);
+	struct device *dev = &info->client->dev;
+	u8 pwr_rdy;
+	int ret;
+
+	ret = rt9455_read_mask(info, RT9455_REG_CTRL1,
+			       RT9455_REG_CTRL1_PWR_RDY_MASK,
+			       RT9455_REG_CTRL1_PWR_RDY_SHIFT,
+			       &pwr_rdy);
+	if (ret) {
+		dev_err(dev, "Failed to read Power Ready bit\n");
+		return;
+	}
+	switch (pwr_rdy) {
+	case RT9455_PWR_FAULT:
+		dev_dbg(dev, "Charger disconnected from power source\n");
+		cancel_delayed_work_sync(&info->max_charging_time_work);
+		break;
+	case RT9455_PWR_GOOD:
+		dev_dbg(dev, "Charger connected to power source\n");
+		ret = rt9455_write_mask(info, RT9455_REG_CTRL7,
+					RT9455_REG_CTRL7_CHG_EN_MASK,
+					RT9455_REG_CTRL7_CHG_EN_SHIFT,
+					RT9455_CHARGE_ENABLE);
+		if (ret) {
+			dev_err(dev, "Failed to enable charging\n");
+			return;
+		}
+		schedule_delayed_work(&info->max_charging_time_work,
+				      RT9455_MAX_CHARGING_TIME * HZ);
+		break;
+	}
+}
+
+static void rt9455_max_charging_time_work_callback(struct work_struct *work)
+{
+	struct rt9455_info *info = container_of(work, struct rt9455_info,
+						max_charging_time_work.work);
+	struct device *dev = &info->client->dev;
+	int ret;
+
+	dev_err(dev, "Battery has been charging for at least 6 hours and is not yet fully charged. Battery is dead, therefore charging is disabled.\n");
+	ret = rt9455_write_mask(info, RT9455_REG_CTRL7,
+				RT9455_REG_CTRL7_CHG_EN_MASK,
+				RT9455_REG_CTRL7_CHG_EN_SHIFT,
+				RT9455_CHARGE_DISABLE);
+	if (ret)
+		dev_err(dev, "Failed to disable charging\n");
+}
+
+static void rt9455_batt_presence_work_callback(struct work_struct *work)
+{
+	struct rt9455_info *info = container_of(work, struct rt9455_info,
+						batt_presence_work.work);
+	struct device *dev = &info->client->dev;
+	u8 irq1;
+	int ret;
+
+	ret = rt9455_read(info, RT9455_REG_IRQ1, &irq1);
+	if (ret) {
+		dev_err(dev, "Failed to read IRQ1 register\n");
+		return;
+	}
+
+	/* If the battery is still absent, batt_presence_work is rescheduled.
+	   Otherwise, max_charging_time is scheduled.
+	 */
+	if (irq1 & RT9455_REG_IRQ1_BATAB_MASK) {
+		schedule_delayed_work(&info->batt_presence_work,
+				      RT9455_BATT_PRESENCE_DELAY * HZ);
+	} else {
+		schedule_delayed_work(&info->max_charging_time_work,
+				      RT9455_MAX_CHARGING_TIME * HZ);
+	}
+}
+
+struct power_supply_desc rt9455_charger_desc = {
+	.name			= RT9455_DRIVER_NAME,
+	.type			= POWER_SUPPLY_TYPE_USB,
+	.properties		= rt9455_charger_properties,
+	.num_properties		= ARRAY_SIZE(rt9455_charger_properties),
+	.get_property		= rt9455_charger_get_property,
+	.set_property		= rt9455_charger_set_property,
+	.property_is_writeable	= rt9455_charger_property_is_writeable,
+};
+
+static int rt9455_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct device *dev = &client->dev;
+	struct rt9455_info *info;
+	struct power_supply_config rt9455_charger_config = {};
+	/* mandatory device-specific data values */
+	u32 ichrg, ieoc_percentage, voreg;
+	/* optional device-specific data values */
+	u32 vmivr = -1, iaicr = -1;
+	int ret;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+		dev_err(dev, "No support for SMBUS_BYTE_DATA\n");
+		return -ENODEV;
+	}
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->client = client;
+	i2c_set_clientdata(client, info);
+
+	ret = rt9455_discover_charger(info, &ichrg, &ieoc_percentage,
+				      &voreg, &vmivr, &iaicr);
+	if (ret) {
+		dev_err(dev, "Failed to discover charger\n");
+		return ret;
+	}
+
+#if IS_ENABLED(CONFIG_USB_PHY)
+	info->usb_phy = usb_get_phy(USB_PHY_TYPE_USB2);
+	if (IS_ERR_OR_NULL(info->usb_phy)) {
+		dev_err(dev, "Failed to get USB transceiver\n");
+	} else {
+		info->nb.notifier_call = rt9455_usb_event;
+		ret = usb_register_notifier(info->usb_phy, &info->nb);
+		if (ret) {
+			dev_err(dev, "Failed to register USB notifier\n");
+			usb_put_phy(info->usb_phy);
+		}
+	}
+#endif
+
+	INIT_DELAYED_WORK(&info->pwr_rdy_work, rt9455_pwr_rdy_work_callback);
+	INIT_DELAYED_WORK(&info->max_charging_time_work,
+			  rt9455_max_charging_time_work_callback);
+	INIT_DELAYED_WORK(&info->batt_presence_work,
+			  rt9455_batt_presence_work_callback);
+
+	rt9455_charger_config.of_node		= dev->of_node;
+	rt9455_charger_config.drv_data		= info;
+	rt9455_charger_config.supplied_to	= rt9455_charger_supplied_to;
+	rt9455_charger_config.num_supplicants	=
+					ARRAY_SIZE(rt9455_charger_supplied_to);
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
+					rt9455_irq_handler_thread,
+					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					RT9455_DRIVER_NAME, info);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register IRQ handler\n");
+		return ret;
+	}
+
+	ret = rt9455_hw_init(info, ichrg, ieoc_percentage, voreg, vmivr, iaicr);
+	if (ret) {
+		dev_err(dev, "Failed to set charger to its default values\n");
+		return ret;
+	}
+
+	info->charger = power_supply_register(dev, &rt9455_charger_desc,
+					      &rt9455_charger_config);
+	if (IS_ERR_OR_NULL(info->charger)) {
+		dev_err(dev, "Failed to register charger\n");
+		ret = PTR_ERR(info->charger);
+		goto put_usb_phy;
+	}
+
+	return 0;
+
+put_usb_phy:
+#if IS_ENABLED(CONFIG_USB_PHY)
+	if (!IS_ERR_OR_NULL(info->usb_phy))  {
+		usb_unregister_notifier(info->usb_phy, &info->nb);
+		usb_put_phy(info->usb_phy);
+	}
+#endif
+	return ret;
+}
+
+static int rt9455_remove(struct i2c_client *client)
+{
+	int ret;
+	struct rt9455_info *info = i2c_get_clientdata(client);
+
+	ret = rt9455_register_reset(info);
+	if (ret)
+		dev_err(&info->client->dev, "Failed to set charger to its default values\n");
+
+#if IS_ENABLED(CONFIG_USB_PHY)
+	if (!IS_ERR_OR_NULL(info->usb_phy)) {
+		usb_unregister_notifier(info->usb_phy, &info->nb);
+		usb_put_phy(info->usb_phy);
+	}
+#endif
+
+	cancel_delayed_work_sync(&info->pwr_rdy_work);
+	cancel_delayed_work_sync(&info->max_charging_time_work);
+	cancel_delayed_work_sync(&info->batt_presence_work);
+
+	power_supply_unregister(info->charger);
+
+	return ret;
+}
+
+static const struct i2c_device_id rt9455_i2c_id_table[] = {
+	{ RT9455_DRIVER_NAME, 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, rt9455_i2c_id_table);
+
+static const struct of_device_id rt9455_of_match[] = {
+	{ .compatible = "rt,rt9455", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rt9455_of_match);
+
+static const struct acpi_device_id rt9455_i2c_acpi_match[] = {
+	{"RTK9455", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, rt9455_i2c_acpi_match);
+
+static struct i2c_driver rt9455_driver = {
+	.probe		= rt9455_probe,
+	.remove		= rt9455_remove,
+	.id_table	= rt9455_i2c_id_table,
+	.driver = {
+		.name		= RT9455_DRIVER_NAME,
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(rt9455_of_match),
+		.acpi_match_table = ACPI_PTR(rt9455_i2c_acpi_match),
+	},
+};
+module_i2c_driver(rt9455_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Anda-Maria Nicolae <anda-maria.nicolae@intel.com>");
+MODULE_ALIAS("i2c:rt9455-charger");
+MODULE_DESCRIPTION("Richtek RT9455 Charger Driver");
-- 
1.7.9.5
