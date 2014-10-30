From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 06/10] power: charger-manager: Get external power souce
 information only from EXTCON.
Date: Thu, 30 Oct 2014 21:43:12 +0900
Message-ID: <1414672996-28355-7-git-send-email-jonghwa3.lee@samsung.com>
References: <1414672996-28355-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1414672996-28355-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, pavel@ucw.cz, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>
List-Id: linux-pm@vger.kernel.org

When charger-manager checks whether external power source is available,
it gets information from charger IC driver. However, it's not correct source,
charger IC doesn't have responsibilty to give cable connection status.
The charger-manager already gets cable information from EXTCON susbsystem,
so it can re-use it.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 drivers/power/charger-manager.c |   34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index bb44588..172dfe5 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -115,34 +115,28 @@ static bool is_batt_present(struct charger_manager *cm)
  * is_ext_pwr_online - See if an external power source is attached to charge
  * @cm: the Charger Manager representing the battery.
  *
- * Returns true if at least one of the chargers of the battery has an external
- * power source attached to charge the battery regardless of whether it is
- * actually charging or not.
+ * Returns true if there is external power source.
+ * Cable connection information is only obtained by EXTCON class notification.
  */
 static bool is_ext_pwr_online(struct charger_manager *cm)
 {
-	union power_supply_propval val;
-	struct power_supply *psy;
-	bool online = false;
-	int i, ret;
 
-	/* If at least one of them has one, it's yes. */
-	for (i = 0; cm->desc->psy_charger_stat[i]; i++) {
-		psy = power_supply_get_by_name(cm->desc->psy_charger_stat[i]);
-		if (!psy) {
-			dev_err(cm->dev, "Cannot find power supply \"%s\"\n",
-					cm->desc->psy_charger_stat[i]);
-			continue;
-		}
+	struct charger_desc *desc = cm->desc;
+	struct charger_regulator *regulators = desc->charger_regulators;
+	struct charger_cable *cables;
+	int i, j, num_cables;
 
-		ret = psy->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &val);
-		if (ret == 0 && val.intval) {
-			online = true;
-			break;
+	/* If at least one of them has one, it's yes. */
+	for (i = 0; i < desc->num_charger_regulators; i++) {
+		cables = regulators[i].cables;
+		num_cables = regulators[i].num_cables;
+		for (j = 0; j < num_cables; j++) {
+			if (cables[j].attached)
+				return true;
 		}
 	}
 
-	return online;
+	return false;
 }
 
 /**
-- 
1.7.9.5
