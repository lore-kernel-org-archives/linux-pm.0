From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Thu, 5 Jul 2007 10:23:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707051014180.3728-100000__24074.0710324191$1183645750$gmane$org@iolanthe.rowland.org>
References: <18060.14856.824473.325660@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18060.14856.824473.325660@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kernel development list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 5 Jul 2007, Paul Mackerras wrote:

> Alan Stern writes:
> 
> > Let's agree the kernel threads and the freezer are a separate issue.  
> 
> No, I don't think they are a separate issue, because I think the
> distinction the freezer makes between kernel threads and user threads
> is a false and misleading distinction.

That's a little strong.  "Misleading" I could understand, but "false"?  
Isn't the distinction between a kernel thread and a user task pretty 
clear-cut (except for a few borderline cases which aren't at issue just 
now)?

> > I agree the kernel threads which try to do I/O during a suspend will 
> > need extra attention.  However if these threads are necessary for the 
> > suspend procedure, then blocking them (which is how people on this 
> > thread have been saying driver should treat I/O requests during a 
> > suspend) will cause additional problems.  There's no way around it; 
> > these threads _will_ require more work.
> 
> There is a way around it; do the request blocking in the drivers,
> where it belongs.

How will that help?  Block the kernel thread in the freezer or block it 
in the driver -- either way it is blocked.  So how do your deadlocks 
get resolved?

> In general the only way to guarantee there are no deadlocks is to
> construct the graph of dependencies between tasks.  Those dependencies
> are not in practice observable from outside the tasks, so it is
> virtually impossible to construct the graph.
> 
> The "don't freeze kernel threads" thing is an attempt to make a crude
> approximation to the dependency graph (by saying kernel threads only
> depend on other kernel threads), but the approximation breaks down
> when you have FUSE or user-level device drivers.

I disagree with your analysis -- not that it's completely wrong, but it 
points out an existing basic problem in the kernel.  The kernel should 
never depend on userspace!  More correctly, a task executing in the 
kernel should never block with any sort of mutex or other lock held (in 
a way that would preclude it from being frozen, let's say) while 
waiting for a response from userspace.

Then the dependency graph would be easy to construct: User tasks can
depend on whatever they want, and kernel threads never depend on a user
task.

If this contradicts the existing implementations and APIs for userspace 
filesystems, then so be it.  My conclusion would be that the 
implementations and APIs should be changed.

> > There remains the problem of user tasks whose assistance is required to 
> > carry out some I/O (as with FUSE).  If the I/O can be deferred until 
> > after the resume, then there's no problem.  If the I/O can be carried 
> > out before the suspend, then it should be.  And finally, if the I/O 
> > must be done during the suspend, you're in real trouble -- how do you 
> > do I/O to a suspended device?
> 
> So why doesn't that argument apply to kernel threads? :)

It _does_ apply to kernel threads.  That's exactly why I wrote above 
that kernel threads which try to do I/O during a suspend will need 
extra attention.

Alan Stern
