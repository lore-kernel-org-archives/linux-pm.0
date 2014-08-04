From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Hibernate: check unsafe page should not in e820
 reserved region
Date: Mon, 4 Aug 2014 15:08:11 +0200
Message-ID: <20140804130810.GA23098@amd.pavel.ucw.cz>
References: <1407148396-21405-1-git-send-email-jlee@suse.com>
 <s5hlhr4v32f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60338 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbaHDNIN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Aug 2014 09:08:13 -0400
Content-Disposition: inline
In-Reply-To: <s5hlhr4v32f.wl%tiwai@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>

> > +
> > +	list_for_each_entry(region, &nosave_regions, list) {
> > +		if (pfn >= region->start_pfn && pfn < region->end_pfn) {
> > +			pr_err("PM: %#010llx in e820 nosave regsion: "

And while looking at it, this should probably be spelled "region".
 
...plus maybe past part of changelog here into the comment?

Otherwise looks good to me, 

Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
