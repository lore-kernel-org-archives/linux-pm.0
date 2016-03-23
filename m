From: YH Huang <yh.huang@mediatek.com>
Subject: [PATCH] sbs-battery: fix power status when battery is dry
Date: Wed, 23 Mar 2016 17:53:14 +0800
Message-ID: <1458726794-48298-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, YH Huang <yh.huang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

When the battery is dry and BATTERY_FULL_DISCHARGED is set,
we should check BATTERY_DISCHARGING to decide the power status.
If BATTERY_DISCHARGING is set, the power status is not charging.
Or the power status should be charging.

Signed-off-by: YH Huang <yh.huang@mediatek.com>
---
 drivers/power/sbs-battery.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index d6226d6..d86db0e 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -382,11 +382,12 @@ static int sbs_get_battery_property(struct i2c_client *client,
 
 		if (ret & BATTERY_FULL_CHARGED)
 			val->intval = POWER_SUPPLY_STATUS_FULL;
-		else if (ret & BATTERY_FULL_DISCHARGED)
-			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
-		else if (ret & BATTERY_DISCHARGING)
-			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
-		else
+		else if (ret & BATTERY_DISCHARGING) {
+			if (ret & BATTERY_FULL_DISCHARGED)
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			else
+				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		} else
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 
 		if (chip->poll_time == 0)
@@ -702,11 +703,12 @@ static void sbs_delayed_work(struct work_struct *work)
 
 	if (ret & BATTERY_FULL_CHARGED)
 		ret = POWER_SUPPLY_STATUS_FULL;
-	else if (ret & BATTERY_FULL_DISCHARGED)
-		ret = POWER_SUPPLY_STATUS_NOT_CHARGING;
-	else if (ret & BATTERY_DISCHARGING)
-		ret = POWER_SUPPLY_STATUS_DISCHARGING;
-	else
+	else if (ret & BATTERY_DISCHARGING) {
+		if (ret & BATTERY_FULL_DISCHARGED)
+			ret = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		else
+			ret = POWER_SUPPLY_STATUS_DISCHARGING;
+	} else
 		ret = POWER_SUPPLY_STATUS_CHARGING;
 
 	if (chip->last_state != ret) {
-- 
1.7.9.5
