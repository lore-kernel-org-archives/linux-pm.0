From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Sat, 20 Jun 2015 09:07:20 +1000
Message-ID: <20150619230720.GB16870@dastard>
References: <3798672.EXej90jOp1@vostro.rjw.lan>
 <CACVXFVMEwOSeP8FM89E4XZPUhDsP6bfeCGmJDK1i5kKs-3MCDg@mail.gmail.com>
 <CAJZ5v0gvDCwXWc5aAU7dGDsC=8ZbGBhQHgPkP92W=+Z7-v_2wA@mail.gmail.com>
 <20150515113557.54ef930b@lxorguk.ukuu.org.uk>
 <20150518115727.72439610@notabene.brown>
 <CAJvTdKn_0EZ0ZuqO2e4+ExD8kFWcy78fse4zHr3uFZODOroXEg@mail.gmail.com>
 <20150619010955.GL20262@dastard>
 <CAJvTdKkJoSFUpBvCG0kEaTWti7EpPmficUxXZg49cb0QJD3A6w@mail.gmail.com>
 <20150619043147.GA16870@dastard>
 <CAJvTdKm15=+S4Y0mR+rzm8FOi2sfwGSqz9yiSh+GNcgMf85NxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:45394 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753557AbbFSXHd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 19:07:33 -0400
Content-Disposition: inline
In-Reply-To: <CAJvTdKm15=+S4Y0mR+rzm8FOi2sfwGSqz9yiSh+GNcgMf85NxQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: NeilBrown <neilb@suse.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rafael@kernel.org>, Ming Lei <tom.leiming@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Fri, Jun 19, 2015 at 02:34:37AM -0400, Len Brown wrote:
> > Can you repeat this test on your system, so that we can determine if
> > the 5ms ""sync time" is actually just the overhead of inode cache
> > traversal? If that is the case, the speed of sync on a clean
> > filesystem is already a solved problem - the patchset should be
> > merged in the 4.2 cycle....
> 
> Yes, drop_caches does seem to help repeated sync on this system:
> Exactly what patch series does this?  I'm running ext4 (the default,
> not btrfs)

None. It's the current behaviour of sync that is ends up walking the
inode cache in it's entirity to find dirty inodes that need to be
waited on. That's what the sync scalability patch series I pointed
you at fixes - sync then keeps a "dirty inodes that need to be
waited on list" instead of doing a cache traversal to find them.
i.e. the "no cache" results you see will soon be the behaviour sync
has regardless of the size of the inode cache.

> [lenb@d975xbx ~]$ sudo grep ext4_inode /proc/slabinfo
> ext4_inode_cache    3536   3536   1008   16    4 : tunables    0    0
>   0 : slabdata    221    221      0

That's actually a really small cache to begin with.

> > This is the problem we really need to reproduce and track down.
> 
> Putting a function trace on sys_sync and executing sync manually,
> I was able to see it take 100ms,
> though function trace itself could be contributing to that...

It would seem that way - you need to get the traces to dump to
something that has no sync overhead....

> running analyze_suspend.py after the slab tweak above didn't change much.
> in one run sync was 20ms (out of a total suspend time of 60ms).

Which may be because the inode cache was larger?

> Curiously, in another run, sync ran at 15ms, but sd suspend exploded to 300ms.
> I've seen that in some other results.  Sometimes sync if fast, but sd
> then more than makes up for it by being slow:-(

Oh, I see that too. Normally That's because the filesystem hasn't
been told to enter an idle state and so is doing metadata writeback
IO after the sync. When that happens the sd suspend has wait for
request queues to drain, IO to complete and device caches to flush.
This simply cannot be avoided because suspend never tells the
filesytems to enter an idle state....

i.e. remember what I said initially in this thread about suspend
actually needing to freeze filesystems, not just sync them?

> FYI,
> I ran analyze_suspend.py -x2
> from current directory /tmp, which is mounted on tmpfs,
> but still found the 2nd sync was very slow -- 200ms
> vs 6 - 20 ms for the sync preceding the 1st suspend.

So where did that time go? As I pointed out previously, function
trace will only tell us if the delay is data writeback or not. We
seem to have confirmed that the delay is, indeed, writeback of dirty
data. Now we need to identify what the dirty data belongs to: we
need to trace individual writeback events to see what dirty inodes
are actually being written.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
