From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] A New Power Management API
Date: Sun, 17 Apr 2005 15:29:17 -0700
Message-ID: <200504171529.17711.david-b@pacbell.net>
References: <1113533193.3451.40.camel@localhost.localdomain>
	<200504161124.05846.david-b@pacbell.net>
	<1113770914.3451.107.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============17280664462257378=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1113770914.3451.107.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============17280664462257378==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 17 April 2005 1:48 pm, Adam Belay wrote:
> On Sat, 2005-04-16 at 11:24 -0700, David Brownell wrote:
> > On Friday 15 April 2005 11:54 am, Adam Belay wrote:
> > > 
> > > I'm not familiar with how we would control such a device from software.
> > > If you think more than _ON and _OFF would be necessary, I could
> > > certainly revise this code.  
> > 
> > Other similar devices include the TI TPS6501x series:
> > ...
> > Yes, more than "on" and "off" is necessary.  ...
> 
> Ok, so I think each power plane (or LDO or whatever) would be a power
> resource, not the controller itself.

Maybe.  I suspect packaging it that way would seem like "extra"
work, but I won't pretend to know all the right answers for how
to talk to such chips.  One person asking me how to handle a
similar chip on a Motorola platform told me he expected to get
more than a few arrows in his back ... and I was kind of worried
about starting a new drivers/i2c/power subtree!  ;)

What I've seen so far is that the LDO setup is just board-specific
init logic of the "write once and forget" variety.  Which means
that software basically ignores it later ... although it's possible
that some LDOs might be adjusted to lower voltages during certain
system states.

Likewise with GPIOs used to switch power supplied through the LDOs:
board-specific logic kicking when the various drivers need to do
their thing.


> > One small point to notice:  this is an I2C driver, but it needs
> > to initialize quite early on most boards, since it's used to power
> > up other devices (including often the DSP).  So the system init
> > sequence has been adjusted to make that behave:  I2C initializes
> > early (subsys_initcall), as does this specific I2C driver.
> 
> Yeah, sounds like that could get rather tricky.

Not really, but I thought it was worth pointing out.  It's an example
of a case where PC-ish assumptions can cause surprises.  (Another
would be assuming PM registers can be accessed in IRQ context... or
that ACPI handles any of that!)


> > > I could see something like having a clock put at a slower 
> > > speed, so maybe we do need more than on and off.
> > 
> > How would you handle the ARM clock trees?  E.g. the stuff you'll
> > find in arch/arm/mach-omap/clock.c in 2.6.12-rc2?  (Older versions
> > are very similar, the latest version in the linux-omap tree above
> > can be made to disable unused clocks at boot time.)  My initial
> > thought was that these specific resources wouldn't show up as any
> > kind of power resource, since they're already managed properly
> > (by clk_use/clk_unuse) as drivers activate and de-activate.
> 
> So I think each clock could be a power resource.  It looks like the
> current code isn't doing much more than turning them on and off. 

They should clk_use()/clk_unuse(), and automatically handle the
activation/deactivation of parent clocks.  Some clocks are shared
between multiple devices ... so "on/off" doesn't suffice, those
devices' drivers rely on the clock framework to coordinate.  (Or
were you thinking that on/off would match use/unuse?  There's no
point to separate enable/disable calls IMO.)

If there were strong advantages to fitting those into a new resource
framework, that could surely be done.  I think any driver actually
touching a clock will be platform-specific, but there's not much
point to having different clock APIs on every platform.  (Other
than experimenting, which could be useful for a while yet.)


> I'm 
> curious about changing the frequency.  In what cases might this happen?

One example I noticed recently:  the driver for an audio codec needed
to change the frequency driving that chip.  That's for a clock that goes
off-chip.  Likewise setting clocks used to drive LCD controllers at a
specific speed; and in another case, setting the clock to match what
was used on an internal bus.  Again this mostly seems like init-and-forget.

There's also cpufreq style stuff.  If someone implements that for OMAP
it'll need to account for a variety of constraints.  For now it seems
that just idling the CPU -- or putting it into big sleep -- is enough
of a win for power saving that cpufreq may not be much wanted.


> Would it be related to power state of the device, or could the frequency
> be changed without changing the state?

Frequency affects power consumption in device-specific ways, but so
far the focus in Linux is just to affect it by ensuring that clocks
are off unless they're needed.  That includes enabling hardware clock
gating support.  (OMAP automates clock gating a lot more than other chips
I've had occasion to look at.)  I suspect _most_ boards expect a single
frequency for each device (plus zero-Hertz).


> Is the frequency a specific 
> requirement of the device that isn't intended to be changed at all?

That's specific to the device and its driver.  There are lots of drivers
that don't much care about details of frequencies ... only that clocks
fed to their various busses and bridges are all in "safe" ratios.  And
there are sometimes also external constraints, e.g. with that codec or
with USB.


> I think adding more than on and off might get to be too complicated, but
> clearly every power resource we're interested in has an on/off
> capability.  If we really need this sort of functionality to be handled
> by the power management subsystem, then maybe we could have a "struct
> power_clock" with a "struct power_resource" inside of it?  Maybe the
> drivers should be handling these sort of things on their own?  I'm
> interested in how drivers will be interacting with this.

Me too.  I think ARM has the best-worked Linux clock infrastructure
just now, and the model there is that drivers manage their clocks
explicitly and without any formal platform_device.resource entries.
(Should power resources be treated like any other resources?)

That's one reason I pointed you at OMAP's clock code.  It's working
reasonably well right now, and it's a case where simple APIs to clock
trees won't work well ... e.g. PXA, or AT91, chips have really simple
clock trees.  More like mach-s3c2410/clock.c in 2.6.current.

OMAP's is complex (deep hierarchy, autogating, very flexible) and is
also chip-specific at the detail level.  For example, the USB host
clock is set up differently on 1510/590 vs later chips; and those
later ones have two different MMC controllers, independently clocked.
So it's a rich enough real-world-Linux example to chew on a while.  :)

- Dave


 

--===============17280664462257378==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============17280664462257378==--
