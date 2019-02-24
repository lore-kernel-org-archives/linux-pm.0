From: Harry Pan <harry.pan@intel.com>
Subject: [PATCH v6 1/2] PM / sleep: refactor the filesystems sync to reduce duplication
Date: Sun, 24 Feb 2019 14:17:52 +0800
Message-ID: <20190224061753.17638-1-harry.pan@intel.com>
References: <20190222154904.6260-1-harry.pan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222154904.6260-1-harry.pan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: harry.pan@intel.com, gs0622@gmail.com, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch creates a common helper to sync filesystems and shares
to the suspend, hibernate, and snapshot.

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 include/linux/suspend.h  |  3 +++
 kernel/power/hibernate.c |  5 +----
 kernel/power/main.c      |  9 +++++++++
 kernel/power/suspend.c   | 13 +++++--------
 kernel/power/user.c      |  5 +----
 5 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 3f529ad9a9d2..6b3ea9ea6a9e 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -425,6 +425,7 @@ void restore_processor_state(void);
 /* kernel/power/main.c */
 extern int register_pm_notifier(struct notifier_block *nb);
 extern int unregister_pm_notifier(struct notifier_block *nb);
+extern void ksys_sync_helper(void);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
@@ -462,6 +463,8 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
 	return 0;
 }
 
+static inline void ksys_sync_helper(void) {}
+
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
 
 static inline bool pm_wakeup_pending(void) { return false; }
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index abef759de7c8..cc105ecd9c07 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -14,7 +14,6 @@
 
 #include <linux/export.h>
 #include <linux/suspend.h>
-#include <linux/syscalls.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
 #include <linux/device.h>
@@ -709,9 +708,7 @@ int hibernate(void)
 		goto Exit;
 	}
 
-	pr_info("Syncing filesystems ... \n");
-	ksys_sync();
-	pr_info("done.\n");
+	ksys_sync_helper();
 
 	error = freeze_processes();
 	if (error)
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 35b50823d83b..a8a8e6ec57e6 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -16,6 +16,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/suspend.h>
+#include <linux/syscalls.h>
 
 #include "power.h"
 
@@ -51,6 +52,14 @@ void unlock_system_sleep(void)
 }
 EXPORT_SYMBOL_GPL(unlock_system_sleep);
 
+void ksys_sync_helper(void)
+{
+	pr_info("Syncing filesystems ... ");
+	ksys_sync();
+	pr_cont("done.\n");
+}
+EXPORT_SYMBOL_GPL(ksys_sync_helper);
+
 /* Routines for PM-transition notifications */
 
 static BLOCKING_NOTIFIER_HEAD(pm_chain_head);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..e39059dea38b 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -17,7 +17,6 @@
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/cpuidle.h>
-#include <linux/syscalls.h>
 #include <linux/gfp.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -568,13 +567,11 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
-#ifndef CONFIG_SUSPEND_SKIP_SYNC
-	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-	pr_info("Syncing filesystems ... ");
-	ksys_sync();
-	pr_cont("done.\n");
-	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
-#endif
+	if (!IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC)) {
+		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
+		ksys_sync_helper();
+		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+	}
 
 	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
 	pm_suspend_clear_flags();
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 2d8b60a3c86b..cb24e840a3e6 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/suspend.h>
-#include <linux/syscalls.h>
 #include <linux/reboot.h>
 #include <linux/string.h>
 #include <linux/device.h>
@@ -228,9 +227,7 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		if (data->frozen)
 			break;
 
-		printk("Syncing filesystems ... ");
-		ksys_sync();
-		printk("done.\n");
+		ksys_sync_helper();
 
 		error = freeze_processes();
 		if (error)
-- 
2.18.1
