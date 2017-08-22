From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH] PM / Hibernate: Feed the wathdog when creating snapshot
Date: Tue, 22 Aug 2017 10:55:57 +0800
Message-ID: <20170822025557.GA11870@yu-desktop-1.sh.intel.com>
References: <1503328098-5120-1-git-send-email-yu.c.chen@intel.com>
 <20170821132600.c8a509bcacce123e3f51d989@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:17002 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754049AbdHVCyS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Aug 2017 22:54:18 -0400
Content-Disposition: inline
In-Reply-To: <20170821132600.c8a509bcacce123e3f51d989@linux-foundation.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Andrew,
On Mon, Aug 21, 2017 at 01:26:00PM -0700, Andrew Morton wrote:
> On Mon, 21 Aug 2017 23:08:18 +0800 Chen Yu <yu.c.chen@intel.com> wrote:
> 
> > There is a problem that when counting the pages for creating
> > the hibernation snapshot will take significant amount of
> > time, especially on system with large memory. Since the counting
> > job is performed with irq disabled, this might lead to NMI lockup.
> > The following warning were found on a system with 1.5TB DRAM:
> > 
> > ...
> > 
> > It has taken nearly 20 seconds(2.10GHz CPU) thus the NMI lockup
> > was triggered. In case the timeout of the NMI watch dog has been
> > set to 1 second, a safe interval should be 6590003/20 = 320k pages
> > in theory. However there might also be some platforms running at a
> > lower frequency, so feed the watchdog every 100k pages.
> > 
> > ...
> >
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2531,9 +2532,12 @@ void drain_all_pages(struct zone *zone)
> >  
> >  #ifdef CONFIG_HIBERNATION
> >  
> > +/* Touch watchdog for every WD_INTERVAL_PAGE pages. */
> > +#define WD_INTERVAL_PAGE	(100*1024)
> > +
> >  void mark_free_pages(struct zone *zone)
> >  {
> > -	unsigned long pfn, max_zone_pfn;
> > +	unsigned long pfn, max_zone_pfn, page_num = 0;
> >  	unsigned long flags;
> >  	unsigned int order, t;
> >  	struct page *page;
> > @@ -2548,6 +2552,9 @@ void mark_free_pages(struct zone *zone)
> >  		if (pfn_valid(pfn)) {
> >  			page = pfn_to_page(pfn);
> >  
> > +			if (!((page_num++) % WD_INTERVAL_PAGE))
> > +				touch_nmi_watchdog();
> > +
> >  			if (page_zone(page) != zone)
> >  				continue;
> >  
> > @@ -2561,8 +2568,11 @@ void mark_free_pages(struct zone *zone)
> >  			unsigned long i;
> >  
> >  			pfn = page_to_pfn(page);
> > -			for (i = 0; i < (1UL << order); i++)
> > +			for (i = 0; i < (1UL << order); i++) {
> > +				if (!((page_num++) % WD_INTERVAL_PAGE))
> > +					touch_nmi_watchdog();
> >  				swsusp_set_page_free(pfn_to_page(pfn + i));
> > +			}
> >  		}
> >  	}
> >  	spin_unlock_irqrestore(&zone->lock, flags);
> 
> hm, is it really worth all the WD_INTERVAL_PAGE stuff? 
> touch_nmi_watchdog() is pretty efficient and calling it once-per-page
> may not have a measurable effect.
>
We have version 1 of patch to feed the dog once-per-page. And we thought
it might look more elegant if we feed the dog every N pages.
> And if we're really concerned about the performance impact it would be
> better to make WD_INTERVAL_PAGE a power of 2 (128*1024?) to avoid the
> modulus operation.
> 
Ok, I'll change the interval to 128*1024 then.
Thanks,
	Yu
