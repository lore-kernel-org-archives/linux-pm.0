From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V6] Report interrupt(s) that caused system wakeup
Date: Thu, 27 Aug 2015 13:00:43 -0700
Message-ID: <1440705643-3092-2-git-send-email-alexandra.yates@linux.intel.com>
References: <[PATCH V6] Report interrupt(s) that caused system wakeup>
 <1440705643-3092-1-git-send-email-alexandra.yates@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43531 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbbH0T7C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Aug 2015 15:59:02 -0400
In-Reply-To: <1440705643-3092-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, rjw@rjwysocki.net, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>

This feature reports which IRQs cause the system to wakeup from sleep last
time it was suspended.

It adds a new sysfs attribute under /sys/power/ named: pm_last_wakeup_irqs
when read, will return a list of IRQs that caused the system to wakeup.
That will be useful for system wakeup diagnostics.

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-power | 11 +++++++++++
 drivers/base/power/wakeup.c           | 33 ++++++++++++++++++++++++++++++++-
 include/linux/suspend.h               |  5 +++--
 kernel/irq/pm.c                       |  2 +-
 kernel/power/main.c                   | 23 +++++++++++++++++++++++
 5 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index f455181..4f9cc3a 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -256,3 +256,14 @@ Description:
 		Writing a "1" enables this printing while writing a "0"
 		disables it.  The default value is "0".  Reading from this file
 		will display the current value.
+
+What:		/sys/power/pm_last_wakeup_irqs
+Date:		April 2015
+Contact:	Alexandra Yates <alexandra.yates@linux.intel.org>
+Description:
+		The /sys/power/pm_last_wakeup_irqs file allows user space
+		to identify and report the IRQs responsible for waking the
+		system up from sleep. The IRQD_WAKEUP_TRIGGERED flag is set and
+		reported when the given IRQ fires after it has been armed for
+		system wakeup. This output is useful for system wakeup
+		diagnostics.
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 51f15bc..0f6cc55 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -28,6 +28,9 @@ bool events_check_enabled __read_mostly;
 /* If set and the system is suspending, terminate the suspend. */
 static bool pm_abort_suspend __read_mostly;
 
+/* IRQ number which causes system wakeup  */
+static unsigned int wakeup_irq;
+
 /*
  * Combined counters of registered wakeup events and wakeup events in progress.
  * They need to be modified together atomically, so it's better to use one
@@ -858,8 +861,9 @@ bool pm_wakeup_pending(void)
 	return ret || pm_abort_suspend;
 }
 
-void pm_system_wakeup(void)
+void pm_system_irq_wakeup(unsigned int irq_number)
 {
+	wakeup_irq = irq_number;
 	pm_abort_suspend = true;
 	freeze_wake();
 }
@@ -870,6 +874,33 @@ void pm_wakeup_clear(void)
 	pm_abort_suspend = false;
 }
 
+#ifdef CONFIG_PM_SLEEP_DEBUG
+/*
+ * pm_get_last_wakeup_irqs - gets interrupt number that
+ * caused the system to wake up from suspend-to-idle.
+ * @buf: keeps track of the irqs that casued the system to wakeup
+ */
+ssize_t pm_get_last_wakeup_irqs(char *buf, size_t size)
+{
+	char *str = buf;
+	char *end = buf + size;
+
+	if (!pm_abort_suspend)
+		return 0;
+
+	/* If pm_abort_suspend is not set, the previous suspend was aborted
+	 * before arming the wakeup IRQs, so avoid printing stale information
+	 * in that case.
+	 */
+	str += scnprintf(str, end - str, "%d ", wakeup_irq);
+
+	if (str != buf)
+		str--;
+
+	return (str - buf);
+}
+#endif /* CONFIG_PM_SLEEP_DEBUG */
+
 /**
  * pm_get_wakeup_count - Read the number of registered wakeup events.
  * @count: Address to store the value at.
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 5efe743..86ab316 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -378,6 +378,7 @@ void restore_processor_state(void);
 /* kernel/power/main.c */
 extern int register_pm_notifier(struct notifier_block *nb);
 extern int unregister_pm_notifier(struct notifier_block *nb);
+extern ssize_t pm_get_last_wakeup_irqs(char *buf, size_t size);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
@@ -389,7 +390,7 @@ extern int unregister_pm_notifier(struct notifier_block *nb);
 extern bool events_check_enabled;
 
 extern bool pm_wakeup_pending(void);
-extern void pm_system_wakeup(void);
+extern void pm_system_irq_wakeup(unsigned int);
 extern void pm_wakeup_clear(void);
 extern bool pm_get_wakeup_count(unsigned int *count, bool block);
 extern bool pm_save_wakeup_count(unsigned int count);
@@ -438,7 +439,7 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
 
 static inline bool pm_wakeup_pending(void) { return false; }
-static inline void pm_system_wakeup(void) {}
+static inline void pm_system_irq_wakeup(unsigned int) {}
 static inline void pm_wakeup_clear(void) {}
 
 static inline void lock_system_sleep(void) {}
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index d22786a..46068a1 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -21,7 +21,7 @@ bool irq_pm_check_wakeup(struct irq_desc *desc)
 		desc->istate |= IRQS_SUSPENDED | IRQS_PENDING;
 		desc->depth++;
 		irq_disable(desc);
-		pm_system_wakeup();
+		pm_system_irq_wakeup(irq_desc_get_irq(desc));
 		return true;
 	}
 	return false;
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 63d395b..6e550c0 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -272,6 +272,28 @@ static inline void pm_print_times_init(void)
 {
 	pm_print_times_enabled = !!initcall_debug;
 }
+
+static ssize_t pm_last_wakeup_irqs_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					char *buf)
+{
+	size_t ret;
+
+	ret = pm_get_last_wakeup_irqs(buf, PAGE_SIZE);
+	if (ret)
+		buf[ret++] = '\n';
+
+	return ret;
+}
+
+static ssize_t pm_last_wakeup_irqs_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t n)
+{
+	return -EINVAL;
+}
+power_attr(pm_last_wakeup_irqs);
+
 #else /* !CONFIG_PM_SLEEP_DEBUG */
 static inline void pm_print_times_init(void) {}
 #endif /* CONFIG_PM_SLEEP_DEBUG */
@@ -604,6 +626,7 @@ static struct attribute * g[] = {
 #endif
 #ifdef CONFIG_PM_SLEEP_DEBUG
 	&pm_print_times_attr.attr,
+	&pm_last_wakeup_irqs_attr.attr,
 #endif
 #endif
 #ifdef CONFIG_FREEZER
-- 
1.9.1

