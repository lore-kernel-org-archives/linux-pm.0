From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/1] suspend: make sync() on suspend-to-RAM build-time optional
Date: Fri, 31 Jul 2015 12:46:17 -0400
Message-ID: <674dcf60fc85324b41479fcec930d64126c09fb1.1438360540.git.len.brown@intel.com>
References: <1438361177-23201-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33730 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbbGaQqp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 12:46:45 -0400
In-Reply-To: <1438361177-23201-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

The Linux kernel suspend path has traditionally invoked sys_sync()
before freezing user threads.

But sys_sync() can be expensive, and some user-space OS's do not want
the kernel to pay the cost of sys_sync() on every suspend -- preferring
invoke sync() from user-space if/when they want it.

So make sys_sync on suspend build-time optional.

The default is unchanged.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/Kconfig   | 10 ++++++++++
 kernel/power/suspend.c |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 7e01f78..80afa8a 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -18,6 +18,16 @@ config SUSPEND_FREEZER
 
 	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
 
+config SUSPEND_SKIP_SYNC
+	bool "Skip kernel's sys_sync() on suspend to RAM/standby"
+	depends on SUSPEND
+	depends on EXPERT
+	help
+	  Delete the kernel sys_sync() before freezing user processes.
+	  Some operating systems prefer not to pay this cost on every
+	  invocation of suspend, or they are content with invoking sync()
+	  from user-space before invoking suspend.
+
 config HIBERNATE_CALLBACKS
 	bool
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8d7a1ef..4a942ee 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -482,11 +482,13 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_FREEZE)
 		freeze_begin();
 
+#ifndef	CONFIG_SUSPEND_SKIP_SYNC
 	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
 	printk(KERN_INFO "PM: Syncing filesystems ... ");
 	sys_sync();
 	printk("done.\n");
 	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+#endif
 
 	pr_debug("PM: Preparing system for %s sleep\n", pm_states[state]);
 	error = suspend_prepare(state);
-- 
2.5.0

