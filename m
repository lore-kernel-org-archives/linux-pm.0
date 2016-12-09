From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v2 7/8] power: supply: tps65217: Use generic name for get_property()
Date: Fri,  9 Dec 2016 16:49:05 +0900
Message-ID: <20161209074906.27545-8-woogyom.kim@gmail.com>
References: <20161209074906.27545-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209074906.27545-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-pm@vger.kernel.org

Rename it as tps65217_charger_get_property().

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 79afeca..63c5556 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -115,9 +115,9 @@ static int tps65217_enable_charging(struct tps65217_charger *charger)
 	return 0;
 }
 
-static int tps65217_ac_get_property(struct power_supply *psy,
-			enum power_supply_property psp,
-			union power_supply_propval *val)
+static int tps65217_charger_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
 {
 	struct tps65217_charger *charger = power_supply_get_drvdata(psy);
 
@@ -190,7 +190,7 @@ static int tps65217_charger_poll_task(void *data)
 static const struct power_supply_desc tps65217_charger_desc = {
 	.name			= "tps65217-ac",
 	.type			= POWER_SUPPLY_TYPE_MAINS,
-	.get_property		= tps65217_ac_get_property,
+	.get_property		= tps65217_charger_get_property,
 	.properties		= tps65217_charger_props,
 	.num_properties		= ARRAY_SIZE(tps65217_charger_props),
 };
-- 
2.9.3
