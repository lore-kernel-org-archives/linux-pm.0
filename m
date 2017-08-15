From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH][RFC] PM / Hibernate: Feed NMI wathdog when creating
 snapshot
Date: Tue, 15 Aug 2017 14:41:19 +0200
Message-ID: <20170815124119.GG29067@dhcp22.suse.cz>
References: <1502731156-24903-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55079 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751313AbdHOMlW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Aug 2017 08:41:22 -0400
Content-Disposition: inline
In-Reply-To: <1502731156-24903-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-mm@kvack.org, linux-pm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>

On Tue 15-08-17 01:19:16, Chen Yu wrote:
[...]
> @@ -2561,8 +2562,10 @@ void mark_free_pages(struct zone *zone)
>  			unsigned long i;
>  
>  			pfn = page_to_pfn(page);
> -			for (i = 0; i < (1UL << order); i++)
> +			for (i = 0; i < (1UL << order); i++) {
>  				swsusp_set_page_free(pfn_to_page(pfn + i));
> +				touch_nmi_watchdog();
> +			}

this is rather excessive. Why don't you simply call touch_nmi_watchdog
once per every 1000 pages? Or once per free_list entry?

Moreover why don't you need to touch_nmi_watchdog in the loop over all
pfns in the zone (right above this loop)?
-- 
Michal Hocko
SUSE Labs
