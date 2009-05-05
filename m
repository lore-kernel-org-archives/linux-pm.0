From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 5/5] PM/Hibernate: Do not release
	preallocated memory	unnecessarily (rev. 2)
Date: Tue, 5 May 2009 10:24:27 +0800
Message-ID: <20090505022427.GA10880__17252.9568350457$1241490563$gmane$org@localhost>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905031830.49690.rjw@sisk.pl>
	<200905040208.43040.rjw@sisk.pl> <200905040222.39062.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905040222.39062.rjw@sisk.pl>
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alan-jenkins@tuffmail.co.uk" <alan-jenkins@tuffmail.co.uk>, "jens.axboe@oracle.com" <jens.axboe@oracle.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "kernel-testers@vger.kernel.org" <kernel-testers@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 04, 2009 at 08:22:38AM +0800, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Since the hibernation code is now going to use allocations of memory
> to create enough room for the image, it can also use the page frames
> allocated at this stage as image page frames.  The low-level
> hibernation code needs to be rearranged for this purpose, but it
> allows us to avoid freeing a great number of pages and allocating
> these same pages once again later, so it generally is worth doing.
> 
> [rev. 2: Change the strategy of preallocating memory to allocate as
>  many pages as needed to get the right image size in one shot (the
>  excessive allocated pages are released afterwards).]

Rafael, I tried out your patches and found doubled memory shrink speed!

[  579.641781] PM: Preallocating image memory ... done (allocated 383900 pages, 128000 image pages kept)
[  583.087875] PM: Allocated 1535600 kbytes in 3.43 seconds (447.69 MB/s)

For you reference, here is the free memory before/after
hibernate_preallocate_memory():

        # free
                     total       used       free     shared    buffers     cached
        Mem:          1933       1917         15          0          0       1845
        -/+ buffers/cache:         72       1861
        Swap:            0          0          0

        # free
                     total       used       free     shared    buffers     cached
        Mem:          1933        920       1012          0          0        356
        -/+ buffers/cache:        563       1369
        Swap:            0          0          0

It seems that the preallocated memory is not freed on -ENOMEM.

+       error = memory_bm_create(&orig_bm, GFP_IMAGE, PG_ANY);
+       if (error)
+               goto err_out;
+
+       error = memory_bm_create(&copy_bm, GFP_IMAGE, PG_ANY);
+       if (error)
+               goto err_out;

memory_bm_create() is called a number of times, each time it will
call create_mem_extents()/memory_bm_free(). Can they be optimized to
be called only once?

A side note: there are somehow duplicated *_extent_*() logics in the
filesystems, is it possible that we abstract out some of the common code?

+       for_each_populated_zone(zone) {
+               size += snapshot_additional_pages(zone);
+               count += zone_page_state(zone, NR_FREE_PAGES);
+               if (!is_highmem(zone))
+                       count -= zone->lowmem_reserve[ZONE_NORMAL];
+       }

Why [ZONE_NORMAL] instead of [zone]? ZONE_NORMAL may not always be the largest zone,
for example, My 4GB laptop has a tiny ZONE_NORMAL and a large ZONE_DMA32.

+       /* If size < max_size, preallocating enough memory may be impossible. */
+       if (count > 0 && size == max_size)
+               error = -ENOMEM;
+       if (error)
+               goto err_out;

The two if()s can be merged.

At last, I'd express my major concern about the transition to preallocate
based memory shrinking: will it lead to more random swapping IOs?

Thanks,
Fengguang
