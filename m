From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 14:31:04 +1100
Message-ID: <1111548664.16201.63.camel@gaston>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
	<1111540913.16224.43.camel@gaston>
	<Pine.LNX.4.50.0503221724550.16154-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7858421088585541=="
In-Reply-To: <Pine.LNX.4.50.0503221724550.16154-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
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

--===============7858421088585541==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Just to clarify, are you suggesting that the functional (not necesarily
> literal) steps to fully suspend a device during a system state transition
> are first to 'suspend' it, preventing it from being used and accessed or
> being suspended/resumed from userpsace; then to have it directly enter a
> low power state (e.g. via an enter_state() method)?

At the system level, low power state must be entered atomically with the
actual suspending of the driver. That is, when suspend() has returned,
th device must be sleeping. That is necessary for the good old reason
that once the parent is asleep, no way you can talk to your device.

> > Note that rather than enter_state, I'd rather just have a function
> > pointer enter_this_state in the driver state array ...
> 
> Wouldn't that imply a different ->enter_state() method for each system
> state?

one enter state method for each driver state. If the driver has one
enter state for each system state, then go for it.

> > > To assist this, there should probably be only 1 list to hold the PM nodes,
> > > making the code a lot simpler.
> >
> > I think we have to do real tree walking ...
> 
> Why? Note that I wasn't talking about ordering; only about consolidating
> the current mess of having the active and inactive lists in the PM core.

Because of parent/child dependencies, I'm not sure we can get away with
simple list walking.

> > > For runtime states, I think the bus should be the one exporting PM control
> > > files through sysfs, not the driver core. It will handle the display and
> > > setting of power states, allowing it to show userspace states that
> > > actually mean something, rather than just arbitrary numbers that don't map
> > > to every bus.
> >
> > I don't agree. As I explained, power states will be device specific. Bus
> > power states won't be (they will be well defined) but most
> > devices/drivers are "leaf" devices and they will expose all sort of
> > fancy power states to userland.
> 
> Yes. I was simply talking about who handles the userspace interaction via
> sysfs. The e.g. PCI subsystem will export a sysfs file for each PCI
> device.
> 
> Each device will have an array of states. I think this should be a static
> sized array for the known PCI power states, and a pointer to device/driver
> specific states. Each entry will have a name and a pointer to a method to
> enter that state.

I don't understand your static sized + pointer idea ...

At every level, we have devies. The core doesn't make a difference
between a device and a bus state. A bus state is just a device parent't
state. The only difference is that _we_ will strictly define the bus
states for known busses, while leaf devices will have freedom of doing
what they want.

So at every level, device -> state array. No need for fancy pointers.

> For devices that are not bound to a driver, this will show the standard
> PCI PM states the device supports. Entering these states will be handled
> by generic code, and will come with no guarantee.

Hrm... no driver -> no suspend imho... but that can be debated :)

> When a driver is bound to a device, it will modify the static array as
> necessary (removing dangerous states, and changing the method pointers),
> and it will fill in the pointer for device/driver specific states.

The driver just exposes it's array that gets attached to struct device.
No need to "modify" an existing array or whatever. In 99.9% of the
states, the array will just be a static structure in the driver.

> When showing these states via sysfs, the show() method can simply access
> the array for the particular state. For the setting of states, the store()
> method would simply call the method pointer in the array for the requested
> state.

Yes and no. If we deal with parent/child dependencies, we'll have to me
smarter than that. Again, we need to be able to do fancy things like
putting a USB bus into "suspend" (ie. USB standard suspend state, don't
mismatch with "system" suspend, though the policy for system suspend is
probably, at the USB bus level, to enter suspend anyway). For that, the
bus driver will have to make sure all child devices are in a state
compatible with the parent beeing suspended. This is why I want this
state dependency mecanism.

We can't have the USB bus driver know all possible state of childs,
that's contrary to the whole idea of letting leaf devices have any state
they want. _However_, since child devices do know the parent state (the
USB bus states have been clearly defined), they can have in their state
array, a dependency indication indicating that they have to be put into
state Y when the parent goes into state X or deeper (I want state to be
ordered to make things easier).

That sort of things requires some smarter tree walking though, and maybe
a bit of recursion, though we'll be careful here :)

Either that, or we can have a pair of routines in childs called
"parent_state_change_before" and "parent_change_state_after" to let them
deal with it locally, but that looks ugly...

Again, most devices will have a simple array, so it will end up beeing
extremely simple for driver developers to implement. Granted, it makes
bus iteration for us more complicated and pushes some complexity to the
core. But, as I explained previously:

 - This is a complex problem
 - I'd rather have the complexity in a single place (the core) and keep
   the driver side as simple as possible

I think we would fix a lot of our problems if we had a notion of a bus
tree iterator. When the PM code needs to iterate the tree, it creates
the iterator object which registers itself somewhere.

When/if a device gets removed/added to the tree, the iterator can be
"updated" and put back into position to deal with it.

In fact, it's all simple to deal with until we have to deal with races
between tree walking vs. suspend resume. I think that can be easily
solved using the above, plus always delaying (put them in a "todo list")
all additions while a system suspend is in progress.

There additional things to think about though (regardless of the scheme
we decide to use). One of them is: a device may be added while the bus
isn't in "max" state. The other is child->parent callbacks. The device
driver itself may want to kick the bus into life, especially in case of
idle suspend.

The whole "kick the bus, I want more power" (that is child -> parent
action) I think should stay bus specific. That is, the child knows the
bus isn't in a required state to process a given request. It will call a
parent routine to "kick" the bus. The bus will then eventually change
state and the child will proceed. (Maybe we want something asynchronous
there btw... to be discussed).

The addition of a device while the bus isn't in "max" state means the
driver need a mecanism to know in which state it's starting up. That can
be added too.

> I *think* this is similar/identical to what you've suggested before,
> right?
> 
> Note that I say that the bus code handles the show()/store() methods
> because it's string parsing and formatting that would be replicated
> through a lot of drivers. It's not that hard, but it would all be
> copy/replaced code that can be hard to deal with when bugs arise. And, it
> can simply enough be done by the bus subsystem..
> 
> > I think drivers should have an array of states, with names, enter_state
> > function pointer (per state) and bit mask of state dependency indicating
> > the state dependency vs. parent. Additionally, states should be ordered
> > so the core knows how to properly cascade up/down.
> 
> I'm not sure I get this. Could you elaborate more?

Well, states have numbers implicitely (their position in the array). For
well-defined state arrays (that is busses), those numbers can be made
nto known constants.

The child can then have an integer in each state indicating the minimum
state required for the bus for the device state to be valid. That will
deal with the "minimum dependency".

Ben.



--===============7858421088585541==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============7858421088585541==--
