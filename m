From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach completes
Date: Thu, 20 Nov 2014 21:56:28 +0100
Message-ID: <5824227.jcJU6stFvy@vostro.rjw.lan>
References: <20141117220238.GE5258@dtor-ws> <4182833.JTef00bpdk@vostro.rjw.lan> <CAPDyKFo-b7wB7DJifwX0ARu8GJYQmSn6W5NDs4++BvO5LTVGEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo-b7wB7DJifwX0ARu8GJYQmSn6W5NDs4++BvO5LTVGEA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, November 20, 2014 11:13:01 AM Ulf Hansson wrote:
> On 20 November 2014 01:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrot=
e:
> > On Wednesday, November 19, 2014 09:54:00 AM Ulf Hansson wrote:
> >> [...]
> >>
> >> >>
> >> >> Scenario 5), a platform driver with/without runtime PM callback=
s.
> >> >> ->probe()
> >> >> - do some initialization
> >> >> - may fetch handles to runtime PM resources
> >> >> - pm_runtime_enable()
> >> >
> >> > Well, and now how the driver knows if the device is "on" before =
accessing it?
> >>
> >> In this case the driver don't need to access the device during
> >> ->probe(). That's postponed until sometime later.
> >
> > If this is a platform driver, it rather does need to access the dev=
ice,
> > precisely because it doesn't know what power state the device is in=
 otherwise.
> > See below.
> >
> >> >> Note 1)
> >> >> Scenario 1) and 2), both relies on the approach to power on the=
 PM
> >> >> domain by using pm_runtime_get_sync(). That approach didn't wor=
k when
> >> >> CONFIG_PM_RUNTIME was unset, but we recently decided to fixed t=
hat by
> >> >> the below patch, so that's good!
> >> >> "[PATCH] PM / domains: Kconfig: always enable PM_RUNTIME when g=
enpd enabled"
> >> >>
> >> >> Note 2)
> >> >> Scenario 3) and 4) use the same principles for managing runtime=
 PM.
> >> >> These scenarios needs a way to power on the generic PM domain p=
rior
> >> >> probing the device. The call to pm_runtime_set_active(), preven=
ts an
> >> >> already powered PM domain from power off until after probe, but=
 that's
> >> >> not enough.
> >> >>
> >> >> Note 3)
> >> >> The $subject patch, tried to address the issues for scenario 3)=
 and
> >> >> 4). It does so, but will affect scenario 5) which was working n=
icely
> >> >> before. In scenario 5), the $subject patch will cause the gener=
ic PM
> >> >> domain to potentially stay powered after ->probe() even if the =
device
> >> >> is runtime PM suspended.
> >> >
> >> > Why would it?  If the device is runtime-suspended, the domain wi=
ll know
> >> > that, because its callbacks will be used for that.  At least, th=
at's
> >> > what I'd expect to happen, so is there a problem here?
> >>
> >> Genpd do knows about the device but it doesn=E2=80=99t get a "noti=
fication" to
> >> power off. There are no issues whatsoever for driver.
> >
> > Except that the driver is arguably buggy.
> >
> >> This is a somewhat special case. Let's go through an example.
> >>
> >> 1. The PM domain is initially in powered off state.
> >> 2. The bus ->probe() invokes dev_pm_domain_attach() and then the P=
M
> >> domain gets attached to the device.
> >> 3. $subject patch causes the PM domain to power on.
> >> 4. A driver ->probe() sequence start, following the Scenario 5).
> >> 5. The device is initially in runtime PM suspended state and it wi=
ll
> >> remain so during ->probe().
> >
> > But is it physically suspended?
> >
> > The runtime PM status of the device after ->probe is required to re=
flect its
> > real state if runtime PM is enabled.  If that's not the case, it is=
 a bug.
>=20
> Agree.
>=20
> While I was searching for drivers that behave as in scenario 5), they
> tend to register some subsystem specific callbacks and don't access
> the device until some of those callbacks are invoked.
>=20
> At least that was my interpretation of their ->probe() methods, but
> it's not always easy to tell how those callbacks are being used for
> each subsystem.
>=20
> >
> > Now, for platform drivers, the driver can't really assume anything =
in
> > particular about the current power state of the device at ->probe t=
ime,
> > because different platforms including devices handled by that drive=
r may
> > behave differently.
> >
> > A good example would be two platforms A and B where the same device=
 X is in a
> > power domain such that A boots with the domain (physically) "on", w=
hile B boots
> > with the domain "off".  If the driver for X assumes anything about =
the initial
> > power state of the device, it may not work on either A or B.
>=20
> I get your point and agree!
>=20
> >
> >> 6. The pm_request_idle() invoked after really_probe() in driver co=
re,
> >> won't trigger a runtime PM suspend callback to be invoked. In othe=
r
> >> words, genpd don't get a "notification" that it may power off.
> >>
> >> In this state, genpd will either power off from the late_initcall,
> >> genpd_poweroff_unused() (depending on when the driver was probed) =
or
> >> wait until some device's runtime PM suspend callback is invoked at=
 any
> >> later point.
> >
> > Which sounds OK to me, so why is it a problem?
>=20
> The late_initcall doesn't work for modules.
>=20
> Also, suppose the PM domain only holds this "inactive device" that wa=
s
> probed as in scenario 5). Then, you could end up having the PM domain
> powered, even if it isn't needed.
>=20
> Anyway, I can live with this. It's likely the driver that behave as i=
n
> scenario 5) that should be fixed as you stated.
>=20
> >
> >> >> I see three options going forward.
> >> >>
> >> >> Option 1)
> >> >> Convert scenario 3) and 4) into using the pm_runtime_get_sync()
> >> >> approach. There are no theoretical obstacles to do this, but pu=
re
> >> >> practical. There are a lot of drivers that needs to be converte=
d and
> >> >> we also need to teach driver authors future wise to not use
> >> >> pm_runtime_set_active() in this manner.
> >> >
> >> > I'd say we need to do something like this anyway.  That is, stan=
dardize on
> >> > *one* approach.  I'm actually not sure what approach is the most=
 useful,
> >> > but the pm_runtime_get_sync() one seems to be the most popular t=
o me.
> >> >
> >> >> Option 2)
> >> >> Add some kind of get/put API for PM domains. The buses invokes =
it to
> >> >> control the power to the PM domain. From what I understand, tha=
t's
> >> >> also what Dmitry think is needed!?
> >> >> Anyway, that somehow means to proceed with the approach I took =
in the
> >> >> below patchset.
> >> >> [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
> >> >> http://marc.info/?t=3D141320907000003&r=3D1&w=3D2
> >> >
> >> > I don't like that.  The API is already quite complicated in my v=
iew and
> >> > adding even more complexity to it is not going to help in the lo=
ng run.
> >>
> >> I absolutely agree that we shouldn't add unnecessary APIs and keep
> >> APIs as simple as possible.
> >>
> >> In that context, I think the effect from proceeding with Option 2)
> >> also means there are no need for the below APIs any more.
> >> pm_genpd_poweron()
> >> pm_genpd_name_poweron() (requires some additional work though)
> >> pm_genpd_poweroff_unused()
> >> pm_genpd_dev_need_restore()
> >>
> >> I guess you figured out that I am in favour of Option 2). :-)
> >> Especially since it cover all scenarios and we don't have to go a =
fix
> >> a vast amount of drivers.
> >
> > Adding more callbacks to struct dev_pm_domain just in order to hand=
le some
> > genpd-specific use case is out of the question.  If you find a way =
within
> > genpd to address this the way you like, I'm open for ideas.  Otherw=
ise,
> > let's just do what I said.
> >
> >> >
> >> >> Option 3)
> >> >> Live we the limitation this $subject patch introduces for scena=
rio 5).
> >> >
> >> > I'd say, 3) for now and 1) going forward.
> >>
> >> This could work!
> >>
> >> The hardest part is to know when we should revert $subject patch, =
to
> >> fix the regression introduced for scenario 5).
> >
> > Well, I don't think so.
> >
> > First of all, there is a (very) limited number of platforms using g=
enpd today
> > and it should be perfectly possible to go through the platform driv=
ers used
> > by them and see which of those drivers are affected.  Fixing them s=
hould not
> > be too hard either.
>=20
> Considering that scenario 5) probably exists because of buggy drivers
> and that the related issues is very limited, I am perfectly fine with
> your proposal!
>=20
> Will you queue this patch then?

I will, but I'll change the first line of the changelog to read: "Vast =
amount
of platform drivers enables runtime PM, [...]" (ie. leave out AMBA from=
 there).

Rafael
