From: Nitish Ambastha <nitish.a@samsung.com>
Subject: [PATCH 1/1] kernel/power/autosleep.c: check for pm_suspend() return
 before queueing suspend again
Date: Mon, 29 Jun 2015 18:04:57 +0530
Message-ID: <1435581297-20271-1-git-send-email-nitish.a@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50514 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbbF2HBY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2015 03:01:24 -0400
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
 kernel/power/autosleep.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/power/autosleep.c b/kernel/power/autosleep.c
index 9012ecf..3923148 100644
--- a/kernel/power/autosleep.c
+++ b/kernel/power/autosleep.c
@@ -26,6 +26,7 @@ static struct wakeup_source *autosleep_ws;
 static void try_to_suspend(struct work_struct *work)
 {
 	unsigned int initial_count, final_count;
+	int error = 0;
 
 	if (!pm_get_wakeup_count(&initial_count, true))
 		goto out;
@@ -45,10 +46,20 @@ static void try_to_suspend(struct work_struct *work)
 	if (autosleep_state >= PM_SUSPEND_MAX)
 		hibernate();
 	else
-		pm_suspend(autosleep_state);
+		error = pm_suspend(autosleep_state);
 
 	mutex_unlock(&autosleep_lock);
 
+	if (error) {
+		/*
+		 * If some devices failed to suspend, its better to wait
+		 * to prevent system from trying to suspend in tight loop
+		 */
+		pr_info("PM: suspend returned (%d)\n", error);
+		schedule_timeout_uninterruptible(HZ / 2);
+		goto out;
+	}
+
 	if (!pm_get_wakeup_count(&final_count, false))
 		goto out;
 
-- 
1.7.9.5

