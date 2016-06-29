From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 1/3] PM / hibernate: Do not free preallocated safe pages during image restore
Date: Wed, 29 Jun 2016 03:00:51 +0200
Message-ID: <2079485.Jxhzxdvifa@vostro.rjw.lan>
References: <2260927.OOWMYX738E@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2260927.OOWMYX738E@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The core image restoration code preallocates some safe pages
(ie. pages that weren't used by the image kernel before hibernation)
for future use before allocating the bulk of memory for loading the
image data.  Those safe pages are then freed so they can be allocated
again (with the memory management subsystem's help).  That's done to
ensure that there will be enough safe pages for temporary data
structures needed during image restoration.

However, it is not really necessary to free those pages after they
have been allocated.  They can be added to the (global) list of
safe pages right away and then picked up from there when needed
without freeing.

That reduces the overhead related to using safe pages, especially
in the arch-specific code, so modify the code accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/snapshot.c |   66 +++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

Index: linux-pm/kernel/power/snapshot.c
===================================================================
--- linux-pm.orig/kernel/power/snapshot.c
+++ linux-pm/kernel/power/snapshot.c
@@ -74,6 +74,22 @@ void __init hibernate_image_size_init(vo
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
+ * before hibernation) that may be used as temporary storage for image kernel
+ * memory contents.
+ */
+static struct linked_page *safe_pages_list;
+
 /* Pointer to an auxiliary buffer (1 page) */
 static void *buffer;
 
@@ -113,9 +129,21 @@ static void *get_image_page(gfp_t gfp_ma
 	return res;
 }
 
+static void *__get_safe_page(gfp_t gfp_mask)
+{
+	if (safe_pages_list) {
+		void *ret = safe_pages_list;
+
+		safe_pages_list = safe_pages_list->next;
+		memset(ret, 0, PAGE_SIZE);
+		return ret;
+	}
+	return get_image_page(gfp_mask, PG_SAFE);
+}
+
 unsigned long get_safe_page(gfp_t gfp_mask)
 {
-	return (unsigned long)get_image_page(gfp_mask, PG_SAFE);
+	return (unsigned long)__get_safe_page(gfp_mask);
 }
 
 static struct page *alloc_image_page(gfp_t gfp_mask)
@@ -150,15 +178,6 @@ static inline void free_image_page(void
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
@@ -208,7 +227,8 @@ static void *chain_alloc(struct chain_al
 	if (LINKED_PAGE_DATA_SIZE - ca->used_space < size) {
 		struct linked_page *lp;
 
-		lp = get_image_page(ca->gfp_mask, ca->safe_needed);
+		lp = ca->safe_needed ? __get_safe_page(ca->gfp_mask) :
+					get_image_page(ca->gfp_mask, PG_ANY);
 		if (!lp)
 			return NULL;
 
@@ -2104,11 +2124,6 @@ static int unpack_orig_pfns(unsigned lon
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
@@ -2334,7 +2349,7 @@ static int
 prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
 {
 	unsigned int nr_pages, nr_highmem;
-	struct linked_page *sp_list, *lp;
+	struct linked_page *lp;
 	int error;
 
 	/* If there is no highmem, the buffer will not be necessary */
@@ -2362,9 +2377,9 @@ prepare_image(struct memory_bitmap *new_
 	 * NOTE: This way we make sure there will be enough safe pages for the
 	 * chain_alloc() in get_buffer().  It is a bit wasteful, but
 	 * nr_copy_pages cannot be greater than 50% of the memory anyway.
+	 *
+	 * nr_copy_pages cannot be less than allocated_unsafe_pages too.
 	 */
-	sp_list = NULL;
-	/* nr_copy_pages cannot be lesser than allocated_unsafe_pages */
 	nr_pages = nr_copy_pages - nr_highmem - allocated_unsafe_pages;
 	nr_pages = DIV_ROUND_UP(nr_pages, PBES_PER_LINKED_PAGE);
 	while (nr_pages > 0) {
@@ -2373,12 +2388,11 @@ prepare_image(struct memory_bitmap *new_
 			error = -ENOMEM;
 			goto Free;
 		}
-		lp->next = sp_list;
-		sp_list = lp;
+		lp->next = safe_pages_list;
+		safe_pages_list = lp;
 		nr_pages--;
 	}
 	/* Preallocate memory for the image */
-	safe_pages_list = NULL;
 	nr_pages = nr_copy_pages - nr_highmem - allocated_unsafe_pages;
 	while (nr_pages > 0) {
 		lp = (struct linked_page *)get_zeroed_page(GFP_ATOMIC);
@@ -2396,12 +2410,6 @@ prepare_image(struct memory_bitmap *new_
 		swsusp_set_page_free(virt_to_page(lp));
 		nr_pages--;
 	}
-	/* Free the reserved safe pages so that chain_alloc() can use them */
-	while (sp_list) {
-		lp = sp_list->next;
-		free_image_page(sp_list, PG_UNSAFE_CLEAR);
-		sp_list = lp;
-	}
 	return 0;
 
  Free:
@@ -2491,6 +2499,8 @@ int snapshot_write_next(struct snapshot_
 		if (error)
 			return error;
 
+		safe_pages_list = NULL;
+
 		error = memory_bm_create(&copy_bm, GFP_ATOMIC, PG_ANY);
 		if (error)
 			return error;
