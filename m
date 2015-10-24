From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Sun, 25 Oct 2015 07:06:48 +0900
Message-ID: <20151024220648.GR29919@sirena.org.uk>
References: <20151018192931.GY14956@sirena.org.uk>
 <562A5602.7000208@sonymobile.com>
 <CAL_JsqLNSM=+j2r9HPcbSzsZrgnGEY3=kv21EXxisKwP5+57ag@mail.gmail.com>
 <24100858.2KIS8Y2npV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FNX2SHge3qdlDajY"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <24100858.2KIS8Y2npV@vostro.rjw.lan>
Sender: linux-gpio-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tim Bird <tim.bird@sonymobile.com>, "frowand.list@gmail.com" <frowand.list@gmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>David
List-Id: linux-pm@vger.kernel.org


--FNX2SHge3qdlDajY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 24, 2015 at 04:17:12PM +0200, Rafael J. Wysocki wrote:

> Well, I'm not quite sure why exactly everyone is so focused on probing here.

Probe deferral is really noisy even if it's working fine on a given
system so it's constantly being highlighted to people in a way that
other issues aren't if you're not directly having problems.

There's also the understanding people had that the order things get
bound changes the ordering for some of the other cases (perhaps it's a
good idea to do that, it seems likely to be sensible?).


--FNX2SHge3qdlDajY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWLAD1AAoJECTWi3JdVIfQn9QH/1ZQrvI10PtpWUQHu6GzOxZK
B1o63z5QhirS2YbZxYLH6hso0K0/4eVmY0VS35L/DM3hRePI1vFZHLKCFH3/jOJX
AHnTwLpWu9w/iJ3yP7qJuInLq9IYA6Tj32SgYx98IsrN8JhUAFVvn/KM7mJK2jD3
PdfIDQF5b6ZduAktIUkzKMaYrrxvbRarut+DadjTwJc2so5DvFuIBCBdruGcOOax
bHfI+PL2ALE+IXn0z7MSioeBvszUB4paMpz7goBvu4OqdOUBxdGz7l0v1BlwI8SL
X27RYEK77ZN9+DaO0a+OWtQpuYrBIFDnQrN6g+6HuEb2RP5EXZTll7aUeMJ3miw=
=89D6
-----END PGP SIGNATURE-----

--FNX2SHge3qdlDajY--
