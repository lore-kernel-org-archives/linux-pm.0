From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 13/24] mm/power: Use memblock apis for early memory allocations
Date: Sat, 09 Nov 2013 02:30:44 +0100
Message-ID: <1479529.EjZ9YN8f8I@vostro.rjw.lan>
References: <1383954120-24368-1-git-send-email-santosh.shilimkar@ti.com> <1383954120-24368-14-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1383954120-24368-14-git-send-email-santosh.shilimkar@ti.com>
Sender: owner-linux-mm@kvack.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, November 08, 2013 06:41:49 PM Santosh Shilimkar wrote:
> Switch to memblock interfaces for early memory allocator instead of
> bootmem allocator. No functional change in beahvior than what it is
> in current code from bootmem users points of view.
> 
> Archs already converted to NO_BOOTMEM now directly use memblock
> interfaces instead of bootmem wrappers build on top of memblock. And the
> archs which still uses bootmem, these new apis just fallback to exiting
> bootmem APIs.
> 
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: linux-pm@vger.kernel.org
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Fine by me, thanks!

> ---
>  kernel/power/snapshot.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 358a146..887134e 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -637,7 +637,7 @@ __register_nosave_region(unsigned long start_pfn, unsigned long end_pfn,
>  		BUG_ON(!region);
>  	} else
>  		/* This allocation cannot fail */
> -		region = alloc_bootmem(sizeof(struct nosave_region));
> +		region = memblock_virt_alloc(sizeof(struct nosave_region));
>  	region->start_pfn = start_pfn;
>  	region->end_pfn = end_pfn;
>  	list_add_tail(&region->list, &nosave_regions);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
