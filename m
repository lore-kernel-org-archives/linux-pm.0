From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 25/35] mm: Fix vmstat to also account for freepages in
 the region allocator
Date: Fri, 30 Aug 2013 18:51:50 +0530
Message-ID: <20130830132143.4947.71496.stgit@srivatsabhat.in.ibm.com>
References: <20130830131221.4947.99764.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130830131221.4947.99764.stgit@srivatsabhat.in.ibm.com>
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org, mgorman@suse.de, hannes@cmpxchg.org, tony.luck@intel.com, matthew.garrett@nebula.com, dave@sr71.net, riel@redhat.com, arjan@linux.intel.com, srinivas.pandruvada@linux.intel.com, willy@linux.intel.com, kamezawa.hiroyu@jp.fujitsu.com, lenb@kernel.org, rjw@sisk.pl
Cc: gargankita@gmail.com, paulmck@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, andi@firstfloor.org, isimatu.yasuaki@jp.fujitsu.com, santosh.shilimkar@ti.com, kosaki.motohiro@gmail.com, srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently vmstat considers only the freepages present in the buddy freelists
of the page allocator. But with the newly introduced region allocator in
place, freepages could be present in the region allocator as well. So teach
vmstat to take them into consideration when reporting free memory.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 mm/vmstat.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 924babc..8cb7a10 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -829,6 +829,8 @@ static void frag_show_print(struct seq_file *m, pg_data_t *pgdat,
 {
 	int i, order, t;
 	struct free_area *area;
+	struct free_area_region *reg_area;
+	struct region_allocator *reg_alloc;
 
 	seq_printf(m, "Node %d, zone %8s \n", pgdat->node_id, zone->name);
 
@@ -845,6 +847,12 @@ static void frag_show_print(struct seq_file *m, pg_data_t *pgdat,
 				nr_free +=
 					area->free_list[t].mr_list[i].nr_free;
 			}
+
+			/* Add up freepages in the region allocator as well */
+			reg_alloc = &zone->region_allocator;
+			reg_area = &reg_alloc->region[i].region_area[order];
+			nr_free += reg_area->nr_free;
+
 			seq_printf(m, "%6lu ", nr_free);
 		}
 		seq_putc(m, '\n');

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
