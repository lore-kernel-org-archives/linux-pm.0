From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 18:05:09 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503231742090.15119-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
	<1111540913.16224.43.camel@gaston>
	<Pine.LNX.4.50.0503221724550.16154-100000@monsoon.he.net>
	<1111548664.16201.63.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============17928402436393376=="
In-Reply-To: <1111548664.16201.63.camel@gaston>
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

--===============17928402436393376==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 23 Mar 2005, Benjamin Herrenschmidt wrote:

> > When showing these states via sysfs, the show() method can simply access
> > the array for the particular state. For the setting of states, the store()
> > method would simply call the method pointer in the array for the requested
> > state.
>
> Yes and no. If we deal with parent/child dependencies, we'll have to me
> smarter than that. Again, we need to be able to do fancy things like
> putting a USB bus into "suspend" (ie. USB standard suspend state, don't
> mismatch with "system" suspend, though the policy for system suspend is
> probably, at the USB bus level, to enter suspend anyway). For that, the
> bus driver will have to make sure all child devices are in a state
> compatible with the parent beeing suspended. This is why I want this
> state dependency mecanism.
>
> We can't have the USB bus driver know all possible state of childs,
> that's contrary to the whole idea of letting leaf devices have any state
> they want. _However_, since child devices do know the parent state (the
> USB bus states have been clearly defined), they can have in their state
> array, a dependency indication indicating that they have to be put into
> state Y when the parent goes into state X or deeper (I want state to be
> ordered to make things easier).

Are the leaf devices ever going to enter some random, ill-defined state?
While a device could enter a number of states, that set seems finite.
Correct me if I'm wrong, I only know PM from a PCI perpsective.

For PCI, there are 4 possible states a device could be in (ok 5, counting
D3-cold). How many power states are there in USB?

It would be trivial to add a set of lists to each bridge driver to hold
each device that is in a particular state. E.g. for PCI that would be:

	struct list_head	devices_d0;
	struct list_head	devices_d1;
	struct list_head	devices_d2;
	struct list_head	devices_d3;
	struct list_head	devices_d3cold;

As devices are discovered and bound, they are put on the devices_d0 list.
As runtime power management happens, they would be moved to the
appropriate lists based on the power state they entered. When a bridge was
told to go into a certain power state, it could easily iterate over all
the devices that were only in a power state that had to change.

It would be trivial for a bus to do automatic opportunistic power
management. It could quickly check what was the lowest state it could
enter based on the highest power state a child could have:

	if (list_empty(&devices_d0)) {
		if (list_empty(&devices_d1)) {
			if (list_empty(&devices_d2)) {
				enter_b3();
			} else {
				enter_b2();
			}
		} else {
			enter_b1();
		}
	}

Or something like that. :)

> Again, most devices will have a simple array, so it will end up beeing
> extremely simple for driver developers to implement. Granted, it makes
> bus iteration for us more complicated and pushes some complexity to the
> core. But, as I explained previously:
>
>  - This is a complex problem
>  - I'd rather have the complexity in a single place (the core) and keep
>    the driver side as simple as possible
>
> I think we would fix a lot of our problems if we had a notion of a bus
> tree iterator. When the PM code needs to iterate the tree, it creates
> the iterator object which registers itself somewhere.

I agree, and it's easy enough to think of things with a bus-centric view.
But, how does that add complexity to the core? I envision the core doing
something like this:

- Keep a hierarchical list of buses
- Iterate over buses to put them to sleep

If we kept it at that, we could just call down to the bridge drivers and
have them iterate over the devices on their bus to suspend them. This
would push all the handling of leaf devices to the bus subsystems
themselves. That would keep the core simple, not matter to the leaf device
drivers, and place the burden on the bridge drivers.

The bridge driver largely don't exist (except for USB hubs), the
requirements aren't very tough, and it would localize the semantics where
they need to be - in the bus subsystems.

Seems like a win all around..

Ok, now I'll read the rest of the threads..


	Pat

--===============17928402436393376==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============17928402436393376==--
