From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] PM / hibernate: Simplify mark_unsafe_pages()
Date: Thu, 23 Jun 2016 02:07:30 +0200
Message-ID: <8588549.m9b2d9p6pQ@vostro.rjw.lan>
References: <28211201.GaRaWsd3LX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57410 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750996AbcFWADM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2016 20:03:12 -0400
In-Reply-To: <28211201.GaRaWsd3LX@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rework mark_unsafe_pages() to use a simpler method of clearing
all bits in free_pages_map and to set the bits for the "unsafe"
pages (ie. pages that were used by the image kernel before
hibernation) with the help of duplicate_memory_bitmap().

For this purpose, move the pfn_valid() check from mark_unsafe_pages()
to unpack_orig_pfns() where the "unsafe" pages are discovered.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: mark_unsafe_pages() can be void now.

---
 kernel/power/snapshot.c |   64 ++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 39 deletions(-)

Index: linux-pm/kernel/power/snapshot.c
===================================================================
--- linux-pm.orig/kernel/power/snapshot.c
+++ linux-pm/kernel/power/snapshot.c
@@ -2049,53 +2049,41 @@ int snapshot_read_next(struct snapshot_h
 	return PAGE_SIZE;
 }
 
+static void duplicate_memory_bitmap(struct memory_bitmap *dst,
+				    struct memory_bitmap *src)
+{
+	unsigned long pfn;
+
+	memory_bm_position_reset(src);
+	pfn = memory_bm_next_pfn(src);
+	while (pfn != BM_END_OF_MAP) {
+		memory_bm_set_bit(dst, pfn);
+		pfn = memory_bm_next_pfn(src);
+	}
+}
+
 /**
  *	mark_unsafe_pages - mark the pages that cannot be used for storing
  *	the image during resume, because they conflict with the pages that
  *	had been used before suspend
  */
 
-static int mark_unsafe_pages(struct memory_bitmap *bm)
+static void mark_unsafe_pages(struct memory_bitmap *bm)
 {
-	struct zone *zone;
-	unsigned long pfn, max_zone_pfn;
+	unsigned long pfn;
 
-	/* Clear page flags */
-	for_each_populated_zone(zone) {
-		max_zone_pfn = zone_end_pfn(zone);
-		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
-			if (pfn_valid(pfn))
-				swsusp_unset_page_free(pfn_to_page(pfn));
+	/* Clear the "free"/"unsafe" bit for all PFNs */
+	memory_bm_position_reset(free_pages_map);
+	pfn = memory_bm_next_pfn(free_pages_map);
+	while (pfn != BM_END_OF_MAP) {
+		memory_bm_clear_current(free_pages_map);
+		pfn = memory_bm_next_pfn(free_pages_map);
 	}
 
-	/* Mark pages that correspond to the "original" pfns as "unsafe" */
-	memory_bm_position_reset(bm);
-	do {
-		pfn = memory_bm_next_pfn(bm);
-		if (likely(pfn != BM_END_OF_MAP)) {
-			if (likely(pfn_valid(pfn)))
-				swsusp_set_page_free(pfn_to_page(pfn));
-			else
-				return -EFAULT;
-		}
-	} while (pfn != BM_END_OF_MAP);
+	/* Mark pages that correspond to the "original" PFNs as "unsafe" */
+	duplicate_memory_bitmap(free_pages_map, bm);
 
 	allocated_unsafe_pages = 0;
-
-	return 0;
-}
-
-static void
-duplicate_memory_bitmap(struct memory_bitmap *dst, struct memory_bitmap *src)
-{
-	unsigned long pfn;
-
-	memory_bm_position_reset(src);
-	pfn = memory_bm_next_pfn(src);
-	while (pfn != BM_END_OF_MAP) {
-		memory_bm_set_bit(dst, pfn);
-		pfn = memory_bm_next_pfn(src);
-	}
 }
 
 static int check_header(struct swsusp_info *info)
@@ -2145,7 +2133,7 @@ static int unpack_orig_pfns(unsigned lon
 		/* Extract and buffer page key for data page (s390 only). */
 		page_key_memorize(buf + j);
 
-		if (memory_bm_pfn_present(bm, buf[j]))
+		if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j]))
 			memory_bm_set_bit(bm, buf[j]);
 		else
 			return -EFAULT;
@@ -2387,9 +2375,7 @@ prepare_image(struct memory_bitmap *new_
 	buffer = NULL;
 
 	nr_highmem = count_highmem_image_pages(bm);
-	error = mark_unsafe_pages(bm);
-	if (error)
-		goto Free;
+	mark_unsafe_pages(bm);
 
 	error = memory_bm_create(new_bm, GFP_ATOMIC, PG_SAFE);
 	if (error)

