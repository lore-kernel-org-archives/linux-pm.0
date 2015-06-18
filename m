From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [PATCH V4] Report interrupt(s) that caused system wakeup
Date: Wed, 17 Jun 2015 18:08:41 -0700
Message-ID: <1434589721-15018-2-git-send-email-alexandra.yates@linux.intel.com>
References: <1434589721-15018-1-git-send-email-alexandra.yates@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30715 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbbFRBHk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Jun 2015 21:07:40 -0400
In-Reply-To: <1434589721-15018-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org, peterz@infradead.org, Alexandra Yates <alexandra.yates@linux.intel.com>

Add a new IRQ flag named IRQD_WAKEUP_TRIGGERED.  This flag is set
when a given IRQ fires after it has been armed for system wakeup.
The flag is cleared before arming the IRQ for system wakeup
during the next system suspend. This feature makes possible to
check which IRQs might have woken the system up from sleep last
time it was suspended.

Add a new sysfs attribute under /sys/power/ named:pm_last_wakeup_irqs
when read, will return a list of IRQs with the new flag set.  That
will be useful for system wakeup diagnostics.

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-power | 11 +++++++++++
 drivers/base/power/wakeup.c           | 31 +++++++++++++++++++++++++++++++
 include/linux/irq.h                   |  7 +++++++
 include/linux/suspend.h               |  1 +
 kernel/irq/pm.c                       |  2 ++
 kernel/power/main.c                   | 23 +++++++++++++++++++++++
 6 files changed, 75 insertions(+)

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
index 7726200..1f15863 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -737,6 +737,37 @@ void pm_wakeup_clear(void)
 	pm_abort_suspend = false;
 }
 
+#ifdef CONFIG_PM_SLEEP_DEBUG
+/*
+ * pm_get_last_wakeup_irqs - Parses interrupts to identify which one
+ * caused the system to wake up from suspend-to-idle.
+ * @buf: keeps track of the irqs that casued the system to wakeup
+ */
+ssize_t pm_get_last_wakeup_irqs(char *buf, size_t size)
+{
+	struct irq_desc *desc;
+	int irq;
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
+	for_each_irq_desc(irq, desc)
+		if (irqd_triggered_wakeup(&desc->irq_data))
+			str += scnprintf(str, end - str, "%d ", irq);
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
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 62c6901..9b1a31f 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -182,6 +182,7 @@ struct irq_data {
  * IRQD_IRQ_MASKED		- Masked state of the interrupt
  * IRQD_IRQ_INPROGRESS		- In progress state of the interrupt
  * IRQD_WAKEUP_ARMED		- Wakeup mode armed
+ * IRQD_WAKEUP_TRIGGERED	- Triggered system wakeup
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -196,8 +197,14 @@ enum {
 	IRQD_IRQ_MASKED			= (1 << 17),
 	IRQD_IRQ_INPROGRESS		= (1 << 18),
 	IRQD_WAKEUP_ARMED		= (1 << 19),
+	IRQD_WAKEUP_TRIGGERED		= (1 << 20),
 };
 
+static inline bool irqd_triggered_wakeup(struct irq_data *d)
+{
+	return d->state_use_accessors & IRQD_WAKEUP_TRIGGERED;
+}
+
 static inline bool irqd_is_setaffinity_pending(struct irq_data *d)
 {
 	return d->state_use_accessors & IRQD_SETAFFINITY_PENDING;
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 5efe743..7cadded 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -378,6 +378,7 @@ void restore_processor_state(void);
 /* kernel/power/main.c */
 extern int register_pm_notifier(struct notifier_block *nb);
 extern int unregister_pm_notifier(struct notifier_block *nb);
+extern ssize_t pm_get_last_wakeup_irqs(char *buf, size_t size);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 5204a6d..52dc34c 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -22,6 +22,7 @@ bool irq_pm_check_wakeup(struct irq_desc *desc)
 		desc->depth++;
 		irq_disable(desc);
 		pm_system_wakeup();
+		irqd_set(&desc->irq_data, IRQD_WAKEUP_TRIGGERED);
 		return true;
 	}
 	return false;
@@ -73,6 +74,7 @@ static bool suspend_device_irq(struct irq_desc *desc, int irq)
 	if (!desc->action || desc->no_suspend_depth)
 		return false;
 
+	irqd_clear(&desc->irq_data, IRQD_WAKEUP_TRIGGERED);
 	if (irqd_is_wakeup_set(&desc->irq_data)) {
 		irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
 		/*
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 86e8157..77b46d8 100644
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
 #else /* !CONFIG_PP_SLEEP_DEBUG */
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

