From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Nested suspends; messages vs. states
Date: Mon, 21 Mar 2005 15:11:54 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============50076396347016527=="
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============50076396347016527==
Content-Type: TEXT/PLAIN; charset=US-ASCII

Here are a couple of issues I want to raise before the next IRC session.


Nested suspends:  We know that the PM core tries to avoid increasing a
device's suspend level (i.e., FREEZE -> SUSPEND) as part of a system
sleep.  However...  The core won't have a very good idea of a device's
initial state, and a device may already be suspended when the system sleep
begins.  We have decided that devices' power states are represented by
pointers to structures defined at the bus or device level; the PM core
won't know how to interpret them.  So it won't know whether a device is
already suspended.

There's also the possibility that as part of runtime power management, a
user might tell an already-suspended device to go to a different, but
still suspended, power state.  The core can't filter out such requests
because it doesn't understand the states.  It's not even clear that such
requests _should_ be filtered out.  PM-aware PCI devices, for example,
have no trouble moving from D1 to D2.

The simplest way of handling this is to allow explicitly for such
possibilities.  When a device is asked to go from a very-low-power state
to a slightly-low-power state, it should be legal for the driver to leave
it in the very-low-power state.  It should also be legal for the driver to
go to full power temporarily, then down to the requested power level.  In
particular, if a device is already suspended then it should be okay for
the driver to do nothing and still return Success for a FREEZE or SUSPEND
request -- and this fact should be documented.

Another way to handle this is to include a generic "low power" flag as a
standard part of the new power-state structures.  That way the core would
at least know whether a device was at full power.  (Maybe include a
"quiescent" flag too, since some devices can be operational while at low
power.)  While this isn't a bad idea, I rather favor the other approach.
of course we can always do both.


Messages vs. states:  At the moment the PM core seems to be pretty
confused over this distinction.  Right in the definition of struct
dev_pm_info we have:

	pm_message_t		power_state;

Obviously a message isn't the same thing as a state.  This looks like 
something that will need to be changed in a lot of drivers when we 
introduce the new notion of a power state.

As a corollary we have the problem of what to include in the argument
passed to a suspend callback.  It should be a message, clearly, and 
part of the message should be an indication of which state to go to.  The
question is, how is this state represented?  For device power management
we will want to provide a genuine power state (i.e., pointer to bus- or
device-specific structure).  For system power management we will want to
provide a generic code -- PMSG_ON, PMSG_FREEZE, or PMSG_SUSPEND -- which
the driver will map to a real power state.

It seems to me the best way to do this is to let pm_message_t include both
a generic code and a power-state pointer.  There should be a new code
added (PMSG_RUNTIME? or maybe PMSG_DEVICE?), meaning that the driver
should use the state pointer.  Otherwise the driver maps the generic code.

Alan Stern


--===============50076396347016527==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============50076396347016527==--
