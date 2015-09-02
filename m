From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] [v3] PM / hibernate: Fix hibernation panic caused by inconsistent e820 map
Date: Wed,  2 Sep 2015 20:06:28 +0800
Message-ID: <1441195588-31175-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17699 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023AbbIBMDV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Sep 2015 08:03:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz
Cc: mingo@redhat.com, joeyli.kernel@gmail.com, yinghai@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

On some platforms, there is occasional panic triggered when trying to
resume from hibernation, a typical panic looks like:

BUG: unable to handle kernel paging request at ffff880085894000
IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70

This is because e820 map has been changed by BIOS before/after
hibernation, and one of the page frames from first kernel
is right located in second kernel's unmapped region, so panic
comes out when accessing unmapped kernel address.

Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820 reserved
regions") was once introduced to fix this problem: to warn on the change
on BIOS e820 and deny the resuming process, thus avoid the panic
afterwards. However, this patch makes resuming from hibernation on Lenovo
x230 failed, and the reason for it is that, this patch can not deal with
unaligned E820_RESERVED_KERN regions and fails to resume from hibernation:
https://bugzilla.kernel.org/show_bug.cgi?id=96111
As a result, this patch is reverted.

To solve this hibernation panic issue fundamentally, we need to get rid of
the impact of E820_RESERVED_KERN, so Yinghai,Lu proposes a patch to kill
E820_RESERVED_KERN and based on his patch we can re-apply
Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820 reserved
regions"), and stress testing has been performed on problematic platform
with above two patches applied, it works as expected, no panic anymore.

However, there is still one thing left, hibernation might fail even after
above two patches applied, with the following warnning in log:

PM: Image mismatch: memory size

This is also because BIOS provides different e820 memory map before/after
hibernation, thus different memory pages, and linux regards different
number of memory pages as invalid process and refuses to resume, in order
to protect against data corruption. However, this check might be too
strict, consider the following scenario:
The hibernating system has a smaller memory capacity than the resuming
system, and the former memory region is a subset of the latter, it should
be allowed to resume. Here is a case for this situation:

before hibernation:

BIOS-e820: [mem 0x0000000020200000-0x0000000077517fff] usable
BIOS-e820: [mem 0x0000000077518000-0x0000000077567fff] reserved
Memory: 3871356K/4058428K available (7595K kernel code, 1202K rwdata,
3492K rodata, 1400K init, 1308K bss, 187072K reserved, 0K cma-reserved)

after hibernation:
BIOS-e820: [mem 0x0000000020200000-0x000000007753ffff] usable
BIOS-e820: [mem 0x0000000077540000-0x0000000077567fff] reserved
Memory: 3871516K/4058588K available (7595K kernel code, 1202K rwdata,
3492K rodata, 1400K init, 1308K bss, 187072K reserved, 0K cma-reserved)

According to above data, the number of present_pages has increased by
40(thus 160K), linux will terminate the resuming process. But since
[0x0000000020200000-0x0000000077517fff] is a subset of
[0x0000000020200000-0x000000007753ffff], we should let system resume.

Since above two patches can not deal with the hibernation failor, another
solution to fix both hibernation panic and hibernation failor is proposed
as follows:
We simply check that, if each non-highmem page frame to be restored is a
valid mapped kernel page(by checking if this page is in pfn_mapped
array in arch/x86/mm/init.c), if it is, resuming process will continue.
In this way we do not have to touch E820_RESERVED_KERN, and we can:
1.prevent the hibernation panic caused by unmapped-page address
accessing
2.remove the code that requires the same memory size before/after
hibernation.

Note: for point 2, this patch only works on x86_64 platforms
(with no highmem), because the highmem page frames on x86_32
are not directly-mapped by kernel, which is out of the scope
of pfn_mapped, this patch will not guarantee that whether the
higmem region is legal for restore. A further work might include
a logic to check if each page frame to be restored is in E820_RAM
region, but it might require quite neat checkings in the code.
For now, just solve the problem reported on x86_64.

After this patch applied, the panic will be replaced with the warning:

PM: Loading and decompressing image data (96092 pages)...
PM: Image loading progress:   0%
PM: Image loading progress:  10%
PM: Image loading progress:  20%
PM: Image loading progress:  30%
PM: Image loading progress:  40%
PM:  0x849dd000 to restored not in valid memory region

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---

v3:
 - Adjust the logic to exclude the end_pfn boundary in pfn_mapped
   when invoking mark_valid_pages, because the end_pfn is not
   a mapped page frame, we should not regard it as a valid page.

   Move the sanity check of valid pages to a early stage in resuming
   process(moved to mark_unsafe_pages), in this way, we can avoid
   unnecessarily accessing these invalid pages in later stage(yes,
   move to the original position Joey once introduced in:
   Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820
   reserved regions")

   With v3 patch applied, I did 30 cycles on my problematic platform,
   no panic triggered anymore(50% reproducible before patched, by
   plugging/unplugging memory peripheral during hibernation), and it
   just warns of invalid pages.
   
v2:
 - According to Ingo's suggestion, rewrite this patch.

   New version just checks each page frame according to pfn_mapped array.
   So that we do not need to touch existing code related to
   E820_RESERVED_KERN. And this method can naturely guarantee
   that the system before/after hibernation do not need to be of
   the same memory size on x86_64.
--
 kernel/power/snapshot.c | 123 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 116 insertions(+), 7 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 5235dd4..e120a9e 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -881,6 +881,9 @@ static struct memory_bitmap *forbidden_pages_map;
 /* Set bits in this map correspond to free page frames. */
 static struct memory_bitmap *free_pages_map;
 
+/* Set bits in this map correspond to kernel mapped page frames. */
+static struct memory_bitmap *valid_pages_map;
+
 /*
  * Each page frame allocated for creating the image is marked by setting the
  * corresponding bits in forbidden_pages_map and free_pages_map simultaneously
@@ -922,6 +925,12 @@ static void swsusp_unset_page_forbidden(struct page *page)
 		memory_bm_clear_bit(forbidden_pages_map, page_to_pfn(page));
 }
 
+static int swsusp_page_is_valid(struct page *page)
+{
+	return valid_pages_map ?
+		memory_bm_test_bit(valid_pages_map, page_to_pfn(page)) : 0;
+}
+
 /**
  *	mark_nosave_pages - set bits corresponding to the page frames the
  *	contents of which should not be saved in a given bitmap.
@@ -956,6 +965,85 @@ static void mark_nosave_pages(struct memory_bitmap *bm)
 }
 
 /**
+ *	mark_valid_pages - set bits corresponding to the page frames
+ *	which are directly mapped by kernel at PAGE_OFFSET.
+ */
+#ifdef CONFIG_X86
+static void mark_valid_pages(struct memory_bitmap *bm)
+{
+	unsigned long start_pfn, end_pfn, j;
+	int i;
+
+	for (i = 0; i < nr_pfn_mapped; i++) {
+		start_pfn = pfn_mapped[i].start;
+		end_pfn = pfn_mapped[i].end;
+		for (j = start_pfn; j < end_pfn; j++)
+			mem_bm_set_bit_check(bm, j);
+	}
+}
+
+static bool is_valid_orig_page(unsigned long pfn)
+{
+	/*
+	 * For non-highmem pages, we leverage page_address
+	 * to retrieve its address, but we must make sure
+	 * this page has been directly mapped by kernel,
+	 * otherwise kernel exception will be triggered when accessing
+	 * unmapped pages. The related bug is reported here:
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=96111
+	 */
+	if (PageHighMem(pfn_to_page(pfn)))
+		return true;
+	if (!swsusp_page_is_valid(pfn_to_page(pfn))) {
+		pr_err(
+			"PM:  %#010llx to restored not in valid memory region\n",
+			(unsigned long long) pfn << PAGE_SHIFT);
+		return false;
+	} else
+		return true;
+}
+
+static bool memory_size_not_consistent(struct swsusp_info *info)
+{
+#ifdef CONFIG_X86_64
+	/*
+	 * For 64bit x86_64 systems, there is no need to check
+	 * num_physpages against get_num_physpages, because:
+	 * for x86_64, is_valid_orig_page ensures that each page to be
+	 * restored is strictly the subset of current system's
+	 * direct-mapping page frames, otherwise warn and deny the
+	 * hibernation in any other case.
+	 * Please refer to git changelog for why this code is
+	 * adjusted for x86_64.
+	 */
+	return false;
+#else
+	if (info->num_physpages != get_num_physpages())
+		return true;
+	else
+		return false;
+#endif
+}
+#else
+static void mark_valid_pages(struct memory_bitmap *bm)
+{
+}
+
+static bool is_valid_orig_page(unsigned long pfn)
+{
+	return true;
+}
+
+static bool memory_size_not_consistent(struct swsusp_info *info)
+{
+	if (info->num_physpages != get_num_physpages())
+		return true;
+	else
+		return false;
+}
+#endif
+
+/**
  *	create_basic_memory_bitmaps - create bitmaps needed for marking page
  *	frames that should not be saved and free page frames.  The pointers
  *	forbidden_pages_map and free_pages_map are only modified if everything
@@ -965,13 +1053,15 @@ static void mark_nosave_pages(struct memory_bitmap *bm)
 
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
@@ -989,14 +1079,28 @@ int create_basic_memory_bitmaps(void)
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
@@ -1015,19 +1119,24 @@ int create_basic_memory_bitmaps(void)
 
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
@@ -2023,7 +2132,7 @@ static int mark_unsafe_pages(struct memory_bitmap *bm)
 	do {
 		pfn = memory_bm_next_pfn(bm);
 		if (likely(pfn != BM_END_OF_MAP)) {
-			if (likely(pfn_valid(pfn)))
+			if (likely(pfn_valid(pfn)) && is_valid_orig_page(pfn))
 				swsusp_set_page_free(pfn_to_page(pfn));
 			else
 				return -EFAULT;
@@ -2053,7 +2162,7 @@ static int check_header(struct swsusp_info *info)
 	char *reason;
 
 	reason = check_image_kernel(info);
-	if (!reason && info->num_physpages != get_num_physpages())
+	if (!reason && memory_size_not_consistent(info))
 		reason = "memory size";
 	if (reason) {
 		printk(KERN_ERR "PM: Image mismatch: %s\n", reason);
-- 
1.8.4.2

