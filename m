From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 02/15] Revert "platform/olpc: Make ec explicitly
 non-modular"
Date: Fri, 2 Nov 2018 23:16:27 +0100
Message-ID: <20181102221626.GC5322@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-3-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010172300.317643-3-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:22:47, Lubomir Rintel wrote:
> It doesn't make sense to always have this built-in, e.g. on ARM
> multiplatform kernels. A better way to address the problem the original
> commit aimed to solve is to fix Kconfig.
>=20
> This reverts commit f48d1496b8537d75776478c6942dd87f34d7f270.

This looks ok, but I don't see the Kconfig fix in the series. Is it
needed?
									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvczLoACgkQMOfwapXb+vKP3wCgncIgCUhQc8t9VMf5U6GgH+2s
/+AAn1nqvwQUi61z0K6p8w+6e0NOu84z
=1Ih7
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
