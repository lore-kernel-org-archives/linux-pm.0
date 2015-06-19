From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 19 Jun 2015 11:09:55 +1000
Message-ID: <20150619010955.GL20262@dastard>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
 <20150514092251.6d0625af@notabene.brown>
 <20150514235426.GF4316@dastard>
 <3798672.EXej90jOp1@vostro.rjw.lan>
 <CACVXFVMEwOSeP8FM89E4XZPUhDsP6bfeCGmJDK1i5kKs-3MCDg@mail.gmail.com>
 <CAJZ5v0gvDCwXWc5aAU7dGDsC=8ZbGBhQHgPkP92W=+Z7-v_2wA@mail.gmail.com>
 <20150515113557.54ef930b@lxorguk.ukuu.org.uk>
 <20150518115727.72439610@notabene.brown>
 <CAJvTdKn_0EZ0ZuqO2e4+ExD8kFWcy78fse4zHr3uFZODOroXEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:25128 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751467AbbFSBKL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 21:10:11 -0400
Content-Disposition: inline
In-Reply-To: <CAJvTdKn_0EZ0ZuqO2e4+ExD8kFWcy78fse4zHr3uFZODOroXEg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: NeilBrown <neilb@suse.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rafael@kernel.org>, Ming Lei <tom.leiming@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Thu, Jun 18, 2015 at 02:14:31AM -0400, Len Brown wrote:
> On Sun, May 17, 2015 at 9:57 PM, NeilBrown <neilb@suse.de> wrote:
> > On Fri, 15 May 2015 11:35:57 +0100 One Thousand Gnomes
> > <gnomes@lxorguk.ukuu.org.uk> wrote:
> >
> >> > > Data loss may be caused for hotplug storage(like USB), or all storage
> >> > > when power is exhausted during suspend.
> >> >
> >> > Which also may very well happen at run time, right?
> >>
> >> Intuitively users treat "suspended" as a bit like off and do remove
> >> devices they've "finished with".
> >>
> >> Technically yes the instant off/on on a phone is the same as the suspend
> >> to RAM on a laptop but it doesn't mean the model in people's heads is the
> >> same... not yet anyway.
> >>
> >> > > Is there obvious advantage to remove sys_sync() in the case?
> >> >
> >> > Yes, there is.  It is not necessary to sync() every time you suspend
> >> > if you do that very often.
> >>
> >> But if you do it very often you won't have any dirty pages to flush so it
> >> will be very fast.
> >
> > Several people have said things like this, and yet Len clearly saw a problem
> > so sometimes it isn't as fast as you think it should be.  I guess we need
> > some data.
> >
> > In fact there seem to be a number of open questions:
> >
> > 1/ Len has seen enough delays to bother sending a patch.  Twice.  Lots of
> >    other people claim there shouldn't be much delay.
> >
> >    Len: can you provide numbers?  How long does the sys_sync take
> >    (min/max/mean....).  I think an interesting number would be in a quick
> >    "resume, do something, suspend" cycle, what percent of the time is spent
> >    in sys_sync.
> >    Maybe also report what filesystems are in use, and whether you expect
> >    there to be any dirty data.
> >
> >    If I run "time sync; time sync; time sync" it reports about 50msec for
> >    each sync.  If I run "time sleep 0; time sleep 0; time sleep 0" it reports
> >    about 2 msec.  So sys_sync is taking at least 50msec.
> >    Almost all of that is in sync_inodes_sb() and much of that is in
> >    _raw_spin_lock.... though I might be misinterpreting perf.  It seems to
> >    wait for a BDI flusher thread to go off and do nothing.
> >
> >    Len: is 50msec enough to bother you?
> 
> 50ms is not acceptable.
> 5ms is also not acceptable.
> 
> If it were guaranteed to be under 1ms, it would not behigh  on my
> "performance pain" list, but I would still require the option
> to delete it entirely.
> 
> But sys_sync time is random on  many systems,
> with a very large maximum duration.
> 
> Attached is the output from analyze_suspend.py -x2
> on a desktop machine, which has just an inexpensive SSD for storage.
> It is a fresh install of Fedora 22 with a stock 4.0.4-301 kernel
> with no tweaks.

More information required. Mounted filesystems, mount options, etc
at minimum so we have some idea of what is being synced. We don't
even know what filesystem you are using....

> The 1st suspend starts with a sync that takes 6.6ms
> But the 2nd suspend starts with a sync that takes 451.8ms

The graph posted just has a single box labelled "sync_filesystems"
with no other information about what is actually taking that time.
We need to know what is consuming all that time *inside*
sync_filesystems() to make any progress here.

> So the reasoning that subsequent sys_sync's should be instantly quick
> because they are following a previous sys_sync is found to be simply
> erroneous by observations such as this.

Which indicates that either the system is not idle as expected, or
there's some kind of bug in one of the filesystems that is being
synced.

But we can't do any analysis of the problem you are seeing if the
only information you give us "it takes too long".  Something like a
function trace that tells use exactly what functions are being
called and how long they take to execute would be really handy
here.

Alternatively, you don't need to suspend to test this - just run a
test program on an idle system that does two sync() calls 50ms apart
and see what happens. If you can't reproduce it outside of a suspend
operation, then we need to look at what suspend is actually causing
to be dirtied in those 50ms.

If you can reproduce it, you can then even narrow down the
filesystem that is causing the problem by using syncfs() instead of
sync() to test the filesystems one at a time, and once you've done
that take a writeback event trace so we can see exactly what
inodes/data is being written back, and hence identify what the first
sync is not cleaning.

FWIW, I'd also suggest trying the changes to the sync code here:

git://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git superblock-scaling

As they avoid the need for sync to walk all the cached inodes
in the system needlessly and so should reduce the CPU overhead of
sys_sync() quite substantially.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
