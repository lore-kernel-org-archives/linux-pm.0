From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] PM/Hibernate: Use memory allocations to
	free memory
Date: Fri, 1 May 2009 16:14:23 -0700
Message-ID: <20090501161423.94b37d5b.akpm__35367.0798046098$1241219995$gmane$org@linux-foundation.org>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera>
	<20090422131943.69288af3.akpm@linux-foundation.org>
	<200905020026.19027.rjw@sisk.pl> <200905020029.39181.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905020029.39181.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, kernel-testers@vger.kernel.org, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2 May 2009 00:29:38 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Modify the hibernation memory shrinking code so that it will make
> memory allocations to free memory instead of using an artificial
> memory shrinking mechanism for that.  Remove the shrinking of
> memory from the suspend-to-RAM code, where it is not really
> necessary.  Finally, remove the no longer used memory shrinking
> functions from mm/vmscan.c .
> 
> ...
>
> +static long alloc_and_mark_pages(struct memory_bitmap *bm, long nr_pages)
>  {
> -	if (tmp > SHRINK_BITE)
> -		tmp = SHRINK_BITE;
> -	return shrink_all_memory(tmp);
> +	long nr_normal = 0;
> +
> +	while (nr_pages-- > 0) {
> +		struct page *page;
> +
> +		page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM);
> +		if (!page)
> +			return -ENOMEM;
> +		memory_bm_set_bit(bm, page_to_pfn(page));
> +		if (!PageHighMem(page))
> +			nr_normal++;
> +	}
> +
> +	return nr_normal;
>  }

Do we need the bitmap?  I expect we can just string all these pages
onto a local list via page.lru.  Would need to check that - the
pageframe fields are quite overloaded.


> ...
>
> +#define SHRINK_BITE	10000
> +		long size, highmem_size, ret;
> +
> +		highmem_size = count_highmem_pages() - 2 * alloc_highmem;
> +		size = count_data_pages() + PAGES_FOR_IO + SPARE_PAGES
> +			- 2 * alloc_normal;

It'd be nice if this head-spinning arithmetic were spelled out in a
comment somewhere.  There are rather a lot of magic-number heuristics
in here.

>  		tmp = size;
>  		size += highmem_size;
>  		for_each_populated_zone(zone) {
> @@ -621,27 +671,39 @@ int swsusp_shrink_memory(void)

All looks pretty sane to me.
