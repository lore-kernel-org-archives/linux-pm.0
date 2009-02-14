From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/9] swsusp: clean up shrink_all_zones()
Date: Sat, 14 Feb 2009 02:04:10 +0100
Message-ID: <200902140204.12040.rjw__2671.69804214991$1234576118$gmane$org@sisk.pl>
References: <200902140157.40869.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902140157.40869.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

Move local variables to innermost possible scopes and use local
variables to cache calculations/reads done more than once.

No change in functionality (intended).

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---

 mm/vmscan.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -2057,31 +2057,31 @@ static unsigned long shrink_all_zones(un
 				      int pass, struct scan_control *sc)
 {
 	struct zone *zone;
-	unsigned long nr_to_scan, ret = 0;
-	enum lru_list l;
+	unsigned long ret = 0;
 
 	for_each_zone(zone) {
+		enum lru_list l;
 
 		if (!populated_zone(zone))
 			continue;
-
 		if (zone_is_all_unreclaimable(zone) && prio != DEF_PRIORITY)
 			continue;
 
 		for_each_evictable_lru(l) {
+			enum zone_stat_item ls = NR_LRU_BASE + l;
+			unsigned long lru_pages = zone_page_state(zone, ls);
+
 			/* For pass = 0, we don't shrink the active list */
-			if (pass == 0 &&
-				(l == LRU_ACTIVE || l == LRU_ACTIVE_FILE))
+			if (pass == 0 && (l == LRU_ACTIVE_ANON ||
+						l == LRU_ACTIVE_FILE))
 				continue;
 
-			zone->lru[l].nr_scan +=
-				(zone_page_state(zone, NR_LRU_BASE + l)
-								>> prio) + 1;
+			zone->lru[l].nr_scan += (lru_pages >> prio) + 1;
 			if (zone->lru[l].nr_scan >= nr_pages || pass > 3) {
+				unsigned long nr_to_scan;
+
 				zone->lru[l].nr_scan = 0;
-				nr_to_scan = min(nr_pages,
-					zone_page_state(zone,
-							NR_LRU_BASE + l));
+				nr_to_scan = min(nr_pages, lru_pages);
 				ret += shrink_list(l, nr_to_scan, zone,
 								sc, prio);
 				if (ret >= nr_pages)
@@ -2089,7 +2089,6 @@ static unsigned long shrink_all_zones(un
 			}
 		}
 	}
-
 	return ret;
 }
 
