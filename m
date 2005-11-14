From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: RE: Wakeup requests during a system sleep transition
Date: Mon, 14 Nov 2005 09:23:01 -0500
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DD4CD178@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============69326758293803481=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============69326758293803481==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8bit

We've been doing something like (a); basically, adding a flag that gets
set if a wakeup event occurs during the suspend process and checking it
at the end. This covers the case where the plumbing among the drivers
fails to catch the wakeup dependency (I think this is the same as Alan's
"some drivers don't bother to make this check").  

We're only doing suspend-in-place, though (no hard disk in the system),
so the sequence ends up being a little different. We're also doing this
with automatically initiated, rather than user-initiated, suspends, so
we have to deal with the problem of the system software (as opposed to
an external event) deciding to wake up after suspend has started but
before the suspend sequence has completed. 

scott 

-----Original Message-----
From: linux-pm-bounces@lists.osdl.org
[mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Alan Stern
Sent: Friday, November 11, 2005 8:54 PM
To: David Brownell
Cc: Linux-pm mailing list
Subject: Re: [linux-pm] Wakeup requests during a system sleep transition

On Fri, 11 Nov 2005, David Brownell wrote:

> On Tuesday 08 November 2005 11:43 am, Alan Stern wrote:
> > A question has come up recently in private conversations concerning 
> > remote wakeup requests arriving while a system sleep transition is
in progress.
> > How should they be handled?
> > 
> > There are at least three possibilities:
> > 
> >     (a) Carry out the wakeup request (i.e., resume the requesting
device)
> > 	and then abort the system sleep when the device's parent is told
> > 	to suspend and it sees that its children aren't all suspended.
> 
> This probably makes the most sense to me ...

Me too (as must have been obvious from the following comments).

> >     (b) Carry out the wakeup request, then sometime later try to
recover
> > 	by re-suspending the device that was just resumed, and continue
> > 	the sleep transition.
> > 
> >     (c) Ignore the wakeup request and proceed with the sleep
transition.
> > 
> > (a) is very simple and doesn't require any extra code, since drivers

> > should already be checking to make sure that all the children are 
> > suspended before suspending their devices.

I didn't mention this before, but it's possible that some drivers don't
bother to make this check.  We may want to do the checking in the PM
core instead -- whenever a resume request occurs while a sleep
transition is in progress, abort the sleep.

> >  When the sleep transition is
> > aborted, we can just return -ERESTARTSYS and force the user to try 
> > again
> > -- exactly the same as would happen with any other interrupted 
> > system call.
> 
> That is, it requires faults on suspend to be handled reasonably.
> Not a new requirement ... but quite possibly one that's not always 
> being satisfied.  And certainly one that's awkward to test.

Here's an easy way to test it.  In an appropriate driver's suspend
routine, add:

	printk(KERN_INFO "Delaying suspend -- do your stuff!\n");
	msleep(2000);

Then when that message pops up, you have two seconds to cause a wakeup
event.

> > (b) is not a good solution, IMO.  It involves a pretty hairy 
> > recovery scheme that's not well defined.  It runs the risk of 
> > leaving some devices unsuspended while suspending their parents, or 
> > leaving data structures out of sync with the actual hardware state.

> > Furthermore I don't see any advantage in making the kernel do the 
> > re-suspend over making userspace restart the entire sleep
transition, as in (a).
> 
> Although I'm not sure I'd see the point to having userspace try to 
> suspend again ... user said to wake up, after all!!

Right.  Although it may have been a coincidence.  Or something as silly
as a release of the Enter key aborting a suspend which got started when
that key was pressed.

> In general, (b) sounds complex and error prone.  Two things that are 
> IMO worth avoiding in the kernel.

Agreed.

> > (c) seems like a reasonable approach.  It does, however, have a 
> > couple of problems.  First, drivers can't (currently) tell the 
> > difference between an overall system sleep and a device-specific 
> > runtime suspend.  Since we certainly _don't_ want to ignore 
> > device-wakeup requests during a runtime suspend, there's no way for 
> > a driver to ignore them during a system sleep transition.
> > 
> > The second thing to consider about (c) is that ignoring a wakeup 
> > request might not make it go away.  It will depend on the exact 
> > nature of the hardware and the type of request of course, but 
> > there's a good chance that the request will persist until the system

> > finally goes to sleep.  At that point the request will immediately 
> > wake the system right back up.  The overall effect is the same as 
> > with (a) -- the system is awake at the end
> > -- but you've wasted a lot of time and effort to get there.
> 
> Both are reasons I'd prefer (a).
> 
> 
> > Now it's true that sometimes there will be no choice.  Once tasks 
> > are frozen, there's no way to resume a device since doing so 
> > requires a process context.  Then we'd be forced to adopt (c).
> 
> On the other hand, a clean failure of the suspend would restart those 
> tasks nicely... I don't see that as an issue.

Neither do I.  Note that if tasks are frozen, the driver doesn't have
any reason to abort the suspend.  As far as the driver can tell
everything proceeds normally: It gets a resume request and it tells the
appropriate process to carry out the resume.  It's not the driver's
fault that the process is frozen and so can't do the resume until the
system awakens.

> > However there are
> > situations where tasks are _not_ frozen during a sleep transition.  
> > Suspend-To-RAM on PPC, for example.  What should happen in such
cases?
> 
> Use (a).  ;)

My thought exactly.  :-)  But I'd still like to hear what other people
on the list think.  Maybe there's a fourth alternative...

Alan Stern



--===============69326758293803481==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============69326758293803481==--
