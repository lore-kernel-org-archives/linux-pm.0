From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/4] mfd: da9150: Add support for Fuel-Gauge
Date: Thu, 18 Jun 2015 17:06:34 +0100
Message-ID: <8d8f583fee9313f261efa96a038874e552995c17.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1434643491.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/mfd/da9150-core.c       | 162 ++++++++++++++++++++++++++++++++++++++--
 include/linux/mfd/da9150/core.h |  19 +++++
 include/linux/mfd/da9150/fg.h   |  39 ++++++++++
 3 files changed, 212 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/mfd/da9150/fg.h

diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
index 5549817..8feb75d 100644
--- a/drivers/mfd/da9150-core.c
+++ b/drivers/mfd/da9150-core.c
@@ -21,8 +21,80 @@
 #include <linux/interrupt.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/da9150/core.h>
+#include <linux/mfd/da9150/fg.h>
 #include <linux/mfd/da9150/registers.h>
 
+/* Raw device access, used for QIF */
+static int da9150_i2c_read_device(struct i2c_client *client, u8 addr, int count,
+				  u8 *buf)
+{
+	struct i2c_msg xfer;
+	int ret;
+
+	/*
+	 * Read is split into two transfers as device expects STOP/START rather
+	 * than repeated start to carry out this kind of access.
+	 */
+
+	/* Write address */
+	xfer.addr = client->addr;
+	xfer.flags = 0;
+	xfer.len = 1;
+	xfer.buf = &addr;
+
+	ret = i2c_transfer(client->adapter, &xfer, 1);
+	if (ret != 1) {
+		if (ret < 0)
+			return ret;
+		else
+			return -EIO;
+	}
+
+	/* Read data */
+	xfer.addr = client->addr;
+	xfer.flags = I2C_M_RD;
+	xfer.len = count;
+	xfer.buf = buf;
+
+	ret = i2c_transfer(client->adapter, &xfer, 1);
+	if (ret == 1)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static int da9150_i2c_write_device(struct i2c_client *client, u8 addr,
+				   int count, const u8 *buf)
+{
+	struct i2c_msg xfer;
+	u8 *reg_data;
+	int ret;
+
+	reg_data = kzalloc(1 + count, GFP_KERNEL);
+	if (!reg_data)
+		return -ENOMEM;
+
+	reg_data[0] = addr;
+	memcpy(&reg_data[1], buf, count);
+
+	/* Write address & data */
+	xfer.addr = client->addr;
+	xfer.flags = 0;
+	xfer.len = 1 + count;
+	xfer.buf = reg_data;
+
+	ret = i2c_transfer(client->adapter, &xfer, 1);
+	kfree(reg_data);
+	if (ret == 1)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
 static bool da9150_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -107,6 +179,28 @@ static const struct regmap_config da9150_regmap_config = {
 	.volatile_reg = da9150_volatile_reg,
 };
 
+void da9150_read_qif(struct da9150 *da9150, u8 addr, int count, u8 *buf)
+{
+	int ret;
+
+	ret = da9150->read_dev(da9150->core_qif, addr, count, buf);
+	if (ret < 0)
+		dev_err(da9150->dev, "Failed to read from QIF 0x%x: %d\n",
+			addr, ret);
+}
+EXPORT_SYMBOL_GPL(da9150_read_qif);
+
+void da9150_write_qif(struct da9150 *da9150, u8 addr, int count, const u8 *buf)
+{
+	int ret;
+
+	ret = da9150->write_dev(da9150->core_qif, addr, count, buf);
+	if (ret < 0)
+		dev_err(da9150->dev, "Failed to write to QIF 0x%x: %d\n",
+			addr, ret);
+}
+EXPORT_SYMBOL_GPL(da9150_write_qif);
+
 u8 da9150_reg_read(struct da9150 *da9150, u16 reg)
 {
 	int val, ret;
@@ -297,6 +391,15 @@ static struct resource da9150_charger_resources[] = {
 	},
 };
 
+static struct resource da9150_fg_resources[] = {
+	{
+		.name = "FG",
+		.start = DA9150_IRQ_FG,
+		.end = DA9150_IRQ_FG,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
 static struct mfd_cell da9150_devs[] = {
 	{
 		.name = "da9150-gpadc",
@@ -310,6 +413,12 @@ static struct mfd_cell da9150_devs[] = {
 		.resources = da9150_charger_resources,
 		.num_resources = ARRAY_SIZE(da9150_charger_resources),
 	},
+	{
+		.name = "da9150-fuelgauge",
+		.of_compatible = "dlg,da9150-fg",
+		.resources = da9150_fg_resources,
+		.num_resources = ARRAY_SIZE(da9150_fg_resources),
+	},
 };
 
 static int da9150_probe(struct i2c_client *client,
@@ -317,11 +426,14 @@ static int da9150_probe(struct i2c_client *client,
 {
 	struct da9150 *da9150;
 	struct da9150_pdata *pdata = dev_get_platdata(&client->dev);
+	int qif_addr;
 	int ret;
 
 	da9150 = devm_kzalloc(&client->dev, sizeof(*da9150), GFP_KERNEL);
-	if (!da9150)
-		return -ENOMEM;
+	if (!da9150) {
+		ret = -ENOMEM;
+		goto fail;
+	}
 
 	da9150->dev = &client->dev;
 	da9150->irq = client->irq;
@@ -332,19 +444,46 @@ static int da9150_probe(struct i2c_client *client,
 		ret = PTR_ERR(da9150->regmap);
 		dev_err(da9150->dev, "Failed to allocate register map: %d\n",
 			ret);
-		return ret;
+		goto fail;
+	}
+
+	/* Setup secondary I2C interface for QIF access */
+	qif_addr = da9150_reg_read(da9150, DA9150_CORE2WIRE_CTRL_A);
+	qif_addr = (qif_addr & DA9150_CORE_BASE_ADDR_MASK) >> 1;
+	qif_addr |= DA9150_QIF_I2C_ADDR_LSB;
+	da9150->core_qif = i2c_new_dummy(client->adapter, qif_addr);
+	if (!da9150->core_qif) {
+		dev_err(da9150->dev, "Failed to attach QIF client\n");
+		ret = -ENODEV;
+		goto fail;
 	}
 
-	da9150->irq_base = pdata ? pdata->irq_base : -1;
+	i2c_set_clientdata(da9150->core_qif, da9150);
+	da9150->read_dev = (read_dev_t) da9150_i2c_read_device;
+	da9150->write_dev = (write_dev_t) da9150_i2c_write_device;
+
+	if (pdata) {
+		da9150->irq_base = pdata->irq_base;
+
+		da9150_devs[2].platform_data = pdata->fg_pdata;
+		da9150_devs[2].pdata_size = sizeof(struct da9150_fg_pdata);
+	} else {
+		da9150->irq_base = -1;
+	}
 
 	ret = regmap_add_irq_chip(da9150->regmap, da9150->irq,
 				  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 				  da9150->irq_base, &da9150_regmap_irq_chip,
 				  &da9150->regmap_irq_data);
-	if (ret)
-		return ret;
+	if (ret) {
+		dev_err(da9150->dev, "Failed to add regmap irq chip: %d\n",
+			ret);
+		goto regmap_irq_fail;
+	}
+
 
 	da9150->irq_base = regmap_irq_chip_get_base(da9150->regmap_irq_data);
+
 	enable_irq_wake(da9150->irq);
 
 	ret = mfd_add_devices(da9150->dev, -1, da9150_devs,
@@ -352,11 +491,17 @@ static int da9150_probe(struct i2c_client *client,
 			      da9150->irq_base, NULL);
 	if (ret) {
 		dev_err(da9150->dev, "Failed to add child devices: %d\n", ret);
-		regmap_del_irq_chip(da9150->irq, da9150->regmap_irq_data);
-		return ret;
+		goto mfd_fail;
 	}
 
 	return 0;
+
+mfd_fail:
+	regmap_del_irq_chip(da9150->irq, da9150->regmap_irq_data);
+regmap_irq_fail:
+	i2c_unregister_device(da9150->core_qif);
+fail:
+	return ret;
 }
 
 static int da9150_remove(struct i2c_client *client)
@@ -365,6 +510,7 @@ static int da9150_remove(struct i2c_client *client)
 
 	regmap_del_irq_chip(da9150->irq, da9150->regmap_irq_data);
 	mfd_remove_devices(da9150->dev);
+	i2c_unregister_device(da9150->core_qif);
 
 	return 0;
 }
diff --git a/include/linux/mfd/da9150/core.h b/include/linux/mfd/da9150/core.h
index 76e6689..98ecfea 100644
--- a/include/linux/mfd/da9150/core.h
+++ b/include/linux/mfd/da9150/core.h
@@ -15,9 +15,11 @@
 #define __DA9150_CORE_H
 
 #include <linux/device.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/regmap.h>
 
+
 /* I2C address paging */
 #define DA9150_REG_PAGE_SHIFT	8
 #define DA9150_REG_PAGE_MASK	0xFF
@@ -46,23 +48,40 @@
 #define DA9150_IRQ_GPADC	19
 #define DA9150_IRQ_WKUP		20
 
+/* Platform Data */
+struct da9150_fg_pdata;
+
 struct da9150_pdata {
 	int irq_base;
+	struct da9150_fg_pdata *fg_pdata;
 };
 
+/* I/O function typedefs for raw access */
+typedef int (*read_dev_t)(void *client, u8 addr, int count, u8 *buf);
+typedef int (*write_dev_t)(void *client, u8 addr, int count, const u8 *buf);
+
 struct da9150 {
 	struct device *dev;
 	struct regmap *regmap;
+	struct i2c_client *core_qif;
+
+	read_dev_t read_dev;
+	write_dev_t write_dev;
+
 	struct regmap_irq_chip_data *regmap_irq_data;
 	int irq;
 	int irq_base;
 };
 
 /* Device I/O */
+void da9150_read_qif(struct da9150 *da9150, u8 addr, int count, u8 *buf);
+void da9150_write_qif(struct da9150 *da9150, u8 addr, int count, const u8 *buf);
+
 u8 da9150_reg_read(struct da9150 *da9150, u16 reg);
 void da9150_reg_write(struct da9150 *da9150, u16 reg, u8 val);
 void da9150_set_bits(struct da9150 *da9150, u16 reg, u8 mask, u8 val);
 
 void da9150_bulk_read(struct da9150 *da9150, u16 reg, int count, u8 *buf);
 void da9150_bulk_write(struct da9150 *da9150, u16 reg, int count, const u8 *buf);
+
 #endif /* __DA9150_CORE_H */
diff --git a/include/linux/mfd/da9150/fg.h b/include/linux/mfd/da9150/fg.h
new file mode 100644
index 0000000..2cff203
--- /dev/null
+++ b/include/linux/mfd/da9150/fg.h
@@ -0,0 +1,39 @@
+/*
+ * DA9150 MFD Driver - Fuel Gauge Data
+ *
+ * Copyright (c) 2015 Dialog Semiconductor
+ *
+ * Author: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __DA9150_FG_H
+#define __DA9150_FG_H
+
+#include <linux/power_supply.h>
+
+/* I2C sub-device address */
+#define DA9150_QIF_I2C_ADDR_LSB		0x5
+
+/* Platform data */
+struct da9150_fg_pdata {
+	u32 update_interval;	/* msecs */
+	u8 warn_soc_lvl;	/* % value */
+	u8 crit_soc_lvl;	/* % value */
+};
+
+/*
+ * Function template to provide battery temperature. Should provide
+ * 0.1 degrees C resolution return values.
+ */
+typedef int (*da9150_read_temp_t)(void *context);
+
+/* Register temp callback function */
+void da9150_fg_register_temp_cb(struct power_supply *psy, da9150_read_temp_t cb,
+				void *cb_context);
+
+#endif /* __DA9150_FG_H */
-- 
1.9.3
