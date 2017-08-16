From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH][RFC v2] PM / Hibernate: Disable wathdog when creating
 snapshot
Date: Wed, 16 Aug 2017 14:33:59 +0200
Message-ID: <20170816123359.GC32161@dhcp22.suse.cz>
References: <1502859218-13099-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1502859218-13099-1-git-send-email-yu.c.chen@intel.com>
Sender: owner-linux-mm@kvack.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed 16-08-17 12:53:38, Chen Yu wrote:
[...]
> @@ -2537,10 +2538,15 @@ void mark_free_pages(struct zone *zone)
>  	unsigned long flags;
>  	unsigned int order, t;
>  	struct page *page;
> +	bool wd_suspended;
>  
>  	if (zone_is_empty(zone))
>  		return;
>  
> +	wd_suspended = lockup_detector_suspend() ? false : true;
> +	if (!wd_suspended)
> +		pr_warn_once("Failed to disable lockup detector during hibernation.\n");
> +
>  	spin_lock_irqsave(&zone->lock, flags);
>  
>  	max_zone_pfn = zone_end_pfn(zone);

I am not maintainer of this code so I am not very familiar with the full
context of this function but lockup_detector_suspend is just too heavy
for the purpose you are trying to achive. Really why don't you just
poke the watchdog every N pages?
-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
