From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Linux 3.7-rc3
Date: Tue, 30 Oct 2012 10:50:50 +0100 (CET)
Message-ID: <alpine.LRH.2.00.1210301048390.10392@twin.jikos.cz>
References: <CA+55aFwwTc4QXKqiECgE9NOE2zjC6GsGHHydGP9YDbgQSbw9Aw@mail.gmail.com> <26004880.qboZkUVCy9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45348 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755430Ab2J3JvB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Oct 2012 05:51:01 -0400
In-Reply-To: <26004880.qboZkUVCy9@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, 30 Oct 2012, Rafael J. Wysocki wrote:

> > Nothing particularly stands out here. Lots of small fixes, exemplified
> > by the series of memory leak fixes in usb serial drivers. Just a lot
> > of random stuff..
> > 
> > Most of it is drivers (all over: drm, wireless, staging, usb, sound),
> > but there's a few filesystem updates (nfs, btrfs, ext4), arch updates
> > (arm, x86 and m68k) and just random stuff. Shortlog appended.
> 
> Unfortunately, s2disk is broken with this one and previous -rc.  In the
> majority of cases it just hangs the machine during hibernation, although
> sometimes it returns to user space reporting freezing problems, suspicions
> RCU usage and similar stuff, pretty much without any useful debug information.
> 
> I'm quite confident that v3.6 was OK (and -stable based on that too), so
> it most likely is a recent regression.  The in-kernel hibernation
> (ie. "echo disk > /sys/power/state") works no problem.  So does suspend to
> RAM on my test boxes.
> 
> So far I have been able to reproduce this 100% of the time on two machines
> with Intel CPUs and graphics driven by i915.  I _suspect_ that this may be
> related to VT switching, because s2disk does some ugly things in that area
> which are not done by the in-kernel code.  Dunno.
> 
> Anyway, it looks like nothing short of bisection is going to help debug this,
> but I'm afraid I won't have the time to bisect within the next two weeks, so if
> anyone can reproduce this issue and will be able to bisect it, please help
> (openSUSE/Tumbleweed users anyone?).

Just a data point here -- this is probably not generally true.

I am using s2disk very often on my x200s, and I haven't hit this problem 
so far (currently running 2ab3f29, i.e. slightly before rc3).

-- 
Jiri Kosina
SUSE Labs

