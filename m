From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v8 9/9] power: supply: sbs-battery: move gpio present detect to sbs_get_property
Date: Tue, 18 Jul 2017 16:19:44 +0800
Message-ID: <1500365984-61404-10-git-send-email-preid@electromag.com.au>
References: <1500365984-61404-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:59968 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751453AbdGRIT6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 04:19:58 -0400
In-Reply-To: <1500365984-61404-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Phil Reid <preid@electromag.com.au>

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
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/power/supply/sbs-battery.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index f705945..686e7cb 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -325,16 +325,6 @@ static int sbs_get_battery_presence_and_health(
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
@@ -600,6 +590,19 @@ static int sbs_get_property(struct power_supply *psy,
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
