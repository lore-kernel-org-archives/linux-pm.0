From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH] power: bq27xxx_battery: Reorganize I2C into a module
Date: Mon, 23 Nov 2015 10:53:51 -0600
Message-ID: <1448297631-8916-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55322 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711AbbKWQyM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 11:54:12 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Andreas Dannenberg <dannenberg@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>

Separate out I2C functionality into a module. This fixes several small
issues and simplifies the driver initialization.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/Kconfig                 |  14 +-
 drivers/power/Makefile                |   1 +
 drivers/power/bq27xxx_battery.c       | 326 +++-----------------------=
--------
 drivers/power/bq27xxx_battery_i2c.c   | 150 ++++++++++++++++
 include/linux/power/bq27xxx_battery.h |  57 ++++--
 5 files changed, 227 insertions(+), 321 deletions(-)
 create mode 100644 drivers/power/bq27xxx_battery_i2c.c

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 237d7aa..42a5b51 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -160,22 +160,16 @@ config BATTERY_SBS
 config BATTERY_BQ27XXX
 	tristate "BQ27xxx battery driver"
 	help
-	  Say Y here to enable support for batteries with BQ27xxx (I2C/HDQ) c=
hips.
+	  Say Y here to enable support for batteries with BQ27xxx chips.
=20
 config BATTERY_BQ27XXX_I2C
-	bool "BQ27xxx I2C support"
+	tristate "BQ27xxx I2C support"
 	depends on BATTERY_BQ27XXX
 	depends on I2C
 	default y
 	help
-	  Say Y here to enable support for batteries with BQ27xxx (I2C) chips=
=2E
-
-config BATTERY_BQ27XXX_PLATFORM
-	bool "BQ27xxx HDQ support"
-	depends on BATTERY_BQ27XXX
-	default y
-	help
-	  Say Y here to enable support for batteries with BQ27xxx (HDQ) chips=
=2E
+	  Say Y here to enable support for batteries with BQ27xxx chips
+	  connected over an I2C bus.
=20
 config BATTERY_DA9030
 	tristate "DA9030 battery driver"
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index b656638..0e4eab5 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_BATTERY_IPAQ_MICRO) +=3D ipaq_micro_batt=
ery.o
 obj-$(CONFIG_BATTERY_WM97XX)	+=3D wm97xx_battery.o
 obj-$(CONFIG_BATTERY_SBS)	+=3D sbs-battery.o
 obj-$(CONFIG_BATTERY_BQ27XXX)	+=3D bq27xxx_battery.o
+obj-$(CONFIG_BATTERY_BQ27XXX_I2C) +=3D bq27xxx_battery_i2c.o
 obj-$(CONFIG_BATTERY_DA9030)	+=3D da9030_battery.o
 obj-$(CONFIG_BATTERY_DA9052)	+=3D da9052-battery.o
 obj-$(CONFIG_CHARGER_DA9150)	+=3D da9150-charger.o
diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_ba=
ttery.c
index 880233c..0607397 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -45,11 +45,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
-#include <linux/idr.h>
-#include <linux/i2c.h>
 #include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <asm/unaligned.h>
=20
 #include <linux/power/bq27xxx_battery.h>
=20
@@ -78,11 +74,6 @@
 #define BQ27XXX_POWER_CONSTANT		(29200) /* 29.2 =C2=B5V^2 * 1000 */
 #define BQ27XXX_CURRENT_CONSTANT	(3570) /* 3.57 =C2=B5V * 1000 */
=20
-struct bq27xxx_device_info;
-struct bq27xxx_access_methods {
-	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
-};
-
 #define INVALID_REG_ADDR	0xff
=20
 /*
@@ -110,40 +101,6 @@ enum bq27xxx_reg_index {
 	BQ27XXX_REG_AP,		/* Average Power */
 };
=20
-struct bq27xxx_reg_cache {
-	int temperature;
-	int time_to_empty;
-	int time_to_empty_avg;
-	int time_to_full;
-	int charge_full;
-	int cycle_count;
-	int capacity;
-	int energy;
-	int flags;
-	int power_avg;
-	int health;
-};
-
-struct bq27xxx_device_info {
-	struct device		*dev;
-	int			id;
-	enum bq27xxx_chip	chip;
-
-	struct bq27xxx_reg_cache cache;
-	int charge_design_full;
-
-	unsigned long last_update;
-	struct delayed_work work;
-
-	struct power_supply	*bat;
-
-	struct bq27xxx_access_methods bus;
-
-	struct mutex lock;
-
-	u8 *regs;
-};
-
 /* Register mappings */
 static u8 bq27000_regs[] =3D {
 	0x00,	/* CONTROL	*/
@@ -710,7 +667,7 @@ static int bq27xxx_battery_read_health(struct bq27x=
xx_device_info *di)
 	return POWER_SUPPLY_HEALTH_GOOD;
 }
=20
-static void bq27xxx_battery_update(struct bq27xxx_device_info *di)
+void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 {
 	struct bq27xxx_reg_cache cache =3D {0, };
 	bool has_ci_flag =3D di->chip =3D=3D BQ27000 || di->chip =3D=3D BQ270=
10;
@@ -761,6 +718,7 @@ static void bq27xxx_battery_update(struct bq27xxx_d=
evice_info *di)
=20
 	di->last_update =3D jiffies;
 }
+EXPORT_SYMBOL_GPL(bq27xxx_battery_update);
=20
 static void bq27xxx_battery_poll(struct work_struct *work)
 {
@@ -991,32 +949,30 @@ static void bq27xxx_external_power_changed(struct=
 power_supply *psy)
 	schedule_delayed_work(&di->work, 0);
 }
=20
-static int bq27xxx_powersupply_init(struct bq27xxx_device_info *di,
-				    const char *name)
+int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 {
-	int ret;
 	struct power_supply_desc *psy_desc;
 	struct power_supply_config psy_cfg =3D { .drv_data =3D di, };
=20
+	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
+	mutex_init(&di->lock);
+	di->regs =3D bq27xxx_regs[di->chip];
+
 	psy_desc =3D devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (!psy_desc)
 		return -ENOMEM;
=20
-	psy_desc->name =3D name;
+	psy_desc->name =3D di->name;
 	psy_desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
 	psy_desc->properties =3D bq27xxx_battery_props[di->chip].props;
 	psy_desc->num_properties =3D bq27xxx_battery_props[di->chip].size;
 	psy_desc->get_property =3D bq27xxx_battery_get_property;
 	psy_desc->external_power_changed =3D bq27xxx_external_power_changed;
=20
-	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
-	mutex_init(&di->lock);
-
 	di->bat =3D power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(di->bat)) {
-		ret =3D PTR_ERR(di->bat);
-		dev_err(di->dev, "failed to register battery: %d\n", ret);
-		return ret;
+		dev_err(di->dev, "failed to register battery\n");
+		return PTR_ERR(di->bat);
 	}
=20
 	dev_info(di->dev, "support ver. %s enabled\n", DRIVER_VERSION);
@@ -1025,8 +981,9 @@ static int bq27xxx_powersupply_init(struct bq27xxx=
_device_info *di,
=20
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bq27xxx_battery_setup);
=20
-static void bq27xxx_powersupply_unregister(struct bq27xxx_device_info =
*di)
+void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 {
 	/*
 	 * power_supply_unregister call bq27xxx_battery_get_property which
@@ -1042,192 +999,7 @@ static void bq27xxx_powersupply_unregister(struc=
t bq27xxx_device_info *di)
=20
 	mutex_destroy(&di->lock);
 }
-
-/* i2c specific code */
-#ifdef CONFIG_BATTERY_BQ27XXX_I2C
-
-/* If the system has several batteries we need a different name for ea=
ch
- * of them...
- */
-static DEFINE_IDR(battery_id);
-static DEFINE_MUTEX(battery_mutex);
-
-static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *d=
ata)
-{
-	struct bq27xxx_device_info *di =3D data;
-
-	bq27xxx_battery_update(di);
-
-	return IRQ_HANDLED;
-}
-
-static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8=
 reg,
-				    bool single)
-{
-	struct i2c_client *client =3D to_i2c_client(di->dev);
-	struct i2c_msg msg[2];
-	unsigned char data[2];
-	int ret;
-
-	if (!client->adapter)
-		return -ENODEV;
-
-	msg[0].addr =3D client->addr;
-	msg[0].flags =3D 0;
-	msg[0].buf =3D &reg;
-	msg[0].len =3D sizeof(reg);
-	msg[1].addr =3D client->addr;
-	msg[1].flags =3D I2C_M_RD;
-	msg[1].buf =3D data;
-	if (single)
-		msg[1].len =3D 1;
-	else
-		msg[1].len =3D 2;
-
-	ret =3D i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
-	if (ret < 0)
-		return ret;
-
-	if (!single)
-		ret =3D get_unaligned_le16(data);
-	else
-		ret =3D data[0];
-
-	return ret;
-}
-
-static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
-				     const struct i2c_device_id *id)
-{
-	char *name;
-	struct bq27xxx_device_info *di;
-	int num;
-	int retval =3D 0;
-
-	/* Get new ID for the new battery device */
-	mutex_lock(&battery_mutex);
-	num =3D idr_alloc(&battery_id, client, 0, 0, GFP_KERNEL);
-	mutex_unlock(&battery_mutex);
-	if (num < 0)
-		return num;
-
-	name =3D devm_kasprintf(&client->dev, GFP_KERNEL, "%s-%d", id->name, =
num);
-	if (!name) {
-		retval =3D -ENOMEM;
-		goto batt_failed;
-	}
-
-	di =3D devm_kzalloc(&client->dev, sizeof(*di), GFP_KERNEL);
-	if (!di) {
-		retval =3D -ENOMEM;
-		goto batt_failed;
-	}
-
-	di->id =3D num;
-	di->dev =3D &client->dev;
-	di->chip =3D id->driver_data;
-	di->bus.read =3D &bq27xxx_battery_i2c_read;
-	di->regs =3D bq27xxx_regs[di->chip];
-
-	retval =3D bq27xxx_powersupply_init(di, name);
-	if (retval)
-		goto batt_failed;
-
-	/* Schedule a polling after about 1 min */
-	schedule_delayed_work(&di->work, 60 * HZ);
-
-	i2c_set_clientdata(client, di);
-
-	if (client->irq) {
-		retval =3D devm_request_threaded_irq(&client->dev, client->irq,
-				NULL, bq27xxx_battery_irq_handler_thread,
-				IRQF_ONESHOT,
-				name, di);
-		if (retval) {
-			dev_err(&client->dev,
-				"Unable to register IRQ %d error %d\n",
-				client->irq, retval);
-			return retval;
-		}
-	}
-
-	return 0;
-
-batt_failed:
-	mutex_lock(&battery_mutex);
-	idr_remove(&battery_id, num);
-	mutex_unlock(&battery_mutex);
-
-	return retval;
-}
-
-static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
-{
-	struct bq27xxx_device_info *di =3D i2c_get_clientdata(client);
-
-	bq27xxx_powersupply_unregister(di);
-
-	mutex_lock(&battery_mutex);
-	idr_remove(&battery_id, di->id);
-	mutex_unlock(&battery_mutex);
-
-	return 0;
-}
-
-static const struct i2c_device_id bq27xxx_id[] =3D {
-	{ "bq27200", BQ27000 },
-	{ "bq27210", BQ27010 },
-	{ "bq27500", BQ27500 },
-	{ "bq27510", BQ27500 },
-	{ "bq27520", BQ27500 },
-	{ "bq27530", BQ27530 },
-	{ "bq27531", BQ27530 },
-	{ "bq27541", BQ27541 },
-	{ "bq27542", BQ27541 },
-	{ "bq27546", BQ27541 },
-	{ "bq27742", BQ27541 },
-	{ "bq27545", BQ27545 },
-	{ "bq27421", BQ27421 },
-	{ "bq27425", BQ27421 },
-	{ "bq27441", BQ27421 },
-	{ "bq27621", BQ27421 },
-	{},
-};
-MODULE_DEVICE_TABLE(i2c, bq27xxx_id);
-
-static struct i2c_driver bq27xxx_battery_i2c_driver =3D {
-	.driver =3D {
-		.name =3D "bq27xxx-battery",
-	},
-	.probe =3D bq27xxx_battery_i2c_probe,
-	.remove =3D bq27xxx_battery_i2c_remove,
-	.id_table =3D bq27xxx_id,
-};
-
-static inline int bq27xxx_battery_i2c_init(void)
-{
-	int ret =3D i2c_add_driver(&bq27xxx_battery_i2c_driver);
-
-	if (ret)
-		pr_err("Unable to register BQ27xxx i2c driver\n");
-
-	return ret;
-}
-
-static inline void bq27xxx_battery_i2c_exit(void)
-{
-	i2c_del_driver(&bq27xxx_battery_i2c_driver);
-}
-
-#else
-
-static inline int bq27xxx_battery_i2c_init(void) { return 0; }
-static inline void bq27xxx_battery_i2c_exit(void) {};
-
-#endif
-
-/* platform specific code */
-#ifdef CONFIG_BATTERY_BQ27XXX_PLATFORM
+EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
=20
 static int bq27xxx_battery_platform_read(struct bq27xxx_device_info *d=
i, u8 reg,
 					 bool single)
@@ -1267,7 +1039,6 @@ static int bq27xxx_battery_platform_probe(struct =
platform_device *pdev)
 {
 	struct bq27xxx_device_info *di;
 	struct bq27xxx_platform_data *pdata =3D pdev->dev.platform_data;
-	const char *name;
=20
 	if (!pdata) {
 		dev_err(&pdev->dev, "no platform_data supplied\n");
@@ -1292,83 +1063,36 @@ static int bq27xxx_battery_platform_probe(struc=
t platform_device *pdev)
=20
 	di->dev =3D &pdev->dev;
 	di->chip =3D pdata->chip;
-	di->regs =3D bq27xxx_regs[di->chip];
-
-	name =3D pdata->name ?: dev_name(&pdev->dev);
-	di->bus.read =3D &bq27xxx_battery_platform_read;
+	di->name =3D pdata->name ?: dev_name(&pdev->dev);
+	di->bus.read =3D bq27xxx_battery_platform_read;
=20
-	return bq27xxx_powersupply_init(di, name);
+	return bq27xxx_battery_setup(di);
 }
=20
 static int bq27xxx_battery_platform_remove(struct platform_device *pde=
v)
 {
 	struct bq27xxx_device_info *di =3D platform_get_drvdata(pdev);
=20
-	bq27xxx_powersupply_unregister(di);
+	bq27xxx_battery_teardown(di);
=20
 	return 0;
 }
=20
+static const struct platform_device_id bq27xxx_battery_platform_id_tab=
le[] =3D {
+	{ "bq27000-battery", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, bq27xxx_battery_platform_id_table);
+
 static struct platform_driver bq27xxx_battery_platform_driver =3D {
 	.probe	=3D bq27xxx_battery_platform_probe,
 	.remove =3D bq27xxx_battery_platform_remove,
 	.driver =3D {
 		.name =3D "bq27000-battery",
 	},
+	.id_table =3D bq27xxx_battery_platform_id_table,
 };
-
-static inline int bq27xxx_battery_platform_init(void)
-{
-	int ret =3D platform_driver_register(&bq27xxx_battery_platform_driver=
);
-
-	if (ret)
-		pr_err("Unable to register BQ27xxx platform driver\n");
-
-	return ret;
-}
-
-static inline void bq27xxx_battery_platform_exit(void)
-{
-	platform_driver_unregister(&bq27xxx_battery_platform_driver);
-}
-
-#else
-
-static inline int bq27xxx_battery_platform_init(void) { return 0; }
-static inline void bq27xxx_battery_platform_exit(void) {};
-
-#endif
-
-/*
- * Module stuff
- */
-
-static int __init bq27xxx_battery_init(void)
-{
-	int ret;
-
-	ret =3D bq27xxx_battery_i2c_init();
-	if (ret)
-		return ret;
-
-	ret =3D bq27xxx_battery_platform_init();
-	if (ret)
-		bq27xxx_battery_i2c_exit();
-
-	return ret;
-}
-module_init(bq27xxx_battery_init);
-
-static void __exit bq27xxx_battery_exit(void)
-{
-	bq27xxx_battery_platform_exit();
-	bq27xxx_battery_i2c_exit();
-}
-module_exit(bq27xxx_battery_exit);
-
-#ifdef CONFIG_BATTERY_BQ27XXX_PLATFORM
-MODULE_ALIAS("platform:bq27000-battery");
-#endif
+module_platform_driver(bq27xxx_battery_platform_driver);
=20
 MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
 MODULE_DESCRIPTION("BQ27xxx battery monitor driver");
diff --git a/drivers/power/bq27xxx_battery_i2c.c b/drivers/power/bq27xx=
x_battery_i2c.c
new file mode 100644
index 0000000..9429e66
--- /dev/null
+++ b/drivers/power/bq27xxx_battery_i2c.c
@@ -0,0 +1,150 @@
+/*
+ * SCI Reset driver for Keystone based devices
+ *
+ * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.c=
om/
+ *	Andrew F. Davis <afd@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <asm/unaligned.h>
+
+#include <linux/power/bq27xxx_battery.h>
+
+static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *d=
ata)
+{
+	struct bq27xxx_device_info *di =3D data;
+
+	bq27xxx_battery_update(di);
+
+	return IRQ_HANDLED;
+}
+
+static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8=
 reg,
+				    bool single)
+{
+	struct i2c_client *client =3D to_i2c_client(di->dev);
+	struct i2c_msg msg[2];
+	unsigned char data[2];
+	int ret;
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	msg[0].addr =3D client->addr;
+	msg[0].flags =3D 0;
+	msg[0].buf =3D &reg;
+	msg[0].len =3D sizeof(reg);
+	msg[1].addr =3D client->addr;
+	msg[1].flags =3D I2C_M_RD;
+	msg[1].buf =3D data;
+	if (single)
+		msg[1].len =3D 1;
+	else
+		msg[1].len =3D 2;
+
+	ret =3D i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret < 0)
+		return ret;
+
+	if (!single)
+		ret =3D get_unaligned_le16(data);
+	else
+		ret =3D data[0];
+
+	return ret;
+}
+
+static int bq27xxx_battery_i2c_probe(struct i2c_client *client,
+				     const struct i2c_device_id *id)
+{
+	struct bq27xxx_device_info *di;
+	int ret;
+
+	di =3D devm_kzalloc(&client->dev, sizeof(*di), GFP_KERNEL);
+	if (!di)
+		return -ENOMEM;
+
+	di->dev =3D &client->dev;
+	di->chip =3D id->driver_data;
+	di->name =3D id->name;
+	di->bus.read =3D bq27xxx_battery_i2c_read;
+
+	ret =3D bq27xxx_battery_setup(di);
+	if (ret)
+		return ret;
+
+	/* Schedule a polling after about 1 min */
+	schedule_delayed_work(&di->work, 60 * HZ);
+
+	i2c_set_clientdata(client, di);
+
+	if (client->irq) {
+		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
+				NULL, bq27xxx_battery_irq_handler_thread,
+				IRQF_ONESHOT,
+				di->name, di);
+		if (ret) {
+			dev_err(&client->dev,
+				"Unable to register IRQ %d error %d\n",
+				client->irq, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
+{
+	struct bq27xxx_device_info *di =3D i2c_get_clientdata(client);
+
+	bq27xxx_battery_teardown(di);
+
+	return 0;
+}
+
+static const struct i2c_device_id bq27xxx_i2c_id_table[] =3D {
+	{ "bq27200", BQ27000 },
+	{ "bq27210", BQ27010 },
+	{ "bq27500", BQ27500 },
+	{ "bq27510", BQ27500 },
+	{ "bq27520", BQ27500 },
+	{ "bq27530", BQ27530 },
+	{ "bq27531", BQ27530 },
+	{ "bq27541", BQ27541 },
+	{ "bq27542", BQ27541 },
+	{ "bq27546", BQ27541 },
+	{ "bq27742", BQ27541 },
+	{ "bq27545", BQ27545 },
+	{ "bq27421", BQ27421 },
+	{ "bq27425", BQ27421 },
+	{ "bq27441", BQ27421 },
+	{ "bq27621", BQ27421 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
+
+static struct i2c_driver bq27xxx_battery_i2c_driver =3D {
+	.driver =3D {
+		.name =3D "bq27xxx-battery",
+	},
+	.probe =3D bq27xxx_battery_i2c_probe,
+	.remove =3D bq27xxx_battery_i2c_remove,
+	.id_table =3D bq27xxx_i2c_id_table,
+};
+module_i2c_driver(bq27xxx_battery_i2c_driver);
+
+MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_DESCRIPTION("BQ27xxx battery monitor i2c driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/powe=
r/bq27xxx_battery.h
index 45f6a7b..998d8f1 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -1,6 +1,16 @@
 #ifndef __LINUX_BQ27X00_BATTERY_H__
 #define __LINUX_BQ27X00_BATTERY_H__
=20
+enum bq27xxx_chip {
+	BQ27000 =3D 1, /* bq27000, bq27200 */
+	BQ27010, /* bq27010, bq27210 */
+	BQ27500, /* bq27500, bq27510, bq27520 */
+	BQ27530, /* bq27530, bq27531 */
+	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
+	BQ27545, /* bq27545 */
+	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
+};
+
 /**
  * struct bq27xxx_plaform_data - Platform data for bq27xxx devices
  * @name: Name of the battery.
@@ -12,20 +22,47 @@
  *	register to be read. The return value should either be the content =
of
  *	the passed register or an error value.
  */
-enum bq27xxx_chip {
-	BQ27000 =3D 1, /* bq27000, bq27200 */
-	BQ27010, /* bq27010, bq27210 */
-	BQ27500, /* bq27500, bq27510, bq27520 */
-	BQ27530, /* bq27530, bq27531 */
-	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
-	BQ27545, /* bq27545 */
-	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
-};
-
 struct bq27xxx_platform_data {
 	const char *name;
 	enum bq27xxx_chip chip;
 	int (*read)(struct device *dev, unsigned int);
 };
=20
+struct bq27xxx_device_info;
+struct bq27xxx_access_methods {
+	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
+};
+
+struct bq27xxx_reg_cache {
+	int temperature;
+	int time_to_empty;
+	int time_to_empty_avg;
+	int time_to_full;
+	int charge_full;
+	int cycle_count;
+	int capacity;
+	int energy;
+	int flags;
+	int power_avg;
+	int health;
+};
+
+struct bq27xxx_device_info {
+	struct device *dev;
+	enum bq27xxx_chip chip;
+	const char *name;
+	struct bq27xxx_access_methods bus;
+	struct bq27xxx_reg_cache cache;
+	int charge_design_full;
+	unsigned long last_update;
+	struct delayed_work work;
+	struct power_supply *bat;
+	struct mutex lock;
+	u8 *regs;
+};
+
+void bq27xxx_battery_update(struct bq27xxx_device_info *di);
+int bq27xxx_battery_setup(struct bq27xxx_device_info *di);
+void bq27xxx_battery_teardown(struct bq27xxx_device_info *di);
+
 #endif
--=20
1.9.1

