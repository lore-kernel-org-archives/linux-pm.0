From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v5 9/9] power: supply: sbs-manager: Add alert callback and battery change notification
Date: Mon,  1 May 2017 16:49:59 +0800
Message-ID: <1493628599-30552-10-git-send-email-preid@electromag.com.au>
References: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, peda@axentia.se, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This adds smb alert support via the smbus_alert driver to generate
power_supply_changed notifications when either external power is
removed / applied or a battery inserted / removed.
Use the i2c alert callback to notify the attached battery driver that a
change has occurred.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/power/supply/Kconfig       |   1 +
 drivers/power/supply/sbs-manager.c | 129 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 8aa5324..a25359c 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -536,6 +536,7 @@ config AXP20X_POWER
 config MANAGER_SBS
 	tristate "Smart Battery System Manager"
 	depends on I2C && I2C_MUX
+	select I2C_SMBUS
 	help
 	  Say Y here to include support for Smart Battery System Manager
 	  ICs. The driver reports online and charging status via sysfs.
diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
index adf9e41..d7f7a92 100644
--- a/drivers/power/supply/sbs-manager.c
+++ b/drivers/power/supply/sbs-manager.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
+#include <linux/gpio.h>
 #include <linux/power_supply.h>
 
 #define SBSM_MAX_BATS  4
@@ -30,14 +31,22 @@
 #define SBSM_CMD_BATSYSINFO      0x04
 #define SBSM_CMD_LTC             0x3c
 
+#define SBSM_BIT_AC_PRESENT      BIT(0)
+
 struct sbsm_data {
 	struct i2c_client *client;
 	struct i2c_mux_core *muxc;
 
 	struct power_supply *psy;
 
+	struct gpio_chip chip;
+
 	int cur_chan;         /* currently selected channel */
 	bool is_ltc1760;      /* special capabilities */
+
+	unsigned int supported_bats;
+	unsigned int last_state;
+	unsigned int last_state_cont;
 };
 
 static enum power_supply_property sbsm_props[] = {
@@ -184,6 +193,116 @@ static int sbsm_select(struct i2c_mux_core *muxc, u32 chan)
 	return ret;
 }
 
+static int sbsm_gpio_get_value(struct gpio_chip *gc, unsigned off)
+{
+	struct sbsm_data *data = gpiochip_get_data(gc);
+	int ret;
+
+	ret = sbsm_read_word(data->client, SBSM_CMD_BATSYSSTATE);
+	if (ret < 0)
+		return ret;
+
+	return ret & BIT(off);
+}
+
+/*
+ * This needs to be defined or the GPIO lib fails to register the pin.
+ * But the 'gpio' is always an input.
+ */
+static int sbsm_gpio_direction_input(struct gpio_chip *gc, unsigned off)
+{
+	return 0;
+}
+
+static int sbsm_do_alert(struct device *dev, void *d)
+{
+	struct i2c_client *client = i2c_verify_client(dev);
+	struct i2c_driver *driver;
+
+	if (!client || client->addr != 0x0b)
+		return 0;
+
+	device_lock(dev);
+	if (client->dev.driver) {
+		driver = to_i2c_driver(client->dev.driver);
+		if (driver->alert)
+			driver->alert(client, I2C_PROTOCOL_SMBUS_ALERT, 0);
+		else
+			dev_warn(&client->dev, "no driver alert()!\n");
+	} else
+		dev_dbg(&client->dev, "alert with no driver\n");
+	device_unlock(dev);
+
+	return -EBUSY;
+}
+
+static void sbsm_alert(struct i2c_client *client, enum i2c_alert_protocol prot,
+		       unsigned int d)
+{
+	struct sbsm_data *sbsm = i2c_get_clientdata(client);
+
+	int ret, i, irq_bat = 0;
+
+	ret = sbsm_read_word(sbsm->client, SBSM_CMD_BATSYSSTATE);
+	if (ret >= 0)
+		irq_bat = ret ^ sbsm->last_state;
+	sbsm->last_state = ret;
+
+	ret = sbsm_read_word(sbsm->client, SBSM_CMD_BATSYSSTATECONT);
+	if ((ret >= 0) &&
+	    ((ret ^ sbsm->last_state_cont) & SBSM_BIT_AC_PRESENT)) {
+		irq_bat |= sbsm->supported_bats;
+		power_supply_changed(sbsm->psy);
+	}
+	sbsm->last_state_cont = ret;
+
+	for (i = 0; i < SBSM_MAX_BATS; i++) {
+		if (irq_bat & BIT(i)) {
+			device_for_each_child(&sbsm->muxc->adapter[i]->dev,
+					      NULL, sbsm_do_alert);
+		}
+	}
+}
+
+static int sbsm_gpio_setup(struct sbsm_data *data)
+{
+	struct gpio_chip *gc = &data->chip;
+	struct i2c_client *client = data->client;
+	struct device *dev = &client->dev;
+	struct device_node *of_node = client->dev.of_node;
+	int ret;
+
+	if (!of_get_property(of_node, "gpio-controller", NULL))
+		return 0;
+
+	ret  = sbsm_read_word(client, SBSM_CMD_BATSYSSTATE);
+	if (ret < 0)
+		return ret;
+	data->last_state = ret;
+
+	ret  = sbsm_read_word(client, SBSM_CMD_BATSYSSTATECONT);
+	if (ret < 0)
+		return ret;
+	data->last_state_cont = ret;
+
+	gc->get = sbsm_gpio_get_value;
+	gc->direction_input  = sbsm_gpio_direction_input;
+	gc->can_sleep = true;
+	gc->base = -1;
+	gc->ngpio = SBSM_MAX_BATS;
+	gc->label = client->name;
+	gc->parent = dev;
+	gc->owner = THIS_MODULE;
+
+	ret = devm_gpiochip_add_data(dev, gc, data);
+	if (ret) {
+		dev_err(dev, "devm_gpiochip_add_data failed: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
 #if defined(CONFIG_OF)
 
 #include <linux/of_device.h>
@@ -214,7 +333,7 @@ static int sbsm_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct power_supply_desc *psy_desc;
 	struct power_supply_config psy_cfg = {};
-	int ret = 0, i, supported_bats;
+	int ret = 0, i;
 
 	/* Device listens only at address 0x0a */
 	if (client->addr != 0x0a)
@@ -235,7 +354,7 @@ static int sbsm_probe(struct i2c_client *client,
 	ret  = sbsm_read_word(client, SBSM_CMD_BATSYSINFO);
 	if (ret < 0)
 		return ret;
-	supported_bats = le16_to_cpu(ret) & 0xf;
+	data->supported_bats = le16_to_cpu(ret) & 0xf;
 
 	data->muxc = i2c_mux_alloc(adapter, dev, SBSM_MAX_BATS, 0,
 				   I2C_MUX_LOCKED, &sbsm_select, NULL);
@@ -248,7 +367,7 @@ static int sbsm_probe(struct i2c_client *client,
 
 	/* register muxed i2c channels. One for each supported battery */
 	for (i = 0; i < SBSM_MAX_BATS; ++i) {
-		if ((1 << i) & supported_bats) {
+		if ((1 << i) & data->supported_bats) {
 			ret = i2c_mux_add_adapter(data->muxc, 0, i + 1, 0);
 			if (ret) {
 				dev_err(dev,
@@ -273,6 +392,9 @@ static int sbsm_probe(struct i2c_client *client,
 		ret = -ENOMEM;
 		goto err_psy;
 	}
+	ret = sbsm_gpio_setup(data);
+	if (ret < 0)
+		goto err_psy;
 
 	psy_cfg.drv_data = data;
 	data->psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
@@ -316,6 +438,7 @@ static int sbsm_remove(struct i2c_client *client)
 	},
 	.probe		= sbsm_probe,
 	.remove		= sbsm_remove,
+	.alert		= sbsm_alert,
 	.id_table	= sbsm_ids
 };
 module_i2c_driver(sbsm_driver);
-- 
1.8.3.1
