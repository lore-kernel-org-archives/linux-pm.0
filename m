From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: [PATCH v2] PM / sleep: make pm notifier called symmetrically
Date: Sun, 19 Jun 2016 23:52:27 -0700
Message-ID: <1466405547-3830-1-git-send-email-lianwei.wang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org, oleg@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Lianwei Wang <lianwei.wang@gmail.com>
List-Id: linux-pm@vger.kernel.org

This makes pm notifier PREPARE/POST symmetrical: if PREPARE
fails, we will only undo what ever happened on PREPARE.

It fixes the unbalanced cpu hotplug enable in cpu pm notifier.

Signed-off-by: Lianwei Wang <lianwei.wang@gmail.com>
---
 kernel/power/hibernate.c | 20 ++++++++++++--------
 kernel/power/main.c      | 11 +++++++++--
 kernel/power/power.h     |  2 ++
 kernel/power/suspend.c   | 10 ++++++----
 kernel/power/user.c      | 14 ++++++++------
 5 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index fca9254280ee..126e24caa82e 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -647,7 +647,7 @@ static void power_down(void)
  */
 int hibernate(void)
 {
-	int error;
+	int error, nr_calls = 0;
 
 	if (!hibernation_available()) {
 		pr_debug("PM: Hibernation not available.\n");
@@ -662,9 +662,11 @@ int hibernate(void)
 	}
 
 	pm_prepare_console();
-	error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
-	if (error)
+	error = __pm_notifier_call_chain(PM_HIBERNATION_PREPARE, -1, &nr_calls);
+	if (error) {
+		nr_calls--;
 		goto Exit;
+	}
 
 	printk(KERN_INFO "PM: Syncing filesystems ... ");
 	sys_sync();
@@ -714,7 +716,7 @@ int hibernate(void)
 	/* Don't bother checking whether freezer_test_done is true */
 	freezer_test_done = false;
  Exit:
-	pm_notifier_call_chain(PM_POST_HIBERNATION);
+	__pm_notifier_call_chain(PM_POST_HIBERNATION, nr_calls, NULL);
 	pm_restore_console();
 	atomic_inc(&snapshot_device_available);
  Unlock:
@@ -740,7 +742,7 @@ int hibernate(void)
  */
 static int software_resume(void)
 {
-	int error;
+	int error, nr_calls = 0;
 	unsigned int flags;
 
 	/*
@@ -827,9 +829,11 @@ static int software_resume(void)
 	}
 
 	pm_prepare_console();
-	error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
-	if (error)
+	error = __pm_notifier_call_chain(PM_RESTORE_PREPARE, -1, &nr_calls);
+	if (error) {
+		nr_calls--;
 		goto Close_Finish;
+	}
 
 	pr_debug("PM: Preparing processes for restore.\n");
 	error = freeze_processes();
@@ -855,7 +859,7 @@ static int software_resume(void)
 	unlock_device_hotplug();
 	thaw_processes();
  Finish:
-	pm_notifier_call_chain(PM_POST_RESTORE);
+	__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
 	pm_restore_console();
 	atomic_inc(&snapshot_device_available);
 	/* For success case, the suspend path will release the lock */
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 27946975eff0..5ea50b1b7595 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -38,12 +38,19 @@ int unregister_pm_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_pm_notifier);
 
-int pm_notifier_call_chain(unsigned long val)
+int __pm_notifier_call_chain(unsigned long val, int nr_to_call, int *nr_calls)
 {
-	int ret = blocking_notifier_call_chain(&pm_chain_head, val, NULL);
+	int ret;
+
+	ret = __blocking_notifier_call_chain(&pm_chain_head, val, NULL,
+						nr_to_call, nr_calls);
 
 	return notifier_to_errno(ret);
 }
+int pm_notifier_call_chain(unsigned long val)
+{
+	return __pm_notifier_call_chain(val, -1, NULL);
+}
 
 /* If set, devices may be suspended and resumed asynchronously. */
 int pm_async_enabled = 1;
diff --git a/kernel/power/power.h b/kernel/power/power.h
index efe1b3b17c88..51f02ecaf125 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -200,6 +200,8 @@ static inline void suspend_test_finish(const char *label) {}
 
 #ifdef CONFIG_PM_SLEEP
 /* kernel/power/main.c */
+extern int __pm_notifier_call_chain(unsigned long val, int nr_to_call,
+				    int *nr_calls);
 extern int pm_notifier_call_chain(unsigned long val);
 #endif
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 5b70d64b871e..0acab9d7f96f 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -266,16 +266,18 @@ static int suspend_test(int level)
  */
 static int suspend_prepare(suspend_state_t state)
 {
-	int error;
+	int error, nr_calls = 0;
 
 	if (!sleep_state_supported(state))
 		return -EPERM;
 
 	pm_prepare_console();
 
-	error = pm_notifier_call_chain(PM_SUSPEND_PREPARE);
-	if (error)
+	error = __pm_notifier_call_chain(PM_SUSPEND_PREPARE, -1, &nr_calls);
+	if (error) {
+		nr_calls--;
 		goto Finish;
+	}
 
 	trace_suspend_resume(TPS("freeze_processes"), 0, true);
 	error = suspend_freeze_processes();
@@ -286,7 +288,7 @@ static int suspend_prepare(suspend_state_t state)
 	suspend_stats.failed_freeze++;
 	dpm_save_failed_step(SUSPEND_FREEZE);
  Finish:
-	pm_notifier_call_chain(PM_POST_SUSPEND);
+	__pm_notifier_call_chain(PM_POST_SUSPEND, nr_calls, NULL);
 	pm_restore_console();
 	return error;
 }
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 526e8911460a..35310b627388 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -47,7 +47,7 @@ atomic_t snapshot_device_available = ATOMIC_INIT(1);
 static int snapshot_open(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
-	int error;
+	int error, nr_calls = 0;
 
 	if (!hibernation_available())
 		return -EPERM;
@@ -74,9 +74,9 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 			swap_type_of(swsusp_resume_device, 0, NULL) : -1;
 		data->mode = O_RDONLY;
 		data->free_bitmaps = false;
-		error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
+		error = __pm_notifier_call_chain(PM_HIBERNATION_PREPARE, -1, &nr_calls);
 		if (error)
-			pm_notifier_call_chain(PM_POST_HIBERNATION);
+			__pm_notifier_call_chain(PM_POST_HIBERNATION, --nr_calls, NULL);
 	} else {
 		/*
 		 * Resuming.  We may need to wait for the image device to
@@ -86,13 +86,15 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 
 		data->swap = -1;
 		data->mode = O_WRONLY;
-		error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
+		error = __pm_notifier_call_chain(PM_RESTORE_PREPARE, -1, &nr_calls);
 		if (!error) {
 			error = create_basic_memory_bitmaps();
 			data->free_bitmaps = !error;
-		}
+		} else
+			nr_calls--;
+
 		if (error)
-			pm_notifier_call_chain(PM_POST_RESTORE);
+			__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
 	}
 	if (error)
 		atomic_inc(&snapshot_device_available);
-- 
1.9.1
