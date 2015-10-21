From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Wed, 21 Oct 2015 22:03:39 +0100
Message-ID: <20151021210339.GR32054@sirena.org.uk>
References: <561E1378.6000906@collabora.com>
 <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <5627B677.5090109@gmail.com>
 <20151021162758.GP32054@sirena.org.uk>
 <5627D6E0.5020708@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+HdfuZ4tX+pUSv6/"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5627D6E0.5020708@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti>
List-Id: linux-pm@vger.kernel.org


--+HdfuZ4tX+pUSv6/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 21, 2015 at 11:18:08AM -0700, Frank Rowand wrote:
> On 10/21/2015 9:27 AM, Mark Brown wrote:

> > Overall boot time and time to get some individual built in component up
> > and running aren't the same thing - what this'll do is get things up
> > more in the link order of the leaf consumers rather than deferring those
> > leaf consumers when their dependencies aren't ready yet.

> Thanks!  I read too much into what was being improved.

> So this patch series, which on other merits may be a good idea, is as
> a by product solving a specific ordering issue, moving successful panel
> initialization to an earlier point in the boot sequence, if I now
> understand more correctly.

Yeah, that's my understanding.

> In that context, this seems like yet another ad hoc way of causing the
> probe order to change in a way to solves one specific issue?  Could
> it just as likely move the boot order of some other driver on some
> other board later, to the detriment of somebody else?

Indeed.  My general feeling is that it does make the link order stuff
more predictable and easier to work with and it does have other merits
(in terms of the error reporting, though there's other ways to address
that like the one Russell is proposing).

--+HdfuZ4tX+pUSv6/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJ/2qAAoJECTWi3JdVIfQ9MgIAIR+qXN0q0pY1zKwb6/58+sQ
PH/X1p3w5xiusgk/rTw3uRO1aaL7IQc+LReMkk2Hf90C2p6A2vK3mqNnSPZHnGH/
pvHzDER2FesjNLuaM9GtxZV8lrXu74tUX1y30DgOM6EqJ/RQBr6cSHybcgbTQmHo
/0NwCPhei2WiLSblE6e9VVqrDC256P9vclzWNSSUCQ3FAo78B2ram74srRdtHfVn
Tw2ytHO1rEDbzov8n0QJVgU0P9+vpeSwrcLvZgyNNhOXfuGv8Re7TvYw/DkcBYMY
2UEMarleRtdV9B94IPZoqSui4p939tCdNg0NFfyj0rPSQ4s3Au9dIZ0x4lIjLt8=
=T1Oq
-----END PGP SIGNATURE-----

--+HdfuZ4tX+pUSv6/--
