From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 08/11] power: supply: bq24190_charger: Export 5V boost
 converter as regulator
Date: Wed, 30 Aug 2017 11:48:11 +0200
Message-ID: <20170830094814.17758-9-hdegoede@redhat.com>
References: <20170830094814.17758-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170830094814.17758-1-hdegoede@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Liam Breck <liam@networkimprov.net>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Register the 5V boost converter as a regulator named "usb_otg_vbus".

This commit also adds support for bq24190_platform_data, through which
non device-tree platforms can pass the regulator_init_data (containing
mappings for the consumer amongst other things).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use "usb_otg_vbus" as default name for the regulator
-Add support for passing regulator_init_data for non device-tree platforms
-Register the regulator later, to avoid it showing up and shortly later
 disappearing again on probe errors (e.g. -EPROBE_DEFER).

Changes in v3:
-Add a bq24190_set_charge_mode helper and use that for the vbus_enable
 and vbus_disable callbacks to reduce code duplication
---
 drivers/power/supply/bq24190_charger.c | 112 +++++++++++++++++++++++++++++++++
 include/linux/power/bq24190_charger.h  |  18 ++++++
 2 files changed, 130 insertions(+)
 create mode 100644 include/linux/power/bq24190_charger.h

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index fa711c106b63..e606a078b0dd 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -16,6 +16,9 @@
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
+#include <linux/power/bq24190_charger.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
@@ -513,6 +516,111 @@ static int bq24190_sysfs_create_group(struct bq24190_dev_info *bdi)
 static inline void bq24190_sysfs_remove_group(struct bq24190_dev_info *bdi) {}
 #endif
 
+#ifdef CONFIG_REGULATOR
+static int bq24190_set_charge_mode(struct regulator_dev *dev, u8 val)
+{
+	struct bq24190_dev_info *bdi = rdev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_get_sync(bdi->dev);
+	if (ret < 0) {
+		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
+		pm_runtime_put_noidle(bdi->dev);
+		return ret;
+	}
+
+	ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
+				 BQ24190_REG_POC_CHG_CONFIG_MASK,
+				 BQ24190_REG_POC_CHG_CONFIG_SHIFT, val);
+
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
+
+	return ret;
+}
+
+static int bq24190_vbus_enable(struct regulator_dev *dev)
+{
+	return bq24190_set_charge_mode(dev, BQ24190_REG_POC_CHG_CONFIG_OTG);
+}
+
+static int bq24190_vbus_disable(struct regulator_dev *dev)
+{
+	return bq24190_set_charge_mode(dev, BQ24190_REG_POC_CHG_CONFIG_CHARGE);
+}
+
+static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
+{
+	struct bq24190_dev_info *bdi = rdev_get_drvdata(dev);
+	int ret;
+	u8 val;
+
+	ret = pm_runtime_get_sync(bdi->dev);
+	if (ret < 0) {
+		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
+		pm_runtime_put_noidle(bdi->dev);
+		return ret;
+	}
+
+	ret = bq24190_read_mask(bdi, BQ24190_REG_POC,
+				BQ24190_REG_POC_CHG_CONFIG_MASK,
+				BQ24190_REG_POC_CHG_CONFIG_SHIFT, &val);
+
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
+
+	return ret ? ret : val == BQ24190_REG_POC_CHG_CONFIG_OTG;
+}
+
+static const struct regulator_ops bq24190_vbus_ops = {
+	.enable = bq24190_vbus_enable,
+	.disable = bq24190_vbus_disable,
+	.is_enabled = bq24190_vbus_is_enabled,
+};
+
+static const struct regulator_desc bq24190_vbus_desc = {
+	.name = "usb_otg_vbus",
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &bq24190_vbus_ops,
+	.fixed_uV = 5000000,
+	.n_voltages = 1,
+};
+
+static const struct regulator_init_data bq24190_vbus_init_data = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static int bq24190_register_vbus_regulator(struct bq24190_dev_info *bdi)
+{
+	struct bq24190_platform_data *pdata = bdi->dev->platform_data;
+	struct regulator_config cfg = { };
+	struct regulator_dev *reg;
+	int ret = 0;
+
+	cfg.dev = bdi->dev;
+	if (pdata && pdata->regulator_init_data)
+		cfg.init_data = pdata->regulator_init_data;
+	else
+		cfg.init_data = &bq24190_vbus_init_data;
+	cfg.driver_data = bdi;
+	reg = devm_regulator_register(bdi->dev, &bq24190_vbus_desc, &cfg);
+	if (IS_ERR(reg)) {
+		ret = PTR_ERR(reg);
+		dev_err(bdi->dev, "Can't register regulator: %d\n", ret);
+	}
+
+	return ret;
+}
+#else
+static int bq24190_register_vbus_regulator(struct bq24190_dev_info *bdi)
+{
+	return 0;
+}
+#endif
+
 static int bq24190_set_config(struct bq24190_dev_info *bdi)
 {
 	int ret;
@@ -1740,6 +1848,10 @@ static int bq24190_probe(struct i2c_client *client,
 		goto out_sysfs;
 	}
 
+	ret = bq24190_register_vbus_regulator(bdi);
+	if (ret < 0)
+		goto out_sysfs;
+
 	if (bdi->extcon) {
 		INIT_DELAYED_WORK(&bdi->extcon_work, bq24190_extcon_work);
 		bdi->extcon_nb.notifier_call = bq24190_extcon_event;
diff --git a/include/linux/power/bq24190_charger.h b/include/linux/power/bq24190_charger.h
new file mode 100644
index 000000000000..45ce7f116a91
--- /dev/null
+++ b/include/linux/power/bq24190_charger.h
@@ -0,0 +1,18 @@
+/*
+ * Platform data for the TI bq24190 battery charger driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _BQ24190_CHARGER_H_
+#define _BQ24190_CHARGER_H_
+
+#include <linux/regulator/machine.h>
+
+struct bq24190_platform_data {
+	const struct regulator_init_data *regulator_init_data;
+};
+
+#endif
-- 
2.13.4
