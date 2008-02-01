From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/37] Suspend: Testing facility (rev. 2)
Date: Thu, 31 Jan 2008 23:36:40 -0500
Message-ID: <73b3b8a6d123c77888caa9acfb5938fc784e7732.1201840183.git.len.brown__47431.2040875249$1201842096$gmane$org@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
In-Reply-To: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce sysfs attribute /sys/power/pm_test allowing one to test the suspend
core code.  Namely, writing one of the strings:

freezer
devices
platform
processors
core

to this file causes the suspend code to work in one of the test modes defined as
follows:

freezer
- test the freezing of processes

devices
- test the freezing of processes and suspending of devices

platform
- test the freezing of processes, suspending of devices and platform global
  control methods(*)

processors
- test the freezing of processes, suspending of devices, platform global
  control methods and the disabling of nonboot CPUs

core
- test the freezing of processes, suspending of devices, platform global
  control methods, the disabling of nonboot CPUs and suspending of
  platform/system devices

(*) These are ACPI global control methods on ACPI systems

Then, if a suspend is started by normal means, the suspend core will perform
its normal operations up to the point indicated by given test level.  Next, it
will wait for 5 seconds and carry out the resume operations needed to transition
the system back to the fully functional state.

Writing "none" to /sys/power/pm_test turns the testing off.

When open for reading, /sys/power/pm_test contains a space-separated list of all
available tests (including "none" that represents the normal functionality) in
which the current test level is indicated by square brackets.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/main.c  |  108 +++++++++++++++++++++++++++++++++++++++++++++----
 kernel/power/power.h |   18 ++++++++
 2 files changed, 117 insertions(+), 9 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index efc0836..84e1ae6 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -31,6 +31,79 @@ DEFINE_MUTEX(pm_mutex);
 unsigned int pm_flags;
 EXPORT_SYMBOL(pm_flags);
 
+#ifdef CONFIG_PM_DEBUG
+int pm_test_level = TEST_NONE;
+
+static int suspend_test(int level)
+{
+	if (pm_test_level == level) {
+		printk(KERN_INFO "suspend debug: Waiting for 5 seconds.\n");
+		mdelay(5000);
+		return 1;
+	}
+	return 0;
+}
+
+static const char * const pm_tests[__TEST_AFTER_LAST] = {
+	[TEST_NONE] = "none",
+	[TEST_CORE] = "core",
+	[TEST_CPUS] = "processors",
+	[TEST_PLATFORM] = "platform",
+	[TEST_DEVICES] = "devices",
+	[TEST_FREEZER] = "freezer",
+};
+
+static ssize_t pm_test_show(struct kset *kset, char *buf)
+{
+	char *s = buf;
+	int level;
+
+	for (level = TEST_FIRST; level <= TEST_MAX; level++)
+		if (pm_tests[level]) {
+			if (level == pm_test_level)
+				s += sprintf(s, "[%s] ", pm_tests[level]);
+			else
+				s += sprintf(s, "%s ", pm_tests[level]);
+		}
+
+	if (s != buf)
+		/* convert the last space to a newline */
+		*(s-1) = '\n';
+
+	return (s - buf);
+}
+
+static ssize_t pm_test_store(struct kset *kset, const char *buf, size_t n)
+{
+	const char * const *s;
+	int level;
+	char *p;
+	int len;
+	int error = -EINVAL;
+
+	p = memchr(buf, '\n', n);
+	len = p ? p - buf : n;
+
+	mutex_lock(&pm_mutex);
+
+	level = TEST_FIRST;
+	for (s = &pm_tests[level]; level <= TEST_MAX; s++, level++)
+		if (*s && len == strlen(*s) && !strncmp(buf, *s, len)) {
+			pm_test_level = level;
+			error = 0;
+			break;
+		}
+
+	mutex_unlock(&pm_mutex);
+
+	return error ? error : n;
+}
+
+power_attr(pm_test);
+#else /* !CONFIG_PM_DEBUG */
+static inline int suspend_test(int level) { return 0; }
+#endif /* !CONFIG_PM_DEBUG */
+
 #ifdef CONFIG_SUSPEND
 
 /* This is just an arbitrary number */
@@ -136,7 +209,10 @@ static int suspend_enter(suspend_state_t state)
 		printk(KERN_ERR "Some devices failed to power down\n");
 		goto Done;
 	}
-	error = suspend_ops->enter(state);
+
+	if (!suspend_test(TEST_CORE))
+		error = suspend_ops->enter(state);
+
 	device_power_up();
  Done:
 	arch_suspend_enable_irqs();
@@ -167,16 +243,25 @@ int suspend_devices_and_enter(suspend_state_t state)
 		printk(KERN_ERR "Some devices failed to suspend\n");
 		goto Resume_console;
 	}
+
+	if (suspend_test(TEST_DEVICES))
+		goto Resume_devices;
+
 	if (suspend_ops->prepare) {
 		error = suspend_ops->prepare();
 		if (error)
 			goto Resume_devices;
 	}
+
+	if (suspend_test(TEST_PLATFORM))
+		goto Finish;
+
 	error = disable_nonboot_cpus();
-	if (!error)
+	if (!error && !suspend_test(TEST_CPUS))
 		suspend_enter(state);
 
 	enable_nonboot_cpus();
+ Finish:
 	if (suspend_ops->finish)
 		suspend_ops->finish();
  Resume_devices:
@@ -243,12 +328,17 @@ static int enter_state(suspend_state_t state)
 	printk("done.\n");
 
 	pr_debug("PM: Preparing system for %s sleep\n", pm_states[state]);
-	if ((error = suspend_prepare()))
+	error = suspend_prepare();
+	if (error)
 		goto Unlock;
 
+	if (suspend_test(TEST_FREEZER))
+		goto Finish;
+
 	pr_debug("PM: Entering %s sleep\n", pm_states[state]);
 	error = suspend_devices_and_enter(state);
 
+ Finish:
 	pr_debug("PM: Finishing wakeup.\n");
 	suspend_finish();
  Unlock:
@@ -369,18 +459,18 @@ pm_trace_store(struct kobject *kobj, struct kobj_attribute *attr,
 }
 
 power_attr(pm_trace);
+#endif /* CONFIG_PM_TRACE */
 
 static struct attribute * g[] = {
 	&state_attr.attr,
+#ifdef CONFIG_PM_TRACE
 	&pm_trace_attr.attr,
+#endif
+#ifdef CONFIG_PM_DEBUG
+	&pm_test_attr.attr,
+#endif
 	NULL,
 };
-#else
-static struct attribute * g[] = {
-	&state_attr.attr,
-	NULL,
-};
-#endif /* CONFIG_PM_TRACE */
 
 static struct attribute_group attr_group = {
 	.attrs = g,
diff --git a/kernel/power/power.h b/kernel/power/power.h
index c5321eb..9f9e16e 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -188,3 +188,21 @@ int restore_highmem(void);
 static inline unsigned int count_highmem_pages(void) { return 0; }
 static inline int restore_highmem(void) { return 0; }
 #endif
+
+/*
+ * Suspend test levels
+ */
+enum {
+	/* keep first */
+	TEST_NONE,
+	TEST_CORE,
+	TEST_CPUS,
+	TEST_PLATFORM,
+	TEST_DEVICES,
+	TEST_FREEZER,
+	/* keep last */
+	__TEST_AFTER_LAST
+};
+
+#define TEST_FIRST	TEST_NONE
+#define TEST_MAX	(__TEST_AFTER_LAST - 1)
-- 
1.5.4.rc5.16.gc0279
