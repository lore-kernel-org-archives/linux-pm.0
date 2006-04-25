From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Tue, 25 Apr 2006 15:56:54 -0700
Message-ID: <200604251556.55040.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200604251404.30228.david-b@pacbell.net>
	<200604252355.29006.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============048384575194066803=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604252355.29006.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============048384575194066803==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 25 April 2006 2:55 pm, Rafael J. Wysocki wrote:
> On Tuesday 25 April 2006 23:04, David Brownell wrote:
>  
> > The third state is the problem scenario, kicking in when the driver was
> > statically linked (or modprobed from initramfs, etc), but not during
> > your scenario.
> 
> The problem, as I see it, is that too many devices may be initialized at the
> kernel startup.

That's a fair observation.  In the same way, swsusp resumes too many devices
before writing the snapshot.  In both cases, it only needs the resume partition,
not every random bit of hardware in the system.

But it's not the root cause of the problem either.  The same problem appears if
the device holding the resume partition gets forced into this "broken suspend"
state.


> I think we _can_ reset some of them before the image 
> is restored, but at least some of them need to be treated more carefully.

Maybe; but remember they _were_ just reset ... and that if a driver doesn't
know how to re-init a device that it has just reset, then it has other problems!
It's a common practice to reset on entrance to probe() ... if that works, it's
"just" a simple matter of code cleanup/reorg to let the init code be used if
resume() detects the device hardware has been reset.

For example, rmmod/modprobe cycles wouldn't behave sanely ... and it'd likely
break with kexec().  If they "need" careful treatment, that'd seem to me most
like a driver bug ...

Now, if you have specific examples of things that shouldn't be reset, that
could be interesting.  I don't seem to have tripped over any, and from first
principles it's clear to me there _shouldn't_ be such drivers (modulo bugs).

If you're going to argue that there are enough buggy drivers around that
we can't rely on them to behave correctly here ... well, we don't have an
example of even one such driver, much less a flood of them.  And the thing
to do with bugs is fix them, not coddle them.  ;)


> > Right:  the first two "safe" cases kick in.  This is the partial workaround I
> > had identified:  dodging the code paths for that third state, where suspend()
> > is being used to put the hardware into a broken suspend state.
> 
> So perhaps we should just make them enter a state that's not broken?
> That may be reset for some devices (eg. USB) and something else for some
> others (eg. storage).

Sure, but I'm not sure what "something else" would ever be.  Examples?
Not of cases where something else _could_ be done, but where it _must_ be.


> > It may help to think of two distinct types of device hardware suspend states
> > (only the first is real, the second is just a software bug):
> > 
> >  - Correct, with internal state corresponding to what the driver suspend() did;
> >    what a normal hardware suspend/resume cycle (not powercycle!) could do.
> > 
> >  - Broken, with any other internal state (except reset).  This is what swsusp
> >    currently forces, by adding **AND HIDING** a reset and reinit cycle, because
> >    of the extra suspend() call in (7).
> 
> Still there are drivers that have no problems with it, so why we should we
> forcibly reset their devices?

Can any driver can really justify not handling the case where resume() sees
hardware that's been reset?  That is, _exactly_ as would be the case if its
driver were only loaded as a module after the kernel booted?  I think not...


> > My patch/suggestion just ensures that instead of that broken state, reset is used.
> > in all cases ... not just the "driver not initialized before snapshot resume" case.
> 
> As I said before I generally agree with this except I think some more fine
> grained approach is needed in this case.

You've not convinced me of that; might be right, but nothing proves it to me.


> Basically it seems we need something like a .prepare_for_resume() routine,
> that will be called before restoring the swsusp's image, apart from .suspend()
> and .resume() for each driver.  Your patch just assumes that
> .prepare_for_resume() should be "reset" for all devices.

I want to avoid piling on more special cases for swsusp, and that would appear
to be the only potential user for a prepare_for_resume().

The patch assumes that kexec() and the swsusp snapshot resume should be subject
to the same basic constraints.  While that might be a bit aggressive, it sure
seems like it's the right approach to take:  not adding special cases just for
swsusp, and making sure two very similar problems don't needlessly diverge
their solutions.  Plus, it's a mechanism that's been in place for some time now,
known to work.

- Dave


--===============048384575194066803==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============048384575194066803==--
