From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/2] power: supply: bq24735: bring down the noise level
Date: Wed, 21 Dec 2016 22:29:53 +0100
Message-ID: <1482355793-16190-3-git-send-email-peda@axentia.se>
References: <1482355793-16190-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482355793-16190-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If there is no ti,ac-detect-gpios configured, it is normal to
have failed reads of the options register. So, hold back on the
log spamming.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/power/supply/bq24735-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index d8be81203837..eb0145380def 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -192,7 +192,7 @@ static bool bq24735_charger_is_present(struct bq24735 *charger)
 
 		ac = bq24735_read_word(charger->client, BQ24735_CHG_OPT);
 		if (ac < 0) {
-			dev_err(&charger->client->dev,
+			dev_dbg(&charger->client->dev,
 				"Failed to read charger options : %d\n",
 				ac);
 			return false;
-- 
2.1.4
