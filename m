From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Ottawa [topics]
Date: Wed, 16 Mar 2005 13:50:02 -0800
Message-ID: <200503161350.02426.david-b@pacbell.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3002F2271A@hdsmsx401.amr.corp.intel.com>
	<200503132028.49339.david-b@pacbell.net>
	<1110776843.14684.250.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============94510572103471668=="
In-Reply-To: <1110776843.14684.250.camel@gaston>
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
Cc: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============94510572103471668==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 13 March 2005 9:07 pm, Benjamin Herrenschmidt wrote:
> 
> > Clock management.  ARM (and other) SOC based boards commonly have
> > schemes to gate clocks off when the peripheral in question is unused,
> > thereby saving power.  <asm-arm/hardware/clock.h> has an API used to
> > explicitly represent the clock tree.
> 
> I have similar stuff on pmac, though probably not as detailed as the ARM
> ones, I think it's orthogonal to the PM model. That is, it's up to a
> device driver to decide wether to "release" it's clock or not based on
> it's state, the clock net management beeing completely separated from
> the actual device state management. That's also how I do it on pmac, and
> I think hwo Apple does it.

Sort of.  Point being that clock management is often the only
hardware control over peripheral power consumption.  Clock
usage appears both as "driver-internal" state ... and also
as a constraint affecting the possible system PM transitions.


> > So a common mode of operation with such systems will be to keep
> > the peripheral unclocked (saving power) until it's needed.  I don't
> > actually see any reason to routinely plan policy options there,
> > that'd just be pointless extra work.  clk_use() when the device
> > is active, clk_unuse() otherwise.  And in some cases "suspended"
> > will mean "unused" for at least some clocks.
> 
> Yes, but it's orthogonal to the PM model. A device could even request
> slower clocks in intermediate power states or whatever, but it's the
> device driver that calls into the "clock manager" on power state
> transitions (or even at runtime) to express it's needs.

Not orthogonal.  Suspending a device will often involve a clock
transition ... and certain clocking levels will preclude certain
system PM states.


> > That's sort of a "low level" category ... except that it pops up to
> > higher level concerns.  For example, clocks may be shared (which can
> > make the "low level" vs "driver state and relationships" distinctions
> > look nonexistent), and they may interact with system power transitions. 
> 
> A bit, but then, the clock net is often even more scary than the power
> tree. I wouldn't try to mix them up.

Embedded chips normally couple clock management with power management
very tightly.  They may have separate power switching controls, but
that's less widespread.

 
> > The primary mechanism I've heard discussed is having devices monitor
> > when they haven't been used recently, and using that to enter some
> > suspend level.  The "not even active" clock gating approach isn't
> > quite the same.
> 
> Yes, drivers deciding themselves, or through sysfs. Part of the model I
> propose is to let drivers expose a richer set of states to userland as
> well. Policy for things like handelds can become so complicated that I
> think it should be moved to userspace.

When drivers just don't use clocks they don't need (a "policy"), it
gets simple rather quickly.  Pushing it to userspace would be a way
to add complexity ... IMO a non-goal.


> > > 4.) Userspace - how to notify of power changes, how to allow the user to
> > > control power management.
> > > 
> > > Anything else?
> > 
> > Oh, and wakeup event sources.  ACPI has a very indirect approach,
> > which seems to underlay some assumptions on this list.  There's a
> > similar thing going on with PCI.  So for example when folk start
> > to assume that a "wakeup" event is for some reason distinct from
> > the device's normal IRQ, I must cringe ... anyone assuming that
> > device or system suspend involves turning off IRQs is erecting
> > roadblocks against most embedded hardware.
> 
> Yes and no ... They must be treated differently for sure. There are a
> lot of cases where they are actually completely different.

And as many when they aren't.  Hence my point that assuming they ARE
is making trouble.  Some of the swsusp discussions seem to bring that
notion out.


> The problem 
> we discussed a while ago with USB is an example of the mess, and I still
> have to investigate in details. Basically, the current USB code upstream
> will crash the machine on sleep 90% of the times when I have something
> plugged, while the same set of devices sleeps happily in OS X 100% of
> the time. So we must be doing something wrong.

Orthogonal issue; still loks specific to your hardware.


> Wether the system IRQs must be masked or not is one thing that is
> platform specific during suspend. Wether devices must stop their IRQ
> emission, well... 

What's a "system IRQ" as opposed to any other kind?  Drivers don't
generally know or care how their IRQs are routed, they just care
that they get a callback.


> At least with USB, you do free_irq(). That means that 
> unless your IRQ is shared, it _will_ be masked at the controller level
> anyway. So if the IRQ is used to wakeup the CPU, that is broken, at
> least unless the IRQ line from the device (before reaching the IRQ
> controller) is also triggering some sort of external wakeup mecanism.

That's a good example of a PCI-specific assumption, the type I
was saying creates problems.  Non-PCI hardware has no reason to
free the IRQ.  (In fact, the only reason PCI hardware does it is
to keep that PPC-ism out of the OHCI code.)

 
> I tend to think that devices using IRQs for wakeup instead of separate
> IOs are broken design, but then, we all know that HW folks can't get
> anything right ;)

Again, that's a strong PCI bias.  Having PCI biases like that is
just creating trouble.  In fact, not all PCI hardware works that
way either ... just stuff using the PCI PM model.  And the last
many PCI busess I've looked at have had devices that don't use
the PCM PM attributes, don't support PCI D3 ...

- Dave



> In some cases, we might have to provide some arch hooks to be called by
> drivers to know what to do ...
> 
> Ben.
> 
> 

--===============94510572103471668==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============94510572103471668==--
