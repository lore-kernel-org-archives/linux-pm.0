From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 09/10] power: charger-manager: Support different polling mode
 for sleep state.
Date: Thu, 30 Oct 2014 21:43:15 +0900
Message-ID: <1414672996-28355-10-git-send-email-jonghwa3.lee@samsung.com>
References: <1414672996-28355-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1414672996-28355-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, pavel@ucw.cz, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>
List-Id: linux-pm@vger.kernel.org

Add additional polling mode for sleep state to define different mode with
normal state. With this change, charger-manager can work differently in
normal state or sleep state. e.g, polling aways for normal and polling
only when charing for sleep. If there is no defined polling mode for
sleep state it just follows the normal state's.
In addition to, polling rate is still same in sleep.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 drivers/power/charger-manager.c       |   20 +++++++++++++++++---
 include/linux/power/charger-manager.h |    9 ++++++---
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 1ccb9be..0a0834f 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -291,7 +291,15 @@ static bool is_full_charged(struct charger_manager *cm)
  */
 static bool is_polling_required(struct charger_manager *cm)
 {
-	switch (cm->desc->polling_mode) {
+	enum polling_modes polling_mode;
+
+	if (cm_suspended
+		&& cm->desc->poll_mode_sleep >= 0)
+		polling_mode = cm->desc->poll_mode_sleep;
+	else
+		polling_mode = cm->desc->poll_mode_normal;
+
+	switch (polling_mode) {
 	case CM_POLL_DISABLE:
 		return false;
 	case CM_POLL_ALWAYS:
@@ -302,7 +310,7 @@ static bool is_polling_required(struct charger_manager *cm)
 		return is_charging(cm);
 	default:
 		dev_warn(cm->dev, "Incorrect polling_mode (%d)\n",
-			 cm->desc->polling_mode);
+			 polling_mode);
 	}
 
 	return false;
@@ -1158,7 +1166,13 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
 	of_property_read_string(np, "cm-name", &desc->psy_name);
 
 	of_property_read_u32(np, "cm-poll-mode", &poll_mode);
-	desc->polling_mode = poll_mode;
+	desc->poll_mode_normal = poll_mode;
+
+	/* Polling mode in sleep state */
+	if (!of_property_read_u32(np, "cm-poll-mode-sleep", &poll_mode))
+		desc->poll_mode_sleep = poll_mode;
+	else
+		desc->poll_mode_sleep = -EINVAL;
 
 	of_property_read_u32(np, "cm-poll-interval",
 				&desc->polling_interval_ms);
diff --git a/include/linux/power/charger-manager.h b/include/linux/power/charger-manager.h
index 37fb181..a30a0b6 100644
--- a/include/linux/power/charger-manager.h
+++ b/include/linux/power/charger-manager.h
@@ -131,8 +131,10 @@ struct charger_regulator {
 /**
  * struct charger_desc
  * @psy_name: the name of power-supply-class for charger manager
- * @polling_mode:
- *	Determine which polling mode will be used
+ * @poll_mode_normal:
+ *	Determine which polling mode will be used in normal state.
+ * @poll_mode_sleep:
+ *	Determine which polling mode will be used in sleep state.
  * @fullbatt_vchkdrop_uV:
  *	Check voltage drop after the battery is fully charged.
  *	If it has dropped more than fullbatt_vchkdrop_uV
@@ -170,7 +172,8 @@ struct charger_regulator {
 struct charger_desc {
 	const char *psy_name;
 
-	enum polling_modes polling_mode;
+	enum polling_modes poll_mode_normal;
+	enum polling_modes poll_mode_sleep;
 	unsigned int polling_interval_ms;
 
 	unsigned int fullbatt_vchkdrop_uV;
-- 
1.7.9.5
