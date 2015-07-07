From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Tue, 07 Jul 2015 14:14:44 +0200
Message-ID: <1652992.e7VOEWpWyZ@vostro.rjw.lan>
References: <4290667.ZqInAykFGS@vostro.rjw.lan> <1595559.BsCkcDEfNB@vostro.rjw.lan> <20150707011756.GC3902@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55934 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752926AbbGGLsT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 07:48:19 -0400
In-Reply-To: <20150707011756.GC3902@dastard>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alan Stern <stern@rowland.harvard.edu>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Tuesday, July 07, 2015 11:17:56 AM Dave Chinner wrote:
> On Mon, Jul 06, 2015 at 03:52:25PM +0200, Rafael J. Wysocki wrote:
> > On Monday, July 06, 2015 10:06:14 AM Dave Chinner wrote:
> > > On Sat, Jul 04, 2015 at 03:03:46AM +0200, Rafael J. Wysocki wrote:
> > > > > No, your observation was that "sync is slow". Your *solution* is "we
> > > > > need to remove sync".
> > > > 
> > > > Not only slow, but pointless too.  The argument goes: "It is slow and
> > > > pointless and so it may be dropped."
> > > > 
> > > > Now, I can agree that it wasn't clearly demonstrated that the unconditional
> > > > sys_sync() in the suspend code path was pointless, but it also has never
> > > > been clearly shown why it is not pointless on systems that suspend and resume
> > > > reliably.
> > > 
> > > I just gave you an example of why sync is needed: Suspend, pull out
> > > USB drive when putting laptop in bag.
> > 
> > Exactly the same thing can happen while not suspended.  What does make suspend
> > special with respect to that?
> 
> Stop being obtuse.

Stop being rude.

> If you remember that you need to pull the USB
> stick before you suspend, then you damn well remember to "safely
> eject" the USB stick and that syncs, unmounts and flushes the drive
> caches before telling you it is safe to pull the stick.

All of that only means "the kernel needs to protect users from consequences
of silly mistakes" which I'm not sure I agree with.

For example, on desktop systems I use user space syncs filesystems before
writing to /sys/power/state, so the additional sys_sync() in the kernel doesn't
seem to serve any purpose.

> > > > Moreover, question is if we really need to carry out the sync on *every*
> > > > suspend even if it is not pointless overall.  That shouldn't really be
> > > > necessary if we suspend and resume often enough or if we resume only for
> > > > a while and then suspend again.  Maybe it should be rate limited somehow
> > > > at least?
> > > 
> > > If you suspend and resume frequently, then the cost of the sync
> > > shoul dbe negliable because the amount of data dirtied between
> > > resume/suspend shoul dbe negliable. hence my questions about where
> > > sync is spending too much time, and whether we've actually fixed
> > > those problems or not. If sync speed on clean filesystems is a
> > > problem then we need to fix sync, not work around it.
> > 
> > Well, say you never suspend, but you also only shut down the system when you
> > need to replace the kernel on it.  How often would you invoke global sync on
> > that system?
> 
> Never, because:
> 
> 	- the kernel does background writeback of dirty data so you
> 	  don't need to run sync while the system is running; and

OK, and that surely happens between suspend-resume cycles too, so why does
the sync in the suspend code path make a difference, really (except for
avoiding the consequences of possible user mistakes)?

> 	- unmount during shutdown runs sync_filesystem() internally
> 	  (just like sys_sync does) to ensure the filesystem is
> 	  clean and no data is lost.

And that still will be the case regardless of whether or not suspend is used.

> Seriously, stop being making ignorant arguments to justify removing
> sys_sync(). *If* there's a problem sys_sync() we need to *fix it*,
> not ignore it.

I'm not advocating for dropping the sys_sync().  I'd just have applied the Len's
patch had I thought that had been the way to go.

I'm not agreeing with your argumentation about why the sync is needed, though
(except for the one point that removing it might uncover some latent bugs).

For now, I've seen two arguments: the one about the possible latent bug (that
I agree with) and the one about how users may be hurt if they unplug storage
devices holding unmounted filesystems while suspended (which may be addressed
by a sync in user space just fine).  Are there any other reasons?

Rafael

