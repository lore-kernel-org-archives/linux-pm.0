From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] Hibernation: Handle DEBUG_PAGEALLOC on x86
Date: Wed, 20 Feb 2008 01:47:44 +0100
Message-ID: <200802200147.45479.rjw@sisk.pl>
References: <200802200133.44098.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200802200133.44098.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.osdl.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Johannes Berg <johannes@sipsolutions.net>, Nigel Cunningham <nigel@suspend2.net>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make hibernation work with CONFIG_DEBUG_PAGEALLOC set on x86, by
checking if the pages to be copied are marked as present in the
kernel mapping and temporarily marking them as present if that's not
the case.  No functional modifications are introduced if
CONFIG_DEBUG_PAGEALLOC is unset.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/mm/pageattr.c  |   19 ++++++++++++++++++-
 include/linux/mm.h      |    6 ++++++
 kernel/power/snapshot.c |   42 +++++++++++++++++++++++++++++-------------
 3 files changed, 53 insertions(+), 14 deletions(-)

Index: linux-2.6/kernel/power/snapshot.c
===================================================================
--- linux-2.6.orig/kernel/power/snapshot.c
+++ linux-2.6/kernel/power/snapshot.c
@@ -875,8 +875,8 @@ static inline void *saveable_highmem_pag
 #endif /* CONFIG_HIGHMEM */
 
 /**
- *	saveable - Determine whether a non-highmem page should be included in
- *	the suspend image.
+ *	saveable_page - Determine whether a non-highmem page should be included
+ *	in the suspend image.
  *
  *	We should save the page if it isn't Nosave, and is not in the range
  *	of pages statically defined as 'unsaveable', and it isn't a part of
@@ -897,7 +897,8 @@ static struct page *saveable_page(unsign
 	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
 		return NULL;
 
-	if (PageReserved(page) && pfn_is_nosave(pfn))
+	if (PageReserved(page)
+	    && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
 		return NULL;
 
 	return page;
@@ -938,6 +939,25 @@ static inline void do_copy_page(long *ds
 		*dst++ = *src++;
 }
 
+
+/**
+ *	safe_copy_page - check if the page we are going to copy is marked as
+ *		present in the kernel page tables (this always is the case if
+ *		CONFIG_DEBUG_PAGEALLOC is not set and in that case
+ *		kernel_page_present() always returns 'true').
+ */
+static void safe_copy_page(void *dst, struct page *s_page)
+{
+	if (kernel_page_present(s_page)) {
+		do_copy_page(dst, page_address(s_page));
+	} else {
+		kernel_map_pages(s_page, 1, 1);
+		do_copy_page(dst, page_address(s_page));
+		kernel_map_pages(s_page, 1, 0);
+	}
+}
+
+
 #ifdef CONFIG_HIGHMEM
 static inline struct page *
 page_is_saveable(struct zone *zone, unsigned long pfn)
@@ -946,8 +966,7 @@ page_is_saveable(struct zone *zone, unsi
 			saveable_highmem_page(pfn) : saveable_page(pfn);
 }
 
-static inline void
-copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
+static void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 {
 	struct page *s_page, *d_page;
 	void *src, *dst;
@@ -961,29 +980,26 @@ copy_data_page(unsigned long dst_pfn, un
 		kunmap_atomic(src, KM_USER0);
 		kunmap_atomic(dst, KM_USER1);
 	} else {
-		src = page_address(s_page);
 		if (PageHighMem(d_page)) {
 			/* Page pointed to by src may contain some kernel
 			 * data modified by kmap_atomic()
 			 */
-			do_copy_page(buffer, src);
+			safe_copy_page(buffer, s_page);
 			dst = kmap_atomic(pfn_to_page(dst_pfn), KM_USER0);
 			memcpy(dst, buffer, PAGE_SIZE);
 			kunmap_atomic(dst, KM_USER0);
 		} else {
-			dst = page_address(d_page);
-			do_copy_page(dst, src);
+			safe_copy_page(page_address(d_page), s_page);
 		}
 	}
 }
 #else
 #define page_is_saveable(zone, pfn)	saveable_page(pfn)
 
-static inline void
-copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
+static inline void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 {
-	do_copy_page(page_address(pfn_to_page(dst_pfn)),
-			page_address(pfn_to_page(src_pfn)));
+	safe_copy_page(page_address(pfn_to_page(dst_pfn)),
+				pfn_to_page(src_pfn));
 }
 #endif /* CONFIG_HIGHMEM */
 
Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -1171,12 +1171,18 @@ static inline void enable_debug_pageallo
 {
 	debug_pagealloc_enabled = 1;
 }
+#ifdef CONFIG_HIBERNATION
+extern bool kernel_page_present(struct page *page);
+#endif /* CONFIG_HIBERNATION */
 #else
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable) {}
 static inline void enable_debug_pagealloc(void)
 {
 }
+#ifdef CONFIG_HIBERNATION
+static inline bool kernel_page_present(struct page *page) { return true; }
+#endif /* CONFIG_HIBERNATION */
 #endif
 
 extern struct vm_area_struct *get_gate_vma(struct task_struct *tsk);
Index: linux-2.6/arch/x86/mm/pageattr.c
===================================================================
--- linux-2.6.orig/arch/x86/mm/pageattr.c
+++ linux-2.6/arch/x86/mm/pageattr.c
@@ -904,7 +904,24 @@ void kernel_map_pages(struct page *page,
 	 */
 	cpa_fill_pool();
 }
-#endif
+
+#ifdef CONFIG_HIBERNATION
+
+bool kernel_page_present(struct page *page)
+{
+	unsigned int level;
+	pte_t *pte;
+
+	if (PageHighMem(page))
+		return false;
+
+	pte = lookup_address((unsigned long)page_address(page), &level);
+	return (pte_val(*pte) & _PAGE_PRESENT);
+}
+
+#endif /* CONFIG_HIBERNATION */
+
+#endif /* CONFIG_DEBUG_PAGEALLOC */
 
 /*
  * The testcases use internal knowledge of the implementation that shouldn't

