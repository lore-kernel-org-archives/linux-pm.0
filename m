From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Mon, 6 Jul 2015 13:06:45 +0200
Message-ID: <20150706110645.GC381@amd>
References: <Pine.LNX.4.44L0.1507041011510.19175-100000@netrider.rowland.org>
 <2293886.L6VJGgjdDp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43989 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbbGFLGr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 07:06:47 -0400
Content-Disposition: inline
In-Reply-To: <2293886.L6VJGgjdDp@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Dave Chinner <david@fromorbit.com>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Mon 2015-07-06 01:28:20, Rafael J. Wysocki wrote:
> On Saturday, July 04, 2015 10:19:55 AM Alan Stern wrote:
> > On Sat, 4 Jul 2015, Rafael J. Wysocki wrote:
> > 
> > > The only argument against dropping sys_sync() from the suspend code path
> > > I've seen in this thread that I entirely agree with is that it may lead to
> > > regressions, because we've done it practically forever and it may hide latent
> > > bugs somewhere in block drivers etc.  Dropping it, though, is the only way
> > > to see those bugs, if any, and if we want to ever fix them, we need to see
> > > them.  That's why I think that it may be a good idea to allow people to
> > > drop it if they are willing to accept some extra risk (via the kernel
> > > command line, for example).
> > 
> > I'd be perfectly happy to have the sync selectable at runtime, one way 
> > or another.  The three most reasonable options seem to be:
> > 
> > 	kernel command line
> > 
> > 	sysfs file
> > 
> > 	sysctl setting
> > 
> > The command line is less flexible (it can't be changed after booting).  
> > Either of the other two would be fine with me.
> 
> We'll probably use a sysfs file (possibly plus a Kconfig option to set the
> boot time default).

Android people can already do sync-less s2ram using existing
interface. IMO they should just do it.

In any case, sysfs file + Kconfig is an overkill. We already have too
many Kconfig options.

There's not a single Android phone supported by mainline
kernel. I'm sure they have bigger problems than Android setting
default sysfs values...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
