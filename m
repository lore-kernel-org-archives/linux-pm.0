From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/5] mm: Introduce __GFP_NO_OOM_KILL
Date: Thu, 7 May 2009 23:50:06 +0200
Message-ID: <200905072350.07105.rjw__37132.6766013682$1241735832$gmane$org@sisk.pl>
References: <200905070040.08561.rjw@sisk.pl> <200905072348.59856.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905072348.59856.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>

> > Remind me: why can't we just allocate N pages at suspend-time?
> 
> We need half of memory free. The reason we can't "just allocate" is
> probably OOM killer; but my memories are quite weak :-(.

hm.  You'd think that with our splendid range of __GFP_foo falgs, there
would be some combo which would suit this requirement but I can't
immediately spot one.

We can always add another I guess.  Something like...

[rjw: fixed white space, added comment in page_alloc.c]

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/gfp.h |    3 ++-
 mm/page_alloc.c     |    8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -1619,8 +1619,12 @@ nofail_alloc:
 			goto got_pg;
 		}
 
-		/* The OOM killer will not help higher order allocs so fail */
-		if (order > PAGE_ALLOC_COSTLY_ORDER) {
+		/*
+		 * The OOM killer will not help higher order allocs so fail.
+		 * Also fail if the caller doesn't want the OOM killer to run.
+		 */
+		if (order > PAGE_ALLOC_COSTLY_ORDER
+				|| (gfp_mask & __GFP_NO_OOM_KILL)) {
 			clear_zonelist_oom(zonelist, gfp_mask);
 			goto nopage;
 		}
Index: linux-2.6/include/linux/gfp.h
===================================================================
--- linux-2.6.orig/include/linux/gfp.h
+++ linux-2.6/include/linux/gfp.h
@@ -51,8 +51,9 @@ struct vm_area_struct;
 #define __GFP_THISNODE	((__force gfp_t)0x40000u)/* No fallback, no policies */
 #define __GFP_RECLAIMABLE ((__force gfp_t)0x80000u) /* Page is reclaimable */
 #define __GFP_MOVABLE	((__force gfp_t)0x100000u)  /* Page is movable */
+#define __GFP_NO_OOM_KILL ((__force gfp_t)0x200000u)  /* Don't invoke out_of_memory() */
 
-#define __GFP_BITS_SHIFT 21	/* Room for 21 __GFP_FOO bits */
+#define __GFP_BITS_SHIFT 22	/* Number of __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /* This equals 0, but use constants in case they ever change */
