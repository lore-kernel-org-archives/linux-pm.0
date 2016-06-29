From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 3/3] PM / hibernate: Recycle safe pages after image restoration
Date: Wed, 29 Jun 2016 03:05:10 +0200
Message-ID: <2448424.sR3JM3oiG3@vostro.rjw.lan>
References: <2260927.OOWMYX738E@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58071 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752506AbcF2BAv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2016 21:00:51 -0400
In-Reply-To: <2260927.OOWMYX738E@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

One of the memory bitmaps used by the hibernation image restoration
code is freed after the image has been loaded.

That is not quite efficient, though, because the memory pages used
for building that bitmap are known to be safe (ie. they were not
used by the image kernel before hibernation) and the arch-specific
code finalizing the image restoration may need them.  In that case
it needs to allocate those pages again via the memory management
subsystem, check if they are really safe again by consulting the
other bitmaps and so on.

To avoid that, recycle those pages by putting them into the global
list of known safe pages so that they can be given to the arch code
right away when necessary.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/snapshot.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)


--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

Index: linux-pm/kernel/power/snapshot.c
===================================================================
--- linux-pm.orig/kernel/power/snapshot.c
+++ linux-pm/kernel/power/snapshot.c
@@ -158,6 +158,14 @@ static struct page *alloc_image_page(gfp
 	return page;
 }
 
+static void recycle_safe_page(void *page_address)
+{
+	struct linked_page *lp = page_address;
+
+	lp->next = safe_pages_list;
+	safe_pages_list = lp;
+}
+
 /**
  *	free_image_page - free page represented by @addr, allocated with
  *	get_image_page (page flags set by it must be cleared)
@@ -852,6 +860,34 @@ struct nosave_region {
 
 static LIST_HEAD(nosave_regions);
 
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
  *	register_nosave_region - register a range of page frames the contents
  *	of which should not be saved during the suspend (to be used in the early
@@ -2542,9 +2578,9 @@ void snapshot_write_finalize(struct snap
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

