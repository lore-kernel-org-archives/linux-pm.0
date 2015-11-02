From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread freezer
Date: Mon, 02 Nov 2015 03:43:07 +0100
Message-ID: <2258525.D9qdTJBeTN@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1510301637310.1659-100000@iolanthe.rowland.org> <6015070.Gclh0s3EvS@vostro.rjw.lan> <alpine.LNX.2.00.1510310844360.17538@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1510310844360.17538@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, October 31, 2015 09:19:33 AM Jiri Kosina wrote:
> On Sat, 31 Oct 2015, Rafael J. Wysocki wrote:
> 
> > > > > > > I would say instead "no I/O is allowed from now on".  Maybe that's an 
> > > > > > > overstatement, but I think it comes closer to the truth.
> > > > > 
> > > > > But that's what PM callbacks are for.
> > 
> > Not really.  In fact, PM callbacks may not be suitable for some use cases even
> > in theory (that's if you want something to stop running before any PM callbacks
> > are executed during suspend).
> 
> If that's the case, wouldn't then it be better to have .pre_suspend 
> callback as well, instead of having to do this kind of polling?

If that's an individual driver's kthread, I guess it should be sufficient to
stop it from the .prepare callback.  If it is something more generic, creating
a device for it just in order to be able to execute a PM callback from there
may be slightly overkill.

But again, I'm not aware of any real cases like that, so it may not be an issue
in practice.

> > > > The most natural implementation would be for the callback routine to set 
> > > > a flag; at various strategic points the kthread would check the flag and 
> > > > if it was set, call a routine that sits around and waits for the suspend 
> > > > to be over.  
> > > 
> > > Could you name at least some existing kthreads that would actually *need* 
> > > such complex handling, instead of just waiting in schedule() until 
> > > suspend-resume cycle is over, given that PM callbacks do all the necessary 
> > > cleanup (putting HW to sleep, cancelling timers, etc) anyway?
> > > 
> > > PM callback can always explicitly do kthread_stop() on a particular 
> > > kthread if really necessary.
> > 
> > Runtime PM uses a freezable workqueue, allocated in pm_start_workqueue().
> 
> Yeah, agreed, as I said in the original mail, freezable workqueues I am 
> not covering for the moment, there might be a additional issues with them 
> compared to kthreads. That needs to be further looked into.

OK

> > > The main point of freezer is to reach quiescent state wrt. filesystems 
> > > (metadata in memory need to be absolutely in sync with what's on disk). 
> > > That's no different between hibernation and s2ram, is it?
> > > 
> > > BTW, a quite some of this has been already "pre-discussed" in 
> > > Documentation/power/freezing-of-tasks.txt (which has BTW been written 
> > > before we've had the possibility to freeze filesystems, and this fact is 
> > > even point there out).
> > 
> > That is somewhat outdated in my view.  At least my list of reasons for using
> > the freezer is now somewhat different from the one given in that file.
> 
> Well, so what is the list then, and how do you know that kthread_run() 
> users are behaving according to that list? That's basically exactly what 
> this effort is about -- making some sense out of current situation.

Currently, the #1 reason for using the freezer is to prevent user space
from interacting with devices during system suspend/resume.  BTW, that also
covers devices with runtime PM support, because the handling of user space
access to them in the runtime PM case may be different.

For example, if user space does a "read" or "write" on a character device
which is runtime-suspended at that point, the driver may want to resume the
device temporarily, carry out the operation and suspend it again, but that
generally won't work for the system suspend case.

Note that this applies to both system suspend (all variants of it for that
matter) and hibernation.

The #2 reason in my view is that essentially the freezer is what makes a
difference between runtime idle and system suspend on platforms without
firmware/hardware suspend support (or the lightweight variants of suspend
in general).  Namely, it effectively prevents user space from setting up
timers in the future and helps to reduce interrupt noise causing the CPUs
to leave deep low-power states too often (at least in some cases).

The #3 reason is to provide a way for things that might touch persistent
storage after a hibernation image had been created to prevent themselves from
running during that time.  Note that it also is a good idea to prevent such
things from running during system suspend/resume in general so they don't
try to access devices at wrong times.

BTW, the freezing of filesystems during system suspend (not hibernation) makes
sense too, because it will help to address the long-standing issue with storage
devices that go away while the system is suspended.

I guess it may also helps to address the case when a device is removed from a
suspended system, written to on another system in the meantime and inserted
back into the (still suspended) original system which then is resumed.  Today
this is an almost guaranteed data corruption scenario, but if the filesystem in
question is properly frozen during suspend, the driver should be able to detect
superblock changes during unfreeze.

So the approach I'd suggest would be to add the freezing of filesystems to the
suspend/resume code paths just for the above reasons and drop the kthreads
freezing from the filesystems that support the proper freezing.  The rest
should be easier to deal with then.

Thanks,
Rafael
