From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread
 freezer
Date: Fri, 30 Oct 2015 22:17:54 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1510302204280.17538@pobox.suse.cz>
References: <Pine.LNX.4.44L0.1510301637310.1659-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39774 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760560AbbJ3VR4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 30 Oct 2015 17:17:56 -0400
In-Reply-To: <Pine.LNX.4.44L0.1510301637310.1659-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, 30 Oct 2015, Alan Stern wrote:

> > > > I would say instead "no I/O is allowed from now on".  Maybe that's an 
> > > > overstatement, but I think it comes closer to the truth.
> > 
> > But that's what PM callbacks are for.
> 
> Why are PM callbacks any more suitable than the freezer?  

Once the PM callback triggers, you know that you are really actually 
undergoing suspend and have to do whatever is necessary.

OTOH, try_to_freeze() is a kind of "are we there yet?" polling, and the 
whole state needs to be prepared pro-actively for suspend already when you 
call it, each and every time, even if you are not going through suspend at 
all.

That's sub-optimal, and very easy to get wrong over gradual code changes.

> The most natural implementation would be for the callback routine to set 
> a flag; at various strategic points the kthread would check the flag and 
> if it was set, call a routine that sits around and waits for the suspend 
> to be over.  

Could you name at least some existing kthreads that would actually *need* 
such complex handling, instead of just waiting in schedule() until 
suspend-resume cycle is over, given that PM callbacks do all the necessary 
cleanup (putting HW to sleep, cancelling timers, etc) anyway?

PM callback can always explicitly do kthread_stop() on a particular 
kthread if really necessary.

> Also, you never replied to my question about suspend vs. hibernation.

The main point of freezer is to reach quiescent state wrt. filesystems 
(metadata in memory need to be absolutely in sync with what's on disk). 
That's no different between hibernation and s2ram, is it?

BTW, a quite some of this has been already "pre-discussed" in 
Documentation/power/freezing-of-tasks.txt (which has BTW been written 
before we've had the possibility to freeze filesystems, and this fact is 
even point there out).

Thanks,

-- 
Jiri Kosina
SUSE Labs

