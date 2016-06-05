From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: [PATCH] power: Add support for LTC1760 Dual Smart Battery System
 Manager
Date: Sun, 05 Jun 2016 22:55:29 +0200
Message-ID: <1465160129.17905.24.camel@amnesix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, peda@axentia.se, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org

This driver adds support for the LTC1760 Dual Smart Battery System
Manager.
The LTC1760 is an I2C device listening at address 0x0a and is capable of
communicating up to two I2C smart battery devices. Both smart battery
devices are listening at address 0x0b, so the LTC1760 muliplexes between
them. The driver makes use of the I2C-Mux framework to allow smart
batteries to be bound via device tree, i.e. the sbs-battery driver.

Via sysfs interface the online state and charge type are presented where
the charge type can also be changed between the default value "trickle"
and
"fast".

Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
---
Path generated against v4.7-rc1

 .../devicetree/bindings/power/ltc1760.txt          |  42 +++
 drivers/power/Kconfig                              |  12 +
 drivers/power/Makefile                             |   1 +
 drivers/power/ltc1760-dual-battery-charger.c       | 316
+++++++++++++++++++++
 4 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/ltc1760.txt
 create mode 100644 drivers/power/ltc1760-dual-battery-charger.c

diff --git a/Documentation/devicetree/bindings/power/ltc1760.txt
b/Documentation/devicetree/bindings/power/ltc1760.txt
new file mode 100644
index 0000000..b948a32
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/ltc1760.txt
@@ -0,0 +1,42 @@
+Binding for LTC1760 Dual Smart Battery System Manager
+
+Required properties:
+- compatible: should be "ltc1760"
+- reg: integer, i2c address of the device. Should be <0xa>.
+
+The device is basically an i2c-mux used to communicate with
+two smart battery devices at address 0xb. The driver actually
+implements this behaviour. So standard i2c-mux nodes can be
+used to register up to two slave batteries.
+
+Example:
+
+batman@0a {
+    compatible = "ltc1760";
+    reg = <0x0a>;
+
+    #address-cells = <1>;
+    #size-cells = <0>;
+
+    i2c-battery1@1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <1>;
+
+        battery1@0b {
+            compatible = "sbs-battery";
+            reg = <0x0b>;
+        };
+    };
+
+    i2c-battery2@2 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <2>;
+
+        battery2@0b {
+            compatible = "sbs-battery";
+            reg = <0x0b>;
+        };
+    };
+};
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 421770d..1f56a04 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -351,6 +351,18 @@ config CHARGER_GPIO
 	  This driver can be build as a module. If so, the module will be
 	  called gpio-charger.
 
+config CHARGER_LTC1760
+	tristate "LTC1760 Dual Battery Charger Driver"
+	depends on I2C
+	help
+	  Say Y here to include support for LTC1760 Dual Battery Charger
+	  IC. The driver reports online and charging status via sysfs.
+	  It presents itself also as I2C two port mux which allows to bind
+	  smart battery driver to its ports.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ltc1760-charger.
+
 config CHARGER_MANAGER
 	bool "Battery charger manager for multiple chargers"
 	depends on REGULATOR
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index e46b75d..fc3f43d 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
 obj-$(CONFIG_BATTERY_DS2780)	+= ds2780_battery.o
 obj-$(CONFIG_BATTERY_DS2781)	+= ds2781_battery.o
 obj-$(CONFIG_BATTERY_DS2782)	+= ds2782_battery.o
+obj-$(CHARGER_LTC1760)		+= ltc1760-dual-battery-charger.o
 obj-$(CONFIG_BATTERY_GAUGE_LTC2941)	+= ltc2941-battery-gauge.o
 obj-$(CONFIG_BATTERY_GOLDFISH)	+= goldfish_battery.o
 obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
diff --git a/drivers/power/ltc1760-dual-battery-charger.c
b/drivers/power/ltc1760-dual-battery-charger.c
new file mode 100644
index 0000000..74b0ec5
--- /dev/null
+++ b/drivers/power/ltc1760-dual-battery-charger.c
@@ -0,0 +1,316 @@
+/*
+ * Driver for the Linear Technology LTC1760 Dual Smart Battery System
Manager
+ *
+ * The device communicates via i2c at address 0x0a and multiplexes
access up to
+ * two smart batteries at the address 0x0b.
+ *
+ * The two batteries can be charged if external power supply is
connected or the
+ * batteries can be equally discharged at the same time if they provide
(nearly)
+ * equal voltage.
+ *
+ * Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/i2c-mux.h>
+#include <linux/power_supply.h>
+
+/* registers addresses */
+#define LTC1760_CMD_BATSYSSTATE     0x01
+#define LTC1760_CMD_BATSYSSTATECONT 0x02
+#define LTC1760_CMD_LTC             0x3c
+
+struct ltc1760_data {
+	struct i2c_client *client;
+	struct power_supply psy;
+
+	struct i2c_adapter *bat_muxes[2];
+	int    cur_chan;         /* currently selected channel */
+
+	struct mutex update_mtx; /* serialize access to cached values */
+	ulong last_update;
+	bool valid;
+	int ignore_requests;
+
+	/* cached register values */
+	u16 bat_sys_state;
+	u16 bat_sys_state_cont;
+	u16 ltc;
+};
+
+static enum power_supply_property ltc1760_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+};
+
+/*
+ * Read out devices registers. Return 0 on success else negative error
code.
+ *
+ * The ltc may stretch i2c clock, if it is communicating with smart
batteries.
+ * This may result in communication timouts from our side.
+ */
+static int ltc1760_update_cache(struct ltc1760_data *data)
+{
+	int reg;
+
+	reg = i2c_smbus_read_word_data(data->client, LTC1760_CMD_BATSYSSTATE);
+	if (reg < 0)
+		goto err;
+	data->bat_sys_state = (u16)reg;
+
+	reg = i2c_smbus_read_word_data(data->client,
+				       LTC1760_CMD_BATSYSSTATECONT);
+	if (reg < 0)
+		goto err;
+	data->bat_sys_state_cont = (u16)reg;
+
+	reg = i2c_smbus_read_word_data(data->client, LTC1760_CMD_LTC);
+	if (reg < 0)
+		goto err;
+	data->ltc = (u16)reg;
+
+	return 0;
+
+err:
+	dev_dbg(&data->client->dev, "Failed to read out register\n");
+	return reg;
+}
+
+static void ltc1760_update(struct ltc1760_data *data)
+{
+	if (data->ignore_requests > 0) {
+		data->ignore_requests--;
+		return;
+	}
+
+	mutex_lock(&data->update_mtx);
+	if (time_after(jiffies, data->last_update + HZ) || !data->valid) {
+		if (!ltc1760_update_cache(data)) {
+			data->valid = true;
+			data->last_update = jiffies;
+		}
+	}
+	mutex_unlock(&data->update_mtx);
+}
+
+static int ltc1760_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct ltc1760_data *data = container_of(psy, struct ltc1760_data,
psy);
+
+	ltc1760_update(data);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = !!(data->bat_sys_state_cont & 0x1);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		if (data->bat_sys_state & 0x00f0) {
+			/* charge mode fast if turbo is active */
+			val->intval = (data->ltc & 0x80)
+				? POWER_SUPPLY_CHARGE_TYPE_FAST
+				: POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		} else {
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ltc1760_prop_is_writeable(struct power_supply *psy,
+				     enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_CHARGE_TYPE;
+}
+
+static int ltc1760_set_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				const union power_supply_propval *val)
+{
+	struct ltc1760_data *data = container_of(psy, struct ltc1760_data,
psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		mutex_lock(&data->update_mtx);
+		/* write 1 to TURBO if type fast is given */
+		i2c_smbus_write_word_data(
+			data->client, LTC1760_CMD_LTC,
+			(val->intval == POWER_SUPPLY_CHARGE_TYPE_FAST)
+			? (0x1 << 7) : 0);
+		data->valid = false;
+		mutex_unlock(&data->update_mtx);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * Write to mux register. Don't use i2c_transfer()/i2c_smbus_xfer()
+ * for this as they will try to lock adapter a second time
+ */
+static int ltc1760_write_select_bat_reg(struct i2c_adapter *adap,
+					struct i2c_client *client, u8 chan)
+{
+	int ret;
+
+	if (adap->algo->master_xfer) {
+		char buf[3] = { LTC1760_CMD_BATSYSSTATE, 0, chan << 4 };
+		struct i2c_msg msg = {397
+			.addr = client->addr;
+			.flags = 0;
+			.len = sizeof(buf);
+			.buf = buf;
+		};
+		ret = adap->algo->master_xfer(adap, &msg, 1);
+	} else {
+		union i2c_smbus_data data = {
+			.word = (chan << 12);
+		};
+		ret = adap->algo->smbus_xfer(
+			adap, client->addr,
+			client->flags,
+			I2C_SMBUS_WRITE,
+			LTC1760_CMD_BATSYSSTATE,
+			I2C_SMBUS_WORD_DATA,
+			&data);
+	}
+
+	return ret;
+}
+
+/*
+ * Switch to battery
+ * Parameter chan is directly the content of SMB_BAT* nibble
+ */
+static int ltc1760_select(struct i2c_adapter *adap, void *client, u32
chan)
+{
+	struct ltc1760_data *data = i2c_get_clientdata(client);
+	int ret = 0;
+
+	if (data->cur_chan != chan) {
+		ret = ltc1760_write_select_bat_reg(adap, client, chan);
+		if (ret < 0) {
+			data->cur_chan = 0; /* invalid */
+			return ret;
+		}
+		data->cur_chan = chan;
+	}
+
+	return ret;
+}
+
+static int ltc1760_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct ltc1760_data *data;
+	struct device *dev = &client->dev;
+	int ret = 0, i;
+
+	/* Device listens only at address 0x0a */
+	if (client->addr != 0x0a)
+		return -ENODEV;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -EPFNOSUPPORT;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	data->client = client;
+	data->cur_chan = 0; /* 0 is invalid. Force selection next time */
+
+	mutex_init(&data->update_mtx);
+
+	/* register muxed i2c channels */
+	for (i = 0; i < 2; ++i) {
+		data->bat_muxes[i] =
+			i2c_add_mux_adapter(adapter, &client->dev,
+					    client,
+					    0, 0x1 << i,
+					    0, &ltc1760_select, NULL);
+		if (!data->bat_muxes[i]) {
+			dev_err(dev, "failed to register mux\n");
+			ret = -ENODEV;
+			goto err_mux;
+		}
+	}
+
+	data->psy.name = "ac";
+	data->psy.type = POWER_SUPPLY_TYPE_MAINS;
+	data->psy.properties = ltc1760_props;
+	data->psy.num_properties = ARRAY_SIZE(ltc1760_props);
+	data->psy.get_property = &ltc1760_get_property;
+	data->psy.set_property = &ltc1760_set_property;
+	data->psy.property_is_writeable = &ltc1760_prop_is_writeable;
+
+	/* ignore first request, started by power_supply_register() */
+	data->ignore_requests = 1;
+
+	ret = power_supply_register(dev, &data->psy);
+	if (ret) {
+		dev_err(dev, "failed to register %s power supply\n",
+			data->psy.name);
+		goto err_psy;
+	}
+
+	dev_info(dev, "registered ltc1760 at i2c address 0x0a\n");
+
+	return 0;
+
+err_psy:
+err_mux:
+	for (--i ; i >= 0; --i)
+		i2c_del_mux_adapter(data->bat_muxes[i]);
+	return ret;
+}
+
+static int ltc1760_remove(struct i2c_client *client)
+{
+	struct ltc1760_data *data = i2c_get_clientdata(client);
+	int i;
+
+	power_supply_unregister(&data->psy);
+
+	for (i = 0; i < 2; ++i)
+		i2c_del_mux_adapter(data->bat_muxes[i]);
+
+	mutex_destroy(&data->update_mtx);
+
+	return 0;
+}
+
+static const struct i2c_device_id ltc1760_ids[] = {
+	{ "ltc1760", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ltc1760_ids);
+
+static struct i2c_driver ltc1760_driver = {
+	.driver = {
+		.name = "ltc1760",
+		.owner = THIS_MODULE,
+	},
+	.probe		= ltc1760_probe,
+	.remove		= ltc1760_remove,
+	.id_table	= ltc1760_ids
+};
+module_i2c_driver(ltc1760_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Karl-Heinz Schneider <karl-heinz@schneider-inet.de>")
+MODULE_DESCRIPTION("LTC1760 Dual Smart Battery System Manager");
-- 
1.9.1
