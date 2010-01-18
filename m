From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Mon, 18 Jan 2010 22:06:36 +0100
Message-ID: <201001182206.36365.rjw__22826.2950121009$1263848900$gmane$org@sisk.pl>
References: <1263745267.2162.42.camel@barrios-desktop>
	<201001180125.59413.rjw@sisk.pl>
	<20100118111703.AE36.A69D9226@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100118111703.AE36.A69D9226@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 18 January 2010, KOSAKI Motohiro wrote:
> > Index: linux-2.6/mm/page_alloc.c
> > ===================================================================
> > --- linux-2.6.orig/mm/page_alloc.c
> > +++ linux-2.6/mm/page_alloc.c
> > @@ -1963,10 +1963,13 @@ __alloc_pages_nodemask(gfp_t gfp_mask, u
> >  	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, nodemask, order,
> >  			zonelist, high_zoneidx, ALLOC_WMARK_LOW|ALLOC_CPUSET,
> >  			preferred_zone, migratetype);
> > -	if (unlikely(!page))
> > +	if (unlikely(!page)) {
> > +		mm_lock_suspend(gfp_mask);
> >  		page = __alloc_pages_slowpath(gfp_mask, order,
> >  				zonelist, high_zoneidx, nodemask,
> >  				preferred_zone, migratetype);
> > +		mm_unlock_suspend(gfp_mask);
> > +	}
> >  
> >  	trace_mm_page_alloc(page, order, gfp_mask, migratetype);
> >  	return page;
> 
> I think we don't need read side lock at all. generally, no lock might makes race.
> But in this case, changing gfp_allowed_mask and nvidia suspend method should be
> serialized higher level. Why the above two code need to run concurrently?

The changing of gfp_allowed_mask is serialized with the suspend of devices,
so there's no concurrency here.

I was concerned about another problem, though, which is what happens if the
suspend process runs in parallel with a memory allocation that started earlier
and happens to do some I/O.  I that case the suspend process doesn't know
about the I/O done by the mm subsystem and may disturb it in principle.

That said, perhaps that should be a concern for the block devices subsystem to
prevent such situations from happening.

So, perhaps I'll remove the reader-side lock altogether and go back to
something like the first version of the patch.

Rafael
