From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Ottawa [topics]
Date: Thu, 17 Mar 2005 09:26:03 -0800
Message-ID: <200503170926.04001.david-b@pacbell.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3002F2271A@hdsmsx401.amr.corp.intel.com>
	<200503161350.02426.david-b@pacbell.net>
	<1111016445.7192.72.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============066053375616560439=="
In-Reply-To: <1111016445.7192.72.camel@gaston>
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

--===============066053375616560439==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 16 March 2005 3:40 pm, Benjamin Herrenschmidt wrote:
> On Wed, 2005-03-16 at 13:50 -0800, David Brownell wrote:
> 
> > > 
> > > Yes, but it's orthogonal to the PM model. A device could even request
> > > slower clocks in intermediate power states or whatever, but it's the
> > > device driver that calls into the "clock manager" on power state
> > > transitions (or even at runtime) to express it's needs.
> > 
> > Not orthogonal.  Suspending a device will often involve a clock
> > transition ... and certain clocking levels will preclude certain
> > system PM states.
> 
>  .../...
> 
> Oh well, then come up with a scheme that can deal with those without
> beeing as big as the kernel itself...

If suspend-prepare fails, then the pm core backs out of that state
transition.  That's one part -- isolating core from many details,
and keeping it from needing to centrally manage every minor detail.


Another part is something I've been implying quite a lot:  that many
system power transitions should be "opportunistic".  Drivers would
have default "low power when unused" policies.  Parents would see
low power children, and could enter low power states themselves.

Then the platform PM logic could automatically enter appropriate
system PM states.  E.g. using the variable scheduler timeout stuff
to notice that now might be a good time to enter "big sleep" or
some other S1 or "suspend" analogue ... or that since the 48 MHz
clock is off, that "deep sleep" (or other S3 analogue) is possible.
With various wakeup sources including the system timer, of course.

That could tie into the centrally managed power state transitions
as follows:  userspace says "goto state FOO", device tree is notified,
the above opportunistic logic kicks in.  When the tree notifications
complete, the same logic called from the VST code could kick in.
Same result:  system goes into S1, or S3, or whatever.  Just it's
done by userspace request, not automatically.  (A policy choice.)


This just uses the existing PM infrastructure intelligently, with
minor additions to pass information up the tree ... and to use
that information once it's there.  It decentralizes much of the
key decision making, leveraging hardware PM support.


> > Embedded chips normally couple clock management with power management
> > very tightly.  They may have separate power switching controls, but
> > that's less widespread.
> 
> I am familiar with that, and I still think this shouldn't be directly
> dealt by the PM framework. In fact, in most embedded cases, drivers are
> specific anyway and can embed the clock net stuff.

That just won't work.  They're joined at the hip.  Drivers embed much
clock tree knowledge, that goes without saying.  But at the same time,
the platform PM code has to understand very basic rules like "these
clocks must be off before we can enter state FOO" and "state BAR is
like state FOO but these additional clocks must be off".  It's got
to rely on the drivers to gate the clocks correctly, otherwise any
attempt to suspend will just break the drivers.


> "My" hardware is jsut a fucking standard NEC USB2 chip in most cases and
> a lucent cell in Apple stuff in the other. Also "My" hardware is also
> the class of laptops that happen to have had working sleep support for
> much longer and much more reliably than any x86 out there. You are
> breaking that and don't seem to be interested in making that work. THat
> makes me thing that working sleep on USB today is just a matter of luck.

Calm down.  I don't have "your" hardware to test with, and "you" (Paul)
only yesterday posted the first proposed patch.  Expecting me to solve
all your hardware-coupled problems is unreasonable in such cases.

Another thing that's unreasonable is to try to prevent progress in x86
space just because it'd affect PPC.  :)


> > > At least with USB, you do free_irq(). That means that 
> > > unless your IRQ is shared, it _will_ be masked at the controller level
> > > anyway. So if the IRQ is used to wakeup the CPU, that is broken, at
> > > least unless the IRQ line from the device (before reaching the IRQ
> > > controller) is also triggering some sort of external wakeup mecanism.
> > 
> > That's a good example of a PCI-specific assumption, the type I
> > was saying creates problems.  Non-PCI hardware has no reason to
> > free the IRQ.  (In fact, the only reason PCI hardware does it is
> > to keep that PPC-ism out of the OHCI code.)
> 
> Which we have to keep anyway for the suspend code.

You're making no sense to me, since you appear to have just ignored
the point I made.   The PCI code works, modulo bugs, today.  As do
several non-PCI chips, that will absolutely break if you try to
disable their (wakeup) IRQs during suspend.


> And embedded with 
> bizarre clock stuff will need hooks there too.

My example was embedded with non-bizarre clocks, which disproved
the point you were making about IRQs....


> I don't understand how 
> you try to get the ppc stuff out on one side and deal with all the
> embedded cruft on the other. Masking IRQ in my case is mostly a matter
> of sanity. I'm switching the main clock off on the OHCI cell and disable
> the cell in the ASIC, I disable the IRQ that I know is not shared to
> make sure that there is no "dangling" irq line. I'm fairly sure other
> platforms (embedded especially) will need similar tweaks.

Remember that the example I gave was for platforms that do NOT want
to see the IRQs disabled.  They are after all the sources of wakeup
events that take the system out of the sleep/suspend state.  They
do NOT want "similar tweaks" at all.

 
> > > I tend to think that devices using IRQs for wakeup instead of separate
> > > IOs are broken design, but then, we all know that HW folks can't get
> > > anything right ;)
> > 
> > Again, that's a strong PCI bias.
> 
> Not at all. I would have said the same before we had PCI PM in the PCI
> spec.

Well, it's at any rate a faulty assumption that you should stop making.

- Dave


> >   Having PCI biases like that is
> > just creating trouble.  In fact, not all PCI hardware works that
> > way either ... just stuff using the PCI PM model.  And the last
> > many PCI busess I've looked at have had devices that don't use
> > the PCM PM attributes, don't support PCI D3 ...
> > 
> > - Dave
> > 
> > 
> > 
> > > In some cases, we might have to provide some arch hooks to be called by
> > > drivers to know what to do ...
> > > 
> > > Ben.
> > > 
> > > 
> -- 
> Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> 
> 

--===============066053375616560439==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============066053375616560439==--
