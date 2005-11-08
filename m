From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH 2/2] swsusp: improve freeing of memory
Date: Wed, 9 Nov 2005 00:11:52 +0100
Message-ID: <200511090011.53125.rjw@sisk.pl>
References: <200511082355.43984.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============20969895248840009=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200511082355.43984.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============20969895248840009==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch makes swsusp free only as much memory as needed and not as much
as possible.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 include/linux/suspend.h |    2 -
 kernel/power/disk.c     |   30 ++--------------------
 kernel/power/power.h    |    2 +
 kernel/power/snapshot.c |   64 ++++++++++++++++++++++++++++++++++++++++++++----
 kernel/power/swsusp.c   |   41 ++++++++++++++++++++++++++++++
 5 files changed, 105 insertions(+), 34 deletions(-)

Index: linux-2.6.14-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.14-mm1.orig/kernel/power/disk.c	2005-11-07 23:31:40.000000000 +0100
+++ linux-2.6.14-mm1/kernel/power/disk.c	2005-11-07 23:32:28.000000000 +0100
@@ -24,6 +24,7 @@
 
 extern suspend_disk_method_t pm_disk_mode;
 
+extern int swsusp_shrink_memory(void);
 extern int swsusp_suspend(void);
 extern int swsusp_write(void);
 extern int swsusp_check(void);
@@ -73,31 +74,6 @@
 static int in_suspend __nosavedata = 0;
 
 
-/**
- *	free_some_memory -  Try to free as much memory as possible
- *
- *	... but do not OOM-kill anyone
- *
- *	Notice: all userland should be stopped at this point, or
- *	livelock is possible.
- */
-
-static void free_some_memory(void)
-{
-	unsigned int i = 0;
-	unsigned int tmp;
-	unsigned long pages = 0;
-	char *p = "-\\|/";
-
-	printk("Freeing memory...  ");
-	while ((tmp = shrink_all_memory(10000))) {
-		pages += tmp;
-		printk("\b%c", p[i++ % 4]);
-	}
-	printk("\bdone (%li pages freed)\n", pages);
-}
-
-
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
@@ -127,8 +103,8 @@
 	}
 
 	/* Free memory before shutting down devices. */
-	free_some_memory();
-	return 0;
+	if (!(error = swsusp_shrink_memory()))
+		return 0;
 thaw:
 	thaw_processes();
 	enable_nonboot_cpus();
Index: linux-2.6.14-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.14-mm1.orig/kernel/power/power.h	2005-11-07 23:31:40.000000000 +0100
+++ linux-2.6.14-mm1/kernel/power/power.h	2005-11-07 23:32:29.000000000 +0100
@@ -60,7 +60,9 @@
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
 
+extern unsigned int count_data_pages(void);
 extern void free_pagedir(struct pbe *pblist);
+extern void release_eaten_pages(void);
 extern struct pbe *alloc_pagedir(unsigned nr_pages, gfp_t gfp_mask, int safe_needed);
 extern void swsusp_free(void);
 extern int alloc_data_pages(struct pbe *pblist, gfp_t gfp_mask, int safe_needed);
Index: linux-2.6.14-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-mm1.orig/kernel/power/snapshot.c	2005-11-07 23:31:40.000000000 +0100
+++ linux-2.6.14-mm1/kernel/power/snapshot.c	2005-11-07 23:32:29.000000000 +0100
@@ -38,6 +38,30 @@
 static unsigned int nr_copy_pages = 0;
 
 #ifdef CONFIG_HIGHMEM
+unsigned int count_highmem_pages(void)
+{
+	struct zone *zone;
+	unsigned int n = 0;
+
+	for_each_zone (zone)
+		if (is_highmem(zone)) {
+			mark_free_pages(zone);
+			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; zone_pfn++) {
+				struct page *page;
+				unsigned long pfn = zone_pfn + zone->zone_start_pfn;
+				if (!pfn_valid(pfn))
+					continue;
+				page = pfn_to_page(pfn);
+				if (PageReserved(page))
+					continue;
+				if (PageNosaveFree(page))
+					continue;
+				n++;
+			}
+		}
+	return n;
+}
+
 struct highmem_page {
 	char *data;
 	struct page *page;
@@ -153,17 +177,15 @@
 	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
 		return 0;
-	if (PageReserved(page) && pfn_is_nosave(pfn)) {
-		pr_debug("[nosave pfn 0x%lx]", pfn);
+	if (PageReserved(page) && pfn_is_nosave(pfn))
 		return 0;
-	}
 	if (PageNosaveFree(page))
 		return 0;
 
 	return 1;
 }
 
-static unsigned count_data_pages(void)
+unsigned int count_data_pages(void)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
@@ -268,6 +290,35 @@
 }
 
 /**
+ *	On resume it is necessary to trace and eventually free the unsafe
+ *	pages that have been allocated, because they are needed for I/O
+ *	(on x86-64 we likely will "eat" these pages once again while
+ *	creating the temporary page translation tables)
+ */
+
+struct eaten_page {
+	struct eaten_page	*next;
+	char			padding[PAGE_SIZE - sizeof(void *)];
+};
+
+static struct eaten_page *eaten_pages = NULL;
+
+void release_eaten_pages(void)
+{
+	struct eaten_page *p, *q;
+
+	p = eaten_pages;
+	while (p) {
+		q = p->next;
+		/* We don't want swsusp_free() to free this page again */
+		ClearPageNosave(virt_to_page(p));
+		free_page((unsigned long)p);
+		p = q;
+	}
+	eaten_pages = NULL;
+}
+
+/**
  *	@safe_needed - on resume, for storing the PBE list and the image,
  *	we can only use memory pages that do not conflict with the pages
  *	which had been used before suspend.
@@ -285,9 +336,12 @@
 	if (safe_needed)
 		do {
 			res = (void *)get_zeroed_page(gfp_mask);
-			if (res && PageNosaveFree(virt_to_page(res)))
+			if (res && PageNosaveFree(virt_to_page(res))) {
 				/* This is for swsusp_free() */
 				SetPageNosave(virt_to_page(res));
+				((struct eaten_page *)res)->next = eaten_pages;
+				eaten_pages = res;
+			}
 		} while (res && PageNosaveFree(virt_to_page(res)));
 	else
 		res = (void *)get_zeroed_page(gfp_mask);
Index: linux-2.6.14-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-mm1.orig/kernel/power/swsusp.c	2005-11-07 23:32:09.000000000 +0100
+++ linux-2.6.14-mm1/kernel/power/swsusp.c	2005-11-07 23:32:29.000000000 +0100
@@ -77,11 +77,13 @@
 #include "power.h"
 
 #ifdef CONFIG_HIGHMEM
+unsigned int count_highmem_pages(void);
 int save_highmem(void);
 int restore_highmem(void);
 #else
 static int save_highmem(void) { return 0; }
 static int restore_highmem(void) { return 0; }
+static unsigned int count_highmem_pages(void) { return 0; }
 #endif
 
 #define CIPHER "aes"
@@ -772,6 +774,41 @@
 	return error;
 }
 
+/**
+ *	swsusp_shrink_memory -  Try to free as much memory as needed
+ *
+ *	... but do not OOM-kill anyone
+ *
+ *	Notice: all userland should be stopped before it is called, or
+ *	livelock is possible.
+ */
+
+int swsusp_shrink_memory(void)
+{
+	unsigned long cnt;
+	long tmp;
+	unsigned long pages = 0;
+	unsigned int i = 0;
+	char *p = "-\\|/";
+
+	printk("Shrinking memory...  ");
+	do {
+		cnt = count_data_pages() + count_highmem_pages();
+		cnt += (cnt + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
+			PAGES_FOR_IO;
+		tmp = cnt - nr_free_pages();
+		if (tmp > 0) {
+			tmp = 10000;
+			cnt = shrink_all_memory(tmp);
+			pages += cnt;
+		}
+		printk("\b%c", p[i++%4]);
+	} while (tmp > 0 && cnt > 0);
+	printk("\bdone (%lu pages freed)\n", pages);
+
+	return tmp > 0 ? -ENOMEM : 0;
+}
+
 int swsusp_suspend(void)
 {
 	int error;
@@ -1199,8 +1236,10 @@
 		/* Allocate memory for the image and read the data from swap */
 		if (!error)
 			error = alloc_data_pages(pblist, GFP_ATOMIC, 1);
-		if (!error)
+		if (!error) {
+			release_eaten_pages();
 			error = load_image_data(pblist, &handle, nr_pages);
+		}
 		if (!error)
 			snapshot_pblist_set(pblist);
 	}
Index: linux-2.6.14-mm1/include/linux/suspend.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/suspend.h	2005-11-07 23:31:40.000000000 +0100
+++ linux-2.6.14-mm1/include/linux/suspend.h	2005-11-07 23:32:29.000000000 +0100
@@ -73,6 +73,6 @@
  * XXX: We try to keep some more pages free so that I/O operations succeed
  * without paging. Might this be more?
  */
-#define PAGES_FOR_IO	512
+#define PAGES_FOR_IO	1024
 
 #endif /* _LINUX_SWSUSP_H */

--===============20969895248840009==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============20969895248840009==--
