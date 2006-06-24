From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 22:42:30 -0400
Message-ID: <20060624024230.GB3438@neo.rr.com>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606221130.30614.david-b@pacbell.net>
	<Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 23, 2006 at 04:44:40PM -0700, Linus Torvalds wrote:
> =

> =

> On Fri, 23 Jun 2006, Adam Belay wrote:
> > =

> > In my opinion, the point here is that the suspend functions are trying =
to
> > prevent access to hardware.
> =

> Yes. =

> =

> My point is that it's not needed for STR, has nothing to do with "driver" =

> (every driver needs to do it, and it doesn't actually touch hardware), an=
d =

> it's wrong.
> =

> And IT'S ONLY DONE BECAUSE THE INTERFACE SUCKS!

Yeah, I think it could certainly be improved.  However, I think it's very
important that we be careful to prevent a driver from attempting to access
powered off hardware, even in the STR case.  Now that doesn't warrant a
fullblown teardown of the driver stack.  In most cases this sort of thing
can be handled by notifying the right higher-level subystems.  So the actual
driver suspend() mechanisms can remain very simple. (see below)

> =

> It's really only needed with the current setup, because the whole =

> suspend() phase is so messy, and we try to solve everything in one single =

> pass, and one single function call.

As an immediate incremental improvement, we could add a prepare_suspend()
callback that would be called before userspace is stopped and a
finish_resume() callback that would be called after userspace has been
started again.

> =

> What I'd like to get to (and no, I realize that just ->save_state() will =

> _not_ get me there - it's just a first step) is a point where 99% of all =

> devices can literally do just something like
> =

> 	pci_save_state(dev);
> 	pci_set_wake_event(..);
> 	pci_set_power_state(dev, PCI_D3hot);

Yes, most drivers, especially of the PCI variety, can do something pretty
simple when suspending, but only if we have the right infrastructure in pla=
ce.

> =

> in their suspend routine. =

> i
> Now, in order to get there, we'll need a few more pieces. In particular, =

> it would require that this final suspend be called when interrupts have =

> been turned off.

One thing that might help us get there is if we passed a suspend notificati=
on
to the class devices (i.e. the higher level subsystems).  In this example,
I'm referring to the objects represented in /sys/class/net.  If that were t=
he
case, most network drivers would only have to do something similar to what =
you
suggested above, plus possibly some hardware specific power-off registers.
Right now a lot of drivers have to do some "calling upward" to higher layer=
s.
IMO this adds a lot of unneeded complexity and is less than ideal.

> (And I think Ben is right, we might want to have a "final_resume()" which =

> is called when user mode has resumed).

I agree.

> Five simple routines are _superior_ to one complicated routine. That is =

> true even if the five simple routines end up having more lines of code.
> =

> 			Linus

I'm curious about your thoughts on runtime suspending of devices are, such =
as
the resource rebalancing or cpufreq cases I suggested earlier.  Do you have
any opinions on how this might be handled?  So far, I've been favoring usage
of the same sort of freeze() mechanism used for preparing for memory snapsh=
ots
etc.

Thanks,
Adam
