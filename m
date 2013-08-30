From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 22/35] mm: Provide a mechanism to request free memory
 from the region allocator
Date: Fri, 30 Aug 2013 18:50:49 +0530
Message-ID: <20130830132047.4947.67625.stgit@srivatsabhat.in.ibm.com>
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

Implement helper functions to request freepages from the region allocator
in order to add them to the buddy freelists.

For simplicity, all operations related to the region allocator are performed
at the granularity of entire memory regions. That is, when the buddy
allocator requests freepages from the region allocator, the latter picks a
free region and always allocates all the freepages belonging to that entire
region.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 mm/page_alloc.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d407caf..5b58e7d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -938,6 +938,29 @@ static void add_to_region_allocator(struct zone *z, struct free_list *free_list,
 	del_from_freelist_bulk(ralloc_list, free_list, order, region_id);
 }
 
+/* Delete freepages from the region allocator and add them to buddy freelists */
+static int del_from_region_allocator(struct zone *zone, unsigned int order,
+				     int migratetype)
+{
+	struct region_allocator *reg_alloc;
+	struct list_head *ralloc_list;
+	struct free_list *free_list;
+	int next_region;
+
+	reg_alloc = &zone->region_allocator;
+
+	next_region = reg_alloc->next_region;
+	if (next_region < 0)
+		return -ENOMEM;
+
+	ralloc_list = &reg_alloc->region[next_region].region_area[order].list;
+	free_list = &zone->free_area[order].free_list[migratetype];
+
+	add_to_freelist_bulk(ralloc_list, free_list, order, next_region);
+
+	return 0;
+}
+
 /*
  * Freeing function for a buddy system allocator.
  *
