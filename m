From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/2] power: supply: ltc2941-battery-gauge: Add OF device ID table
Date: Wed, 22 Feb 2017 11:28:15 -0300
Message-ID: <20170222142816.19246-1-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/power/supply/ltc2941-battery-gauge.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 4adf2ba021ce..3b047f54c3b9 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -9,6 +9,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/swab.h>
@@ -387,7 +388,7 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
 
 	np = of_node_get(client->dev.of_node);
 
-	info->num_regs = id->driver_data;
+	info->num_regs = (int)of_device_get_match_data(&client->dev);
 	info->supply_desc.name = np->name;
 
 	/* r_sense can be negative, when sense+ is connected to the battery
@@ -497,9 +498,23 @@ static const struct i2c_device_id ltc294x_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);
 
+static const struct of_device_id ltc294x_i2c_of_match[] = {
+	{
+		.compatible = "maxim,max17040",
+		.data = (void *)LTC2941_NUM_REGS
+	},
+	{
+		.compatible = "maxim,max77836-battery",
+		.data = (void *)LTC2941_NUM_REGS
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ltc294x_i2c_of_match);
+
 static struct i2c_driver ltc294x_driver = {
 	.driver = {
 		.name	= "LTC2941",
+		.of_match_table = of_match_ptr(ltc294x_i2c_of_match),
 		.pm	= LTC294X_PM_OPS,
 	},
 	.probe		= ltc294x_i2c_probe,
-- 
2.9.3
