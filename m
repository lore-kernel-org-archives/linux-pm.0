From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCHv2 2/2] mm/page_poisoning.c: Allow for zero poisoning
Date: Fri, 29 Jan 2016 11:45:43 +0100
Message-ID: <20160129104543.GA21224@amd>
References: <1454035099-31583-1-git-send-email-labbott@fedoraproject.org>
 <1454035099-31583-3-git-send-email-labbott@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57165 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbcA2Kpz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jan 2016 05:45:55 -0500
Content-Disposition: inline
In-Reply-To: <1454035099-31583-3-git-send-email-labbott@fedoraproject.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laura Abbott <labbott@fedoraproject.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org

Hi!

> By default, page poisoning uses a poison value (0xaa) on free. If this
> is changed to 0, the page is not only sanitized but zeroing on alloc
> with __GFP_ZERO can be skipped as well. The tradeoff is that detecting
> corruption from the poisoning is harder to detect. This feature also
> cannot be used with hibernation since pages are not guaranteed to be
> zeroed after hibernation.

So... this makes kernel harder to debug for performance advantage...?
If so.. how big is the performance advantage?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
