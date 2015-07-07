From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Tue, 7 Jul 2015 11:17:56 +1000
Message-ID: <20150707011756.GC3902@dastard>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
 <1496051.AgsebokWnB@vostro.rjw.lan>
 <20150706000614.GB3902@dastard>
 <1595559.BsCkcDEfNB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:1794 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751993AbbGGBSQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 21:18:16 -0400
Content-Disposition: inline
In-Reply-To: <1595559.BsCkcDEfNB@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alan Stern <stern@rowland.harvard.edu>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Mon, Jul 06, 2015 at 03:52:25PM +0200, Rafael J. Wysocki wrote:
> On Monday, July 06, 2015 10:06:14 AM Dave Chinner wrote:
> > On Sat, Jul 04, 2015 at 03:03:46AM +0200, Rafael J. Wysocki wrote:
> > > > No, your observation was that "sync is slow". Your *solution* is "we
> > > > need to remove sync".
> > > 
> > > Not only slow, but pointless too.  The argument goes: "It is slow and
> > > pointless and so it may be dropped."
> > > 
> > > Now, I can agree that it wasn't clearly demonstrated that the unconditional
> > > sys_sync() in the suspend code path was pointless, but it also has never
> > > been clearly shown why it is not pointless on systems that suspend and resume
> > > reliably.
> > 
> > I just gave you an example of why sync is needed: Suspend, pull out
> > USB drive when putting laptop in bag.
> 
> Exactly the same thing can happen while not suspended.  What does make suspend
> special with respect to that?

Stop being obtuse. If you remember that you need to pull the USB
stick before you suspend, then you damn well remember to "safely
eject" the USB stick and that syncs, unmounts and flushes the drive
caches before telling you it is safe to pull the stick.

> > > Moreover, question is if we really need to carry out the sync on *every*
> > > suspend even if it is not pointless overall.  That shouldn't really be
> > > necessary if we suspend and resume often enough or if we resume only for
> > > a while and then suspend again.  Maybe it should be rate limited somehow
> > > at least?
> > 
> > If you suspend and resume frequently, then the cost of the sync
> > shoul dbe negliable because the amount of data dirtied between
> > resume/suspend shoul dbe negliable. hence my questions about where
> > sync is spending too much time, and whether we've actually fixed
> > those problems or not. If sync speed on clean filesystems is a
> > problem then we need to fix sync, not work around it.
> 
> Well, say you never suspend, but you also only shut down the system when you
> need to replace the kernel on it.  How often would you invoke global sync on
> that system?

Never, because:

	- the kernel does background writeback of dirty data so you
	  don't need to run sync while the system is running; and
	- unmount during shutdown runs sync_filesystem() internally
	  (just like sys_sync does) to ensure the filesystem is
	  clean and no data is lost.

Seriously, stop being making ignorant arguments to justify removing
sys_sync(). *If* there's a problem sys_sync() we need to *fix it*,
not ignore it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
