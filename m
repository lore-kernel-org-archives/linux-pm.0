From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 04/14] power: max17042_battery: Add default platform_data fallback data
Date: Fri, 14 Apr 2017 20:32:49 +0200
Message-ID: <20170414183259.24382-4-hdegoede@redhat.com>
References: <20170414183259.24382-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752912AbdDNSdH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 14:33:07 -0400
In-Reply-To: <20170414183259.24382-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

Some x86 machines use a max17047 fuel-gauge and x86 might be missing
platform_data if not provided by SFI.

This commit adds default platform_data as fallback option so that the
driver can work on boards where no platform_data is provided.

Since not all boards have a thermistor hooked up, set temp_min to 0 and
change the health checks from temp <= temp_min to temp < temp_min to
not trigger on such boards (where temp reads 0).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Reword commit message
-Add MAX17042_DEFAULT_FOO defines to include/linux/power/max17042.h and
 use these to set the default pdata values
---
 drivers/power/supply/max17042_battery.c | 60 +++++++++++++++++++++++++++++----
 include/linux/power/max17042_battery.h  |  6 +++-
 2 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index a51b296..f0ff6e8 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -150,12 +150,12 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 	if (ret < 0)
 		goto health_error;
 
-	if (temp <= chip->pdata->temp_min) {
+	if (temp < chip->pdata->temp_min) {
 		*health = POWER_SUPPLY_HEALTH_COLD;
 		goto out;
 	}
 
-	if (temp >= chip->pdata->temp_max) {
+	if (temp > chip->pdata->temp_max) {
 		*health = POWER_SUPPLY_HEALTH_OVERHEAT;
 		goto out;
 	}
@@ -772,8 +772,9 @@ static void max17042_init_worker(struct work_struct *work)
 
 #ifdef CONFIG_OF
 static struct max17042_platform_data *
-max17042_get_pdata(struct device *dev)
+max17042_get_pdata(struct max17042_chip *chip)
 {
+	struct device *dev = &chip->client->dev;
 	struct device_node *np = dev->of_node;
 	u32 prop;
 	struct max17042_platform_data *pdata;
@@ -806,10 +807,55 @@ max17042_get_pdata(struct device *dev)
 	return pdata;
 }
 #else
+static struct max17042_reg_data max17047_default_pdata_init_regs[] = {
+	/*
+	 * Some firmwares do not set FullSOCThr, Enable End-of-Charge Detection
+	 * when the voltage FG reports 95%, as recommended in the datasheet.
+	 */
+	{ MAX17047_FullSOCThr, MAX17042_BATTERY_FULL << 8 },
+};
+
 static struct max17042_platform_data *
-max17042_get_pdata(struct device *dev)
+max17042_get_pdata(struct max17042_chip *chip)
 {
-	return dev->platform_data;
+	struct device *dev = &chip->client->dev;
+	struct max17042_platform_data *pdata;
+	int ret, misc_cfg;
+
+	if (dev->platform_data)
+		return dev->platform_data;
+
+	/*
+	 * The MAX17047 gets used on x86 where we might not have pdata, assume
+	 * the firmware will already have initialized the fuel-gauge and provide
+	 * default values for the non init bits to make things work.
+	 */
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return pdata;
+
+	if (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17042) {
+		pdata->init_data = max17047_default_pdata_init_regs;
+		pdata->num_init_data =
+			ARRAY_SIZE(max17047_default_pdata_init_regs);
+	}
+
+	ret = regmap_read(chip->regmap, MAX17042_MiscCFG, &misc_cfg);
+	if (ret < 0)
+		return NULL;
+
+	/* If bits 0-1 are set to 3 then only Voltage readings are used */
+	if ((misc_cfg & 0x3) == 0x3)
+		pdata->enable_current_sense = false;
+	else
+		pdata->enable_current_sense = true;
+
+	pdata->vmin = MAX17042_DEFAULT_VMIN;
+	pdata->vmax = MAX17042_DEFAULT_VMAX;
+	pdata->temp_min = MAX17042_DEFAULT_TEMP_MIN;
+	pdata->temp_max = MAX17042_DEFAULT_TEMP_MAX;
+
+	return pdata;
 }
 #endif
 
@@ -858,20 +904,20 @@ static int max17042_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	chip->client = client;
+	chip->chip_type = id->driver_data;
 	chip->regmap = devm_regmap_init_i2c(client, &max17042_regmap_config);
 	if (IS_ERR(chip->regmap)) {
 		dev_err(&client->dev, "Failed to initialize regmap\n");
 		return -EINVAL;
 	}
 
-	chip->pdata = max17042_get_pdata(&client->dev);
+	chip->pdata = max17042_get_pdata(chip);
 	if (!chip->pdata) {
 		dev_err(&client->dev, "no platform data provided\n");
 		return -EINVAL;
 	}
 
 	i2c_set_clientdata(client, chip);
-	chip->chip_type = id->driver_data;
 	psy_cfg.drv_data = chip;
 
 	/* When current is not measured,
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 522757a..3489fb0 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -24,8 +24,12 @@
 #define __MAX17042_BATTERY_H_
 
 #define MAX17042_STATUS_BattAbsent	(1 << 3)
-#define MAX17042_BATTERY_FULL	(100)
+#define MAX17042_BATTERY_FULL		(95)   /* Recommend. FullSOCThr value */
 #define MAX17042_DEFAULT_SNS_RESISTOR	(10000)
+#define MAX17042_DEFAULT_VMIN		(3000)
+#define MAX17042_DEFAULT_VMAX		(4500) /* LiHV cell max */
+#define MAX17042_DEFAULT_TEMP_MIN	(0)    /* For sys without temp sensor */
+#define MAX17042_DEFAULT_TEMP_MAX	(700)  /* 70 degrees Celcius */
 
 #define MAX17042_CHARACTERIZATION_DATA_SIZE 48
 
-- 
2.9.3
