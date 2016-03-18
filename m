From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Should suspend plug low-level devices?
Date: Fri, 18 Mar 2016 17:06:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1603181651400.1866-100000@iolanthe.rowland.org>
References: <20160318203242.GL20028@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33364 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754050AbcCRVGE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 17:06:04 -0400
In-Reply-To: <20160318203242.GL20028@mtj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, florian@mickler.org, jkosina@suse.cz, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Fri, 18 Mar 2016, Tejun Heo wrote:

> Whether something is running on kthread or workqueue doesn't make any
> difference.  Why would it?  It's about dependency chain, not what
> something is running on.
> 
> > > * Make block layer plug bio's from upper layers.
> > > 
> > > * Visit each freezable workqueue or kthread users and convert them to
> > >   plug explicitly.
> > 
> > How would this help the case in question?  If a workqueue is plugged 
> > instead of frozen, won't flush_delayed_work still deadlock?
> 
> By plugging and unplugging in a well defined order rather than
> "whatever comes first in workqueue or task lists".

The original problem here was that some unfreezable code was waiting
(via flush_delayed_work) on frozen code, and it was blocking the
routine that would unfreeze things.  Therefore the order of freezing or
thawing has no bearing on this particular problem.

This is an example of a dependency chain where finer-grained control of
freezing will not help.  And even if we moved the I/O plugging from the
high-level routines to the low-level drivers, we could still end up
with situations where something waiting for a plugged device driver was
blocking the code that would unplug it.

Now, I have nothing against finer-grained control of freezing, although
I'm not sure how you would implement it in cases where a kthread is not
per-device but rather is per-driver or per-subsystem.  But we will 
still have to handle inversions where unfreezable code is waiting for 
frozen code.

Alan Stern

