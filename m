From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 10/35] mm: Use the correct migratetype during buddy
 merging
Date: Fri, 30 Aug 2013 18:07:28 +0530
Message-ID: <20130830123715.24352.33969.stgit@srivatsabhat.in.ibm.com>
References: <20130830123303.24352.18732.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130830123303.24352.18732.stgit@srivatsabhat.in.ibm.com>
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org, mgorman@suse.de, hannes@cmpxchg.org, tony.luck@intel.com, matthew.garrett@nebula.com, dave@sr71.net, riel@redhat.com, arjan@linux.intel.com, srinivas.pandruvada@linux.intel.com, willy@linux.intel.com, kamezawa.hiroyu@jp.fujitsu.com, lenb@kernel.org, rjw@sisk.pl
Cc: gargankita@gmail.com, paulmck@linux.vnet.ibm.com, amit.kachhap@linaro.org, svaidy@linux.vnet.ibm.com, andi@firstfloor.org, isimatu.yasuaki@jp.fujitsu.com, santosh.shilimkar@ti.com, kosaki.motohiro@gmail.com, srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

While merging buddy free pages of a given order to make a higher order page,
the buddy allocator might coalesce pages belonging to *two* *different*
migratetypes of that order!

So, don't assume that both the buddies come from the same freelist;
instead, explicitly find out the migratetype info of the buddy page and use
it while merging the buddies.

Also, set the freepage migratetype of the buddy to the new one.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 mm/page_alloc.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b4b1275..07ac019 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -681,10 +681,14 @@ static inline void __free_one_page(struct page *page,
 			__mod_zone_freepage_state(zone, 1 << order,
 						  migratetype);
 		} else {
+			int mt;
+
 			area = &zone->free_area[order];
-			del_from_freelist(buddy, &area->free_list[migratetype]);
+			mt = get_freepage_migratetype(buddy);
+			del_from_freelist(buddy, &area->free_list[mt]);
 			area->nr_free--;
 			rmv_page_order(buddy);
+			set_freepage_migratetype(buddy, migratetype);
 		}
 		combined_idx = buddy_idx & page_idx;
 		page = page + (combined_idx - page_idx);

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
