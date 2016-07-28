From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][v6] PM / hibernate: Introduce test_resume mode for
 hibernation
Date: Thu, 28 Jul 2016 21:32:06 +0200
Message-ID: <20160728193206.GC8837@amd>
References: <1469154647-5860-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48928 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756713AbcG1TcL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2016 15:32:11 -0400
Content-Disposition: inline
In-Reply-To: <1469154647-5860-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mail List <linux-kernel@vger.kernel.org>

On Fri 2016-07-22 10:30:47, Chen Yu wrote:
> test_resume mode is to verify if the snapshot data
> written to swap device can be successfully restored
> to memory. It is useful to ease the debugging process
> on hibernation, since this mode can not only bypass
> the BIOSes/bootloader, but also the system re-initialization.
> 
> To avoid the risk to break the filesystm on persistent storage,
> this patch resumes the image with tasks frozen.
> 
> For example:
> echo test_resume > /sys/power/disk
> echo disk > /sys/power/state
> 
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

(And yes, I'd still like documentation patch for this, but that can be
done in separate patch.)

Thanks,
								Pavel
								
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
