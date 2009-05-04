From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Mon, 4 May 2009 13:02:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905041253380.23036__17581.5496397719$1241467474$gmane$org@chino.kir.corp.google.com>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905041702.23291.rjw@sisk.pl>
	<alpine.DEB.2.00.0905040939400.10707@chino.kir.corp.google.com>
	<200905042151.07953.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905042151.07953.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, torvalds@linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 4 May 2009, Rafael J. Wysocki wrote:

> Index: linux-2.6/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.orig/mm/page_alloc.c
> +++ linux-2.6/mm/page_alloc.c
> @@ -1599,7 +1599,8 @@ nofail_alloc:
>  					zonelist, high_zoneidx, alloc_flags);
>  		if (page)
>  			goto got_pg;
> -	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
> +	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)
> +			&& !(gfp_mask & __GFP_NO_OOM_KILL)) {
>  		if (!try_set_zone_oom(zonelist, gfp_mask)) {
>  			schedule_timeout_uninterruptible(1);
>  			goto restart;
> Index: linux-2.6/include/linux/gfp.h
> ===================================================================
> --- linux-2.6.orig/include/linux/gfp.h
> +++ linux-2.6/include/linux/gfp.h
> @@ -51,8 +51,9 @@ struct vm_area_struct;
>  #define __GFP_THISNODE	((__force gfp_t)0x40000u)/* No fallback, no policies */
>  #define __GFP_RECLAIMABLE ((__force gfp_t)0x80000u) /* Page is reclaimable */
>  #define __GFP_MOVABLE	((__force gfp_t)0x100000u)  /* Page is movable */
> +#define __GFP_NO_OOM_KILL ((__force gfp_t)0x200000u)  /* Don't invoke out_of_memory() */
>  
> -#define __GFP_BITS_SHIFT 21	/* Room for 21 __GFP_FOO bits */
> +#define __GFP_BITS_SHIFT 22	/* Number of __GFP_FOO bits */
>  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
>  
>  /* This equals 0, but use constants in case they ever change */
> 

Yeah, that's much better, thanks.  There's currently concerns about adding 
a new gfp flag in another thread (__GFP_PANIC), though, so you might find 
some resistance in adding a flag with a very specific and limited use cae.

I think you might have better luck in doing

	struct zone *z;

	for_each_populated_zone(z)
		zone_set_flag(z, ZONE_OOM_LOCKED);
	
if all other tasks are really in D state at this point since oom killer 
serialization is done with try locks in the page allocator.  This is 
equivalent to __GFP_NO_OOM_KILL.
