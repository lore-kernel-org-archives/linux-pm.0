From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 08/27] power: Export I2C module alias information in missing drivers
Date: Thu, 30 Jul 2015 18:18:33 +0200
Message-ID: <1438273132-20926-9-git-send-email-javier@osg.samsung.com>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The I2C core always reports the MODALIAS uevent as "i2c:<client name"
regardless if the driver was matched using the I2C id_table or the
of_match_table. So the driver needs to export the I2C table and this
be built into the module or udev won't have the necessary information
to auto load the correct module when the device is added.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/power/bq24190_charger.c | 1 +
 drivers/power/rt5033_battery.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/bq24190_charger.c b/drivers/power/bq24190_charger.c
index 703ebecaf38b..bb6d85bd6e56 100644
--- a/drivers/power/bq24190_charger.c
+++ b/drivers/power/bq24190_charger.c
@@ -1515,6 +1515,7 @@ static const struct i2c_device_id bq24190_i2c_ids[] = {
 	{ "bq24190", BQ24190_REG_VPRS_PN_24190 },
 	{ },
 };
+MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id bq24190_of_match[] = {
diff --git a/drivers/power/rt5033_battery.c b/drivers/power/rt5033_battery.c
index a7a6877b4e16..bcdd83048492 100644
--- a/drivers/power/rt5033_battery.c
+++ b/drivers/power/rt5033_battery.c
@@ -165,7 +165,7 @@ static const struct i2c_device_id rt5033_battery_id[] = {
 	{ "rt5033-battery", },
 	{ }
 };
-MODULE_DEVICE_TABLE(platform, rt5033_battery_id);
+MODULE_DEVICE_TABLE(i2c, rt5033_battery_id);
 
 static struct i2c_driver rt5033_battery_driver = {
 	.driver = {
-- 
2.4.3
