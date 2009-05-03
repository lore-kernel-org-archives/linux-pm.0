From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/4] mm: Add __GFP_NO_OOM_KILL flag
Date: Sun, 3 May 2009 02:22:06 +0200
Message-ID: <200905030222.07360.rjw__32158.1249045723$1241312107$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera>
	<20090502104947.2720f173.akpm@linux-foundation.org>
	<200905030220.57933.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905030220.57933.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, kernel-testers@vger.kernel.org, torvalds@linux-foundation.org
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

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/gfp.h |    3 ++-
 mm/page_alloc.c     |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -1620,7 +1620,8 @@ nofail_alloc:
 		}
 
 		/* The OOM killer will not help higher order allocs so fail */
-		if (order > PAGE_ALLOC_COSTLY_ORDER) {
+		if (order > PAGE_ALLOC_COSTLY_ORDER ||
+				(gfp_mask & __GFP_NO_OOM_KILL)) {
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
+#define __GFP_BITS_SHIFT 22	/* Number of__GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /* This equals 0, but use constants in case they ever change */
