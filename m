From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Tue, 20 Oct 2015 09:56:14 +0200
Message-ID: <4025469.zmyipZqCsP@vostro.rjw.lan>
References: <561E1378.6000906@collabora.com> <1603415.VWFZ8V0WMC@vostro.rjw.lan> <CAL_JsqKa3MFJUWKV2KxPE_NmrP2g4dOD3zr+0Kyx4yBkDOg2HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqKa3MFJUWKV2KxPE_NmrP2g4dOD3zr+0Kyx4yBkDOg2HA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Terje =?ISO-8859-1?Q?Bergstr=F6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdw>
List-Id: linux-pm@vger.kernel.org

On Monday, October 19, 2015 05:58:40 PM Rob Herring wrote:
> On Mon, Oct 19, 2015 at 4:40 PM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org=
> wrote:
> > On Monday, October 19, 2015 10:58:25 AM Rob Herring wrote:
> >> On Mon, Oct 19, 2015 at 10:29 AM, David Woodhouse <dwmw2@infradead=
=2Eorg> wrote:
> >> > On Mon, 2015-10-19 at 15:50 +0100, Mark Brown wrote:
> >> >> > But the point I'm making is that we are working towards *fixi=
ng* that,
> >> >> > and *not* using DT-specific code in places where we should be=
 using the
> >> >> > generic APIs.
> >> >>
> >> >> What is the plan for fixing things here?  It's not obvious (at =
least to
> >> >> me) that we don't want to have the subsystems having knowledge =
of how
> >> >> they are bound to a specific firmware which is what you seem to=
 imply
> >> >> here.
> >> >
> >> > I don't know that there *is* a coherent plan here to address it =
all.
> >> >
> >> > Certainly, we *will* need subsystems to have firmware-specific
> >> > knowledge in some cases. Take GPIO as an example; ACPI *has* a w=
ay to
> >> > describe GPIO, and properties which reference GPIO pins are inte=
nded to
> >> > work through that =E2=80=94 while in DT, properties which refere=
nce GPIO pins
> >> > will have different contents. They'll be compatible at the drive=
r
> >> > level, in the sense that there's a call to get a given GPIO give=
n the
> >> > property name, but the subsystems *will* be doing different thin=
gs
> >> > behind the scenes.
> >> >
> >> > My plan, such as it is, is to go through the leaf-node drivers w=
hich
> >> > almost definitely *should* be firmware-agnostic, and convert tho=
se. And
> >> > then take stock of what we have left, and work out what, if anyt=
hing,
> >> > still needs to be done.
> >>
> >> Many cases are already agnostic in the drivers in terms of the *_g=
et()
> >> functions. Some are DT specific, but probably because those subsys=
tems
> >> are new and DT only. In any case, I don't think these 1 line chang=
es
> >> do anything to make doing conversions here harder.
> >>
> >> >> It seems like we're going to have to refactor these bits of cod=
e when
> >> >> they get generalised anyway so I'm not sure that the additional=
 cost
> >> >> here is that big.
> >> >
> >> > That's an acceptable answer =E2=80=94 "we're adding legacy code =
here but we
> >> > know it's going to be refactored anyway". If that's true, all it=
 takes
> >> > is a note in the commit comment to that effect. That's different=
 from
> >> > having not thought about it :)
> >>
> >> Considering at one point we did create a fwnode based API, we did
> >> think about it. Plus there was little input from ACPI folks as to
> >> whether the change was even useful for ACPI case.
> >
> > Well, sorry, but who was asking whom, specifically?
>=20
> You and linux-acpi have been copied on v2 and later of the entire
> series I think.

Yes, but it wasn't like a direct request, say "We need your input, so c=
an you
please have a look and BTW we want this in 4.4, so please do it ASAP". =
 In
which case I'd prioritize that before other things I needed to take car=
e of.

> > The underlying problem is present in ACPI too and we don't really h=
ave a good
> > solution for it.  We might benefit from a common one if it existed.
>=20
> The problem for DT is we don't generically know what are the
> dependencies at a core level. We could know some or most dependencies
> if phandles (links to other nodes) were typed, but they are not. If
> the core had this information, we could simply control the device
> creation to order probing. Instead, this information is encoded into
> the bindings and binding parsing resides in the subsystems. That
> parsing happens during probe of the client side and is done by the
> subsystems (for common bindings). Since we already do the parsing at
> this point, it is a convenient place to trigger the probe of the
> dependency. Is ACPI going to be similar in this regard?

It is similar in some ways.  For example, if a device's functionality d=
epends
on an I2C resource (connection), the core doesn't know that at the devi=
ce
creation time at least in some cases.  Same for GPIO, SPI, DMA engines =
etc.

There is a _DEP object in ACPI that can be used by firmware to tell the=
 OS
about those dependencies, but there's no way in the driver core to use =
that
information anyway today.

> Fundamentally, it is a question of probe devices when their
> dependencies are present or drivers ensure their dependencies are
> ready. IIRC, init systems went thru a similar debate for service
> dependencies.

The probe ordering is not the entire picture, though.

Even if you get the probe ordering right, the problem is going to show =
up in
multiple other places: system suspend/resume, runtime PM, system shutdo=
wn,
unbinding of drivers.  In all of those cases it is necessary to handle =
things
in a specific order if there is a dependency.

> >> In any case, we're talking about adding 1 line.
> >
> > But also about making the driver core slighly OF-centric.
>=20
> How so? The one line is in DT binding parsing code in subsystems, not
> driver core. The driver core change is we add every device (that
> happened to be created by DT) to the deferred probe list, so they
> don't probe right away.

The "that happened to be created by DT" part is of concern here.  What =
is there
that makes DT special in that respect?  Why shouldn't that be applicabl=
e to
devices created by the ACPI core, for example, or by a board file or so=
mething
else?

> > Sure, we need OF-specific code and ACPI-specific code wherever diff=
erent
> > handling is required, but doing that at the driver core level seems=
 to be
> > a bit of a stretch to me.
> >
> > Please note that we don't really have ACPI-specific calls in the dr=
iver core,
> > although we might have added them long ago even before the OF stuff=
 appeared
> > in the kernel for the first time.  We didn't do that, (among other =
things)
> > because we didn't want that particular firmware interface to appear=
 special
> > in any way and I'm not really sure why it is now OK to make OF look=
 special
> > instead.
>=20
> I don't think DT is special and we avoid DT specific core changes as
> much as possible. I think the difference is DT uses platform_device
> and ACPI does not.

ACPI uses platform devices too.  In fact, ACPI device objects are enume=
rated as
platform devices by default now.

Or do you means something else here?

> It used to be separate, but got merged together primarily to support =
the
> plethora of existing drivers. Anyway, that is all outside of anything=
 in this
> series.

It explains the context of the series, so it is useful to talk about IM=
O.

>=20
> > If it is trivial to avoid that (and you seem to be arguing that it =
is), why
> > do we have to do it?
>=20
> Sorry, I don't follow what "that" or "it" is.

OK, so maybe I misunderstood you, sorry about that.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
