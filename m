From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / hibernate: Simplify mark_unsafe_pages()
Date: Wed, 22 Jun 2016 03:19:45 +0200
Message-ID: <28211201.GaRaWsd3LX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rework mark_unsafe_pages() to use a simpler method to clear
all bits in free_pages_map and to set the bits for the "unsafe"
pages (ie. pages that were used by the image kernel before
hibernation) with the help of duplicate_memory_bitmap().

For this purpose, move the pfn_valid() check from mark_unsafe_pages()
to unpack_orig_pfns() where the "unsafe" pages are discovered.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/snapshot.c |   53 +++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

Index: linux-pm/kernel/power/snapshot.c
===================================================================
--- linux-pm.orig/kernel/power/snapshot.c
+++ linux-pm/kernel/power/snapshot.c
@@ -2049,6 +2049,19 @@ int snapshot_read_next(struct snapshot_h
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
@@ -2060,44 +2073,22 @@ static int mark_unsafe_pages(struct memo
 	struct zone *zone;
 	unsigned long pfn, max_zone_pfn;
 
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
 
 	return 0;
 }
 
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
-}
-
 static int check_header(struct swsusp_info *info)
 {
 	char *reason;
@@ -2145,7 +2136,7 @@ static int unpack_orig_pfns(unsigned lon
 		/* Extract and buffer page key for data page (s390 only). */
 		page_key_memorize(buf + j);
 
-		if (memory_bm_pfn_present(bm, buf[j]))
+		if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j]))
 			memory_bm_set_bit(bm, buf[j]);
 		else
 			return -EFAULT;
