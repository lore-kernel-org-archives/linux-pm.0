From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / hibernate: Recycle safe pages after image restoration
Date: Mon, 20 Jun 2016 03:13:44 +0200
Message-ID: <1812721.V0eVCV6g4v@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51170 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751423AbcFTBKE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 19 Jun 2016 21:10:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The hibernation image restoration code in snapshot.c allocates more
safe pages (ie. pages that were not used by the image kernel before
hibernation and therefore are suitable for storing temporary stuff
that must not collide with the image kernel's memory contents).
Those extra allocated safe pages are not freed and are never
used later until control goes back to the image kernel.

Moreover, after loading the image one of the memory bitmaps used
for that and also built of safe pages is returned to the memory
management subsystem via memory_bm_free().

None of those things is particularly efficient, because arch-specific
image restoration code usually needs safe pages too and allocates
them using get_safe_page() which has to go through the memory
management subsystem and then consult the hibernate subsystem's
memory bitmaps to see if the page is really safe (and it if isn't,
the allocation is repeated and so on).  All of that takes time
and energy and the two sources of known safe pages that have
already been allocated once can be put to a good use in there.

For this reason, make it possible to recycle memory pages from
the bitmap that's not necessary any more by adding them to the
list of known safe pages instead of freeing them and rework
get_safe_page() to make it return pages from that list first
and only ask the memory management system for a new page if
that list is empty.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/snapshot.c |   77 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 16 deletions(-)

Index: linux-pm/kernel/power/snapshot.c
===================================================================
--- linux-pm.orig/kernel/power/snapshot.c
+++ linux-pm/kernel/power/snapshot.c
@@ -74,6 +74,30 @@ void __init hibernate_image_size_init(vo
  */
 struct pbe *restore_pblist;
 
+/* struct linked_page is used to build chains of pages */
+
+#define LINKED_PAGE_DATA_SIZE	(PAGE_SIZE - sizeof(void *))
+
+struct linked_page {
+	struct linked_page *next;
+	char data[LINKED_PAGE_DATA_SIZE];
+} __packed;
+
+/*
+ * List of "safe" pages (ie. pages that were not used by the image kernel
+ * before hibernation) that may be used as temporary storage for kernel image
+ * memory contents.
+ */
+static struct linked_page *safe_pages_list;
+
+static void recycle_safe_page(void *page_address)
+{
+	struct linked_page *lp = page_address;
+
+	lp->next = safe_pages_list;
+	safe_pages_list = lp;
+}
+
 /* Pointer to an auxiliary buffer (1 page) */
 static void *buffer;
 
@@ -115,6 +139,13 @@ static void *get_image_page(gfp_t gfp_ma
 
 unsigned long get_safe_page(gfp_t gfp_mask)
 {
+	if (safe_pages_list) {
+		void *ret = safe_pages_list;
+
+		safe_pages_list = safe_pages_list->next;
+		memset(ret, 0, PAGE_SIZE);
+		return (unsigned long)ret;
+	}
 	return (unsigned long)get_image_page(gfp_mask, PG_SAFE);
 }
 
@@ -150,15 +181,6 @@ static inline void free_image_page(void
 	__free_page(page);
 }
 
-/* struct linked_page is used to build chains of pages */
-
-#define LINKED_PAGE_DATA_SIZE	(PAGE_SIZE - sizeof(void *))
-
-struct linked_page {
-	struct linked_page *next;
-	char data[LINKED_PAGE_DATA_SIZE];
-} __packed;
-
 static inline void
 free_list_of_pages(struct linked_page *list, int clear_page_nosave)
 {
@@ -621,6 +643,34 @@ static void memory_bm_free(struct memory
 	INIT_LIST_HEAD(&bm->zones);
 }
 
+static void recycle_zone_bm_rtree(struct mem_zone_bm_rtree *zone)
+{
+	struct rtree_node *node;
+
+	list_for_each_entry(node, &zone->nodes, list)
+		recycle_safe_page(node->data);
+
+	list_for_each_entry(node, &zone->leaves, list)
+		recycle_safe_page(node->data);
+}
+
+static void memory_bm_recycle(struct memory_bitmap *bm)
+{
+	struct mem_zone_bm_rtree *zone;
+	struct linked_page *p_list;
+
+	list_for_each_entry(zone, &bm->zones, list)
+		recycle_zone_bm_rtree(zone);
+
+	p_list = bm->p_list;
+	while (p_list) {
+		struct linked_page *lp = p_list;
+
+		p_list = lp->next;
+		recycle_safe_page(lp);
+	}
+}
+
 /**
  *	memory_bm_find_bit - Find the bit for pfn in the memory
  *			     bitmap
@@ -2104,11 +2154,6 @@ static int unpack_orig_pfns(unsigned lon
 	return 0;
 }
 
-/* List of "safe" pages that may be used to store data loaded from the suspend
- * image
- */
-static struct linked_page *safe_pages_list;
-
 #ifdef CONFIG_HIGHMEM
 /* struct highmem_pbe is used for creating the list of highmem pages that
  * should be restored atomically during the resume from disk, because the page
@@ -2546,9 +2591,9 @@ void snapshot_write_finalize(struct snap
 	/* Restore page key for data page (s390 only). */
 	page_key_write(handle->buffer);
 	page_key_free();
-	/* Free only if we have loaded the image entirely */
+	/* Do that only if we have loaded the image entirely */
 	if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages) {
-		memory_bm_free(&orig_bm, PG_UNSAFE_CLEAR);
+		memory_bm_recycle(&orig_bm);
 		free_highmem_data();
 	}
 }

