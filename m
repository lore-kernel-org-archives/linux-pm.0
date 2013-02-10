From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Getting rid of freezer for suspend [was Re: [fuse-devel]
 [PATCH] fuse: make fuse daemon frozen along with kernel threads]
Date: Sun, 10 Feb 2013 19:55:05 +0100
Message-ID: <20130210185504.GA17268@amd.pavel.ucw.cz>
References: <1360113112.17267.1.camel@fli24-HP-Compaq-8100-Elite-CMT-PC>
 <20130210103344.GA8888@amd.pavel.ucw.cz>
 <3538583.NDAkGLdQOZ@vostro.rjw.lan>
 <3938124.8eafYb16IB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44888 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756010Ab3BJSzH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 Feb 2013 13:55:07 -0500
Content-Disposition: inline
In-Reply-To: <3938124.8eafYb16IB@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Goswin von Brederlow <goswin-v-b@web.de>, Li Fei <fei.li@intel.com>, len.brown@intel.com, mingo@redhat.com, peterz@infradead.org, biao.wang@intel.com, linux-pm@vger.kernel.org, fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com

Hi!

> > > > The whole memory shrinking we do for hibernation is now done by allocating
> > > > memory, so the freezer is not necessary for *that* and there's *zero*
> > > > difference between suspend and hibernation with respect to why the freezer is
> > > > used.
> > > 
> > > Funny. Freezer was put there so that hibernation image was safe to
> > > write out. You need disk subsystems in workable state for hibernation.
> > 
> > I'm not really sure what you're talking about.  Why do you think the freezer is
> > necessary for that?

Well, from freezer you need:

1) user process frozen.

2) essential locks _not_ held so that block devices are still functional.

> > > mmap... what is problem with mmap? For suspend, memory is powered, so
> > > you can permit people changing it.
> > 
> > Suppose mmap is used to make the registers of some device available to user
> > space.  Yes, that can happen.

"Don't do it, then". Yes, can happen, but hopefully is not too common
these days. [And... freezer doing 1) but not 2) would be enough to
handle that. Freezer doing 1) but not 2) would also be simpler...]

> > Again, I'm not sure what you're talking about.  Once the image has been
> > created, it can be saved while user space is running just fine.
> 
> Of course, we don't want random changes to be made to persistent storage after
> the image has been created, because those changes might not be consistent with
> the memory contents stored in the image, and that's why user space is still
> frozen when we're saving the image.

Yes. That's the reason 1) for freezer.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
