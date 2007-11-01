From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/3] Suspend: Testing facility
Date: Thu, 1 Nov 2007 23:58:27 +0100
Message-ID: <200711012358.27919.rjw__41775.2285524786$1193957119$gmane$org@sisk.pl>
References: <200711012357.27797.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711012357.27797.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce /sys/power/pm_test_level attribute allowing one to test the suspend
core code.  Namely, writing a number (1-5) to this file causes the suspend code
to work in one of the test modes defined as follows:

5 - test the freezing of processes
4 - test the freezing of processes and suspending of devices
3 - test the freezing of processes, suspending of devices and platform global
    control methods
2 - test the freezing of processes, suspending of devices, platform global
    control methods and the disabling of nonboot CPUs
1 - test the freezing of processes, suspending of devices, platform global
    control methods, the disabling of nonboot CPUs and suspending of
    platform/system devices

Then, if a suspend is started by normal means, the suspend core will perform
its normal operations up to the point indicated by the test level.  Next, it
will wait for 5 seconds and carry out the resume operations needed to transition
the system back to the fully functional state.

Writing 0 to /sys/power/pm_test_level turns the testing off.  The current test
level may be read from /sys/power/pm_test_level .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/main.c  |   75 ++++++++++++++++++++++++++++++++++++++++++++-------
 kernel/power/power.h |   10 ++++++
 2 files changed, 76 insertions(+), 9 deletions(-)

Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -28,6 +28,46 @@ BLOCKING_NOTIFIER_HEAD(pm_chain_head);
 
 DEFINE_MUTEX(pm_mutex);
 
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
+static ssize_t pm_test_level_show(struct kset *kset, char *buf)
+{
+	return sprintf(buf, "%d\n", pm_test_level);
+}
+
+static ssize_t
+pm_test_level_store(struct kset *kset, const char *buf, size_t n)
+{
+	int val;
+
+	if (sscanf(buf, "%d", &val) != 1)
+		return -EINVAL;
+
+	if (val < TEST_NONE || val > TEST_FREEZER)
+		return -EINVAL;
+
+	pm_test_level = val;
+
+	return n;
+}
+
+power_attr(pm_test_level);
+#else /* !CONFIG_PM_DEBUG */
+static inline int suspend_test(int level) { return 0; }
+#endif /* !CONFIG_PM_DEBUG */
+
+
 #ifdef CONFIG_SUSPEND
 
 /* This is just an arbitrary number */
@@ -133,7 +173,10 @@ static int suspend_enter(suspend_state_t
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
@@ -164,16 +207,25 @@ int suspend_devices_and_enter(suspend_st
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
@@ -240,12 +292,17 @@ static int enter_state(suspend_state_t s
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
@@ -363,18 +420,18 @@ pm_trace_store(struct kset *kset, const 
 }
 
 power_attr(pm_trace);
+#endif /* CONFIG_PM_TRACE */
 
 static struct attribute * g[] = {
 	&state_attr.attr,
+#ifdef CONFIG_PM_TRACE
 	&pm_trace_attr.attr,
+#endif
+#ifdef CONFIG_PM_DEBUG
+	&pm_test_level_attr.attr,
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
Index: linux-2.6/kernel/power/power.h
===================================================================
--- linux-2.6.orig/kernel/power/power.h
+++ linux-2.6/kernel/power/power.h
@@ -182,3 +182,13 @@ static inline int pm_notifier_call_chain
 	return (blocking_notifier_call_chain(&pm_chain_head, val, NULL)
 			== NOTIFY_BAD) ? -EINVAL : 0;
 }
+
+/* Suspend test levels */
+enum {
+	TEST_NONE,
+	TEST_CORE,
+	TEST_CPUS,
+	TEST_PLATFORM,
+	TEST_DEVICES,
+	TEST_FREEZER
+};
