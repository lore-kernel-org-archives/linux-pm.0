From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 02/19] memory: tegra: Add MC flush support
Date: Mon, 20 Jul 2015 15:14:25 +0200
Message-ID: <20150720131410.GA1098@ulmo>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-3-git-send-email-jonathanh@nvidia.com>
 <20150717095754.GG3057@ulmo>
 <20150717102049.GQ6287@tbergstrom-lnx.Nvidia.com>
 <20150717113124.GP3057@ulmo>
 <20150720095941.GZ6287@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150720095941.GZ6287-Rysk9IDjsxmJz7etNGeUX8VPkgjIgRvpAL8bYrjMMd8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 12:59:41PM +0300, Peter De Schrijver wrote:
> On Fri, Jul 17, 2015 at 01:31:24PM +0200, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Fri, Jul 17, 2015 at 01:20:49PM +0300, Peter De Schrijver wrote:
> > > On Fri, Jul 17, 2015 at 11:57:55AM +0200, Thierry Reding wrote:
> > > > > Old Signed by an unknown key
> > > >=20
> > > > On Mon, Jul 13, 2015 at 01:39:40PM +0100, Jon Hunter wrote:
> > > > > The Tegra memory controller implements a flush feature to flush p=
ending
> > > > > accesses and prevent further accesses from occurring. This featur=
e is
> > > > > used when powering down IP blocks to ensure the IP block is in a =
good
> > > > > state. The flushes are organised by software groups and IP blocks=
 are
> > > > > assigned in hardware to the different software groups. Add helper
> > > > > functions for requesting a handle to an MC flush for a given
> > > > > software group and enabling/disabling the MC flush itself.
> > > > >=20
> > > > > This is based upon a change by Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>.
> > > > >=20
> > > > > Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > > > ---
> > > > >  drivers/memory/tegra/mc.c | 110 ++++++++++++++++++++++++++++++++=
++++++++++++++
> > > > >  drivers/memory/tegra/mc.h |   2 +
> > > > >  include/soc/tegra/mc.h    |  34 ++++++++++++++
> > > > >  3 files changed, 146 insertions(+)
> > > >=20
> > > > Do we know if this is actually necessary? I remember having a discu=
ssion
> > > > with Arnd Bergmann a while ago, and the Linux driver model kind of
> > > > assumes that by the time a device is disabled all outstanding acces=
ses
> > > > will have stopped.
> > > >=20
> > > > Do we have a way to determine that this even makes a difference? Ca=
n we
> > > > trigger a case where not doing this would cause breakage and see th=
at
> > > > adding this fixes that particular issue?
> > > >=20
> > >=20
> > > Most likely it is. The memory controller can still be processing requ=
ests
> > > when the peripheral domain is powergated. This would mean the respons=
e cannot
> > > be delivered in that case. So we need to be sure there are no outstan=
ding
> > > requests before shutting down the domain.
> >=20
> > My point is that that's the driver's responsibility anyway, hence making
> > the explicit flush unnecessary.
> >=20
>=20
> The peripheral driver doesn't know how long a request is queued in the me=
mory
> controller. So it can't be responsible for ensuring this.

Surely whenever the peripheral reports that the operation is done (be
that via some DMA controller interrupt or syncpoint increment) the
operation would have flushed from the memory controller. Drivers are
already supposed to make sure this is the case when they are removed or
suspended, so this would mean that we'd be adding all this code for no
real gain.

It would also explain why we're currently not seeing any such problems.

Also note that I'm not saying no to this, I merely want to make sure
that it's necessary, and in order to prove so we need tests to produce
enough traffic for this to be exposed, and then we can also verify that
the patches actually do what they're supposed to.

Thierry

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrPQuAAoJEN0jrNd/PrOh1YgP/0pKCp1K5Ls2NT9Jp94Vy/56
Ndk/R294ioHDRPy9V+QnT9DwDLzxNHMeFlAIy3rLqqmtLrtaJjUx5Sj6FaiRLXi3
thofS0a4TqIFWUKNW7UeNHmkyYWZHjSGsoxq/11oPw3mreHzgxKPwuYWnElD1S3C
F3FQAlVe1w+W//Fa1wO1CJEtX7/hXGT+M9MERyyzmZTTwOJGfvdeEg5/+PAc7wL7
74NPVAAu0mbNQ0RH2gTiON/jfJu7ueyM1CdDCD2uhNjMUGVI/LSZjpyGgf4q7kAH
dUWxaZvU8GfJeqkdowWgZOz+z/M8I3a8sZo9yaz3pvCo9XOrbKKGKYE9rMixzuOA
teAJiFE267q6x9U0U7kOhUy7fTK0kimIdKnLgMwxZwcGQ4lEugLpCjtnEFOG/z6q
nopP1gr3O54BT7DmRPpLQ0uJXdz6+aXtvgMkr5M1ps1/h5rGSy14rt7TslAFiHCH
fdAcLnCJM15gSde2vcXBi9reKQgvCRZ72gk1P9UjOhIx8U1/Y3Ht9Kz0QWUidNre
hqqjFpYg7kqzXTIRIMxZkQ7V7+Bo2qoreIJgZMhZ0E6u556PJy8+/RoSpyeyHQol
hd9gc/qQsUpcLIT5prL/F57D8X7PZDDHg7gFBnTA/q5mh0s3OjBWvSa7jVNMBkF0
zp0eYjYakTh/lC8lSltJ
=K7SK
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
