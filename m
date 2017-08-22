From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH][v2] PM / Hibernate: Feed the wathdog when creating
 snapshot
Date: Tue, 22 Aug 2017 15:16:50 +0200
Message-ID: <20170822131649.GL9729@dhcp22.suse.cz>
References: <1503372002-13310-1-git-send-email-yu.c.chen@intel.com>
 <1595884.XH9dSsijkg@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1595884.XH9dSsijkg@aspire.rjw.lan>
Sender: owner-linux-mm@kvack.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Chen Yu <yu.c.chen@intel.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>, Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue 22-08-17 14:55:39, Rafael J. Wysocki wrote:
[...]
> And you may want to touch the watchdog at the end too in case
> page_count is small then.

Why would that be needed? If the number of pages is slow then we will
release the IRQ lock early and won't need to care about watchdog at all.
-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
