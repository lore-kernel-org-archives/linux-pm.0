From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v2 8/8] power: supply: tps65217: Use generic charger name
Date: Fri,  9 Dec 2016 16:49:06 +0900
Message-ID: <20161209074906.27545-9-woogyom.kim@gmail.com>
References: <20161209074906.27545-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209074906.27545-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-pm@vger.kernel.org

"tps65217-charger" is more appropriate name because the driver supports
not only AC but also USB charger.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 63c5556..29b61e8 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -188,7 +188,7 @@ static int tps65217_charger_poll_task(void *data)
 }
 
 static const struct power_supply_desc tps65217_charger_desc = {
-	.name			= "tps65217-ac",
+	.name			= "tps65217-charger",
 	.type			= POWER_SUPPLY_TYPE_MAINS,
 	.get_property		= tps65217_charger_get_property,
 	.properties		= tps65217_charger_props,
-- 
2.9.3
