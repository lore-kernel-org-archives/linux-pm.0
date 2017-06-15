From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v7 10/10] power: supply: sbs-battery: move gpio present detect to sbs_get_property
Date: Thu, 15 Jun 2017 21:59:38 +0800
Message-ID: <1497535178-12001-11-git-send-email-preid@electromag.com.au>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently when a gpio is defined for battery presence it is only used in
the sbs_get_battery_presence_and_health function for 2 properties.
All other properties currently try to read data form the battery before
returning an error if not present. We should know in advance that no
data is going to returned.

As the driver tries multiple times to access a property, this prevents
a lot of smbus accesses, which had a significant effect on device boot-up.
As when the device is registered lots of property accesses are attempted
during boot.

If no gpio is used for presence detection no change in behaviour should
occur.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/power/supply/sbs-battery.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index cf43e38..1e3a8b2 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -324,16 +324,6 @@ static int sbs_get_battery_presence_and_health(
 	union power_supply_propval *val)
 {
 	s32 ret;
-	struct sbs_info *chip = i2c_get_clientdata(client);
-
-	if (psp == POWER_SUPPLY_PROP_PRESENT && chip->gpio_detect) {
-		ret = gpiod_get_value_cansleep(chip->gpio_detect);
-		if (ret < 0)
-			return ret;
-		val->intval = ret;
-		chip->is_present = val->intval;
-		return ret;
-	}
 
 	/*
 	 * Write to ManufacturerAccess with ManufacturerAccess command
@@ -599,6 +589,19 @@ static int sbs_get_property(struct power_supply *psy,
 	struct sbs_info *chip = power_supply_get_drvdata(psy);
 	struct i2c_client *client = chip->client;
 
+	if (chip->gpio_detect) {
+		ret = gpiod_get_value_cansleep(chip->gpio_detect);
+		if (ret < 0)
+			return ret;
+		if (psp == POWER_SUPPLY_PROP_PRESENT) {
+			val->intval = ret;
+			chip->is_present = val->intval;
+			return 0;
+		}
+		if (ret == 0)
+			return -ENODATA;
+	}
+
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
 	case POWER_SUPPLY_PROP_HEALTH:
-- 
1.8.3.1
