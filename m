From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Wed, 4 Jul 2007 10:57:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707041045150.25704-100000__44102.9288959273$1183561078$gmane$org@netrider.rowland.org>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
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

On Wed, 4 Jul 2007, Paul Mackerras wrote:

> Alan Stern writes:
> 
> > I disagree.  The problem isn't the kernel calling userspace; it's
> > userspace trying to do I/O at a time when everything is supposed to be
> > quiescing.  Detecting that and blocking it in drivers is hard and
> > error-prone; preventing it by freezing userspace is easy and cheap.
> 
> And unreliable, and prone to deadlocks, and invasive - requiring
> changes to kernel threads that have nothing to do with drivers or
> suspend/resume.

Let's agree the kernel threads and the freezer are a separate issue.  
In the most recent kernels, the freezer does not suspend kernel threads 
by default.

I agree the kernel threads which try to do I/O during a suspend will 
need extra attention.  However if these threads are necessary for the 
suspend procedure, then blocking them (which is how people on this 
thread have been saying driver should treat I/O requests during a 
suspend) will cause additional problems.  There's no way around it; 
these threads _will_ require more work.

> > The reasons why the PPC people dislike the whole idea aren't clear to
> > me. 
> 
> Our experience is that it isn't necessary.  It's extra code that in
> practice causes deadlocks and added maintenance burden for no
> discernable benefit.

I have discussed the benefits elsewhere.  As for the deadlocks -- do 
you still observe them if you use the version of the freezer which 
doesn't freeze kernel threads?

> The freezer doesn't achieve its stated goal of preventing drivers from
> getting I/O requests after suspend, since kernel threads can (and do)
> initiate I/O.  So then we say that some kernel threads need to be
> frozen and others don't, but making that decision is difficult and
> error-prone.

No -- we say that the kernel threads which generate I/O requests during 
suspend need to be changed.

> In fact I believe that making a distinction between user and kernel
> threads is wrong and likely to lead to problems, since userspace can
> be involved in doing I/O (e.g. FUSE or the user-space driver
> framework).  So the argument of the previous paragraph also applies to
> some userspace processes.

Userspace cannot do I/O directly on its own, apart from some
exceptional situations where a privileged task directly twiddles some
I/O ports or the equivalent.

There remains the problem of user tasks whose assistance is required to 
carry out some I/O (as with FUSE).  If the I/O can be deferred until 
after the resume, then there's no problem.  If the I/O can be carried 
out before the suspend, then it should be.  And finally, if the I/O 
must be done during the suspend, you're in real trouble -- how do you 
do I/O to a suspended device?

> I remain convinced that the right approach is to fix the drivers to do
> one of two things; either do something in the suspend call to block
> further requests to the device, or use a late-suspend call to put
> their device into a low-power state.  Of course, correctly-written
> frameworks can do a lot to help the chipset drivers here.

The first alternative is a possibility.  My argument all along has been 
that it is difficult and error-prone, and it adds more overhead to 
system operation (even when not suspending!) than simply freezing 
userspace.

Alan Stern
