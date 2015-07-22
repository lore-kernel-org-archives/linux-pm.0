From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 4/8] power: bq27x00_battery: Checkpatch fixes
Date: Wed, 22 Jul 2015 16:51:56 -0500
Message-ID: <1437601920-13045-5-git-send-email-afd@ti.com>
References: <1437601920-13045-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437601920-13045-1-git-send-email-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-pm@vger.kernel.org

Remove space before tab.
Remove unnecessary line continuations.
Add braces to else statement.
Remove unnecessary parentheses.
Remove unneeded blank lines.
Remove unnecessary 'out of memory' message.
Add missing line after declarations.
Change use of printk to pr_err.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/bq27x00_battery.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index 9cdad19..8287261f 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -108,7 +108,7 @@ struct bq27x00_reg_cache {
 };
 
 struct bq27x00_device_info {
-	struct device 		*dev;
+	struct device		*dev;
 	int			id;
 	enum bq27x00_chip	chip;
 
@@ -202,8 +202,8 @@ static enum power_supply_property bq27510_battery_props[] = {
 
 static unsigned int poll_interval = 360;
 module_param(poll_interval, uint, 0644);
-MODULE_PARM_DESC(poll_interval, "battery poll interval in seconds - " \
-				"0 disables polling");
+MODULE_PARM_DESC(poll_interval,
+		 "battery poll interval in seconds - 0 disables polling");
 
 /*
  * Common code for BQ27x00 devices
@@ -319,8 +319,9 @@ static int bq27x00_battery_read_ilmd(struct bq27x00_device_info *di)
 			ilmd = bq27x00_read(di, BQ27510_REG_DCAP, false);
 		else
 			ilmd = bq27x00_read(di, BQ27500_REG_DCAP, false);
-	} else
+	} else {
 		ilmd = bq27x00_read(di, BQ27000_REG_ILMD, true);
+	}
 
 	if (ilmd < 0) {
 		dev_dbg(di->dev, "error reading initial last measured discharge\n");
@@ -451,7 +452,7 @@ static int bq27x00_battery_read_health(struct bq27x00_device_info *di)
 		return tval;
 	}
 
-	if ((di->chip == BQ27500)) {
+	if (di->chip == BQ27500) {
 		if (tval & BQ27500_FLAG_SOCF)
 			tval = POWER_SUPPLY_HEALTH_DEAD;
 		else if (tval & BQ27500_FLAG_OTC)
@@ -836,7 +837,6 @@ static void bq27x00_powersupply_unregister(struct bq27x00_device_info *di)
 	mutex_destroy(&di->lock);
 }
 
-
 /* i2c specific code */
 #ifdef CONFIG_BATTERY_BQ27X00_I2C
 
@@ -897,14 +897,12 @@ static int bq27x00_battery_probe(struct i2c_client *client,
 
 	name = devm_kasprintf(&client->dev, GFP_KERNEL, "%s-%d", id->name, num);
 	if (!name) {
-		dev_err(&client->dev, "failed to allocate device name\n");
 		retval = -ENOMEM;
 		goto batt_failed;
 	}
 
 	di = devm_kzalloc(&client->dev, sizeof(*di), GFP_KERNEL);
 	if (!di) {
-		dev_err(&client->dev, "failed to allocate device info data\n");
 		retval = -ENOMEM;
 		goto batt_failed;
 	}
@@ -965,8 +963,9 @@ static struct i2c_driver bq27x00_battery_driver = {
 static inline int bq27x00_battery_i2c_init(void)
 {
 	int ret = i2c_add_driver(&bq27x00_battery_driver);
+
 	if (ret)
-		printk(KERN_ERR "Unable to register BQ27x00 i2c driver\n");
+		pr_err("Unable to register BQ27x00 i2c driver\n");
 
 	return ret;
 }
@@ -1037,10 +1036,8 @@ static int bq27000_battery_probe(struct platform_device *pdev)
 	}
 
 	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
-	if (!di) {
-		dev_err(&pdev->dev, "failed to allocate device info data\n");
+	if (!di)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(pdev, di);
 
@@ -1073,8 +1070,9 @@ static struct platform_driver bq27000_battery_driver = {
 static inline int bq27x00_battery_platform_init(void)
 {
 	int ret = platform_driver_register(&bq27000_battery_driver);
+
 	if (ret)
-		printk(KERN_ERR "Unable to register BQ27000 platform driver\n");
+		pr_err("Unable to register BQ27000 platform driver\n");
 
 	return ret;
 }
-- 
1.9.1
