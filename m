From: Rob Herring <robh@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Tue, 20 Oct 2015 09:15:01 -0500
Message-ID: <CAL_JsqJuu5_Osqi+X6M6UeRDZFQB+_8riYDF1gvsGayk5-4SFw@mail.gmail.com>
References: <561E1378.6000906@collabora.com> <1603415.VWFZ8V0WMC@vostro.rjw.lan>
 <CAL_JsqKa3MFJUWKV2KxPE_NmrP2g4dOD3zr+0Kyx4yBkDOg2HA@mail.gmail.com> <4025469.zmyipZqCsP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <4025469.zmyipZqCsP@vostro.rjw.lan>
Sender: linux-clk-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: David Woodhouse <dwmw2@infradead.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Liam Girdwood <lgirdwoo>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 20, 2015 at 2:56 AM, Rafael J. Wysocki <rjw@rjwysocki.net> =
wrote:
> On Monday, October 19, 2015 05:58:40 PM Rob Herring wrote:
>> On Mon, Oct 19, 2015 at 4:40 PM, Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>> > On Monday, October 19, 2015 10:58:25 AM Rob Herring wrote:
>> >> On Mon, Oct 19, 2015 at 10:29 AM, David Woodhouse <dwmw2@infradea=
d.org> wrote:
>> >> > On Mon, 2015-10-19 at 15:50 +0100, Mark Brown wrote:
>> >> >> > But the point I'm making is that we are working towards *fix=
ing* that,
>> >> >> > and *not* using DT-specific code in places where we should b=
e using the
>> >> >> > generic APIs.
>> >> >>
>> >> >> What is the plan for fixing things here?  It's not obvious (at=
 least to
>> >> >> me) that we don't want to have the subsystems having knowledge=
 of how
>> >> >> they are bound to a specific firmware which is what you seem t=
o imply
>> >> >> here.
>> >> >
>> >> > I don't know that there *is* a coherent plan here to address it=
 all.
>> >> >
>> >> > Certainly, we *will* need subsystems to have firmware-specific
>> >> > knowledge in some cases. Take GPIO as an example; ACPI *has* a =
way to
>> >> > describe GPIO, and properties which reference GPIO pins are int=
ended to
>> >> > work through that =E2=80=94 while in DT, properties which refer=
ence GPIO pins
>> >> > will have different contents. They'll be compatible at the driv=
er
>> >> > level, in the sense that there's a call to get a given GPIO giv=
en the
>> >> > property name, but the subsystems *will* be doing different thi=
ngs
>> >> > behind the scenes.
>> >> >
>> >> > My plan, such as it is, is to go through the leaf-node drivers =
which
>> >> > almost definitely *should* be firmware-agnostic, and convert th=
ose. And
>> >> > then take stock of what we have left, and work out what, if any=
thing,
>> >> > still needs to be done.
>> >>
>> >> Many cases are already agnostic in the drivers in terms of the *_=
get()
>> >> functions. Some are DT specific, but probably because those subsy=
stems
>> >> are new and DT only. In any case, I don't think these 1 line chan=
ges
>> >> do anything to make doing conversions here harder.
>> >>
>> >> >> It seems like we're going to have to refactor these bits of co=
de when
>> >> >> they get generalised anyway so I'm not sure that the additiona=
l cost
>> >> >> here is that big.
>> >> >
>> >> > That's an acceptable answer =E2=80=94 "we're adding legacy code=
 here but we
>> >> > know it's going to be refactored anyway". If that's true, all i=
t takes
>> >> > is a note in the commit comment to that effect. That's differen=
t from
>> >> > having not thought about it :)
>> >>
>> >> Considering at one point we did create a fwnode based API, we did
>> >> think about it. Plus there was little input from ACPI folks as to
>> >> whether the change was even useful for ACPI case.
>> >
>> > Well, sorry, but who was asking whom, specifically?
>>
>> You and linux-acpi have been copied on v2 and later of the entire
>> series I think.
>
> Yes, but it wasn't like a direct request, say "We need your input, so=
 can you
> please have a look and BTW we want this in 4.4, so please do it ASAP"=
=2E  In
> which case I'd prioritize that before other things I needed to take c=
are of.

=46air enough. Can you please review and comment on v7 of the series? W=
e
can discuss at KS as well.

>> > The underlying problem is present in ACPI too and we don't really =
have a good
>> > solution for it.  We might benefit from a common one if it existed=
=2E
>>
>> The problem for DT is we don't generically know what are the
>> dependencies at a core level. We could know some or most dependencie=
s
>> if phandles (links to other nodes) were typed, but they are not. If
>> the core had this information, we could simply control the device
>> creation to order probing. Instead, this information is encoded into
>> the bindings and binding parsing resides in the subsystems. That
>> parsing happens during probe of the client side and is done by the
>> subsystems (for common bindings). Since we already do the parsing at
>> this point, it is a convenient place to trigger the probe of the
>> dependency. Is ACPI going to be similar in this regard?
>
> It is similar in some ways.  For example, if a device's functionality=
 depends
> on an I2C resource (connection), the core doesn't know that at the de=
vice
> creation time at least in some cases.  Same for GPIO, SPI, DMA engine=
s etc.

So you will need to create devices, defer their probing and then probe
on demand as well unless you have other ideas how you would do it.

> There is a _DEP object in ACPI that can be used by firmware to tell t=
he OS
> about those dependencies, but there's no way in the driver core to us=
e that
> information anyway today.

I would think that the equivalent function for ACPI to of_device_probe
could process these if they are generic and you can associate the
dependency to a struct device.

>> Fundamentally, it is a question of probe devices when their
>> dependencies are present or drivers ensure their dependencies are
>> ready. IIRC, init systems went thru a similar debate for service
>> dependencies.
>
> The probe ordering is not the entire picture, though.
>
> Even if you get the probe ordering right, the problem is going to sho=
w up in
> multiple other places: system suspend/resume, runtime PM, system shut=
down,
> unbinding of drivers.  In all of those cases it is necessary to handl=
e things
> in a specific order if there is a dependency.

My understanding was with deferred probe that it also solves suspend
ordering problems because things are suspended in reverse order of
probing. I suppose you could have slightly different dependencies for
suspend, runtime PM, etc. than for probe? Perhaps we need to save the
list of dependencies as we probe them. I don't think that would be too
hard to add on to this series, but then if we don't need it now, why
add it?

>> >> In any case, we're talking about adding 1 line.
>> >
>> > But also about making the driver core slighly OF-centric.
>>
>> How so? The one line is in DT binding parsing code in subsystems, no=
t
>> driver core. The driver core change is we add every device (that
>> happened to be created by DT) to the deferred probe list, so they
>> don't probe right away.
>
> The "that happened to be created by DT" part is of concern here.  Wha=
t is there
> that makes DT special in that respect?  Why shouldn't that be applica=
ble to
> devices created by the ACPI core, for example, or by a board file or =
something
> else?

DT is first. I think both examples could use this. Board files avoid
the problem by controlling the registration order with initcall levels
and just the call order in the code. You could come up with some way
to define dependencies for devices in board files and reuse this
mechanism. ACPI could use this as well if the dependencies are handled
in a similar way and it seems like they could be.

>> > Sure, we need OF-specific code and ACPI-specific code wherever dif=
ferent
>> > handling is required, but doing that at the driver core level seem=
s to be
>> > a bit of a stretch to me.
>> >
>> > Please note that we don't really have ACPI-specific calls in the d=
river core,
>> > although we might have added them long ago even before the OF stuf=
f appeared
>> > in the kernel for the first time.  We didn't do that, (among other=
 things)
>> > because we didn't want that particular firmware interface to appea=
r special
>> > in any way and I'm not really sure why it is now OK to make OF loo=
k special
>> > instead.
>>
>> I don't think DT is special and we avoid DT specific core changes as
>> much as possible. I think the difference is DT uses platform_device
>> and ACPI does not.
>
> ACPI uses platform devices too.  In fact, ACPI device objects are enu=
merated as
> platform devices by default now.

Okay, I should have grepped for that:
drivers/base/platform.c:                ACPI_COMPANION_SET(&pdev->dev, =
NULL);
drivers/base/platform.c:        len =3D acpi_device_modalias(dev, buf,
PAGE_SIZE -1);
drivers/base/platform.c:        rc =3D acpi_device_uevent_modalias(dev,=
 env);
drivers/base/platform.c:        /* Then try ACPI style match */
drivers/base/platform.c:        if (acpi_driver_match_device(dev, drv))

These are all cases which have DT version as well, so we're not really
all that different here. There's a few more for DT, but that probably
means you have just not hit the problems we have yet. For example,
what happens if you have an interrupt line in which the controller is
probed after the device connected to the interrupt line? That required
resolving irqs in platform_get_irq rather than using static resources
to support deferred probe.

Converting things like this to fwnode calls isn't hard to do. There
just hasn't been a pressing need or mandate to do so.

Rob
