From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Sun, 10 May 2009 01:03:22 +0200
Message-ID: <200905100103.23815.rjw__1204.43033888495$1241911908$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905092337.39906.rjw@sisk.pl>
	<alpine.DEB.2.00.0905091536250.6272@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.0905091536250.6272@chino.kir.corp.google.com>
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

On Sunday 10 May 2009, David Rientjes wrote:
> On Sat, 9 May 2009, Rafael J. Wysocki wrote:
> 
> > > This has been changed in the latest mmotm with Mel's page alloactor 
> > > patches (and I think yours should be based on mmotm).  Specifically, 
> > > page-allocator-break-up-the-allocator-entry-point-into-fast-and-slow-paths.patch.
> > > 
> > > Before his patchset, zonelists that had ZONE_OOM_LOCKED set for at least 
> > > one of their zones would unconditionally goto restart.  Now, if
> > > order > PAGE_ALLOC_COSTLY_ORDER, it gives up and returns NULL.  Otherwise, 
> > > it does goto restart.
> > > 
> > > So if your allocation has order > PAGE_ALLOC_COSTLY_ORDER,
> > 
> > It doesn't.  All of my allocations are of order 0.
> > 
> 
> All order 0 allocations are implicitly __GFP_NOFAIL and will loop 
> endlessly unless they can't block.  So if you want to simply prohibit the 
> oom killer from being invoked and not change the retry behavior, setting 
> ZONE_OOM_LOCKED for all zones will do that.  If your machine hangs, it 
> means nothing can be reclaimed and you can't free memory via oom killing, 
> so there's nothing else the page allocator can do.

But I want it to give up in this case instead of looping forever.

Look.  I have a specific problem at hand that I want to solve and the approach
you suggested _clearly_ _doesn't_ _work_.  I have also tried to explain to you
why it doesn't work, but you're ingnoring it, so I really don't know what else
I can say.

OTOH, the approach suggested by Andrew _does_ _work_ regardless of your
opinion about it.  It's been tested and it's done the job 100% of the time.  Go
figure.  And please stop beating the dead horse.

Thanks,
Rafael
