From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/13] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
Date: Wed, 16 Jul 2014 12:00:12 +0100
Message-ID: <20140716110012.GL17528@sirena.org.uk>
References: <53C01558.3090607@nvidia.com>
 <CAL1qeaHETQ7kSGNjPiwi_9WNMtr9qZp0KwjZCCxY29+_N4AcuA@mail.gmail.com>
 <53C01D17.2050906@nvidia.com>
 <20140714083854.GO2081@ulmo>
 <20140714091233.GC6800@sirena.org.uk>
 <20140714092434.GA9755@ulmo>
 <20140714102203.GD6800@sirena.org.uk>
 <53C58DCB.90502@nvidia.com>
 <20140715225252.GD17528@sirena.org.uk>
 <20140716080133.GI7978@ulmo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+PbGPm1eXpwOoWkI"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140716080133.GI7978@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--+PbGPm1eXpwOoWkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 16, 2014 at 10:01:34AM +0200, Thierry Reding wrote:
> On Tue, Jul 15, 2014 at 11:52:52PM +0100, Mark Brown wrote:

> > This looks fine, can you submit properly please?  For the I2C address
> > why not just have an interface to get the regmap and then provide a way
> > to get the underlying device back from the regmap?

> Is it mandatory for regulators to use regmap? Also I'm not sure how this

No, but this is for a limited subset of devices that the hardware knows
how to write to directly which means that they're restricted to things
that can be supported with regmap (or already know how to interact with
the hardware and don't need this interface at all).  The proposed patch
already relies on regmap - it's passing back the information the regmap
helpers use.

> will work with MFDs, since the device may not be the actual bus device,
> but rather a child of the MFD (and what we want access to is the MFD).

> Perhaps for regmaps that would work in most cases since MFDs seem to
> aften share the regmap with their children. However, the code in
> regulator_register() at least indicates that even then it's possible to
> have a regmap in children that's different from the top-level MFD.

Right, drivers can say exactly which regmap to use.

--+PbGPm1eXpwOoWkI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxls5AAoJELSic+t+oim9vC0P/1ga+B2y7WfWBEoc0bRFCC2W
UO0bq9GC1ygvBdsDGjqMzxAUQdJjk0wgjTe3ZgY+suhiUbE+YgH/bXdh1HI40pbP
n3oW32wBKgxuaqmrn1aitm/owiD96nzhK3aWb458EoRFQ1XpvRfmiON1By31Yorx
wkoVWG1TK3D82GNLrqyXBprgFFABQS9DI3gg7nrFICv2v4wGzrAK/xUFZbBjyFuY
vcZRy4fhmGx+lEd1pr2MNnynwD4acLSjQuqdWddLvrR8fu4kuKbMijZOWY251Yq+
4oyTJ7yPhNc4uuNDSYNbX4RiKsecOEPaqixLsBYJWZrlw/KOeLbkPCWqZA+bfIJ7
sBtwC8+lgfarYtztcIZtJe9wkXLM4TW4w+17OrrjhhK2ACF116pyTF91sPdFeKTl
AuUGoqnyTvdW+o+aOFvVE2nCICJCLMErP4qOQjzl/6UnvNfsG0Ws8gjnChKEWkDS
oVNHc9lUuN5/njQURrc+EJno/N4n4qTE15T5Atn5bFjpKHvQgt+REKWd0GtEVKJR
Un0b3PAgEBRzARd1XBXROMEzc2TokimTDFXpaZXw2vdjw2eO4lSfVvV4FEQjMCHh
3OmJ9WnTxeCd/lmsQk5JagEOqYTWZE1x1Ur7P3mali7VzDRC85mGFF6uOxYkgMKY
A/Oihci0OXH8pNi2lC+n
=ebZh
-----END PGP SIGNATURE-----

--+PbGPm1eXpwOoWkI--
