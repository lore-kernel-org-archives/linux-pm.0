From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Mon, 4 May 2009 21:51:07 +0200
Message-ID: <200905042151.07953.rjw__48636.1842057251$1241466925$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905041702.23291.rjw@sisk.pl>
	<alpine.DEB.2.00.0905040939400.10707@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.0905040939400.10707@chino.kir.corp.google.com>
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
To: David Rientjes <rientjes@google.com>
Cc: kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, torvalds@linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 04 May 2009, David Rientjes wrote:
> On Mon, 4 May 2009, Rafael J. Wysocki wrote:
> 
> > > > Index: linux-2.6/mm/page_alloc.c
> > > > ===================================================================
> > > > --- linux-2.6.orig/mm/page_alloc.c
> > > > +++ linux-2.6/mm/page_alloc.c
> > > > @@ -1620,7 +1620,8 @@ nofail_alloc:
> > > >  		}
> > > >  
> > > >  		/* The OOM killer will not help higher order allocs so fail */
> > > > -		if (order > PAGE_ALLOC_COSTLY_ORDER) {
> > > > +		if (order > PAGE_ALLOC_COSTLY_ORDER ||
> > > > +				(gfp_mask & __GFP_NO_OOM_KILL)) {
> > > >  			clear_zonelist_oom(zonelist, gfp_mask);
> > > >  			goto nopage;
> > > >  		}
> > > 
> > > This is inconsistent because __GFP_NO_OOM_KILL now implies __GFP_NORETRY 
> > > (the "goto nopage" above), but only for allocations with __GFP_FS set and 
> > > __GFP_NORETRY clear.
> > 
> > Well, what would you suggest?
> > 
> 
> A couple things:
> 
>  - rebase this on mmotm so that it doesn't conflict with Mel Gorman's page
>    allocator speedup changes, and

I'm going to rebase the patchset on top of linux-next eventually.

>  - avoid the final call to get_page_from_freelist() for 
>    !(gfp_mask & __GFP_NO_OOM_KILL) by adding a check for it alongside 
>    (gfp_mask & __GFP_FS) and !(gfp_mask & __GFP_NORETRY) because it should
>    really only catch parallel oom killings which won't happen in your 
>    suspend case since it uses ALLOC_WMARK_HIGH.
> 
> The latter is important to avoid unnecessary dependencies among low-level 
> __GFP_* flags (although all __GFP_NO_OOM_KILL allocations should really 
> all be passing __GFP_NORETRY too to avoid relying too heavily on direct 
> reclaim).

OK, thanks.

Something like this?

---
 include/linux/gfp.h |    3 ++-
 mm/page_alloc.c     |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -1599,7 +1599,8 @@ nofail_alloc:
 					zonelist, high_zoneidx, alloc_flags);
 		if (page)
 			goto got_pg;
-	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
+	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)
+			&& !(gfp_mask & __GFP_NO_OOM_KILL)) {
 		if (!try_set_zone_oom(zonelist, gfp_mask)) {
 			schedule_timeout_uninterruptible(1);
 			goto restart;
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
