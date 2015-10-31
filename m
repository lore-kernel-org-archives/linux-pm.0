From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread
 freezer
Date: Sat, 31 Oct 2015 11:56:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1510311125410.9118-100000@netrider.rowland.org>
References: <alpine.LNX.2.00.1510302204280.17538@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:36028 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751813AbbJaP4o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 31 Oct 2015 11:56:44 -0400
In-Reply-To: <alpine.LNX.2.00.1510302204280.17538@pobox.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, 30 Oct 2015, Jiri Kosina wrote:

> On Fri, 30 Oct 2015, Alan Stern wrote:
> 
> > > > > I would say instead "no I/O is allowed from now on".  Maybe that's an 
> > > > > overstatement, but I think it comes closer to the truth.
> > > 
> > > But that's what PM callbacks are for.
> > 
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

I think we are talking at cross purposes.  Your view of how a kthread 
works appears to be very different from mine.

Here's how I see it: A kthread performs some service, generally in a
big loop.  At certain points in that loop (perhaps only at the head),
the kthread will be in a suitable state for suspend: sufficiently
quiescent, no locks held, no I/O in progress, and so on.  At other
points, the kthread is not ready for suspend.

Therefore the fact that a PM callback tells you exactly when a supsend 
is about to occur is of no use.  The kthread can't act on that 
information directly, because most of the time it isn't ready for a 
suspend.  Only when it reaches one of its quiescent points will it be 
ready to do whatever is necessary -- which usually is nothing at all.

Given this picture, I don't see any alternative to a polling approach
of one kind or another.  At various quiescent points the kthread checks
to see if a suspend is imminent before moving forward.  At other times
the kthread can't handle suspend anyway, so it ignores the issue.  
This approach is exactly what try_to_freeze and friends support.

> > The most natural implementation would be for the callback routine to set 
> > a flag; at various strategic points the kthread would check the flag and 
> > if it was set, call a routine that sits around and waits for the suspend 
> > to be over.  
> 
> Could you name at least some existing kthreads that would actually *need* 
> such complex handling, instead of just waiting in schedule() until 
> suspend-resume cycle is over, given that PM callbacks do all the necessary 
> cleanup (putting HW to sleep, cancelling timers, etc) anyway?

Out of all the kthreads you modified in your patch 2/3, the only one
I'm familiar with is the one in f_mass_storage.c (the USB mass-storage
gadget driver).  That's kind of a special case, and I don't mind you
ripping out all the freezer stuff from it because its approach was
almost completely arbitrary all along.  AFAIK, we have never settled on
the right way for a USB gadget to handle system sleep.

Other cases I don't know about.  My argument is based on the general
analysis given above.  But consider one point: You said "instead of
just waiting in schedule() until suspend-resume cycle is over".  What
if, at the time of the PM callback, the kthread happens to be holding a
mutex that some driver needs to acquire while suspending?  If the
kthread just hops into schedule() and waits there, the suspend will
fail or deadlock.  This example shows that the situation is more
complicated than you make it appear.

> PM callback can always explicitly do kthread_stop() on a particular 
> kthread if really necessary.

Don't kthreads have to poll to find out when they need to stop?  How is 
that different from (or better than) polling to see when they need to 
freeze?

> > Also, you never replied to my question about suspend vs. hibernation.
> 
> The main point of freezer is to reach quiescent state wrt. filesystems 
> (metadata in memory need to be absolutely in sync with what's on disk). 
> That's no different between hibernation and s2ram, is it?

That was my point.  Since there's no difference, why did your patch 
talk about hibernation only, and not s2ram?

(Of course, some people like Len Brown have been arguing that for 
s2ram, the metadata in memory does _not_ need to be in sync with what's 
on disk.  I'm ignoring that for now, but such things would have to be 
taken into account when the final patch is written.)

Alan Stern

