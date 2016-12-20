From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 3/3] power: supply: bq24735: always check for AC adapter presence in probe
Date: Tue, 20 Dec 2016 12:33:02 +0100
Message-ID: <1482233582-29770-4-git-send-email-peda@axentia.se>
References: <1482233582-29770-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482233582-29770-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

So what if there is a status_gpio specified? bq24735_charger_is_present()
do have a working fallback for the case of no status_gpio.

Simplify this by not special casing setups w/o status_gpio, folding
two consecutive if-blocks in the process.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/power/supply/bq24735-charger.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index 71f977d055d7..4f6275e5cf1c 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -416,7 +416,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (!charger->status_gpio || bq24735_charger_is_present(charger)) {
+	if (bq24735_charger_is_present(charger)) {
 		ret = bq24735_read_word(client, BQ24735_MANUFACTURER_ID);
 		if (ret < 0) {
 			dev_err(&client->dev, "Failed to read manufacturer id : %d\n",
@@ -437,10 +437,7 @@ static int bq24735_charger_probe(struct i2c_client *client,
 				"device id mismatch. 0x000b != 0x%04x\n", ret);
 			return -ENODEV;
 		}
-	}
 
-	/* check for AC adapter presence */
-	if (bq24735_charger_is_present(charger)) {
 		ret = bq24735_enable_charging(charger);
 		if (ret < 0) {
 			dev_err(&client->dev, "Failed to enable charging\n");
-- 
2.1.4
