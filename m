From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / hibernate: Introduce snapshot test mode for
 hibernation
Date: Wed, 13 Jul 2016 19:01:23 +0200
Message-ID: <20160713170123.GA13546@amd>
References: <1467873658-31986-1-git-send-email-yu.c.chen@intel.com>
 <20160713095005.GA27870@amd>
 <578615D5.3060501@intel.com>
 <20160713102156.GA14505@atrey.karlin.mff.cuni.cz>
 <57861A70.9090606@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45948 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbcGMRBl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 13:01:41 -0400
Content-Disposition: inline
In-Reply-To: <57861A70.9090606@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org

Hi!

> >>and then swapon the swap device, and do a testing. This should be safer?
> >Yeah, that's the way. Read-only root is other option.
> >
> >>>I guess updating documentation would be welcome from my side,
> >>>otherwise it should be ok.
> >>OK, I'll  update the documents.
> >Just add fat warning into the documentation.
> OK.

Actually... If you could add

printk(KERN_ALERT "Hibernation image written. If you have any
filesystems mounted read-write and attempt to resume, you'll corrupt
your data. To prevent that, remove the hibernation image.\n")

...I guess that would save someone's filesystem. (Yes, very high
loglevel. If you attempt to do this from anything else then singleuser
or initrd, you are asking for problems, so... lets make sure user sees
it.)

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
