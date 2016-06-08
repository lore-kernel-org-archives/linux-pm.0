From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] leds: handle suspend/resume in heartbeat trigger
Date: Wed,  8 Jun 2016 10:29:48 +0200
Message-ID: <1465374588-8453-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36246 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161776AbcFHI37 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 04:29:59 -0400
Received: by mail-lf0-f45.google.com with SMTP id j5so748038lfb.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jun 2016 01:29:58 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>, Richard Purdie <rpurdie@rpsys.net>
Cc: linux-leds@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

The following phenomena was observed: when suspending the
system, sometimes the heartbeat LED was left on, glowing and
wasting power while the rest of the system is asleep, also
disturbing power dissapation measures on the odd suspend
cycle when it's left on.

Clearly this is not how we want the heartbeat trigger to
work: it should turn off and leave the LED off during
system suspend.

This removes the heartbeat trigger when preparing suspend and
restores it during resume. The trigger code will make sure all
LEDs are left in OFF state after removing the trigger, and
will re-enable the trigger on all LEDs after resuming.

Cc: linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Also register/unregister the trigger on PM_RESTORE and
  PM_HIBERNATION notifications.
- Jacek if you already applied v1 please apply this instead,
  or tell me and I can make an incremental patch.
---
 drivers/leds/trigger/ledtrig-heartbeat.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/leds/trigger/ledtrig-heartbeat.c b/drivers/leds/trigger/ledtrig-heartbeat.c
index 410c39c62dc7..c9f386213e9e 100644
--- a/drivers/leds/trigger/ledtrig-heartbeat.c
+++ b/drivers/leds/trigger/ledtrig-heartbeat.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/leds.h>
 #include <linux/reboot.h>
+#include <linux/suspend.h>
 #include "../leds.h"
 
 static int panic_heartbeats;
@@ -154,6 +155,30 @@ static struct led_trigger heartbeat_led_trigger = {
 	.deactivate = heartbeat_trig_deactivate,
 };
 
+static int heartbeat_pm_notifier(struct notifier_block *nb,
+				 unsigned long pm_event, void *unused)
+{
+	int rc;
+
+	switch (pm_event) {
+	case PM_SUSPEND_PREPARE:
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+		led_trigger_unregister(&heartbeat_led_trigger);
+		break;
+	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		rc = led_trigger_register(&heartbeat_led_trigger);
+		if (rc)
+			pr_err("could not re-register heartbeat trigger\n");
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
 static int heartbeat_reboot_notifier(struct notifier_block *nb,
 				     unsigned long code, void *unused)
 {
@@ -168,6 +193,10 @@ static int heartbeat_panic_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static struct notifier_block heartbeat_pm_nb = {
+	.notifier_call = heartbeat_pm_notifier,
+};
+
 static struct notifier_block heartbeat_reboot_nb = {
 	.notifier_call = heartbeat_reboot_notifier,
 };
@@ -184,12 +213,14 @@ static int __init heartbeat_trig_init(void)
 		atomic_notifier_chain_register(&panic_notifier_list,
 					       &heartbeat_panic_nb);
 		register_reboot_notifier(&heartbeat_reboot_nb);
+		register_pm_notifier(&heartbeat_pm_nb);
 	}
 	return rc;
 }
 
 static void __exit heartbeat_trig_exit(void)
 {
+	unregister_pm_notifier(&heartbeat_pm_nb);
 	unregister_reboot_notifier(&heartbeat_reboot_nb);
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &heartbeat_panic_nb);
-- 
2.4.11

