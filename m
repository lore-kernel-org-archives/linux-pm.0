From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V10] Report interrupt that caused system wakeup
Date: Mon, 14 Sep 2015 11:02:22 -0700
Message-ID: <1442253742-14240-1-git-send-email-alexandra.yates@linux.intel.com>
References: <[PATCH V10] Report interrupt that caused system wakeup>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:55257 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbbINSAW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 14 Sep 2015 14:00:22 -0400
In-Reply-To: <[PATCH V10] Report interrupt that caused system wakeup>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>

Add a sysfs attribute, /sys/power/pm_wakeup_irq, reporting the IRQ
number of the first wakeup interrupt (that is, the first interrupt
from an IRQ line armed for system wakeup) seen by the kernel during
the most recent system suspend/resume cycle.

This feature will be useful for system wakeup diagnostics of
spurious wakeup interrupts.

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-power | 12 ++++++++++++
 drivers/base/power/wakeup.c           |  9 +++++++++
 include/linux/suspend.h               |  5 +++++
 kernel/irq/pm.c                       |  3 ++-
 kernel/power/main.c                   | 18 ++++++++++++++++++
 5 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index f455181..50b368d 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -256,3 +256,15 @@ Description:
 		Writing a "1" enables this printing while writing a "0"
 		disables it.  The default value is "0".  Reading from this file
 		will display the current value.
+
+What:		/sys/power/pm_wakeup_irq
+Date:		April 2015
+Contact:	Alexandra Yates <alexandra.yates@linux.intel.org>
+Description:
+		The /sys/power/pm_wakeup_irq file reports to user space the IRQ
+		number of the first wakeup interrupt (that is, the first
+		interrupt from an IRQ line armed for system wakeup) seen by the
+		kernel during the most recent system suspend/resume cycle.
+
+		This output is useful for system wakeup diagnostics of spurious
+		wakeup interrupts.
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 51f15bc..93cc12d 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -868,6 +868,15 @@ EXPORT_SYMBOL_GPL(pm_system_wakeup);
 void pm_wakeup_clear(void)
 {
 	pm_abort_suspend = false;
+	wakeup_irq = 0;
+}
+
+void pm_system_irq_wakeup(unsigned int irq_number)
+{
+	if (wakeup_irq == 0) {
+		wakeup_irq = irq_number;
+		pm_system_wakeup();
+	}
 }
 
 /**
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 5efe743..686ba2f 100644
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
@@ -391,6 +394,7 @@ extern bool events_check_enabled;
 extern bool pm_wakeup_pending(void);
 extern void pm_system_wakeup(void);
 extern void pm_wakeup_clear(void);
+extern void pm_system_irq_wakeup(unsigned int);
 extern bool pm_get_wakeup_count(unsigned int *count, bool block);
 extern bool pm_save_wakeup_count(unsigned int count);
 extern void pm_wakep_autosleep_enabled(bool set);
@@ -440,6 +444,7 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
 static inline bool pm_wakeup_pending(void) { return false; }
 static inline void pm_system_wakeup(void) {}
 static inline void pm_wakeup_clear(void) {}
+static inline void pm_system_irq_wakeup(unsigned int) {}
 
 static inline void lock_system_sleep(void) {}
 static inline void unlock_system_sleep(void) {}
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index d22786a..d26a823 100644
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
@@ -73,6 +73,7 @@ static bool suspend_device_irq(struct irq_desc *desc, int irq)
 	if (!desc->action || desc->no_suspend_depth)
 		return false;
 
+
 	if (irqd_is_wakeup_set(&desc->irq_data)) {
 		irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
 		/*
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 63d395b..9880bf8 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -272,6 +272,23 @@ static inline void pm_print_times_init(void)
 {
 	pm_print_times_enabled = !!initcall_debug;
 }
+
+unsigned int wakeup_irq;
+static ssize_t pm_wakeup_irq_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					char *buf)
+{
+	return wakeup_irq ? sprintf(buf, "%u\n", wakeup_irq) : -ENODATA;
+}
+
+static ssize_t pm_wakeup_irq_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t n)
+{
+	return -EINVAL;
+}
+power_attr(pm_wakeup_irq);
+
 #else /* !CONFIG_PM_SLEEP_DEBUG */
 static inline void pm_print_times_init(void) {}
 #endif /* CONFIG_PM_SLEEP_DEBUG */
@@ -604,6 +621,7 @@ static struct attribute * g[] = {
 #endif
 #ifdef CONFIG_PM_SLEEP_DEBUG
 	&pm_print_times_attr.attr,
+	&pm_wakeup_irq_attr.attr,
 #endif
 #endif
 #ifdef CONFIG_FREEZER
-- 
1.9.1

