From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Should suspend plug low-level devices?
Date: Thu, 17 Mar 2016 14:51:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1603171433300.2097-100000@iolanthe.rowland.org>
References: <20160316163410.GJ6980@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53588 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753134AbcCQSvh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 14:51:37 -0400
In-Reply-To: <20160316163410.GJ6980@mtj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, florian@mickler.org, jkosina@suse.cz, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Wed, 16 Mar 2016, Tejun Heo wrote:

> Hello, Alan.
> 
> On Wed, Mar 16, 2016 at 11:37:35AM -0400, Alan Stern wrote:
> > Doing what you suggest would require a tremendous effort.  There are
> 
> I don't know.  Is it?
> 
> > lots and lots of drivers that have no provisions for plugging; they
> > would all need to be modified.  Changing the higher layers instead (to
> > prevent them from generating I/O requests during suspend) seems much
> > easier.
> 
> Big lock and "much easier" usually don't go together.  I get why we
> started out this way - there wasn't anything working and we didn't
> quite understand what the actual requirements were and wanted
> something more or less working with manageable amount of effort, but I
> think we're past the point where we need to address the issue
> properly.  The more complex drivers are already doing most of what's
> necessary and even for drivers which depend on the freezer the changes
> don't need to be too difficult.
> 
> Stopping kthreads in itself is fine but the problem is that we
> currently don't know who's stopping what.  Just making each freezing
> explicit, say, an explicit invocation of kthread_freeze_kthread(),
> wouldn't be that difficult and would go a long way.  e.g. It would
> immediately solve the problem arising from kthread freezing order not
> matching device dependency hierarchy.

We're talking about workqueues in particular.  Freezing order is not 
the issue.

The problem that started this discussion was that a block device can be
hot-unplugged while the system is asleep.  The device driver's resume
routine realizes the device is gone and unregisters it.  As part of the
unregistration, the block layer (bdi_unregister) does a
flush_delayed_work.

I'm not sure exactly what work it's trying to flush (the code is
difficult to follow), but evidently it can't go forward while the
system is still resuming.  Maybe the workqueue thread is frozen.

> > The original design of the PM subsystem was intended to make life
> > easier for drivers by minimizing the amount of work needed to support
> > suspend/resume.  Maybe the decision to do it that way was wrong, but
> > it's kind of late to change the design now.
> 
> Hmmm... but that's how most subsystems evolve.  We start out with
> something coarse and not quite optimal or even correct and then as we
> learn more, the code and design evolve.  I frankly don't think
> shifting to driver-side plugging would be *that* difficult.  It's
> gonna be quite a bit of work, for sure, but things can be gradual.
> For example,
> 
> * Make block layer plug bio's from upper layers.
> 
> * Visit each freezable workqueue or kthread users and convert them to
>   plug explicitly.

How would this help the case in question?  If a workqueue is plugged 
instead of frozen, won't flush_delayed_work still deadlock?

> > I foresee other kinds of problems, too.  Suppose after a suspend 
> > starts, some higher layer code creates an I/O request with a short 
> > timeout.  If the device weren't suspended the request would succeed -- 
> > should it time out and fail now that the system is going to sleep?  
> > That would make system sleep transitions non-transparent.
> 
> I can't see how freezing or not freezing would make any difference
> there.  What if a kthread gets frozen with with IOs in flight?  The
> timeouts would still trigger whether the issuer is frozen or not.  IO
> timeouts are mostly implemented in block layer and block layer just
> needs to handle it sensibly.

kthreads (including workqueues) get frozen at controlled places.  
Presumably they are smart enough not to allow themselves to be frozen
while any I/Os are in flight.

Alan Stern

