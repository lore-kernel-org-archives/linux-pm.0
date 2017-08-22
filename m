From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][v2] PM / Hibernate: Feed the wathdog when creating snapshot
Date: Tue, 22 Aug 2017 15:18:08 +0200
Message-ID: <2871816.XzHRS8c6tY@aspire.rjw.lan>
References: <1503372002-13310-1-git-send-email-yu.c.chen@intel.com> <1595884.XH9dSsijkg@aspire.rjw.lan> <20170822131649.GL9729@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53307 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932791AbdHVN0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2017 09:26:42 -0400
In-Reply-To: <20170822131649.GL9729@dhcp22.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>, Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, August 22, 2017 3:16:50 PM CEST Michal Hocko wrote:
> On Tue 22-08-17 14:55:39, Rafael J. Wysocki wrote:
> [...]
> > And you may want to touch the watchdog at the end too in case
> > page_count is small then.
> 
> Why would that be needed? If the number of pages is slow then we will
> release the IRQ lock early and won't need to care about watchdog at all.
> 

Fair enough.
