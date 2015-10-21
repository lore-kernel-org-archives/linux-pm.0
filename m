From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Wed, 21 Oct 2015 17:27:58 +0100
Message-ID: <20151021162758.GP32054@sirena.org.uk>
References: <561E1378.6000906@collabora.com>
 <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <CAAObsKB2BUZ-smid45wOdAQw6h2yNqCydk+azAFNk69ewHJtZQ@mail.gmail.com>
 <5627B677.5090109@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wrbiW19WTymQQzps"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5627B677.5090109@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti>
List-Id: linux-pm@vger.kernel.org


--wrbiW19WTymQQzps
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2015 at 08:59:51AM -0700, Frank Rowand wrote:
> On 10/19/2015 5:34 AM, Tomeu Vizoso wrote:

> > To be clear, I was saying that this series should NOT affect total
> > boot times much.

> I'm confused.  If I understood correctly, improving boot time was
> the key justification for accepting this patch set.  For example,
> from "[PATCH v7 0/20] On-demand device probing":
>=20
>    I have a problem with the panel on my Tegra Chromebook taking longer
>    than expected to be ready during boot (St=E9phane Marchesin reported w=
hat
>    is basically the same issue in [0]), and have looked into ordered
>    probing as a better way of solving this than moving nodes around in the
>    DT or playing with initcall levels and linking order.
>=20
>    ...
>=20
>    With this series I get the kernel to output to the panel in 0.5s,
>    instead of 2.8s.

Overall boot time and time to get some individual built in component up
and running aren't the same thing - what this'll do is get things up
more in the link order of the leaf consumers rather than deferring those
leaf consumers when their dependencies aren't ready yet.

> While not as dramatic as your results, they are somewhat supportive.
> What has changed your assessment that the on-demand device probing
> patches will give a big boot performance increase?  Do you have
> new data or analysis?

See above, my understanding was that the performance improvements were
more around improved control/predictability/handwave of the boot
ordering rather than total time.

--wrbiW19WTymQQzps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJ70OAAoJECTWi3JdVIfQeWcH/j2uOXOzgx7pnrlm7I69Kibp
atBDWslC2PLIFyM8NQMCCyylED2dqSr72HHG++eDyB9kHbaaba+ZNu8DDqcbQYSF
MaVOWhUulhhEnyRhj3I+aYT+GVZ9QQwTzRau/cUD0Mrqf/lUvGZKUeU+gq34v4DK
JfBU6MLZJNjAskQSSLPwzllg2hSb0VP5zy2ScbiawsUyRRNDn5tHUQ+r0K/rlWHJ
9Zjr/q9QxHcDVhdX+bORqc7QCSlQhsrIATItLhLksSaX99iuhTltgGWjE/UonSId
LHxDyw9zGss8voGsVVfmBf2FaD1/lEDyVMzGq0+GizxNNwaYXZ/fpGHvSbT2/Sw=
=D7aZ
-----END PGP SIGNATURE-----

--wrbiW19WTymQQzps--
