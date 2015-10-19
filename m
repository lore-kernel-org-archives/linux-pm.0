From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 19 Oct 2015 12:02:38 +0100
Message-ID: <20151019110238.GE14956@sirena.org.uk>
References: <561E1378.6000906@collabora.com>
 <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <1445247881.53393.146.camel@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KwgAcZnBnwoMp5TU"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445247881.53393.146.camel@infradead.org>
Sender: linux-clk-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti>
List-Id: linux-pm@vger.kernel.org


--KwgAcZnBnwoMp5TU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 19, 2015 at 10:44:41AM +0100, David Woodhouse wrote:
> On Sun, 2015-10-18 at 20:53 +0100, Mark Brown wrote:

> > Do you mean firmware rather than bus here?  I think that's the confusion
> > I have...

> Certainly, if it literally is adding of_* calls then that would seem to
> be gratuitously firmware-specific. Nothing should be using those these
> days; any new code should be using the generic device property APIs
> (except in special cases).

It's not entirely clear to me that we should be moving to fwnode_
wholesale yet - the last advice was to hold off for a little while which
makes sense given that the ACPI community still doesn't seem to have
worked out what it wants to do here and how.  The x86 embedded people
are all gung ho but it's less clear that anyone else wants to use _DSD
in quite the same way (I know of some efforts to use _DSD separately to
the DT compatibility stuff) and there are some vendors who definitely do
have completely different binding schemes for ACPI and DT and therefore
specifically care which is in use.

It would really help if ACPI could get their binding review process in
place, and if we do want to actually start converting everything to
fwnode_ we need to start communicating that actively since otherwise
people can't really be expected to know.

--KwgAcZnBnwoMp5TU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJM3NAAoJECTWi3JdVIfQZWIH+wWlytIatZzb02megHs7cfkS
XkfoBZZlTpwYYTLooWg9gc7XQ/Hx2qk/CTJwHZOudgYjrig+IWFuwOAU5Vw5YMm8
7LN539ptj28jYJibjVxoIIX0bRAiQgrG9i3/5K5e6pmGzqnea/D2mu9sG5L2Fz//
WLK/BYSFuVW6AzmoncTtGgYqECOFDXo8azymWx86d/NlXXMWKIvoEb0qVS+dJrgi
6U7UQqhp46CwWEX3yk4Yf51Fi1wh6xAaLZcXeXqwvy+rYUXpBRNWKhG+0HR1d+Ep
lOg6BbeD+4VpVvPL0yFpxmWEnjicr9mB6jVz/tkKq/tVq6aVat5SrbGTs5Tygjg=
=TjUN
-----END PGP SIGNATURE-----

--KwgAcZnBnwoMp5TU--
