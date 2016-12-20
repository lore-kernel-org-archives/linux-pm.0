From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/3] power: supply: bq24735: move down bq24735_{en,dis}able_charging
Date: Tue, 20 Dec 2016 12:33:00 +0100
Message-ID: <1482233582-29770-2-git-send-email-peda@axentia.se>
References: <1482233582-29770-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482233582-29770-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

bq24735_enable_charging() needs to call bq24735_config_charging(),
which is something to change later, this is just a preparatory patch.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/power/supply/bq24735-charger.c | 38 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index 8a0242c13b7e..2787c19d6696 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -107,25 +107,6 @@ static int bq24735_update_word(struct i2c_client *client, u8 reg,
 	return bq24735_write_word(client, reg, tmp);
 }
 
-static inline int bq24735_enable_charging(struct bq24735 *charger)
-{
-	if (charger->pdata->ext_control)
-		return 0;
-
-	return bq24735_update_word(charger->client, BQ24735_CHG_OPT,
-				   BQ24735_CHG_OPT_CHARGE_DISABLE, 0);
-}
-
-static inline int bq24735_disable_charging(struct bq24735 *charger)
-{
-	if (charger->pdata->ext_control)
-		return 0;
-
-	return bq24735_update_word(charger->client, BQ24735_CHG_OPT,
-				   BQ24735_CHG_OPT_CHARGE_DISABLE,
-				   BQ24735_CHG_OPT_CHARGE_DISABLE);
-}
-
 static int bq24735_config_charger(struct bq24735 *charger)
 {
 	struct bq24735_platform *pdata = charger->pdata;
@@ -177,6 +158,25 @@ static int bq24735_config_charger(struct bq24735 *charger)
 	return 0;
 }
 
+static inline int bq24735_enable_charging(struct bq24735 *charger)
+{
+	if (charger->pdata->ext_control)
+		return 0;
+
+	return bq24735_update_word(charger->client, BQ24735_CHG_OPT,
+				   BQ24735_CHG_OPT_CHARGE_DISABLE, 0);
+}
+
+static inline int bq24735_disable_charging(struct bq24735 *charger)
+{
+	if (charger->pdata->ext_control)
+		return 0;
+
+	return bq24735_update_word(charger->client, BQ24735_CHG_OPT,
+				   BQ24735_CHG_OPT_CHARGE_DISABLE,
+				   BQ24735_CHG_OPT_CHARGE_DISABLE);
+}
+
 static bool bq24735_charger_is_present(struct bq24735 *charger)
 {
 	if (charger->status_gpio) {
-- 
2.1.4
