From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Sun, 3 May 2009 17:38:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905031734190.24114__489.309992599551$1241451941$gmane$org@chino.kir.corp.google.com>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905031830.49690.rjw@sisk.pl>
	<200905040208.43040.rjw@sisk.pl> <200905040210.10153.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905040210.10153.rjw@sisk.pl>
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
> @@ -1620,7 +1620,8 @@ nofail_alloc:
>  		}
>  
>  		/* The OOM killer will not help higher order allocs so fail */
> -		if (order > PAGE_ALLOC_COSTLY_ORDER) {
> +		if (order > PAGE_ALLOC_COSTLY_ORDER ||
> +				(gfp_mask & __GFP_NO_OOM_KILL)) {
>  			clear_zonelist_oom(zonelist, gfp_mask);
>  			goto nopage;
>  		}

This is inconsistent because __GFP_NO_OOM_KILL now implies __GFP_NORETRY 
(the "goto nopage" above), but only for allocations with __GFP_FS set and 
__GFP_NORETRY clear.
