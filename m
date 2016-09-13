From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v2 0/7] Functional dependencies between devices
Date: Wed, 14 Sep 2016 01:18:16 +0200
Message-ID: <4860126.rVrMyhOcY1@vostro.rjw.lan>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <CAJZ5v0hS1FtqmsaqT03sMyGW8==UxTo-uFZkzueF=pFPHWjOdA@mail.gmail.com> <20160913175731.GA1393@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53131 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1758095AbcIMXMJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 19:12:09 -0400
In-Reply-To: <20160913175731.GA1393@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>

On Tuesday, September 13, 2016 07:57:31 PM Lukas Wunner wrote:
> On Sun, Sep 11, 2016 at 12:04:36AM +0200, Rafael J. Wysocki wrote:
> > On Sat, Sep 10, 2016 at 1:39 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > > On Thu, Sep 08, 2016 at 11:25:44PM +0200, Rafael J. Wysocki wrote:
> > >> As discussed in the recent "On-demand device probing" thread and in a
> > >> Kernel Summit session earlier today, there is a problem with handling
> > >> cases where functional dependencies between devices are involved.
> > >>
> > >> What I mean by a "functional dependency" is when the driver of device B
> > >> needs both device A and its driver to be present and functional to be
> > >> able to work.  This implies that the driver of A needs to be working
> > >> for B to be probed successfully and it cannot be unbound from the
> > >> device before the B's driver.  This also has certain consequences for
> > >> power management of these devices (suspend/resume and runtime PM
> > >> ordering).
> > >
> > > As a general observation, this series seems to conflate two
> > > separate issues:
> > >
> > > (a) non-hierarchical device dependencies
> > >     (a device depends on another device which is not its parent
> > >     with regards to (runtime) suspend/resume ordering)
> > 
> > You need to say what it means that one device depends on another one.
> > Without that you don't get anything useful.
> 
> As stated above, what it means is that "a device depends on another device
> with regards to (runtime) suspend/resume ordering".

But this series isn't only about suspend/resume, which seems to be your point,
right?

> > > (b) driver-presence dependencies
> > >     (a device depends on another device to be bound to a driver
> > >     before it can probe / must be unbound before the other device
> > >     can unbind)
> > >
> > > Those two issues are orthogonal.
> > 
> > No, they aren't.
> > 
> > At least for a number of devices (quite likely it would be safe to say
> > that for the majority of them I think) the supplier can only provide
> 
> You got numbers to back up the majority claim?

This isn't a claim (which is why I said "quite likely" and so on).

I have examples, though.  I2C/SPI/GPIO controllers providing connections/pins
to devices that aren't their children, IOMMUs.

> > any useful service to its consumers when it has a driver bound to it
> > and running and the consumers cannot operate correctly without that
> > service.  That's why the "unbind consumers before unbinding the
> > supplier" logic is in there.
> > 
> > And in the context of this series a "dependency" boils down to the
> > ordering of execution of callbacks of certain type.  Like, for
> > example, "can I execute ->runtime_suspend() for device A before
> > executing it for device B?"  If there's a link between A and B where
> > the former is the supplier, the answer is "no".  The reason why is the
> > assumption that after ->runtime_suspend() A will stop responding and
> > will not be able to provide the service in question to B any more.
> > 
> > Likewise, if the driver of A goes away, this device will not be able
> > to provide the service in question to B any more, so it doesn't make
> > sense for the driver of B to still be running then.
> > 
> > This is the case I wanted to cover with this series if it was not clear
> > before.
> 
> That much was clear to me. I maintain that dependency with regards to
> suspend/resume ordering and dependency with regards to driver presence
> are two different things. The case you wanted to cover just happens to
> be a combination of the two. The series would be more useful if either
> type of dependency could be achieved without gratuitously also getting
> the other type.

It looks like you're referring to the previous iteration of the series here.

> You could make the case that providing two separate APIs seems
> wasteful since it would increase the amount of code and sometimes
> both types of dependency are required at the same time anyway.
> That would be a valid argument.

Well, that was my thinking, but I guess it wasn't clearly stated.

Maybe except that IMO it is "sometimes one type of the dependency is not
required" rather than the other way around.

> But you should design the API thus that either dependency type is optional.
> 
> Providing just dependency with regards to suspend/resume ordering
> should be as simple as adding a "DEVICE_LINKS_DRIVER_DONT_CARE" flag.
> Then the various calls that you're adding in dd.c would only have to
> be called if the flag isn't set, same for the various places where
> you check the link state.

OK, fair enough.  But that could be added later too.

> > Of course, you don't like what device_links_unbind_consumers() does
> > because of your "Thunderbolt on Macs" use case, but guess what,
> 
> To name a different use case: On hybrid graphics laptops, the discrete
> GPU usually includes an HDA controller for external HDMI displays.
> The GPU and the HDA controllers are siblings (functions 0 and 1 of a
> PCI slot), yet in many laptops power is cut to both devices when _PS3
> is executed for the GPU function. Currently we have a kludge where
> the HDA controller is suspended before the GPU is powered down
> (see vga_switcheroo_init_domain_pm_optimus_hdmi_audio()).
> 
> I envision the HDA controller to be a consumer of the GPU in those
> cases, thus ensuring that it's suspended before power is cut.

So this example isn't a good one IMO.  That clearly is a case when two
(or more) devices share power resources controlled by a single on/off
switch.  Which is a clear use case for a PM domain.

> The way your series works right now, the HDA controller can't be
> bound unless the GPU is bound. That restriction is unnecessary.

That depends on when the link is created, actually.  If the link is created
in the "active" state from the supplier probe, there's no such restriction
AFAICS.

The restriction is only there if (a) that is a permanent link and (b) it
was created before probing both the supplier and the consumer.

> I've also heard from the i915 folks that on some Intel chipsets, the
> integrated HDA controller depends on power wells that are controlled
> by the integrated GPU. I'm not sure if a driver for the GPU needs
> to be present in this use case.
> 
> 
> > you can add a link flag to keep the consumer around when the supplier
> > driver goes away.  I just don't want that to be the default behavior.
> 
> I assume you're referring to the DEVICE_LINK_PERSISTENT flag and that
> a separate patch is needed to make this work, as you've pointed out
> in your e-mail of Sep 7.

No, I'm not.  I was thinking about something like the DEVICE_LINKS_DRIVER_DONT_CARE
you mentioned above.  It would be easy enough to add on top of this series,
but I can put it in there if you insist.

> According to the commit message, such links need to be added before
> the consumer probes, which I fear will require addition of PCI quirks.
> That's not very pretty, a DEVICE_LINKS_DRIVER_DONT_CARE flag would
> seem preferrable.

The commit message may be outdated.

With the series as is you can create a link in (almost) any state from
anywhere.

> > > E.g. a driver-presence dependency may exist between a child and a
> > > parent, or between siblings, whereas a non-hierarchical device
> > > dependency by definition cannot exist between child/parent.
> > >
> > > Let's say I need a driver-presence dependency between parent/child.
> > > The PM core already guarantees correct (runtime) suspend/resume
> > > ordering between child. Device links duplicate that functionality.
> > > Oops?
> > 
> > No, they don't and that should be clear.
> > 
> > They are for out-of-the-tree dependencies only and the parent-child
> > one is *in* the tree.
> 
> I'm sure there are situations where a driver presence dependency
> is needed between parent/child and you should fully expect that
> developers will try to employ device links for these use cases.
> Which means that the code for suspend/resume device ordering is
> executed twice.

Creating a link between a parent and child would be a bug.  I guess
device_link_add() should just return NULL on an attempt to do that.

Thanks,
Rafael

