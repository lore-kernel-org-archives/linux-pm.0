From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/4] ACPI hibernate: Add a mechanism to
	save/restore ACPI NVS memory
Date: Sun, 26 Oct 2008 20:52:15 +0100
Message-ID: <200810262052.16431.rjw__1050.36093523285$1225051436$gmane$org@sisk.pl>
References: <200810262048.23468.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200810262048.23468.rjw@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: [PATCH] ACPI hibernate: Add a mechanism to save/restore ACPI NVS memory

According to the ACPI Specification 3.0b, Section 15.3.2,
"OSPM will call the _PTS control method some time before entering a
sleeping state, to allow the platform's AML code to update this
memory image before entering the sleeping state. After the system
awakes from an S4 state, OSPM will restore this memory area and call
the _WAK control method to enable the BIOS to reclaim its memory
image."  For this reason, implement a mechanism allowing us to save
the NVS memory during hibernation and to restore it during the
subsequent resume.

Based on a patch by Zhang Rui.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Nigel Cunningham <nigel@tuxonice.net>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/sleep/main.c |   53 +++++++++++++++++---
 include/linux/suspend.h   |   13 +++++
 kernel/power/swsusp.c     |  122 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
index 80c0868..f861b73 100644
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -356,9 +356,25 @@ void __init acpi_no_s4_hw_signature(void)
 
 static int acpi_hibernation_begin(void)
 {
-	acpi_target_sleep_state = ACPI_STATE_S4;
-	acpi_sleep_tts_switch(acpi_target_sleep_state);
-	return 0;
+	int error;
+
+	error = hibernate_nvs_alloc();
+	if (!error) {
+		acpi_target_sleep_state = ACPI_STATE_S4;
+		acpi_sleep_tts_switch(acpi_target_sleep_state);
+	}
+
+	return error;
+}
+
+static int acpi_hibernation_pre_snapshot(void)
+{
+	int error = acpi_pm_prepare();
+
+	if (!error)
+		hibernate_nvs_save();
+
+	return error;
 }
 
 static int acpi_hibernation_enter(void)
@@ -379,6 +395,12 @@ static int acpi_hibernation_enter(void)
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
+static void acpi_hibernation_finish(void)
+{
+	hibernate_nvs_free();
+	acpi_pm_finish();
+}
+
 static void acpi_hibernation_leave(void)
 {
 	/*
@@ -394,6 +416,8 @@ static void acpi_hibernation_leave(void)
 			"cannot resume!\n");
 		panic("ACPI S4 hardware signature mismatch");
 	}
+	/* Restore the NVS memory area */
+	hibernate_nvs_restore();
 }
 
 static void acpi_pm_enable_gpes(void)
@@ -404,8 +428,8 @@ static void acpi_pm_enable_gpes(void)
 static struct platform_hibernation_ops acpi_hibernation_ops = {
 	.begin = acpi_hibernation_begin,
 	.end = acpi_pm_end,
-	.pre_snapshot = acpi_pm_prepare,
-	.finish = acpi_pm_finish,
+	.pre_snapshot = acpi_hibernation_pre_snapshot,
+	.finish = acpi_hibernation_finish,
 	.prepare = acpi_pm_prepare,
 	.enter = acpi_hibernation_enter,
 	.leave = acpi_hibernation_leave,
@@ -431,8 +455,21 @@ static int acpi_hibernation_begin_old(void)
 
 	error = acpi_sleep_prepare(ACPI_STATE_S4);
 
+	if (!error) {
+		error = hibernate_nvs_alloc();
+		if (!error)
+			acpi_target_sleep_state = ACPI_STATE_S4;
+	}
+	return error;
+}
+
+static int acpi_hibernation_pre_snapshot_old(void)
+{
+	int error = acpi_pm_disable_gpes();
+
 	if (!error)
-		acpi_target_sleep_state = ACPI_STATE_S4;
+		hibernate_nvs_save();
+
 	return error;
 }
 
@@ -443,8 +480,8 @@ static int acpi_hibernation_begin_old(void)
 static struct platform_hibernation_ops acpi_hibernation_ops_old = {
 	.begin = acpi_hibernation_begin_old,
 	.end = acpi_pm_end,
-	.pre_snapshot = acpi_pm_disable_gpes,
-	.finish = acpi_pm_finish,
+	.pre_snapshot = acpi_hibernation_pre_snapshot_old,
+	.finish = acpi_hibernation_finish,
 	.prepare = acpi_pm_disable_gpes,
 	.enter = acpi_hibernation_enter,
 	.leave = acpi_hibernation_leave,
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 2ce8207..2b409c4 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -232,6 +232,11 @@ extern unsigned long get_safe_page(gfp_t gfp_mask);
 
 extern void hibernation_set_ops(struct platform_hibernation_ops *ops);
 extern int hibernate(void);
+extern int hibernate_nvs_register(unsigned long start, unsigned long size);
+extern int hibernate_nvs_alloc(void);
+extern void hibernate_nvs_free(void);
+extern void hibernate_nvs_save(void);
+extern void hibernate_nvs_restore(void);
 #else /* CONFIG_HIBERNATION */
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
 static inline void swsusp_set_page_free(struct page *p) {}
@@ -239,6 +244,14 @@ static inline void swsusp_unset_page_free(struct page *p) {}
 
 static inline void hibernation_set_ops(struct platform_hibernation_ops *ops) {}
 static inline int hibernate(void) { return -ENOSYS; }
+static inline int hibernate_nvs_register(unsigned long a, unsigned long b)
+{
+	return 0;
+}
+static inline int hibernate_nvs_alloc(void) { return 0; }
+static inline void hibernate_nvs_free(void) {}
+static inline void hibernate_nvs_save(void) {}
+static inline void hibernate_nvs_restore(void) {}
 #endif /* CONFIG_HIBERNATION */
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
index 023ff2a..a92c914 100644
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -262,3 +262,125 @@ int swsusp_shrink_memory(void)
 
 	return 0;
 }
+
+/*
+ * Platforms, like ACPI, may want us to save some memory used by them during
+ * hibernation and to restore the contents of this memory during the subsequent
+ * resume.  The code below implements a mechanism allowing us to do that.
+ */
+
+struct nvs_page {
+	unsigned long phys_start;
+	unsigned int size;
+	void *kaddr;
+	void *data;
+	struct list_head node;
+};
+
+static LIST_HEAD(nvs_list);
+
+/**
+ *	hibernate_nvs_register - register platform NVS memory region to save
+ *	@start - physical address of the region
+ *	@size - size of the region
+ *
+ *	The NVS region need not be page-aligned (both ends) and we arrange
+ *	things so that the data from page-aligned addresses in this region will
+ *	be copied into separate RAM pages.
+ */
+int hibernate_nvs_register(unsigned long start, unsigned long size)
+{
+	struct nvs_page *entry, *next;
+
+	while (size > 0) {
+		unsigned int nr_bytes;
+
+		entry = kzalloc(sizeof(struct nvs_page), GFP_KERNEL);
+		if (!entry)
+			goto Error;
+
+		list_add_tail(&entry->node, &nvs_list);
+		entry->phys_start = start;
+		nr_bytes = PAGE_SIZE - (start & ~PAGE_MASK);
+		entry->size = (size < nr_bytes) ? size : nr_bytes;
+
+		start += entry->size;
+		size -= entry->size;
+	}
+	return 0;
+
+ Error:
+	list_for_each_entry_safe(entry, next, &nvs_list, node) {
+		list_del(&entry->node);
+		kfree(entry);
+	}
+	return -ENOMEM;
+}
+
+/**
+ *	hibernate_nvs_free - free data pages allocated for saving NVS regions
+ */
+void hibernate_nvs_free(void)
+{
+	struct nvs_page *entry;
+
+	list_for_each_entry(entry, &nvs_list, node)
+		if (entry->data) {
+			free_page((unsigned long)entry->data);
+			entry->data = NULL;
+			if (entry->kaddr) {
+				iounmap(entry->kaddr);
+				entry->kaddr = NULL;
+			}
+		}
+}
+
+/**
+ *	hibernate_nvs_alloc - allocate memory necessary for saving NVS regions
+ */
+int hibernate_nvs_alloc(void)
+{
+	struct nvs_page *entry;
+
+	list_for_each_entry(entry, &nvs_list, node) {
+		entry->data = (void *)__get_free_page(GFP_KERNEL);
+		if (!entry->data) {
+			hibernate_nvs_free();
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+/**
+ *	hibernate_nvs_save - save NVS memory regions
+ */
+void hibernate_nvs_save(void)
+{
+	struct nvs_page *entry;
+
+	printk(KERN_INFO "PM: Saving platform NVS memory\n");
+
+	list_for_each_entry(entry, &nvs_list, node)
+		if (entry->data) {
+			entry->kaddr = ioremap(entry->phys_start, entry->size);
+			memcpy(entry->data, entry->kaddr, entry->size);
+		}
+}
+
+/**
+ *	hibernate_nvs_restore - restore NVS memory regions
+ *
+ *	This function is going to be called with interrupts disabled, so it
+ *	cannot iounmap the virtual addresses used to access the NVS region.
+ */
+void hibernate_nvs_restore(void)
+{
+	struct nvs_page *entry;
+
+	printk(KERN_INFO "PM: Restoring platform NVS memory\n");
+
+	list_for_each_entry(entry, &nvs_list, node)
+		if (entry->data)
+			memcpy(entry->kaddr, entry->data, entry->size);
+}
-- 
1.5.6
