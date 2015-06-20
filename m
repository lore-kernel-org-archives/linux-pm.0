From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Sat, 20 Jun 2015 01:26:22 -0400
Message-ID: <CAJvTdKn1kJ=2knUnXgO+6iK6m7Ns6q1aLT2RCeERU5+gJnzmqw@mail.gmail.com>
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
	<20150619230720.GB16870@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:33175 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbbFTF0X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 20 Jun 2015 01:26:23 -0400
In-Reply-To: <20150619230720.GB16870@dastard>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: NeilBrown <neilb@suse.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rafael@kernel.org>, Ming Lei <tom.leiming@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

>> Putting a function trace on sys_sync and executing sync manually,
>> I was able to see it take 100ms,
>> though function trace itself could be contributing to that...
>
> It would seem that way - you need to get the traces to dump to
> something that has no sync overhead....

I don't think that ftrace buffers have sync overhead --
at least not until they are copied into files.

>> Curiously, in another run, sync ran at 15ms, but sd suspend exploded to 300ms.
>> I've seen that in some other results.  Sometimes sync if fast, but sd
>> then more than makes up for it by being slow:-(
>
> Oh, I see that too. Normally That's because the filesystem hasn't
> been told to enter an idle state and so is doing metadata writeback
> IO after the sync. When that happens the sd suspend has wait for
> request queues to drain, IO to complete and device caches to flush.
> This simply cannot be avoided because suspend never tells the
> filesytems to enter an idle state....

I captured a trace of a slow sd suspend.
Apparently, it does two operations -- first  a sync_cache,
then a stop operation.  The sync was fast.   The stop command
was where all the time went.

I'll look at a more modern drive on the same system next week,
just for comparison.

> i.e. remember what I said initially in this thread about suspend
> actually needing to freeze filesystems, not just sync them?

I think with the complexity of file systems and the underlying
devices, yes, we need to think about how to efficiently
and safely suspend/resume them.

But sys_sync is too expensive to have hard-coded in the kernel suspend path.
Some machines can suspend and resume in under 10ms -- they
absolutely do not want sys_sync() hard-coded in the suspend path.

>> FYI,
>> I ran analyze_suspend.py -x2
>> from current directory /tmp, which is mounted on tmpfs,
>> but still found the 2nd sync was very slow -- 200ms
>> vs 6 - 20 ms for the sync preceding the 1st suspend.
>
> So where did that time go? As I pointed out previously, function
> trace will only tell us if the delay is data writeback or not. We
> seem to have confirmed that the delay is, indeed, writeback of dirty
> data. Now we need to identify what the dirty data belongs to: we
> need to trace individual writeback events to see what dirty inodes
> are actually being written.

I expect that analyze_suspend.py is moving data around between
the back-to-back suspends when the -x2 option is used -- will look into it.

thanks,
Len Brown, Intel Open Source Technology Center
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
