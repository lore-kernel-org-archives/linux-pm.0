From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Ottawa
Date: Mon, 14 Mar 2005 16:07:23 +1100
Message-ID: <1110776843.14684.250.camel@gaston>
References: <F7DC2337C7631D4386A2DF6E8FB22B3002F2271A@hdsmsx401.amr.corp.intel.com>
	<1110587382.5752.144.camel@gaston>
	<1110589712.12485.262.camel@localhost.localdomain>
	<200503132028.49339.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============26467605935326954=="
In-Reply-To: <200503132028.49339.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============26467605935326954==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Clock management.  ARM (and other) SOC based boards commonly have
> schemes to gate clocks off when the peripheral in question is unused,
> thereby saving power.  <asm-arm/hardware/clock.h> has an API used to
> explicitly represent the clock tree.

I have similar stuff on pmac, though probably not as detailed as the ARM
ones, I think it's orthogonal to the PM model. That is, it's up to a
device driver to decide wether to "release" it's clock or not based on
it's state, the clock net management beeing completely separated from
the actual device state management. That's also how I do it on pmac, and
I think hwo Apple does it.

> So a common mode of operation with such systems will be to keep
> the peripheral unclocked (saving power) until it's needed.  I don't
> actually see any reason to routinely plan policy options there,
> that'd just be pointless extra work.  clk_use() when the device
> is active, clk_unuse() otherwise.  And in some cases "suspended"
> will mean "unused" for at least some clocks.

Yes, but it's orthogonal to the PM model. A device could even request
slower clocks in intermediate power states or whatever, but it's the
device driver that calls into the "clock manager" on power state
transitions (or even at runtime) to express it's needs.

> That's sort of a "low level" category ... except that it pops up to
> higher level concerns.  For example, clocks may be shared (which can
> make the "low level" vs "driver state and relationships" distinctions
> look nonexistent), and they may interact with system power transitions. 

A bit, but then, the clock net is often even more scary than the power
tree. I wouldn't try to mix them up.

> Plus there are interactions with external devices.  For example, some
> SOCs can enter various deep sleep states when USB is either suspended
> (by the host) or disconnected ... but not all.  (And some could do it
> given external transceiver support...)  So there may be a choice between
> entering a deeper sleep, or discarding active device state...
> 
> 
> > 3.) Power Management Policy - determining which behavior to take for
> > various classes of devices, how to determine idleness etc., and how to
> > control/monitor those devices.
> 
> The primary mechanism I've heard discussed is having devices monitor
> when they haven't been used recently, and using that to enter some
> suspend level.  The "not even active" clock gating approach isn't
> quite the same.

Yes, drivers deciding themselves, or through sysfs. Part of the model I
propose is to let drivers expose a richer set of states to userland as
well. Policy for things like handelds can become so complicated that I
think it should be moved to userspace.
 
> > 4.) Userspace - how to notify of power changes, how to allow the user to
> > control power management.
> > 
> > Anything else?
> 
> Oh, and wakeup event sources.  ACPI has a very indirect approach,
> which seems to underlay some assumptions on this list.  There's a
> similar thing going on with PCI.  So for example when folk start
> to assume that a "wakeup" event is for some reason distinct from
> the device's normal IRQ, I must cringe ... anyone assuming that
> device or system suspend involves turning off IRQs is erecting
> roadblocks against most embedded hardware.

Yes and no ... They must be treated differently for sure. There are a
lot of cases where they are actually completely different. The problem
we discussed a while ago with USB is an example of the mess, and I still
have to investigate in details. Basically, the current USB code upstream
will crash the machine on sleep 90% of the times when I have something
plugged, while the same set of devices sleeps happily in OS X 100% of
the time. So we must be doing something wrong.

Wether the system IRQs must be masked or not is one thing that is
platform specific during suspend. Wether devices must stop their IRQ
emission, well... At least with USB, you do free_irq(). That means that
unless your IRQ is shared, it _will_ be masked at the controller level
anyway. So if the IRQ is used to wakeup the CPU, that is broken, at
least unless the IRQ line from the device (before reaching the IRQ
controller) is also triggering some sort of external wakeup mecanism.

I tend to think that devices using IRQs for wakeup instead of separate
IOs are broken design, but then, we all know that HW folks can't get
anything right ;)

In some cases, we might have to provide some arch hooks to be called by
drivers to know what to do ...

Ben.


--===============26467605935326954==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============26467605935326954==--
