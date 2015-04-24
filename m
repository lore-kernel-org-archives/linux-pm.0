From: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Subject: [PATCH] power_supply: Add ACPI support to bq2415x battery charger
Date: Fri, 24 Apr 2015 19:13:48 +0300
Message-ID: <1429892028-19926-1-git-send-email-anda-maria.nicolae@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Replace of_property_read_u32() function call with device_property_read_u32(),
which is a wrapper over ACPI and devicetree enumeration methods.

Fix minor existing coding style issues reported by checkpatch.pl.

Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
---
 drivers/power/bq2415x_charger.c |   76 ++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index 6c534dc..38c2ad3 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -35,6 +35,7 @@
 #include <linux/idr.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
+#include <linux/acpi.h>
 
 #include <linux/power/bq2415x_charger.h>
 
@@ -1530,13 +1531,15 @@ static int bq2415x_probe(struct i2c_client *client,
 {
 	int ret;
 	int num;
-	char *name;
+	char *name = NULL;
 	struct bq2415x_device *bq;
 	struct device_node *np = client->dev.of_node;
 	struct bq2415x_platform_data *pdata = client->dev.platform_data;
+	const struct acpi_device_id *acpi_id = NULL;
+	struct device *dev = &client->dev;
 
-	if (!np && !pdata) {
-		dev_err(&client->dev, "platform data missing\n");
+	if (!np && !pdata && !ACPI_HANDLE(dev)) {
+		dev_err(dev, "Neither devicetree, nor platform data, nor ACPI support\n");
 		return -ENODEV;
 	}
 
@@ -1547,22 +1550,27 @@ static int bq2415x_probe(struct i2c_client *client,
 	if (num < 0)
 		return num;
 
-	name = kasprintf(GFP_KERNEL, "%s-%d", id->name, num);
+	if (id)
+		name = kasprintf(GFP_KERNEL, "%s-%d", id->name, num);
+	else if (ACPI_HANDLE(dev)) {
+		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
+		name = kasprintf(GFP_KERNEL, "%s-%d", acpi_id->id, num);
+	}
 	if (!name) {
-		dev_err(&client->dev, "failed to allocate device name\n");
+		dev_err(dev, "failed to allocate device name\n");
 		ret = -ENOMEM;
 		goto error_1;
 	}
 
-	bq = devm_kzalloc(&client->dev, sizeof(*bq), GFP_KERNEL);
+	bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
 	if (!bq) {
-		dev_err(&client->dev, "failed to allocate device data\n");
 		ret = -ENOMEM;
 		goto error_2;
 	}
 
 	if (np) {
-		bq->notify_psy = power_supply_get_by_phandle(np, "ti,usb-charger-detection");
+		bq->notify_psy =
+		    power_supply_get_by_phandle(np, "ti,usb-charger-detection");
 
 		if (IS_ERR(bq->notify_psy)) {
 			dev_info(&client->dev,
@@ -1573,8 +1581,7 @@ static int bq2415x_probe(struct i2c_client *client,
 			ret = -EPROBE_DEFER;
 			goto error_2;
 		}
-	}
-	else if (pdata->notify_device)
+	} else if (pdata && pdata->notify_device)
 		bq->notify_psy = power_supply_get_by_name(pdata->notify_device);
 	else
 		bq->notify_psy = NULL;
@@ -1582,36 +1589,45 @@ static int bq2415x_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, bq);
 
 	bq->id = num;
-	bq->dev = &client->dev;
-	bq->chip = id->driver_data;
+	bq->dev = dev;
+	if (id)
+		bq->chip = id->driver_data;
+	else if (ACPI_HANDLE(dev))
+		bq->chip = acpi_id->driver_data;
 	bq->name = name;
 	bq->mode = BQ2415X_MODE_OFF;
 	bq->reported_mode = BQ2415X_MODE_OFF;
 	bq->autotimer = 0;
 	bq->automode = 0;
 
-	if (np) {
-		ret = of_property_read_u32(np, "ti,current-limit",
+	if (np || ACPI_HANDLE(bq->dev)) {
+		ret = device_property_read_u32(bq->dev,
+				"ti,current-limit",
 				&bq->init_data.current_limit);
 		if (ret)
 			goto error_3;
-		ret = of_property_read_u32(np, "ti,weak-battery-voltage",
+		ret = device_property_read_u32(bq->dev,
+				"ti,weak-battery-voltage",
 				&bq->init_data.weak_battery_voltage);
 		if (ret)
 			goto error_3;
-		ret = of_property_read_u32(np, "ti,battery-regulation-voltage",
+		ret = device_property_read_u32(bq->dev,
+				"ti,battery-regulation-voltage",
 				&bq->init_data.battery_regulation_voltage);
 		if (ret)
 			goto error_3;
-		ret = of_property_read_u32(np, "ti,charge-current",
+		ret = device_property_read_u32(bq->dev,
+				"ti,charge-current",
 				&bq->init_data.charge_current);
 		if (ret)
 			goto error_3;
-		ret = of_property_read_u32(np, "ti,termination-current",
+		ret = device_property_read_u32(bq->dev,
+				"ti,termination-current",
 				&bq->init_data.termination_current);
 		if (ret)
 			goto error_3;
-		ret = of_property_read_u32(np, "ti,resistor-sense",
+		ret = device_property_read_u32(bq->dev,
+				"ti,resistor-sense",
 				&bq->init_data.resistor_sense);
 		if (ret)
 			goto error_3;
@@ -1648,7 +1664,8 @@ static int bq2415x_probe(struct i2c_client *client,
 		}
 
 		/* Query for initial reported_mode and set it */
-		bq2415x_notifier_call(&bq->nb, PSY_EVENT_PROP_CHANGED, bq->notify_psy);
+		bq2415x_notifier_call(&bq->nb, PSY_EVENT_PROP_CHANGED,
+				      bq->notify_psy);
 		bq2415x_set_mode(bq, bq->reported_mode);
 
 		bq->automode = 1;
@@ -1727,9 +1744,28 @@ static const struct i2c_device_id bq2415x_i2c_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, bq2415x_i2c_id_table);
 
+static const struct acpi_device_id bq2415x_i2c_acpi_match[] = {
+	{ "BQ2415X", BQUNKNOWN },
+	{ "BQ241500", BQ24150 },
+	{ "BQA24150", BQ24150A },
+	{ "BQ241510", BQ24151 },
+	{ "BQA24151", BQ24151A },
+	{ "BQ241520", BQ24152 },
+	{ "BQ241530", BQ24153 },
+	{ "BQA24153", BQ24153A },
+	{ "BQ241550", BQ24155 },
+	{ "BQ241560", BQ24156 },
+	{ "BQA24156", BQ24156A },
+	{ "BQS24157", BQ24157S },
+	{ "BQ241580", BQ24158 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, bq2415x_i2c_acpi_match);
+
 static struct i2c_driver bq2415x_driver = {
 	.driver = {
 		.name = "bq2415x-charger",
+		.acpi_match_table = ACPI_PTR(bq2415x_i2c_acpi_match),
 	},
 	.probe = bq2415x_probe,
 	.remove = bq2415x_remove,
-- 
1.7.9.5
