From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v10 10/10] power: supply: sbs-battery: move gpio present detect to sbs_get_property
Date: Tue, 25 Jul 2017 11:40:24 +0800
Message-ID: <1500954024-6860-11-git-send-email-preid@electromag.com.au>
References: <1500954024-6860-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500954024-6860-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
