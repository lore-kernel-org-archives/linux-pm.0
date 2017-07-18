From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v8 7/9] power: Adds support for Smart Battery System Manager
Date: Tue, 18 Jul 2017 16:19:42 +0800
Message-ID: <1500365984-61404-8-git-send-email-preid@electromag.com.au>
References: <1500365984-61404-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500365984-61404-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>, Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>

This patch adds support for Smart Battery System Manager.
A SBSM is a device listening at I2C/SMBus address 0x0a and is capable of
communicating up to four I2C smart battery devices. All smart battery
devices are listening at address 0x0b, so the SBSM muliplexes between
them. The driver makes use of the I2C-Mux framework to allow smart
batteries to be bound via device tree, i.e. the sbs-battery driver.

Via sysfs interface the online state and charge type are presented. If
the driver is bound as ltc1760 (an implementation of a Dual Smart Battery
System Manager) the charge type can also be changed from trickle to fast.

Signed-off-by: Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>
Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---
 drivers/power/supply/Kconfig       |  13 ++
 drivers/power/supply/Makefile      |   1 +
 drivers/power/supply/sbs-manager.c | 323 +++++++++++++++++++++++++++++++++++++
 3 files changed, 337 insertions(+)
 create mode 100644 drivers/power/supply/sbs-manager.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 969f500..e7e16ec 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -184,6 +184,19 @@ config CHARGER_SBS
         help
 	  Say Y to include support for SBS compilant battery chargers.
 
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
 config BATTERY_BQ27XXX
 	tristate "BQ27xxx battery driver"
 	help
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index a41f409..2958807 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_BATTERY_IPAQ_MICRO) += ipaq_micro_battery.o
 obj-$(CONFIG_BATTERY_WM97XX)	+= wm97xx_battery.o
 obj-$(CONFIG_BATTERY_SBS)	+= sbs-battery.o
 obj-$(CONFIG_CHARGER_SBS)	+= sbs-charger.o
+obj-$(CONFIG_MANAGER_SBS)	+= sbs-manager.o
 obj-$(CONFIG_BATTERY_BQ27XXX)	+= bq27xxx_battery.o
 obj-$(CONFIG_BATTERY_BQ27XXX_I2C) += bq27xxx_battery_i2c.o
 obj-$(CONFIG_BATTERY_DA9030)	+= da9030_battery.o
diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
new file mode 100644
index 0000000..47c09a1
--- /dev/null
+++ b/drivers/power/supply/sbs-manager.c
@@ -0,0 +1,323 @@
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
+ * Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>
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
+#define SBSM_MASK_BAT_SUPPORTED  GENMASK(3, 0)
+#define SBSM_MASK_CHARGE_BAT     GENMASK(7, 4)
+#define SBSM_BIT_AC_PRESENT      BIT(0)
+#define SBSM_BIT_TURBO           BIT(7)
+
+#define SBSM_SMB_BAT_OFFSET      11
+struct sbsm_data {
+	struct i2c_client *client;
+	struct i2c_mux_core *muxc;
+
+	struct power_supply *psy;
+
+	u8 cur_chan;          /* currently selected channel */
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
+	int reg, retries;
+
+	for (retries = SBSM_RETRY_CNT; retries > 0; retries--) {
+		reg = i2c_smbus_read_word_data(client, address);
+		if (reg >= 0)
+			break;
+	}
+
+	if (reg < 0) {
+		dev_err(&client->dev, "failed to read register 0x%02x\n",
+			address);
+	}
+
+	return reg;
+}
+
+static int sbsm_write_word(struct i2c_client *client, u8 address, u16 word)
+{
+	int ret, retries;
+
+	for (retries = SBSM_RETRY_CNT; retries > 0; retries--) {
+		ret = i2c_smbus_write_word_data(client, address, word);
+		if (ret >= 0)
+			break;
+	}
+	if (ret < 0)
+		dev_err(&client->dev, "failed to write to register 0x%02x\n",
+			address);
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
+		val->intval = !!(regval & SBSM_BIT_AC_PRESENT);
+		break;
+
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		regval = sbsm_read_word(data->client, SBSM_CMD_BATSYSSTATE);
+		if (regval < 0)
+			return regval;
+
+		if ((regval & SBSM_MASK_CHARGE_BAT) == 0) {
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
+			else if (regval & SBSM_BIT_TURBO)
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
+	u16 regval;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		/* write 1 to TURBO if type fast is given */
+		if (!data->is_ltc1760)
+			break;
+		regval = val->intval ==
+			 POWER_SUPPLY_CHARGE_TYPE_FAST ? SBSM_BIT_TURBO : 0;
+		ret = sbsm_write_word(data->client, SBSM_CMD_LTC, regval);
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
+	struct device *dev = &data->client->dev;
+	int ret = 0;
+	u16 reg;
+
+	if (data->cur_chan == chan)
+		return ret;
+
+	/* chan goes from 1 ... 4 */
+	reg = 1 << BIT(SBSM_SMB_BAT_OFFSET + chan);
+	ret = sbsm_write_word(data->client, SBSM_CMD_BATSYSSTATE, reg);
+	if (ret)
+		dev_err(dev, "Failed to select channel %i\n", chan);
+	else
+		data->cur_chan = chan;
+
+	return ret;
+}
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
+		return -EINVAL;
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
+	supported_bats = ret & SBSM_MASK_BAT_SUPPORTED;
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
+		if (supported_bats & BIT(i)) {
+			ret = i2c_mux_add_adapter(data->muxc, 0, i + 1, 0);
+			if (ret)
+				break;
+		}
+	}
+	if (ret) {
+		dev_err(dev, "failed to register i2c mux channel %d\n", i + 1);
+		goto err_mux_register;
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
+	psy_cfg.of_node = dev->of_node;
+	data->psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
+	if (IS_ERR(data->psy)) {
+		ret = PTR_ERR(data->psy);
+		dev_err(dev, "failed to register power supply %s\n",
+			psy_desc->name);
+		goto err_psy;
+	}
+
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
+#ifdef CONFIG_OF
+static const struct of_device_id sbsm_dt_ids[] = {
+	{ .compatible = "sbs,sbs-manager" },
+	{ .compatible = "lltc,ltc1760" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sbsm_dt_ids);
+#endif
+
+static struct i2c_driver sbsm_driver = {
+	.driver = {
+		.name = "sbsm",
+		.of_match_table = of_match_ptr(sbsm_dt_ids),
+	},
+	.probe		= sbsm_probe,
+	.remove		= sbsm_remove,
+	.id_table	= sbsm_ids
+};
+module_i2c_driver(sbsm_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>");
+MODULE_DESCRIPTION("SBSM Smart Battery System Manager");
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
