From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Tue, 22 Mar 2005 16:52:27 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============16766095887074761=="
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

--===============16766095887074761==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Mon, 21 Mar 2005, Alan Stern wrote:

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

I think the core should always call ->suspend() for a device, regardless
of whether it thinks it's in a low power state, or inactive. This is
specifically for the reason that a device could be a low-power runtime
state when the system is suspended.

To assist this, there should probably be only 1 list to hold the PM nodes,
making the code a lot simpler.

> There's also the possibility that as part of runtime power management, a
> user might tell an already-suspended device to go to a different, but
> still suspended, power state.  The core can't filter out such requests
> because it doesn't understand the states.  It's not even clear that such
> requests _should_ be filtered out.  PM-aware PCI devices, for example,
> have no trouble moving from D1 to D2.

Agree.

> Another way to handle this is to include a generic "low power" flag as a
> standard part of the new power-state structures.  That way the core would
> at least know whether a device was at full power.  (Maybe include a
> "quiescent" flag too, since some devices can be operational while at low
> power.)  While this isn't a bad idea, I rather favor the other approach.
> of course we can always do both.

I don't think the core needs to know. It shouldn't care when traversing
the lists what state a device is in.

> Messages vs. states:  At the moment the PM core seems to be pretty
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

The system state transitions should be mediated through the bus driver.
The bus should then translate it and call the driver, which will then map
it back to a device-specific state (optionally using some bus helpers).
We've talked about this before; I think David, Ben and I have all proposed
something like this. Are you suggesting something different?

For runtime states, I think the bus should be the one exporting PM control
files through sysfs, not the driver core. It will handle the display and
setting of power states, allowing it to show userspace states that
actually mean something, rather than just arbitrary numbers that don't map
to every bus.

[ To show these states, the bus should use a per-device array of states
that is filled in by the driver. This could easily include device-specific
states that the driver includes in the array. ]



	Pat

--===============16766095887074761==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============16766095887074761==--
