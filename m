From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 13/18] power: supply: bq24190_charger: Export 5V boost
 converter as regulator
Date: Sun,  6 Aug 2017 14:35:50 +0200
Message-ID: <20170806123555.5124-14-hdegoede@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170806123555.5124-1-hdegoede@redhat.com>
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

Register the 5V boost converter as a regulator named
"regulator-bq24190-usb-vbus". Note the name includes "bq24190" because
the bq24190 family is also used on ACPI devices where there are no
device-tree phandles, so regulator_get will fallback to the name and thus
it must be unique on the system.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 121 +++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index d5a707e14526..f25ea9c4acca 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -16,6 +16,8 @@
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
@@ -504,6 +506,121 @@ static int bq24190_sysfs_create_group(struct bq24190_dev_info *bdi)
 static inline void bq24190_sysfs_remove_group(struct bq24190_dev_info *bdi) {}
 #endif
 
+#ifdef CONFIG_REGULATOR
+static int bq24190_vbus_enable(struct regulator_dev *dev)
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
+				 BQ24190_REG_POC_CHG_CONFIG_SHIFT,
+				 BQ24190_REG_POC_CHG_CONFIG_OTG);
+
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
+
+	return ret;
+}
+
+static int bq24190_vbus_disable(struct regulator_dev *dev)
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
+				 BQ24190_REG_POC_CHG_CONFIG_SHIFT,
+				 BQ24190_REG_POC_CHG_CONFIG_CHARGE);
+
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
+
+	return ret;
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
+	.name = "regulator-bq24190-usb-vbus",
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
+	struct regulator_config cfg = { };
+	struct regulator_dev *reg;
+	int ret = 0;
+
+	cfg.dev = bdi->dev;
+	cfg.init_data = &bq24190_vbus_init_data;
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
 /*
  * According to the "Host Mode and default Mode" section of the
  * manual, a write to any register causes the bq24190 to switch
@@ -1530,6 +1647,10 @@ static int bq24190_probe(struct i2c_client *client,
 		goto out_pmrt;
 	}
 
+	ret = bq24190_register_vbus_regulator(bdi);
+	if (ret < 0)
+		goto out_pmrt;
+
 	ret = bq24190_hw_init(bdi);
 	if (ret < 0) {
 		dev_err(dev, "Hardware init failed\n");
-- 
2.13.3
