From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 02/19] memory: tegra: Add MC flush support
Date: Fri, 17 Jul 2015 13:31:24 +0200
Message-ID: <20150717113124.GP3057@ulmo>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-3-git-send-email-jonathanh@nvidia.com>
 <20150717095754.GG3057@ulmo>
 <20150717102049.GQ6287@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xNm6VWMD3PcA105u"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150717102049.GQ6287-Rysk9IDjsxmJz7etNGeUX8VPkgjIgRvpAL8bYrjMMd8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--xNm6VWMD3PcA105u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2015 at 01:20:49PM +0300, Peter De Schrijver wrote:
> On Fri, Jul 17, 2015 at 11:57:55AM +0200, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Mon, Jul 13, 2015 at 01:39:40PM +0100, Jon Hunter wrote:
> > > The Tegra memory controller implements a flush feature to flush pendi=
ng
> > > accesses and prevent further accesses from occurring. This feature is
> > > used when powering down IP blocks to ensure the IP block is in a good
> > > state. The flushes are organised by software groups and IP blocks are
> > > assigned in hardware to the different software groups. Add helper
> > > functions for requesting a handle to an MC flush for a given
> > > software group and enabling/disabling the MC flush itself.
> > >=20
> > > This is based upon a change by Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>.
> > >=20
> > > Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > ---
> > >  drivers/memory/tegra/mc.c | 110 ++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  drivers/memory/tegra/mc.h |   2 +
> > >  include/soc/tegra/mc.h    |  34 ++++++++++++++
> > >  3 files changed, 146 insertions(+)
> >=20
> > Do we know if this is actually necessary? I remember having a discussion
> > with Arnd Bergmann a while ago, and the Linux driver model kind of
> > assumes that by the time a device is disabled all outstanding accesses
> > will have stopped.
> >=20
> > Do we have a way to determine that this even makes a difference? Can we
> > trigger a case where not doing this would cause breakage and see that
> > adding this fixes that particular issue?
> >=20
>=20
> Most likely it is. The memory controller can still be processing requests
> when the peripheral domain is powergated. This would mean the response ca=
nnot
> be delivered in that case. So we need to be sure there are no outstanding
> requests before shutting down the domain.

My point is that that's the driver's responsibility anyway, hence making
the explicit flush unnecessary.

Thierry

--xNm6VWMD3PcA105u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVqOeLAAoJEN0jrNd/PrOhFCoP/1ZbeC/RyL+p1T8/v7t5t1Z/
71H/16XngqLCD0CuhLjO6CLdNQ0fDrjoSf9I+3qVQ+jN7Wu7hKUhU1ZZ3gEVz71N
a+exibl8ehQGGbdw7TKIvi8DYuggchgWZCUlZTNYCYALkuKcf85Cky6YfaiJt2G6
2rBQDviWGAgCpBwEchA/x0jCGHS6ocjN8Dxveo1H//y9ySVjYcqKWzyYjgaqAqZV
ZaMi+dsg2s6qctQ5tB91Gao6IOoiaCYr4PahmvZ139QyUjSSXU3LjRVC02KGjA4n
NkxYYlT2Rs0+Y7GSWUo7sDngazihmb1R3f+P5eYMHdwbJWsO2IlQ/UXLER3P5Gac
OetLOMUhFaXfV4dTks4znKPQl6RfacNMnlnohhQoXwQJVh3npnuhJK4Sah+8qbBE
+i+FGyR3bIH3fYWlVJDhZ7uf6qR+uHAjp4/7RZlK75J82IcNTlcLI+KtQCL4SS7O
u2/brWtKjZS34MV6SUnZGutmMYzfKH0HeZY+RJtN7oiF2/89R7j6LzM9Cm3oonDi
sI26KtmMwUb6m0//T/Ww4PhkciFwqxqK4bwBoEI5P/te2tgWKuo2Gm1GkJaF4HIZ
tmxWegi8NQbH9BtNCmL8TzebBJF9XPl4QOLCeNfj4+iD4Cz8rvwmiW/l/rel1pFP
URknwa4SoEDeJgxDFE9y
=jFgL
-----END PGP SIGNATURE-----

--xNm6VWMD3PcA105u--
