From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Sat, 9 May 2009 15:39:56 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905091536250.6272__27415.2147504084$1241908931$gmane$org@chino.kir.corp.google.com>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905090155.44635.rjw@sisk.pl>
	<alpine.DEB.2.00.0905091415310.1124@chino.kir.corp.google.com>
	<200905092337.39906.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905092337.39906.rjw@sisk.pl>
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
Cc: kernel-testers@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, Andrew Morton <akpm@linux-foundation.org>, fengguang.wu@intel.com, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 9 May 2009, Rafael J. Wysocki wrote:

> > This has been changed in the latest mmotm with Mel's page alloactor 
> > patches (and I think yours should be based on mmotm).  Specifically, 
> > page-allocator-break-up-the-allocator-entry-point-into-fast-and-slow-paths.patch.
> > 
> > Before his patchset, zonelists that had ZONE_OOM_LOCKED set for at least 
> > one of their zones would unconditionally goto restart.  Now, if
> > order > PAGE_ALLOC_COSTLY_ORDER, it gives up and returns NULL.  Otherwise, 
> > it does goto restart.
> > 
> > So if your allocation has order > PAGE_ALLOC_COSTLY_ORDER,
> 
> It doesn't.  All of my allocations are of order 0.
> 

All order 0 allocations are implicitly __GFP_NOFAIL and will loop 
endlessly unless they can't block.  So if you want to simply prohibit the 
oom killer from being invoked and not change the retry behavior, setting 
ZONE_OOM_LOCKED for all zones will do that.  If your machine hangs, it 
means nothing can be reclaimed and you can't free memory via oom killing, 
so there's nothing else the page allocator can do.
