From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 00/11] PM / Domains: Generic OF-based support
Date: Fri, 26 Sep 2014 12:04:46 +0200
Message-ID: <20140926100445.GL31106@ulmo>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <20140925112122.GA22753@ulmo>
 <7hppej8glk.fsf@deeprootsystems.com>
 <20140926073125.GB31106@ulmo>
 <CAMuHMdWq9ZySdt8sQpBFq=X7LR5a=vZkowNZoB8NHztTisG+NQ@mail.gmail.com>
 <20140926095647.GI31106@ulmo>
 <CAMuHMdUqHZWrQGx=y8_yEJ7G9H5C=Y14-qPCMVJC6mxS5Sdb6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L/bWm/e7/ricERqM"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37528 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031AbaIZKEt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 06:04:49 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdUqHZWrQGx=y8_yEJ7G9H5C=Y14-qPCMVJC6mxS5Sdb6A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@g>


--L/bWm/e7/ricERqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2014 at 12:01:13PM +0200, Geert Uytterhoeven wrote:
> Hi Thierry,
>=20
> On Fri, Sep 26, 2014 at 11:56 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> >> > An alternative would be to make the power-domain controller look up =
the
> >> > clock within the user's device tree node. That could be problematic,
> >> > because while the module clock is always the first clock in current
> >> > device trees, there aren't ordering guarantees, so we'd have to rely=
 on
> >> > the clock name.
> >>
> >> Or on some other way.
> >> Do you have a separate hardware block that controls all (and only) the
> >> module clocks?
> >
> > No, the "clock and reset controller" controls all clocks (and resets) on
> > the SoC.
>=20
> Sorry, with "only the module clocks" I meant "not clocks that are not mod=
ule
> clocks". Having a reset controller function in there is fine.
>=20
> So it seems you do have a clock provider that provides module clocks,
> and can mark them CLK_RUNTIME_PM.
>=20
> >> On shmobile SoCs, all module clocks are controlled using the MSTP
> >> (Module SToP) clocks.
> >>
> >> In my old RFC series "[PATCH/RFC 0/4] of: Register clocks for Runtime =
PM
> >> with PM core" (https://lkml.org/lkml/2014/4/24/1118) the MSTP clock dr=
iver
> >> advertised using a new CLK_RUNTIME_PM flag that its clocks are module
> >> clocks and thus suitable for runtime PM.
> >>
> >> There were some issues with that series, but the general idea of letti=
ng a
> >> clock driver advertise that all its clocks are module clocks could sti=
ll be
> >> useful. Then the power domain driver knows which clocks to manage.
> >
> > That sounds interesting. Although it would still mean that we need a way
> > to associate a clock with the correct power domain. I guess the driver
> > could do that by iterating over all available clocks in the device's
> > clocks property and grab only those that are marked CLK_RUNTIME_PM.
>=20
> Yes, that's the idea.

It sounds like this could work. Reading up on the thread you linked to
there's some resistance to merging what you propose, though. Given that
we may want to control the clocks and resets in the controller as well,
maybe duplicating the clock references would actually be the proper way
to do it.

I'll have to think a little bit more about it, or implement it to see
how it all fits. Thanks for the pointers.

Thierry

--L/bWm/e7/ricERqM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUJTo9AAoJEN0jrNd/PrOh9U4QAIL6kXN9hQhYgsWO8opoBwXx
gupdu012EbD0rKPG9PQcZpLLOhIjfSWjug8TlgRvd1WBrNi4rJaca2DCf46tRfth
ih3EmKKHyldtyz3u6OkpSwcwRrnYoWSsyyf0zc6baG9p3FWi6F0M99C/80SwKIiY
78/KDTbLaHzFcX5UfAUJkZ5HhKT2fkftGXwcpB++Zvutl+TJG6pQ5Au/fOk2Ojsh
XMgT0ceRUC8StGO9xcdpC9Xf3icuW4Na2A9jy0jrHXOOum1VaWtN+baQBhORGO+3
f8brXTezMgtnvFlKh9euOXVW/Y2DbPlZFYv/vM+lGCl85yIsTlLvw6kvhM71DtMP
U/VyJvyVzNJtfzbnuFfM9r5qKNp8VkjRGSTiWVsTyBvP4HsMY9YAyGxhd/1eWlav
rvogJO8Q/bwi9bji6uxPfbIp4mj5bpc1vCWHodz+6jhX0dve5mjdCSfNSQC3yjn5
qPOc1W66KRaREKJzL6MgTFuFq8YDHrSkgnpOF0ZNOMNNhaGWavYN9uI6uKNudpOr
BujqxBkWUgZqJlWGu8ti1nUo/1lY4jw7OgtyloJKqMeeqFd3ZSFCe6PLvR6wFERd
ZgOLB5/7D0WwROKji0Vu0vcGjMDMkBVB6FyzjeVGW0dCwb9woIObDP9v0N3ExfV/
61UYgWe/e/ABarKSpHbT
=6YGG
-----END PGP SIGNATURE-----

--L/bWm/e7/ricERqM--
