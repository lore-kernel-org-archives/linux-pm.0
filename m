From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 30/35] mm: Provide a mechanism to check if a given page
 is in the region allocator
Date: Fri, 30 Aug 2013 18:53:31 +0530
Message-ID: <20130830132329.4947.99949.stgit@srivatsabhat.in.ibm.com>
References: <20130830131221.4947.99764.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130830131221.4947.99764.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, mgorman@suse.de, hannes@cmpxchg.org, tony.luck@intel.com, matthew.garrett@nebula.com, dave@sr71.net, riel@redhat.com, arjan@linux.intel.com, srinivas.pandruvada@linux.intel.com, willy@linux.intel.com, kamezawa.hiroyu@jp.fujitsu.com, lenb@kernel.org, rjw@sisk.pl
Cc: gargankita@gmail.com, paulmck@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, andi@firstfloor.org, isimatu.yasuaki@jp.fujitsu.com, santosh.shilimkar@ti.com, kosaki.motohiro@gmail.com, srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

With the introduction of the region allocator, a freepage can be either
in one of the buddy freelists or in the region allocator. In cases where we
want to move freepages to a given migratetype's freelists, we will need to
know where they were originally located. So provide a helper to distinguish
whether the freepage resides in the region allocator or the buddy freelists.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 mm/page_alloc.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a62730b..3f49ca8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1047,6 +1047,37 @@ static int del_from_region_allocator(struct zone *zone, unsigned int order,
 }
 
 /*
+ * Return 1 if the page is in the region allocator, else return 0
+ * (which usually means that the page is in the buddy freelists).
+ */
+static int page_in_region_allocator(struct page *page)
+{
+	struct region_allocator *reg_alloc;
+	struct free_area_region *reg_area;
+	int order, region_id;
+
+	/* We keep only MAX_ORDER-1 pages in the region allocator */
+	order = page_order(page);
+	if (order != MAX_ORDER-1)
+		return 0;
+
+	/*
+	 * It is sufficient to check if (any of) the pages belonging to
+	 * that region are in the region allocator, because a page resides
+	 * in the region allocator if and only if all the pages of that
+	 * region are also in the region allocator.
+	 */
+	region_id = page_zone_region_id(page);
+	reg_alloc = &page_zone(page)->region_allocator;
+	reg_area = &reg_alloc->region[region_id].region_area[order];
+
+	if (reg_area->nr_free)
+		return 1;
+
+	return 0;
+}
+
+/*
  * Freeing function for a buddy system allocator.
  *
  * The concept of a buddy system is to maintain direct-mapped table
