From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Mon, 6 Jul 2015 12:03:57 +0200
Message-ID: <20150706100357.GA381@amd>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
 <20150508201310.5c4ccfaa@lxorguk.ukuu.org.uk>
 <CAJvTdKnoZhworj21Bsdt5ttGK+vQQ0tB_0-2Aok-rdsU8VvNkg@mail.gmail.com>
 <4290667.ZqInAykFGS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42798 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbbGFKD7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 06:03:59 -0400
Content-Disposition: inline
In-Reply-To: <4290667.ZqInAykFGS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alan Stern <stern@rowland.harvard.edu>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

Hi!

> > Understand, however, there are systems which suspend/resume reliably
> > many times per second, making policy choice of having the kernel hard-code
> > a sys_sync() into the suspend path a bad idea.
> 
> My current view on that is that whether or not to do a sync() before suspending
> ultimately is a policy decision and should belong to user space as such (modulo
> the autosleep situation when user space may not know when the suspend is going
> to happen).
> 
> Moreover, user space is free to do as many sync()s before suspending as it
> wants to and the question here is whether or not the *kernel* should sync()
> in the suspend code path.

sync()s from userspace do not work, as userspace is still running.

sync() from kernel happens with tasks stopped. ... so it should really
get consistent image on disk.

And there are already interfaces that can s2ram without sync, just use
uswsusp ioctls, not the sysfs writes.

If you are doing multiple suspends per second, a) you are doing
something wrong and b) you'd better use ioctl anyway.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
