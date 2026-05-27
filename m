Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3053C9EC3;
	Wed, 27 May 2026 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867221; cv=pass; b=PW2QEpX5DG9jpHuingw8Mcq8iU0fDjkNfD0KQ6PxNU8gpr9QMizko7ipF5/lPZdOL6dzt3MjM+XQakCmHU1Z/r7H2XJNf9lP7LSmoKRslPX9/TZHge3Pl8+u9HV859feE+LYm4mbr2DZP7ZYrj6e+Thd/8iW38lONQwcpaMUkw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867221; c=relaxed/simple;
	bh=sPOOMCB8JUj4Cb+F67h0SFplZXUq9uEVk/JcerlXwmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rIfhAOEaKQqaDdtWmiDzuYa46RF1TTpEYXtl4j5iMqaTzVUOZjzDM2VqAdse7aMbF78BHj3zVJGGNHGlB/ebqnhV/QGhEwg6m6tJRrs16UoXS8pWaEb2//xGww6LgzYp6ZcuUOQm9lHcUmvP63vapvD5YGdp7OX2MWByjGWqqkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lechthaler.online; spf=none smtp.mailfrom=lechthaler.online; dkim=pass (2048-bit key) header.d=lechthaler.online header.i=@lechthaler.online header.b=ObM5WE25; dkim=permerror (0-bit key) header.d=lechthaler.online header.i=@lechthaler.online header.b=9foiSNRP; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lechthaler.online
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lechthaler.online
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lechthaler.online header.i=@lechthaler.online header.b="ObM5WE25";
	dkim=permerror (0-bit key) header.d=lechthaler.online header.i=@lechthaler.online header.b="9foiSNRP"
ARC-Seal: i=1; a=rsa-sha256; t=1779867209; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oybbbeaFB6YWvi3FcRfXBTTAadTeil58QjTD3RzlEyFkl9375Xxfaq5nIfnn1PUS6v
    2L3GBghAJs6AB42FDGG+l5dK3f7DJmM9I8dcotz+fy8zD3JRXH0xahDeO9LUlW4g1OeX
    /SeDi6yd5YXqb8IUNZz7EFy+iimmMRX47BK3c0anzqqiZcXw8XOFwR58pj0NArtH2yQx
    EpuJtePs5nqzAD8onnJsUMt+z0+kUAtVlmopSrkCVhGSPxtonkj/TQH2p94kA0iRIVhC
    nUzcXJ28s7MmhPICFPZvYER+NdOjGhaIAbRGKg7Q59rKZ0lmJojZcqBmCrKlI4S93yvo
    hKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779867209;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=z+q2G3QdJMkg0+UCYhPgyxxM4W1VOAwaVfa1y1S/Ef8=;
    b=WNUagl7IItmC/1xQXXoJTJoJv8E1UXRO6l6kcSo2yGyqAktoRc6cK0SQBVz1RDRKSp
    nUIiRCbhaGKcrleimT+jXuJlrA9PKjK783ICOu4r3Zs0avigvPtdOrZBDLs0cKQL9N+x
    K70rxuDek7jR++g5obJGuBg87fHh0CpPQ9mSfwTtHItLjf6YnDM4Eb5PFjFypu4mWWwP
    nIl/7jexuwn8nOW1A3qBRk5KEkkK+ahov/wZDDy80mK1OnBrtbRJkl8iXBB10zJYokp6
    0zUPqt83hUReNoq6IcNoIAEmQ6vcsRZNJXtAvNcuiRwm7OEOEJWX3/9GVgRDRf8o+e1V
    IpUw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779867209;
    s=strato-dkim-0002; d=lechthaler.online;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=z+q2G3QdJMkg0+UCYhPgyxxM4W1VOAwaVfa1y1S/Ef8=;
    b=ObM5WE25SA0ETEdk5+vsXVYzQ4RFoNm44BkhNS0+OwvGPA6jG8DfJM24DYIIrNKqF0
    teEG0KJKudM9qWRcjkD32FrQvVcxfQdFXOfqz5cQkSBhmaNGHq/VkYiaWkxzZfg1/uxL
    b5qaIR3WwkujaZzfBSk8dkqaOJICFLhX4V+yJcUEepZzPTfYGVUK9WKtJQViWW8LcGYi
    U5T5RC+cnFdLqlHXmKf1nAqzqvYuFLPrpuOlhIbAdR0JWBVbwgCRusNhZzvFuTkV+lxE
    8QFb6ZC5IuNjsMDzY7fDa89kny69May4TDLn2thUMQdEB/IwfNR0AsJgV09Uy0QY96/R
    c6MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779867209;
    s=strato-dkim-0003; d=lechthaler.online;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=z+q2G3QdJMkg0+UCYhPgyxxM4W1VOAwaVfa1y1S/Ef8=;
    b=9foiSNRPHANYKjXmOaDlAEl0SqUgqCjroMb18dzhXm6EfpELzmV/WHCC5Ya5oKrbMI
    MtVar23jhk3GuWq3olCQ==
X-RZG-AUTH: ":LWABbUGmf/p3GWz138t3dAG4+iFy9XUTxnN94F8mUwTghZauya1bHdwWZANyhT7JUoBGg72fwp4OIxY="
Received: from alex-e16..
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id j78f5a24R7XS7Gr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 27 May 2026 09:33:28 +0200 (CEST)
From: Alexander Lechthaler <alexander@lechthaler.online>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lechthaler <alexander@lechthaler.online>
Subject: [PATCH v2] power/snapshot: fix kernel-doc warnings
Date: Wed, 27 May 2026 09:32:23 +0200
Message-ID: <20260527073223.54399-1-alexander@lechthaler.online>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Add missing parameter descriptions to kernel-doc comments in
kernel/power/snapshot.c to silence documentation warnings.

Also convert internal static function comments from kernel-doc
format (`/**`) to regular comments (`/*`).

Signed-off-by: Alexander Lechthaler <alexander@lechthaler.online>
---
 kernel/power/snapshot.c | 126 +++++++++++++++++++++++++++-------------
 1 file changed, 87 insertions(+), 39 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index a564650734dc..da3c3adcfe63 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -175,7 +175,7 @@ static void *buffer;
 
 static unsigned int allocated_unsafe_pages;
 
-/**
+/*
  * get_image_page - Allocate a page for a hibernation image.
  * @gfp_mask: GFP mask for the allocation.
  * @safe_needed: Get pages that were not used before hibernation (restore only)
@@ -244,7 +244,7 @@ static void recycle_safe_page(void *page_address)
 	safe_pages_list = lp;
 }
 
-/**
+/*
  * free_image_page - Free a page allocated for hibernation image.
  * @addr: Address of the page to free.
  * @clear_nosave_free: If set, clear the PageNosaveFree bit for the page.
@@ -428,7 +428,7 @@ struct memory_bitmap {
 #endif
 #define BM_RTREE_LEVEL_MASK	((1UL << BM_RTREE_LEVEL_SHIFT) - 1)
 
-/**
+/*
  * alloc_rtree_node - Allocate a new node and add it to the radix tree.
  * @gfp_mask: GFP mask for the allocation.
  * @safe_needed: Get pages not used before hibernation (restore only)
@@ -458,8 +458,12 @@ static struct rtree_node *alloc_rtree_node(gfp_t gfp_mask, int safe_needed,
 	return node;
 }
 
-/**
+/*
  * add_rtree_block - Add a new leave node to the radix tree.
+ * @zone: Radix tree where node gets added.
+ * @gfp_mask: GFP mask for the allocation.
+ * @safe_needed: Get pages not used before hibernation (restore only).
+ * @ca: Pointer to a linked list of pages ("a chain") to allocate from.
  *
  * The leave nodes need to be allocated in order to keep the leaves
  * linked list in order. This is guaranteed by the zone->blocks
@@ -528,8 +532,13 @@ static int add_rtree_block(struct mem_zone_bm_rtree *zone, gfp_t gfp_mask,
 static void free_zone_bm_rtree(struct mem_zone_bm_rtree *zone,
 			       int clear_nosave_free);
 
-/**
+/*
  * create_zone_bm_rtree - Create a radix tree for one zone.
+ * @gfp_mask: GFP mask for the allocation.
+ * @safe_needed: Get pages not used before hibernation (restore only).
+ * @ca: Pointer to a linked list of pages ("a chain") to allocate from.
+ * @start: First page frame number (PFN) in the zone to build the tree for.
+ * @end: PFN one past the last page covered by the tree.
  *
  * Allocated the mem_zone_bm_rtree structure and initializes it.
  * This function also allocated and builds the radix tree for the
@@ -566,8 +575,10 @@ static struct mem_zone_bm_rtree *create_zone_bm_rtree(gfp_t gfp_mask,
 	return zone;
 }
 
-/**
+/*
  * free_zone_bm_rtree - Free the memory of the radix tree.
+ * @zone: Radix tree to free node pages from.
+ * @clear_nosave_free: If set, clear the PageNosaveFree bit for the pages.
  *
  * Free all node pages of the radix tree. The mem_zone_bm_rtree
  * structure itself is not freed here nor are the rtree_node
@@ -604,7 +615,7 @@ struct mem_extent {
 	unsigned long end;
 };
 
-/**
+/*
  * free_mem_extents - Free a list of memory extents.
  * @list: List of extents to free.
  */
@@ -618,7 +629,7 @@ static void free_mem_extents(struct list_head *list)
 	}
 }
 
-/**
+/*
  * create_mem_extents - Create a list of memory extents.
  * @list: List to put the extents into.
  * @gfp_mask: Mask to use for memory allocations.
@@ -678,8 +689,11 @@ static int create_mem_extents(struct list_head *list, gfp_t gfp_mask)
 	return 0;
 }
 
-/**
+/*
  * memory_bm_create - Allocate memory for a memory bitmap.
+ * @bm: Memory bitmap.
+ * @gfp_mask: Mask to use for memory allocations.
+ * @safe_needed: Get pages not used before hibernation (restore only).
  */
 static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
 			    int safe_needed)
@@ -720,9 +734,10 @@ static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
 	goto Exit;
 }
 
-/**
+/*
  * memory_bm_free - Free memory occupied by the memory bitmap.
  * @bm: Memory bitmap.
+ * @clear_nosave_free: If set, clear the PageNosaveFree bit for the pages.
  */
 static void memory_bm_free(struct memory_bitmap *bm, int clear_nosave_free)
 {
@@ -736,11 +751,16 @@ static void memory_bm_free(struct memory_bitmap *bm, int clear_nosave_free)
 	INIT_LIST_HEAD(&bm->zones);
 }
 
-/**
+/*
  * memory_bm_find_bit - Find the bit for a given PFN in a memory bitmap.
+ * @bm: Memory bitmap.
+ * @pfn: Page Frame Number (PFN).
+ * @addr: Returned address of the bitmap storage containing the bit.
+ * @bit_nr: Returned bit number within @addr.
  *
  * Find the bit in memory bitmap @bm that corresponds to the given PFN.
- * The cur.zone, cur.block and cur.node_pfn members of @bm are updated.
+ * The cur.zone, cur.node, cur.node_pfn and cur.cur_pfn members
+ * of @bm are updated.
  *
  * Walk the radix tree to find the page containing the bit that represents @pfn
  * and return the position of the bit in @addr and @bit_nr.
@@ -881,6 +901,7 @@ static bool memory_bm_pfn_present(struct memory_bitmap *bm, unsigned long pfn)
 
 /*
  * rtree_next_node - Jump to the next leaf node.
+ * @bm: Memory bitmap.
  *
  * Set the position to the beginning of the next node in the
  * memory bitmap. This is either the next node in the current
@@ -915,7 +936,7 @@ static bool rtree_next_node(struct memory_bitmap *bm)
 	return false;
 }
 
-/**
+/*
  * memory_bm_next_pfn - Find the next set bit in a memory bitmap.
  * @bm: Memory bitmap.
  *
@@ -990,6 +1011,8 @@ static void memory_bm_recycle(struct memory_bitmap *bm)
 
 /**
  * register_nosave_region - Register a region of unsaveable memory.
+ * @start_pfn: Start page frame number (PFN).
+ * @end_pfn: End page frame number (PFN).
  *
  * Register a range of page frames the contents of which should not be saved
  * during hibernation (to be used in the early initialization code).
@@ -1072,7 +1095,7 @@ static void swsusp_unset_page_forbidden(struct page *page)
 		memory_bm_clear_bit(forbidden_pages_map, page_to_pfn(page));
 }
 
-/**
+/*
  * mark_nosave_pages - Mark pages that should not be saved.
  * @bm: Memory bitmap.
  *
@@ -1288,7 +1311,7 @@ static void mark_free_pages(struct zone *zone)
 }
 
 #ifdef CONFIG_HIGHMEM
-/**
+/*
  * count_free_highmem_pages - Compute the total number of free highmem pages.
  *
  * The returned number is system-wide.
@@ -1305,8 +1328,10 @@ static unsigned int count_free_highmem_pages(void)
 	return cnt;
 }
 
-/**
+/*
  * saveable_highmem_page - Check if a highmem page is saveable.
+ * @zone: Zone containing the PFN.
+ * @pfn: Page frame number to check.
  *
  * Determine whether a highmem page should be included in a hibernation image.
  *
@@ -1338,7 +1363,7 @@ static struct page *saveable_highmem_page(struct zone *zone, unsigned long pfn)
 	return page;
 }
 
-/**
+/*
  * count_highmem_pages - Compute the total number of saveable highmem pages.
  */
 static unsigned int count_highmem_pages(void)
@@ -1362,8 +1387,10 @@ static unsigned int count_highmem_pages(void)
 }
 #endif /* CONFIG_HIGHMEM */
 
-/**
+/*
  * saveable_page - Check if the given page is saveable.
+ * @zone: Zone containing the PFN.
+ * @pfn: Page frame number to check.
  *
  * Determine whether a non-highmem page should be included in a hibernation
  * image.
@@ -1401,7 +1428,7 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
 	return page;
 }
 
-/**
+/*
  * count_data_pages - Compute the total number of saveable non-highmem pages.
  */
 static unsigned int count_data_pages(void)
@@ -1440,8 +1467,10 @@ static inline bool do_copy_page(long *dst, long *src)
 	return !z;
 }
 
-/**
+/*
  * safe_copy_page - Copy a page in a safe way.
+ * @dst: Destination page.
+ * @s_page: Source page.
  *
  * Check if the page we are going to copy is marked as present in the kernel
  * page tables. This always is the case if CONFIG_DEBUG_PAGEALLOC or
@@ -1637,7 +1666,7 @@ void swsusp_free(void)
 
 #define GFP_IMAGE	(GFP_KERNEL | __GFP_NOWARN)
 
-/**
+/*
  * preallocate_image_pages - Allocate a number of pages for hibernation image.
  * @nr_pages: Number of page frames to allocate.
  * @mask: GFP flags to use for the allocation.
@@ -1687,8 +1716,11 @@ static unsigned long preallocate_image_highmem(unsigned long nr_pages)
 	return preallocate_image_pages(nr_pages, GFP_IMAGE | __GFP_HIGHMEM);
 }
 
-/**
+/*
  *  __fraction - Compute (an approximation of) x * (multiplier / base).
+ * @x: Value the fraction is applied to.
+ * @multiplier: Fraction numerator.
+ * @base: Fraction denominator.
  */
 static unsigned long __fraction(u64 x, u64 multiplier, u64 base)
 {
@@ -1717,7 +1749,7 @@ static inline unsigned long preallocate_highmem_fraction(unsigned long nr_pages,
 }
 #endif /* CONFIG_HIGHMEM */
 
-/**
+/*
  * free_unnecessary_pages - Release preallocated pages not needed for the image.
  */
 static unsigned long free_unnecessary_pages(void)
@@ -1771,7 +1803,7 @@ static unsigned long free_unnecessary_pages(void)
 	return free;
 }
 
-/**
+/*
  * minimum_image_size - Estimate the minimum acceptable size of an image.
  * @saveable: Number of saveable pages in the system.
  *
@@ -1982,8 +2014,9 @@ int hibernate_preallocate_memory(void)
 }
 
 #ifdef CONFIG_HIGHMEM
-/**
+/*
  * count_pages_for_highmem - Count non-highmem pages needed for copying highmem.
+ * @nr_highmem: Number of highmem pages to copy.
  *
  * Compute the number of non-highmem pages that will be necessary for creating
  * copies of highmem pages.
@@ -2003,8 +2036,10 @@ static unsigned int count_pages_for_highmem(unsigned int nr_highmem)
 static unsigned int count_pages_for_highmem(unsigned int nr_highmem) { return 0; }
 #endif /* CONFIG_HIGHMEM */
 
-/**
+/*
  * enough_free_mem - Check if there is enough free memory for the image.
+ * @nr_pages: Number of normal pages required for the image.
+ * @nr_highmem: Number of highmem pages required for the image.
  */
 static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
 {
@@ -2023,8 +2058,9 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
 }
 
 #ifdef CONFIG_HIGHMEM
-/**
+/*
  * get_highmem_buffer - Allocate a buffer for highmem pages.
+ * @safe_needed: Whether a safe buffer for copying highmem pages is needed.
  *
  * If there are some highmem pages in the hibernation image, we may need a
  * buffer to copy them and/or load their data.
@@ -2035,8 +2071,10 @@ static inline int get_highmem_buffer(int safe_needed)
 	return buffer ? 0 : -ENOMEM;
 }
 
-/**
+/*
  * alloc_highmem_pages - Allocate some highmem pages for the image.
+ * @bm: Bitmap to mark allocated pages in.
+ * @nr_highmem: Number of highmem pages to allocate.
  *
  * Try to allocate as many pages as needed, but if the number of free highmem
  * pages is less than that, allocate them all.
@@ -2065,8 +2103,11 @@ static inline unsigned int alloc_highmem_pages(struct memory_bitmap *bm,
 					       unsigned int n) { return 0; }
 #endif /* CONFIG_HIGHMEM */
 
-/**
+/*
  * swsusp_alloc - Allocate memory for hibernation image.
+ * @copy_bm: Bitmap to mark allocated pages in.
+ * @nr_pages: Number of normal pages to allocate.
+ * @nr_highmem: Number of highmem pages to allocate.
  *
  * We first try to allocate as many highmem pages as there are
  * saveable highmem pages in the system.  If that fails, we allocate
@@ -2191,7 +2232,7 @@ static int init_header(struct swsusp_info *info)
 #define ENCODED_PFN_ZERO_FLAG ((unsigned long)1 << (BITS_PER_LONG - 1))
 #define ENCODED_PFN_MASK (~ENCODED_PFN_ZERO_FLAG)
 
-/**
+/*
  * pack_pfns - Prepare PFNs for saving.
  * @bm: Memory bitmap.
  * @buf: Memory buffer to store the PFNs in.
@@ -2292,8 +2333,9 @@ static void duplicate_memory_bitmap(struct memory_bitmap *dst,
 	}
 }
 
-/**
+/*
  * mark_unsafe_pages - Mark pages that were used before hibernation.
+ * @bm: Bitmap containing PFNs of pages used before hibernation.
  *
  * Mark the pages that cannot be used for storing the image during restoration,
  * because they conflict with the pages that had been used before hibernation.
@@ -2330,8 +2372,9 @@ static int check_header(struct swsusp_info *info)
 	return 0;
 }
 
-/**
+/*
  * load_header - Check the image header and copy the data from it.
+ * @info: Pointer to the structure to copy the header data to.
  */
 static int load_header(struct swsusp_info *info)
 {
@@ -2346,7 +2389,7 @@ static int load_header(struct swsusp_info *info)
 	return error;
 }
 
-/**
+/*
  * unpack_orig_pfns - Set bits corresponding to given PFNs in a memory bitmap.
  * @bm: Memory bitmap.
  * @buf: Area of memory containing the PFNs.
@@ -2406,7 +2449,7 @@ struct highmem_pbe {
  */
 static struct highmem_pbe *highmem_pblist;
 
-/**
+/*
  * count_highmem_image_pages - Compute the number of highmem pages in the image.
  * @bm: Memory bitmap.
  *
@@ -2432,7 +2475,7 @@ static unsigned int safe_highmem_pages;
 
 static struct memory_bitmap *safe_highmem_bm;
 
-/**
+/*
  * prepare_highmem_image - Allocate memory for loading highmem data from image.
  * @bm: Pointer to an uninitialized memory bitmap structure.
  * @nr_highmem_p: Pointer to the number of highmem image pages.
@@ -2483,8 +2526,10 @@ static int prepare_highmem_image(struct memory_bitmap *bm,
 
 static struct page *last_highmem_page;
 
-/**
+/*
  * get_highmem_page_buffer - Prepare a buffer to store a highmem image page.
+ * @page: Page structure of the highmem image page to be loaded.
+ * @ca: Chain allocator to allocate memory for the page copy if needed.
  *
  * For a given highmem image page get a buffer that suspend_write_next() should
  * return to its caller to write to.
@@ -2546,7 +2591,7 @@ static void *get_highmem_page_buffer(struct page *page,
 	return kaddr;
 }
 
-/**
+/*
  * copy_last_highmem_page - Copy most the most recent highmem image page.
  *
  * Copy the contents of a highmem image from @buffer, where the caller of
@@ -2597,7 +2642,7 @@ static inline void free_highmem_data(void) {}
 
 #define PBES_PER_LINKED_PAGE	(LINKED_PAGE_DATA_SIZE / sizeof(struct pbe))
 
-/**
+/*
  * prepare_image - Make room for loading hibernation image.
  * @new_bm: Uninitialized memory bitmap structure.
  * @bm: Memory bitmap with unsafe pages marked.
@@ -2706,8 +2751,10 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
 	return error;
 }
 
-/**
+/*
  * get_buffer - Get the address to store the next image data page.
+ * @bm: Memory bitmap with the "original" PFNs of the image pages.
+ * @ca: Chain allocator to allocate memory for the page copy if needed.
  *
  * Get the address that snapshot_write_next() should return to its caller to
  * write to.
@@ -2845,6 +2892,7 @@ int snapshot_write_next(struct snapshot_handle *handle)
 
 /**
  * snapshot_write_finalize - Complete the loading of a hibernation image.
+ * @handle: Snapshot handle structure used for the loading.
  *
  * Must be called after the last call to snapshot_write_next() in case the last
  * page in the image happens to be a highmem page and its contents should be
-- 
2.43.0

