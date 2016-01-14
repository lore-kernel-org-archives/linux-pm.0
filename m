From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 16/16] ARM64: tegra: select PM_GENERIC_DOMAINS
Date: Thu, 14 Jan 2016 11:29:24 +0100
Message-ID: <20160114102924.GA22340@ulmo>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <8579242.omBpg1aLr2@wuerfel>
 <CAPDyKFrewx5CbS9QKZAxqq0Gu+TywQ3nkDGZFURR=PJLtkDuyQ@mail.gmail.com>
 <11122786.kKumQ3Dhls@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <11122786.kKumQ3Dhls@wuerfel>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2016 at 10:21:06AM +0100, Arnd Bergmann wrote:
> On Thursday 14 January 2016 09:57:14 Ulf Hansson wrote:
> > On 13 January 2016 at 21:43, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> > > On Wednesday 13 January 2016 18:03:24 Thierry Reding wrote:
> > >> On Fri, Dec 04, 2015 at 02:57:17PM +0000, Jon Hunter wrote:
> > >> > Enable PM_GENERIC_DOMAINS for tegra 64-bit devices. To ensure that=
 devices
> > >> > dependent upon a particular power-domain are only probed when that=
 power
> > >> > domain has been powered up, requires that PM is made mandatory for=
 tegra
> > >> > 64-bit devices and so select this option for tegra as well.
> > >> >
> > >> > Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > >> > ---
> > >> >  arch/arm64/Kconfig.platforms | 2 ++
> > >> >  1 file changed, 2 insertions(+)
> > >> >
> > >> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.pla=
tforms
> > >> > index 9806324fa215..e0b5bd0aff0f 100644
> > >> > --- a/arch/arm64/Kconfig.platforms
> > >> > +++ b/arch/arm64/Kconfig.platforms
> > >> > @@ -93,6 +93,8 @@ config ARCH_TEGRA
> > >> >       select GENERIC_CLOCKEVENTS
> > >> >       select HAVE_CLK
> > >> >       select PINCTRL
> > >> > +     select PM
> > >> > +     select PM_GENERIC_DOMAINS
> > >> >       select RESET_CONTROLLER
> > >> >       help
> > >> >         This enables support for the NVIDIA Tegra SoC family.
> > >>
> > >> This has potential consequences for multi-platform builds, doesn't i=
t?
> > >> All of a sudden any combination of builds that includes Tegra won't =
be
> > >> possible to build without PM support.
> > >>
> > >> Adding linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org for visibility.
> > >>
> > >>
> > >
> > > Agreed, it would be better to add 'depends on PM_GENERIC_DOMAINS'
> > > dependencies in the drivers that require it.
> > >
> >=20
> > The problem with that approach is that if those drivers are cross SoC
> > drivers. In some cases PM isn't needed and it is.
> >=20
> > Of course I don't have the in depth knowledge about the drivers being
> > used in Tegra which may need PM, perhaps it's not that many?
> >=20
> > Anyway, to me it seems like ARCH_TEGRA should depend on PM instead.
> > Would that work?
>=20
> That seems a little over-restrictive, as it prevents you from
> building a tegra kernel even if none of the drivers that rely
> on the pm domains are used, but it would work.
>=20
> I've looked again at how other platforms (on arm32) do it, and
> a lot of them use "select PM_GENERIC_DOMAINS if PM", so they don't
> automatically enable PM, but they enable the pmdomain code if
> PM is already set. No driver really "depends on PM_GENERIC_DOMAINS",
> so we shouldn't really start that now or we end up with circular
> dependencies in the long run.

It just occurred to me that none of these options really make much of a
difference. As Jon mentioned once we merge this series a lot of features
on Tegra will start to rely on PM_GENERIC_DOMAINS and hence PM. So if we
do want to build a kernel with a maximum of Tegra features enabled (and
I think a multi_v7_defconfig should include that) we'll end up with a PM
dependency anyway, whether forced via select or implied via depends on.

I'm beginning to wonder if PM really should be an option these days. The
disadvantages of making it optional do outweigh the advantages in my
opinion. I'm not saying that, in general, it's totally useless to build
a kernel that has no PM support, but for the more specific case where
you would want to enable multi-platform support I don't think there's
much practical advantage in allowing !PM. One of the most common build
warnings are triggered because of this option. Also multi-platform
kernels are really big already, so much so that I doubt it would make a
significant difference if we unconditionally built PM support. Also the
chances are that we'll be seeing more and more SoCs support PM and rely
on it, much like Tegra would with the addition of this series.

I imagine that we could save ourselves a lot of headaches by simply
enabling PM by default, whether that be via the PM Kconfig option or by
selecting it from ARCH_TEGRA and any other architectures that may come
to rely on it. Doing so would also reduce the amount of test coverage
that we need to do, both at compile- and runtime.

Thierry

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWl3iBAAoJEN0jrNd/PrOhlBAP/1IkvmlDI2pinS/PtwoV6oOk
EgBcbBqUyd2zk/YZ6EC5mAD5Azh3a7NEvet2Ux+9MND1fNxXQ5KA8dGQz0XYWwWJ
WZPyebPUTUsaqqeVG10UA8bPAeD0ewj5g8rI1ZyKAQED8JYInCLuzVN1h/+29fdl
HhADB85n6egLj67IS/03RNIhtDbk7QVjRjSAC+ZJQXIJxJGoCA989GNt18pxfQxg
PxZ6W33tv1DtCL5YEhfsUcTZlRaDULt1dAWl+BET0J4o8CeqDkDcvr9ufQc+nwAk
QxLfI6mQ++dhCzSTxSMT3Jc/EpV42d5/3mXDZZ4wmRxGS56ZKFiAood9I6iCMYpW
m5Gro3+alGKoYsdVKqtlQIC5grEJkkfnSlmfl/nMmB46T5h97wop7iIhAcYgJNXK
SZZkIgu6ZSNtrdY/s+L24QddAF9kWw5Y/VKxaO0LBVcjdBLwT04Qr7JUvqH/lhFJ
jb3nTz64cqHf/u/XMKd03a4dOUnmkEQICtVUMcjPZeTatiWwaanXUJtNHZ20kvx0
d/Xc4pXicTtKDaYvUVoBrg79z1e0Zt26OKz0BZ1BY9DNhqQ5//GykISoPsx+BM15
3Ae9zmdnDHMZk8BIeODByTaa8RKj/olOQ2c2RwMW8GfIrBF6OzcF7eBNv5O/zXmW
sOgWDaYrHJMx9WPcDCQv
=4NxC
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
