Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B23C4B81
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781448125; cv=none; b=OmNhehOGv6javznBnEDWs0lyvYLWvzN1aIZrrq2Ogx9I3j8kB3aKRXhNkI+d+Bs+7/QAN6C8Xn6juQkw8JY7b5yJYFxsr03sAL1QmTmoD5b99zyW2tnWP3fn/9jkS7JoLHRBFgo2XZyIlLiMh5ZhIcBlfZNmneLB0uS7z0X7v8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781448125; c=relaxed/simple;
	bh=MjKtAHoERcy68wZzUa6udMP5EXDtwiJOL0t4qPEs+wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CsFmfdl1B/gnsp+hjblja5ojeuFJ7rQJChe9i0inyIy7ZrMLSpzBgOCvI940LVy4qs+uuC3fgbJeVDg0WI1X6Aj7y8Bm/XWgVUFQGN/sDxgaVSgF8Km8eiyuQBEh1MPgUtA/Fq5I29B6fJ8fstYI1ZfKl4DjKqicgMMEhpnuab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzPgWz/K; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzPgWz/K"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490a76757e5so17372925e9.2
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781448122; x=1782052922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fV7vSNqEWWo4/nPAG+OlMNWkB/5EiiwzzKFp8ZOYLzk=;
        b=kzPgWz/KKFae/6XkJn/qLKFqYL46Hpf/aA8ftG/O06x7FAFSwoP1S3Pucx6iUgG1K7
         q1kGQqwg5lHwGFC71siJjVoqkkFdUzUYrgNFGIhe39j3McR6gmVRoXrt4vscXQMsoe25
         R7yQg79BRZT9u5cfuC29NhbhPxIhAV5RN36OwKzkjuHdAiDIwwOuEczt/dFz140qEA7p
         zAXckqaqvEtDkQAlOCLsSIdiDLlOXt0+Xo2idMp/l37yqPJjF5ONFv+9VTfjaSynjE0u
         Jux8ynT5djlmbydig7QtB4hluX0YelVQqYsZS2KSR68jq9usppRWTiVoEBimKgeZzkqH
         BTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781448122; x=1782052922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fV7vSNqEWWo4/nPAG+OlMNWkB/5EiiwzzKFp8ZOYLzk=;
        b=hkSFiOUnglViENP0fdiOYzREMajiVpCDYcohWVHvpp4fG+pvPoX8uRs+E9HasJpUCh
         9xZL2qfoNhPB2h0LrgvVdoiyif1LDGN4zSke/9gOZbolva9D0WZSPbb2HsfE6ud/LeBQ
         V2z499iD+I43QBsQMpgqwmLma11Lhi9cIlWWJD4uzVETQIyYSFC4D8LSyA4VoolhWkN7
         GkXkRP39gprUaoVFLbzh8lu3Yoga6RtzTJoAiHqTHxBTZVQW7/R2Tqv0hQEGlOb4LLdy
         ULlQdIy8cxNqTv09k+eY3cIsaSaozHB+lNVep4m4EBK0bcACpZaSanhkFLuqDKzWQ8C8
         79QQ==
X-Forwarded-Encrypted: i=1; AFNElJ+JQdMWvWQVGGVrg8DmBNmSGEPqucfh8PDExpzyRlgtJDgkr8RYR3/rxwX+192NH5JOBqFV+SOMXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgMRp4a+WYmAFCLawQHf18fMEJk3cQVWhkjU0HeBhRHXDi16BT
	GtvY/WE3eoq1/Y8b5CtgyqYTqZ31F8bcDvZZci2SplOYj0YPQMrHsVwO
X-Gm-Gg: Acq92OHD3I6j8wDHj9shiDFVAOat/zctxsvnN8QUmQJVeICa4Jf0aDBZbkkUbraB601
	HSJWOTddhMg3T8kqAL0Ak7cxB3XKExLSMaWn61WqwAPFd/nOi6x1Rki7h9zakk4+5gnW1PFm/Mk
	tFQldTklYt7JM73VNB8fDCbHQzcX49gCUgMwCuGLxZhRMaKKJ7Ayqkt54wKMyaXnTQdHJytFwC8
	lgysIfYTjZKpJDya1fxuEzfFWEzhySwLVpLaLkxQ7+tiOwLrQ6AH573sLsSSLrrBNQsoSrG+2nM
	icavrfdGlenKPDLgyxAPJ7nBR/4vpNIByBdnZeDlHHMiocoAyJQz7DRXtNili6hUNZm8X0FaGmU
	fbNllYHmtKuXQODDBw+kf3CCbmp1TxWqBgQBL6StyeaXq9kIo9y6VcINpVGu+hP5gGN6n1GngfM
	xvVImG7zR8OUS7zkiGUmLHVBTMN+aiN+zcIaE9tq87zbzcFPucGnu9RefkVmgibdm4iUFL1EJeV
	A==
X-Received: by 2002:a7b:c44b:0:b0:490:e60b:5fd8 with SMTP id 5b1f17b1804b1-492200e7ba3mr57356095e9.26.1781448122093;
        Sun, 14 Jun 2026 07:42:02 -0700 (PDT)
Received: from DESKTOP-80V9C1H (89-93-105-162.hfc.dyn.abo.bbox.fr. [89.93.105.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922037ba81sm165466495e9.15.2026.06.14.07.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 07:42:01 -0700 (PDT)
From: Ronan Marchal <ronanmarchal29@gmail.com>
To: rafael@kernel.org
Cc: pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ronan Marchal <ronanmarchal29@gmail.com>
Subject: [PATCH] kernel/power/snapshot: Add missing kernel-doc parameter descriptions
Date: Sun, 14 Jun 2026 16:41:58 +0200
Message-ID: <20260614144158.82751-1-ronanmarchal29@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing parameter descriptions in kernel-doc comments to fix
warnings reported by scripts/kernel-doc -none.

Signed-off-by: Ronan Marchal <ronanmarchal29@gmail.com>
---
 kernel/power/snapshot.c | 72 +++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index a564650734dc..5941d2ec4c64 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -460,6 +460,11 @@ static struct rtree_node *alloc_rtree_node(gfp_t gfp_mask, int safe_needed,
 
 /**
  * add_rtree_block - Add a new leave node to the radix tree.
+ * @gfp_mask: GFP mask for the allocation.
+ * @safe_needed: Get pages not used before hibernation (restore only)
+ * @ca: Pointer to a linked list of pages ("a chain") to allocate from
+ * @zone: The radix tree zone bitmap whose blocks counter tracks
+ *        the position of the next leave node to allocate.
  *
  * The leave nodes need to be allocated in order to keep the leaves
  * linked list in order. This is guaranteed by the zone->blocks
@@ -530,10 +535,15 @@ static void free_zone_bm_rtree(struct mem_zone_bm_rtree *zone,
 
 /**
  * create_zone_bm_rtree - Create a radix tree for one zone.
+ * @gfp_mask: GFP mask for the allocation.
+ * @safe_needed: Get pages not used before hibernation (restore only).
+ * @ca: Pointer to a linked list of pages ("a chain") to allocate from.
+ * @start: Start PFN of the zone.
+ * @end: End PFN of the zone.
  *
- * Allocated the mem_zone_bm_rtree structure and initializes it.
- * This function also allocated and builds the radix tree for the
- * zone.
+ * Allocates and initializes the mem_zone_bm_rtree structure, including
+ * its nodes and leaves lists. Builds the radix tree by allocating the
+ * number of blocks required to cover all pages in the [@start, @end] range.
  */
 static struct mem_zone_bm_rtree *create_zone_bm_rtree(gfp_t gfp_mask,
 						      int safe_needed,
@@ -568,6 +578,8 @@ static struct mem_zone_bm_rtree *create_zone_bm_rtree(gfp_t gfp_mask,
 
 /**
  * free_zone_bm_rtree - Free the memory of the radix tree.
+ * @zone: The radix tree to free.
+ * @clear_nosave_free: If set, clear the PageNosaveFree bit for the page.
  *
  * Free all node pages of the radix tree. The mem_zone_bm_rtree
  * structure itself is not freed here nor are the rtree_node
@@ -680,6 +692,11 @@ static int create_mem_extents(struct list_head *list, gfp_t gfp_mask)
 
 /**
  * memory_bm_create - Allocate memory for a memory bitmap.
+ * @bm: Memory bitmap.
+ * @gfp_mask: GFP mask for the allocation.
+ * @safe_needed: Get pages not used before hibernation (restore only).
+ *
+ * Allocate memory for a memory bitmap and initialize it.
  */
 static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
 			    int safe_needed)
@@ -723,6 +740,8 @@ static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
 /**
  * memory_bm_free - Free memory occupied by the memory bitmap.
  * @bm: Memory bitmap.
+ * @clear_nosave_free: If set, clear the PageNosaveFree bit for the page.
+ *
  */
 static void memory_bm_free(struct memory_bitmap *bm, int clear_nosave_free)
 {
@@ -738,6 +757,10 @@ static void memory_bm_free(struct memory_bitmap *bm, int clear_nosave_free)
 
 /**
  * memory_bm_find_bit - Find the bit for a given PFN in a memory bitmap.
+ * @bm: Memory bitmap.
+ * @pfn: The page frame number to find.
+ * @addr: The address of the memory page containing the bit for @pfn.
+ * @bit_nr: The bit index within the page for @pfn.
  *
  * Find the bit in memory bitmap @bm that corresponds to the given PFN.
  * The cur.zone, cur.block and cur.node_pfn members of @bm are updated.
@@ -881,7 +904,8 @@ static bool memory_bm_pfn_present(struct memory_bitmap *bm, unsigned long pfn)
 
 /*
  * rtree_next_node - Jump to the next leaf node.
- *
+ * @bm: Memory bitmap.
+ *
  * Set the position to the beginning of the next node in the
  * memory bitmap. This is either the next node in the current
  * zone's radix tree or the first node in the radix tree of the
@@ -990,6 +1014,8 @@ static void memory_bm_recycle(struct memory_bitmap *bm)
 
 /**
  * register_nosave_region - Register a region of unsaveable memory.
+ * @start_pfn: The starting page frame number.
+ * @end_pfn: The ending page frame number.
  *
  * Register a range of page frames the contents of which should not be saved
  * during hibernation (to be used in the early initialization code).
@@ -1307,9 +1333,11 @@ static unsigned int count_free_highmem_pages(void)
 
 /**
  * saveable_highmem_page - Check if a highmem page is saveable.
+ * @zone: The zone to which the page belongs.
+ * @pfn: The page frame number of the page to check.
  *
  * Determine whether a highmem page should be included in a hibernation image.
- *
+ *
  * We should save the page if it isn't Nosave or NosaveFree, or Reserved,
  * and it isn't part of a free chunk of pages.
  */
@@ -1364,7 +1392,9 @@ static unsigned int count_highmem_pages(void)
 
 /**
  * saveable_page - Check if the given page is saveable.
- *
+ * @zone: The zone to which the page belongs.
+ * @pfn: The page frame number of the page to check.
+ *
  * Determine whether a non-highmem page should be included in a hibernation
  * image.
  *
@@ -1442,7 +1472,9 @@ static inline bool do_copy_page(long *dst, long *src)
 
 /**
  * safe_copy_page - Copy a page in a safe way.
- *
+ * @dst: The destination address to copy to.
+ * @s_page: The source page to copy from.
+ *
  * Check if the page we are going to copy is marked as present in the kernel
  * page tables. This always is the case if CONFIG_DEBUG_PAGEALLOC or
  * CONFIG_ARCH_HAS_SET_DIRECT_MAP is not set. In that case kernel_page_present()
@@ -1688,7 +1720,10 @@ static unsigned long preallocate_image_highmem(unsigned long nr_pages)
 }
 
 /**
- *  __fraction - Compute (an approximation of) x * (multiplier / base).
+ * __fraction - Compute (an approximation of) x * (multiplier / base).
+ * @x: The value to multiply.
+ * @multiplier: The numerator of the fraction.
+ * @base: The denominator of the fraction.
  */
 static unsigned long __fraction(u64 x, u64 multiplier, u64 base)
 {
@@ -1984,6 +2019,7 @@ int hibernate_preallocate_memory(void)
 #ifdef CONFIG_HIGHMEM
 /**
  * count_pages_for_highmem - Count non-highmem pages needed for copying highmem.
+ * @nr_highmem: Number of highmem pages to copy.
  *
  * Compute the number of non-highmem pages that will be necessary for creating
  * copies of highmem pages.
@@ -2003,8 +2039,13 @@ static unsigned int count_pages_for_highmem(unsigned int nr_highmem)
 static unsigned int count_pages_for_highmem(unsigned int nr_highmem) { return 0; }
 #endif /* CONFIG_HIGHMEM */
 
-/**
+c/**
  * enough_free_mem - Check if there is enough free memory for the image.
+ * @nr_pages: Number of non-highmem pages to copy.
+ * @nr_highmem: Number of highmem pages to copy.
+ *
+ * Check if there are enough free non-highmem pages available to save
+ * the hibernation image.
  */
 static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
 {
@@ -2025,6 +2066,7 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
 #ifdef CONFIG_HIGHMEM
 /**
  * get_highmem_buffer - Allocate a buffer for highmem pages.
+ * @safe_needed: The type of pages to allocate for the buffer.
  *
  * If there are some highmem pages in the hibernation image, we may need a
  * buffer to copy them and/or load their data.
@@ -2037,6 +2079,8 @@ static inline int get_highmem_buffer(int safe_needed)
 
 /**
  * alloc_highmem_pages - Allocate some highmem pages for the image.
+ * @bm: Memory bitmap.
+ * @nr_highmem: Number of highmem pages to allocate.
  *
  * Try to allocate as many pages as needed, but if the number of free highmem
  * pages is less than that, allocate them all.
@@ -2067,6 +2111,9 @@ static inline unsigned int alloc_highmem_pages(struct memory_bitmap *bm,
 
 /**
  * swsusp_alloc - Allocate memory for hibernation image.
+ * @copy_bm: Memory bitmap.
+ * @nr_pages: Number of non-highmem pages to allocate.
+ * @nr_highmem: Number of highmem pages to allocate.
  *
  * We first try to allocate as many highmem pages as there are
  * saveable highmem pages in the system.  If that fails, we allocate
@@ -2294,6 +2341,7 @@ static void duplicate_memory_bitmap(struct memory_bitmap *dst,
 
 /**
  * mark_unsafe_pages - Mark pages that were used before hibernation.
+ * @bm: Memory bitmap.
  *
  * Mark the pages that cannot be used for storing the image during restoration,
  * because they conflict with the pages that had been used before hibernation.
@@ -2332,6 +2380,7 @@ static int check_header(struct swsusp_info *info)
 
 /**
  * load_header - Check the image header and copy the data from it.
+ * @info: Structure containing the image header.
  */
 static int load_header(struct swsusp_info *info)
 {
@@ -2485,6 +2534,8 @@ static struct page *last_highmem_page;
 
 /**
  * get_highmem_page_buffer - Prepare a buffer to store a highmem image page.
+ * @page: Pointer to the highmem image page.
+ * @ca: Pointer to the chain allocator structure.
  *
  * For a given highmem image page get a buffer that suspend_write_next() should
  * return to its caller to write to.
@@ -2708,6 +2759,8 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
 
 /**
  * get_buffer - Get the address to store the next image data page.
+ * @bm: Memory bitmap.
+ * @ca: Pointer to the chain allocator structure.
  *
  * Get the address that snapshot_write_next() should return to its caller to
  * write to.
@@ -2845,6 +2898,7 @@ int snapshot_write_next(struct snapshot_handle *handle)
 
 /**
  * snapshot_write_finalize - Complete the loading of a hibernation image.
+ * @handle: Snapshot handle structure to guide the writing.
  *
  * Must be called after the last call to snapshot_write_next() in case the last
  * page in the image happens to be a highmem page and its contents should be
-- 
2.53.0

