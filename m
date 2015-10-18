From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Sun, 18 Oct 2015 20:41:24 +0100
Message-ID: <20151018194124.GA14956@sirena.org.uk>
References: <561E1378.6000906@collabora.com>
 <20151017065750.GA18607@kroah.com>
 <CAL_Jsq+Due3CgV0Z_m4vYQsa+X30DSxgmqz_r=26OrBV7v+H2g@mail.gmail.com>
 <20151017154709.GE4059@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ylUvUtShPtQAJVVd"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151017154709.GE4059@kroah.com>
Sender: linux-clk-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.com>, Jin
List-Id: linux-pm@vger.kernel.org


--ylUvUtShPtQAJVVd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 17, 2015 at 08:47:09AM -0700, Greg Kroah-Hartman wrote:
> On Sat, Oct 17, 2015 at 10:04:55AM -0500, Rob Herring wrote:

> > I think Linus W, Mark B, and I all said a similar thing initially in
> > that dependencies should be handled in the driver core. We went down
> > the path of making this not firmware (aka bus) specific and an earlier
> > version had just that (with fwnode_* calls). That turned out to be
> > pointless as the calling locations were almost always in DT specific
> > code anyway. If you notice, the calls are next to other DT specific
> > calls generally (usually a "get"). So yes, I'd prefer not to have to
> > touch every subsystem, but we had to do that anyway to add DT support.

> If they are "next" to a call like that, why not put it in that call?  I
> really object to having to "sprinkle" this all over the kernel, for no
> obvious reason why that is happening at all (look at the USB patch for
> one such example.)

I did ask that question myself IIRC - we could probably get a long way
by trying to instantiate anything that looks probable when we do a
phandle lookup on it.

--ylUvUtShPtQAJVVd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWI/XkAAoJECTWi3JdVIfQITcH/jtrvXbuGKZZSYbLjVQcSiWt
C/MXzYtFbSJgvLgAcxbbegmnGt9ERY0WcETCVaBWpHK3K5vgxFu+9bnWjuFU1FxG
dH6MBp2mC2A3GiUsaVAo4TSRNoouB34729rfeSCgqEiQ6sK+rksvZWgc/nSJC0TD
DRJJMQieFUPHW6ywTOHL9allHuOJrmCX6vLyJEoSR1ggcMKoFkAPup3UMSv5Uvgw
uQHVqaDadofytOa+qSSkrEIkFmUs6raQhh1H2OB2xilFKeXyjvYuo8rvVgSxokti
RjFEZm/y2U7dzyrXTLPOOup3YPZfXaIxQqSXfMCUmWiAwJSSvK0GeL/IylHRmZM=
=WR65
-----END PGP SIGNATURE-----

--ylUvUtShPtQAJVVd--
