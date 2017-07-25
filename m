From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v10 09/10] power: supply: sbs-manager: Add alert callback and battery change notification
Date: Tue, 25 Jul 2017 11:40:23 +0800
Message-ID: <1500954024-6860-10-git-send-email-preid@electromag.com.au>
References: <1500954024-6860-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1500954024-6860-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, preid@electromag.com.au, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This adds smb alert support via the smbus_alert driver to generate
power_supply_changed notifications when either external power is
removed / applied or a battery inserted / removed.
Use the i2c alert callback to notify the attached battery driver that a
change has occurred.

Signed-off-by: Phil Reid <preid@electromag.com.au>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/power/supply/Kconfig       |   3 +-
 drivers/power/supply/sbs-manager.c | 129 +++++++++++++++++++++++++++++++++++--
 2 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e7e16ec..1b05021 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -186,7 +186,8 @@ config CHARGER_SBS
 
 config MANAGER_SBS
 	tristate "Smart Battery System Manager"
-	depends on I2C && I2C_MUX
+	depends on I2C && I2C_MUX && GPIOLIB
+	select I2C_SMBUS
 	help
 	  Say Y here to include support for Smart Battery System Manager
 	  ICs. The driver reports online and charging status via sysfs.
diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
index 47c09a1..3e3ad09 100644
--- a/drivers/power/supply/sbs-manager.c
+++ b/drivers/power/supply/sbs-manager.c
@@ -16,10 +16,12 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
 #include <linux/power_supply.h>
+#include <linux/property.h>
 
 #define SBSM_MAX_BATS  4
 #define SBSM_RETRY_CNT 3
@@ -43,7 +45,12 @@ struct sbsm_data {
 	struct power_supply *psy;
 
 	u8 cur_chan;          /* currently selected channel */
+	struct gpio_chip chip;
 	bool is_ltc1760;      /* special capabilities */
+
+	unsigned int supported_bats;
+	unsigned int last_state;
+	unsigned int last_state_cont;
 };
 
 static enum power_supply_property sbsm_props[] = {
@@ -186,6 +193,117 @@ static int sbsm_select(struct i2c_mux_core *muxc, u32 chan)
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
+	int ret, i, irq_bat = 0, state = 0;
+
+	ret = sbsm_read_word(sbsm->client, SBSM_CMD_BATSYSSTATE);
+	if (ret >= 0) {
+		irq_bat = ret ^ sbsm->last_state;
+		sbsm->last_state = ret;
+		state = ret;
+	}
+
+	ret = sbsm_read_word(sbsm->client, SBSM_CMD_BATSYSSTATECONT);
+	if ((ret >= 0) &&
+	    ((ret ^ sbsm->last_state_cont) & SBSM_BIT_AC_PRESENT)) {
+		irq_bat |= sbsm->supported_bats & state;
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
+	int ret;
+
+	if (!device_property_present(dev, "gpio-controller"))
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
 static const struct power_supply_desc sbsm_default_psy_desc = {
 	.type = POWER_SUPPLY_TYPE_MAINS,
 	.properties = sbsm_props,
@@ -203,7 +321,7 @@ static int sbsm_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct power_supply_desc *psy_desc;
 	struct power_supply_config psy_cfg = {};
-	int ret = 0, i, supported_bats;
+	int ret = 0, i;
 
 	/* Device listens only at address 0x0a */
 	if (client->addr != 0x0a)
@@ -224,8 +342,7 @@ static int sbsm_probe(struct i2c_client *client,
 	ret  = sbsm_read_word(client, SBSM_CMD_BATSYSINFO);
 	if (ret < 0)
 		return ret;
-	supported_bats = ret & SBSM_MASK_BAT_SUPPORTED;
-
+	data->supported_bats = ret & SBSM_MASK_BAT_SUPPORTED;
 	data->muxc = i2c_mux_alloc(adapter, dev, SBSM_MAX_BATS, 0,
 				   I2C_MUX_LOCKED, &sbsm_select, NULL);
 	if (!data->muxc) {
@@ -237,7 +354,7 @@ static int sbsm_probe(struct i2c_client *client,
 
 	/* register muxed i2c channels. One for each supported battery */
 	for (i = 0; i < SBSM_MAX_BATS; ++i) {
-		if (supported_bats & BIT(i)) {
+		if (data->supported_bats & BIT(i)) {
 			ret = i2c_mux_add_adapter(data->muxc, 0, i + 1, 0);
 			if (ret)
 				break;
@@ -262,6 +379,9 @@ static int sbsm_probe(struct i2c_client *client,
 		ret = -ENOMEM;
 		goto err_psy;
 	}
+	ret = sbsm_gpio_setup(data);
+	if (ret < 0)
+		goto err_psy;
 
 	psy_cfg.drv_data = data;
 	psy_cfg.of_node = dev->of_node;
@@ -314,6 +434,7 @@ static int sbsm_remove(struct i2c_client *client)
 	},
 	.probe		= sbsm_probe,
 	.remove		= sbsm_remove,
+	.alert		= sbsm_alert,
 	.id_table	= sbsm_ids
 };
 module_i2c_driver(sbsm_driver);
-- 
1.8.3.1
