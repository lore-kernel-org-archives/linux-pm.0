From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 13/15] power: supply: olpc_battery: Move priv data to a struct
Date: Wed, 10 Oct 2018 19:22:58 +0200
Message-ID: <20181010172300.317643-14-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

The global variables for private data are not too nice. I'd like some
more, and that would clutter the global name space even further.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/power/supply/olpc_battery.c | 73 +++++++++++++++--------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index 540d44bf536f..2a2d7cc995f0 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -53,6 +53,12 @@
 
 #define BAT_ADDR_MFR_TYPE	0x5F
 
+struct olpc_battery_data {
+	struct power_supply *olpc_ac;
+	struct power_supply *olpc_bat;
+	char bat_serial[17];
+};
+
 /*********************************************************************
  *		Power
  *********************************************************************/
@@ -91,11 +97,8 @@ static const struct power_supply_desc olpc_ac_desc = {
 	.get_property = olpc_ac_get_prop,
 };
 
-static struct power_supply *olpc_ac;
-
-static char bat_serial[17]; /* Ick */
-
-static int olpc_bat_get_status(union power_supply_propval *val, uint8_t ec_byte)
+static int olpc_bat_get_status(struct olpc_battery_data *data,
+		union power_supply_propval *val, uint8_t ec_byte)
 {
 	if (olpc_platform_info.ecver > 0x44) {
 		if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
@@ -326,6 +329,7 @@ static int olpc_bat_get_property(struct power_supply *psy,
 				 enum power_supply_property psp,
 				 union power_supply_propval *val)
 {
+	struct olpc_battery_data *data = power_supply_get_drvdata(psy);
 	int ret = 0;
 	__be16 ec_word;
 	uint8_t ec_byte;
@@ -347,7 +351,7 @@ static int olpc_bat_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		ret = olpc_bat_get_status(val, ec_byte);
+		ret = olpc_bat_get_status(data, val, ec_byte);
 		if (ret)
 			return ret;
 		break;
@@ -450,8 +454,8 @@ static int olpc_bat_get_property(struct power_supply *psy,
 		if (ret)
 			return ret;
 
-		sprintf(bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
-		val->strval = bat_serial;
+		sprintf(data->bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
+		val->strval = data->bat_serial;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 		ret = olpc_bat_get_voltage_max_design(val);
@@ -579,17 +583,17 @@ static struct power_supply_desc olpc_bat_desc = {
 	.use_for_apm = 1,
 };
 
-static struct power_supply *olpc_bat;
-
 static int olpc_battery_suspend(struct platform_device *pdev,
 				pm_message_t state)
 {
-	if (device_may_wakeup(&olpc_ac->dev))
+	struct olpc_battery_data *data = platform_get_drvdata(pdev);
+
+	if (device_may_wakeup(&data->olpc_ac->dev))
 		olpc_ec_wakeup_set(EC_SCI_SRC_ACPWR);
 	else
 		olpc_ec_wakeup_clear(EC_SCI_SRC_ACPWR);
 
-	if (device_may_wakeup(&olpc_bat->dev))
+	if (device_may_wakeup(&data->olpc_bat->dev))
 		olpc_ec_wakeup_set(EC_SCI_SRC_BATTERY | EC_SCI_SRC_BATSOC
 				   | EC_SCI_SRC_BATERR);
 	else
@@ -601,7 +605,8 @@ static int olpc_battery_suspend(struct platform_device *pdev,
 
 static int olpc_battery_probe(struct platform_device *pdev)
 {
-	int ret;
+	struct power_supply_config psy_cfg = {};
+	struct olpc_battery_data *data;
 	uint8_t status;
 
 	/*
@@ -620,9 +625,13 @@ static int olpc_battery_probe(struct platform_device *pdev)
 
 	/* Ignore the status. It doesn't actually matter */
 
-	olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
-	if (IS_ERR(olpc_ac))
-		return PTR_ERR(olpc_ac);
+	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.drv_data = data;
+
+	data->olpc_ac = devm_power_supply_register(&pdev->dev, &olpc_ac_desc, &psy_cfg);
+	if (IS_ERR(data->olpc_ac))
+		return PTR_ERR(data->olpc_ac);
+
 	if (of_property_match_string(pdev->dev.of_node, "compatible",
 					"olpc,xo1.5-battery") >= 0) {
 		/* XO-1.5 */
@@ -634,42 +643,36 @@ static int olpc_battery_probe(struct platform_device *pdev)
 		olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
 	}
 
-	olpc_bat = power_supply_register(&pdev->dev, &olpc_bat_desc, NULL);
-	if (IS_ERR(olpc_bat)) {
-		ret = PTR_ERR(olpc_bat);
-		goto battery_failed;
-	}
+	data->olpc_bat = devm_power_supply_register(&pdev->dev, &olpc_bat_desc, &psy_cfg);
+	if (IS_ERR(data->olpc_bat))
+		return PTR_ERR(data->olpc_bat);
 
-	ret = device_create_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
+	ret = device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
 	if (ret)
-		goto eeprom_failed;
+		return ret;
 
-	ret = device_create_file(&olpc_bat->dev, &olpc_bat_error);
+	ret = device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
 	if (ret)
 		goto error_failed;
 
 	if (olpc_ec_wakeup_available()) {
-		device_set_wakeup_capable(&olpc_ac->dev, true);
-		device_set_wakeup_capable(&olpc_bat->dev, true);
+		device_set_wakeup_capable(&data->olpc_ac->dev, true);
+		device_set_wakeup_capable(&data->olpc_bat->dev, true);
 	}
 
 	return 0;
 
 error_failed:
-	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
-eeprom_failed:
-	power_supply_unregister(olpc_bat);
-battery_failed:
-	power_supply_unregister(olpc_ac);
+	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
 	return ret;
 }
 
 static int olpc_battery_remove(struct platform_device *pdev)
 {
-	device_remove_file(&olpc_bat->dev, &olpc_bat_error);
-	device_remove_bin_file(&olpc_bat->dev, &olpc_bat_eeprom);
-	power_supply_unregister(olpc_bat);
-	power_supply_unregister(olpc_ac);
+	struct olpc_battery_data *data = platform_get_drvdata(pdev);
+
+	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
+	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
 	return 0;
 }
 
-- 
2.19.0
