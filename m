From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] power: supply: ltc2941-battery-gauge: Release device_node in ltc294x_i2c_probe()
Date: Sun, 29 Apr 2018 01:35:55 +0300
Message-ID: <1524954955-22107-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Julia Lawall <julia.lawall@lip6.fr>, sil2review@lists.osadl.org
List-Id: linux-pm@vger.kernel.org

There is of_node_get(client->dev.of_node) in ltc294x_i2c_probe(),
but these is no of_node_put() somethere in the driver.

The patch adds one on error and normal paths.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 4f129bb4c972..7854a89b3332 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -481,7 +481,7 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	if (ret < 0) {
 		dev_err(&client->dev,
 			"Could not find lltc,resistor-sense in devicetree\n");
-		return ret;
+		goto err_node_put;
 	}
 	info->r_sense = r_sense;
 
@@ -511,7 +511,7 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 		if (ret < 0) {
 			dev_err(&client->dev,
 				"Could not read status register\n");
-			return ret;
+			goto err_node_put;
 		}
 		if (status & LTC2941_REG_STATUS_CHIP_ID)
 			info->id = LTC2941_ID;
@@ -550,19 +550,25 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 	ret = ltc294x_reset(info, prescaler_exp);
 	if (ret < 0) {
 		dev_err(&client->dev, "Communication with chip failed\n");
-		return ret;
+		goto err_node_put;
 	}
 
 	info->supply = power_supply_register(&client->dev, &info->supply_desc,
 					     &psy_cfg);
 	if (IS_ERR(info->supply)) {
 		dev_err(&client->dev, "failed to register ltc2941\n");
-		return PTR_ERR(info->supply);
+		ret = PTR_ERR(info->supply);
+		goto err_node_put;
 	} else {
 		schedule_delayed_work(&info->work, LTC294X_WORK_DELAY * HZ);
 	}
 
+	of_node_put(np);
 	return 0;
+
+err_node_put:
+	of_node_put(np);
+	return ret;
 }
 
 static void ltc294x_i2c_shutdown(struct i2c_client *client)
-- 
2.7.4
