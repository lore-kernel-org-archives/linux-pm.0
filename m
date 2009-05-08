From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Fri, 8 May 2009 15:51:55 +0200
Message-ID: <200905081551.56577.rjw__12895.1285304085$1241790890$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905080111.31273.rjw@sisk.pl>
	<20090508095010.GA26398@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090508095010.GA26398@localhost>
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
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: David Rientjes <rientjes@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alan-jenkins@tuffmail.co.uk" <alan-jenkins@tuffmail.co.uk>, "jens.axboe@oracle.com" <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, "kernel-testers@vger.kernel.org" <kernel-testers@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 08 May 2009, Wu Fengguang wrote:
> On Fri, May 08, 2009 at 07:11:30AM +0800, Rafael J. Wysocki wrote:
> > On Friday 08 May 2009, David Rientjes wrote:
> > > On Thu, 7 May 2009, Andrew Morton wrote:
> > > 
> > > > The setting and clearing of that thing looks gruesomely racy..
> > > > 
> > > 
> > > It's not racy currently because zone_scan_lock ensures ZONE_OOM_LOCKED 
> > > gets test/set and cleared atomically for the entire zonelist (the clear 
> > > happens for the same zonelist that was test/set).
> > > 
> > > Using it for hibernation in the way I've proposed will open it up to the 
> > > race I earlier described: when a kthread is in the oom killer and 
> > > subsequently clears its zonelist of ZONE_OOM_LOCKED (all other tasks are 
> > > frozen so they can't be in the oom killer).  That's perfectly acceptable, 
> > > however, since the system is by definition already oom if kthreads can't 
> > > get memory so it will end up killing a user task even though it's stuck in 
> > > D state and will exit on thaw; we aren't concerned about killing 
> > > needlessly because the oom killer becomes a no-op when it finds a task 
> > > that has already been killed but hasn't exited by way of TIF_MEMDIE.
> > 
> > OK there.
> > 
> > So everyone seems to agree we can do something like in the patch below?
> > 
> > ---
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PM/Hibernate: Rework shrinking of memory
> > 
> > Rework swsusp_shrink_memory() so that it calls shrink_all_memory()
> > just once to make some room for the image and then allocates memory
> > to apply more pressure to the memory management subsystem, if
> > necessary.
> 
> Thanks! Reducing to single-pass helps memory bounty laptops considerably :)
> 
> > Unfortunately, we don't seem to be able to drop shrink_all_memory()
> > entirely just yet, because that would lead to huge performance
> > regressions in some test cases.
> 
> Yes, but it's not the fault of this patch. In fact some regressions
> may even be positive pressures to the page allocate/reclaim code ;)
> 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  kernel/power/snapshot.c |  151 +++++++++++++++++++++++++++++++++---------------
> >  1 file changed, 104 insertions(+), 47 deletions(-)
> > 
> > Index: linux-2.6/kernel/power/snapshot.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/power/snapshot.c
> > +++ linux-2.6/kernel/power/snapshot.c
> > @@ -1066,69 +1066,126 @@ void swsusp_free(void)
> >  	buffer = NULL;
> >  }
> >  
> > +/* Helper functions used for the shrinking of memory. */
> > +
> >  /**
> > - *	swsusp_shrink_memory -  Try to free as much memory as needed
> > - *
> > - *	... but do not OOM-kill anyone
> > + * preallocate_image_memory - Allocate given number of page frames
> > + * @nr_pages: Number of page frames to allocate
> >   *
> > - *	Notice: all userland should be stopped before it is called, or
> > - *	livelock is possible.
> > + * Return value: Number of page frames actually allocated
> >   */
> > -
> > -#define SHRINK_BITE	10000
> > -static inline unsigned long __shrink_memory(long tmp)
> > +static unsigned long preallocate_image_memory(unsigned long nr_pages)
> >  {
> > -	if (tmp > SHRINK_BITE)
> > -		tmp = SHRINK_BITE;
> > -	return shrink_all_memory(tmp);
> > +	unsigned long nr_alloc = 0;
> > +
> > +	while (nr_pages > 0) {
> > +		if (!alloc_image_page(GFP_KERNEL | __GFP_NOWARN))
> > +			break;
> > +		nr_pages--;
> > +		nr_alloc++;
> > +	}
> > +
> > +	return nr_alloc;
> >  }
> >  
> > +/**
> > + * swsusp_shrink_memory -  Make the kernel release as much memory as needed
> > + *
> > + * To create a hibernation image it is necessary to make a copy of every page
> > + * frame in use.  We also need a number of page frames to be free during
> > + * hibernation for allocations made while saving the image and for device
> > + * drivers, in case they need to allocate memory from their hibernation
> > + * callbacks (these two numbers are given by PAGES_FOR_IO and SPARE_PAGES,
> > + * respectively, both of which are rough estimates).  To make this happen, we
> > + * compute the total number of available page frames and allocate at least
> > + *
> > + * ([page frames total] + PAGES_FOR_IO + [metadata pages]) / 2 + 2 * SPARE_PAGES
> > + *
> > + * of them, which corresponds to the maximum size of a hibernation image.
> > + *
> > + * If image_size is set below the number following from the above formula,
> > + * the preallocation of memory is continued until the total number of page
> > + * frames in use is below the requested image size or it is impossible to
> > + * allocate more memory, whichever happens first.
> > + */
> >  int swsusp_shrink_memory(void)
> >  {
> > -	long tmp;
> >  	struct zone *zone;
> > -	unsigned long pages = 0;
> > -	unsigned int i = 0;
> > -	char *p = "-\\|/";
> > +	unsigned long saveable, size, max_size, count, pages = 0;
> >  	struct timeval start, stop;
> > +	int error = 0;
> >  
> > -	printk(KERN_INFO "PM: Shrinking memory...  ");
> > +	printk(KERN_INFO "PM: Shrinking memory ... ");
> >  	do_gettimeofday(&start);
> > -	do {
> > -		long size, highmem_size;
> >  
> > -		highmem_size = count_highmem_pages();
> > -		size = count_data_pages() + PAGES_FOR_IO + SPARE_PAGES;
> > -		tmp = size;
> > -		size += highmem_size;
> > -		for_each_populated_zone(zone) {
> > -			tmp += snapshot_additional_pages(zone);
> > -			if (is_highmem(zone)) {
> > -				highmem_size -=
> > -					zone_page_state(zone, NR_FREE_PAGES);
> > -			} else {
> > -				tmp -= zone_page_state(zone, NR_FREE_PAGES);
> > -				tmp += zone->lowmem_reserve[ZONE_NORMAL];
> > -			}
> > -		}
> > +	/* Count the number of saveable data pages. */
> > +	saveable = count_data_pages() + count_highmem_pages();
> >  
> > -		if (highmem_size < 0)
> > -			highmem_size = 0;
> > +	/*
> > +	 * Compute the total number of page frames we can use (count) and the
> > +	 * number of pages needed for image metadata (size).
> > +	 */
> > +	count = saveable;
> > +	size = 0;
> > +	for_each_populated_zone(zone) {
> > +		size += snapshot_additional_pages(zone);
> > +		count += zone_page_state(zone, NR_FREE_PAGES);
> > +		count -= zone->pages_min;
> 
> I'd prefer to be more safe, by removing the above line...
> 
> > +	}
> 
> ...and add another line here:
> 
>         count -= totalreserve_pages;

OK

> But hey, that 'count' counts "savable+free" memory.
> We don't have a counter for an estimation of "free+freeable" memory,
> ie. we are sure we cannot preallocate above that threshold. 
> 
> One applicable situation is, when there are 800M anonymous memory,
> but only 500M image_size and no swap space.
> 
> In that case we will otherwise goto the oom code path. Sure oom is
> (and shall be) reliably disabled in hibernation, but still we shall be
> cautious enough not to create a low memory situation, which will hurt:
> - hibernation speed
>   (vmscan goes mad trying to squeeze the last free page)
> - user experiences after resume
>   (all *active* file data and metadata have to reloaded)

Strangely enough, my recent testing with this patch doesn't confirm the
theory. :-)  Namely, I set image_size too low on purpose and it only caused
preallocate_image_memory() to return NULL at one point and that was it.

It didn't even took too much time.

I'll carry out more testing to verify this observation.

> The current code simply tries *too hard* to meet image_size.
> I'd rather take that as a mild advice, and to only free
> "free+freeable-margin" pages when image_size is not approachable.
> 
> The safety margin can be totalreserve_pages, plus enough pages for
> retaining the "hard core working set".

How to compute the size of the "hard core working set", then?

Rafael
