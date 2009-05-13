From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/6] mm,
 PM/Freezer: Disable OOM killer when tasks are frozen
Date: Wed, 13 May 2009 15:47:26 -0700
Message-ID: <20090513154726.0786a27d.akpm__33361.6330674433$1242254922$gmane$org@linux-foundation.org>
References: <200905070040.08561.rjw@sisk.pl> <200905101548.57557.rjw@sisk.pl>
	<200905131032.53624.rjw@sisk.pl> <200905131037.50011.rjw@sisk.pl>
	<alpine.DEB.2.00.0905131534530.25680@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.0905131534530.25680@chino.kir.corp.google.com>
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
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@lists.linux-foundation.org, fengguang.wu@intel.com
List-Id: linux-pm@vger.kernel.org

On Wed, 13 May 2009 15:35:32 -0700 (PDT)
David Rientjes <rientjes@google.com> wrote:

> On Wed, 13 May 2009, Rafael J. Wysocki wrote:
> 
> > Index: linux-2.6/mm/page_alloc.c
> > ===================================================================
> > --- linux-2.6.orig/mm/page_alloc.c
> > +++ linux-2.6/mm/page_alloc.c
> > @@ -175,6 +175,8 @@ static void set_pageblock_migratetype(st
> >  					PB_migrate, PB_migrate_end);
> >  }
> >  
> > +bool oom_killer_disabled __read_mostly;
> > +
> >  #ifdef CONFIG_DEBUG_VM
> >  static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
> >  {
> > @@ -1600,6 +1602,9 @@ nofail_alloc:
> >  		if (page)
> >  			goto got_pg;
> >  	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
> > +		if (oom_killer_disabled)
> > +			goto nopage;
> > +
> >  		if (!try_set_zone_oom(zonelist, gfp_mask)) {
> >  			schedule_timeout_uninterruptible(1);
> >  			goto restart;
> 
> This allows __GFP_NOFAIL allocations to fail.

I think that's OK - oom_killer_disable() and __GFP_NOFAIL are
fundamentally incompatible, and __GFP_NOFAIL is a crock.
