From: David Lechner <david@lechnology.com>
Subject: [PATCH 1/2] power: supply: lego_ev3_battery: Don't ignore iio_read_channel_processed() return value
Date: Fri, 20 Jul 2018 15:19:43 -0500
Message-ID: <20180720201944.20503-2-david@lechnology.com>
References: <20180720201944.20503-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180720201944.20503-1-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: David Lechner <david@lechnology.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This changes the LEGO MINDSTORMS EV3 power supply driver to return an
error if iio_read_channel_processed() fails.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/power/supply/lego_ev3_battery.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/lego_ev3_battery.c b/drivers/power/supply/lego_ev3_battery.c
index 7b993d669f7f..6e3b3e384172 100644
--- a/drivers/power/supply/lego_ev3_battery.c
+++ b/drivers/power/supply/lego_ev3_battery.c
@@ -39,7 +39,7 @@ static int lego_ev3_battery_get_property(struct power_supply *psy,
 					 union power_supply_propval *val)
 {
 	struct lego_ev3_battery *batt = power_supply_get_drvdata(psy);
-	int val2;
+	int ret, val2;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
@@ -47,11 +47,18 @@ static int lego_ev3_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		/* battery voltage is iio channel * 2 + Vce of transistor */
-		iio_read_channel_processed(batt->iio_v, &val->intval);
+		ret = iio_read_channel_processed(batt->iio_v, &val->intval);
+		if (ret)
+			return ret;
+
 		val->intval *= 2000;
 		val->intval += 200000;
+
 		/* plus adjust for shunt resistor drop */
-		iio_read_channel_processed(batt->iio_i, &val2);
+		ret = iio_read_channel_processed(batt->iio_i, &val2);
+		if (ret)
+			return ret;
+
 		val2 *= 1000;
 		val2 /= 15;
 		val->intval += val2;
@@ -64,7 +71,10 @@ static int lego_ev3_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		/* battery current is iio channel / 15 / 0.05 ohms */
-		iio_read_channel_processed(batt->iio_i, &val->intval);
+		ret = iio_read_channel_processed(batt->iio_i, &val->intval);
+		if (ret)
+			return ret;
+
 		val->intval *= 20000;
 		val->intval /= 15;
 		break;
-- 
2.17.1
