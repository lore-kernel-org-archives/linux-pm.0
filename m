From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH V3 09/11] power: charger-manager: Not to start charging
 directly in cable nofitication.
Date: Fri, 19 Dec 2014 17:55:21 +0900
Message-ID: <1418979323-7188-10-git-send-email-jonghwa3.lee@samsung.com>
References: <1418979323-7188-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54612 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbaLSIze (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Dec 2014 03:55:34 -0500
In-reply-to: <1418979323-7188-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, pavel@ucw.cz, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

This patch prevents direct charging control in cable notification.
It sets only input current limit according to cable type and yields charging
control to be done by cm_monitor() where charging management proceeds.
It may loose few ms to enable charging compared to before, even though it's
more important that charging is enabled always in safe context.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 drivers/power/charger-manager.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 44cc19a..4f8b0e6 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -849,7 +849,8 @@ static void charger_extcon_work(struct work_struct *work)
 			cable->min_uA, cable->max_uA);
 	}
 
-	try_charger_enable(cable->cm, cable->attached);
+	cancel_delayed_work(&cm_monitor_work);
+	queue_delayed_work(cm_wq, &cm_monitor_work, 0);
 }
 
 /**
@@ -873,15 +874,6 @@ static int charger_extcon_notifier(struct notifier_block *self,
 	cable->attached = event;
 
 	/*
-	 * Setup monitoring to check battery state
-	 * when charger cable is attached.
-	 */
-	if (cable->attached && is_polling_required(cable->cm)) {
-		cancel_work_sync(&setup_polling);
-		schedule_work(&setup_polling);
-	}
-
-	/*
 	 * Setup work for controlling charger(regulator)
 	 * according to charger cable.
 	 */
-- 
1.7.9.5

