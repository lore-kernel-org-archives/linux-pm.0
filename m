From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: [RFC] RFC Events that triggered an interrupt
Date: Wed, 23 Sep 2015 14:09:16 -0700
Message-ID: <1443042556-8960-1-git-send-email-alexandra.yates@linux.intel.com>
References: <RFC Events that triggered an interrupt>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30942 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755128AbbIWVHN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Sep 2015 17:07:13 -0400
In-Reply-To: <RFC Events that triggered an interrupt>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net, kristen.c.accardi@intel.com, linux-power-mgmt@linux.intel.com
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>

Hello,

I need your advice on this development I'm working on.

In theory the patch is looking to find out which events
triggered an interrupt.  To do this, during suspend, the patch
records the current event counts for all GPEs in suspend_device_irqs().
During resume, the patch subtract those from the (new) current event
counts for all GPEs in resume_device_irqs()

However, when I executing the code all the values are 0.   it
seems that the functions counter_wake_show() and counter_wake_set()
never get executed.  Since the end result of the list of GPEs is blank.

If you have a better idea on how I can approach this solution
please send your feedback.

Thank you,
Alexandra.

Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
---
 drivers/acpi/sysfs.c | 263 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |   1 +
 kernel/irq/pm.c      |   3 +
 3 files changed, 267 insertions(+)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 40a4265..b1cf288 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -461,6 +461,7 @@ err:
 	return -ENOMEM;
 }
 
+
 /*
  * Detailed ACPI IRQ counters:
  * /sys/firmware/acpi/interrupts/
@@ -480,10 +481,15 @@ struct event_counter {
 	u32 flags;
 };
 
+
 static struct event_counter *all_counters;
+static struct event_counter *all_suspend_counters;
+static struct event_counter *all_resume_counters;
+
 static u32 num_gpes;
 static u32 num_counters;
 static struct attribute **all_attrs;
+static struct attribute **all_resume_attrs;
 static u32 acpi_gpe_count;
 
 static struct attribute_group interrupt_stats_attr_group = {
@@ -491,6 +497,7 @@ static struct attribute_group interrupt_stats_attr_group = {
 };
 
 static struct kobj_attribute *counter_attrs;
+static struct kobj_attribute *wake_counter_attrs;
 
 static void delete_gpe_attr_array(void)
 {
@@ -512,6 +519,29 @@ static void delete_gpe_attr_array(void)
 	return;
 }
 
+static void delete_wake_gpe_attr_array(void)
+{
+	struct event_counter *tmp = all_suspend_counters;
+	all_suspend_counters = NULL;
+	kfree(tmp);
+
+	tmp = all_resume_counters;
+	all_resume_counters = NULL;
+	kfree(tmp);
+
+	if(wake_counter_attrs){
+		int i;
+
+		for (i = 0; i < num_gpes; i++)
+			kfree(wake_counter_attrs[i].attr.name);
+
+		kfree(wake_counter_attrs);
+	}
+	kfree(all_resume_attrs);
+
+	return;
+}
+
 static void gpe_count(u32 gpe_number)
 {
 	acpi_gpe_count++;
@@ -591,6 +621,7 @@ static ssize_t counter_show(struct kobject *kobj,
 	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE].count =
 	    acpi_gpe_count;
 	size = sprintf(buf, "%8u", all_counters[index].count);
+	all_suspend_counters[index].count = all_counters[index].count;
 
 	/* "gpe_all" or "sci" */
 	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
@@ -688,6 +719,117 @@ end:
 	return result ? result : size;
 }
 
+static ssize_t counter_wake_set(struct kobject *kobj,
+			   struct kobj_attribute *attr, const char *buf,
+			   size_t size)
+{
+	int index = attr - wake_counter_attrs;
+	acpi_event_status status;
+	acpi_handle handle;
+	int result = 0;
+	unsigned long tmp;
+
+	if (index == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI) {
+		int i;
+		for (i = 0; i < num_counters; ++i)
+			all_resume_counters[i].count = 0;
+		acpi_gpe_count = 0;
+		acpi_irq_handled = 0;
+		acpi_irq_not_handled = 0;
+		goto end;
+	}
+
+	/* show the event status for both GPEs and Fixed Events */
+	result = get_status(index, &status, &handle);
+	if (result)
+		goto end;
+
+	if (!(status & ACPI_EVENT_FLAG_HAS_HANDLER)) {
+		printk(KERN_WARNING PREFIX
+		       "Can not change Invalid GPE/Fixed Event status\n");
+		return -EINVAL;
+	}
+
+	if (index < num_gpes) {
+		if (!strcmp(buf, "disable\n") &&
+		    (status & ACPI_EVENT_FLAG_ENABLED))
+			result = acpi_disable_gpe(handle, index);
+		else if (!strcmp(buf, "enable\n") &&
+			 !(status & ACPI_EVENT_FLAG_ENABLED))
+			result = acpi_enable_gpe(handle, index);
+		else if (!strcmp(buf, "clear\n") &&
+			 (status & ACPI_EVENT_FLAG_SET))
+			result = acpi_clear_gpe(handle, index);
+		else if (!kstrtoul(buf, 0, &tmp))
+			all_resume_counters[index].count = tmp;
+		else
+			result = -EINVAL;
+	} else if (index < num_gpes + ACPI_NUM_FIXED_EVENTS) {
+		int event = index - num_gpes;
+		if (!strcmp(buf, "disable\n") &&
+		    (status & ACPI_EVENT_FLAG_ENABLED))
+			result = acpi_disable_event(event, ACPI_NOT_ISR);
+		else if (!strcmp(buf, "enable\n") &&
+			 !(status & ACPI_EVENT_FLAG_ENABLED))
+			result = acpi_enable_event(event, ACPI_NOT_ISR);
+		else if (!strcmp(buf, "clear\n") &&
+			 (status & ACPI_EVENT_FLAG_SET))
+			result = acpi_clear_event(event);
+		else if (!kstrtoul(buf, 0, &tmp))
+			all_resume_counters[index].count = tmp;
+		else
+			result = -EINVAL;
+	} else
+		all_resume_counters[index].count = strtoul(buf, NULL, 0);
+
+	if (ACPI_FAILURE(result))
+		result = -EINVAL;
+end:
+	return result ? result : size;
+}
+
+
+static ssize_t counter_wake_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	int index = attr - counter_attrs;
+	int size=0;
+	acpi_handle handle;
+	acpi_event_status status;
+	int result = 0;
+
+	all_resume_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI].count =
+	    acpi_irq_handled;
+	all_resume_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI_NOT].count =
+	    acpi_irq_not_handled;
+	all_resume_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE].count =
+	    acpi_gpe_count;
+
+	size = sprintf(buf, "%8u", all_resume_counters[index].count);
+
+
+	/* "gpe_all" or "sci" */
+	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
+		goto end;
+
+	result = get_status(index, &status, &handle);
+	if (result)
+		goto end;
+
+	if (!(status & ACPI_EVENT_FLAG_HAS_HANDLER))
+		size += sprintf(buf + size, "   invalid");
+	else if (status & ACPI_EVENT_FLAG_ENABLED)
+		size += sprintf(buf + size, "   enabled");
+	else if (status & ACPI_EVENT_FLAG_WAKE_ENABLED)
+		size += sprintf(buf + size, "   wake_enabled");
+	else
+		size += sprintf(buf + size, "   disabled");
+
+end:
+	size += sprintf(buf + size, "\n");
+	return result ? result : size;
+}
+
 void acpi_irq_stats_init(void)
 {
 	acpi_status status;
@@ -708,6 +850,11 @@ void acpi_irq_stats_init(void)
 			       GFP_KERNEL);
 	if (all_counters == NULL)
 		goto fail;
+	all_suspend_counters = kzalloc(sizeof(struct event_counter) * (num_gpes),
+                               GFP_KERNEL);
+        if (all_suspend_counters == NULL){
+                goto fail;
+	}
 
 	status = acpi_install_global_event_handler(acpi_global_event_handler, NULL);
 	if (ACPI_FAILURE(status))
@@ -776,6 +923,122 @@ static void __exit interrupt_stats_exit(void)
 	return;
 }
 
+/*
+ * Detailed ACPI IRQ counters:
+ * /sys/firmware/acpi/wakeups/
+ */
+static struct attribute_group wakeup_stats_attr_group = {
+        .name = "wakeup",
+};
+
+
+void acpi_wake_resume_events_init(void)
+{
+	/* only to run once during resume*/
+	//acpi_status status;
+	int i;
+	if (all_resume_counters)
+		return;
+
+	num_gpes = acpi_current_gpe_count;
+	num_counters = num_gpes + ACPI_NUM_FIXED_EVENTS + NUM_COUNTERS_EXTRA;
+
+	all_resume_attrs = kzalloc(sizeof(struct attribute *) * (num_counters + 1),
+			    GFP_KERNEL);
+	if (all_resume_attrs == NULL)
+		return;
+
+
+	all_resume_counters = kzalloc(sizeof(struct event_counter) * (num_counters),
+			       GFP_KERNEL);
+	if (all_resume_counters == NULL)
+		goto fail;
+	printk("\n *  *  *  * acpi_wake_resume_events init all_resume_counters \n");
+
+	wake_counter_attrs = kzalloc(sizeof(struct kobj_attribute) * (num_counters),
+				GFP_KERNEL);
+	if (wake_counter_attrs == NULL)
+		goto fail;
+	printk("\n *  *  *  * acpi_wake_resume_events init wake_counter_attrs \n");
+
+
+	printk("\n *  *  *  * acpi_wake_resume_events_init after init drivers/acpi/sysfs.c\n");
+	for (i = 0; i < num_gpes; ++i) {
+                char buffer[12];
+                char *name;
+
+		if (i < num_gpes)
+			sprintf(buffer, "gpe%02X", i);
+		else if (i == num_gpes + ACPI_EVENT_PMTIMER)
+			sprintf(buffer, "ff_pmtimer");
+		else if (i == num_gpes + ACPI_EVENT_GLOBAL)
+			sprintf(buffer, "ff_gbl_lock");
+		else if (i == num_gpes + ACPI_EVENT_POWER_BUTTON)
+			sprintf(buffer, "ff_pwr_btn");
+		else if (i == num_gpes + ACPI_EVENT_SLEEP_BUTTON)
+			sprintf(buffer, "ff_slp_btn");
+		else if (i == num_gpes + ACPI_EVENT_RTC)
+			sprintf(buffer, "ff_rt_clk");
+		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE)
+			sprintf(buffer, "gpe_all");
+		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI)
+			sprintf(buffer, "sci");
+		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI_NOT)
+			sprintf(buffer, "sci_not");
+		else if (i == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_ERROR)
+			sprintf(buffer, "error");
+		else
+			sprintf(buffer, "bug%02X", i);
+
+		name = kstrdup(buffer, GFP_KERNEL);
+		if (name == NULL)
+			goto fail;
+
+		sysfs_attr_init(&wake_counter_attrs[i].attr);
+		wake_counter_attrs[i].attr.name = name;
+		wake_counter_attrs[i].attr.mode = 0644;
+		wake_counter_attrs[i].show = counter_wake_show;
+		wake_counter_attrs[i].store = counter_wake_set;
+
+
+		/*
+		 * I like to use this commented condition to filter what GPEs changed but
+		 * when enabled /sys/firmware/acpi/wakeup/ is empty.
+		 * Addtioanlly printing all_resume_counters and all_suspend_counters at
+		 * this level the out put is 0.
+		 * However, printing all at the conter_wake_show/counter_wake_set level
+		 * dmesg desnt show a printout of any values. I also tried placing
+		 * decicion clause inside conter_wake_show/counter_wake_set but then the
+		 * counters become trashed within the GPE files.
+		 * Without the if statement the system would print the GPEs as in
+		 * /sys/firmware/acpi/interrupts.  With the statement enabled then
+		 * it doesn't print anything.
+		 * if (abs(all_resume_counters[i].count - all_suspend_counters[i].count) != 0)
+		 */
+			all_resume_attrs[i] = &wake_counter_attrs[i].attr;
+        }
+        wakeup_stats_attr_group.attrs = all_resume_attrs;
+	printk("\n *  *  *  * acpi_wake_resume_events_init END drivers/acpi/sysfs.c\n");
+        if (!sysfs_create_group(acpi_kobj, &wakeup_stats_attr_group))
+                return;
+
+fail:
+	printk("\n *  *  *  * acpi_wake_resume_events_init ERROR drivers/acpi/sysfs.c\n");
+	delete_wake_gpe_attr_array();
+        //delete_gpe_attr_array();
+        return;
+}
+
+static void __exit acpi_wake_resume_events_exit(void)
+{
+        sysfs_remove_group(acpi_kobj, &wakeup_stats_attr_group);
+
+	delete_wake_gpe_attr_array();
+
+        return;
+}
+
+
 static ssize_t
 acpi_show_profile(struct device *dev, struct device_attribute *attr,
 		  char *buf)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7235c48..5c983de 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -191,6 +191,7 @@ int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base);
 int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base);
 int acpi_ioapic_registered(acpi_handle handle, u32 gsi_base);
 void acpi_irq_stats_init(void);
+void acpi_wake_resume_events_init(void);
 extern u32 acpi_irq_handled;
 extern u32 acpi_irq_not_handled;
 
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 21c6261..c5383b4 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/irq.h>
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
@@ -158,6 +159,8 @@ static void resume_irqs(bool want_early)
 	struct irq_desc *desc;
 	int irq;
 
+	printk("\n* * * * from kernel/irq/pm.c\n");
+	acpi_wake_resume_events_init();
 	for_each_irq_desc(irq, desc) {
 		unsigned long flags;
 		bool is_early = desc->action &&
-- 
1.9.1

