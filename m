From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 3/3] Runtime PM support for named power states
Date: Thu, 6 Oct 2005 13:16:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510061300470.6024-100000@iolanthe.rowland.org>
References: <200510051634.00719.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============30086632933669488=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200510051634.00719.david-b@pacbell.net>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============30086632933669488==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 5 Oct 2005, David Brownell wrote:

> On Wednesday 05 October 2005 1:08 pm, Alan Stern wrote:
> > On Tue, 4 Oct 2005, David Brownell wrote:
> > 
> > > My theory is that the PM core doesn't need any notion that's more
> > > complex than "moved device from <this> device list to <that> one".
> > > Suspend and resume just move devices between lists.
> 
> (That is, for _system_ sleep state transitions.)
> 
> 
> > Sounds reasonable.  There's one thing to consider, though.  System sleep
> > transitions are supposed to work even when devices are already in a
> > low-power state, which some drivers may not be able to handle.  That's the
> > main reason why dev->power.power_state exists today -- so that the PM core
> > can see if a device needs to be set back to full power before suspending
> > it.
> 
> Then let the darn driver implement those rules.  Admittedly (as Scott
> Preece implied) that's a change in semantics, and some drivers may well
> expect suspend() is never followed by another suspend().  But my point
> was that the states are device-specific ... so there's really not much
> reasoning that least-common-denominator "pm core" code can do about
> the states.  (IMO it's reasonable to define a "full-ON" state; but any
> other states can't be very generic.)
> 
> 
> > IMO we could avoid the need for power_state by removing the guarantee
> > about never calling ->suspend when a device is already in a low-power
> > state.  The system sleep code could issue an optimistic ->suspend call,
> > and if that fails then do ->resume followed by ->suspend.
> 
> I'm sure I said part of that.  :)

Ah, but which one of us said it first?  :-)

> > As part of the infrastructure changes, we could remove
> > dev->power.power_state, dev->power.prev_state, and maybe also
> > dev->power.saved_state (currently it is used only in a few platform
> > drivers for stuff that could easily be stored in a private data
> > structure).  Nothing would be needed but the name pointer, and that should
> > be under the bus/driver's control.
> 
> Exactly.

Then you agree with everything up to here?  Good.

FREEZE is a rather special case.  It doesn't correspond to any particular 
power state.  But maybe that doesn't matter -- when devices are in FREEZE, 
then almost by definition no user processes are awake to query their 
states.

> > People have already pretty much agreed that ->resume needs to take a 
> > pm_message_t argument, and that will mean changing a lot of drivers.
> 
> I certainly didn't agree on that, though I expect you remembered that.

I didn't remember you either agreeing or objecting to it.  But we do have
this issue about whether or not devices might be in an unknown state when
a RESUME occurs.  Passing an extra argument would enable drivers to _know_
when to expect an "unexpected" state change.

> > > (IMO it's clearly wrong to clobber a power_state value that the
> > > driver set ... it surely knows more about itself than the pm core.)
> > 
> > Drivers _should_ manage these values, especially if they will be used by 
> > sysfs.  On the other hand, if there are only two states then the PM core 
> > can assume that the first is ON and the second is SUSPEND, so it could 
> > handle the updates by itself.
> 
> That's a big "if".

But it's true for many devices.  All USB devices, for instance.  And the 
PM core could easily tell when it was true, by exporting a generic 
two-entry state array and checking whether a particular device was using 
that generic array.

>  Notice by the way there's no "OFF" ... what's with
> that?  If there's "core" code knowing about states, "ON" and "OFF" would
> make sense pretty much always.  Then there could be various driver
> specific states that can morph back to ON -- preserving state, which
> may be something USB needs more than most other frameworks -- with varying
> degrees of speed.

Is there a significant difference in meaning between OFF and SUSPEND?  
Seems to me that OFF should be a device's state only after a hot-unplug --
i.e., once the struct device has been unregistered.  So an OFF state would
never appear in the system.

Anyway, my point was that the simplest (two-state) case could be handled
directly by the PM core, while anything more complicated would have to be
handled by drivers.  This provides a relatively straightforward upgrade
path, since essentially every driver currently interacts with the core in
terms of a two-state model (or three if you count FREEZE as a separate
state).

Alan Stern


--===============30086632933669488==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============30086632933669488==--
