From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] PM / hibernate: Clean up comments in snapshot.c
Date: Wed, 06 Jul 2016 23:43:46 +0200
Message-ID: <4596346.p6dvE20klp@vostro.rjw.lan>
References: <20396026.uktHd5ozkC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57936 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755769AbcGFVkF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2016 17:40:05 -0400
In-Reply-To: <20396026.uktHd5ozkC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Many comments in kernel/power/snapshot.c do not follow the general
comment formatting rules.  They look odd, some of them are outdated
too, some are hard to parse and generally difficult to understand.

Clean them up to make them easier to comprehend.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/snapshot.c |  662 ++++++++++++++++++++++++------------------------
 1 file changed, 343 insertions(+), 319 deletions(-)

Index: linux-pm/kernel/power/snapshot.c
===================================================================
--- linux-pm.orig/kernel/power/snapshot.c
+++ linux-pm/kernel/power/snapshot.c
@@ -92,7 +92,8 @@ void __init hibernate_image_size_init(vo
 	image_size = ((totalram_pages * 2) / 5) * PAGE_SIZE;
 }
 
-/* List of PBEs needed for restoring the pages that were allocated before
+/*
+ * List of PBEs needed for restoring the pages that were allocated before
  * the suspend and included in the suspend image, but have also been
  * allocated by the "resume" kernel, so their contents cannot be written
  * directly to their "original" page frames.
@@ -118,16 +119,6 @@ static struct linked_page *safe_pages_li
 /* Pointer to an auxiliary buffer (1 page) */
 static void *buffer;
 
-/**
- *	@safe_needed - on resume, for storing the PBE list and the image,
- *	we can only use memory pages that do not conflict with the pages
- *	used before suspend.  The unsafe pages have PageNosaveFree set
- *	and we count them using unsafe_pages.
- *
- *	Each allocated image page is marked as PageNosave and PageNosaveFree
- *	so that swsusp_free() can release it.
- */
-
 #define PG_ANY		0
 #define PG_SAFE		1
 #define PG_UNSAFE_CLEAR	1
@@ -135,6 +126,19 @@ static void *buffer;
 
 static unsigned int allocated_unsafe_pages;
 
+/**
+ * get_image_page - Allocate a page for a hibernation image.
+ * @gfp_mask: GFP mask for the allocation.
+ * @safe_needed: Get pages that were not used before hibernation (restore only)
+ *
+ * During image restoration, for storing the PBE list and the image data, we can
+ * only use memory pages that do not conflict with the pages used before
+ * hibernation.  The "unsafe" pages have PageNosaveFree set and we count them
+ * using allocated_unsafe_pages.
+ *
+ * Each allocated image page is marked as PageNosave and PageNosaveFree so that
+ * swsusp_free() can release it.
+ */
 static void *get_image_page(gfp_t gfp_mask, int safe_needed)
 {
 	void *res;
@@ -192,10 +196,13 @@ static void recycle_safe_page(void *page
 }
 
 /**
- *	free_image_page - free page represented by @addr, allocated with
- *	get_image_page (page flags set by it must be cleared)
+ * free_image_page - Free a page allocated for hibernation image.
+ * @addr: Address of the page to free.
+ * @clear_nosave_free: If set, clear the PageNosaveFree bit for the page.
+ *
+ * The page to free should have been allocated by get_image_page() (page flags
+ * set by it are affected).
  */
-
 static inline void free_image_page(void *addr, int clear_nosave_free)
 {
 	struct page *page;
@@ -222,24 +229,22 @@ static inline void free_list_of_pages(st
 	}
 }
 
-/**
-  *	struct chain_allocator is used for allocating small objects out of
-  *	a linked list of pages called 'the chain'.
-  *
-  *	The chain grows each time when there is no room for a new object in
-  *	the current page.  The allocated objects cannot be freed individually.
-  *	It is only possible to free them all at once, by freeing the entire
-  *	chain.
-  *
-  *	NOTE: The chain allocator may be inefficient if the allocated objects
-  *	are not much smaller than PAGE_SIZE.
-  */
-
+/*
+ * struct chain_allocator is used for allocating small objects out of
+ * a linked list of pages called 'the chain'.
+ *
+ * The chain grows each time when there is no room for a new object in
+ * the current page.  The allocated objects cannot be freed individually.
+ * It is only possible to free them all at once, by freeing the entire
+ * chain.
+ *
+ * NOTE: The chain allocator may be inefficient if the allocated objects
+ * are not much smaller than PAGE_SIZE.
+ */
 struct chain_allocator {
 	struct linked_page *chain;	/* the chain */
 	unsigned int used_space;	/* total size of objects allocated out
-					 * of the current page
-					 */
+					   of the current page */
 	gfp_t gfp_mask;		/* mask for allocating pages */
 	int safe_needed;	/* if set, only "safe" pages are allocated */
 };
@@ -275,44 +280,44 @@ static void *chain_alloc(struct chain_al
 }
 
 /**
- *	Data types related to memory bitmaps.
+ * Data types related to memory bitmaps.
  *
- *	Memory bitmap is a structure consiting of many linked lists of
- *	objects.  The main list's elements are of type struct zone_bitmap
- *	and each of them corresonds to one zone.  For each zone bitmap
- *	object there is a list of objects of type struct bm_block that
- *	represent each blocks of bitmap in which information is stored.
- *
- *	struct memory_bitmap contains a pointer to the main list of zone
- *	bitmap objects, a struct bm_position used for browsing the bitmap,
- *	and a pointer to the list of pages used for allocating all of the
- *	zone bitmap objects and bitmap block objects.
- *
- *	NOTE: It has to be possible to lay out the bitmap in memory
- *	using only allocations of order 0.  Additionally, the bitmap is
- *	designed to work with arbitrary number of zones (this is over the
- *	top for now, but let's avoid making unnecessary assumptions ;-).
- *
- *	struct zone_bitmap contains a pointer to a list of bitmap block
- *	objects and a pointer to the bitmap block object that has been
- *	most recently used for setting bits.  Additionally, it contains the
- *	pfns that correspond to the start and end of the represented zone.
- *
- *	struct bm_block contains a pointer to the memory page in which
- *	information is stored (in the form of a block of bitmap)
- *	It also contains the pfns that correspond to the start and end of
- *	the represented memory area.
- *
- *	The memory bitmap is organized as a radix tree to guarantee fast random
- *	access to the bits. There is one radix tree for each zone (as returned
- *	from create_mem_extents).
- *
- *	One radix tree is represented by one struct mem_zone_bm_rtree. There are
- *	two linked lists for the nodes of the tree, one for the inner nodes and
- *	one for the leave nodes. The linked leave nodes are used for fast linear
- *	access of the memory bitmap.
+ * Memory bitmap is a structure consiting of many linked lists of
+ * objects.  The main list's elements are of type struct zone_bitmap
+ * and each of them corresonds to one zone.  For each zone bitmap
+ * object there is a list of objects of type struct bm_block that
+ * represent each blocks of bitmap in which information is stored.
+ *
+ * struct memory_bitmap contains a pointer to the main list of zone
+ * bitmap objects, a struct bm_position used for browsing the bitmap,
+ * and a pointer to the list of pages used for allocating all of the
+ * zone bitmap objects and bitmap block objects.
+ *
+ * NOTE: It has to be possible to lay out the bitmap in memory
+ * using only allocations of order 0.  Additionally, the bitmap is
+ * designed to work with arbitrary number of zones (this is over the
+ * top for now, but let's avoid making unnecessary assumptions ;-).
+ *
+ * struct zone_bitmap contains a pointer to a list of bitmap block
+ * objects and a pointer to the bitmap block object that has been
+ * most recently used for setting bits.  Additionally, it contains the
+ * PFNs that correspond to the start and end of the represented zone.
+ *
+ * struct bm_block contains a pointer to the memory page in which
+ * information is stored (in the form of a block of bitmap)
+ * It also contains the pfns that correspond to the start and end of
+ * the represented memory area.
+ *
+ * The memory bitmap is organized as a radix tree to guarantee fast random
+ * access to the bits. There is one radix tree for each zone (as returned
+ * from create_mem_extents).
+ *
+ * One radix tree is represented by one struct mem_zone_bm_rtree. There are
+ * two linked lists for the nodes of the tree, one for the inner nodes and
+ * one for the leave nodes. The linked leave nodes are used for fast linear
+ * access of the memory bitmap.
  *
- *	The struct rtree_node represents one node of the radix tree.
+ * The struct rtree_node represents one node of the radix tree.
  */
 
 #define BM_END_OF_MAP	(~0UL)
@@ -358,9 +363,8 @@ struct bm_position {
 struct memory_bitmap {
 	struct list_head zones;
 	struct linked_page *p_list;	/* list of pages used to store zone
-					 * bitmap objects and bitmap block
-					 * objects
-					 */
+					   bitmap objects and bitmap block
+					   objects */
 	struct bm_position cur;	/* most recently used bit position */
 };
 
@@ -374,12 +378,12 @@ struct memory_bitmap {
 #endif
 #define BM_RTREE_LEVEL_MASK	((1UL << BM_RTREE_LEVEL_SHIFT) - 1)
 
-/*
- *	alloc_rtree_node - Allocate a new node and add it to the radix tree.
+/**
+ * alloc_rtree_node - Allocate a new node and add it to the radix tree.
  *
- *	This function is used to allocate inner nodes as well as the
- *	leave nodes of the radix tree. It also adds the node to the
- *	corresponding linked list passed in by the *list parameter.
+ * This function is used to allocate inner nodes as well as the
+ * leave nodes of the radix tree. It also adds the node to the
+ * corresponding linked list passed in by the *list parameter.
  */
 static struct rtree_node *alloc_rtree_node(gfp_t gfp_mask, int safe_needed,
 					   struct chain_allocator *ca,
@@ -400,12 +404,12 @@ static struct rtree_node *alloc_rtree_no
 	return node;
 }
 
-/*
- *	add_rtree_block - Add a new leave node to the radix tree
+/**
+ * add_rtree_block - Add a new leave node to the radix tree.
  *
- *	The leave nodes need to be allocated in order to keep the leaves
- *	linked list in order. This is guaranteed by the zone->blocks
- *	counter.
+ * The leave nodes need to be allocated in order to keep the leaves
+ * linked list in order. This is guaranteed by the zone->blocks
+ * counter.
  */
 static int add_rtree_block(struct mem_zone_bm_rtree *zone, gfp_t gfp_mask,
 			   int safe_needed, struct chain_allocator *ca)
@@ -470,12 +474,12 @@ static int add_rtree_block(struct mem_zo
 static void free_zone_bm_rtree(struct mem_zone_bm_rtree *zone,
 			       int clear_nosave_free);
 
-/*
- *	create_zone_bm_rtree - create a radix tree for one zone
+/**
+ * create_zone_bm_rtree - Create a radix tree for one zone.
  *
- *	Allocated the mem_zone_bm_rtree structure and initializes it.
- *	This function also allocated and builds the radix tree for the
- *	zone.
+ * Allocated the mem_zone_bm_rtree structure and initializes it.
+ * This function also allocated and builds the radix tree for the
+ * zone.
  */
 static struct mem_zone_bm_rtree *create_zone_bm_rtree(gfp_t gfp_mask,
 						      int safe_needed,
@@ -508,12 +512,12 @@ static struct mem_zone_bm_rtree *create_
 	return zone;
 }
 
-/*
- *	free_zone_bm_rtree - Free the memory of the radix tree
+/**
+ * free_zone_bm_rtree - Free the memory of the radix tree.
  *
- *	Free all node pages of the radix tree. The mem_zone_bm_rtree
- *	structure itself is not freed here nor are the rtree_node
- *	structs.
+ * Free all node pages of the radix tree. The mem_zone_bm_rtree
+ * structure itself is not freed here nor are the rtree_node
+ * structs.
  */
 static void free_zone_bm_rtree(struct mem_zone_bm_rtree *zone,
 			       int clear_nosave_free)
@@ -546,8 +550,8 @@ struct mem_extent {
 };
 
 /**
- *	free_mem_extents - free a list of memory extents
- *	@list - list of extents to empty
+ * free_mem_extents - Free a list of memory extents.
+ * @list: List of extents to free.
  */
 static void free_mem_extents(struct list_head *list)
 {
@@ -560,10 +564,11 @@ static void free_mem_extents(struct list
 }
 
 /**
- *	create_mem_extents - create a list of memory extents representing
- *	                     contiguous ranges of PFNs
- *	@list - list to put the extents into
- *	@gfp_mask - mask to use for memory allocations
+ * create_mem_extents - Create a list of memory extents.
+ * @list: List to put the extents into.
+ * @gfp_mask: Mask to use for memory allocations.
+ *
+ * The extents represent contiguous ranges of PFNs.
  */
 static int create_mem_extents(struct list_head *list, gfp_t gfp_mask)
 {
@@ -619,8 +624,8 @@ static int create_mem_extents(struct lis
 }
 
 /**
-  *	memory_bm_create - allocate memory for a memory bitmap
-  */
+ * memory_bm_create - Allocate memory for a memory bitmap.
+ */
 static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
 			    int safe_needed)
 {
@@ -661,8 +666,9 @@ static int memory_bm_create(struct memor
 }
 
 /**
-  *	memory_bm_free - free memory occupied by the memory bitmap @bm
-  */
+ * memory_bm_free - Free memory occupied by the memory bitmap.
+ * @bm: Memory bitmap.
+ */
 static void memory_bm_free(struct memory_bitmap *bm, int clear_nosave_free)
 {
 	struct mem_zone_bm_rtree *zone;
@@ -676,14 +682,13 @@ static void memory_bm_free(struct memory
 }
 
 /**
- *	memory_bm_find_bit - Find the bit for pfn in the memory
- *			     bitmap
+ * memory_bm_find_bit - Find the bit for a given PFN in a memory bitmap.
  *
- *	Find the bit in the bitmap @bm that corresponds to given pfn.
- *	The cur.zone, cur.block and cur.node_pfn member of @bm are
- *	updated.
- *	It walks the radix tree to find the page which contains the bit for
- *	pfn and returns the bit position in **addr and *bit_nr.
+ * Find the bit in memory bitmap @bm that corresponds to the given PFN.
+ * The cur.zone, cur.block and cur.node_pfn members of @bm are updated.
+ *
+ * Walk the radix tree to find the page containing the bit that represents @pfn
+ * and return the position of the bit in @addr and @bit_nr.
  */
 static int memory_bm_find_bit(struct memory_bitmap *bm, unsigned long pfn,
 			      void **addr, unsigned int *bit_nr)
@@ -712,10 +717,9 @@ static int memory_bm_find_bit(struct mem
 
 zone_found:
 	/*
-	 * We have a zone. Now walk the radix tree to find the leave
-	 * node for our pfn.
+	 * We have found the zone. Now walk the radix tree to find the leaf node
+	 * for our PFN.
 	 */
-
 	node = bm->cur.node;
 	if (((pfn - zone->start_pfn) & ~BM_BLOCK_MASK) == bm->cur.node_pfn)
 		goto node_found;
@@ -808,14 +812,14 @@ static bool memory_bm_pfn_present(struct
 }
 
 /*
- *	rtree_next_node - Jumps to the next leave node
+ * rtree_next_node - Jump to the next leaf node.
  *
- *	Sets the position to the beginning of the next node in the
- *	memory bitmap. This is either the next node in the current
- *	zone's radix tree or the first node in the radix tree of the
- *	next zone.
+ * Set the position to the beginning of the next node in the
+ * memory bitmap. This is either the next node in the current
+ * zone's radix tree or the first node in the radix tree of the
+ * next zone.
  *
- *	Returns true if there is a next node, false otherwise.
+ * Return true if there is a next node, false otherwise.
  */
 static bool rtree_next_node(struct memory_bitmap *bm)
 {
@@ -844,14 +848,15 @@ static bool rtree_next_node(struct memor
 }
 
 /**
- *	memory_bm_rtree_next_pfn - Find the next set bit in the bitmap @bm
+ * memory_bm_rtree_next_pfn - Find the next set bit in a memory bitmap.
+ * @bm: Memory bitmap.
  *
- *	Starting from the last returned position this function searches
- *	for the next set bit in the memory bitmap and returns its
- *	number. If no more bit is set BM_END_OF_MAP is returned.
+ * Starting from the last returned position this function searches for the next
+ * set bit in @bm and returns the PFN represented by it.  If no more bits are
+ * set, BM_END_OF_MAP is returned.
  *
- *	It is required to run memory_bm_position_reset() before the
- *	first call to this function.
+ * It is required to run memory_bm_position_reset() before the first call to
+ * this function for the given memory bitmap.
  */
 static unsigned long memory_bm_next_pfn(struct memory_bitmap *bm)
 {
@@ -873,11 +878,10 @@ static unsigned long memory_bm_next_pfn(
 	return BM_END_OF_MAP;
 }
 
-/**
- *	This structure represents a range of page frames the contents of which
- *	should not be saved during the suspend.
+/*
+ * This structure represents a range of page frames the contents of which
+ * should not be saved during hibernation.
  */
-
 struct nosave_region {
 	struct list_head list;
 	unsigned long start_pfn;
@@ -915,11 +919,11 @@ static void memory_bm_recycle(struct mem
 }
 
 /**
- *	register_nosave_region - register a range of page frames the contents
- *	of which should not be saved during the suspend (to be used in the early
- *	initialization code)
+ * register_nosave_region - Register a region of unsaveable memory.
+ *
+ * Register a range of page frames the contents of which should not be saved
+ * during hibernation (to be used in the early initialization code).
  */
-
 void __init __register_nosave_region(unsigned long start_pfn,
 				     unsigned long end_pfn, int use_kmalloc)
 {
@@ -938,7 +942,7 @@ void __init __register_nosave_region(uns
 		}
 	}
 	if (use_kmalloc) {
-		/* during init, this shouldn't fail */
+		/* During init, this shouldn't fail */
 		region = kmalloc(sizeof(struct nosave_region), GFP_KERNEL);
 		BUG_ON(!region);
 	} else
@@ -1004,10 +1008,12 @@ static void swsusp_unset_page_forbidden(
 }
 
 /**
- *	mark_nosave_pages - set bits corresponding to the page frames the
- *	contents of which should not be saved in a given bitmap.
+ * mark_nosave_pages - Mark pages that should not be saved.
+ * @bm: Memory bitmap.
+ *
+ * Set the bits in @bm that correspond to the page frames the contents of which
+ * should not be saved.
  */
-
 static void mark_nosave_pages(struct memory_bitmap *bm)
 {
 	struct nosave_region *region;
@@ -1037,13 +1043,13 @@ static void mark_nosave_pages(struct mem
 }
 
 /**
- *	create_basic_memory_bitmaps - create bitmaps needed for marking page
- *	frames that should not be saved and free page frames.  The pointers
- *	forbidden_pages_map and free_pages_map are only modified if everything
- *	goes well, because we don't want the bits to be used before both bitmaps
- *	are set up.
+ * create_basic_memory_bitmaps - Create bitmaps to hold basic page information.
+ *
+ * Create bitmaps needed for marking page frames that should not be saved and
+ * free page frames.  The forbidden_pages_map and free_pages_map pointers are
+ * only modified if everything goes well, because we don't want the bits to be
+ * touched before both bitmaps are set up.
  */
-
 int create_basic_memory_bitmaps(void)
 {
 	struct memory_bitmap *bm1, *bm2;
@@ -1088,12 +1094,12 @@ int create_basic_memory_bitmaps(void)
 }
 
 /**
- *	free_basic_memory_bitmaps - free memory bitmaps allocated by
- *	create_basic_memory_bitmaps().  The auxiliary pointers are necessary
- *	so that the bitmaps themselves are not referred to while they are being
- *	freed.
+ * free_basic_memory_bitmaps - Free memory bitmaps holding basic information.
+ *
+ * Free memory bitmaps allocated by create_basic_memory_bitmaps().  The
+ * auxiliary pointers are necessary so that the bitmaps themselves are not
+ * referred to while they are being freed.
  */
-
 void free_basic_memory_bitmaps(void)
 {
 	struct memory_bitmap *bm1, *bm2;
@@ -1114,11 +1120,13 @@ void free_basic_memory_bitmaps(void)
 }
 
 /**
- *	snapshot_additional_pages - estimate the number of additional pages
- *	be needed for setting up the suspend image data structures for given
- *	zone (usually the returned value is greater than the exact number)
+ * snapshot_additional_pages - Estimate the number of extra pages needed.
+ * @zone: Memory zone to carry out the computation for.
+ *
+ * Estimate the number of additional pages needed for setting up a hibernation
+ * image data structures for @zone (usually, the returned value is greater than
+ * the exact number).
  */
-
 unsigned int snapshot_additional_pages(struct zone *zone)
 {
 	unsigned int rtree, nodes;
@@ -1136,10 +1144,10 @@ unsigned int snapshot_additional_pages(s
 
 #ifdef CONFIG_HIGHMEM
 /**
- *	count_free_highmem_pages - compute the total number of free highmem
- *	pages, system-wide.
+ * count_free_highmem_pages - Compute the total number of free highmem pages.
+ *
+ * The returned number is system-wide.
  */
-
 static unsigned int count_free_highmem_pages(void)
 {
 	struct zone *zone;
@@ -1153,11 +1161,12 @@ static unsigned int count_free_highmem_p
 }
 
 /**
- *	saveable_highmem_page - Determine whether a highmem page should be
- *	included in the suspend image.
+ * saveable_highmem_page - Check if a highmem page is saveable.
  *
- *	We should save the page if it isn't Nosave or NosaveFree, or Reserved,
- *	and it isn't a part of a free chunk of pages.
+ * Determine whether a highmem page should be included in a hibernation image.
+ *
+ * We should save the page if it isn't Nosave or NosaveFree, or Reserved,
+ * and it isn't part of a free chunk of pages.
  */
 static struct page *saveable_highmem_page(struct zone *zone, unsigned long pfn)
 {
@@ -1183,10 +1192,8 @@ static struct page *saveable_highmem_pag
 }
 
 /**
- *	count_highmem_pages - compute the total number of saveable highmem
- *	pages.
+ * count_highmem_pages - Compute the total number of saveable highmem pages.
  */
-
 static unsigned int count_highmem_pages(void)
 {
 	struct zone *zone;
@@ -1214,12 +1221,14 @@ static inline void *saveable_highmem_pag
 #endif /* CONFIG_HIGHMEM */
 
 /**
- *	saveable_page - Determine whether a non-highmem page should be included
- *	in the suspend image.
+ * saveable_page - Check if the given page is saveable.
+ *
+ * Determine whether a non-highmem page should be included in a hibernation
+ * image.
  *
- *	We should save the page if it isn't Nosave, and is not in the range
- *	of pages statically defined as 'unsaveable', and it isn't a part of
- *	a free chunk of pages.
+ * We should save the page if it isn't Nosave, and is not in the range
+ * of pages statically defined as 'unsaveable', and it isn't part of
+ * a free chunk of pages.
  */
 static struct page *saveable_page(struct zone *zone, unsigned long pfn)
 {
@@ -1248,10 +1257,8 @@ static struct page *saveable_page(struct
 }
 
 /**
- *	count_data_pages - compute the total number of saveable non-highmem
- *	pages.
+ * count_data_pages - Compute the total number of saveable non-highmem pages.
  */
-
 static unsigned int count_data_pages(void)
 {
 	struct zone *zone;
@@ -1271,7 +1278,8 @@ static unsigned int count_data_pages(voi
 	return n;
 }
 
-/* This is needed, because copy_page and memcpy are not usable for copying
+/*
+ * This is needed, because copy_page and memcpy are not usable for copying
  * task structs.
  */
 static inline void do_copy_page(long *dst, long *src)
@@ -1282,12 +1290,12 @@ static inline void do_copy_page(long *ds
 		*dst++ = *src++;
 }
 
-
 /**
- *	safe_copy_page - check if the page we are going to copy is marked as
- *		present in the kernel page tables (this always is the case if
- *		CONFIG_DEBUG_PAGEALLOC is not set and in that case
- *		kernel_page_present() always returns 'true').
+ * safe_copy_page - Copy a page in a safe way.
+ *
+ * Check if the page we are going to copy is marked as present in the kernel
+ * page tables (this always is the case if CONFIG_DEBUG_PAGEALLOC is not set
+ * and in that case kernel_page_present() always returns 'true').
  */
 static void safe_copy_page(void *dst, struct page *s_page)
 {
@@ -1300,7 +1308,6 @@ static void safe_copy_page(void *dst, st
 	}
 }
 
-
 #ifdef CONFIG_HIGHMEM
 static inline struct page *page_is_saveable(struct zone *zone, unsigned long pfn)
 {
@@ -1323,7 +1330,8 @@ static void copy_data_page(unsigned long
 		kunmap_atomic(src);
 	} else {
 		if (PageHighMem(d_page)) {
-			/* Page pointed to by src may contain some kernel
+			/*
+			 * The page pointed to by src may contain some kernel
 			 * data modified by kmap_atomic()
 			 */
 			safe_copy_page(buffer, s_page);
@@ -1395,12 +1403,11 @@ static struct memory_bitmap orig_bm;
 static struct memory_bitmap copy_bm;
 
 /**
- *	swsusp_free - free pages allocated for the suspend.
+ * swsusp_free - Free pages allocated for hibernation image.
  *
- *	Suspend pages are alocated before the atomic copy is made, so we
- *	need to release them after the resume.
+ * Image pages are alocated before snapshot creation, so they need to be
+ * released after resume.
  */
-
 void swsusp_free(void)
 {
 	unsigned long fb_pfn, fr_pfn;
@@ -1451,7 +1458,7 @@ out:
 #define GFP_IMAGE	(GFP_KERNEL | __GFP_NOWARN)
 
 /**
- * preallocate_image_pages - Allocate a number of pages for hibernation image
+ * preallocate_image_pages - Allocate a number of pages for hibernation image.
  * @nr_pages: Number of page frames to allocate.
  * @mask: GFP flags to use for the allocation.
  *
@@ -1501,7 +1508,7 @@ static unsigned long preallocate_image_h
 }
 
 /**
- *  __fraction - Compute (an approximation of) x * (multiplier / base)
+ *  __fraction - Compute (an approximation of) x * (multiplier / base).
  */
 static unsigned long __fraction(u64 x, u64 multiplier, u64 base)
 {
@@ -1533,7 +1540,7 @@ static inline unsigned long preallocate_
 #endif /* CONFIG_HIGHMEM */
 
 /**
- * free_unnecessary_pages - Release preallocated pages not needed for the image
+ * free_unnecessary_pages - Release preallocated pages not needed for the image.
  */
 static unsigned long free_unnecessary_pages(void)
 {
@@ -1587,7 +1594,7 @@ static unsigned long free_unnecessary_pa
 }
 
 /**
- * minimum_image_size - Estimate the minimum acceptable size of an image
+ * minimum_image_size - Estimate the minimum acceptable size of an image.
  * @saveable: Number of saveable pages in the system.
  *
  * We want to avoid attempting to free too much memory too hard, so estimate the
@@ -1617,7 +1624,7 @@ static unsigned long minimum_image_size(
 }
 
 /**
- * hibernate_preallocate_memory - Preallocate memory for hibernation image
+ * hibernate_preallocate_memory - Preallocate memory for hibernation image.
  *
  * To create a hibernation image it is necessary to make a copy of every page
  * frame in use.  We also need a number of page frames to be free during
@@ -1790,10 +1797,11 @@ int hibernate_preallocate_memory(void)
 
 #ifdef CONFIG_HIGHMEM
 /**
-  *	count_pages_for_highmem - compute the number of non-highmem pages
-  *	that will be necessary for creating copies of highmem pages.
-  */
-
+ * count_pages_for_highmem - Count non-highmem pages needed for copying highmem.
+ *
+ * Compute the number of non-highmem pages that will be necessary for creating
+ * copies of highmem pages.
+ */
 static unsigned int count_pages_for_highmem(unsigned int nr_highmem)
 {
 	unsigned int free_highmem = count_free_highmem_pages() + alloc_highmem;
@@ -1810,10 +1818,8 @@ static unsigned int count_pages_for_high
 #endif /* CONFIG_HIGHMEM */
 
 /**
- *	enough_free_mem - Make sure we have enough free memory for the
- *	snapshot image.
+ * enough_free_mem - Check if there is enough free memory for the image.
  */
-
 static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
 {
 	struct zone *zone;
@@ -1832,10 +1838,11 @@ static int enough_free_mem(unsigned int
 
 #ifdef CONFIG_HIGHMEM
 /**
- *	get_highmem_buffer - if there are some highmem pages in the suspend
- *	image, we may need the buffer to copy them and/or load their data.
+ * get_highmem_buffer - Allocate a buffer for highmem pages.
+ *
+ * If there are some highmem pages in the hibernation image, we may need a
+ * buffer to copy them and/or load their data.
  */
-
 static inline int get_highmem_buffer(int safe_needed)
 {
 	buffer = get_image_page(GFP_ATOMIC | __GFP_COLD, safe_needed);
@@ -1843,11 +1850,11 @@ static inline int get_highmem_buffer(int
 }
 
 /**
- *	alloc_highmem_image_pages - allocate some highmem pages for the image.
- *	Try to allocate as many pages as needed, but if the number of free
- *	highmem pages is lesser than that, allocate them all.
+ * alloc_highmem_image_pages - Allocate some highmem pages for the image.
+ *
+ * Try to allocate as many pages as needed, but if the number of free highmem
+ * pages is less than that, allocate them all.
  */
-
 static inline unsigned int alloc_highmem_pages(struct memory_bitmap *bm,
 					       unsigned int nr_highmem)
 {
@@ -1873,17 +1880,16 @@ static inline unsigned int alloc_highmem
 #endif /* CONFIG_HIGHMEM */
 
 /**
- *	swsusp_alloc - allocate memory for the suspend image
+ * swsusp_alloc - Allocate memory for hibernation image.
  *
- *	We first try to allocate as many highmem pages as there are
- *	saveable highmem pages in the system.  If that fails, we allocate
- *	non-highmem pages for the copies of the remaining highmem ones.
- *
- *	In this approach it is likely that the copies of highmem pages will
- *	also be located in the high memory, because of the way in which
- *	copy_data_pages() works.
+ * We first try to allocate as many highmem pages as there are
+ * saveable highmem pages in the system.  If that fails, we allocate
+ * non-highmem pages for the copies of the remaining highmem ones.
+ *
+ * In this approach it is likely that the copies of highmem pages will
+ * also be located in the high memory, because of the way in which
+ * copy_data_pages() works.
  */
-
 static int swsusp_alloc(struct memory_bitmap *orig_bm,
 			struct memory_bitmap *copy_bm,
 			unsigned int nr_pages, unsigned int nr_highmem)
@@ -1936,7 +1942,8 @@ asmlinkage __visible int swsusp_save(voi
 		return -ENOMEM;
 	}
 
-	/* During allocating of suspend pagedir, new cold pages may appear.
+	/*
+	 * During allocating of suspend pagedir, new cold pages may appear.
 	 * Kill them.
 	 */
 	drain_local_pages(NULL);
@@ -1999,10 +2006,13 @@ static int init_header(struct swsusp_inf
 }
 
 /**
- *	pack_pfns - pfns corresponding to the set bits found in the bitmap @bm
- *	are stored in the array @buf[] (1 page at a time)
+ * pack_pfns - Prepare PFNs for saving.
+ * @bm: Memory bitmap.
+ * @buf: Memory buffer to store the PFNs in.
+ *
+ * PFNs corresponding to set bits in @bm are stored in the area of memory
+ * pointed to by @buf (1 page at a time).
  */
-
 static inline void pack_pfns(unsigned long *buf, struct memory_bitmap *bm)
 {
 	int j;
@@ -2017,22 +2027,21 @@ static inline void pack_pfns(unsigned lo
 }
 
 /**
- *	snapshot_read_next - used for reading the system memory snapshot.
+ * snapshot_read_next - Get the address to read the next image page from.
+ * @handle: Snapshot handle to be used for the reading.
  *
- *	On the first call to it @handle should point to a zeroed
- *	snapshot_handle structure.  The structure gets updated and a pointer
- *	to it should be passed to this function every next time.
- *
- *	On success the function returns a positive number.  Then, the caller
- *	is allowed to read up to the returned number of bytes from the memory
- *	location computed by the data_of() macro.
- *
- *	The function returns 0 to indicate the end of data stream condition,
- *	and a negative number is returned on error.  In such cases the
- *	structure pointed to by @handle is not updated and should not be used
- *	any more.
+ * On the first call, @handle should point to a zeroed snapshot_handle
+ * structure.  The structure gets populated then and a pointer to it should be
+ * passed to this function every next time.
+ *
+ * On success, the function returns a positive number.  Then, the caller
+ * is allowed to read up to the returned number of bytes from the memory
+ * location computed by the data_of() macro.
+ *
+ * The function returns 0 to indicate the end of the data stream condition,
+ * and negative numbers are returned on errors.  If that happens, the structure
+ * pointed to by @handle is not updated and should not be used any more.
  */
-
 int snapshot_read_next(struct snapshot_handle *handle)
 {
 	if (handle->cur > nr_meta_pages + nr_copy_pages)
@@ -2061,7 +2070,8 @@ int snapshot_read_next(struct snapshot_h
 
 		page = pfn_to_page(memory_bm_next_pfn(&copy_bm));
 		if (PageHighMem(page)) {
-			/* Highmem pages are copied to the buffer,
+			/*
+			 * Highmem pages are copied to the buffer,
 			 * because we can't return with a kmapped
 			 * highmem page (we may not be called again).
 			 */
@@ -2093,11 +2103,11 @@ static void duplicate_memory_bitmap(stru
 }
 
 /**
- *	mark_unsafe_pages - mark the pages that cannot be used for storing
- *	the image during resume, because they conflict with the pages that
- *	had been used before suspend
+ * mark_unsafe_pages - Mark pages that were used before hibernation.
+ *
+ * Mark the pages that cannot be used for storing the image during restoration,
+ * because they conflict with the pages that had been used before hibernation.
  */
-
 static void mark_unsafe_pages(struct memory_bitmap *bm)
 {
 	unsigned long pfn;
@@ -2131,9 +2141,8 @@ static int check_header(struct swsusp_in
 }
 
 /**
- *	load header - check the image header and copy data from it
+ * load header - Check the image header and copy the data from it.
  */
-
 static int load_header(struct swsusp_info *info)
 {
 	int error;
@@ -2148,8 +2157,12 @@ static int load_header(struct swsusp_inf
 }
 
 /**
- *	unpack_orig_pfns - for each element of @buf[] (1 page at a time) set
- *	the corresponding bit in the memory bitmap @bm
+ * unpack_orig_pfns - Set bits corresponding to given PFNs in a memory bitmap.
+ * @bm: Memory bitmap.
+ * @buf: Area of memory containing the PFNs.
+ *
+ * For each element of the array pointed to by @buf (1 page at a time), set the
+ * corresponding bit in @bm.
  */
 static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
 {
@@ -2172,7 +2185,8 @@ static int unpack_orig_pfns(unsigned lon
 }
 
 #ifdef CONFIG_HIGHMEM
-/* struct highmem_pbe is used for creating the list of highmem pages that
+/*
+ * struct highmem_pbe is used for creating the list of highmem pages that
  * should be restored atomically during the resume from disk, because the page
  * frames they have occupied before the suspend are in use.
  */
@@ -2182,7 +2196,8 @@ struct highmem_pbe {
 	struct highmem_pbe *next;
 };
 
-/* List of highmem PBEs needed for restoring the highmem pages that were
+/*
+ * List of highmem PBEs needed for restoring the highmem pages that were
  * allocated before the suspend and included in the suspend image, but have
  * also been allocated by the "resume" kernel, so their contents cannot be
  * written directly to their "original" page frames.
@@ -2190,11 +2205,11 @@ struct highmem_pbe {
 static struct highmem_pbe *highmem_pblist;
 
 /**
- *	count_highmem_image_pages - compute the number of highmem pages in the
- *	suspend image.  The bits in the memory bitmap @bm that correspond to the
- *	image pages are assumed to be set.
+ * count_highmem_image_pages - Compute the number of highmem pages in the image.
+ * @bm: Memory bitmap.
+ *
+ * The bits in @bm that correspond to image pages are assumed to be set.
  */
-
 static unsigned int count_highmem_image_pages(struct memory_bitmap *bm)
 {
 	unsigned long pfn;
@@ -2211,22 +2226,23 @@ static unsigned int count_highmem_image_
 	return cnt;
 }
 
-/**
- *	prepare_highmem_image - try to allocate as many highmem pages as
- *	there are highmem image pages (@nr_highmem_p points to the variable
- *	containing the number of highmem image pages).  The pages that are
- *	"safe" (ie. will not be overwritten when the suspend image is
- *	restored) have the corresponding bits set in @bm (it must be
- *	unitialized).
- *
- *	NOTE: This function should not be called if there are no highmem
- *	image pages.
- */
-
 static unsigned int safe_highmem_pages;
 
 static struct memory_bitmap *safe_highmem_bm;
 
+/**
+ * prepare_highmem_image - Allocate memory for loading highmem data from image.
+ * @bm: Pointer to an uninitialized memory bitmap structure.
+ * @nr_highmem_p: Pointer to the number of highmem image pages.
+ *
+ * Try to allocate as many highmem pages as there are highmem image pages
+ * (@nr_highmem_p points to the variable containing the number of highmem image
+ * pages).  The pages that are "safe" (ie. will not be overwritten when the
+ * hibernation image is restored entirely) have the corresponding bits set in
+ * @bm (it must be unitialized).
+ *
+ * NOTE: This function should not be called if there are no highmem image pages.
+ */
 static int prepare_highmem_image(struct memory_bitmap *bm,
 				 unsigned int *nr_highmem_p)
 {
@@ -2263,25 +2279,26 @@ static int prepare_highmem_image(struct
 	return 0;
 }
 
+static struct page *last_highmem_page;
+
 /**
- *	get_highmem_page_buffer - for given highmem image page find the buffer
- *	that suspend_write_next() should set for its caller to write to.
+ * get_highmem_page_buffer - Prepare a buffer to store a highmem image page.
+ *
+ * For a given highmem image page get a buffer that suspend_write_next() should
+ * return to its caller to write to.
  *
- *	If the page is to be saved to its "original" page frame or a copy of
- *	the page is to be made in the highmem, @buffer is returned.  Otherwise,
- *	the copy of the page is to be made in normal memory, so the address of
- *	the copy is returned.
- *
- *	If @buffer is returned, the caller of suspend_write_next() will write
- *	the page's contents to @buffer, so they will have to be copied to the
- *	right location on the next call to suspend_write_next() and it is done
- *	with the help of copy_last_highmem_page().  For this purpose, if
- *	@buffer is returned, @last_highmem page is set to the page to which
- *	the data will have to be copied from @buffer.
+ * If the page is to be saved to its "original" page frame or a copy of
+ * the page is to be made in the highmem, @buffer is returned.  Otherwise,
+ * the copy of the page is to be made in normal memory, so the address of
+ * the copy is returned.
+ *
+ * If @buffer is returned, the caller of suspend_write_next() will write
+ * the page's contents to @buffer, so they will have to be copied to the
+ * right location on the next call to suspend_write_next() and it is done
+ * with the help of copy_last_highmem_page().  For this purpose, if
+ * @buffer is returned, @last_highmem_page is set to the page to which
+ * the data will have to be copied from @buffer.
  */
-
-static struct page *last_highmem_page;
-
 static void *get_highmem_page_buffer(struct page *page,
 				     struct chain_allocator *ca)
 {
@@ -2289,13 +2306,15 @@ static void *get_highmem_page_buffer(str
 	void *kaddr;
 
 	if (swsusp_page_is_forbidden(page) && swsusp_page_is_free(page)) {
-		/* We have allocated the "original" page frame and we can
+		/*
+		 * We have allocated the "original" page frame and we can
 		 * use it directly to store the loaded page.
 		 */
 		last_highmem_page = page;
 		return buffer;
 	}
-	/* The "original" page frame has not been allocated and we have to
+	/*
+	 * The "original" page frame has not been allocated and we have to
 	 * use a "safe" page frame to store the loaded page.
 	 */
 	pbe = chain_alloc(ca, sizeof(struct highmem_pbe));
@@ -2325,11 +2344,12 @@ static void *get_highmem_page_buffer(str
 }
 
 /**
- *	copy_last_highmem_page - copy the contents of a highmem image from
- *	@buffer, where the caller of snapshot_write_next() has place them,
- *	to the right location represented by @last_highmem_page .
+ * copy_last_highmem_page - Copy most the most recent highmem image page.
+ *
+ * Copy the contents of a highmem image from @buffer, where the caller of
+ * snapshot_write_next() has stored them, to the right location represented by
+ * @last_highmem_page .
  */
-
 static void copy_last_highmem_page(void)
 {
 	if (last_highmem_page) {
@@ -2372,22 +2392,23 @@ static inline int last_highmem_page_copi
 static inline void free_highmem_data(void) {}
 #endif /* CONFIG_HIGHMEM */
 
-/**
- *	prepare_image - use the memory bitmap @bm to mark the pages that will
- *	be overwritten in the process of restoring the system memory state
- *	from the suspend image ("unsafe" pages) and allocate memory for the
- *	image.
- *
- *	The idea is to allocate a new memory bitmap first and then allocate
- *	as many pages as needed for the image data, but not to assign these
- *	pages to specific tasks initially.  Instead, we just mark them as
- *	allocated and create a lists of "safe" pages that will be used
- *	later.  On systems with high memory a list of "safe" highmem pages is
- *	also created.
- */
-
 #define PBES_PER_LINKED_PAGE	(LINKED_PAGE_DATA_SIZE / sizeof(struct pbe))
 
+/**
+ * prepare_image - Make room for loading hibernation image.
+ * @new_bm: Unitialized memory bitmap structure.
+ * @bm: Memory bitmap with unsafe pages marked.
+ *
+ * Use @bm to mark the pages that will be overwritten in the process of
+ * restoring the system memory state from the suspend image ("unsafe" pages)
+ * and allocate memory for the image.
+ *
+ * The idea is to allocate a new memory bitmap first and then allocate
+ * as many pages as needed for image data, but without specifying what those
+ * pages will be used for just yet.  Instead, we mark them all as allocated and
+ * create a lists of "safe" pages to be used later.  On systems with high
+ * memory a list of "safe" highmem pages is created too.
+ */
 static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
 {
 	unsigned int nr_pages, nr_highmem;
@@ -2412,7 +2433,8 @@ static int prepare_image(struct memory_b
 		if (error)
 			goto Free;
 	}
-	/* Reserve some safe pages for potential later use.
+	/*
+	 * Reserve some safe pages for potential later use.
 	 *
 	 * NOTE: This way we make sure there will be enough safe pages for the
 	 * chain_alloc() in get_buffer().  It is a bit wasteful, but
@@ -2458,10 +2480,11 @@ static int prepare_image(struct memory_b
 }
 
 /**
- *	get_buffer - compute the address that snapshot_write_next() should
- *	set for its caller to write to.
+ * get_buffer - Get the address to store the next image data page.
+ *
+ * Get the address that snapshot_write_next() should return to its caller to
+ * write to.
  */
-
 static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
 {
 	struct pbe *pbe;
@@ -2476,12 +2499,14 @@ static void *get_buffer(struct memory_bi
 		return get_highmem_page_buffer(page, ca);
 
 	if (swsusp_page_is_forbidden(page) && swsusp_page_is_free(page))
-		/* We have allocated the "original" page frame and we can
+		/*
+		 * We have allocated the "original" page frame and we can
 		 * use it directly to store the loaded page.
 		 */
 		return page_address(page);
 
-	/* The "original" page frame has not been allocated and we have to
+	/*
+	 * The "original" page frame has not been allocated and we have to
 	 * use a "safe" page frame to store the loaded page.
 	 */
 	pbe = chain_alloc(ca, sizeof(struct pbe));
@@ -2498,22 +2523,21 @@ static void *get_buffer(struct memory_bi
 }
 
 /**
- *	snapshot_write_next - used for writing the system memory snapshot.
+ * snapshot_write_next - Get the address to store the next image page.
+ * @handle: Snapshot handle structure to guide the writing.
  *
- *	On the first call to it @handle should point to a zeroed
- *	snapshot_handle structure.  The structure gets updated and a pointer
- *	to it should be passed to this function every next time.
- *
- *	On success the function returns a positive number.  Then, the caller
- *	is allowed to write up to the returned number of bytes to the memory
- *	location computed by the data_of() macro.
- *
- *	The function returns 0 to indicate the "end of file" condition,
- *	and a negative number is returned on error.  In such cases the
- *	structure pointed to by @handle is not updated and should not be used
- *	any more.
+ * On the first call, @handle should point to a zeroed snapshot_handle
+ * structure.  The structure gets populated then and a pointer to it should be
+ * passed to this function every next time.
+ *
+ * On success, the function returns a positive number.  Then, the caller
+ * is allowed to write up to the returned number of bytes to the memory
+ * location computed by the data_of() macro.
+ *
+ * The function returns 0 to indicate the "end of file" condition.  Negative
+ * numbers are returned on errors, in which cases the structure pointed to by
+ * @handle is not updated and should not be used any more.
  */
-
 int snapshot_write_next(struct snapshot_handle *handle)
 {
 	static struct chain_allocator ca;
@@ -2585,13 +2609,13 @@ int snapshot_write_next(struct snapshot_
 }
 
 /**
- *	snapshot_write_finalize - must be called after the last call to
- *	snapshot_write_next() in case the last page in the image happens
- *	to be a highmem page and its contents should be stored in the
- *	highmem.  Additionally, it releases the memory that will not be
- *	used any more.
+ * snapshot_write_finalize - Complete the loading of a hibernation image.
+ *
+ * Must be called after the last call to snapshot_write_next() in case the last
+ * page in the image happens to be a highmem page and its contents should be
+ * stored in highmem.  Additionally, it recycles bitmap memory that's not
+ * necessary any more.
  */
-
 void snapshot_write_finalize(struct snapshot_handle *handle)
 {
 	copy_last_highmem_page();
@@ -2629,15 +2653,15 @@ static inline void swap_two_pages_data(s
 }
 
 /**
- *	restore_highmem - for each highmem page that was allocated before
- *	the suspend and included in the suspend image, and also has been
- *	allocated by the "resume" kernel swap its current (ie. "before
- *	resume") contents with the previous (ie. "before suspend") one.
+ * restore_highmem - Put highmem image pages into their original locations.
+ *
+ * For each highmem page that was in use before hibernation and is included in
+ * the image, and also has been allocated by the "restore" kernel, swap its
+ * current contents with the previous (ie. "before hibernation") ones.
  *
- *	If the resume eventually fails, we can call this function once
- *	again and restore the "before resume" highmem state.
+ * If the restore eventually fails, we can call this function once again and
+ * restore the highmem state as seen by the restore kernel.
  */
-
 int restore_highmem(void)
 {
 	struct highmem_pbe *pbe = highmem_pblist;

