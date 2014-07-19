From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/6] PM / Hibernate: Memory bitmap scalability
 improvements
Date: Sat, 19 Jul 2014 12:26:23 +0200
Message-ID: <20140719102623.GA837@amd.pavel.ucw.cz>
References: <1405684643-30234-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36902 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758166AbaGSK0Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 19 Jul 2014 06:26:25 -0400
Content-Disposition: inline
In-Reply-To: <1405684643-30234-1-git-send-email-joro@8bytes.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> here is a patch set to improve the scalability of the memory
> bitmap implementation used for hibernation. The current
> implementation does not scale well to machines with several
> TB of memory. A resume on those machines may cause soft
> lockups to be reported.
> 
> These patches improve the data structure by adding a radix
> tree to the linked list structure to improve random access
> performance from O(n) to O(log_b(n)), where b depends on the
> architecture (b=512 on amd64, 1024 in i386).
> 
> A test on a 12TB machine showed an improvement in resume
> time from 76s with the old implementation to 2.4s with the
> radix tree and the improved swsusp_free function. See below
> for details of this test.

Ok, nice.

How did space requirements change?

In particular, do we need to reserve a bit more pages for hibernation
now?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
