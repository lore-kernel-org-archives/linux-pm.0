From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Mon, 18 Jan 2010 11:20:28 +0900 (JST)
Message-ID: <20100118111703.AE36.A69D9226__25243.2748595767$1263781452$gmane$org@jp.fujitsu.com>
References: <1263745267.2162.42.camel@barrios-desktop>
	<201001180125.59413.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001180125.59413.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, kosaki.motohiro@jp.fujitsu.com, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> Index: linux-2.6/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.orig/mm/page_alloc.c
> +++ linux-2.6/mm/page_alloc.c
> @@ -1963,10 +1963,13 @@ __alloc_pages_nodemask(gfp_t gfp_mask, u
>  	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, nodemask, order,
>  			zonelist, high_zoneidx, ALLOC_WMARK_LOW|ALLOC_CPUSET,
>  			preferred_zone, migratetype);
> -	if (unlikely(!page))
> +	if (unlikely(!page)) {
> +		mm_lock_suspend(gfp_mask);
>  		page = __alloc_pages_slowpath(gfp_mask, order,
>  				zonelist, high_zoneidx, nodemask,
>  				preferred_zone, migratetype);
> +		mm_unlock_suspend(gfp_mask);
> +	}
>  
>  	trace_mm_page_alloc(page, order, gfp_mask, migratetype);
>  	return page;

I think we don't need read side lock at all. generally, no lock might makes race.
But in this case, changing gfp_allowed_mask and nvidia suspend method should be
serialized higher level. Why the above two code need to run concurrently?
