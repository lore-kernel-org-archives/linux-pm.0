From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 13:29:34 +1100
Message-ID: <1111631375.16201.172.camel@gaston>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
	<1111540913.16224.43.camel@gaston>
	<Pine.LNX.4.50.0503221724550.16154-100000@monsoon.he.net>
	<1111548664.16201.63.camel@gaston>
	<Pine.LNX.4.50.0503231742090.15119-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============60596345724769884=="
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
To: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============60596345724769884==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Are the leaf devices ever going to enter some random, ill-defined state?
> While a device could enter a number of states, that set seems finite.
> Correct me if I'm wrong, I only know PM from a PCI perpsective.
> 
> For PCI, there are 4 possible states a device could be in (ok 5, counting
> D3-cold). How many power states are there in USB?

Power states of a device go far beyond what their bus provide. For
example, I have ideas of using that to provide a way for radeonfb to
underclock the video chip, with significant gain on power consumptions.
There may be plenty other operational modes on a given piece of HW that
aren't necesarily related to the PCI PM state. The later is just a
"tool" for use by the driver, they aren't really useful to expose in
practice.

> It would be trivial to add a set of lists to each bridge driver to hold
> each device that is in a particular state. E.g. for PCI that would be:
> 
> 	struct list_head	devices_d0;
> 	struct list_head	devices_d1;
> 	struct list_head	devices_d2;
> 	struct list_head	devices_d3;
> 	struct list_head	devices_d3cold;

But they make no sense ! Have you any driver writing experience ? :)
Specs are nice, but sometimes quite far from reality. Those states
aren't even properly defined by the PCI Spec (their actual HW meaning is
not), and what state to enter for a given state and what is the effect
of that state is totally device dependant. Some devices support only a
subset of them, etc etc etc...
 
> As devices are discovered and bound, they are put on the devices_d0 list.
> As runtime power management happens, they would be moved to the
> appropriate lists based on the power state they entered. When a bridge was
> told to go into a certain power state, it could easily iterate over all
> the devices that were only in a power state that had to change.

No, we shouldn't even care about the PCI PM states IMHO. Drivers may
chose to put their device in a given PCI PM state because they know that
on such HW, that PM state has this specific effect etc... but that's not
something we want to expose beyond that. There _is_ some platform
requirements on PCI PM states for sustem suspend though, and we need a
way to address them (via pci_choose_state or equivalent maybe) but that
isn't even always properly dealt with by all HW anyway.

>It would be trivial for a bus to do automatic opportunistic power
> management. It could quickly check what was the lowest state it could
> enter based on the highest power state a child could have:
> 
> 	if (list_empty(&devices_d0)) {
> 		if (list_empty(&devices_d1)) {
> 			if (list_empty(&devices_d2)) {
> 				enter_b3();
> 			} else {
> 				enter_b2();
> 			}
> 		} else {
> 			enter_b1();
> 		}
> 	}
> 
> Or something like that. :)

Excepot that there is nothing like a definition of what a "D2" state
means to a PCI bus ... If it meant "unclocked" (which is _usually_ the
case with some devices, assuming D2 means you can remove the clock but
not power), but it's not even properly specified.

> I agree, and it's easy enough to think of things with a bus-centric view.
> But, how does that add complexity to the core? I envision the core doing
> something like this:
> 
> - Keep a hierarchical list of buses
> - Iterate over buses to put them to sleep

The core should only care about devices. A bus is just a special case of
device with childs... and thus a possible dependency. States exposed by
busses are device states. PCI cannot really expose any since the PCI D
states don't really have any meaning. The only thing PCI can expose with
some useful sanity is "clocked removed" and "power removed" ... There
may be room for a "low power" (only the minimum sleep power is
provided). Drivers could act on those, since those are states that
actually _mean_ something to the HW, thus drivers designers could take
proper decisions on what to do. At the bus level, D1 or D2 have no
meaning. The PCI spec is broken in this regard (and many others ...)

> If we kept it at that, we could just call down to the bridge drivers and
> have them iterate over the devices on their bus to suspend them. This
> would push all the handling of leaf devices to the bus subsystems
> themselves. That would keep the core simple, not matter to the leaf device
> drivers, and place the burden on the bridge drivers.
> 
> The bridge driver largely don't exist (except for USB hubs), the
> requirements aren't very tough, and it would localize the semantics where
> they need to be - in the bus subsystems.
> 
> Seems like a win all around..
> 
> Ok, now I'll read the rest of the threads..
> 
> 
> 	Pat
-- 
Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>


--===============60596345724769884==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============60596345724769884==--
