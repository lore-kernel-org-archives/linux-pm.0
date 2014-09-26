From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Fri, 26 Sep 2014 11:56:48 +0200
Message-ID: <20140926095647.GI31106@ulmo>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <20140925112122.GA22753@ulmo>
 <7hppej8glk.fsf@deeprootsystems.com>
 <20140926073125.GB31106@ulmo>
 <CAMuHMdWq9ZySdt8sQpBFq=X7LR5a=vZkowNZoB8NHztTisG+NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AXxEqdD4tcVTjWte"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:46092 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359AbaIZJ4w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 05:56:52 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdWq9ZySdt8sQpBFq=X7LR5a=vZkowNZoB8NHztTisG+NQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@g>


--AXxEqdD4tcVTjWte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2014 at 10:06:24AM +0200, Geert Uytterhoeven wrote:
> Hi Thierry,
>=20
> On Fri, Sep 26, 2014 at 9:31 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Thu, Sep 25, 2014 at 03:45:11PM -0700, Kevin Hilman wrote:
> >> Thierry Reding <thierry.reding@gmail.com> writes:
> >> > I just noticed these patches because they conflicted with some of the
> >> > local patches I had to add a very similar framework. One of the reas=
ons
> >> > why I hadn't posted these publicly yet is because the platform where=
 I
> >> > want to use this (Tegra) is somewhat quirky when it comes to power
> >> > domains.
> >> >
> >> > On Tegra these domains are called power gates and they currently have
> >> > their own API. We've been looking at migrating things over to some
> >> > generic framework for some time and PM domains do seem like a good f=
it.
> >> > However one of the quirks regarding these domains on Tegra is that a
> >> > fixed sequence exists that needs to be respected when enabling or
> >> > disabling a power partition. The exact sequence can be found in the
> >> > drivers/soc/tegra/pmc.c driver's tegra_powergate_sequence_power_up()
> >> > function. Essentially we need to call into the clock and reset drive=
rs
> >> > at very specific moments during the operations that the PMC does.
> >> >
> >> > One solution to this would be to make the needed clocks and resets
> >> > available to the power domain driver via DT, but then we have the
> >> > problem that two drivers would be controlling the same resources. For
> >> > example drivers could still want to disable the clock for more fine-
> >> > grained power management.
> >>
> >> I think you're on the right path here.  You can get rid of this confli=
ct
> >> by removing the direct/manual clock management from the drivers, and
> >> using runtime PM instead: s/clk_enable/pm_runtime_get_sync/,
> >> s/clk_disable/pm_runtime_put_sync/.  When using runtime PM, those calls
> >> trickle down through the power domain driver, which can manage the
> >> device clocks, as well as any additional clocks and resets needed for
> >> power gating.
> >
> > Okay. The DT part of it is going to be pretty nasty (as usual) because
> > we currently have the clocks and resets within the device's device tree
> > node (which I think is where they really belong).
> >
> > So one possibility would be to move the clocks and resets to the power
> > domain controller's node, like so:
> >
> >         pmc@... {
> >                 power-domains {
> >                         ...
> >
> >                         sata@... {
> >                                 clocks =3D <&tegra_car 124>;
> >                                 resets =3D <&tegra_car 124>;
> >                         };
> >                 };
> >         };
> >
> > An alternative would be to make the power-domain controller look up the
> > clock within the user's device tree node. That could be problematic,
> > because while the module clock is always the first clock in current
> > device trees, there aren't ordering guarantees, so we'd have to rely on
> > the clock name.
>=20
> Or on some other way.
> Do you have a separate hardware block that controls all (and only) the
> module clocks?

No, the "clock and reset controller" controls all clocks (and resets) on
the SoC.

> On shmobile SoCs, all module clocks are controlled using the MSTP
> (Module SToP) clocks.
>=20
> In my old RFC series "[PATCH/RFC 0/4] of: Register clocks for Runtime PM
> with PM core" (https://lkml.org/lkml/2014/4/24/1118) the MSTP clock driver
> advertised using a new CLK_RUNTIME_PM flag that its clocks are module
> clocks and thus suitable for runtime PM.
>=20
> There were some issues with that series, but the general idea of letting a
> clock driver advertise that all its clocks are module clocks could still =
be
> useful. Then the power domain driver knows which clocks to manage.

That sounds interesting. Although it would still mean that we need a way
to associate a clock with the correct power domain. I guess the driver
could do that by iterating over all available clocks in the device's
clocks property and grab only those that are marked CLK_RUNTIME_PM.

Thierry

--AXxEqdD4tcVTjWte
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUJThfAAoJEN0jrNd/PrOhepEP/RVYNPZMYreP7YYyYKVfY/gO
2o7VerNdGnwjIlAXLbSjmIGXVqPvPJxqHmlWRNOzp9fmys589GoAetZ51t9UKLfW
JR2uAMQX23x2kBXGXURXj2XBiWKuVmyGipW78ITLY3qKX5YCYI0StKpgKRqjtFzx
ZnsUKEcQ8J0B9Otk78ofU/oUGXuz4VlAEHsoU9CsRNZ736oloqopTon/E2pFJVRK
S4Ex32BEOkk5sAKdTTTeTS+PvZ/JcFb20LTkx6THdunQpJCLIKkBT2h0yVKl17C1
c2MY89QZbN4PhZXfKR2E/YIwgCiMqzwAAk5hWKUfxCgdsAc4IsYRl+RAQowy05OJ
m+TLO2mlp1oQkzMA9GZwzSegwbOTsuD6Phuwygju9mVEQARkEqzC3HLcz+22XNZp
viQYwqWVSiTvxp/dT0XwOM4SMV73q1k/umRn72f9ezNnAXrsqHNZCUAqb8rwmjl3
IsIpVo14r9CX8T8W0o2SIue6N+JdWMqs0tOq+aHC3qnMIu1giCssWRpVxHGKhza7
nDudcbk+dPp41QOX19QBmHo1C+UOv+O5C51+GvDprPRtxJeUV75/y1W7CTWU1lP9
Rep7wOJBb5R/I+0rhsTTNsY66z5Cx8TEbVXevFSgQlO8jHicnVVlQBIsT5/UKvON
fsOkK575sgkj30MK3pCM
=twYa
-----END PGP SIGNATURE-----

--AXxEqdD4tcVTjWte--
