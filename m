From: Nitish Ambastha <nitish.a@samsung.com>
Subject: [PATCHv2 1/1] kernel/power/autosleep.c: check for pm_suspend() return
 before queueing suspend again
Date: Tue, 30 Jun 2015 00:24:14 +0530
Message-ID: <1435604054-29711-1-git-send-email-nitish.a@samsung.com>
References: <1435581297-20271-1-git-send-email-nitish.a@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53896 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbbF2NVP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2015 09:21:15 -0400
In-reply-to: <1435581297-20271-1-git-send-email-nitish.a@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: cpgs@samsung.com, nitish.a@samsung.com, nits.ambastha@gmail.com

Prevent tight loop for suspend-resume when some
devices failed to suspend
If some devices failed to suspend, we monitor this
error in try_to_suspend(). pm_suspend() is already
an 'int' returning function, how about checking return
from pm_suspend() before queueing suspend again?

For devices which do not register for pending events,
this will prevent tight loop for suspend-resume in
suspend abort scenarios due to device suspend failures

Signed-off-by: Nitish Ambastha <nitish.a@samsung.com>
---
v2: Rearranged code to make wait entry shared with
    existing one as suggested by Pavel Machek <pavel@ucw.cz>
    Corrected log level from pr_info to pr_err for failure log
    Added return check for hibernate()

 kernel/power/autosleep.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/power/autosleep.c b/kernel/power/autosleep.c
index 9012ecf..1a86698 100644
--- a/kernel/power/autosleep.c
+++ b/kernel/power/autosleep.c
@@ -26,6 +26,7 @@ static struct wakeup_source *autosleep_ws;
 static void try_to_suspend(struct work_struct *work)
 {
 	unsigned int initial_count, final_count;
+	int error = 0;
 
 	if (!pm_get_wakeup_count(&initial_count, true))
 		goto out;
@@ -43,22 +44,30 @@ static void try_to_suspend(struct work_struct *work)
 		return;
 	}
 	if (autosleep_state >= PM_SUSPEND_MAX)
-		hibernate();
+		error = hibernate();
 	else
-		pm_suspend(autosleep_state);
+		error = pm_suspend(autosleep_state);
 
 	mutex_unlock(&autosleep_lock);
 
+	if (error) {
+		pr_err("PM: suspend returned (%d)\n", error);
+		goto wait;
+	}
+
 	if (!pm_get_wakeup_count(&final_count, false))
 		goto out;
 
+	if (final_count != initial_count)
+		goto out;
+
+ wait:
 	/*
-	 * If the wakeup occured for an unknown reason, wait to prevent the
-	 * system from trying to suspend and waking up in a tight loop.
+	 * If some devices failed to suspend or if the wakeup ocurred
+	 * for an unknown reason, wait to prevent the system from
+	 * trying to suspend and waking up in a tight loop.
 	 */
-	if (final_count == initial_count)
-		schedule_timeout_uninterruptible(HZ / 2);
-
+	schedule_timeout_uninterruptible(HZ / 2);
  out:
 	queue_up_suspend_work();
 }
-- 
1.7.9.5

