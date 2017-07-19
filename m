From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 2/2] power: supply: bq27xxx: move platform driver code into bq27xxx_battery_hdq.c
Date: Wed, 19 Jul 2017 12:04:07 -0500
Message-ID: <20170719170407.14005-3-afd@ti.com>
References: <20170719170407.14005-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719170407.14005-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-pm@vger.kernel.org

When the BQ27xxx driver was originally written the w1 subsystem only
allowed device drivers for w1 attached devices to live in the w1
subsystem. Kernel driver subsystems expect that the driver for a device
live in the directory of the subsystem for which it implements
functionality, not in the directory of the bus that it is attached. To
work around this, the BQ27xxx driver was implemented as a platform device
driver and the interface driver would instantiate this device from within
the w1 directory, then pass a w1 read callback as platform data.

As we can now have the w1 interface driver in the power/supply directory
(like we do already with the i2c interface driver) we can remove this
middle-layer platform driver.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Acked-by: Pali Rohár <pali.rohar@gmail.com>
Acked-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c     | 104 ------------
 drivers/power/supply/bq27xxx_battery_hdq.c | 250 ++++++++++++++++-------------
 include/linux/power/bq27xxx_battery.h      |  17 --
 3 files changed, 135 insertions(+), 236 deletions(-)
 rewrite drivers/power/supply/bq27xxx_battery_hdq.c (72%)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index ed44439d0112..079083b31293 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1938,110 +1938,6 @@ void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
 
-static int bq27xxx_battery_platform_read(struct bq27xxx_device_info *di, u8 reg,
-					 bool single)
-{
-	struct device *dev = di->dev;
-	struct bq27xxx_platform_data *pdata = dev->platform_data;
-	unsigned int timeout = 3;
-	int upper, lower;
-	int temp;
-
-	if (!single) {
-		/* Make sure the value has not changed in between reading the
-		 * lower and the upper part */
-		upper = pdata->read(dev, reg + 1);
-		do {
-			temp = upper;
-			if (upper < 0)
-				return upper;
-
-			lower = pdata->read(dev, reg);
-			if (lower < 0)
-				return lower;
-
-			upper = pdata->read(dev, reg + 1);
-		} while (temp != upper && --timeout);
-
-		if (timeout == 0)
-			return -EIO;
-
-		return (upper << 8) | lower;
-	}
-
-	return pdata->read(dev, reg);
-}
-
-static int bq27xxx_battery_platform_probe(struct platform_device *pdev)
-{
-	struct bq27xxx_device_info *di;
-	struct bq27xxx_platform_data *pdata = pdev->dev.platform_data;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform_data supplied\n");
-		return -EINVAL;
-	}
-
-	if (!pdata->read) {
-		dev_err(&pdev->dev, "no hdq read callback supplied\n");
-		return -EINVAL;
-	}
-
-	if (!pdata->chip) {
-		dev_err(&pdev->dev, "no device supplied\n");
-		return -EINVAL;
-	}
-
-	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
-	if (!di)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, di);
-
-	di->dev = &pdev->dev;
-	di->chip = pdata->chip;
-	di->name = pdata->name ?: dev_name(&pdev->dev);
-	di->bus.read = bq27xxx_battery_platform_read;
-
-	return bq27xxx_battery_setup(di);
-}
-
-static int bq27xxx_battery_platform_remove(struct platform_device *pdev)
-{
-	struct bq27xxx_device_info *di = platform_get_drvdata(pdev);
-
-	bq27xxx_battery_teardown(di);
-
-	return 0;
-}
-
-static const struct platform_device_id bq27xxx_battery_platform_id_table[] = {
-	{ "bq27000-battery", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(platform, bq27xxx_battery_platform_id_table);
-
-#ifdef CONFIG_OF
-static const struct of_device_id bq27xxx_battery_platform_of_match_table[] = {
-	{ .compatible = "ti,bq27000" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, bq27xxx_battery_platform_of_match_table);
-#endif
-
-static struct platform_driver bq27xxx_battery_platform_driver = {
-	.probe	= bq27xxx_battery_platform_probe,
-	.remove = bq27xxx_battery_platform_remove,
-	.driver = {
-		.name = "bq27000-battery",
-		.of_match_table = of_match_ptr(bq27xxx_battery_platform_of_match_table),
-	},
-	.id_table = bq27xxx_battery_platform_id_table,
-};
-module_platform_driver(bq27xxx_battery_platform_driver);
-
-MODULE_ALIAS("platform:bq27000-battery");
-
 MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
 MODULE_DESCRIPTION("BQ27xxx battery monitor driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/power/supply/bq27xxx_battery_hdq.c b/drivers/power/supply/bq27xxx_battery_hdq.c
dissimilarity index 72%
index f4df67eb9d2c..9aff896c9802 100644
--- a/drivers/power/supply/bq27xxx_battery_hdq.c
+++ b/drivers/power/supply/bq27xxx_battery_hdq.c
@@ -1,115 +1,135 @@
-/*
- * Copyright (C) 2007 Texas Instruments, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/types.h>
-#include <linux/platform_device.h>
-#include <linux/mutex.h>
-#include <linux/power/bq27xxx_battery.h>
-
-#include <linux/w1.h>
-
-#define W1_FAMILY_BQ27000	0x01
-
-#define HDQ_CMD_READ	(0)
-#define HDQ_CMD_WRITE	(1<<7)
-
-static int F_ID;
-module_param(F_ID, int, S_IRUSR);
-MODULE_PARM_DESC(F_ID, "1-wire slave FID for BQ device");
-
-static int w1_bq27000_read(struct device *dev, unsigned int reg)
-{
-	u8 val;
-	struct w1_slave *sl = container_of(dev->parent, struct w1_slave, dev);
-
-	mutex_lock(&sl->master->bus_mutex);
-	w1_write_8(sl->master, HDQ_CMD_READ | reg);
-	val = w1_read_8(sl->master);
-	mutex_unlock(&sl->master->bus_mutex);
-
-	return val;
-}
-
-static struct bq27xxx_platform_data bq27000_battery_info = {
-	.read   = w1_bq27000_read,
-	.name   = "bq27000-battery",
-	.chip   = BQ27000,
-};
-
-static int w1_bq27000_add_slave(struct w1_slave *sl)
-{
-	int ret;
-	struct platform_device *pdev;
-
-	pdev = platform_device_alloc("bq27000-battery", -1);
-	if (!pdev) {
-		ret = -ENOMEM;
-		return ret;
-	}
-	ret = platform_device_add_data(pdev,
-				       &bq27000_battery_info,
-				       sizeof(bq27000_battery_info));
-	if (ret)
-		goto pdev_add_failed;
-	pdev->dev.parent = &sl->dev;
-
-	ret = platform_device_add(pdev);
-	if (ret)
-		goto pdev_add_failed;
-
-	dev_set_drvdata(&sl->dev, pdev);
-
-	goto success;
-
-pdev_add_failed:
-	platform_device_put(pdev);
-success:
-	return ret;
-}
-
-static void w1_bq27000_remove_slave(struct w1_slave *sl)
-{
-	struct platform_device *pdev = dev_get_drvdata(&sl->dev);
-
-	platform_device_unregister(pdev);
-}
-
-static struct w1_family_ops w1_bq27000_fops = {
-	.add_slave	= w1_bq27000_add_slave,
-	.remove_slave	= w1_bq27000_remove_slave,
-};
-
-static struct w1_family w1_bq27000_family = {
-	.fid = W1_FAMILY_BQ27000,
-	.fops = &w1_bq27000_fops,
-};
-
-static int __init w1_bq27000_init(void)
-{
-	if (F_ID)
-		w1_bq27000_family.fid = F_ID;
-
-	return w1_register_family(&w1_bq27000_family);
-}
-
-static void __exit w1_bq27000_exit(void)
-{
-	w1_unregister_family(&w1_bq27000_family);
-}
-
-module_init(w1_bq27000_init);
-module_exit(w1_bq27000_exit);
-
-MODULE_AUTHOR("Texas Instruments Ltd");
-MODULE_DESCRIPTION("HDQ/1-wire slave driver bq27000 battery monitor chip");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("w1-family-" __stringify(W1_FAMILY_BQ27000));
+/*
+ * BQ27xxx battery monitor HDQ/1-wire driver
+ *
+ * Copyright (C) 2007-2017 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/power/bq27xxx_battery.h>
+
+#include <linux/w1.h>
+
+#define W1_FAMILY_BQ27000	0x01
+
+#define HDQ_CMD_READ	(0 << 7)
+#define HDQ_CMD_WRITE	(1 << 7)
+
+static int F_ID;
+module_param(F_ID, int, S_IRUSR);
+MODULE_PARM_DESC(F_ID, "1-wire slave FID for BQ27xxx device");
+
+static int w1_bq27000_read(struct w1_slave *sl, unsigned int reg)
+{
+	u8 val;
+
+	mutex_lock(&sl->master->bus_mutex);
+	w1_write_8(sl->master, HDQ_CMD_READ | reg);
+	val = w1_read_8(sl->master);
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return val;
+}
+
+static int bq27xxx_battery_hdq_read(struct bq27xxx_device_info *di, u8 reg,
+				    bool single)
+{
+	struct w1_slave *sl = dev_to_w1_slave(di->dev);
+	unsigned int timeout = 3;
+	int upper, lower;
+	int temp;
+
+	if (!single) {
+		/*
+		 * Make sure the value has not changed in between reading the
+		 * lower and the upper part
+		 */
+		upper = w1_bq27000_read(sl, reg + 1);
+		do {
+			temp = upper;
+			if (upper < 0)
+				return upper;
+
+			lower = w1_bq27000_read(sl, reg);
+			if (lower < 0)
+				return lower;
+
+			upper = w1_bq27000_read(sl, reg + 1);
+		} while (temp != upper && --timeout);
+
+		if (timeout == 0)
+			return -EIO;
+
+		return (upper << 8) | lower;
+	}
+
+	return w1_bq27000_read(sl, reg);
+}
+
+static int bq27xxx_battery_hdq_add_slave(struct w1_slave *sl)
+{
+	struct bq27xxx_device_info *di;
+
+	di = devm_kzalloc(&sl->dev, sizeof(*di), GFP_KERNEL);
+	if (!di)
+		return -ENOMEM;
+
+	dev_set_drvdata(&sl->dev, di);
+
+	di->dev = &sl->dev;
+	di->chip = BQ27000;
+	di->name = "bq27000-battery";
+	di->bus.read = bq27xxx_battery_hdq_read;
+
+	return bq27xxx_battery_setup(di);
+}
+
+static void bq27xxx_battery_hdq_remove_slave(struct w1_slave *sl)
+{
+	struct bq27xxx_device_info *di = dev_get_drvdata(&sl->dev);
+
+	bq27xxx_battery_teardown(di);
+}
+
+static struct w1_family_ops bq27xxx_battery_hdq_fops = {
+	.add_slave	= bq27xxx_battery_hdq_add_slave,
+	.remove_slave	= bq27xxx_battery_hdq_remove_slave,
+};
+
+static struct w1_family bq27xxx_battery_hdq_family = {
+	.fid = W1_FAMILY_BQ27000,
+	.fops = &bq27xxx_battery_hdq_fops,
+};
+
+static int __init bq27xxx_battery_hdq_init(void)
+{
+	if (F_ID)
+		bq27xxx_battery_hdq_family.fid = F_ID;
+
+	return w1_register_family(&bq27xxx_battery_hdq_family);
+}
+module_init(bq27xxx_battery_hdq_init);
+
+static void __exit bq27xxx_battery_hdq_exit(void)
+{
+	w1_unregister_family(&bq27xxx_battery_hdq_family);
+}
+module_exit(bq27xxx_battery_hdq_exit);
+
+MODULE_AUTHOR("Texas Instruments Ltd");
+MODULE_DESCRIPTION("BQ27xxx battery monitor HDQ/1-wire driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("w1-family-" __stringify(W1_FAMILY_BQ27000));
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 11e11685dd1d..89890437f9ab 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -20,23 +20,6 @@ enum bq27xxx_chip {
 	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
 };
 
-/**
- * struct bq27xxx_plaform_data - Platform data for bq27xxx devices
- * @name: Name of the battery.
- * @chip: Chip class number of this device.
- * @read: HDQ read callback.
- *	This function should provide access to the HDQ bus the battery is
- *	connected to.
- *	The first parameter is a pointer to the battery device, the second the
- *	register to be read. The return value should either be the content of
- *	the passed register or an error value.
- */
-struct bq27xxx_platform_data {
-	const char *name;
-	enum bq27xxx_chip chip;
-	int (*read)(struct device *dev, unsigned int);
-};
-
 struct bq27xxx_device_info;
 struct bq27xxx_access_methods {
 	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
-- 
2.13.0
