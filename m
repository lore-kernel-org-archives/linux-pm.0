From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 5/19] TuxOnIce: Create means of determining how
	many pages can be allocated.
Date: Thu,  7 May 2009 00:39:01 +1000
Message-ID: <1241620755-22133-6-git-send-email-nigel__20406.0547439896$1241622005$gmane$org@tuxonice.net>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

The use of watermarks in the page allocator mean that one cannot simply
check nr_free_zone_pages to discover how many pages are available. This
function adds a variant of nr_free_zone_pages that takes watermarks into
account, together with a variant of nr_free_buffer_pages to use it. The
later function is used by TuxOnIce to ensure that it always leaves some
memory available for lower level block I/O functions.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 include/linux/swap.h |    1 +
 mm/page_alloc.c      |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 62d8143..085cc14 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -168,6 +168,7 @@ struct swap_list_t {
 extern unsigned long totalram_pages;
 extern unsigned long totalreserve_pages;
 extern unsigned int nr_free_buffer_pages(void);
+extern unsigned int nr_unallocated_buffer_pages(void);
 extern unsigned int nr_free_pagecache_pages(void);
 
 /* Definition of global_page_state not available yet */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e2f2699..95e753f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1810,6 +1810,26 @@ static unsigned int nr_free_zone_pages(int offset)
 	return sum;
 }
 
+static unsigned int nr_unallocated_zone_pages(int offset)
+{
+	struct zoneref *z;
+	struct zone *zone;
+
+	/* Just pick one node, since fallback list is circular */
+	unsigned int sum = 0;
+
+	struct zonelist *zonelist = node_zonelist(numa_node_id(), GFP_KERNEL);
+
+	for_each_zone_zonelist(zone, z, zonelist, offset) {
+		unsigned long high = zone->pages_high;
+		unsigned long left = zone_page_state(zone, NR_FREE_PAGES);
+		if (left > high)
+			sum += left - high;
+	}
+
+	return sum;
+}
+
 /*
  * Amount of free RAM allocatable within ZONE_DMA and ZONE_NORMAL
  */
@@ -1820,6 +1840,14 @@ unsigned int nr_free_buffer_pages(void)
 EXPORT_SYMBOL_GPL(nr_free_buffer_pages);
 
 /*
+ * Amount of free RAM allocatable within ZONE_DMA and ZONE_NORMAL
+ */
+unsigned int nr_unallocated_buffer_pages(void)
+{
+	return nr_unallocated_zone_pages(gfp_zone(GFP_USER));
+}
+
+/*
  * Amount of free RAM allocatable within all zones
  */
 unsigned int nr_free_pagecache_pages(void)
-- 
1.5.6.3
