From: Phil Reid <preid@electromag.com.au>
Subject: [RFC v2 3/3] i2c: core: move smbus_alert module into i2c-core
Date: Tue, 28 Nov 2017 11:38:29 +0800
Message-ID: <1511840309-37964-4-git-send-email-preid@electromag.com.au>
References: <1511840309-37964-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1511840309-37964-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: realmz6@gmail.com, wsa@the-dreams.de, sre@kernel.org, preid@electromag.com.au, adi-buildroot-devel@lists.sourceforge.net, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, jdelvare@suse.de, benjamin.tissoires@redhat.com
List-Id: linux-pm@vger.kernel.org

Remove the i2c-smbus module and move the smbus_alert driver into the
i2c-core. This simplifies the build logic for when i2c-core is builtin
and drivers selecting I2C_SMBUS_ALERT are modules. Also smbus_alert code
is moved from i2c-core-smbus.c to i2c-core-smbus-alert.c

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/Kconfig                |   5 +-
 drivers/i2c/Makefile               |   2 +-
 drivers/i2c/i2c-core-base.c        |   7 ++
 drivers/i2c/i2c-core-smbus-alert.c | 243 +++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core-smbus.c       |  22 ----
 drivers/i2c/i2c-core.h             |  13 ++
 drivers/i2c/i2c-smbus.c            | 218 ---------------------------------
 7 files changed, 265 insertions(+), 245 deletions(-)
 create mode 100644 drivers/i2c/i2c-core-smbus-alert.c
 delete mode 100644 drivers/i2c/i2c-smbus.c

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index fcd4bea..486a1f4 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -85,14 +85,11 @@ config I2C_HELPER_AUTO
 	  In doubt, say Y.
 
 config I2C_SMBUS_ALERT
-	tristate "SMBus-alert protocol" if !I2C_HELPER_AUTO
+	bool "SMBus-alert protocol" if !I2C_HELPER_AUTO
 	help
 	  Say Y here if you want support for SMBus alert extensions to the I2C
 	  specification.
 
-	  This support is also available as a module.  If so, the module
-	  will be called i2c-smbus.
-
 source drivers/i2c/algos/Kconfig
 source drivers/i2c/busses/Kconfig
 
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index b0116a1..efc3c54c 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -8,8 +8,8 @@ i2c-core-objs 			:= i2c-core-base.o i2c-core-smbus.o
 i2c-core-$(CONFIG_ACPI)		+= i2c-core-acpi.o
 i2c-core-$(CONFIG_I2C_SLAVE) 	+= i2c-core-slave.o
 i2c-core-$(CONFIG_OF) 		+= i2c-core-of.o
+i2c-core-$(CONFIG_I2C_SMBUS_ALERT)	+= i2c-core-smbus-alert.o
 
-obj-$(CONFIG_I2C_SMBUS_ALERT)	+= i2c-smbus.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_MUX)		+= i2c-mux.o
 obj-y				+= algos/ busses/ muxes/
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 54ffc8d..5788c80 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1690,6 +1690,10 @@ static int __init i2c_init(void)
 	if (retval)
 		goto class_err;
 
+	retval = i2c_smbus_alert_add_driver();
+	if (retval)
+		goto dummy_err;
+
 	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
 		WARN_ON(of_reconfig_notifier_register(&i2c_of_notifier));
 	if (IS_ENABLED(CONFIG_ACPI))
@@ -1697,6 +1701,8 @@ static int __init i2c_init(void)
 
 	return 0;
 
+dummy_err:
+	i2c_del_driver(&dummy_driver);
 class_err:
 #ifdef CONFIG_I2C_COMPAT
 	class_compat_unregister(i2c_adapter_compat_class);
@@ -1713,6 +1719,7 @@ static void __exit i2c_exit(void)
 		WARN_ON(acpi_reconfig_notifier_unregister(&i2c_acpi_notifier));
 	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
 		WARN_ON(of_reconfig_notifier_unregister(&i2c_of_notifier));
+	i2c_smbus_alert_del_driver();
 	i2c_del_driver(&dummy_driver);
 #ifdef CONFIG_I2C_COMPAT
 	class_compat_unregister(i2c_adapter_compat_class);
diff --git a/drivers/i2c/i2c-core-smbus-alert.c b/drivers/i2c/i2c-core-smbus-alert.c
new file mode 100644
index 0000000..fb5aae6
--- /dev/null
+++ b/drivers/i2c/i2c-core-smbus-alert.c
@@ -0,0 +1,243 @@
+/*
+ * i2c-smbus.c - SMBus extensions to the I2C protocol
+ *
+ * Copyright (C) 2008 David Brownell
+ * Copyright (C) 2010 Jean Delvare <jdelvare@suse.de>
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
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+#include "i2c-core.h"
+
+struct i2c_smbus_alert {
+	struct work_struct	alert;
+	struct i2c_client	*ara;		/* Alert response address */
+};
+
+struct alert_data {
+	unsigned short		addr;
+	enum i2c_alert_protocol	type;
+	unsigned int		data;
+};
+
+/* If this is the alerting device, notify its driver */
+static int smbus_do_alert(struct device *dev, void *addrp)
+{
+	struct i2c_client *client = i2c_verify_client(dev);
+	struct alert_data *data = addrp;
+	struct i2c_driver *driver;
+
+	if (!client || client->addr != data->addr)
+		return 0;
+	if (client->flags & I2C_CLIENT_TEN)
+		return 0;
+
+	/*
+	 * Drivers should either disable alerts, or provide at least
+	 * a minimal handler.  Lock so the driver won't change.
+	 */
+	device_lock(dev);
+	if (client->dev.driver) {
+		driver = to_i2c_driver(client->dev.driver);
+		if (driver->alert)
+			driver->alert(client, data->type, data->data);
+		else
+			dev_warn(&client->dev, "no driver alert()!\n");
+	} else
+		dev_dbg(&client->dev, "alert with no driver\n");
+	device_unlock(dev);
+
+	/* Stop iterating after we find the device */
+	return -EBUSY;
+}
+
+/*
+ * The alert IRQ handler needs to hand work off to a task which can issue
+ * SMBus calls, because those sleeping calls can't be made in IRQ context.
+ */
+static irqreturn_t smbus_alert(int irq, void *d)
+{
+	struct i2c_smbus_alert *alert = d;
+	struct i2c_client *ara;
+	unsigned short prev_addr = 0;	/* Not a valid address */
+
+	ara = alert->ara;
+
+	for (;;) {
+		s32 status;
+		struct alert_data data;
+
+		/*
+		 * Devices with pending alerts reply in address order, low
+		 * to high, because of slave transmit arbitration.  After
+		 * responding, an SMBus device stops asserting SMBALERT#.
+		 *
+		 * Note that SMBus 2.0 reserves 10-bit addresses for future
+		 * use.  We neither handle them, nor try to use PEC here.
+		 */
+		status = i2c_smbus_read_byte(ara);
+		if (status < 0)
+			break;
+
+		data.data = status & 1;
+		data.addr = status >> 1;
+		data.type = I2C_PROTOCOL_SMBUS_ALERT;
+
+		if (data.addr == prev_addr) {
+			dev_warn(&ara->dev, "Duplicate SMBALERT# from dev "
+				"0x%02x, skipping\n", data.addr);
+			break;
+		}
+		dev_dbg(&ara->dev, "SMBALERT# from dev 0x%02x, flag %d\n",
+			data.addr, data.data);
+
+		/* Notify driver for the device which issued the alert */
+		device_for_each_child(&ara->adapter->dev, &data,
+				      smbus_do_alert);
+		prev_addr = data.addr;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void smbalert_work(struct work_struct *work)
+{
+	struct i2c_smbus_alert *alert;
+
+	alert = container_of(work, struct i2c_smbus_alert, alert);
+
+	smbus_alert(0, alert);
+}
+
+/* Setup SMBALERT# infrastructure */
+static int smbalert_probe(struct i2c_client *ara,
+			  const struct i2c_device_id *id)
+{
+	struct i2c_smbus_alert_setup *setup = dev_get_platdata(&ara->dev);
+	struct i2c_smbus_alert *alert;
+	struct i2c_adapter *adapter = ara->adapter;
+	int res, irq;
+
+	alert = devm_kzalloc(&ara->dev, sizeof(struct i2c_smbus_alert),
+			     GFP_KERNEL);
+	if (!alert)
+		return -ENOMEM;
+
+	if (setup) {
+		irq = setup->irq;
+	} else {
+		irq = of_irq_get_byname(adapter->dev.of_node, "smbus_alert");
+		if (irq <= 0)
+			return irq;
+	}
+
+	INIT_WORK(&alert->alert, smbalert_work);
+	alert->ara = ara;
+
+	if (irq > 0) {
+		res = devm_request_threaded_irq(&ara->dev, irq,
+						NULL, smbus_alert,
+						IRQF_SHARED | IRQF_ONESHOT,
+						"smbus_alert", alert);
+		if (res)
+			return res;
+	}
+
+	i2c_set_clientdata(ara, alert);
+	dev_info(&adapter->dev, "supports SMBALERT#\n");
+
+	return 0;
+}
+
+/* IRQ and memory resources are managed so they are freed automatically */
+static int smbalert_remove(struct i2c_client *ara)
+{
+	struct i2c_smbus_alert *alert = i2c_get_clientdata(ara);
+
+	cancel_work_sync(&alert->alert);
+	return 0;
+}
+
+static const struct i2c_device_id smbalert_ids[] = {
+	{ "smbus_alert", 0 },
+	{ /* LIST END */ }
+};
+MODULE_DEVICE_TABLE(i2c, smbalert_ids);
+
+static struct i2c_driver smbalert_driver = {
+	.driver = {
+		.name	= "smbus_alert",
+	},
+	.probe		= smbalert_probe,
+	.remove		= smbalert_remove,
+	.id_table	= smbalert_ids,
+};
+
+#if IS_ENABLED(CONFIG_OF)
+int of_i2c_setup_smbus_alert(struct i2c_adapter *adapter)
+{
+	struct i2c_client *client;
+	int irq;
+
+	irq = of_property_match_string(adapter->dev.of_node, "interrupt-names",
+				       "smbus_alert");
+	if (irq == -EINVAL || irq == -ENODATA)
+		return 0;
+	else if (irq < 0)
+		return irq;
+
+	client = i2c_setup_smbus_alert(adapter, NULL);
+	if (!client)
+		return -ENODEV;
+
+	return 0;
+}
+#endif
+
+/**
+ * i2c_handle_smbus_alert - Handle an SMBus alert
+ * @ara: the ARA client on the relevant adapter
+ * Context: can't sleep
+ *
+ * Helper function to be called from an I2C bus driver's interrupt
+ * handler. It will schedule the alert work, in turn calling the
+ * corresponding I2C device driver's alert function.
+ *
+ * It is assumed that ara is a valid i2c client previously returned by
+ * i2c_setup_smbus_alert().
+ */
+int i2c_handle_smbus_alert(struct i2c_client *ara)
+{
+	struct i2c_smbus_alert *alert = i2c_get_clientdata(ara);
+
+	return schedule_work(&alert->alert);
+}
+EXPORT_SYMBOL_GPL(i2c_handle_smbus_alert);
+
+int i2c_smbus_alert_add_driver(void)
+{
+	return i2c_add_driver(&smbalert_driver);
+}
+
+void i2c_smbus_alert_del_driver(void)
+{
+	i2c_del_driver(&smbalert_driver);
+}
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index f4c3b18..7f3ec02 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -625,25 +625,3 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
 	return i2c_new_device(adapter, &ara_board_info);
 }
 EXPORT_SYMBOL_GPL(i2c_setup_smbus_alert);
-
-#if IS_ENABLED(CONFIG_I2C_SMBUS_ALERT) && IS_ENABLED(CONFIG_OF)
-int of_i2c_setup_smbus_alert(struct i2c_adapter *adapter)
-{
-	struct i2c_client *client;
-	int irq;
-
-	irq = of_property_match_string(adapter->dev.of_node, "interrupt-names",
-				       "smbus_alert");
-	if (irq == -EINVAL || irq == -ENODATA)
-		return 0;
-	else if (irq < 0)
-		return irq;
-
-	client = i2c_setup_smbus_alert(adapter, NULL);
-	if (!client)
-		return -ENODEV;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(of_i2c_setup_smbus_alert);
-#endif
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 2ee5396..c6873f4 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -69,3 +69,16 @@ static inline int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
 	return 0;
 }
 #endif
+
+#if IS_ENABLED(CONFIG_I2C_SMBUS_ALERT)
+int i2c_smbus_alert_add_driver(void);
+void i2c_smbus_alert_del_driver(void);
+#else
+static inline int i2c_smbus_alert_add_driver(void)
+{
+	return 0;
+}
+static inline void i2c_smbus_alert_del_driver(void)
+{
+}
+#endif
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
deleted file mode 100644
index c11a50e..0000000
--- a/drivers/i2c/i2c-smbus.c
+++ /dev/null
@@ -1,218 +0,0 @@
-/*
- * i2c-smbus.c - SMBus extensions to the I2C protocol
- *
- * Copyright (C) 2008 David Brownell
- * Copyright (C) 2010 Jean Delvare <jdelvare@suse.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/device.h>
-#include <linux/i2c.h>
-#include <linux/i2c-smbus.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of_irq.h>
-#include <linux/slab.h>
-#include <linux/workqueue.h>
-
-#include "i2c-core.h"
-
-struct i2c_smbus_alert {
-	struct work_struct	alert;
-	struct i2c_client	*ara;		/* Alert response address */
-};
-
-struct alert_data {
-	unsigned short		addr;
-	enum i2c_alert_protocol	type;
-	unsigned int		data;
-};
-
-/* If this is the alerting device, notify its driver */
-static int smbus_do_alert(struct device *dev, void *addrp)
-{
-	struct i2c_client *client = i2c_verify_client(dev);
-	struct alert_data *data = addrp;
-	struct i2c_driver *driver;
-
-	if (!client || client->addr != data->addr)
-		return 0;
-	if (client->flags & I2C_CLIENT_TEN)
-		return 0;
-
-	/*
-	 * Drivers should either disable alerts, or provide at least
-	 * a minimal handler.  Lock so the driver won't change.
-	 */
-	device_lock(dev);
-	if (client->dev.driver) {
-		driver = to_i2c_driver(client->dev.driver);
-		if (driver->alert)
-			driver->alert(client, data->type, data->data);
-		else
-			dev_warn(&client->dev, "no driver alert()!\n");
-	} else
-		dev_dbg(&client->dev, "alert with no driver\n");
-	device_unlock(dev);
-
-	/* Stop iterating after we find the device */
-	return -EBUSY;
-}
-
-/*
- * The alert IRQ handler needs to hand work off to a task which can issue
- * SMBus calls, because those sleeping calls can't be made in IRQ context.
- */
-static irqreturn_t smbus_alert(int irq, void *d)
-{
-	struct i2c_smbus_alert *alert = d;
-	struct i2c_client *ara;
-	unsigned short prev_addr = 0;	/* Not a valid address */
-
-	ara = alert->ara;
-
-	for (;;) {
-		s32 status;
-		struct alert_data data;
-
-		/*
-		 * Devices with pending alerts reply in address order, low
-		 * to high, because of slave transmit arbitration.  After
-		 * responding, an SMBus device stops asserting SMBALERT#.
-		 *
-		 * Note that SMBus 2.0 reserves 10-bit addresses for future
-		 * use.  We neither handle them, nor try to use PEC here.
-		 */
-		status = i2c_smbus_read_byte(ara);
-		if (status < 0)
-			break;
-
-		data.data = status & 1;
-		data.addr = status >> 1;
-		data.type = I2C_PROTOCOL_SMBUS_ALERT;
-
-		if (data.addr == prev_addr) {
-			dev_warn(&ara->dev, "Duplicate SMBALERT# from dev "
-				"0x%02x, skipping\n", data.addr);
-			break;
-		}
-		dev_dbg(&ara->dev, "SMBALERT# from dev 0x%02x, flag %d\n",
-			data.addr, data.data);
-
-		/* Notify driver for the device which issued the alert */
-		device_for_each_child(&ara->adapter->dev, &data,
-				      smbus_do_alert);
-		prev_addr = data.addr;
-	}
-
-	return IRQ_HANDLED;
-}
-
-static void smbalert_work(struct work_struct *work)
-{
-	struct i2c_smbus_alert *alert;
-
-	alert = container_of(work, struct i2c_smbus_alert, alert);
-
-	smbus_alert(0, alert);
-}
-
-/* Setup SMBALERT# infrastructure */
-static int smbalert_probe(struct i2c_client *ara,
-			  const struct i2c_device_id *id)
-{
-	struct i2c_smbus_alert_setup *setup = dev_get_platdata(&ara->dev);
-	struct i2c_smbus_alert *alert;
-	struct i2c_adapter *adapter = ara->adapter;
-	int res, irq;
-
-	alert = devm_kzalloc(&ara->dev, sizeof(struct i2c_smbus_alert),
-			     GFP_KERNEL);
-	if (!alert)
-		return -ENOMEM;
-
-	if (setup) {
-		irq = setup->irq;
-	} else {
-		irq = of_irq_get_byname(adapter->dev.of_node, "smbus_alert");
-		if (irq <= 0)
-			return irq;
-	}
-
-	INIT_WORK(&alert->alert, smbalert_work);
-	alert->ara = ara;
-
-	if (irq > 0) {
-		res = devm_request_threaded_irq(&ara->dev, irq,
-						NULL, smbus_alert,
-						IRQF_SHARED | IRQF_ONESHOT,
-						"smbus_alert", alert);
-		if (res)
-			return res;
-	}
-
-	i2c_set_clientdata(ara, alert);
-	dev_info(&adapter->dev, "supports SMBALERT#\n");
-
-	return 0;
-}
-
-/* IRQ and memory resources are managed so they are freed automatically */
-static int smbalert_remove(struct i2c_client *ara)
-{
-	struct i2c_smbus_alert *alert = i2c_get_clientdata(ara);
-
-	cancel_work_sync(&alert->alert);
-	return 0;
-}
-
-static const struct i2c_device_id smbalert_ids[] = {
-	{ "smbus_alert", 0 },
-	{ /* LIST END */ }
-};
-MODULE_DEVICE_TABLE(i2c, smbalert_ids);
-
-static struct i2c_driver smbalert_driver = {
-	.driver = {
-		.name	= "smbus_alert",
-	},
-	.probe		= smbalert_probe,
-	.remove		= smbalert_remove,
-	.id_table	= smbalert_ids,
-};
-
-/**
- * i2c_handle_smbus_alert - Handle an SMBus alert
- * @ara: the ARA client on the relevant adapter
- * Context: can't sleep
- *
- * Helper function to be called from an I2C bus driver's interrupt
- * handler. It will schedule the alert work, in turn calling the
- * corresponding I2C device driver's alert function.
- *
- * It is assumed that ara is a valid i2c client previously returned by
- * i2c_setup_smbus_alert().
- */
-int i2c_handle_smbus_alert(struct i2c_client *ara)
-{
-	struct i2c_smbus_alert *alert = i2c_get_clientdata(ara);
-
-	return schedule_work(&alert->alert);
-}
-EXPORT_SYMBOL_GPL(i2c_handle_smbus_alert);
-
-module_i2c_driver(smbalert_driver);
-
-MODULE_AUTHOR("Jean Delvare <jdelvare@suse.de>");
-MODULE_DESCRIPTION("SMBus protocol extensions support");
-MODULE_LICENSE("GPL");
-- 
1.8.3.1
