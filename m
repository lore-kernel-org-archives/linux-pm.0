From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v2 6/8] power: supply: tps65217: Use generic name for power supply property
Date: Fri,  9 Dec 2016 16:49:04 +0900
Message-ID: <20161209074906.27545-7-woogyom.kim@gmail.com>
References: <20161209074906.27545-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209074906.27545-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-pm@vger.kernel.org

Replace 'ac_props' with 'charger_props'.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 5daf361..79afeca 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -50,7 +50,7 @@ struct tps65217_charger {
 	struct task_struct	*poll_task;
 };
 
-static enum power_supply_property tps65217_ac_props[] = {
+static enum power_supply_property tps65217_charger_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
@@ -191,8 +191,8 @@ static const struct power_supply_desc tps65217_charger_desc = {
 	.name			= "tps65217-ac",
 	.type			= POWER_SUPPLY_TYPE_MAINS,
 	.get_property		= tps65217_ac_get_property,
-	.properties		= tps65217_ac_props,
-	.num_properties		= ARRAY_SIZE(tps65217_ac_props),
+	.properties		= tps65217_charger_props,
+	.num_properties		= ARRAY_SIZE(tps65217_charger_props),
 };
 
 static int tps65217_charger_probe(struct platform_device *pdev)
-- 
2.9.3
