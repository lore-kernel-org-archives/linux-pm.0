From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 08/15] Platform: OLPC: Move EC-specific functionality out
 from x86
Date: Sun, 4 Nov 2018 13:31:38 +0100
Message-ID: <20181104123138.GB23864@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-9-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PAKmkkBo0+rTwAqJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010172300.317643-9-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--PAKmkkBo0+rTwAqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:22:53, Lubomir Rintel wrote:
> It is actually plaform independent. Move it to the olpc-ec driver from
> the X86 OLPC platform, so that it could be used by the ARM based laptops
> too.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PAKmkkBo0+rTwAqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve5qoACgkQMOfwapXb+vIiRwCfd/JiJ2h9sqnx2OYVfTND+S4Y
ImMAn14ASAbOEG0fzL9/dwFjsyPP6ejZ
=q11j
-----END PGP SIGNATURE-----

--PAKmkkBo0+rTwAqJ--
