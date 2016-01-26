From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4 16/16] ARM64: tegra: select PM_GENERIC_DOMAINS
Date: Tue, 26 Jan 2016 18:30:01 +0100
Message-ID: <20160126173001.GA11062@ulmo.nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <11122786.kKumQ3Dhls@wuerfel>
 <20160114102924.GA22340@ulmo>
 <4244898.5om31fQ1mz@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4244898.5om31fQ1mz@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2016 at 12:11:39PM +0100, Arnd Bergmann wrote:
> On Thursday 14 January 2016 11:29:24 Thierry Reding wrote:
> >=20
> > It just occurred to me that none of these options really make much of a
> > difference. As Jon mentioned once we merge this series a lot of features
> > on Tegra will start to rely on PM_GENERIC_DOMAINS and hence PM. So if we
> > do want to build a kernel with a maximum of Tegra features enabled (and
> > I think a multi_v7_defconfig should include that) we'll end up with a PM
> > dependency anyway, whether forced via select or implied via depends on.
> >=20
> > I'm beginning to wonder if PM really should be an option these days. The
> > disadvantages of making it optional do outweigh the advantages in my
> > opinion. I'm not saying that, in general, it's totally useless to build
> > a kernel that has no PM support, but for the more specific case where
> > you would want to enable multi-platform support I don't think there's
> > much practical advantage in allowing !PM. One of the most common build
> > warnings are triggered because of this option. Also multi-platform
> > kernels are really big already, so much so that I doubt it would make a
> > significant difference if we unconditionally built PM support. Also the
> > chances are that we'll be seeing more and more SoCs support PM and rely
> > on it, much like Tegra would with the addition of this series.
> >=20
> > I imagine that we could save ourselves a lot of headaches by simply
> > enabling PM by default, whether that be via the PM Kconfig option or by
> > selecting it from ARCH_TEGRA and any other architectures that may come
> > to rely on it. Doing so would also reduce the amount of test coverage
> > that we need to do, both at compile- and runtime.
>=20
> I think this needs some investigation. As a general policy, we should
> not grow the kernel image size when moving from a traditional ARM
> platform to an ARCH_MULTIPLATFORM one.

If we make ARCH_TEGRA select PM, then moving to a multi-platform kernel
isn't automatically going to increase the image size. The image size is
only going to increase if you select ARCH_TEGRA to be part of the multi
platform image.

> This is somewhat contradicted by how we already require CONFIG_OF
> to be set for multiplatform kernels, and that adds around 80kb
> to the image size.

Yeah, there's also a fair amount of per-SoC code that can't be built as
a module and which will be included in multi-platform images when the
corresponding ARCH_* symbol is enabled. But I think that's inevitable
given the purpose of multi-platform images.

> Looking at just the defconfig files, these are the ones that currently
> do not set CONFIG_PM:
>=20
> build/acs5k_defconfig/.config:# CONFIG_PM is not set
> build/acs5k_tiny_defconfig/.config:# CONFIG_PM is not set
> build/axm55xx_defconfig/.config:# CONFIG_PM is not set
> build/bcm2835_defconfig/.config:# CONFIG_PM is not set
> build/clps711x_defconfig/.config:# CONFIG_PM is not set
> build/ebsa110_defconfig/.config:# CONFIG_PM is not set
> build/footbridge_defconfig/.config:# CONFIG_PM is not set
> build/ks8695_defconfig/.config:# CONFIG_PM is not set
> build/netwinder_defconfig/.config:# CONFIG_PM is not set
> build/rpc_defconfig/.config:# CONFIG_PM is not set
> build/u300_defconfig/.config:# CONFIG_PM is not set
> build/vf610m4_defconfig/.config:# CONFIG_PM is not set
>=20
> The only ones among these are are actually multiplatform are axm55xx,
> bcm2835, and u300. I see no downsides of force-enabling PM for
> any of those, so we could decide to 'select PM' from
> CONFIG_ARCH_MULTIPLATFORM.

ARCH_MULTIPLATFORM selecting PM would include PM unconditionally, even
if none of the selected platforms require it. In my opinion an explicit
select from platforms that require PM would be cleaner. It could be that
once we start doing that for a single platform others might follow. When
this becomes common place it might be worth moving it up a level, but I
think explicit dependencies would be better for starters.

> The one usecase where we may want to have a modern machine without
> CONFIG_PM is a minimal MACH_VIRT kernel for running in a virtual
> machine or QEMU with minimal memory requirements, e.g. trying to
> squeeze a large number of guests on a single host system.

Right, but those won't be multi-platform kernels, right? If you know
exactly that the kernel will run in a virtual machine and that you want
to run lots of virtual machines, you probably want to build a custom
kernel.

Thierry

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWp60WAAoJEN0jrNd/PrOhuioP/0GHx9p2TRUHbSilGpcRNV5C
MaBXqjjKcn4RJKr4ameuDbRxuVVOD9bxYhzwp1bLaaxeeIyqV+Z7W7xMc8JE1Yqx
lgaWWj3cdjUKo+EIlBAJp6ZiVwwREGH4Jr4noFD+bSxrXH8ao5J6eYVeJhshNAz7
oNBwNGD6KRZyedNc2IdA9fHyHCEm+NHRfysku2lxZ9XX/IyteIjFqNsSGNCne++E
bATxvdvZ7G9l86G4zAWl1JGMLAFJnXKXGQ4qYFsTjgH9Y7/71AaPEd2PFPTkNrvy
ZbmjgwUz29r+pj0OucmETrfmPFXQSh0l7GaX2P1EUrpgSuSu4XbXyl1a+Ks04mRB
D8IRs4VpsDt67MZY5bJUFVJyutKLUaMiHNFFRBc5EArSwfhO7xJ00FuGHufRzMjc
Bu14iH12qL8McPoBHUTRhbRRtpI08q1ecd389THuNjc7lkOcal9SPJkFa/lHPLum
0NYhqdAdwy0GP+xRr+cNUcBNXbTp7VzIacRkw+AH3CnYppgkmesBT3SZyuQqGPJX
10dc/MfpkhoqwXgCvkkxEQAB7x41bcJYEDPJERSIXg/35NcoPzhHhwegTvLYiZgf
R/0BI24SSVpg9sJJCskjYfAdogKoxhsgf6/GngG08UzkteZCaOUVHhGMuUyZbR0s
8zulK3y3Wbe7ngFACORH
=cC6V
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
