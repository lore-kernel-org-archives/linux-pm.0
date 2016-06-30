From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: [PATCH v2 2/2] power: Adds support for Smart Battery System Manager
Date: Thu, 30 Jun 2016 22:05:42 +0200
Message-ID: <1467317142-14063-3-git-send-email-karl-heinz@schneider-inet.de>
References: <1bFnWI-0000MX-9R>
 <1467317142-14063-1-git-send-email-karl-heinz@schneider-inet.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from schneider-inet.de ([85.214.76.205]:35518 "EHLO
	h1714509.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbcF3UGJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2016 16:06:09 -0400
In-Reply-To: <1467317142-14063-1-git-send-email-karl-heinz@schneider-inet.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>, Karl-Heinz Schneider <karl-heinz@schneider-inet.de>

This patch adds support for Smart Battery System Manager.
A SBSM is a device listening at I2C/SMBus address 0x0a and is capable of
communicating up to four I2C smart battery devices. All smart battery
devices are listening at address 0x0b, so the SBSM muliplexes between
them. The driver makes use of the I2C-Mux framework to allow smart
batteries to be bound via device tree, i.e. the sbs-battery driver.

Via sysfs interface the online state and charge type are presented. If
the driver is bound as ltc1760 (an implementation of a Dual Smart Battery
System Manager) the charge type can also be changed from trickle to fast.

Tested-by: Phil Reid <preid@electromag.com.au>
Reviewed-by: Phil Reid <preid@electromag.com.au>
Signed-off-by: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
---
 drivers/power/Kconfig       |  13 ++
 drivers/power/Makefile      |   1 +
 drivers/power/sbs-manager.c | 324 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 338 insertions(+)
 create mode 100644 drivers/power/sbs-manager.c

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 421770d..7c561bf 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -157,6 +157,19 @@ config BATTERY_WM97XX
 	help
 	  Say Y to enable support for battery measured by WM97xx aux port.

+config MANAGER_SBS
+	tristate "Smart Battery System Manager"
+	depends on I2C && I2C_MUX
+	help
+	  Say Y here to include support for Smart Battery System Manager
+	  ICs. The driver reports online and charging status via sysfs.
+	  It presents itself also as I2C mux which allows to bind
+	  smart battery driver to its ports.
+	  Supported is for example LTC1760.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called sbs-manager.
+
 config BATTERY_SBS
         tristate "SBS Compliant gas gauge"
         depends on I2C
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index e46b75d..5378e65 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
 obj-$(CONFIG_BATTERY_DS2780)	+= ds2780_battery.o
 obj-$(CONFIG_BATTERY_DS2781)	+= ds2781_battery.o
 obj-$(CONFIG_BATTERY_DS2782)	+= ds2782_battery.o
+obj-$(CONFIG_MANAGER_SBS)	+= sbs-manager.o
 obj-$(CONFIG_BATTERY_GAUGE_LTC2941)	+= ltc2941-battery-gauge.o
 obj-$(CONFIG_BATTERY_GOLDFISH)	+= goldfish_battery.o
 obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
diff --git a/drivers/power/sbs-manager.c b/drivers/power/sbs-manager.c
new file mode 100644
index 0000000..614edcc
--- /dev/null
+++ b/drivers/power/sbs-manager.c
@@ -0,0 +1,324 @@
+/*
+ * Driver for SBS compliant Smart Battery System Managers
+ *
+ * The device communicates via i2c at address 0x0a and multiplexes access to up
+ * to four smart batteries at address 0x0b.
+ *
+ * Via sysfs interface the online state and charge type are presented.
+ *
+ * Datasheet SBSM:    http://sbs-forum.org/specs/sbsm100b.pdf
+ * Datasheet LTC1760: http://cds.linear.com/docs/en/datasheet/1760fb.pdf
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
+#define SBSM_MAX_BATS  4
+#define SBSM_RETRY_CNT 3
+
+/* registers addresses */
+#define SBSM_CMD_BATSYSSTATE     0x01
+#define SBSM_CMD_BATSYSSTATECONT 0x02
+#define SBSM_CMD_BATSYSINFO      0x04
+#define SBSM_CMD_LTC             0x3c
+
+struct sbsm_data {
+	struct i2c_client *client;
+	struct i2c_mux_core *muxc;
+
+	struct power_supply *psy;
+
+	int cur_chan;         /* currently selected channel */
+	bool is_ltc1760;      /* special capabilities */
+};
+
+static enum power_supply_property sbsm_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+};
+
+static int sbsm_read_word(struct i2c_client *client, u8 address)
+{
+	int reg, retries = SBSM_RETRY_CNT;
+
+	while (retries > 0) {
+		reg = i2c_smbus_read_word_data(client, address);
+		if (reg >= 0)
+			break;
+		--retries;
+	}
+
+	if (reg < 0) {
+		dev_err(&client->dev, "failed to read register %i\n",
+			(int)address);
+		return reg;
+	}
+
+	return le16_to_cpu(reg);
+}
+
+static int sbsm_write_word(struct i2c_client *client, u8 address, u16 word)
+{
+	int ret, retries = SBSM_RETRY_CNT;
+
+	word = cpu_to_le16(word);
+	while (retries > 0) {
+		ret = i2c_smbus_write_word_data(client, address, word);
+		if (ret >= 0)
+			break;
+		--retries;
+	}
+	if (ret < 0)
+		dev_err(&client->dev, "failed to write to register %i\n",
+			(int)address);
+
+	return ret;
+}
+
+static int sbsm_get_property(struct power_supply *psy,
+			     enum power_supply_property psp,
+			     union power_supply_propval *val)
+{
+	struct sbsm_data *data = power_supply_get_drvdata(psy);
+	int regval = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		regval = sbsm_read_word(data->client, SBSM_CMD_BATSYSSTATECONT);
+		if (regval < 0)
+			return regval;
+		val->intval = !!(regval & 0x1);
+		break;
+
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		regval = sbsm_read_word(data->client, SBSM_CMD_BATSYSSTATE);
+		if (regval < 0)
+			return regval;
+
+		if ((regval & 0x00f0) == 0) {
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
+			return 0;
+		}
+		val->intval = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+
+		if (data->is_ltc1760) {
+			/* charge mode fast if turbo is active */
+			regval = sbsm_read_word(data->client, SBSM_CMD_LTC);
+			if (regval < 0)
+				return regval;
+			else if (regval & 0x80)
+				val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sbsm_prop_is_writeable(struct power_supply *psy,
+				  enum power_supply_property psp)
+{
+	struct sbsm_data *data = power_supply_get_drvdata(psy);
+
+	return (psp == POWER_SUPPLY_PROP_CHARGE_TYPE) && data->is_ltc1760;
+}
+
+static int sbsm_set_property(struct power_supply *psy,
+			     enum power_supply_property psp,
+			     const union power_supply_propval *val)
+{
+	struct sbsm_data *data = power_supply_get_drvdata(psy);
+	int ret = -EINVAL;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		/* write 1 to TURBO if type fast is given */
+		if (data->is_ltc1760) {
+			u16 regval = val->intval ==
+			POWER_SUPPLY_CHARGE_TYPE_FAST ? (0x1 << 7) : 0;
+			ret = sbsm_write_word(data->client, SBSM_CMD_LTC,
+					      regval);
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * Switch to battery
+ * Parameter chan is directly the content of SMB_BAT* nibble
+ */
+static int sbsm_select(struct i2c_mux_core *muxc, u32 chan)
+{
+	struct sbsm_data *data = i2c_mux_priv(muxc);
+	int ret = 0;
+
+	if (data->cur_chan == chan)
+		return ret;
+
+	ret = sbsm_write_word(data->client, SBSM_CMD_BATSYSSTATE, chan << 12);
+	if (ret)
+		dev_err(&data->client->dev, "Failed to select channel %i\n",
+			chan);
+	else
+		data->cur_chan = chan;
+
+	return ret;
+}
+
+#if defined(CONFIG_OF)
+
+#include <linux/of_device.h>
+
+static const struct of_device_id sbsm_dt_ids[] = {
+	{ .compatible = "sbs,sbs-manager" },
+	{ .compatible = "lltc,ltc1760" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sbsm_dt_ids);
+
+#endif
+
+static const struct power_supply_desc sbsm_default_psy_desc = {
+	.type = POWER_SUPPLY_TYPE_MAINS,
+	.properties = sbsm_props,
+	.num_properties = ARRAY_SIZE(sbsm_props),
+	.get_property = &sbsm_get_property,
+	.set_property = &sbsm_set_property,
+	.property_is_writeable = &sbsm_prop_is_writeable,
+};
+
+static int sbsm_probe(struct i2c_client *client,
+		      const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct sbsm_data *data;
+	struct device *dev = &client->dev;
+	struct power_supply_desc *psy_desc;
+	struct power_supply_config psy_cfg = {};
+	int ret = 0, i, supported_bats;
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
+
+	data->client = client;
+	data->is_ltc1760 = !!strstr(id->name, "ltc1760");
+
+	ret  = sbsm_read_word(client, SBSM_CMD_BATSYSINFO);
+	if (ret < 0)
+		return ret;
+	supported_bats = le16_to_cpu(ret) & 0xf;
+
+	data->muxc = i2c_mux_alloc(adapter, dev, SBSM_MAX_BATS, 0,
+				   I2C_MUX_LOCKED, &sbsm_select, NULL);
+	if (!data->muxc) {
+		dev_err(dev, "failed to alloc i2c mux\n");
+		ret = -ENOMEM;
+		goto err_mux_alloc;
+	}
+	data->muxc->priv = data;
+
+	/* register muxed i2c channels. One for each supported battery */
+	for (i = 0; i < SBSM_MAX_BATS; ++i) {
+		uint chan = 1 << i;
+
+		if (chan & supported_bats) {
+			ret = i2c_mux_add_adapter(data->muxc, 0, chan, 0);
+			if (ret) {
+				dev_err(dev,
+					"failed to register i2c mux channel %d\n",
+					chan);
+				goto err_mux_register;
+			}
+		}
+	}
+
+	psy_desc = devm_kmemdup(dev, &sbsm_default_psy_desc,
+				sizeof(struct power_supply_desc),
+				GFP_KERNEL);
+	if (!psy_desc) {
+		ret = -ENOMEM;
+		goto err_psy;
+	}
+
+	psy_desc->name = devm_kasprintf(dev, GFP_KERNEL, "sbsm-%s",
+					dev_name(&client->dev));
+	if (!psy_desc->name) {
+		ret = -ENOMEM;
+		goto err_psy;
+	}
+
+	psy_cfg.drv_data = data;
+	data->psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
+	if (IS_ERR(data->psy)) {
+		ret = PTR_ERR(data->psy);
+		dev_err(dev, "failed to register power supply %s\n",
+			psy_desc->name);
+		goto err_psy;
+	}
+
+	dev_info(dev, "sbsm registered\n");
+	return 0;
+
+err_psy:
+err_mux_register:
+	i2c_mux_del_adapters(data->muxc);
+
+err_mux_alloc:
+	return ret;
+}
+
+static int sbsm_remove(struct i2c_client *client)
+{
+	struct sbsm_data *data = i2c_get_clientdata(client);
+
+	i2c_mux_del_adapters(data->muxc);
+	return 0;
+}
+
+static const struct i2c_device_id sbsm_ids[] = {
+	{ "sbs-manager", 0 },
+	{ "ltc1760",     0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sbsm_ids);
+
+static struct i2c_driver sbsm_driver = {
+	.driver = {
+		.name = "sbsm",
+		.owner = THIS_MODULE,
+	},
+	.probe		= sbsm_probe,
+	.remove		= sbsm_remove,
+	.id_table	= sbsm_ids
+};
+module_i2c_driver(sbsm_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Karl-Heinz Schneider <karl-heinz@schneider-inet.de>");
+MODULE_DESCRIPTION("SBSM Smart Battery System Manager");
--
1.9.1
