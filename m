From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/6] PM / Hibernate: Memory bitmap scalability
 improvements
Date: Sat, 19 Jul 2014 15:49:04 +0200
Message-ID: <20140719134904.GA2852@amd.pavel.ucw.cz>
References: <1405684643-30234-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40440 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900AbaGSNtH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 19 Jul 2014 09:49:07 -0400
Content-Disposition: inline
In-Reply-To: <1405684643-30234-1-git-send-email-joro@8bytes.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> These patches improve the data structure by adding a radix
> tree to the linked list structure to improve random access
> performance from O(n) to O(log_b(n)), where b depends on the
> architecture (b=512 on amd64, 1024 in i386).

Are you sure? From your other mail, you said you are adding just a
single page. I'd expect random access performance to go from

O(n) to O(n/1024) in such case?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
