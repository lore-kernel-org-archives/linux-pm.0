From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] PM / sleep: Do not print debug messages by default
Date: Wed, 19 Jul 2017 02:38:44 +0200
Message-ID: <1770660.CcQ51zPl9m@aspire.rjw.lan>
References: <2539550.y54cRb749c@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2539550.y54cRb749c@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Debug messages from the system suspend/hibernation infrastructure can
fill up the entire kernel log buffer in some cases and anyway they
are only useful for debugging.  They depend on CONFIG_PM_DEBUG, but
that is set as a rule as some generally useful diagnostic facilities
depend on it too.

For this reason, avoid printing those messages by default, but make
it possible to turn them on as needed with the help of a new sysfs
attribute under /sys/power/.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/ABI/testing/sysfs-power |   12 +++++++
 drivers/base/power/main.c             |   12 ++-----
 include/linux/suspend.h               |    6 +++
 kernel/power/hibernate.c              |   24 +++++++--------
 kernel/power/main.c                   |   52 ++++++++++++++++++++++++++++++++++
 kernel/power/suspend.c                |   10 +++---
 6 files changed, 91 insertions(+), 25 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -491,8 +491,14 @@ static inline void unlock_system_sleep(v
 
 #ifdef CONFIG_PM_SLEEP_DEBUG
 extern bool pm_print_times_enabled;
+extern __printf(1, 2) void pm_pr_dbg(const char *fmt, ...);
 #else
 #define pm_print_times_enabled	(false)
+
+#include <linux/printk.h>
+
+#define pm_pr_dbg(fmt, ...) \
+	no_printk(KERN_DEBUG fmt, ##__VA_ARGS__)
 #endif
 
 #ifdef CONFIG_PM_AUTOSLEEP
Index: linux-pm/kernel/power/main.c
===================================================================
--- linux-pm.orig/kernel/power/main.c
+++ linux-pm/kernel/power/main.c
@@ -361,6 +361,57 @@ static ssize_t pm_wakeup_irq_show(struct
 
 power_attr_ro(pm_wakeup_irq);
 
+static bool pm_debug_messages_on __read_mostly;
+
+static ssize_t pm_debug_messages_show(struct kobject *kobj,
+				      struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", pm_debug_messages_on);
+}
+
+static ssize_t pm_debug_messages_store(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       const char *buf, size_t n)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val > 1)
+		return -EINVAL;
+
+	pm_debug_messages_on = !!val;
+	return n;
+}
+
+power_attr(pm_debug_messages);
+
+/**
+ * pm_pr_dbg - Print a suspend debug message to the kernel log.
+ * @fmt: Message format.
+ *
+ * The message will be emitted if enabled through the pm_debug_messages
+ * sysfs attribute.
+ */
+void pm_pr_dbg(const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	if (!pm_debug_messages_on)
+		return;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	printk(KERN_DEBUG "PM: %pV", &vaf);
+
+	va_end(args);
+}
+
 #else /* !CONFIG_PM_SLEEP_DEBUG */
 static inline void pm_print_times_init(void) {}
 #endif /* CONFIG_PM_SLEEP_DEBUG */
@@ -697,6 +748,7 @@ static struct attribute * g[] = {
 #ifdef CONFIG_PM_SLEEP_DEBUG
 	&pm_print_times_attr.attr,
 	&pm_wakeup_irq_attr.attr,
+	&pm_debug_messages_attr.attr,
 #endif
 #endif
 #ifdef CONFIG_FREEZER
Index: linux-pm/kernel/power/hibernate.c
===================================================================
--- linux-pm.orig/kernel/power/hibernate.c
+++ linux-pm/kernel/power/hibernate.c
@@ -651,7 +651,7 @@ static int load_image_and_restore(void)
 	int error;
 	unsigned int flags;
 
-	pr_debug("Loading hibernation image.\n");
+	pm_pr_dbg("Loading hibernation image.\n");
 
 	lock_device_hotplug();
 	error = create_basic_memory_bitmaps();
@@ -681,7 +681,7 @@ int hibernate(void)
 	bool snapshot_test = false;
 
 	if (!hibernation_available()) {
-		pr_debug("Hibernation not available.\n");
+		pm_pr_dbg("Hibernation not available.\n");
 		return -EPERM;
 	}
 
@@ -727,7 +727,7 @@ int hibernate(void)
 		else
 		        flags |= SF_CRC32_MODE;
 
-		pr_debug("Writing image.\n");
+		pm_pr_dbg("Writing image.\n");
 		error = swsusp_write(flags);
 		swsusp_free();
 		if (!error) {
@@ -739,7 +739,7 @@ int hibernate(void)
 		in_suspend = 0;
 		pm_restore_gfp_mask();
 	} else {
-		pr_debug("Image restored successfully.\n");
+		pm_pr_dbg("Image restored successfully.\n");
 	}
 
  Free_bitmaps:
@@ -747,7 +747,7 @@ int hibernate(void)
  Thaw:
 	unlock_device_hotplug();
 	if (snapshot_test) {
-		pr_debug("Checking hibernation image\n");
+		pm_pr_dbg("Checking hibernation image\n");
 		error = swsusp_check();
 		if (!error)
 			error = load_image_and_restore();
@@ -811,7 +811,7 @@ static int software_resume(void)
 		goto Unlock;
 	}
 
-	pr_debug("Checking hibernation image partition %s\n", resume_file);
+	pm_pr_dbg("Checking hibernation image partition %s\n", resume_file);
 
 	if (resume_delay) {
 		pr_info("Waiting %dsec before reading resume device ...\n",
@@ -853,10 +853,10 @@ static int software_resume(void)
 	}
 
  Check_image:
-	pr_debug("Hibernation image partition %d:%d present\n",
+	pm_pr_dbg("Hibernation image partition %d:%d present\n",
 		MAJOR(swsusp_resume_device), MINOR(swsusp_resume_device));
 
-	pr_debug("Looking for hibernation image.\n");
+	pm_pr_dbg("Looking for hibernation image.\n");
 	error = swsusp_check();
 	if (error)
 		goto Unlock;
@@ -875,7 +875,7 @@ static int software_resume(void)
 		goto Close_Finish;
 	}
 
-	pr_debug("Preparing processes for restore.\n");
+	pm_pr_dbg("Preparing processes for restore.\n");
 	error = freeze_processes();
 	if (error)
 		goto Close_Finish;
@@ -888,7 +888,7 @@ static int software_resume(void)
 	/* For success case, the suspend path will release the lock */
  Unlock:
 	mutex_unlock(&pm_mutex);
-	pr_debug("Hibernation image not present or could not be loaded.\n");
+	pm_pr_dbg("Hibernation image not present or could not be loaded.\n");
 	return error;
  Close_Finish:
 	swsusp_close(FMODE_READ);
@@ -1012,8 +1012,8 @@ static ssize_t disk_store(struct kobject
 		error = -EINVAL;
 
 	if (!error)
-		pr_debug("Hibernation mode set to '%s'\n",
-			 hibernation_modes[mode]);
+		pm_pr_dbg("Hibernation mode set to '%s'\n",
+			       hibernation_modes[mode]);
 	unlock_system_sleep();
 	return error ? error : n;
 }
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -104,7 +104,7 @@ static void freeze_enter(void)
 
 static void s2idle_loop(void)
 {
-	pr_debug("PM: suspend-to-idle\n");
+	pm_pr_dbg("suspend-to-idle\n");
 
 	do {
 		freeze_enter();
@@ -122,7 +122,7 @@ static void s2idle_loop(void)
 		pm_wakeup_clear(false);
 	} while (!dpm_suspend_noirq(PMSG_SUSPEND));
 
-	pr_debug("PM: resume from suspend-to-idle\n");
+	pm_pr_dbg("resume from suspend-to-idle\n");
 }
 
 void freeze_wake(void)
@@ -542,7 +542,7 @@ static int enter_state(suspend_state_t s
 	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 #endif
 
-	pr_debug("PM: Preparing system for sleep (%s)\n", pm_states[state]);
+	pm_pr_dbg("Preparing system for sleep (%s)\n", pm_states[state]);
 	pm_suspend_clear_flags();
 	error = suspend_prepare(state);
 	if (error)
@@ -552,13 +552,13 @@ static int enter_state(suspend_state_t s
 		goto Finish;
 
 	trace_suspend_resume(TPS("suspend_enter"), state, false);
-	pr_debug("PM: Suspending system (%s)\n", pm_states[state]);
+	pm_pr_dbg("Suspending system (%s)\n", pm_states[state]);
 	pm_restrict_gfp_mask();
 	error = suspend_devices_and_enter(state);
 	pm_restore_gfp_mask();
 
  Finish:
-	pr_debug("PM: Finishing wakeup.\n");
+	pm_pr_dbg("Finishing wakeup.\n");
 	suspend_finish();
  Unlock:
 	mutex_unlock(&pm_mutex);
Index: linux-pm/Documentation/ABI/testing/sysfs-power
===================================================================
--- linux-pm.orig/Documentation/ABI/testing/sysfs-power
+++ linux-pm/Documentation/ABI/testing/sysfs-power
@@ -273,3 +273,15 @@ Description:
 
 		This output is useful for system wakeup diagnostics of spurious
 		wakeup interrupts.
+
+What:		/sys/power/pm_debug_messages
+Date:		July 2017
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		The /sys/power/pm_debug_messages file controls the printing
+		of debug messages from the system suspend/hiberbation
+		infrastructure to the kernel log.
+
+		Writing a "1" to this file enables the debug messages and
+		writing a "0" (default) to it disables them.  Reads from
+		this file return the current value.
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -418,7 +418,6 @@ static void pm_dev_err(struct device *de
 		dev_name(dev), pm_verb(state.event), info, error);
 }
 
-#ifdef CONFIG_PM_DEBUG
 static void dpm_show_time(ktime_t starttime, pm_message_t state,
 			  const char *info)
 {
@@ -432,14 +431,11 @@ static void dpm_show_time(ktime_t startt
 	usecs = usecs64;
 	if (usecs == 0)
 		usecs = 1;
-	pr_info("PM: %s%s%s of devices complete after %ld.%03ld msecs\n",
-		info ?: "", info ? " " : "", pm_verb(state.event),
-		usecs / USEC_PER_MSEC, usecs % USEC_PER_MSEC);
+
+	pm_pr_dbg("%s%s%s of devices complete after %ld.%03ld msecs\n",
+		  info ?: "", info ? " " : "", pm_verb(state.event),
+		  usecs / USEC_PER_MSEC, usecs % USEC_PER_MSEC);
 }
-#else
-static inline void dpm_show_time(ktime_t starttime, pm_message_t state,
-				 const char *info) {}
-#endif /* CONFIG_PM_DEBUG */
 
 static int dpm_run_callback(pm_callback_t cb, struct device *dev,
 			    pm_message_t state, const char *info)
