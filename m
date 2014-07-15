From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/13] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
Date: Tue, 15 Jul 2014 23:52:52 +0100
Message-ID: <20140715225252.GD17528@sirena.org.uk>
References: <1405028569-14253-2-git-send-email-ttynkkynen@nvidia.com>
 <CAL1qeaFF0ZpUFovxTuLXrBPRg2Lbf-754Z=ztD5HFZPbfnDsAw@mail.gmail.com>
 <53C01558.3090607@nvidia.com>
 <CAL1qeaHETQ7kSGNjPiwi_9WNMtr9qZp0KwjZCCxY29+_N4AcuA@mail.gmail.com>
 <53C01D17.2050906@nvidia.com>
 <20140714083854.GO2081@ulmo>
 <20140714091233.GC6800@sirena.org.uk>
 <20140714092434.GA9755@ulmo>
 <20140714102203.GD6800@sirena.org.uk>
 <53C58DCB.90502@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53C58DCB.90502-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 15, 2014 at 11:23:39PM +0300, Tuomas Tynkkynen wrote:

> That sounds indeed useful for this case. How'd the following interface
> sound for the register offset / selector-to-register-value conversion?
> The I2C address would be a bit trickier to get as it would touch the
> regmap stuff as well, but perhaps it would be a good idea to have a
> phandle to the I2C device itself, and then parse the reg field for
> the address.

This looks fine, can you submit properly please?  For the I2C address
why not just have an interface to get the regmap and then provide a way
to get the underlying device back from the regmap?

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxbC7AAoJELSic+t+oim94DsP/3hee0clNxB4r6hBhDawbuBR
ioR6YThPt82r79ST9ZKqgpkwcmGGjZura4HxaMb/ViPJJCsck3V0HgfJATp4/quC
qyBxYT4v/OhZTT/GWld1YB3uk6HG+P5nXqgBBFi1NJbnueXvHFwotRjpMepsRR3p
JSLZOCQ3AYztf6SZkfwiaysIi/n93MEMMNKz2uH9dSQjbE8dyVF2qPy+lxtchwMy
sj2ndUslH9GBaJC4jZcHVWr236SGTguZiPpukgNVNYWTp6g70Vpl0SmRZcIIH5xT
ksQnAiwoxrgAlWdFLFTGHUAW67HWcVi02QJh01wEyFI3fHiu0pF1/74V2WSRK2Vx
deMW3eC9FuqvENsJ5sfGaDkvCTduNsYehiWpoPl5QMJEtWgA314Foscg841NxTr9
QzXoT1DvfHkKVOew+pgXsWhYzg0aazZq+GpxTabcuvQZ+60Zf6tnSyE/u3zCMcfl
UD9DjqaRbt9ZoJfhRC15VsI+eEiUOI2SMN2ZvvoU/IPIk/Ed3gPVj1t/m+5ZHXXc
A4tZAc7tK1UO2JS15fVvEmWpqv8lxK29xT8Y+fNrixwdBmwhBgsRdQnJjc9liJbV
r7p6wBWbw5DEQwt8o+5Hy+kj0G2Z5t5PKWXA5q9Je3wOkhTFqWvMz97Q0NqE9A5b
MsZQFoed22IyuNUuDhtW
=RoQC
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
