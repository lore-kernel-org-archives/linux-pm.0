From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread freezer
Date: Sat, 31 Oct 2015 04:15:25 +0100
Message-ID: <6015070.Gclh0s3EvS@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1510301637310.1659-100000@iolanthe.rowland.org> <alpine.LNX.2.00.1510302204280.17538@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1510302204280.17538@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, October 30, 2015 10:17:54 PM Jiri Kosina wrote:
> On Fri, 30 Oct 2015, Alan Stern wrote:
> 
> > > > > I would say instead "no I/O is allowed from now on".  Maybe that's an 
> > > > > overstatement, but I think it comes closer to the truth.
> > > 
> > > But that's what PM callbacks are for.

Not really.  In fact, PM callbacks may not be suitable for some use cases even
in theory (that's if you want something to stop running before any PM callbacks
are executed during suspend).

> > Why are PM callbacks any more suitable than the freezer?  
> 
> Once the PM callback triggers, you know that you are really actually 
> undergoing suspend and have to do whatever is necessary.
> 
> OTOH, try_to_freeze() is a kind of "are we there yet?" polling, and the 
> whole state needs to be prepared pro-actively for suspend already when you 
> call it, each and every time, even if you are not going through suspend at 
> all.
> 
> That's sub-optimal, and very easy to get wrong over gradual code changes.
> 
> > The most natural implementation would be for the callback routine to set 
> > a flag; at various strategic points the kthread would check the flag and 
> > if it was set, call a routine that sits around and waits for the suspend 
> > to be over.  
> 
> Could you name at least some existing kthreads that would actually *need* 
> such complex handling, instead of just waiting in schedule() until 
> suspend-resume cycle is over, given that PM callbacks do all the necessary 
> cleanup (putting HW to sleep, cancelling timers, etc) anyway?
> 
> PM callback can always explicitly do kthread_stop() on a particular 
> kthread if really necessary.

Runtime PM uses a freezable workqueue, allocated in pm_start_workqueue().

That's because we don't want async runtime PM to happen during system
suspend/resume and for good reasons, so if you want to remove the freezing
mechanism, you need to stop that workqueue at the beginning of dpm_prepare
and start it again at the end of dpm_complete().

> > Also, you never replied to my question about suspend vs. hibernation.
> 
> The main point of freezer is to reach quiescent state wrt. filesystems 
> (metadata in memory need to be absolutely in sync with what's on disk). 
> That's no different between hibernation and s2ram, is it?
> 
> BTW, a quite some of this has been already "pre-discussed" in 
> Documentation/power/freezing-of-tasks.txt (which has BTW been written 
> before we've had the possibility to freeze filesystems, and this fact is 
> even point there out).

That is somewhat outdated in my view.  At least my list of reasons for using
the freezer is now somewhat different from the one given in that file.

In any case, there may be legitimate reasons for kernel threads to be
freezable, so you need to be careful about the wholesale removal of that
feature.

The above is the only one I can recall ATM, but that doesn't mean there
aren't any other.

Thanks,
Rafael
