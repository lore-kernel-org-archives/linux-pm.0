From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v3 3/7] power: supply: tps65217: Use generic name for charger online
Date: Sun, 18 Dec 2016 11:54:28 +0900
Message-ID: <20161218025432.20780-4-woogyom.kim@gmail.com>
References: <20161218025432.20780-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161218025432.20780-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-pm@vger.kernel.org

This driver supports AC and USB chargers. Generic name is preferred.
Replace 'ac_online' with 'online'.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 482ee9f9edff..424a6d32bb6c 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -44,8 +44,8 @@ struct tps65217_charger {
 	struct device *dev;
 	struct power_supply *ac;
 
-	int	ac_online;
-	int	prev_ac_online;
+	int	online;
+	int	prev_online;
 
 	struct task_struct	*poll_task;
 };
@@ -95,7 +95,7 @@ static int tps65217_enable_charging(struct tps65217_charger *charger)
 	int ret;
 
 	/* charger already enabled */
-	if (charger->ac_online)
+	if (charger->online)
 		return 0;
 
 	dev_dbg(charger->dev, "%s: enable charging\n", __func__);
@@ -110,7 +110,7 @@ static int tps65217_enable_charging(struct tps65217_charger *charger)
 		return ret;
 	}
 
-	charger->ac_online = 1;
+	charger->online = 1;
 
 	return 0;
 }
@@ -122,7 +122,7 @@ static int tps65217_ac_get_property(struct power_supply *psy,
 	struct tps65217_charger *charger = power_supply_get_drvdata(psy);
 
 	if (psp == POWER_SUPPLY_PROP_ONLINE) {
-		val->intval = charger->ac_online;
+		val->intval = charger->online;
 		return 0;
 	}
 	return -EINVAL;
@@ -133,7 +133,7 @@ static irqreturn_t tps65217_charger_irq(int irq, void *dev)
 	int ret, val;
 	struct tps65217_charger *charger = dev;
 
-	charger->prev_ac_online = charger->ac_online;
+	charger->prev_online = charger->online;
 
 	ret = tps65217_reg_read(charger->tps, TPS65217_REG_STATUS, &val);
 	if (ret < 0) {
@@ -153,10 +153,10 @@ static irqreturn_t tps65217_charger_irq(int irq, void *dev)
 			return IRQ_HANDLED;
 		}
 	} else {
-		charger->ac_online = 0;
+		charger->online = 0;
 	}
 
-	if (charger->prev_ac_online != charger->ac_online)
+	if (charger->prev_online != charger->online)
 		power_supply_changed(charger->ac);
 
 	ret = tps65217_reg_read(charger->tps, TPS65217_REG_CHGCONFIG0, &val);
-- 
2.11.0
