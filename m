From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Sun, 18 Oct 2015 20:53:30 +0100
Message-ID: <20151018195330.GB14956@sirena.org.uk>
References: <561E1378.6000906@collabora.com>
 <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fJz81ohldq3XijGc"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151018193757.GA9147@kroah.com>
Sender: linux-clk-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti.com>, Jin
List-Id: linux-pm@vger.kernel.org


--fJz81ohldq3XijGc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 18, 2015 at 12:37:57PM -0700, Greg Kroah-Hartman wrote:
> On Sun, Oct 18, 2015 at 08:29:31PM +0100, Mark Brown wrote:
> > On Fri, Oct 16, 2015 at 11:57:50PM -0700, Greg Kroah-Hartman wrote:

> > > I can't see adding calls like this all over the tree just to solve a
> > > bus-specific problem, you are adding of_* calls where they aren't
> > > needed, or wanted, at all.

> > This isn't bus specific, I'm not sure what makes you say that?

> You are making it bus-specific by putting these calls all over the tree
> in different bus subsystems semi-randomly for all I can determine.

Do you mean firmware rather than bus here?  I think that's the confusion
I have...

> > One is that regardless of the actual performance of the system when
> > deferred probe goes off it splats errors all over the console which
> > makes it look like something is going wrong even if everything is fine
> > in the end.  If lots of deferred probing happens then the volume gets
> > big too.  People find this distracting, noisy and ugly - it obscures
> > actual issues and trains people to ignore errors.  I do think this is a
> > reasonable concern and that it's worth trying to mitigate against
> > deferral for this reason alone.  We don't want to just ignore the errors
> > and not print anything either since if the resource doesn't appear the
> > user needs to know what is preventing the driver from instantiating so
> > they can try to fix it.

> This has come up many times, I have no objection to just turning that
> message into a debug message that can be dynamically enabled for those
> people wanting to debug their systems for boot time issues.

It's not just the driver core logging, it's also all the individual
drivers logging that they failed to get whatever resource since silently
failing is not a great user experience.  Many, hopefully most, of the
drivers don't actually have special handling for probe deferral since
half the beauty of probe deferral is that the subsystem supplying the
resource can just return -EPROBE_DEFER when it notices something is
missing but might appear and then the drivers will do the right thing so
long as they have error handling code that they really should have
anyway.

We'd need to have a special dev_err() that handled probe deferral
errors for drivers to use during probe or some other smarts in the
logging infrastructure.  Which isn't a totally horrible idea.

--fJz81ohldq3XijGc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWI/i6AAoJECTWi3JdVIfQHiAH/j87ui2ZA7zZlEigIswdU9WD
jRpEO3ZVBH3VylDoyoCIEtgolJwSqWV1Qk6c1EVn8vyhrP1+t5HYWvqrz+49KJrX
AwCkkEKmXiNBtIAENaSsqVTWH3WmwLWYqbaZ3tTM47zN3gVzj/qnaQNs2GMhPQTs
Y9pCzL1LUTMdviMwoMGtq7Fz9gUu+/pXpj1lT07whQmzfHaiMkcJ35VjHeTMKWnC
r2moRf5uUgZj7gtylYcItS6hr/6P+X/tc7zY91KEMNo+Qrhdh1eC0H35Lsw8VwGA
IqYTYWiz802CQiBCvtAXf3UYMrHZiW3MFWE7MD4dPqcl410M8ZscSxJH9Lsiz8k=
=Y8XH
-----END PGP SIGNATURE-----

--fJz81ohldq3XijGc--
