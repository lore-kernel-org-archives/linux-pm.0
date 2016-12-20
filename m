From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/3] power: supply: bq24735: configure the charger as part of enabling it
Date: Tue, 20 Dec 2016 12:33:01 +0100
Message-ID: <1482233582-29770-3-git-send-email-peda@axentia.se>
References: <1482233582-29770-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482233582-29770-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

During probe, it makes no sense to take care to first not issue any
i2c commands to verify if the connected part really is a bq24735, to
later simply fail the probe in the next step when trying to configure
the charger. So, delay configuration of the charging parameters until
the charger is accessible (i.e. when the AC adapter is present) as
part of enabling the charging.

This also fixes the rather serious issue that the charging parameters
are lost when the AC adapter is disconnected.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/power/supply/bq24735-charger.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index 2787c19d6696..71f977d055d7 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -160,9 +160,15 @@ static int bq24735_config_charger(struct bq24735 *charger)
 
 static inline int bq24735_enable_charging(struct bq24735 *charger)
 {
+	int ret;
+
 	if (charger->pdata->ext_control)
 		return 0;
 
+	ret = bq24735_config_charger(charger);
+	if (ret)
+		return ret;
+
 	return bq24735_update_word(charger->client, BQ24735_CHG_OPT,
 				   BQ24735_CHG_OPT_CHARGE_DISABLE, 0);
 }
@@ -292,7 +298,6 @@ static int bq24735_charger_set_property(struct power_supply *psy,
 			mutex_unlock(&charger->lock);
 			if (ret)
 				return ret;
-			bq24735_config_charger(charger);
 			break;
 		case POWER_SUPPLY_STATUS_DISCHARGING:
 		case POWER_SUPPLY_STATUS_NOT_CHARGING:
@@ -434,12 +439,6 @@ static int bq24735_charger_probe(struct i2c_client *client,
 		}
 	}
 
-	ret = bq24735_config_charger(charger);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed in configuring charger");
-		return ret;
-	}
-
 	/* check for AC adapter presence */
 	if (bq24735_charger_is_present(charger)) {
 		ret = bq24735_enable_charging(charger);
-- 
2.1.4
