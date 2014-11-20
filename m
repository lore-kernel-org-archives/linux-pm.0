From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Power on the PM domain right after attach completes
Date: Thu, 20 Nov 2014 01:35:49 +0100
Message-ID: <4182833.JTef00bpdk@vostro.rjw.lan>
References: <20141117220238.GE5258@dtor-ws> <3492523.qBADTmdTqo@vostro.rjw.lan> <CAPDyKFoiEMO5E3nMJDZkFkuio-5sh99m55k-yM=fuqrHUXbhZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55981 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756964AbaKTAOo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Nov 2014 19:14:44 -0500
In-Reply-To: <CAPDyKFoiEMO5E3nMJDZkFkuio-5sh99m55k-yM=fuqrHUXbhZw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

On Wednesday, November 19, 2014 09:54:00 AM Ulf Hansson wrote:
> [...]
>=20
> >>
> >> Scenario 5), a platform driver with/without runtime PM callbacks.
> >> ->probe()
> >> - do some initialization
> >> - may fetch handles to runtime PM resources
> >> - pm_runtime_enable()
> >
> > Well, and now how the driver knows if the device is "on" before acc=
essing it?
>=20
> In this case the driver don't need to access the device during
> ->probe(). That's postponed until sometime later.

If this is a platform driver, it rather does need to access the device,
precisely because it doesn't know what power state the device is in oth=
erwise.
See below.

> >> Note 1)
> >> Scenario 1) and 2), both relies on the approach to power on the PM
> >> domain by using pm_runtime_get_sync(). That approach didn't work w=
hen
> >> CONFIG_PM_RUNTIME was unset, but we recently decided to fixed that=
 by
> >> the below patch, so that's good!
> >> "[PATCH] PM / domains: Kconfig: always enable PM_RUNTIME when genp=
d enabled"
> >>
> >> Note 2)
> >> Scenario 3) and 4) use the same principles for managing runtime PM=
=2E
> >> These scenarios needs a way to power on the generic PM domain prio=
r
> >> probing the device. The call to pm_runtime_set_active(), prevents =
an
> >> already powered PM domain from power off until after probe, but th=
at's
> >> not enough.
> >>
> >> Note 3)
> >> The $subject patch, tried to address the issues for scenario 3) an=
d
> >> 4). It does so, but will affect scenario 5) which was working nice=
ly
> >> before. In scenario 5), the $subject patch will cause the generic =
PM
> >> domain to potentially stay powered after ->probe() even if the dev=
ice
> >> is runtime PM suspended.
> >
> > Why would it?  If the device is runtime-suspended, the domain will =
know
> > that, because its callbacks will be used for that.  At least, that'=
s
> > what I'd expect to happen, so is there a problem here?
>=20
> Genpd do knows about the device but it doesn=E2=80=99t get a "notific=
ation" to
> power off. There are no issues whatsoever for driver.

Except that the driver is arguably buggy.

> This is a somewhat special case. Let's go through an example.
>=20
> 1. The PM domain is initially in powered off state.
> 2. The bus ->probe() invokes dev_pm_domain_attach() and then the PM
> domain gets attached to the device.
> 3. $subject patch causes the PM domain to power on.
> 4. A driver ->probe() sequence start, following the Scenario 5).
> 5. The device is initially in runtime PM suspended state and it will
> remain so during ->probe().

But is it physically suspended?

The runtime PM status of the device after ->probe is required to reflec=
t its
real state if runtime PM is enabled.  If that's not the case, it is a b=
ug.

Now, for platform drivers, the driver can't really assume anything in
particular about the current power state of the device at ->probe time,
because different platforms including devices handled by that driver ma=
y
behave differently.

A good example would be two platforms A and B where the same device X i=
s in a
power domain such that A boots with the domain (physically) "on", while=
 B boots
with the domain "off".  If the driver for X assumes anything about the =
initial
power state of the device, it may not work on either A or B.

> 6. The pm_request_idle() invoked after really_probe() in driver core,
> won't trigger a runtime PM suspend callback to be invoked. In other
> words, genpd don't get a "notification" that it may power off.
>=20
> In this state, genpd will either power off from the late_initcall,
> genpd_poweroff_unused() (depending on when the driver was probed) or
> wait until some device's runtime PM suspend callback is invoked at an=
y
> later point.

Which sounds OK to me, so why is it a problem?

> >> I see three options going forward.
> >>
> >> Option 1)
> >> Convert scenario 3) and 4) into using the pm_runtime_get_sync()
> >> approach. There are no theoretical obstacles to do this, but pure
> >> practical. There are a lot of drivers that needs to be converted a=
nd
> >> we also need to teach driver authors future wise to not use
> >> pm_runtime_set_active() in this manner.
> >
> > I'd say we need to do something like this anyway.  That is, standar=
dize on
> > *one* approach.  I'm actually not sure what approach is the most us=
eful,
> > but the pm_runtime_get_sync() one seems to be the most popular to m=
e.
> >
> >> Option 2)
> >> Add some kind of get/put API for PM domains. The buses invokes it =
to
> >> control the power to the PM domain. From what I understand, that's
> >> also what Dmitry think is needed!?
> >> Anyway, that somehow means to proceed with the approach I took in =
the
> >> below patchset.
> >> [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
> >> http://marc.info/?t=3D141320907000003&r=3D1&w=3D2
> >
> > I don't like that.  The API is already quite complicated in my view=
 and
> > adding even more complexity to it is not going to help in the long =
run.
>=20
> I absolutely agree that we shouldn't add unnecessary APIs and keep
> APIs as simple as possible.
>=20
> In that context, I think the effect from proceeding with Option 2)
> also means there are no need for the below APIs any more.
> pm_genpd_poweron()
> pm_genpd_name_poweron() (requires some additional work though)
> pm_genpd_poweroff_unused()
> pm_genpd_dev_need_restore()
>=20
> I guess you figured out that I am in favour of Option 2). :-)
> Especially since it cover all scenarios and we don't have to go a fix
> a vast amount of drivers.

Adding more callbacks to struct dev_pm_domain just in order to handle s=
ome
genpd-specific use case is out of the question.  If you find a way with=
in
genpd to address this the way you like, I'm open for ideas.  Otherwise,
let's just do what I said.

> >
> >> Option 3)
> >> Live we the limitation this $subject patch introduces for scenario=
 5).
> >
> > I'd say, 3) for now and 1) going forward.
>=20
> This could work!
>=20
> The hardest part is to know when we should revert $subject patch, to
> fix the regression introduced for scenario 5).

Well, I don't think so.

=46irst of all, there is a (very) limited number of platforms using gen=
pd today
and it should be perfectly possible to go through the platform drivers =
used
by them and see which of those drivers are affected.  Fixing them shoul=
d not
be too hard either.

Rafael

