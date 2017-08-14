From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] power: supply: max17042_battery: Add support for ACPI enumeration
Date: Mon, 14 Aug 2017 22:18:10 +0200
Message-ID: <20170814201811.21110-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752243AbdHNUSN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Aug 2017 16:18:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

Some x86 devices enumerate a max17047 fuel-gauge through a MAX17047
ACPI firmware-node, add support for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/max17042_battery.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index aecaaa2b0586..b2ddb7eb69c6 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -22,6 +22,7 @@
  * This driver is based on max17040_battery.c
  */
 
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -982,6 +983,8 @@ static int max17042_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	const struct power_supply_desc *max17042_desc = &max17042_psy_desc;
 	struct power_supply_config psy_cfg = {};
+	const struct acpi_device_id *acpi_id;
+	struct device *dev = &client->dev;
 	struct max17042_chip *chip;
 	int ret;
 	int i;
@@ -995,7 +998,15 @@ static int max17042_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	chip->client = client;
-	chip->chip_type = id->driver_data;
+	if (id) {
+		chip->chip_type = id->driver_data;
+	} else {
+		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
+		if (!acpi_id)
+			return -ENODEV;
+
+		chip->chip_type = acpi_id->driver_data;
+	}
 	chip->regmap = devm_regmap_init_i2c(client, &max17042_regmap_config);
 	if (IS_ERR(chip->regmap)) {
 		dev_err(&client->dev, "Failed to initialize regmap\n");
@@ -1104,6 +1115,14 @@ static int max17042_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(max17042_pm_ops, max17042_suspend,
 			max17042_resume);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id max17042_acpi_match[] = {
+	{ "MAX17047", MAXIM_DEVICE_TYPE_MAX17047 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, max17042_acpi_match);
+#endif
+
 #ifdef CONFIG_OF
 static const struct of_device_id max17042_dt_match[] = {
 	{ .compatible = "maxim,max17042" },
@@ -1125,6 +1144,7 @@ MODULE_DEVICE_TABLE(i2c, max17042_id);
 static struct i2c_driver max17042_i2c_driver = {
 	.driver	= {
 		.name	= "max17042",
+		.acpi_match_table = ACPI_PTR(max17042_acpi_match),
 		.of_match_table = of_match_ptr(max17042_dt_match),
 		.pm	= &max17042_pm_ops,
 	},
-- 
2.13.4
