From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH][Fix] Hibernation: Do not try to mark invalid
	PFNs as nosave
Date: Thu, 2 Aug 2007 19:18:51 +0200
Message-ID: <200708021918.52283.rjw__44247.1253606074$1186074713$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

[Please consider as 2.6.23 material.]
---
From: Rafael J. Wysocki <rjw@sisk.pl>

On some systems some PFNs reported by the early initialization code as 'nosave'
may be invalid.  If we try to set the corresponding bits in the hibernation
bitmap, BUG_ON() in memory_bm_find_bit() will be triggered and the system
won't be able to boot  (cf. https://bugzilla.novell.com/show_bug.cgi?id=296242).

Prevent this from happening by verifying if the 'nosave' PFNs are valid in
mark_nosave_pages().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/snapshot.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/power/snapshot.c
===================================================================
--- linux-2.6.orig/kernel/power/snapshot.c
+++ linux-2.6/kernel/power/snapshot.c
@@ -709,7 +709,8 @@ static void mark_nosave_pages(struct mem
 				region->end_pfn << PAGE_SHIFT);
 
 		for (pfn = region->start_pfn; pfn < region->end_pfn; pfn++)
-			memory_bm_set_bit(bm, pfn);
+			if (pfn_valid(pfn))
+				memory_bm_set_bit(bm, pfn);
 	}
 }
 
