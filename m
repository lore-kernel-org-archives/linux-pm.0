From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 19 Oct 2015 15:50:48 +0100
Message-ID: <20151019145048.GI14956@sirena.org.uk>
References: <561E1378.6000906@collabora.com>
 <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <1445247881.53393.146.camel@infradead.org>
 <CAL_JsqKehmSobpbdeXGo=-1pAbtrhCHovyyCWya_MNOhGCi8CQ@mail.gmail.com>
 <1445258870.53393.173.camel@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P75d7mFgfYjpUjsN"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445258870.53393.173.camel@infradead.org>
Sender: linux-i2c-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti>
List-Id: linux-pm@vger.kernel.org


--P75d7mFgfYjpUjsN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 19, 2015 at 01:47:50PM +0100, David Woodhouse wrote:
> On Mon, 2015-10-19 at 07:35 -0500, Rob Herring wrote:

> > See version 2 of the series[1] which did that. It became obvious that
> > was pointless because the call paths ended up looking like this:

> > Generic subsystem code -> DT look-up code -> fwnode_probe_device ->
> > of_probe_device

> You link to a thread which says that "AT LEAST CURRENTLY, the calling
> locations [the 'DT look-up code' you mention above] are DT specific
> functions anyway.

> But the point I'm making is that we are working towards *fixing* that,
> and *not* using DT-specific code in places where we should be using the
> generic APIs.

What is the plan for fixing things here?  It's not obvious (at least to
me) that we don't want to have the subsystems having knowledge of how
they are bound to a specific firmware which is what you seem to imply
here.  That seems like it's going to fall down since the different
firmware interfaces do have quite different ideas about how things fit
together at a system level and different compatibility needs which do
suggest that just trying to do a direct mapping from DT into ACPI may
well not make people happy but it sounds like that's the intention.

When it gets to drivers the situation is much more clear since it's
normally just simple properties, it's generally a bit more worrying if
drivers are needing to directly interact with cross-device linkage.
This is all subsystem level code though.

> None of that really negates that fact that we are *working* on cleaning
> these code paths up to be firmware-agnostic, and the fact that we
> haven't got to this one *yet* isn't necessarily a good reason to make
> it *worse* by adding new firmware-specificity to it.

It seems like we're going to have to refactor these bits of code when
they get generalised anyway so I'm not sure that the additional cost
here is that big.

--P75d7mFgfYjpUjsN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJQNHAAoJECTWi3JdVIfQaREH/3tn5eOlLmrwOqNfDROOkFts
y5Wy3xg5mX9QlH88z3oxHPnKqWqSKDRoi/VgRujy8dqaZ4PPBKZA2ZuWqf5BAGar
nAYP9oLWh8/3A0s2NaN6puJYvsmm8287OePqWxHrL+3I6azzj65/LcGx4HmjsM1j
Z/qZaDh/6LwsBtEUv94Q4nhE+OykmmE7Y9EPmd03QOPrgoJhtQ+rO8JchP9NWkVq
W3txdv4ktdFc//r6JJG1gemaOmeGXMcGHzKq2ukrQRCDRRhntp83oLQEw2Lx3o+/
X/gYP+LZR5EL9+mZ6dZgpU5bImqD8cKxsrD30e65xNadnmcfjoXPrUFtQ71t2QQ=
=1a8f
-----END PGP SIGNATURE-----

--P75d7mFgfYjpUjsN--
