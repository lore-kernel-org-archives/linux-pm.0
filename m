From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 21:02:50 -0800
Message-ID: <200503232102.51132.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<1111548664.16201.63.camel@gaston>
	<Pine.LNX.4.50.0503231742090.15119-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============31975902226414155=="
In-Reply-To: <Pine.LNX.4.50.0503231742090.15119-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============31975902226414155==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 23 March 2005 6:05 pm, Patrick Mochel wrote:
> 
> On Wed, 23 Mar 2005, Benjamin Herrenschmidt wrote:
> 
> >
> > We can't have the USB bus driver know all possible state of childs,
> > that's contrary to the whole idea of letting leaf devices have any state
> > they want.

I've found it useful to distinguish between the states that are visible
at a component's lower interface ("towards the hardware") from those that
are visible at its upper interface ("towards userspace").

That way it's easy to draw important distinctions ... like the fact that
each one probably has a different sysfs object (e.g. lower is PCI device,
upper is network interface) ... and in PM terms, they don't need to expose
the same model.  For example, the model that the kernel works with will
not necessarily be appropriate to conflate with application-visible states.


> > _However_, since child devices do know the parent state (the 
> > USB bus states have been clearly defined), they can have in their state
> > array, a dependency indication indicating that they have to be put into
> > state Y when the parent goes into state X or deeper (I want state to be
> > ordered to make things easier).
> 
> Are the leaf devices ever going to enter some random, ill-defined state?

I'd expect that all states manipulated by the kernel would be well defined,
but the kernel won't directly manage all power states.  Examples of this
include "hdparm" managing disk idle timeouts and "xdpyinfo" managing DPMS
ones; the kernel just passes requests through.  (And lest anyone forget,
those two examples can represent as much power as some CPUs...)

Likewise there will be other application state not known to the kernel.



> While a device could enter a number of states, that set seems finite.
> Correct me if I'm wrong, I only know PM from a PCI perpsective.
> 
> For PCI, there are 4 possible states a device could be in (ok 5, counting
> D3-cold).

I'd count six PCI states.  The five defined in the PCI PM spec, and
a sixth for "legacy PM" models ... sort of like PCI_D0, but AFAICT
not really as carefully defined.


> How many power states are there in USB? 

Two:  active and suspended.   Active devices can draw a configurable
amount of power from VBUS (normally 100mA, up to 500mA), and they
receive traffic; normally a packet every millisecond.  Suspended ones
draw much less current from VBUS (normally 0.5mA, up to 2.5mA) and
receive no traffic.

USB devices can also issue wakeup events, in common cases.
 

> It would be trivial to add a set of lists to each bridge driver to hold
> each device that is in a particular state. 

Bridge-ish things I've had occasion to look at normally have on the
order of half a dozen children; rarely even a dozen.  I'm not sure
having a list per state would help much... a simple list-of-children
data structure should suffice.


> >  - This is a complex problem
> >  - I'd rather have the complexity in a single place (the core) and keep
> >    the driver side as simple as possible
> >
> > I think we would fix a lot of our problems if we had a notion of a bus
> > tree iterator. When the PM code needs to iterate the tree, it creates
> > the iterator object which registers itself somewhere.
> 
> I agree, and it's easy enough to think of things with a bus-centric view.
> But, how does that add complexity to the core? I envision the core doing
> something like this:
> 
> - Keep a hierarchical list of buses
> - Iterate over buses to put them to sleep

I'm inclined to Pat's perspective here.  Although I don't really see
any reason to treat busses different from anything else that's got
child devices (as Benjamin has pointed out too).


> If we kept it at that, we could just call down to the bridge drivers and
> have them iterate over the devices on their bus to suspend them. This
> would push all the handling of leaf devices to the bus subsystems
> themselves. That would keep the core simple, not matter to the leaf device
> drivers, and place the burden on the bridge drivers.

Benjamin didn't much like it much at all when I proposed that ... :)

 
> The bridge driver largely don't exist (except for USB hubs), the
> requirements aren't very tough, and it would localize the semantics where
> they need to be - in the bus subsystems.

Yes to localizing semantics!!  Though as for requirements, that's
not always true.

- Dave

--===============31975902226414155==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============31975902226414155==--
