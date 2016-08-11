From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 3/3] PM / hibernate: Recycle safe pages after image
 restoration
Date: Thu, 11 Aug 2016 23:06:15 +0200
Message-ID: <20160811210615.GA28618@amd>
References: <2260927.OOWMYX738E@vostro.rjw.lan>
 <2448424.sR3JM3oiG3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58152 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932444AbcHKVGW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Aug 2016 17:06:22 -0400
Content-Disposition: inline
In-Reply-To: <2448424.sR3JM3oiG3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi!

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> One of the memory bitmaps used by the hibernation image restoration
> code is freed after the image has been loaded.
> 
> That is not quite efficient, though, because the memory pages used
> for building that bitmap are known to be safe (ie. they were not
> used by the image kernel before hibernation) and the arch-specific
> code finalizing the image restoration may need them.  In that case
> it needs to allocate those pages again via the memory management
> subsystem, check if they are really safe again by consulting the
> other bitmaps and so on.
> 
> To avoid that, recycle those pages by putting them into the global
> list of known safe pages so that they can be given to the arch code
> right away when necessary.

Ok, so you are trying to gain speed here? How much is the speedup?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
