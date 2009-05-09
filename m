From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Sat, 9 May 2009 23:37:38 +0200
Message-ID: <200905092337.39906.rjw__28253.282295964$1241905359$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905090155.44635.rjw@sisk.pl>
	<alpine.DEB.2.00.0905091415310.1124@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.0905091415310.1124@chino.kir.corp.google.com>
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
To: David Rientjes <rientjes@google.com>
Cc: kernel-testers@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, Andrew Morton <akpm@linux-foundation.org>, fengguang.wu@intel.com, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 09 May 2009, David Rientjes wrote:
> On Sat, 9 May 2009, Rafael J. Wysocki wrote:
> 
> > > All of your tasks are in D state other than kthreads, right?  That means 
> > > they won't be in the oom killer (thus no zones are oom locked), so you can 
> > > easily do this
> > > 
> > > 	struct zone *z;
> > > 	for_each_populated_zone(z)
> > > 		zone_set_flag(z, ZONE_OOM_LOCKED);
> > > 
> > > and then
> > > 
> > > 	for_each_populated_zone(z)
> > > 		zone_clear_flag(z, ZONE_OOM_LOCKED);
> > > 
> > > The serialization is done with trylocks so this will never invoke the oom 
> > > killer because all zones in the allocator's zonelist will be oom locked.
> > 
> > Well, that might have been a good idea if it actually had worked. :-(
> > 
> > > Why does this not work for you?
> > 
> > If I set image_size to something below "hard core working set" +
> > totalreserve_pages, preallocate_image_memory() hangs the
> > box (please refer to the last patch I sent,
> > http://patchwork.kernel.org/patch/22423/).
> > 
> 
> This has been changed in the latest mmotm with Mel's page alloactor 
> patches (and I think yours should be based on mmotm).  Specifically, 
> page-allocator-break-up-the-allocator-entry-point-into-fast-and-slow-paths.patch.
> 
> Before his patchset, zonelists that had ZONE_OOM_LOCKED set for at least 
> one of their zones would unconditionally goto restart.  Now, if
> order > PAGE_ALLOC_COSTLY_ORDER, it gives up and returns NULL.  Otherwise, 
> it does goto restart.
> 
> So if your allocation has order > PAGE_ALLOC_COSTLY_ORDER,

It doesn't.  All of my allocations are of order 0.

> using the ZONE_OOM_LOCKED approach to locking out the oom killer will work
> just fine in mmotm.

No, it won't, AFAICT.

Best,
Rafael
