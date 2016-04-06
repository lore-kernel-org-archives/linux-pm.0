From: YH Huang <yh.huang@mediatek.com>
Subject: [PATCH] sbs-battery: fix power status when battery charging near dry
Date: Wed, 6 Apr 2016 10:32:25 +0800
Message-ID: <1459909945-36541-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:3605 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760076AbcDFCcg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2016 22:32:36 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, YH Huang <yh.huang@mediatek.com>

POWER_SUPPLY_STATUS_NOT_CHARGING is used for AC connected, but
battery not charging (e.g. because battery temperature is out
of acceptable range).

When battery is charging near dry and BATTERY_FULL_DISCHARGED is set,
it is wrong to set as POWER_SUPPLY_STATUS_NOT_CHARGING.
Just use BATTERY_DISCHARGING to decide the power supply status is
discharging or charging.

Signed-off-by: YH Huang <yh.huang@mediatek.com>
---
 drivers/power/sbs-battery.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index d6226d6..768b9fc 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -382,8 +382,6 @@ static int sbs_get_battery_property(struct i2c_client *client,
 
 		if (ret & BATTERY_FULL_CHARGED)
 			val->intval = POWER_SUPPLY_STATUS_FULL;
-		else if (ret & BATTERY_FULL_DISCHARGED)
-			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else if (ret & BATTERY_DISCHARGING)
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 		else
@@ -702,8 +700,6 @@ static void sbs_delayed_work(struct work_struct *work)
 
 	if (ret & BATTERY_FULL_CHARGED)
 		ret = POWER_SUPPLY_STATUS_FULL;
-	else if (ret & BATTERY_FULL_DISCHARGED)
-		ret = POWER_SUPPLY_STATUS_NOT_CHARGING;
 	else if (ret & BATTERY_DISCHARGING)
 		ret = POWER_SUPPLY_STATUS_DISCHARGING;
 	else
-- 
1.7.9.5

