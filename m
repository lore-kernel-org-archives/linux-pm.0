From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v3 6/7] power: supply: tps65217: Use generic name for get_property()
Date: Sun, 18 Dec 2016 11:54:31 +0900
Message-ID: <20161218025432.20780-7-woogyom.kim@gmail.com>
References: <20161218025432.20780-1-woogyom.kim@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34112 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932462AbcLRCzH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Dec 2016 21:55:07 -0500
In-Reply-To: <20161218025432.20780-1-woogyom.kim@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>

Rename it as tps65217_charger_get_property().

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 79afecafd945..63c555601674 100644
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
2.11.0

