From: Ankita Garg <ankita@in.ibm.com>
Subject: [PATCH 10/10] mm: Create memory regions at boot-up
Date: Fri, 27 May 2011 18:01:38 +0530
Message-ID: <1306499498-14263-11-git-send-email-ankita__45318.5874772773$1306508260$gmane$org@in.ibm.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: thomas.abraham@linaro.org, ankita@in.ibm.com
List-Id: linux-pm@vger.kernel.org

Memory regions are created at boot up time, from the information obtained
from the firmware. This patchset was developed on ARM platform, on which at
present u-boot bootloader does not export information about memory units that
can be independently power managed. For the purpose of demonstration, 2 hard
coded memory regions are created, of 256MB each on the Panda board with 512MB
RAM.

Signed-off-by: Ankita Garg <ankita@in.ibm.com>
---
 include/linux/mmzone.h |    8 +++-----
 mm/page_alloc.c        |   29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index bc3e3fd..5dbe1e1 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -627,14 +627,12 @@ typedef struct mem_region_list_data {
  */
 struct bootmem_data;
 typedef struct pglist_data {
-/*	The linkage to node_zones is now removed. The new hierarchy introduced
- *	is pg_data_t -> mem_region -> zones
- * 	struct zone node_zones[MAX_NR_ZONES];
- */
 	struct zonelist node_zonelists[MAX_ZONELISTS];
 	int nr_zones;
 #ifdef CONFIG_FLAT_NODE_MEM_MAP	/* means !SPARSEMEM */
-	struct page *node_mem_map;
+	strs pg_data_t -> mem_region -> zones
+ *      struct zone node_zones[MAX_NR_ZONES];
+ */uct page *node_mem_map;
 #ifdef CONFIG_CGROUP_MEM_RES_CTLR
 	struct page_cgroup *node_page_cgroup;
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index da8b045..3d994e8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4285,6 +4285,34 @@ static inline int pageblock_default_order(unsigned int order)
 
 #endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
 
+#define REGIONS_SIZE   (512 << 20) >> PAGE_SHIFT
+
+static void init_node_memory_regions(struct pglist_data *pgdat)
+{
+	int cnt = 0;
+	unsigned long i;
+	unsigned long start_pfn = pgdat->node_start_pfn;
+	unsigned long spanned_pages = pgdat->node_spanned_pages;
+	unsigned long total = 0;
+
+	for (i = start_pfn; i < start_pfn + spanned_pages; i+= REGIONS_SIZE) {
+		mem_region_t *mem_region = &pgdat->mem_regions[cnt];
+
+		mem_region->start_pfn = i;
+		if ((spanned_pages - total) <= REGIONS_SIZE) {
+			mem_region->spanned_pages = spanned_pages - total;
+		}
+		else
+			mem_region->spanned_pages = REGIONS_SIZE;
+
+		mem_region->node = pgdat->node_id;
+		mem_region->region = cnt;
+		pgdat->nr_mem_regions++;
+		total += mem_region->spanned_pages;
+		cnt++;
+	}
+}
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -4447,6 +4475,7 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
 		(unsigned long)pgdat->node_mem_map);
 #endif
 
+	init_node_memory_regions(pgdat);
 	free_area_init_core(pgdat, zones_size, zholes_size);
 }
 
-- 
1.7.4
