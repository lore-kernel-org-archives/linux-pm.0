From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Tue, 14 Jul 2015 22:24:51 -0400
Message-ID: <505338dbbcdce9416ac05f67288b10442fbda179.1436926113.git.len.brown@intel.com>
References: <1436927091-32520-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33601 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbGOCZI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2015 22:25:08 -0400
In-Reply-To: <1436927091-32520-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

The Linux kernel suspend path has traditionally invoked sys_sync().

But sys_sync() can be expensive, and some systems do not want
to pay the cost of sys_sync() on every suspend.

So make sys_sync on suspend optional.

Create sysfs attribute /sys/power/pm_suspend_do_sync.
When set to 1, the kernel will sys_sync() on suspend,
When set to 0, it will not.

This attribute can be changed by root at run-time.
Kernel build parameter CONFIG_PM_SUSPEND_DO_SYNC_DEFAULT.
As this is 1, by default, this patch does not change
default behavior.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/ABI/testing/sysfs-power | 10 ++++++++++
 kernel/power/Kconfig                  | 10 ++++++++++
 kernel/power/main.c                   | 31 +++++++++++++++++++++++++++++++
 kernel/power/power.h                  |  1 +
 kernel/power/suspend.c                | 12 +++++++-----
 5 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index f455181..37df98d 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -256,3 +256,13 @@ Description:
 		Writing a "1" enables this printing while writing a "0"
 		disables it.  The default value is "0".  Reading from this file
 		will display the current value.
+
+What:		/sys/power/pm_suspend_do_sync
+Date:		July, 2015
+Contact:	Len Brown <len.brown@intel.com>
+Description:
+		The /sys/power/pm_suspend_do_sync file controls whether the kernel
+		will invoke sys_sync() on entry to the suspend to RAM path.
+		Yes if 1, no if 0.  The default is set by build option
+		CONFIG_PM_SUSPEND_DO_SYNC_DEFAULT.
+
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 7e01f78..28976ed 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -103,6 +103,16 @@ config PM_SLEEP_SMP
 	depends on PM_SLEEP
 	select HOTPLUG_CPU
 
+config PM_SUSPEND_DO_SYNC_DEFAULT
+	int "Default value for /sys/power/suspend_do_sync"
+	range 0 1
+	default "1"
+	depends on SUSPEND
+	---help---
+	Set default value for /sys/power/suspend_sync,
+	which controls whether kernel invokes sys_sync() on suspend to RAM.
+	Value 1 will do the sys_sync(), 0 will not.
+
 config PM_AUTOSLEEP
 	bool "Opportunistic sleep"
 	depends on PM_SLEEP
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 86e8157..a16d369 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -71,6 +71,34 @@ static ssize_t pm_async_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 power_attr(pm_async);
 
+#ifdef CONFIG_SUSPEND
+/* Execute sys_sync() in suspend to RAM path */
+int pm_suspend_do_sync  = CONFIG_PM_SUSPEND_DO_SYNC_DEFAULT;
+
+static ssize_t pm_suspend_do_sync_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", pm_suspend_do_sync);
+}
+
+static ssize_t pm_suspend_do_sync_store(struct kobject *kobj,
+			struct kobj_attribute *attr, const char *buf, size_t n)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val > 1)
+		return -EINVAL;
+
+	pm_suspend_do_sync  = val;
+	return n;
+}
+
+power_attr(pm_suspend_do_sync);
+#endif
+
 #ifdef CONFIG_PM_DEBUG
 int pm_test_level = TEST_NONE;
 
@@ -592,6 +620,9 @@ static struct attribute * g[] = {
 #ifdef CONFIG_PM_SLEEP
 	&pm_async_attr.attr,
 	&wakeup_count_attr.attr,
+#ifdef CONFIG_SUSPEND
+	&pm_suspend_do_sync_attr.attr,
+#endif
 #ifdef CONFIG_PM_AUTOSLEEP
 	&autosleep_attr.attr,
 #endif
diff --git a/kernel/power/power.h b/kernel/power/power.h
index ce9b832..a6120b9 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -201,6 +201,7 @@ static inline void suspend_test_finish(const char *label) {}
 #ifdef CONFIG_PM_SLEEP
 /* kernel/power/main.c */
 extern int pm_notifier_call_chain(unsigned long val);
+extern int pm_suspend_do_sync;
 #endif
 
 #ifdef CONFIG_HIGHMEM
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8d7a1ef..aab5dca 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -482,11 +482,13 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_FREEZE)
 		freeze_begin();
 
-	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-	printk(KERN_INFO "PM: Syncing filesystems ... ");
-	sys_sync();
-	printk("done.\n");
-	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+	if (pm_suspend_do_sync) {
+		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
+		printk(KERN_INFO "PM: Syncing filesystems ... ");
+		sys_sync();
+		printk("done.\n");
+		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
+	}
 
 	pr_debug("PM: Preparing system for %s sleep\n", pm_states[state]);
 	error = suspend_prepare(state);
-- 
2.4.1.314.g9532ead

