From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Wed, 26 Apr 2006 13:26:15 +0200
Message-ID: <200604261326.15853.rjw@sisk.pl>
References: <200604241429.52022.david-b@pacbell.net>
	<200604252355.29006.rjw@sisk.pl>
	<200604251556.55040.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604251556.55040.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Nigel Cunningham <nigel@suspend2.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 April 2006 00:56, David Brownell wrote:
> On Tuesday 25 April 2006 2:55 pm, Rafael J. Wysocki wrote:
> > On Tuesday 25 April 2006 23:04, David Brownell wrote:
> >  
> > > The third state is the problem scenario, kicking in when the driver was
> > > statically linked (or modprobed from initramfs, etc), but not during
> > > your scenario.
> > 
> > The problem, as I see it, is that too many devices may be initialized at the
> > kernel startup.
> 
> That's a fair observation.  In the same way, swsusp resumes too many devices
> before writing the snapshot.  In both cases, it only needs the resume partition,
> not every random bit of hardware in the system.

That's right, and I think we should make it resume only what's needed at some
point in the future.

> But it's not the root cause of the problem either.  The same problem appears if
> the device holding the resume partition gets forced into this "broken suspend"
> state.

Well, IMO the state may or may not be broken depending on the device,
so we should not assume it will always be broken.

> > I think we _can_ reset some of them before the image 
> > is restored, but at least some of them need to be treated more carefully.
> 
> Maybe; but remember they _were_ just reset ... and that if a driver doesn't
> know how to re-init a device that it has just reset, then it has other problems!
> It's a common practice to reset on entrance to probe() ... if that works, it's
> "just" a simple matter of code cleanup/reorg to let the init code be used if
> resume() detects the device hardware has been reset.

Agreed.

> For example, rmmod/modprobe cycles wouldn't behave sanely ... and it'd likely
> break with kexec().  If they "need" careful treatment, that'd seem to me most
> like a driver bug ...
> 
> Now, if you have specific examples of things that shouldn't be reset, that
> could be interesting.

The resume device and friends (ie. controller, bus, etc.).

> I don't seem to have tripped over any, and from first principles it's clear to
> me there _shouldn't_ be such drivers (modulo bugs). 
> 
> If you're going to argue that there are enough buggy drivers around that
> we can't rely on them to behave correctly here ... well, we don't have an
> example of even one such driver, much less a flood of them.  And the thing
> to do with bugs is fix them, not coddle them.  ;)

Agreed.

> > > Right:  the first two "safe" cases kick in.  This is the partial workaround I
> > > had identified:  dodging the code paths for that third state, where suspend()
> > > is being used to put the hardware into a broken suspend state.
> > 
> > So perhaps we should just make them enter a state that's not broken?
> > That may be reset for some devices (eg. USB) and something else for some
> > others (eg. storage).
> 
> Sure, but I'm not sure what "something else" would ever be.  Examples?
> Not of cases where something else _could_ be done, but where it _must_ be.

My point is that it need not be _necessary_ to reset all devices.  We should
reset only those which need to be reset.

> > > It may help to think of two distinct types of device hardware suspend states
> > > (only the first is real, the second is just a software bug):
> > > 
> > >  - Correct, with internal state corresponding to what the driver suspend() did;
> > >    what a normal hardware suspend/resume cycle (not powercycle!) could do.
> > > 
> > >  - Broken, with any other internal state (except reset).  This is what swsusp
> > >    currently forces, by adding **AND HIDING** a reset and reinit cycle, because
> > >    of the extra suspend() call in (7).
> > 
> > Still there are drivers that have no problems with it, so why we should we
> > forcibly reset their devices?
> 
> Can any driver can really justify not handling the case where resume() sees
> hardware that's been reset?  That is, _exactly_ as would be the case if its
> driver were only loaded as a module after the kernel booted?  I think not...

Of course every driver should handle this but that's not the point.  The point
is whether we should _force_ the reset on every device.
 
> > > My patch/suggestion just ensures that instead of that broken state, reset is used.
> > > in all cases ... not just the "driver not initialized before snapshot resume" case.
> > 
> > As I said before I generally agree with this except I think some more fine
> > grained approach is needed in this case.
> 
> You've not convinced me of that; might be right, but nothing proves it to me.

Fair enough. :-)

Greetings,
Rafael
