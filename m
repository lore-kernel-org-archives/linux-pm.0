From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Tue, 22 Mar 2005 17:46:19 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503221724550.16154-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
	<1111540913.16224.43.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============12279509980416115=="
In-Reply-To: <1111540913.16224.43.camel@gaston>
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

--===============12279509980416115==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 23 Mar 2005, Benjamin Herrenschmidt wrote:

>
> > I think the core should always call ->suspend() for a device, regardless
> > of whether it thinks it's in a low power state, or inactive. This is
> > specifically for the reason that a device could be a low-power runtime
> > state when the system is suspended.
>
> Exactly. And if we go all the way I suggested, that is define that
> suspend/resume are the system-state callbacks, and that a new
> enter_state low level callback is used for lower loevle state
> management, then it makes even more sense since it would be those
> suspend/resume calls that will add the additional semantic of "lock the
> state until resume" that the "basic" state management doesn't need.

Just to clarify, are you suggesting that the functional (not necesarily
literal) steps to fully suspend a device during a system state transition
are first to 'suspend' it, preventing it from being used and accessed or
being suspended/resumed from userpsace; then to have it directly enter a
low power state (e.g. via an enter_state() method)?

> Note that rather than enter_state, I'd rather just have a function
> pointer enter_this_state in the driver state array ...

Wouldn't that imply a different ->enter_state() method for each system
state?

> > To assist this, there should probably be only 1 list to hold the PM nodes,
> > making the code a lot simpler.
>
> I think we have to do real tree walking ...

Why? Note that I wasn't talking about ordering; only about consolidating
the current mess of having the active and inactive lists in the PM core.

> > For runtime states, I think the bus should be the one exporting PM control
> > files through sysfs, not the driver core. It will handle the display and
> > setting of power states, allowing it to show userspace states that
> > actually mean something, rather than just arbitrary numbers that don't map
> > to every bus.
>
> I don't agree. As I explained, power states will be device specific. Bus
> power states won't be (they will be well defined) but most
> devices/drivers are "leaf" devices and they will expose all sort of
> fancy power states to userland.

Yes. I was simply talking about who handles the userspace interaction via
sysfs. The e.g. PCI subsystem will export a sysfs file for each PCI
device.

Each device will have an array of states. I think this should be a static
sized array for the known PCI power states, and a pointer to device/driver
specific states. Each entry will have a name and a pointer to a method to
enter that state.

For devices that are not bound to a driver, this will show the standard
PCI PM states the device supports. Entering these states will be handled
by generic code, and will come with no guarantee.

When a driver is bound to a device, it will modify the static array as
necessary (removing dangerous states, and changing the method pointers),
and it will fill in the pointer for device/driver specific states.

When showing these states via sysfs, the show() method can simply access
the array for the particular state. For the setting of states, the store()
method would simply call the method pointer in the array for the requested
state.

I *think* this is similar/identical to what you've suggested before,
right?

Note that I say that the bus code handles the show()/store() methods
because it's string parsing and formatting that would be replicated
through a lot of drivers. It's not that hard, but it would all be
copy/replaced code that can be hard to deal with when bugs arise. And, it
can simply enough be done by the bus subsystem..

> I think drivers should have an array of states, with names, enter_state
> function pointer (per state) and bit mask of state dependency indicating
> the state dependency vs. parent. Additionally, states should be ordered
> so the core knows how to properly cascade up/down.

I'm not sure I get this. Could you elaborate more?

Thanks,


	Pat

--===============12279509980416115==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============12279509980416115==--
