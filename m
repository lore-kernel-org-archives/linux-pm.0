From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V7] Report interrupt that caused system wakeup
Date: Wed,  9 Sep 2015 19:48:21 -0700
Message-ID: <1441853301-3816-1-git-send-email-alexandra.yates@linux.intel.com>
References: <[PATCH V7] Report interrupt that caused system wakeup>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:10516 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766AbbIJCqb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Sep 2015 22:46:31 -0400
In-Reply-To: <[PATCH V7] Report interrupt that caused system wakeup>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>

This feature reports which IRQ cause the system to wakeup from sleep last
time it was suspended.

It adds a new sysfs attribute under /sys/power/ named: pm_last_wakeup_irq
when read, will return the IRQ that caused the system to wakeup.
That will be useful for system wakeup diagnostics.

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-power | 11 +++++++++++
 drivers/base/power/wakeup.c           | 12 ++++++++++++
 include/linux/suspend.h               |  8 +++++++-
 kernel/irq/pm.c                       |  4 ++--
 kernel/power/main.c                   | 19 +++++++++++++++++++
 5 files changed, 51 insertions(+), 3 deletions(-)

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
index 51f15bc..f663fb1 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -870,6 +870,18 @@ void pm_wakeup_clear(void)
 	pm_abort_suspend = false;
 }
 
+void pm_system_irq_wakeup(unsigned int irq_number)
+{
+	if (wakeup_irq == 0)
+		wakeup_irq = irq_number;
+	pm_system_wakeup();
+}
+
+void pm_last_wakeup_irq_reset(void)
+{
+	wakeup_irq = 0;
+}
+
 /**
  * pm_get_wakeup_count - Read the number of registered wakeup events.
  * @count: Address to store the value at.
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 5efe743..eb5ad3b 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -371,6 +371,9 @@ static inline bool hibernation_available(void) { return false; }
 
 extern struct mutex pm_mutex;
 
+/* IRQ number which causes system wakeup  */
+extern unsigned int wakeup_irq;
+
 #ifdef CONFIG_PM_SLEEP
 void save_processor_state(void);
 void restore_processor_state(void);
@@ -378,7 +381,7 @@ void restore_processor_state(void);
 /* kernel/power/main.c */
 extern int register_pm_notifier(struct notifier_block *nb);
 extern int unregister_pm_notifier(struct notifier_block *nb);
-
+extern void pm_last_wakeup_irq_reset(void);
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
 		{ .notifier_call = fn, .priority = pri };	\
@@ -391,6 +394,7 @@ extern bool events_check_enabled;
 extern bool pm_wakeup_pending(void);
 extern void pm_system_wakeup(void);
 extern void pm_wakeup_clear(void);
+extern void pm_system_irq_wakeup(unsigned int);
 extern bool pm_get_wakeup_count(unsigned int *count, bool block);
 extern bool pm_save_wakeup_count(unsigned int count);
 extern void pm_wakep_autosleep_enabled(bool set);
@@ -440,6 +444,8 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
 static inline bool pm_wakeup_pending(void) { return false; }
 static inline void pm_system_wakeup(void) {}
 static inline void pm_wakeup_clear(void) {}
+static inline void pm_system_irq_wakeup(unsigned int) {}
+static inline void pm_last_wakeup_irq_reset(void){};
 
 static inline void lock_system_sleep(void) {}
 static inline void unlock_system_sleep(void) {}
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index d22786a..18178d7 100644
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
@@ -118,7 +118,7 @@ void suspend_device_irqs(void)
 {
 	struct irq_desc *desc;
 	int irq;
-
+	pm_last_wakeup_irq_reset();
 	for_each_irq_desc(irq, desc) {
 		unsigned long flags;
 		bool sync;
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 63d395b..d2bd164 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -272,6 +272,24 @@ static inline void pm_print_times_init(void)
 {
 	pm_print_times_enabled = !!initcall_debug;
 }
+
+unsigned int wakeup_irq;
+EXPORT_SYMBOL_GPL(wakeup_irq);
+static ssize_t pm_last_wakeup_irq_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					char *buf)
+{
+	return wakeup_irq ? sprintf(buf, "%u\n", wakeup_irq) : -EINVAL;
+}
+
+static ssize_t pm_last_wakeup_irq_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t n)
+{
+	return -EINVAL;
+}
+power_attr(pm_last_wakeup_irq);
+
 #else /* !CONFIG_PM_SLEEP_DEBUG */
 static inline void pm_print_times_init(void) {}
 #endif /* CONFIG_PM_SLEEP_DEBUG */
@@ -604,6 +622,7 @@ static struct attribute * g[] = {
 #endif
 #ifdef CONFIG_PM_SLEEP_DEBUG
 	&pm_print_times_attr.attr,
+	&pm_last_wakeup_irq_attr.attr,
 #endif
 #endif
 #ifdef CONFIG_FREEZER
-- 
1.9.1

