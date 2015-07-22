From: Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH V2] PM / hibernate: Fix hibernation panic caused by inconsistent e820 memory map
Date: Wed, 22 Jul 2015 16:29:08 +0800
Message-ID: <1437553748-7344-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2208 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756083AbbGVIZd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 Jul 2015 04:25:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: jlee@suse.com, rafael.j.wysocki@intel.com, yinghai@kernel.org, rui.zhang@intel.com, yex.tian@intel.com, Chen Yu <yu.c.chen@intel.com>

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

This patch is based on Lee, Chun-Yi's original patch
Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820 reserved
regions"), then treats any ajacent E820_RAM/E820_RESERVED_KERN regions
as one region, this can prevent any non-page aligned address in
ajacent E820_RAM/E820_RESERVED regions, from being added to nosave regions,
thus allow system to restore the hibernation image, for example:
three E820_RAM/E820_RESERVED_KERN regions,
[a,b] [b+1,c] [c+1,d], should be treated as a whole:
[a,d].
For the bug reported at https://bugzilla.kernel.org/show_bug.cgi?id=96111
reserve setup_data: [mem 0x000000005baff000-0x000000009d3e0017] usable
reserve setup_data: [mem 0x000000009d3e0018-0x000000009d3f0057] usable
reserve setup_data: [mem 0x000000009d3f0058-0x00000000d684ffff] usable
these regions will be treated as one:
[mem 0x000000005baff000-0x00000000d684ffff] usable.

Tested-by: Tian Ye <yex.tian@intel.com>
Tested-by: Wendy, Wang <wendy.wang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/kernel/e820.c  | 32 +++++++++++++++++++++++++++++++-
 kernel/power/snapshot.c | 26 +++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index a102564..ac2da40 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -672,6 +672,11 @@ void __init parse_e820_ext(u64 phys_addr, u32 data_len)
 
 #if defined(CONFIG_X86_64) || \
 	(defined(CONFIG_X86_32) && defined(CONFIG_HIBERNATION))
+static int e820_is_ram_region(struct e820entry *ei)
+{
+	return (((ei->type == E820_RAM) ||
+		(ei->type == E820_RESERVED_KERN)) ? 1 : 0);
+}
 /**
  * Find the ranges of physical addresses that do not correspond to
  * e820 RAM areas and mark the corresponding pages as nosave for
@@ -693,8 +698,33 @@ void __init e820_mark_nosave_regions(unsigned long limit_pfn)
 
 		pfn = PFN_DOWN(ei->addr + ei->size);
 
-		if (ei->type != E820_RAM && ei->type != E820_RESERVED_KERN)
+		if (!e820_is_ram_region(ei))
 			register_nosave_region(PFN_UP(ei->addr), pfn);
+		else {
+			/**
+			* Treat any ajacent E820_RAM/E820_RESERVED_KERN
+			* regions as one region, because the algorithm
+			* to check the holes between regions may split
+			* non-page-aligned address into nosave region,
+			* which is not expected when resuming from hibernation.
+			* With following code,
+			* [a,b][b+1,c][c+1,d] will be manipulated as [a,d].
+			* thus workaround this problem.
+			*/
+			struct e820entry *ei_next;
+
+			while (i < (e820.nr_map - 1)) {
+				ei_next = &(e820.map[i+1]);
+				if (!e820_is_ram_region(ei_next))
+					break;
+				if (ei->addr + ei->size + 1 == ei_next->addr) {
+					pfn =
+					PFN_DOWN(ei_next->addr + ei_next->size);
+					ei = &e820.map[++i];
+				} else
+					break;
+			}
+		}
 
 		if (pfn >= limit_pfn)
 			break;
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 5235dd4..26ddb2f 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -955,6 +955,25 @@ static void mark_nosave_pages(struct memory_bitmap *bm)
 	}
 }
 
+static bool is_nosave_page(unsigned long pfn)
+{
+	struct nosave_region *region;
+
+	list_for_each_entry(region, &nosave_regions, list) {
+		if (pfn >= region->start_pfn && pfn < region->end_pfn) {
+			pr_err(
+		  "PM: %#010llx in e820 nosave region: [mem %#010llx-%#010llx]\n",
+		  (unsigned long long) pfn << PAGE_SHIFT,
+		  (unsigned long long) region->start_pfn << PAGE_SHIFT,
+		  ((unsigned long long) region->end_pfn << PAGE_SHIFT)
+		  - 1);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  *	create_basic_memory_bitmaps - create bitmaps needed for marking page
  *	frames that should not be saved and free page frames.  The pointers
@@ -2023,7 +2042,7 @@ static int mark_unsafe_pages(struct memory_bitmap *bm)
 	do {
 		pfn = memory_bm_next_pfn(bm);
 		if (likely(pfn != BM_END_OF_MAP)) {
-			if (likely(pfn_valid(pfn)))
+			if (likely(pfn_valid(pfn)) && !is_nosave_page(pfn))
 				swsusp_set_page_free(pfn_to_page(pfn));
 			else
 				return -EFAULT;
@@ -2053,8 +2072,9 @@ static int check_header(struct swsusp_info *info)
 	char *reason;
 
 	reason = check_image_kernel(info);
-	if (!reason && info->num_physpages != get_num_physpages())
-		reason = "memory size";
+	/* No need to check num_physpages because is_nosave_page
+	 * will ensure each page is safe to restore.
+	 */
 	if (reason) {
 		printk(KERN_ERR "PM: Image mismatch: %s\n", reason);
 		return -EPERM;
-- 
1.9.1

