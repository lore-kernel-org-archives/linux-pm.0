From: Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH] PM / hibernate: make sure each resuming page is in current memory zones
Date: Tue, 30 Jun 2015 23:54:28 +0800
Message-ID: <1435679668-13806-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51099 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945AbbF3Puz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Jun 2015 11:50:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, rui.zhang@intel.com, len.brown@intel.com, aaron.lu@intel.com, jlee@suse.com, Chen Yu <yu.c.chen@intel.com>

Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820 reserved
regions") was reverted, because this patch makes resume from hibernation
on Lenovo x230 unreliable. But reverting may bring back the kernel
exception firstly reported in former patch. In general, there are three
problems in current code when resuming from hibernation:

1.Resuming page may also be in second kernel's e820 reserved region.
BIOS-e820: [mem 0x0000000069d4f000-0x0000000069e12fff] reserved
this causes kernel exception described in Commit 84c91b7ae07c
("PM / hibernate: avoid unsafe pages in e820 reserved regions")

2.If Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820
reserved regions") is applied to fix problem 1, and if E820_RESERVED_KERN
regions causes some regions at e820 table not page aligned,
e820_mark_nosave_regions will misjudgment the non-page aligned space to
be "hole" space and add to nosave regions, this causes resuming failed.
Refer to https://bugzilla.kernel.org/show_bug.cgi?id=96111 for detail.

3.e820 memory map inconsistence. Sometimes resuming system may have
larger memory capacity than the one before hibernation. If a strict
superset relationship is satisfied, it should be allowed to resume.
For example,  use case of memory hotplug after hibernation.

e820 memory map before hibernation:
BIOS-e820: [mem 0x0000000020200000-0x0000000077517fff] usable
BIOS-e820: [mem 0x0000000077518000-0x0000000077567fff] reserved

e820 memory map during resuming:
BIOS-e820: [mem 0x0000000020200000-0x000000007753ffff] usable
BIOS-e820: [mem 0x0000000077540000-0x0000000077567fff] reserved

This patch solves above three problems, by checking whether each page to
be restored is strictly subset of current system's available memory zone
region. If it is, it's safe to continue, otherwise terminate.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/snapshot.c | 69 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 5235dd4..ebbb995 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -881,6 +881,9 @@ static struct memory_bitmap *forbidden_pages_map;
 /* Set bits in this map correspond to free page frames. */
 static struct memory_bitmap *free_pages_map;
 
+/* Set bits in this map correspond to all valie page frames. */
+static struct memory_bitmap *valid_pages_map;
+
 /*
  * Each page frame allocated for creating the image is marked by setting the
  * corresponding bits in forbidden_pages_map and free_pages_map simultaneously
@@ -922,6 +925,11 @@ static void swsusp_unset_page_forbidden(struct page *page)
 		memory_bm_clear_bit(forbidden_pages_map, page_to_pfn(page));
 }
 
+int swsusp_page_is_valid(struct page *page)
+{
+	return valid_pages_map ?
+		memory_bm_test_bit(valid_pages_map, page_to_pfn(page)) : 0;
+}
 /**
  *	mark_nosave_pages - set bits corresponding to the page frames the
  *	contents of which should not be saved in a given bitmap.
@@ -955,6 +963,31 @@ static void mark_nosave_pages(struct memory_bitmap *bm)
 	}
 }
 
+/* mark_valid_pages - set bits corresponding to all page frames */
+static void mark_valid_pages(struct memory_bitmap *bm)
+{
+	struct zone *zone;
+	unsigned long pfn, max_zone_pfn;
+
+	for_each_populated_zone(zone) {
+		max_zone_pfn = zone_end_pfn(zone);
+		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
+			if (pfn_valid(pfn))
+				mem_bm_set_bit_check(bm, pfn);
+	}
+}
+
+static bool is_valid_orig_page(unsigned long pfn)
+{
+	if (!swsusp_page_is_valid(pfn_to_page(pfn))) {
+		pr_err(
+		"PM:  %#010llx to restored not in current valid memory region\n",
+		(unsigned long long) pfn << PAGE_SHIFT);
+		return false;
+	} else
+		return true;
+}
+
 /**
  *	create_basic_memory_bitmaps - create bitmaps needed for marking page
  *	frames that should not be saved and free page frames.  The pointers
@@ -965,13 +998,15 @@ static void mark_nosave_pages(struct memory_bitmap *bm)
 
 int create_basic_memory_bitmaps(void)
 {
-	struct memory_bitmap *bm1, *bm2;
+	struct memory_bitmap *bm1, *bm2, *bm3;
 	int error = 0;
 
-	if (forbidden_pages_map && free_pages_map)
+	if (forbidden_pages_map && free_pages_map &&
+		valid_pages_map)
 		return 0;
 	else
-		BUG_ON(forbidden_pages_map || free_pages_map);
+		BUG_ON(forbidden_pages_map || free_pages_map ||
+			valid_pages_map);
 
 	bm1 = kzalloc(sizeof(struct memory_bitmap), GFP_KERNEL);
 	if (!bm1)
@@ -989,14 +1024,27 @@ int create_basic_memory_bitmaps(void)
 	if (error)
 		goto Free_second_object;
 
+	bm3 = kzalloc(sizeof(struct memory_bitmap), GFP_KERNEL);
+	if (!bm3)
+		goto Free_second_bitmap;
+
+	error = memory_bm_create(bm3, GFP_KERNEL, PG_ANY);
+	if (error)
+		goto Free_third_object;
+
 	forbidden_pages_map = bm1;
 	free_pages_map = bm2;
+	valid_pages_map = bm3;
 	mark_nosave_pages(forbidden_pages_map);
-
+	mark_valid_pages(valid_pages_map);
 	pr_debug("PM: Basic memory bitmaps created\n");
 
 	return 0;
 
+ Free_third_object:
+	kfree(bm3);
+ Free_second_bitmap:
+	memory_bm_free(bm2, PG_UNSAFE_CLEAR);
  Free_second_object:
 	kfree(bm2);
  Free_first_bitmap:
@@ -1015,19 +1063,24 @@ int create_basic_memory_bitmaps(void)
 
 void free_basic_memory_bitmaps(void)
 {
-	struct memory_bitmap *bm1, *bm2;
+	struct memory_bitmap *bm1, *bm2, *bm3;
 
-	if (WARN_ON(!(forbidden_pages_map && free_pages_map)))
+	if (WARN_ON(!(forbidden_pages_map && free_pages_map &&
+			valid_pages_map)))
 		return;
 
 	bm1 = forbidden_pages_map;
 	bm2 = free_pages_map;
+	bm3 = valid_pages_map;
 	forbidden_pages_map = NULL;
 	free_pages_map = NULL;
+	valid_pages_map = NULL;
 	memory_bm_free(bm1, PG_UNSAFE_CLEAR);
 	kfree(bm1);
 	memory_bm_free(bm2, PG_UNSAFE_CLEAR);
 	kfree(bm2);
+	memory_bm_free(bm3, PG_UNSAFE_CLEAR);
+	kfree(bm3);
 
 	pr_debug("PM: Basic memory bitmaps freed\n");
 }
@@ -2023,7 +2076,7 @@ static int mark_unsafe_pages(struct memory_bitmap *bm)
 	do {
 		pfn = memory_bm_next_pfn(bm);
 		if (likely(pfn != BM_END_OF_MAP)) {
-			if (likely(pfn_valid(pfn)))
+			if (likely(pfn_valid(pfn)) && is_valid_orig_page(pfn))
 				swsusp_set_page_free(pfn_to_page(pfn));
 			else
 				return -EFAULT;
@@ -2053,8 +2106,6 @@ static int check_header(struct swsusp_info *info)
 	char *reason;
 
 	reason = check_image_kernel(info);
-	if (!reason && info->num_physpages != get_num_physpages())
-		reason = "memory size";
 	if (reason) {
 		printk(KERN_ERR "PM: Image mismatch: %s\n", reason);
 		return -EPERM;
-- 
1.9.1

