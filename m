From: David Rientjes <rientjes@google.com>
Subject: Re: [RFC][PATCH 1/6] mm: Introduce __GFP_NO_OOM_KILL
Date: Mon, 11 May 2009 13:12:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905111312140.27577__37158.9249735281$1242072992$gmane$org@chino.kir.corp.google.com>
References: <200905070040.08561.rjw@sisk.pl> <200905072348.59856.rjw@sisk.pl>
	<200905101548.57557.rjw@sisk.pl> <200905101550.09671.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905101550.09671.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, pm list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 10 May 2009, Rafael J. Wysocki wrote:

> Index: linux-2.6/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.orig/mm/page_alloc.c
> +++ linux-2.6/mm/page_alloc.c
> @@ -1619,8 +1619,12 @@ nofail_alloc:
>  			goto got_pg;
>  		}
>  
> -		/* The OOM killer will not help higher order allocs so fail */
> -		if (order > PAGE_ALLOC_COSTLY_ORDER) {
> +		/*
> +		 * The OOM killer will not help higher order allocs so fail.
> +		 * Also fail if the caller doesn't want the OOM killer to run.
> +		 */
> +		if (order > PAGE_ALLOC_COSTLY_ORDER
> +				|| (gfp_mask & __GFP_NO_OOM_KILL)) {
>  			clear_zonelist_oom(zonelist, gfp_mask);
>  			goto nopage;
>  		}
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

Nack, unnecessary in mmotm and my patch series from 
http://lkml.org/lkml/2009/5/10/118.
