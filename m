From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 12:21:53 +1100
Message-ID: <1111540913.16224.43.camel@gaston>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============49561592999032189=="
In-Reply-To: <Pine.LNX.4.50.0503221635130.16154-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============49561592999032189==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> I think the core should always call ->suspend() for a device, regardless
> of whether it thinks it's in a low power state, or inactive. This is
> specifically for the reason that a device could be a low-power runtime
> state when the system is suspended.

Exactly. And if we go all the way I suggested, that is define that
suspend/resume are the system-state callbacks, and that a new
enter_state low level callback is used for lower loevle state
management, then it makes even more sense since it would be those
suspend/resume calls that will add the additional semantic of "lock the
state until resume" that the "basic" state management doesn't need.

Note that rather than enter_state, I'd rather just have a function
pointer enter_this_state in the driver state array ...

Compatibility with existing drivers is easy: they don't have a state
array, so the system just assumes a default 2 state (running/suspended)
with no enter_this_state callback, and just calls the suspend/resume
callbacks for system-wide suspend. No local PM is supported by those
drivers, which is fine.

> To assist this, there should probably be only 1 list to hold the PM nodes,
> making the code a lot simpler.

I think we have to do real tree walking ...

> The system state transitions should be mediated through the bus driver.
> The bus should then translate it and call the driver, which will then map
> it back to a device-specific state (optionally using some bus helpers).
> We've talked about this before; I think David, Ben and I have all proposed
> something like this. Are you suggesting something different?

I would go to the device, not the bus, but with a different callback
than the low level enter state as explained above... In fact, if you
think about it, suspend/resume _do_ go through the bus which calls the
driver suspend/resume, so it's all fine.

> For runtime states, I think the bus should be the one exporting PM control
> files through sysfs, not the driver core. It will handle the display and
> setting of power states, allowing it to show userspace states that
> actually mean something, rather than just arbitrary numbers that don't map
> to every bus.

I don't agree. As I explained, power states will be device specific. Bus
power states won't be (they will be well defined) but most
devices/drivers are "leaf" devices and they will expose all sort of
fancy power states to userland.

I think drivers should have an array of states, with names, enter_state
function pointer (per state) and bit mask of state dependency indicating
the state dependency vs. parent. Additionally, states should be ordered
so the core knows how to properly cascade up/down.

> [ To show these states, the bus should use a per-device array of states
> that is filled in by the driver. This could easily include device-specific
> states that the driver includes in the array. ]

The bus has just a device (the bus driver, which unfortunately isn't
always clear in the current model), with well defined states for the
bus.

Ben.



--===============49561592999032189==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============49561592999032189==--
