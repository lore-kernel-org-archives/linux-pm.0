From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Tue, 22 Mar 2005 15:21:29 +1100
Message-ID: <1111465290.27490.34.camel@gaston>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1965419057433726=="
In-Reply-To: <Pine.LNX.4.44L0.0503211436020.1241-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============1965419057433726==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-03-21 at 15:11 -0500, Alan Stern wrote:
> Here are a couple of issues I want to raise before the next IRC session.
> 
> 
> Nested suspends:  We know that the PM core tries to avoid increasing a
> device's suspend level (i.e., FREEZE -> SUSPEND) as part of a system
> sleep.  However...  The core won't have a very good idea of a device's
> initial state, and a device may already be suspended when the system sleep
> begins.  We have decided that devices' power states are represented by
> pointers to structures defined at the bus or device level; the PM core
> won't know how to interpret them.  So it won't know whether a device is
> already suspended.

Yup, the model we are desinging now should allow for arbitrary
transitions I suppose as long  as the target state is legal vs. the
dependencies. Also, a system "suspend" state for example is enforced by
the system and a user shouldnt be allowed to change it unless the system
has resumed (thinking here about a spurrious user change coming in after
the suspend call). I suppose the drivers should have some mean of flags
in the message telling if this is a user initiated transition, or a
system initiated transition (hrm... or rather, wether it's initiated by
the user directly on this device, or is the result of a state change
about to happen at the parent level).

> There's also the possibility that as part of runtime power management, a
> user might tell an already-suspended device to go to a different, but
> still suspended, power state.  The core can't filter out such requests
> because it doesn't understand the states.  It's not even clear that such
> requests _should_ be filtered out.  PM-aware PCI devices, for example,
> have no trouble moving from D1 to D2.

The drivers are the only to know what is legal I suppose...

> The simplest way of handling this is to allow explicitly for such
> possibilities.  When a device is asked to go from a very-low-power state
> to a slightly-low-power state, it should be legal for the driver to leave
> it in the very-low-power state.

Well... I'm not sure about that one. If the power states represent some
performance states, the system may want to raise the performance a bit
at the expensve of power and would stay low perf unless a full
transition to state "full on" is done ?

I suspect it's a per driver responsibility here. I suppose common sense
will dicate what can be allowed and what not.

One thing is some states may be transitory. This is also a flag in the
message I suppose. A system state is "permanent" in the sense that only
a system wakeup will undo a system suspend. But a driver originated
(idle timer) suspend need to trigger an auto-wakeup of the driver. I
suspect that in most cases, user originated states are that way too: If
the user explicitely suspends his HD (puts it to SLEEP) via /sysfs
(which can be represented by some kind of GUI think in gnome or KDE
panel, like MacOS used to do), he still wants the drive to spin up again
as soon as a request gets there.

But then again, that is mostly per-driver policy driven by common sense.
A system state is enforceable, a user state may not be...

>   It should also be legal for the driver to
> go to full power temporarily, then down to the requested power level.

Yes.

> In particular, if a device is already suspended then it should be okay for
> the driver to do nothing and still return Success for a FREEZE or SUSPEND
> request -- and this fact should be documented.

Possibly, but is the state actually changed ? If the driver has a state
"suspend" and gets a "freeze" request, does it stay in "suspend" state ?

If the driver is in a user-originated or idle-originated "suspend" state
(with auto-wakeup on activity) and gets a FREEZE (or another SUSPEND)
from the system, it must make sure not to auto-wakeup anymore from that
state. There is a bit of policy to implement here, and I'm not sure how
much of that can be put in the core to help drivers, and how much has to
remain driver specific.

The goal is to be as simple as possible or driverrs will never get it
right, _BUT_ on the other hands, this is a complex problem and we can
probably not hide all of the difficulties. At one point, drivers will
have problems that will have to be fixed on a per driver basis.
 
> Another way to handle this is to include a generic "low power" flag as a
> standard part of the new power-state structures.  That way the core would
> at least know whether a device was at full power.  (Maybe include a
> "quiescent" flag too, since some devices can be operational while at low
> power.)  While this isn't a bad idea, I rather favor the other approach.
> of course we can always do both.

I'm not sure... Do we care ? Just tell the driver and see what it does,
the driver doesn't have to go to the state we requested I suppose.

One thing that is important if we deal with partial suspend and tree
dependencies is the ordering...

When a device is asked to enter a given state, the dependencies of the
childs has to be checked in a different order if we are going to lower
power than if we are going to higher power.

If going to lower power (that is toward suspend), we must check the
dependencies of childs and eventually low-power them before the parent
is actually state changed.

If going to higher power, it is the opposite.

However, if the driver goes to a different state, it must go to a state
that doesn't break that rule. If the parent is asked to go to a deeper
state, that means it's childs will have already been put to a deeper
state to match the dependency of the new state. That means the driver
must not go to a state that breaks that dependency. It can go to a
less-deep state than asked but can't go to a deeper one since the childs
may not be ready for it. Same goes in the opposite direction.

So I think we need to have the states in some sort of order at least so
the core has a notion of what is "lower" and what is "higher" power to
deal with that. Though I suppose we could also have optional hooks in
driver (pre-parent-change and post-parent-change) for driver who want to
be sneaky, but that gets nasty and complicated.

Messages vs. states:  At the moment the PM core seems to be pretty
> confused over this distinction.  Right in the definition of struct
> dev_pm_info we have:
> 
> 	pm_message_t		power_state;
> 
> Obviously a message isn't the same thing as a state.  This looks like 
> something that will need to be changed in a lot of drivers when we 
> introduce the new notion of a power state.
> 
> As a corollary we have the problem of what to include in the argument
> passed to a suspend callback.  It should be a message, clearly, and 
> part of the message should be an indication of which state to go to.  The
> question is, how is this state represented?  For device power management
> we will want to provide a genuine power state (i.e., pointer to bus- or
> device-specific structure).  For system power management we will want to
> provide a generic code -- PMSG_ON, PMSG_FREEZE, or PMSG_SUSPEND -- which
> the driver will map to a real power state.
> 
> It seems to me the best way to do this is to let pm_message_t include both
> a generic code and a power-state pointer.  There should be a new code
> added (PMSG_RUNTIME? or maybe PMSG_DEVICE?), meaning that the driver
> should use the state pointer.  Otherwise the driver maps the generic code.
> 
> Alan Stern
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
> http://lists.osdl.org/mailman/listinfo/linux-pm
-- 
Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>


--===============1965419057433726==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1965419057433726==--
