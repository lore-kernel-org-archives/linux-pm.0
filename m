From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC v2] PM / Hibernate: Disable wathdog when creating
 snapshot
Date: Wed, 16 Aug 2017 22:33:02 +0800
Message-ID: <20170816143301.GA19921@yu-desktop-1.sh.intel.com>
References: <1502859218-13099-1-git-send-email-yu.c.chen@intel.com>
 <20170816123359.GC32161@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170816123359.GC32161@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 16, 2017 at 02:33:59PM +0200, Michal Hocko wrote:
> On Wed 16-08-17 12:53:38, Chen Yu wrote:
> [...]
> > @@ -2537,10 +2538,15 @@ void mark_free_pages(struct zone *zone)
> >  	unsigned long flags;
> >  	unsigned int order, t;
> >  	struct page *page;
> > +	bool wd_suspended;
> >  
> >  	if (zone_is_empty(zone))
> >  		return;
> >  
> > +	wd_suspended = lockup_detector_suspend() ? false : true;
> > +	if (!wd_suspended)
> > +		pr_warn_once("Failed to disable lockup detector during hibernation.\n");
> > +
> >  	spin_lock_irqsave(&zone->lock, flags);
> >  
> >  	max_zone_pfn = zone_end_pfn(zone);
> 
> I am not maintainer of this code so I am not very familiar with the full
> context of this function but lockup_detector_suspend is just too heavy
> for the purpose you are trying to achive. Really why don't you just
> poke the watchdog every N pages?
OK, I'll send another version.
Thanks,
	Yu
> -- 
> Michal Hocko
> SUSE Labs
