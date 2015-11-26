From: James Morse <james.morse@arm.com>
Subject: [PATCH v3 09/10] PM / Hibernate: Publish pages restored in-place to arch code
Date: Thu, 26 Nov 2015 17:32:47 +0000
Message-ID: <1448559168-8363-10-git-send-email-james.morse@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46304 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbbKZReY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 26 Nov 2015 12:34:24 -0500
In-Reply-To: <1448559168-8363-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>

Some architectures require code written to memory as if it were data to be
'cleaned' from any data caches before the processor can fetch them as new
instructions.

During resume from hibernate, the snapshot code copies some pages directly,
meaning these architectures do not get a chance to perform their cache
maintenance. Create a new list of pages that were restored in place, so
that the arch code can perform this maintenance when necessary.

Signed-off-by: James Morse <james.morse@arm.com>
---
 include/linux/suspend.h |  1 +
 kernel/power/snapshot.c | 42 ++++++++++++++++++++++++++++--------------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8b6ec7ef0854..b17cf6081bca 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -384,6 +384,7 @@ extern bool system_entering_hibernation(void);
 extern bool hibernation_available(void);
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
+extern struct pbe *restored_inplace_pblist;
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
 static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 3a970604308f..f251f5af49fb 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -74,6 +74,11 @@ void __init hibernate_image_size_init(void)
  */
 struct pbe *restore_pblist;
 
+/* List of PBEs that were restored in place. modified-harvard architectures
+ * need to 'clean' these pages before they can be executed.
+ */
+struct pbe *restored_inplace_pblist;
+
 /* Pointer to an auxiliary buffer (1 page) */
 static void *buffer;
 
@@ -1359,6 +1364,7 @@ out:
 	nr_copy_pages = 0;
 	nr_meta_pages = 0;
 	restore_pblist = NULL;
+	restored_inplace_pblist = NULL;
 	buffer = NULL;
 	alloc_normal = 0;
 	alloc_highmem = 0;
@@ -2072,6 +2078,7 @@ load_header(struct swsusp_info *info)
 	int error;
 
 	restore_pblist = NULL;
+	restored_inplace_pblist = NULL;
 	error = check_header(info);
 	if (!error) {
 		nr_copy_pages = info->image_pages;
@@ -2427,25 +2434,31 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
 	if (PageHighMem(page))
 		return get_highmem_page_buffer(page, ca);
 
-	if (swsusp_page_is_forbidden(page) && swsusp_page_is_free(page))
-		/* We have allocated the "original" page frame and we can
-		 * use it directly to store the loaded page.
-		 */
-		return page_address(page);
-
-	/* The "original" page frame has not been allocated and we have to
-	 * use a "safe" page frame to store the loaded page.
-	 */
 	pbe = chain_alloc(ca, sizeof(struct pbe));
 	if (!pbe) {
 		swsusp_free();
 		return ERR_PTR(-ENOMEM);
 	}
-	pbe->orig_address = page_address(page);
-	pbe->address = safe_pages_list;
-	safe_pages_list = safe_pages_list->next;
-	pbe->next = restore_pblist;
-	restore_pblist = pbe;
+
+	if (swsusp_page_is_forbidden(page) && swsusp_page_is_free(page)) {
+		/* We have allocated the "original" page frame and we can
+		 * use it directly to store the loaded page.
+		 */
+		pbe->orig_address = NULL;
+		pbe->address = page_address(page);
+		pbe->next = restored_inplace_pblist;
+		restored_inplace_pblist = pbe;
+	} else {
+		/* The "original" page frame has not been allocated and we
+		 * have to use a "safe" page frame to store the loaded page.
+		 */
+		pbe->orig_address = page_address(page);
+		pbe->address = safe_pages_list;
+		safe_pages_list = safe_pages_list->next;
+		pbe->next = restore_pblist;
+		restore_pblist = pbe;
+	}
+
 	return pbe->address;
 }
 
@@ -2513,6 +2526,7 @@ int snapshot_write_next(struct snapshot_handle *handle)
 			chain_init(&ca, GFP_ATOMIC, PG_SAFE);
 			memory_bm_position_reset(&orig_bm);
 			restore_pblist = NULL;
+			restored_inplace_pblist = NULL;
 			handle->buffer = get_buffer(&orig_bm, &ca);
 			handle->sync_read = 0;
 			if (IS_ERR(handle->buffer))
-- 
2.6.2

