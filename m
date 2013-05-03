From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 03/10] freezer: add new freezable helpers using
 freezer_do_not_count()
Date: Fri, 3 May 2013 10:18:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1305031017030.1513-100000@iolanthe.rowland.org>
References: <20130503040934.GA16968@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54948 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1762307Ab3ECOSS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 10:18:18 -0400
In-Reply-To: <20130503040934.GA16968@mtj.dyndns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Colin Cross <ccross@android.com>, Linux PM list <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Oleg Nesterov <oleg@redhat.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jeff Layton <jlayton@redhat.com>, Mandeep Baines <msb@chromium.org>

On Thu, 2 May 2013, Tejun Heo wrote:

> Combined with the locking problems, I was planning to update the
> freezer such that the frozen state is implemented as a form of jobctl
> stop, so that things like ptrace / kill -9 could work on them and we
> also have the clear definition of the frozen state rather than the
> current "it may get stuck somewhere in the kernel".
> 
> But that conflicts with what you're doing here which seems pretty
> useful, so, to satisfy both goals, when somebody needs to put a
> pseudo-frozen task into the actual frozen jobctl stop, those spots
> which are currently using try_to_stop() would have to return an error,
> most likely -EINTR with TIF_SIGPENDING set, and the control should
> return towards userland so that signal handling path can be invoked.
> ie. It should be possible to steer the tasks which are considered
> frozen but not in the frozen jobctl stop into the jobctl stop without
> any side effect.  To do that, those spots basically have to be pretty
> close to the userland boundary where it can easily leave the kernel
> with -EINTR and AFAICS all the spots that you converted are like that
> (which I think is natural).  While not holding any locks doesn't
> guarantee that, I think there'd be a fairly high correlation at least
> and it'd be able to drive people towards finding out what's going on.

Don't forget about freezable kernel threads.  They never cross the 
kernel/user boundary.

Alan Stern

