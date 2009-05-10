From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Sun, 10 May 2009 12:52:16 +0800
Message-ID: <20090510045216.GA5794__1832.39268740198$1241931309$gmane$org@localhost>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905090208.44381.rjw@sisk.pl>
	<20090509073417.GB6487@localhost> <200905092122.58640.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905092122.58640.rjw@sisk.pl>
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
Cc: David Rientjes <rientjes@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alan-jenkins@tuffmail.co.uk" <alan-jenkins@tuffmail.co.uk>, "jens.axboe@oracle.com" <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, "kernel-testers@vger.kernel.org" <kernel-testers@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, May 10, 2009 at 03:22:57AM +0800, Rafael J. Wysocki wrote:
> On Saturday 09 May 2009, Wu Fengguang wrote:
> > On Sat, May 09, 2009 at 08:08:43AM +0800, Rafael J. Wysocki wrote:
> > > On Friday 08 May 2009, Rafael J. Wysocki wrote:
> > > > On Friday 08 May 2009, Wu Fengguang wrote:
> > > [--snip--]
> > > > > But hey, that 'count' counts "savable+free" memory.
> > > > > We don't have a counter for an estimation of "free+freeable" memory,
> > > > > ie. we are sure we cannot preallocate above that threshold. 
> > > > > 
> > > > > One applicable situation is, when there are 800M anonymous memory,
> > > > > but only 500M image_size and no swap space.
> > > > > 
> > > > > In that case we will otherwise goto the oom code path. Sure oom is
> > > > > (and shall be) reliably disabled in hibernation, but still we shall be
> > > > > cautious enough not to create a low memory situation, which will hurt:
> > > > > - hibernation speed
> > > > >   (vmscan goes mad trying to squeeze the last free page)
> > > > > - user experiences after resume
> > > > >   (all *active* file data and metadata have to reloaded)
> > > > 
> > > > Strangely enough, my recent testing with this patch doesn't confirm the
> > > > theory. :-)  Namely, I set image_size too low on purpose and it only caused
> > > > preallocate_image_memory() to return NULL at one point and that was it.
> > > > 
> > > > It didn't even took too much time.
> > > > 
> > > > I'll carry out more testing to verify this observation.
> > > 
> > > I can confirm that even if image_size is below the minimum we can get,
> > 
> > Which minimum please?
> 
> That was supposed to be an alternative way of saying "below any reasonable
> value", but it wasn't very precise indeed.
> 
> I should have said that for given system there was a minimum number of saveable
> pages that hibernate_preallocate_memory() leaved in memory and it just couldn't
> go below that limit.  If image_size is set below this number, the
> preallocate_image_memory(max_size - size) call returns fewer pages that it's
> been requested to allocate and that's it.  No disasters, no anything wrong.

"preallocate_image_memory(max_size - size) returning fewer pages"
would better be avoided, and possibly can be avoided by checking
hard_core_working_set(), right?

> > > the second preallocate_image_memory() just returns after allocating fewer pages
> > > that it's been asked for (that's with the original __GFP_NO_OOM_KILL-based
> > > approach, as I wrote in the previous message in this thread) and nothing bad
> > > happens.
> > >
> > > That may be because we freeze the mm kernel threads, but I've also tested
> > > without freezing them and it's still worked the same way.
> > > 
> > > > > The current code simply tries *too hard* to meet image_size.
> > > > > I'd rather take that as a mild advice, and to only free
> > > > > "free+freeable-margin" pages when image_size is not approachable.
> > > > > 
> > > > > The safety margin can be totalreserve_pages, plus enough pages for
> > > > > retaining the "hard core working set".
> > > > 
> > > > How to compute the size of the "hard core working set", then?
> > > 
> > > Well, I'm still interested in the answer here. ;-)
> > 
> > A tough question ;-)
> > 
> > We can start with the following formula, this should be called *after*
> > the initial memory shrinking.
> 
> OK
> 
> > /* a typical desktop do not have more than 100MB mapped pages */
> > #define MAX_MMAP_PAGES  (100 << (20 - PAGE_SHIFT))
> > unsigned long hard_core_working_set(void)
> > {
> >         unsigned long nr;
> > 
> >         /*
> >          * mapped pages are normally small and precious,
> >          * but shall be bounded for safety.
> >          */
> >         nr = global_page_state(NR_FILE_MAPPED);
> >         nr = min_t(unsigned long, nr, MAX_MMAP_PAGES);
> > 
> >         /*
> >          * if no swap space, this is a hard request;
> >          * otherwise this is an optimization.
> >          * (the disk image IO can be much faster than swap IO)
> 
> Well, if there's no swap space at this point, we won't be able to save the
> image anyway, so this always is an optimization IMO. :-)

Ah OK. Do you think the anonymous pages optimization should be limited?

My desktop normally consumes 200-400MB anonymous pages, but when some
virtual machine is running, the anonymous pages can go beyond 1GB,
with mapped file pages go slightly beyond 100MB.

The image-write vs. swapout-write speeds should be equal, however the
hibernate tool may be able to compress the dataset.

The image-read will be much faster than swapin-read for *rotational*
disks. It may take more time to resume, however the user experiences
after completion will be much better.

I don't think "populating memory with useless data" would be a major
concern, since we already freed up half of the total memory. It's all
about the speed one can get back to work.

> 
> >          */
> >         nr += global_page_state(NR_ACTIVE_ANON);
> >         nr += global_page_state(NR_INACTIVE_ANON);
> > 
> >         /* hard (but normally small) memory requests */
> >         nr += global_page_state(NR_SLAB_UNRECLAIMABLE);
> >         nr += global_page_state(NR_UNEVICTABLE);
> >         nr += global_page_state(NR_PAGETABLE);
> > 
> >         return nr;
> > }
> 
> OK, thanks.
> 
> I'll create a separate patch adding this function and we'll see how it works.

OK, thanks!

btw, if the shrink_all_memory() functions cannot go away because of
performance problems, I can help clean it up.  (FYI: I happen to be
doing so just before you submitted this patchset.:)

Thanks,
Fengguang
