From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / hibernate: Introduce snapshot test mode for
 hibernation
Date: Wed, 13 Jul 2016 12:21:56 +0200
Message-ID: <20160713102156.GA14505@atrey.karlin.mff.cuni.cz>
References: <1467873658-31986-1-git-send-email-yu.c.chen@intel.com>
 <20160713095005.GA27870@amd>
 <578615D5.3060501@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36094 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbcGMKV7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 06:21:59 -0400
Content-Disposition: inline
In-Reply-To: <578615D5.3060501@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org

Hi!

> On 2016???07???13??? 17:50, Pavel Machek wrote:
> >On Thu 2016-07-07 14:40:58, Chen Yu wrote:
> >>This mode is to verify if the snapshot data written to
> >>swap device can be successfully restored to memory. It
> >>is useful to ease the debugging process on hibernation,
> >>since this mode can not only bypass the BIOSen/bootloader,
> >>but also the system re-initialization.
> >>
> >>For example:
> >>$ sudo echo snapshot > /sys/power/disk
> >>$ sudo echo disk > /sys/power/state
> >>
> >>/* manual resume.*/
> >>$ sudo echo 8:3 > /sys/power/resume
> >Your examples will not work, will they?
> It works on my platform, although I did not tested it for too many
> rounds.

Please check again:

sudo echo disk > /sys/power/state
-bash: /sys/power/state: Permission denied

...because bash does the open, not echo.

> >This is also quite tricky/dangerous. If you do this with filesystems
> >mounted R/W, it is "good bye, filesystems".
> Ah, yes, this is quite tricky, maybe we can use this option as a
> debug method,
> for example, boot with rootfs = initrd, without mounting any disks,
> and then swapon the swap device, and do a testing. This should be safer?

Yeah, that's the way. Read-only root is other option.

> >I guess updating documentation would be welcome from my side,
> >otherwise it should be ok.
> OK, I'll  update the documents.

Just add fat warning into the documentation.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
