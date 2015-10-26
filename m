From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 26 Oct 2015 10:12:24 +0900
Message-ID: <20151026011224.GV29919@sirena.org.uk>
References: <20151018192931.GY14956@sirena.org.uk>
 <562A5602.7000208@sonymobile.com>
 <CAL_JsqLNSM=+j2r9HPcbSzsZrgnGEY3=kv21EXxisKwP5+57ag@mail.gmail.com>
 <24100858.2KIS8Y2npV@vostro.rjw.lan>
 <20151024220648.GR29919@sirena.org.uk>
 <CAJZ5v0hPVu7AL8zBdU4Kb7+MVfYv0mTa43RhnCyyPR+RKDbhLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CSNFvL6ilyiKL/Hs"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hPVu7AL8zBdU4Kb7+MVfYv0mTa43RhnCyyPR+RKDbhLA@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tim Bird <tim.bird@sonymobile.com>, "frowand.list@gmail.com" <frowand.list@gmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry
List-Id: linux-pm@vger.kernel.org


--CSNFvL6ilyiKL/Hs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2015 at 02:54:39PM +0100, Rafael J. Wysocki wrote:
> On Sun, Oct 25, 2015 at 12:06 AM, Mark Brown <broonie@kernel.org> wrote:

> > There's also the understanding people had that the order things get
> > bound changes the ordering for some of the other cases (perhaps it's a
> > good idea to do that, it seems likely to be sensible?).

> But it really doesn't do that.  Also making it do so doesn't help much
> in the cases where things can happen asynchronously (system
> suspend/resume, runtime PM).

Yeah, people seem to have that impression though. :(

> If, instead, there was a way to specify a functional dependency at the
> device registration time, it might be used to change the order of
> everything relevant, including probe.  That should help to reduce the
> noise you're referring to.

This links back to the idea of having generic support for pre-probe
actions which is also generally useful (the ability to do things like
power on regulators for devices on enumerable buses so they can be
enumerated as standard). =20

--CSNFvL6ilyiKL/Hs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWLX34AAoJECTWi3JdVIfQxWcH/1aCaKRkQgKa9vAZbBaq2sSf
30EqKg/SLlEPyozfvQqz8QTpxr1XYD4iJ3qT3048aeuYApT7TZVZUMpSpeLuuWcN
Cmi76xZim7KYTRuT+iFewFse+gaKJyl1zpU+2O0R4VpWxUe2fxwJY159CgqS8/cO
rv3tQ03svICO5hrXlW9tS/Z/hoGZe9FQiiWYvmvdcM3XEKYkKY9m8B0B64OJ/8Sp
WmN+EQ1sevAGuMoa3EWIZDhYIbICzBSHA8WLWolALOmEmFEHiz/fjBSf5rYaD42U
68oNScKwVepB4LeewE+syAzBFVMow0SfbpI6dfbwaiS64BNVbMzP5X5Jq04MZMY=
=w1Sh
-----END PGP SIGNATURE-----

--CSNFvL6ilyiKL/Hs--
