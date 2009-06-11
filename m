From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 18/19] PM/Hibernate: Move NVS routines into a
	seperate file (v2).
Date: Thu, 11 Jun 2009 22:12:14 +0000 (UTC)
Message-ID: <S4AoGnG.A.D7H.mZXMKB__29059.2765239582$1244758334$gmane$org@chimera>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Date: Thu Jun 11 23:25:58 CEST 2009
In-Reply-To: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM List <linux-pm@lists.linux-foundation.org>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, Ingo Molnar <mingo@elte.hu>, Wu Fengguang <fengguang.wu@intel.com>, Jaswinder Singh Rajput <jaswinder@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

The *_nvs_* routines in swsusp.c make use of the io*map()
functions, which are only provided for HAS_IOMEM, thus
breaking compilation if HAS_IOMEM is not set. Fix this
by moving the *_nvs_* routines into hibernate_nvs.c, which
is only compiled if HAS_IOMEM is set.

[rjw: Change the name of the new file to hibernate_nvs.c, add the
 license line to the header comment.]

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/suspend.h      |   18 ++++--
 kernel/power/Kconfig         |    4 +
 kernel/power/Makefile        |    1 +
 kernel/power/hibernate_nvs.c |  135 ++++++++++++++++++++++++++++++++++++++++++
 kernel/power/swsusp.c        |  122 --------------------------------------
 5 files changed, 151 insertions(+), 129 deletions(-)
 create mode 100644 kernel/power/hibernate_nvs.c

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 795032e..cd15df6 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -245,11 +245,6 @@ extern unsigned long get_safe_page(gfp_t gfp_mask);
 
 extern void hibernation_set_ops(struct platform_hibernation_ops *ops);
 extern int hibernate(void);
-extern int hibernate_nvs_register(unsigned long start, unsigned long size);
-extern int hibernate_nvs_alloc(void);
-extern void hibernate_nvs_free(void);
-extern void hibernate_nvs_save(void);
-extern void hibernate_nvs_restore(void);
 extern bool system_entering_hibernation(void);
 #else /* CONFIG_HIBERNATION */
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
@@ -258,6 +253,16 @@ static inline void swsusp_unset_page_free(struct page *p) {}
 
 static inline void hibernation_set_ops(struct platform_hibernation_ops *ops) {}
 static inline int hibernate(void) { return -ENOSYS; }
+static inline bool system_entering_hibernation(void) { return false; }
+#endif /* CONFIG_HIBERNATION */
+
+#ifdef CONFIG_HIBERNATION_NVS
+extern int hibernate_nvs_register(unsigned long start, unsigned long size);
+extern int hibernate_nvs_alloc(void);
+extern void hibernate_nvs_free(void);
+extern void hibernate_nvs_save(void);
+extern void hibernate_nvs_restore(void);
+#else /* CONFIG_HIBERNATION_NVS */
 static inline int hibernate_nvs_register(unsigned long a, unsigned long b)
 {
 	return 0;
@@ -266,8 +271,7 @@ static inline int hibernate_nvs_alloc(void) { return 0; }
 static inline void hibernate_nvs_free(void) {}
 static inline void hibernate_nvs_save(void) {}
 static inline void hibernate_nvs_restore(void) {}
-static inline bool system_entering_hibernation(void) { return false; }
-#endif /* CONFIG_HIBERNATION */
+#endif /* CONFIG_HIBERNATION_NVS */
 
 #ifdef CONFIG_PM_SLEEP
 void save_processor_state(void);
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 23bd4da..72067cb 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -116,9 +116,13 @@ config SUSPEND_FREEZER
 
 	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
 
+config HIBERNATION_NVS
+	bool
+
 config HIBERNATION
 	bool "Hibernation (aka 'suspend to disk')"
 	depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
+	select HIBERNATION_NVS if HAS_IOMEM
 	---help---
 	  Enable the suspend to disk (STD) functionality, which is usually
 	  called "hibernation" in user interfaces.  STD checkpoints the
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index eadb17f..c3b81c3 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_FREEZER)		+= process.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PM_TEST_SUSPEND)	+= suspend_test.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o hibernate.o snapshot.o swap.o user.o
+obj-$(CONFIG_HIBERNATION_NVS)	+= hibernate_nvs.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
diff --git a/kernel/power/hibernate_nvs.c b/kernel/power/hibernate_nvs.c
new file mode 100644
index 0000000..39ac698
--- /dev/null
+++ b/kernel/power/hibernate_nvs.c
@@ -0,0 +1,135 @@
+/*
+ * linux/kernel/power/hibernate_nvs.c - Routines for handling NVS memory
+ *
+ * Copyright (C) 2008,2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
+ *
+ * This file is released under the GPLv2.
+ */
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/suspend.h>
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
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
index 87b901c..6a07f4d 100644
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -186,125 +186,3 @@ void swsusp_show_speed(struct timeval *start, struct timeval *stop,
 			centisecs / 100, centisecs % 100,
 			kps / 1000, (kps % 1000) / 10);
 }
-
-/*
- * Platforms, like ACPI, may want us to save some memory used by them during
- * hibernation and to restore the contents of this memory during the subsequent
- * resume.  The code below implements a mechanism allowing us to do that.
- */
-
-struct nvs_page {
-	unsigned long phys_start;
-	unsigned int size;
-	void *kaddr;
-	void *data;
-	struct list_head node;
-};
-
-static LIST_HEAD(nvs_list);
-
-/**
- *	hibernate_nvs_register - register platform NVS memory region to save
- *	@start - physical address of the region
- *	@size - size of the region
- *
- *	The NVS region need not be page-aligned (both ends) and we arrange
- *	things so that the data from page-aligned addresses in this region will
- *	be copied into separate RAM pages.
- */
-int hibernate_nvs_register(unsigned long start, unsigned long size)
-{
-	struct nvs_page *entry, *next;
-
-	while (size > 0) {
-		unsigned int nr_bytes;
-
-		entry = kzalloc(sizeof(struct nvs_page), GFP_KERNEL);
-		if (!entry)
-			goto Error;
-
-		list_add_tail(&entry->node, &nvs_list);
-		entry->phys_start = start;
-		nr_bytes = PAGE_SIZE - (start & ~PAGE_MASK);
-		entry->size = (size < nr_bytes) ? size : nr_bytes;
-
-		start += entry->size;
-		size -= entry->size;
-	}
-	return 0;
-
- Error:
-	list_for_each_entry_safe(entry, next, &nvs_list, node) {
-		list_del(&entry->node);
-		kfree(entry);
-	}
-	return -ENOMEM;
-}
-
-/**
- *	hibernate_nvs_free - free data pages allocated for saving NVS regions
- */
-void hibernate_nvs_free(void)
-{
-	struct nvs_page *entry;
-
-	list_for_each_entry(entry, &nvs_list, node)
-		if (entry->data) {
-			free_page((unsigned long)entry->data);
-			entry->data = NULL;
-			if (entry->kaddr) {
-				iounmap(entry->kaddr);
-				entry->kaddr = NULL;
-			}
-		}
-}
-
-/**
- *	hibernate_nvs_alloc - allocate memory necessary for saving NVS regions
- */
-int hibernate_nvs_alloc(void)
-{
-	struct nvs_page *entry;
-
-	list_for_each_entry(entry, &nvs_list, node) {
-		entry->data = (void *)__get_free_page(GFP_KERNEL);
-		if (!entry->data) {
-			hibernate_nvs_free();
-			return -ENOMEM;
-		}
-	}
-	return 0;
-}
-
-/**
- *	hibernate_nvs_save - save NVS memory regions
- */
-void hibernate_nvs_save(void)
-{
-	struct nvs_page *entry;
-
-	printk(KERN_INFO "PM: Saving platform NVS memory\n");
-
-	list_for_each_entry(entry, &nvs_list, node)
-		if (entry->data) {
-			entry->kaddr = ioremap(entry->phys_start, entry->size);
-			memcpy(entry->data, entry->kaddr, entry->size);
-		}
-}
-
-/**
- *	hibernate_nvs_restore - restore NVS memory regions
- *
- *	This function is going to be called with interrupts disabled, so it
- *	cannot iounmap the virtual addresses used to access the NVS region.
- */
-void hibernate_nvs_restore(void)
-{
-	struct nvs_page *entry;
-
-	printk(KERN_INFO "PM: Restoring platform NVS memory\n");
-
-	list_for_each_entry(entry, &nvs_list, node)
-		if (entry->data)
-			memcpy(entry->kaddr, entry->data, entry->size);
-}
-- 
1.5.2.4
