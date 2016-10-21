From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] PM / Suspend: Fix missing KERN_CONT for suspend message
Date: Fri, 21 Oct 2016 16:24:09 +0100
Message-ID: <1477063449-24530-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9498 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935077AbcJUPYR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2016 11:24:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Commit 4bcc595ccd80 ("printk: reinstate KERN_CONT for printing
continuation lines") exposed a missing KERN_CONT from one of the
messages shown on entering suspend. With v4.9-rc1, the 'done.' shown
after syncing the filesystems no longer appears as a continuation but
a new message with its own timestamp.

[    9.259566] PM: Syncing filesystems ... [    9.264119] done.

Fix this by adding the KERN_CONT log level for the 'done.' part of the
message seen after syncing filesystems. While we are at it, convert
these suspend printks to pr_info and pr_cont, respectively.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 kernel/power/suspend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 1e7f5da648d9..6ccb08f57fcb 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -498,9 +498,9 @@ static int enter_state(suspend_state_t state)
 
 #ifndef CONFIG_SUSPEND_SKIP_SYNC
 	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-	printk(KERN_INFO "PM: Syncing filesystems ... ");
+	pr_info("PM: Syncing filesystems ... ");
 	sys_sync();
-	printk("done.\n");
+	pr_cont("done.\n");
 	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 #endif
 
-- 
1.9.1

