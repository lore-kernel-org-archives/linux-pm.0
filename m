From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri,  8 May 2015 03:08:43 -0400
Message-ID: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f54.google.com ([209.85.216.54]:40447 "EHLO
	mail-vn0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbbEHHIx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 03:08:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Remove sys_sync() from the kernel's suspend flow.

sys_sync() is extremely expensive in some configurations,
and so the kernel should not force users to pay this cost
on every suspend.

The user-space utilities s2ram and s2disk choose to invoke sync() today.
A user can invoke suspend directly via /sys/power/state to skip that cost.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/suspend.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index b7d6b3a..6d237bb 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -473,12 +473,6 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_FREEZE)
 		freeze_begin();
 
-	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-	printk(KERN_INFO "PM: Syncing filesystems ... ");
-	sys_sync();
-	printk("done.\n");
-	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
-
 	pr_debug("PM: Preparing system for %s sleep\n", pm_states[state]);
 	error = suspend_prepare(state);
 	if (error)
-- 
2.4.0.rc1

