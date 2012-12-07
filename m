From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Race condition between driver_probe_device and device_shutdown
Date: Fri, 7 Dec 2012 10:25:59 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1212071023090.1565-100000@iolanthe.rowland.org>
References: <CACVXFVMOxQEJ-nrvGQ-PkevqKkLnXu+QjHgeswkbzFjqOVYCdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36606 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755097Ab2LGP0A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Dec 2012 10:26:00 -0500
In-Reply-To: <CACVXFVMOxQEJ-nrvGQ-PkevqKkLnXu+QjHgeswkbzFjqOVYCdQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux PM List <linux-pm@vger.kernel.org>

On Fri, 7 Dec 2012, Ming Lei wrote:

> > I guess the question is whether the callee is allowed to call
> > device_move(), if not, we're good.
> 
> Not only the callee, and other contexts can change device->parent
> too. Looks rfcomm_tty_open() which calls device_move() is called
> in open() context, so the parent might be changed before unlock(dev->parent)
> in __driver_attach().
> 
> >
> >> Your concern on device_remove() might be correct. Also, I am wondering
> >> if we can walk the 'dpm_list' backwards for device shutdown, which should
> >> be simpler and more reasonable.
> >
> > How would that help?
> 
> device_pm_lock() can prevent device_move() from being running.

That wouldn't prevent problems during unbinding.  Wedson is right; the 
places that lock dev->parent must save a local copy of dev->parent.

Alan Stern

