From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Tue, 22 Mar 2005 12:04:22 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503221143460.954-100000@ida.rowland.org>
References: <1111465290.27490.34.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============83725299467129677=="
In-Reply-To: <1111465290.27490.34.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============83725299467129677==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 22 Mar 2005, Benjamin Herrenschmidt wrote:

> Yup, the model we are desinging now should allow for arbitrary
> transitions I suppose as long  as the target state is legal vs. the
> dependencies. Also, a system "suspend" state for example is enforced by
> the system and a user shouldnt be allowed to change it unless the system
> has resumed (thinking here about a spurrious user change coming in after
> the suspend call).

When per-device locking gets added to the driver model, this can be 
handled by making the PM core lock all devices before starting STR and 
unlock them all after waking up.  Then any user process trying to resume a 
device in the middle will block until the system is fully awake.

> I suppose the drivers should have some mean of flags
> in the message telling if this is a user initiated transition, or a
> system initiated transition (hrm... or rather, wether it's initiated by
> the user directly on this device, or is the result of a state change
> about to happen at the parent level).

My suggestion was to use a new code, PMSG_RUNTIME or something like that,
for suspend calls coming from the user.  Are we okay with no equivalent
code for resume calls?

> > The simplest way of handling this is to allow explicitly for such
> > possibilities.  When a device is asked to go from a very-low-power state
> > to a slightly-low-power state, it should be legal for the driver to leave
> > it in the very-low-power state.
> 
> Well... I'm not sure about that one. If the power states represent some
> performance states, the system may want to raise the performance a bit
> at the expensve of power and would stay low perf unless a full
> transition to state "full on" is done ?

If the system wanted to raise the performance, it will be safest to
detour through "full power" on the way.  If the user (or a userspace 
policy manager) skips the "full power" step, they get what they deserve.

> I suspect it's a per driver responsibility here. I suppose common sense
> will dicate what can be allowed and what not.

Yes.

> One thing is some states may be transitory. This is also a flag in the
> message I suppose. A system state is "permanent" in the sense that only
> a system wakeup will undo a system suspend. But a driver originated
> (idle timer) suspend need to trigger an auto-wakeup of the driver. I
> suspect that in most cases, user originated states are that way too: If
> the user explicitely suspends his HD (puts it to SLEEP) via /sysfs
> (which can be represented by some kind of GUI think in gnome or KDE
> panel, like MacOS used to do), he still wants the drive to spin up again
> as soon as a request gets there.
> 
> But then again, that is mostly per-driver policy driven by common sense.
> A system state is enforceable, a user state may not be...

We can enforce the system sleep states by device locking as described 
above.  For STD no enforcement is needed, because no processes other than 
the PM thread will be running.  (Except for things with PF_NOFREEZE -- 
they are in a position to cause some trouble.)

> > In particular, if a device is already suspended then it should be okay for
> > the driver to do nothing and still return Success for a FREEZE or SUSPEND
> > request -- and this fact should be documented.
> 
> Possibly, but is the state actually changed ? If the driver has a state
> "suspend" and gets a "freeze" request, does it stay in "suspend" state ?

Up to the driver.  The only requirement for FREEZE is that the device must
be quiesced; the actual state doesn't matter.

> If the driver is in a user-originated or idle-originated "suspend" state
> (with auto-wakeup on activity) and gets a FREEZE (or another SUSPEND)
> from the system, it must make sure not to auto-wakeup anymore from that
> state. There is a bit of policy to implement here, and I'm not sure how
> much of that can be put in the core to help drivers, and how much has to
> remain driver specific.

Locking should take care of this, once it's available.


> > Another way to handle this is to include a generic "low power" flag as a
> > standard part of the new power-state structures.  That way the core would
> > at least know whether a device was at full power.  (Maybe include a
> > "quiescent" flag too, since some devices can be operational while at low
> > power.)  While this isn't a bad idea, I rather favor the other approach.
> > of course we can always do both.
> 
> I'm not sure... Do we care ? Just tell the driver and see what it does,
> the driver doesn't have to go to the state we requested I suppose.

I'm not sure either.  I guess we shouldn't worry about adding these flags 
unless it becomes clear that they are needed.

> One thing that is important if we deal with partial suspend and tree
> dependencies is the ordering...
> 
> When a device is asked to enter a given state, the dependencies of the
> childs has to be checked in a different order if we are going to lower
> power than if we are going to higher power.
> 
> If going to lower power (that is toward suspend), we must check the
> dependencies of childs and eventually low-power them before the parent
> is actually state changed.
> 
> If going to higher power, it is the opposite.
> 
> However, if the driver goes to a different state, it must go to a state
> that doesn't break that rule. If the parent is asked to go to a deeper
> state, that means it's childs will have already been put to a deeper
> state to match the dependency of the new state. That means the driver
> must not go to a state that breaks that dependency. It can go to a
> less-deep state than asked but can't go to a deeper one since the childs
> may not be ready for it. Same goes in the opposite direction.
> 
> So I think we need to have the states in some sort of order at least so
> the core has a notion of what is "lower" and what is "higher" power to
> deal with that. Though I suppose we could also have optional hooks in
> driver (pre-parent-change and post-parent-change) for driver who want to
> be sneaky, but that gets nasty and complicated.

I agree.  This is the sort of boilerplate computation that is best done in
one single place -- the PM core.  Unfortunately it means that the core has
to understand what combinations of parent-state/child-state are legal.  I
don't know how that knowledge can best be represented.

Alan Stern


--===============83725299467129677==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============83725299467129677==--
