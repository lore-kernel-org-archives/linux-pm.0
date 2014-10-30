From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / Hibernate: Migrate to ktime_t
Date: Thu, 30 Oct 2014 19:18:29 +0100
Message-ID: <20141030181829.GB14412@amd>
References: <20141030180453.GA55907@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54523 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759304AbaJ3SSb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Oct 2014 14:18:31 -0400
Content-Disposition: inline
In-Reply-To: <20141030180453.GA55907@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tina Ruchandani <ruchandani.tina@gmail.com>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, opw-kernel@googlegroups.com, rjw@rjwysocki.net

On Thu 2014-10-30 11:04:53, Tina Ruchandani wrote:
> This patch migrates swsusp_show_speed and its callers to using ktime_t instead
> of 'struct timeval' which suffers from the y2038 problem.
> 
> Changes to swsusp_show_speed:
>         - use ktime_t for start and stop times
>         - pass start and stop times by value
> Calling functions affected:
>         - load_image
>         - load_image_lzo
>         - save_image
>         - save_image_lzo
>         - hibernate_preallocate_memory
> Design decisions:
>         - use ktime_t to preserve same granularity of reporting as before
>         - use centisecs logic as before to avoid 'div by zero' issues caused by
>           using seconds and nanoseconds directly
>         - use monotonic time (ktime_get()) since we only care about elapsed time.
> 
> Signed-off-by: Tina Ruchandani <ruchandani.tina@gmail.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Pavel Machek <pavel@ucw.cz> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
