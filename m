From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [RFC] A New Power Management API
Date: Sun, 17 Apr 2005 16:48:34 -0400
Message-ID: <1113770914.3451.107.camel@localhost.localdomain>
References: <1113533193.3451.40.camel@localhost.localdomain>
	<20050415095003.52f3185a@cosmic.amd.com>
	<1113591290.3451.79.camel@localhost.localdomain>
	<200504161124.05846.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============026326858694452504=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504161124.05846.david-b@pacbell.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============026326858694452504==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-04-16 at 11:24 -0700, David Brownell wrote:
> On Friday 15 April 2005 11:54 am, Adam Belay wrote:
> > On Fri, 2005-04-15 at 09:50 -0600, Jordan Crouse wrote:
> > > Adam - 
> > > 
> > > Nice stuff.  A few comments.  First, a question:
> > > 
> > > Is it safe to assume that PMU devices  (like these:
> > >  http://www.dialog-semiconductor.com/template.php?page_id=62) would fall
> > > under the category of Power Resources?  if so, we may need to consider
> > > some more advanced hooks than just on/off.
> > 
> > I'm not familiar with how we would control such a device from software.
> > If you think more than _ON and _OFF would be necessary, I could
> > certainly revise this code.  
> 
> Other similar devices include the TI TPS6501x series:
> 
>   http://focus.ti.com/docs/prod/folders/print/tps65010.html
> 
> One of these moments I'll submit the driver I wrote for use with
> OMAP; it's pretty minimalist just now, but tps65010.c is in BK at:
> 
>   http://linux-omap.bkbits.net:8080/main/src/drivers/i2c/chips
> 
> Yes, more than "on" and "off" is necessary.  Lots of drivers
> build on that.  Currently most of them just access the GPIOs
> it provides, interact with battery recharging, or control
> various aspects of system power state transitions.  The hardware
> defaults manage a "not-fast" battery recharge, so battery based
> systems "just work".

Ok, so I think each power plane (or LDO or whatever) would be a power
resource, not the controller itself.

> 
> That driver doesn't yet do anything like forcing a system suspend
> when battery power goes dangerously low, or even feeding IRQs to
> other drivers.  Much less monitoring battery recharge or managing
> fast recharge.  That is, it's incomplete ... so all you will see
> right now is stuff that's essential even for devel boards that
> mostly run on AC power.  No UI is supported yet.

I've looked through the code.  I appreciate the information.

> 
> Those Dialog devices have a slightly different functional mix.
> Motorola also has similar parts, also used in cell phones.
> 
> One small point to notice:  this is an I2C driver, but it needs
> to initialize quite early on most boards, since it's used to power
> up other devices (including often the DSP).  So the system init
> sequence has been adjusted to make that behave:  I2C initializes
> early (subsys_initcall), as does this specific I2C driver.

Yeah, sounds like that could get rather tricky.

> 
> 
> > ACPI only supports _ON and _OFF in its 
> > model.  More complex stuff is handled by the state of the device.
> > 
> >     ---(power_resource)
> >     |        |
> > domain -> device
> > 
> > In my design, power resources are specific power planes and clocks that
> > belong to a given power domain (or that domain's parent).  They often
> > depend on the state of the domain or the system state.  A device may
> > require multiple power resources, but can only belong to one power
> > domain.
> 
> But power domains must be able to belong to other power domains,
> and the domains are themselves power devices... so there's a fair
> amount of "inheritance" going on.

Correct "power devices" use an inheritance model.  "power resources" can
be independent of the inheritance and belong to the global system pool.
I think this can cover most platforms.

> 
> 
> > I could see something like having a clock put at a slower 
> > speed, so maybe we do need more than on and off.
> 
> How would you handle the ARM clock trees?  E.g. the stuff you'll
> find in arch/arm/mach-omap/clock.c in 2.6.12-rc2?  (Older versions
> are very similar, the latest version in the linux-omap tree above
> can be made to disable unused clocks at boot time.)  My initial
> thought was that these specific resources wouldn't show up as any
> kind of power resource, since they're already managed properly
> (by clk_use/clk_unuse) as drivers activate and de-activate.

So I think each clock could be a power resource.  It looks like the
current code isn't doing much more than turning them on and off.  I'm
curious about changing the frequency.  In what cases might this happen?
Would it be related to power state of the device, or could the frequency
be changed without changing the state?  Is the frequency a specific
requirement of the device that isn't intended to be changed at all?

I think adding more than on and off might get to be too complicated, but
clearly every power resource we're interested in has an on/off
capability.  If we really need this sort of functionality to be handled
by the power management subsystem, then maybe we could have a "struct
power_clock" with a "struct power_resource" inside of it?  Maybe the
drivers should be handling these sort of things on their own?  I'm
interested in how drivers will be interacting with this.

Thanks,
Adam



--===============026326858694452504==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============026326858694452504==--
