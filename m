From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH][RFC] PM / Hibernate: Feed NMI wathdog when creating
 snapshot
Date: Wed, 16 Aug 2017 13:17:32 +0200
Message-ID: <20170816111731.GA32161@dhcp22.suse.cz>
References: <1502731156-24903-1-git-send-email-yu.c.chen@intel.com>
 <20170815124119.GG29067@dhcp22.suse.cz>
 <20170815160107.GA2541@yu-desktop-1.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170815160107.GA2541@yu-desktop-1.sh.intel.com>
Sender: owner-linux-mm@kvack.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-mm@kvack.org, linux-pm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed 16-08-17 00:01:08, Chen Yu wrote:
> Hi Michal,
> On Tue, Aug 15, 2017 at 02:41:19PM +0200, Michal Hocko wrote:
[...]
> > Moreover why don't you need to touch_nmi_watchdog in the loop over all
> > pfns in the zone (right above this loop)?
> As the NMI was triggered when checking the free_list rather than in the loop over
> all pfns, it seems that the former has more possibility to catch a NMI if the
> latter has already taken too much time. But yes, a safer way is to feed dog
> in the latter too. I'll modify the code according to your suggestion.

This is a wrong approach IMHO. The whole thing has IRQ disabled.

-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
