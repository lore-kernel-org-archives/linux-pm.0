From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC] PM / Hibernate: Feed NMI wathdog when creating
 snapshot
Date: Wed, 16 Aug 2017 12:53:21 +0800
Message-ID: <20170816045321.GA12984@yu-desktop-1.sh.intel.com>
References: <1502731156-24903-1-git-send-email-yu.c.chen@intel.com>
 <20170815124119.GG29067@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170815124119.GG29067@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, linux-pm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 15, 2017 at 02:41:19PM +0200, Michal Hocko wrote:
> On Tue 15-08-17 01:19:16, Chen Yu wrote:
> [...]
> > @@ -2561,8 +2562,10 @@ void mark_free_pages(struct zone *zone)
> >  			unsigned long i;
> >  
> >  			pfn = page_to_pfn(page);
> > -			for (i = 0; i < (1UL << order); i++)
> > +			for (i = 0; i < (1UL << order); i++) {
> >  				swsusp_set_page_free(pfn_to_page(pfn + i));
> > +				touch_nmi_watchdog();
> > +			}
> 
> this is rather excessive. Why don't you simply call touch_nmi_watchdog
> once per every 1000 pages? Or once per free_list entry?
> 
> Moreover why don't you need to touch_nmi_watchdog in the loop over all
> pfns in the zone (right above this loop)?
> --
After re-checking the code, I think we can simply disable the watchdog
temporarily, thus to avoid feeding the watchdog in the loop.
I'm sending another version based on this.
Thanks,
	Yu
> Michal Hocko
> SUSE Labs
