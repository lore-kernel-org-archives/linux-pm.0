From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / hibernate: Move pm_init/pm_disk_init to
 late_initcall_sync
Date: Tue, 6 Oct 2015 16:42:13 +0200
Message-ID: <20151006144213.GB24518@xo-6d-61-c0.localdomain>
References: <1444093820-6934-1-git-send-email-wonhong.kwon@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58313 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbbJFOmT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2015 10:42:19 -0400
Content-Disposition: inline
In-Reply-To: <1444093820-6934-1-git-send-email-wonhong.kwon@lge.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wonhong Kwon <wonhongkwon@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, gunho.lee@lge.com, Wonhong Kwon <wonhong.kwon@lge.com>

On Tue 2015-10-06 10:10:20, Wonhong Kwon wrote:
> pm_init is being invoked by core_initcall and hibernate_image_size_init
> calculates preferred image size (image_size) based on total pages
> (totalram_pages). This totalram_pages can be modified during various
> initcall-s phase and this can cause miscalculated image_size.
> 
> For example, when CMA is being used, init_cma_reserved_pageblock tries
> to change the totalram_pages and this job is done during core_initcall.
> In order words, the totalram_pages doesn't take CMA reserved pages into
> account when image_size is calculated and it can be too small.
> 
> Move pm_init and pm_disk_init to late_initcall_sync so that it happens
> after all other initcall-s change the totalram_pages.

Hmm, someone else hit same (similar) problem, but had way more complex solution.

So it is nice this is easy.

But is it enough? Can CMA be modular? Can CMA allocate memory after boot?

THanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
