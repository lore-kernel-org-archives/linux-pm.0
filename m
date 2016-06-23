From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / hibernate: Do not free preallocated safe pages during image restore
Date: Thu, 23 Jun 2016 02:09:19 +0200
Message-ID: <6148276.54TsU2aq5D@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64845 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751189AbcFWAFA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2016 20:05:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

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
 kernel/power/snapshot.c |   33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

Index: linux-pm/kernel/power/snapshot.c
===================================================================
--- linux-pm.orig/kernel/power/snapshot.c
+++ linux-pm/kernel/power/snapshot.c
@@ -137,16 +137,21 @@ static void *get_image_page(gfp_t gfp_ma
 	return res;
 }
 
-unsigned long get_safe_page(gfp_t gfp_mask)
+static void *__get_safe_page(gfp_t gfp_mask)
 {
 	if (safe_pages_list) {
 		void *ret = safe_pages_list;
 
 		safe_pages_list = safe_pages_list->next;
 		memset(ret, 0, PAGE_SIZE);
-		return (unsigned long)ret;
+		return ret;
 	}
-	return (unsigned long)get_image_page(gfp_mask, PG_SAFE);
+	return get_image_page(gfp_mask, PG_SAFE);
+}
+
+unsigned long get_safe_page(gfp_t gfp_mask)
+{
+	return (unsigned long)__get_safe_page(gfp_mask);
 }
 
 static struct page *alloc_image_page(gfp_t gfp_mask)
@@ -230,7 +235,8 @@ static void *chain_alloc(struct chain_al
 	if (LINKED_PAGE_DATA_SIZE - ca->used_space < size) {
 		struct linked_page *lp;
 
-		lp = get_image_page(ca->gfp_mask, ca->safe_needed);
+		lp = ca->safe_needed ? __get_safe_page(ca->gfp_mask) :
+					get_image_page(ca->gfp_mask, PG_ANY);
 		if (!lp)
 			return NULL;
 
@@ -2367,7 +2373,7 @@ static int
 prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
 {
 	unsigned int nr_pages, nr_highmem;
-	struct linked_page *sp_list, *lp;
+	struct linked_page *lp;
 	int error;
 
 	/* If there is no highmem, the buffer will not be necessary */
@@ -2393,9 +2399,9 @@ prepare_image(struct memory_bitmap *new_
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
@@ -2404,12 +2410,11 @@ prepare_image(struct memory_bitmap *new_
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
@@ -2427,12 +2432,6 @@ prepare_image(struct memory_bitmap *new_
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
@@ -2522,6 +2521,8 @@ int snapshot_write_next(struct snapshot_
 		if (error)
 			return error;
 
+		safe_pages_list = NULL;
+
 		error = memory_bm_create(&copy_bm, GFP_ATOMIC, PG_ANY);
 		if (error)
 			return error;

