From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread
 freezer
Date: Sat, 31 Oct 2015 09:19:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1510310844360.17538@pobox.suse.cz>
References: <Pine.LNX.4.44L0.1510301637310.1659-100000@iolanthe.rowland.org> <alpine.LNX.2.00.1510302204280.17538@pobox.suse.cz> <6015070.Gclh0s3EvS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56733 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbbJaITg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 31 Oct 2015 04:19:36 -0400
In-Reply-To: <6015070.Gclh0s3EvS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org

On Sat, 31 Oct 2015, Rafael J. Wysocki wrote:

> > > > > > I would say instead "no I/O is allowed from now on".  Maybe that's an 
> > > > > > overstatement, but I think it comes closer to the truth.
> > > > 
> > > > But that's what PM callbacks are for.
> 
> Not really.  In fact, PM callbacks may not be suitable for some use cases even
> in theory (that's if you want something to stop running before any PM callbacks
> are executed during suspend).

If that's the case, wouldn't then it be better to have .pre_suspend 
callback as well, instead of having to do this kind of polling?

> > > The most natural implementation would be for the callback routine to set 
> > > a flag; at various strategic points the kthread would check the flag and 
> > > if it was set, call a routine that sits around and waits for the suspend 
> > > to be over.  
> > 
> > Could you name at least some existing kthreads that would actually *need* 
> > such complex handling, instead of just waiting in schedule() until 
> > suspend-resume cycle is over, given that PM callbacks do all the necessary 
> > cleanup (putting HW to sleep, cancelling timers, etc) anyway?
> > 
> > PM callback can always explicitly do kthread_stop() on a particular 
> > kthread if really necessary.
> 
> Runtime PM uses a freezable workqueue, allocated in pm_start_workqueue().

Yeah, agreed, as I said in the original mail, freezable workqueues I am 
not covering for the moment, there might be a additional issues with them 
compared to kthreads. That needs to be further looked into.

> > The main point of freezer is to reach quiescent state wrt. filesystems 
> > (metadata in memory need to be absolutely in sync with what's on disk). 
> > That's no different between hibernation and s2ram, is it?
> > 
> > BTW, a quite some of this has been already "pre-discussed" in 
> > Documentation/power/freezing-of-tasks.txt (which has BTW been written 
> > before we've had the possibility to freeze filesystems, and this fact is 
> > even point there out).
> 
> That is somewhat outdated in my view.  At least my list of reasons for using
> the freezer is now somewhat different from the one given in that file.

Well, so what is the list then, and how do you know that kthread_run() 
users are behaving according to that list? That's basically exactly what 
this effort is about -- making some sense out of current situation.

Thanks,

-- 
Jiri Kosina
SUSE Labs

