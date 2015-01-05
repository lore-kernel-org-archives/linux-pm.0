From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC PATCHv2 02/19] power_supply: Move run-time configuration to
 separate structure
Date: Mon, 05 Jan 2015 16:47:45 +0100
Message-ID: <1420472882-10463-3-git-send-email-k.kozlowski@samsung.com>
References: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1420472882-10463-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Add new structure 'power_supply_config' for holding run-time
initiazation data like of_node, supplies and private driver data.

When registering the power supply this config should be used instead of
directly initializing 'struct power_supply'.

This allows changing the ownership of power_supply structure from driver
to the power supply core in next patches.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/acpi/battery.c            |  3 ++-
 drivers/power/bq24190_charger.c   |  4 ++--
 drivers/power/charger-manager.c   |  2 +-
 drivers/power/max14577_charger.c  |  2 +-
 drivers/power/max17040_battery.c  |  2 +-
 drivers/power/max17042_battery.c  |  2 +-
 drivers/power/power_supply_core.c | 20 +++++++++++++++-----
 drivers/power/sbs-battery.c       |  6 ++++--
 drivers/power/tps65090-charger.c  |  2 +-
 include/linux/power_supply.h      | 16 ++++++++++++++--
 10 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index d98ba4355819..fd8c06f492a1 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -624,7 +624,8 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
 	battery->bat.get_property = acpi_battery_get_property;
 
-	result = power_supply_register_no_ws(&battery->device->dev, &battery->bat);
+	result = power_supply_register_no_ws(&battery->device->dev,
+			&battery->bat, NULL);
 
 	if (result)
 		return result;
diff --git a/drivers/power/bq24190_charger.c b/drivers/power/bq24190_charger.c
index e4c95e1a6733..f736c4c7c8fe 100644
--- a/drivers/power/bq24190_charger.c
+++ b/drivers/power/bq24190_charger.c
@@ -1418,7 +1418,7 @@ static int bq24190_probe(struct i2c_client *client,
 
 	bq24190_charger_init(&bdi->charger);
 
-	ret = power_supply_register(dev, &bdi->charger);
+	ret = power_supply_register(dev, &bdi->charger, NULL);
 	if (ret) {
 		dev_err(dev, "Can't register charger\n");
 		goto out2;
@@ -1426,7 +1426,7 @@ static int bq24190_probe(struct i2c_client *client,
 
 	bq24190_battery_init(&bdi->battery);
 
-	ret = power_supply_register(dev, &bdi->battery);
+	ret = power_supply_register(dev, &bdi->battery, NULL);
 	if (ret) {
 		dev_err(dev, "Can't register battery\n");
 		goto out3;
diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index ae1032dba86f..034c77bf0fc0 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -1873,7 +1873,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	INIT_DELAYED_WORK(&cm->fullbatt_vchk_work, fullbatt_vchk);
 
-	ret = power_supply_register(NULL, &cm->charger_psy);
+	ret = power_supply_register(NULL, &cm->charger_psy, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot register charger-manager with name \"%s\"\n",
 			cm->charger_psy.name);
diff --git a/drivers/power/max14577_charger.c b/drivers/power/max14577_charger.c
index ef4103ee6021..8f113ed73e6c 100644
--- a/drivers/power/max14577_charger.c
+++ b/drivers/power/max14577_charger.c
@@ -562,7 +562,7 @@ static int max14577_charger_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = power_supply_register(&pdev->dev, &chg->charger);
+	ret = power_supply_register(&pdev->dev, &chg->charger, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
 		goto err;
diff --git a/drivers/power/max17040_battery.c b/drivers/power/max17040_battery.c
index 14d44706327b..bf42c57a4247 100644
--- a/drivers/power/max17040_battery.c
+++ b/drivers/power/max17040_battery.c
@@ -223,7 +223,7 @@ static int max17040_probe(struct i2c_client *client,
 	chip->battery.properties	= max17040_battery_props;
 	chip->battery.num_properties	= ARRAY_SIZE(max17040_battery_props);
 
-	ret = power_supply_register(&client->dev, &chip->battery);
+	ret = power_supply_register(&client->dev, &chip->battery, NULL);
 	if (ret) {
 		dev_err(&client->dev, "failed: power supply register\n");
 		return ret;
diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index 1da6c5fbdff5..c62d1428803e 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -733,7 +733,7 @@ static int max17042_probe(struct i2c_client *client,
 		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
 	}
 
-	ret = power_supply_register(&client->dev, &chip->battery);
+	ret = power_supply_register(&client->dev, &chip->battery, NULL);
 	if (ret) {
 		dev_err(&client->dev, "failed: power supply register\n");
 		return ret;
diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 84ef3f40e7bf..b748391c3e17 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -536,7 +536,9 @@ static void psy_unregister_cooler(struct power_supply *psy)
 #endif
 
 static int __power_supply_register(struct device *parent,
-				   struct power_supply *psy, bool ws)
+				   struct power_supply *psy,
+				   const struct power_supply_config *cfg,
+				   bool ws)
 {
 	struct device *dev;
 	int rc;
@@ -553,6 +555,12 @@ static int __power_supply_register(struct device *parent,
 	dev->release = power_supply_dev_release;
 	dev_set_drvdata(dev, psy);
 	psy->dev = dev;
+	if (cfg) {
+		psy->drv_data = cfg->drv_data;
+		psy->of_node = cfg->of_node;
+		psy->supplied_to = cfg->supplied_to;
+		psy->num_supplicants = cfg->num_supplicants;
+	}
 
 	rc = dev_set_name(dev, "%s", psy->name);
 	if (rc)
@@ -605,15 +613,17 @@ dev_set_name_failed:
 	return rc;
 }
 
-int power_supply_register(struct device *parent, struct power_supply *psy)
+int power_supply_register(struct device *parent, struct power_supply *psy,
+		const struct power_supply_config *cfg)
 {
-	return __power_supply_register(parent, psy, true);
+	return __power_supply_register(parent, psy, cfg, true);
 }
 EXPORT_SYMBOL_GPL(power_supply_register);
 
-int power_supply_register_no_ws(struct device *parent, struct power_supply *psy)
+int power_supply_register_no_ws(struct device *parent, struct power_supply *psy,
+		const struct power_supply_config *cfg)
 {
-	return __power_supply_register(parent, psy, false);
+	return __power_supply_register(parent, psy, cfg, false);
 }
 EXPORT_SYMBOL_GPL(power_supply_register_no_ws);
 
diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index c7b7b4018df3..879f1448fc4a 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -801,6 +801,7 @@ static int sbs_probe(struct i2c_client *client,
 {
 	struct sbs_info *chip;
 	struct sbs_platform_data *pdata = client->dev.platform_data;
+	struct power_supply_config psy_cfg = {};
 	int rc;
 	int irq;
 	char *name;
@@ -825,7 +826,7 @@ static int sbs_probe(struct i2c_client *client,
 	chip->power_supply.properties = sbs_properties;
 	chip->power_supply.num_properties = ARRAY_SIZE(sbs_properties);
 	chip->power_supply.get_property = sbs_get_property;
-	chip->power_supply.of_node = client->dev.of_node;
+	psy_cfg.of_node = client->dev.of_node;
 	/* ignore first notification of external change, it is generated
 	 * from the power_supply_register call back
 	 */
@@ -892,7 +893,8 @@ skip_gpio:
 		goto exit_psupply;
 	}
 
-	rc = power_supply_register(&client->dev, &chip->power_supply);
+	rc = power_supply_register(&client->dev, &chip->power_supply,
+			&psy_cfg);
 	if (rc) {
 		dev_err(&client->dev,
 			"%s: Failed to register power supply\n", __func__);
diff --git a/drivers/power/tps65090-charger.c b/drivers/power/tps65090-charger.c
index 0f4e5971dff5..37629affcd34 100644
--- a/drivers/power/tps65090-charger.c
+++ b/drivers/power/tps65090-charger.c
@@ -268,7 +268,7 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 	cdata->ac.num_supplicants	= pdata->num_supplicants;
 	cdata->ac.of_node		= pdev->dev.of_node;
 
-	ret = power_supply_register(&pdev->dev, &cdata->ac);
+	ret = power_supply_register(&pdev->dev, &cdata->ac, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
 		return ret;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index a5743f24e03e..b203a26d5c54 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -176,6 +176,16 @@ union power_supply_propval {
 struct device;
 struct device_node;
 
+/* Power supply instance specific configuration */
+struct power_supply_config {
+	struct device_node *of_node;
+	/* Driver private data */
+	void *drv_data;
+
+	char **supplied_to;
+	size_t num_supplicants;
+};
+
 struct power_supply {
 	const char *name;
 	enum power_supply_type type;
@@ -278,9 +288,11 @@ static inline int power_supply_is_system_supplied(void) { return -ENOSYS; }
 #endif
 
 extern int power_supply_register(struct device *parent,
-				 struct power_supply *psy);
+				 struct power_supply *psy,
+				 const struct power_supply_config *cfg);
 extern int power_supply_register_no_ws(struct device *parent,
-				 struct power_supply *psy);
+				 struct power_supply *psy,
+				 const struct power_supply_config *cfg);
 extern void power_supply_unregister(struct power_supply *psy);
 extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 
-- 
1.9.1
