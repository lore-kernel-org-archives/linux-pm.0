From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] PM / hibernate: Clean up function headers in snapshot.c
Date: Wed, 06 Jul 2016 23:42:46 +0200
Message-ID: <2118309.TgT5po3rxn@vostro.rjw.lan>
References: <20396026.uktHd5ozkC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20396026.uktHd5ozkC@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The formatting of some function headers in kernel/power/snapshot.c
is not consistent with the general kernel coding style and with the
formatting of some other function headers in the same file.

Make all of them follow the same formatting convention.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/snapshot.c |   93 +++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 51 deletions(-)

Index: linux-pm/kernel/power/snapshot.c
===================================================================
--- linux-pm.orig/kernel/power/snapshot.c
+++ linux-pm/kernel/power/snapshot.c
@@ -211,8 +211,8 @@ static inline void free_image_page(void
 	__free_page(page);
 }
 
-static inline void
-free_list_of_pages(struct linked_page *list, int clear_page_nosave)
+static inline void free_list_of_pages(struct linked_page *list,
+				      int clear_page_nosave)
 {
 	while (list) {
 		struct linked_page *lp = list->next;
@@ -244,8 +244,8 @@ struct chain_allocator {
 	int safe_needed;	/* if set, only "safe" pages are allocated */
 };
 
-static void
-chain_init(struct chain_allocator *ca, gfp_t gfp_mask, int safe_needed)
+static void chain_init(struct chain_allocator *ca, gfp_t gfp_mask,
+		       int safe_needed)
 {
 	ca->chain = NULL;
 	ca->used_space = LINKED_PAGE_DATA_SIZE;
@@ -477,10 +477,11 @@ static void free_zone_bm_rtree(struct me
  *	This function also allocated and builds the radix tree for the
  *	zone.
  */
-static struct mem_zone_bm_rtree *
-create_zone_bm_rtree(gfp_t gfp_mask, int safe_needed,
-		     struct chain_allocator *ca,
-		     unsigned long start, unsigned long end)
+static struct mem_zone_bm_rtree *create_zone_bm_rtree(gfp_t gfp_mask,
+						      int safe_needed,
+						      struct chain_allocator *ca,
+						      unsigned long start,
+						      unsigned long end)
 {
 	struct mem_zone_bm_rtree *zone;
 	unsigned int i, nr_blocks;
@@ -620,8 +621,8 @@ static int create_mem_extents(struct lis
 /**
   *	memory_bm_create - allocate memory for a memory bitmap
   */
-static int
-memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask, int safe_needed)
+static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
+			    int safe_needed)
 {
 	struct chain_allocator ca;
 	struct list_head mem_extents;
@@ -919,9 +920,8 @@ static void memory_bm_recycle(struct mem
  *	initialization code)
  */
 
-void __init
-__register_nosave_region(unsigned long start_pfn, unsigned long end_pfn,
-			 int use_kmalloc)
+void __init __register_nosave_region(unsigned long start_pfn,
+				     unsigned long end_pfn, int use_kmalloc)
 {
 	struct nosave_region *region;
 
@@ -1302,8 +1302,7 @@ static void safe_copy_page(void *dst, st
 
 
 #ifdef CONFIG_HIGHMEM
-static inline struct page *
-page_is_saveable(struct zone *zone, unsigned long pfn)
+static inline struct page *page_is_saveable(struct zone *zone, unsigned long pfn)
 {
 	return is_highmem(zone) ?
 		saveable_highmem_page(zone, pfn) : saveable_page(zone, pfn);
@@ -1346,8 +1345,8 @@ static inline void copy_data_page(unsign
 }
 #endif /* CONFIG_HIGHMEM */
 
-static void
-copy_data_pages(struct memory_bitmap *copy_bm, struct memory_bitmap *orig_bm)
+static void copy_data_pages(struct memory_bitmap *copy_bm,
+			    struct memory_bitmap *orig_bm)
 {
 	struct zone *zone;
 	unsigned long pfn;
@@ -1512,8 +1511,8 @@ static unsigned long __fraction(u64 x, u
 }
 
 static unsigned long preallocate_highmem_fraction(unsigned long nr_pages,
-						unsigned long highmem,
-						unsigned long total)
+						  unsigned long highmem,
+						  unsigned long total)
 {
 	unsigned long alloc = __fraction(nr_pages, highmem, total);
 
@@ -1526,8 +1525,8 @@ static inline unsigned long preallocate_
 }
 
 static inline unsigned long preallocate_highmem_fraction(unsigned long nr_pages,
-						unsigned long highmem,
-						unsigned long total)
+							 unsigned long highmem,
+							 unsigned long total)
 {
 	return 0;
 }
@@ -1807,8 +1806,7 @@ static unsigned int count_pages_for_high
 	return nr_highmem;
 }
 #else
-static unsigned int
-count_pages_for_highmem(unsigned int nr_highmem) { return 0; }
+static unsigned int count_pages_for_highmem(unsigned int nr_highmem) { return 0; }
 #endif /* CONFIG_HIGHMEM */
 
 /**
@@ -1850,8 +1848,8 @@ static inline int get_highmem_buffer(int
  *	highmem pages is lesser than that, allocate them all.
  */
 
-static inline unsigned int
-alloc_highmem_pages(struct memory_bitmap *bm, unsigned int nr_highmem)
+static inline unsigned int alloc_highmem_pages(struct memory_bitmap *bm,
+					       unsigned int nr_highmem)
 {
 	unsigned int to_alloc = count_free_highmem_pages();
 
@@ -1870,8 +1868,8 @@ alloc_highmem_pages(struct memory_bitmap
 #else
 static inline int get_highmem_buffer(int safe_needed) { return 0; }
 
-static inline unsigned int
-alloc_highmem_pages(struct memory_bitmap *bm, unsigned int n) { return 0; }
+static inline unsigned int alloc_highmem_pages(struct memory_bitmap *bm,
+					       unsigned int n) { return 0; }
 #endif /* CONFIG_HIGHMEM */
 
 /**
@@ -1886,9 +1884,9 @@ alloc_highmem_pages(struct memory_bitmap
  *	copy_data_pages() works.
  */
 
-static int
-swsusp_alloc(struct memory_bitmap *orig_bm, struct memory_bitmap *copy_bm,
-		unsigned int nr_pages, unsigned int nr_highmem)
+static int swsusp_alloc(struct memory_bitmap *orig_bm,
+			struct memory_bitmap *copy_bm,
+			unsigned int nr_pages, unsigned int nr_highmem)
 {
 	if (nr_highmem > 0) {
 		if (get_highmem_buffer(PG_ANY))
@@ -2005,8 +2003,7 @@ static int init_header(struct swsusp_inf
  *	are stored in the array @buf[] (1 page at a time)
  */
 
-static inline void
-pack_pfns(unsigned long *buf, struct memory_bitmap *bm)
+static inline void pack_pfns(unsigned long *buf, struct memory_bitmap *bm)
 {
 	int j;
 
@@ -2137,8 +2134,7 @@ static int check_header(struct swsusp_in
  *	load header - check the image header and copy data from it
  */
 
-static int
-load_header(struct swsusp_info *info)
+static int load_header(struct swsusp_info *info)
 {
 	int error;
 
@@ -2231,8 +2227,8 @@ static unsigned int safe_highmem_pages;
 
 static struct memory_bitmap *safe_highmem_bm;
 
-static int
-prepare_highmem_image(struct memory_bitmap *bm, unsigned int *nr_highmem_p)
+static int prepare_highmem_image(struct memory_bitmap *bm,
+				 unsigned int *nr_highmem_p)
 {
 	unsigned int to_alloc;
 
@@ -2286,8 +2282,8 @@ prepare_highmem_image(struct memory_bitm
 
 static struct page *last_highmem_page;
 
-static void *
-get_highmem_page_buffer(struct page *page, struct chain_allocator *ca)
+static void *get_highmem_page_buffer(struct page *page,
+				     struct chain_allocator *ca)
 {
 	struct highmem_pbe *pbe;
 	void *kaddr;
@@ -2360,17 +2356,13 @@ static inline void free_highmem_data(voi
 		free_image_page(buffer, PG_UNSAFE_CLEAR);
 }
 #else
-static unsigned int
-count_highmem_image_pages(struct memory_bitmap *bm) { return 0; }
+static unsigned int count_highmem_image_pages(struct memory_bitmap *bm) { return 0; }
 
-static inline int
-prepare_highmem_image(struct memory_bitmap *bm, unsigned int *nr_highmem_p)
-{
-	return 0;
-}
+static inline int prepare_highmem_image(struct memory_bitmap *bm,
+					unsigned int *nr_highmem_p) { return 0; }
 
-static inline void *
-get_highmem_page_buffer(struct page *page, struct chain_allocator *ca)
+static inline void *get_highmem_page_buffer(struct page *page,
+					    struct chain_allocator *ca)
 {
 	return ERR_PTR(-EINVAL);
 }
@@ -2396,8 +2388,7 @@ static inline void free_highmem_data(voi
 
 #define PBES_PER_LINKED_PAGE	(LINKED_PAGE_DATA_SIZE / sizeof(struct pbe))
 
-static int
-prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
+static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
 {
 	unsigned int nr_pages, nr_highmem;
 	struct linked_page *lp;
@@ -2623,8 +2614,8 @@ int snapshot_image_loaded(struct snapsho
 
 #ifdef CONFIG_HIGHMEM
 /* Assumes that @buf is ready and points to a "safe" page */
-static inline void
-swap_two_pages_data(struct page *p1, struct page *p2, void *buf)
+static inline void swap_two_pages_data(struct page *p1, struct page *p2,
+				       void *buf)
 {
 	void *kaddr1, *kaddr2;
 
