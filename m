From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 05/10] power: charger-manager: Concentrate scattered
 power_supply_changed() calls.
Date: Thu, 30 Oct 2014 21:43:11 +0900
Message-ID: <1414672996-28355-6-git-send-email-jonghwa3.lee@samsung.com>
References: <1414672996-28355-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38443 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759935AbaJ3MnY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Oct 2014 08:43:24 -0400
In-reply-to: <1414672996-28355-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, pavel@ucw.cz, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

Current charger-manager calls power_suuply_changed() whenever charging
status is changed. This patch removes seperated power_supply_changed()
use and let it be called at end of try_charger_enable() function which
is called to set charging/discharging.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 drivers/power/charger-manager.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 687f109..bb44588 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -382,8 +382,10 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 		}
 	}
 
-	if (!err)
+	if (!err) {
 		cm->charger_enabled = enable;
+		power_supply_changed(&cm->charger_psy);
+	}
 
 	return err;
 }
@@ -436,10 +438,8 @@ static void fullbatt_vchk(struct charger_manager *cm)
 
 	dev_info(cm->dev, "VBATT dropped %duV after full-batt\n", diff);
 
-	if (diff > desc->fullbatt_vchkdrop_uV) {
+	if (diff > desc->fullbatt_vchkdrop_uV)
 		try_charger_restart(cm);
-		power_supply_changed(&cm->charger_psy);
-	}
 }
 
 /**
@@ -469,7 +469,6 @@ static int check_charging_duration(struct charger_manager *cm)
 		if (duration > desc->charging_max_duration_ms) {
 			dev_info(cm->dev, "Charging duration exceed %ums\n",
 				 desc->charging_max_duration_ms);
-			power_supply_changed(&cm->charger_psy);
 			try_charger_enable(cm, false);
 			ret = true;
 		}
@@ -480,7 +479,6 @@ static int check_charging_duration(struct charger_manager *cm)
 				is_ext_pwr_online(cm)) {
 			dev_info(cm->dev, "Discharging duration exceed %ums\n",
 				 desc->discharging_max_duration_ms);
-			power_supply_changed(&cm->charger_psy);
 			try_charger_enable(cm, true);
 			ret = true;
 		}
@@ -561,8 +559,7 @@ static bool _cm_monitor(struct charger_manager *cm)
 	 */
 	if (temp_alrt) {
 		cm->emergency_stop = temp_alrt;
-		if (!try_charger_enable(cm, false))
-			power_supply_changed(&cm->charger_psy);
+		try_charger_enable(cm, false);
 
 	/*
 	 * Check whole charging duration and discharing duration
@@ -587,16 +584,13 @@ static bool _cm_monitor(struct charger_manager *cm)
 	} else if (!cm->emergency_stop && is_full_charged(cm) &&
 			cm->charger_enabled) {
 		dev_info(cm->dev, "EVENT_HANDLE: Battery Fully Charged\n");
-		power_supply_changed(&cm->charger_psy);
-
 		try_charger_enable(cm, false);
 
 		fullbatt_vchk(cm);
 	} else {
 		cm->emergency_stop = 0;
 		if (is_ext_pwr_online(cm)) {
-			if (!try_charger_enable(cm, true))
-				power_supply_changed(&cm->charger_psy);
+			try_charger_enable(cm, true);
 		}
 	}
 
-- 
1.7.9.5

