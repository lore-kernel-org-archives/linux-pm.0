From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 4/6] power: charger-manager: Use power_supply_changed() not
 private uevent.
Date: Fri, 12 Sep 2014 20:11:25 +0900
Message-ID: <1410520287-24825-5-git-send-email-jonghwa3.lee@samsung.com>
References: <1410520287-24825-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:31529 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbaILLLh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Sep 2014 07:11:37 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NBS00E5WCF9H0C0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 12 Sep 2014 20:11:33 +0900 (KST)
In-reply-to: <1410520287-24825-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

Whenever battery status is changed, charger manager tries to trigger uevent
through private interface. This patch modifies it to use power_supply_changed()
since it belongs to power supply subsystem.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 drivers/power/charger-manager.c |   81 +++------------------------------------
 1 file changed, 6 insertions(+), 75 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index a8c73db..1917a26 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -35,18 +35,6 @@
 #define CM_DEFAULT_RECHARGE_TEMP_DIFF	50
 #define CM_DEFAULT_CHARGE_TEMP_MAX	500
 
-static const char * const default_event_names[] = {
-	[CM_EVENT_UNKNOWN] = "Unknown",
-	[CM_EVENT_BATT_FULL] = "Battery Full",
-	[CM_EVENT_BATT_IN] = "Battery Inserted",
-	[CM_EVENT_BATT_OUT] = "Battery Pulled Out",
-	[CM_EVENT_BATT_OVERHEAT] = "Battery Overheat",
-	[CM_EVENT_BATT_COLD] = "Battery Cold",
-	[CM_EVENT_EXT_PWR_IN_OUT] = "External Power Attach/Detach",
-	[CM_EVENT_CHG_START_STOP] = "Charging Start/Stop",
-	[CM_EVENT_OTHERS] = "Other battery events"
-};
-
 /*
  * Regard CM_JIFFIES_SMALL jiffies is small enough to ignore for
  * delayed works so that we can run delayed works with CM_JIFFIES_SMALL
@@ -63,8 +51,6 @@ static const char * const default_event_names[] = {
  */
 #define CM_RTC_SMALL		(2)
 
-#define UEVENT_BUF_SIZE		32
-
 static LIST_HEAD(cm_list);
 static DEFINE_MUTEX(cm_list_mtx);
 
@@ -401,61 +387,6 @@ static int try_charger_restart(struct charger_manager *cm)
 }
 
 /**
- * uevent_notify - Let users know something has changed.
- * @cm: the Charger Manager representing the battery.
- * @event: the event string.
- *
- * If @event is null, it implies that uevent_notify is called
- * by resume function. When called in the resume function, cm_suspended
- * should be already reset to false in order to let uevent_notify
- * notify the recent event during the suspend to users. While
- * suspended, uevent_notify does not notify users, but tracks
- * events so that uevent_notify can notify users later after resumed.
- */
-static void uevent_notify(struct charger_manager *cm, const char *event)
-{
-	static char env_str[UEVENT_BUF_SIZE + 1] = "";
-	static char env_str_save[UEVENT_BUF_SIZE + 1] = "";
-
-	if (cm_suspended) {
-		/* Nothing in suspended-event buffer */
-		if (env_str_save[0] == 0) {
-			if (!strncmp(env_str, event, UEVENT_BUF_SIZE))
-				return; /* status not changed */
-			strncpy(env_str_save, event, UEVENT_BUF_SIZE);
-			return;
-		}
-
-		if (!strncmp(env_str_save, event, UEVENT_BUF_SIZE))
-			return; /* Duplicated. */
-		strncpy(env_str_save, event, UEVENT_BUF_SIZE);
-		return;
-	}
-
-	if (event == NULL) {
-		/* No messages pending */
-		if (!env_str_save[0])
-			return;
-
-		strncpy(env_str, env_str_save, UEVENT_BUF_SIZE);
-		kobject_uevent(&cm->dev->kobj, KOBJ_CHANGE);
-		env_str_save[0] = 0;
-
-		return;
-	}
-
-	/* status not changed */
-	if (!strncmp(env_str, event, UEVENT_BUF_SIZE))
-		return;
-
-	/* save the status and notify the update */
-	strncpy(env_str, event, UEVENT_BUF_SIZE);
-	kobject_uevent(&cm->dev->kobj, KOBJ_CHANGE);
-
-	dev_info(cm->dev, "%s\n", event);
-}
-
-/**
  * fullbatt_vchk - Check voltage drop some times after "FULL" event.
  *
  * If a user has designated "fullbatt_vchkdrop_uV" values with
@@ -485,7 +416,7 @@ static void fullbatt_vchk(struct charger_manager *cm)
 
 	if (diff > desc->fullbatt_vchkdrop_uV) {
 		try_charger_restart(cm);
-		uevent_notify(cm, "Recharging");
+		power_supply_changed(&cm->charger_psy);
 	}
 }
 
@@ -516,7 +447,7 @@ static int check_charging_duration(struct charger_manager *cm)
 		if (duration > desc->charging_max_duration_ms) {
 			dev_info(cm->dev, "Charging duration exceed %ums\n",
 				 desc->charging_max_duration_ms);
-			uevent_notify(cm, "Discharging");
+			power_supply_changed(&cm->charger_psy);
 			try_charger_enable(cm, false);
 			ret = true;
 		}
@@ -527,7 +458,7 @@ static int check_charging_duration(struct charger_manager *cm)
 				is_ext_pwr_online(cm)) {
 			dev_info(cm->dev, "Discharging duration exceed %ums\n",
 				 desc->discharging_max_duration_ms);
-			uevent_notify(cm, "Recharging");
+			power_supply_changed(&cm->charger_psy);
 			try_charger_enable(cm, true);
 			ret = true;
 		}
@@ -606,7 +537,7 @@ static bool _cm_monitor(struct charger_manager *cm)
 	if (temp_alrt) {
 		cm->emergency_stop = temp_alrt;
 		if (!try_charger_enable(cm, false))
-			uevent_notify(cm, default_event_names[temp_alrt]);
+			power_supply_changed(&cm->charger_psy);
 
 	/*
 	 * Check whole charging duration and discharing duration
@@ -631,7 +562,7 @@ static bool _cm_monitor(struct charger_manager *cm)
 	} else if (!cm->emergency_stop && is_full_charged(cm) &&
 			cm->charger_enabled) {
 		dev_info(cm->dev, "EVENT_HANDLE: Battery Fully Charged\n");
-		uevent_notify(cm, default_event_names[CM_EVENT_BATT_FULL]);
+		power_supply_changed(&cm->charger_psy);
 
 		try_charger_enable(cm, false);
 
@@ -640,7 +571,7 @@ static bool _cm_monitor(struct charger_manager *cm)
 		cm->emergency_stop = 0;
 		if (is_ext_pwr_online(cm)) {
 			if (!try_charger_enable(cm, true))
-				uevent_notify(cm, "CHARGING");
+				power_supply_changed(&cm->charger_psy);
 		}
 	}
 
-- 
1.7.9.5

