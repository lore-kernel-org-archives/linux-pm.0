From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread
 freezer
Date: Mon, 2 Nov 2015 11:45:47 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511021137310.22567@pobox.suse.cz>
References: <Pine.LNX.4.44L0.1510301637310.1659-100000@iolanthe.rowland.org> <6015070.Gclh0s3EvS@vostro.rjw.lan> <alpine.LNX.2.00.1510310844360.17538@pobox.suse.cz> <2258525.D9qdTJBeTN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40317 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbbKBKps (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Nov 2015 05:45:48 -0500
In-Reply-To: <2258525.D9qdTJBeTN@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, 2 Nov 2015, Rafael J. Wysocki wrote:

> > > > BTW, a quite some of this has been already "pre-discussed" in 
> > > > Documentation/power/freezing-of-tasks.txt (which has BTW been written 
> > > > before we've had the possibility to freeze filesystems, and this fact is 
> > > > even point there out).
> > > 
> > > That is somewhat outdated in my view.  At least my list of reasons for using
> > > the freezer is now somewhat different from the one given in that file.
> > 
> > Well, so what is the list then, and how do you know that kthread_run() 
> > users are behaving according to that list? That's basically exactly what 
> > this effort is about -- making some sense out of current situation.
> 
> Currently, the #1 reason for using the freezer is to prevent user space
> from interacting with devices during system suspend/resume.  BTW, that also
> covers devices with runtime PM support, because the handling of user space
> access to them in the runtime PM case may be different.
> 
> For example, if user space does a "read" or "write" on a character device
> which is runtime-suspended at that point, the driver may want to resume the
> device temporarily, carry out the operation and suspend it again, but that
> generally won't work for the system suspend case.

But why would this even be relevant in this discussion, given that at the 
point we are talking about, the whole userspace has been frozen already?

> The #2 reason in my view is that essentially the freezer is what makes a
> difference between runtime idle and system suspend on platforms without
> firmware/hardware suspend support (or the lightweight variants of suspend
> in general).  Namely, it effectively prevents user space from setting up
> timers in the future and helps to reduce interrupt noise causing the CPUs
> to leave deep low-power states too often (at least in some cases).

I am of course at all not trying to remove freezer for userspace. This 
whole discussion is solely about explicit usage of freezer in kthreads.

> The #3 reason is to provide a way for things that might touch persistent
> storage after a hibernation image had been created to prevent themselves from
> running during that time.  Note that it also is a good idea to prevent such
> things from running during system suspend/resume in general so they don't
> try to access devices at wrong times.
> 
> BTW, the freezing of filesystems during system suspend (not hibernation) makes
> sense too, because it will help to address the long-standing issue with storage
> devices that go away while the system is suspended.
> 
> I guess it may also helps to address the case when a device is removed from a
> suspended system, written to on another system in the meantime and inserted
> back into the (still suspended) original system which then is resumed.  Today
> this is an almost guaranteed data corruption scenario, but if the filesystem in
> question is properly frozen during suspend, the driver should be able to detect
> superblock changes during unfreeze.
> 
> So the approach I'd suggest would be to add the freezing of filesystems to the
> suspend/resume code paths just for the above reasons and drop the kthreads
> freezing from the filesystems that support the proper freezing.  The rest
> should be easier to deal with then.

That alone makes sense. It'll however leave a load of freezer users in the 
kernel that make no sense (one example picked completely out of the air: 
w1_process(); what is the reason for it there?) and are likely broken 
(completely random examples again: md, xfsaild -- they think they are 
freezable, but they are not).

Thanks,

-- 
Jiri Kosina
SUSE Labs

