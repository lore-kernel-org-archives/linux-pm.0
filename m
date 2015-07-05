From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Mon, 06 Jul 2015 01:28:20 +0200
Message-ID: <2293886.L6VJGgjdDp@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1507041011510.19175-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44980 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751311AbbGEXB4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jul 2015 19:01:56 -0400
In-Reply-To: <Pine.LNX.4.44L0.1507041011510.19175-100000@netrider.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dave Chinner <david@fromorbit.com>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Saturday, July 04, 2015 10:19:55 AM Alan Stern wrote:
> On Sat, 4 Jul 2015, Rafael J. Wysocki wrote:
> 
> > The only argument against dropping sys_sync() from the suspend code path
> > I've seen in this thread that I entirely agree with is that it may lead to
> > regressions, because we've done it practically forever and it may hide latent
> > bugs somewhere in block drivers etc.  Dropping it, though, is the only way
> > to see those bugs, if any, and if we want to ever fix them, we need to see
> > them.  That's why I think that it may be a good idea to allow people to
> > drop it if they are willing to accept some extra risk (via the kernel
> > command line, for example).
> 
> I'd be perfectly happy to have the sync selectable at runtime, one way 
> or another.  The three most reasonable options seem to be:
> 
> 	kernel command line
> 
> 	sysfs file
> 
> 	sysctl setting
> 
> The command line is less flexible (it can't be changed after booting).  
> Either of the other two would be fine with me.

We'll probably use a sysfs file (possibly plus a Kconfig option to set the
boot time default).

> > Moreover, question is if we really need to carry out the sync on *every*
> > suspend even if it is not pointless overall.  That shouldn't really be
> > necessary if we suspend and resume often enough or if we resume only for
> > a while and then suspend again.  Maybe it should be rate limited somehow
> > at least?
> 
> For example, skip the sync if the system has been awake for < 100 ms?

Yes, something like that.

> The cutoff time could also be controlled by the sysfs file: -1 =>
> never sync, 0 => always sync, > 0 => sync if the system has been awake 
> longer than the value.

That sounds like a good idea to me.

Thanks,
Rafael

