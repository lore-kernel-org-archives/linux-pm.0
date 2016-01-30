From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCHv2 2/2] mm/page_poisoning.c: Allow for zero poisoning
Date: Sat, 30 Jan 2016 16:30:54 +0100
Message-ID: <20160130153053.GA4859@amd>
References: <1454035099-31583-1-git-send-email-labbott@fedoraproject.org>
 <1454035099-31583-3-git-send-email-labbott@fedoraproject.org>
 <20160129104543.GA21224@amd>
 <56ABDB4A.2040709@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35715 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756832AbcA3Pa5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 30 Jan 2016 10:30:57 -0500
Content-Disposition: inline
In-Reply-To: <56ABDB4A.2040709@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>
Cc: Laura Abbott <labbott@fedoraproject.org>, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org

Hi!

> >>By default, page poisoning uses a poison value (0xaa) on free. If this
> >>is changed to 0, the page is not only sanitized but zeroing on alloc
> >>with __GFP_ZERO can be skipped as well. The tradeoff is that detecting
> >>corruption from the poisoning is harder to detect. This feature also
> >>cannot be used with hibernation since pages are not guaranteed to be
> >>zeroed after hibernation.
> >
> >So... this makes kernel harder to debug for performance advantage...?
> >If so.. how big is the performance advantage?

> 
> The performance advantage really depends on the benchmark you are
> running.

You are trying to improve performance, so you should publish at least
one benchmark where it helps.

Alternatively, quote kernel build times with and without the
patch.

If it speeds kernel compile twice, I guess I may even help with
hibernation support. If it makes kernel compile faster by .00000034%
(or slows it down), we should probably simply ignore this patch.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
