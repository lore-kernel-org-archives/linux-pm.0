From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 05/11] power: Allow compile test of GPIO consumers if
 !GPIOLIB
Date: Wed, 5 Aug 2015 05:49:52 +0200
Message-ID: <20150805034952.GC16139@earth>
References: <1438506475-31012-1-git-send-email-geert@linux-m68k.org>
 <1438506590-31673-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438506590-31673-1-git-send-email-geert@linux-m68k.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 02, 2015 at 11:09:50AM +0200, Geert Uytterhoeven wrote:
> The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
> not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
> functionality only, can still be compiled if GPIOLIB is not enabled.
>=20
> Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
> appropriate.

Thanks, queued.

-- Sebastian

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVwYfgAAoJENju1/PIO/qaAawQAJEh+5CfBeTR7IhCrcM71GBL
Xy47FFgzSe/VdHBCSgQKWuSpyYwpZU/3DLCM+FPhr08YCw8I5jvWAutKhvKVYHWH
IrpBJPEI1cOY+jZpFpwJWT/N0FeC9sdrkmU7ZEJ1WiFbd/W3VJwx4pjNidsspZ9F
UrEkhVgGAKIEJVVGL0Ofc2osXv1ay3rUn318HQrRPSfITndEU5gDIa5erQfpN9Dy
YPAgCnCa+ZybcyF7n31oK9hP8OXAupoAhJdmGia076HX1u0H1Blm6+pynicKHIIY
BuoinxBDf3t0ONRwAbzoMiKl9OtfAbPaD9p39SAKVpamD4biYXDj8AZorMoiJlEF
+enPobRvMvyLMFNG8EbD2MjO2gF8xlouPS76X6fXspY5I2jgAfKrP0pqBt+8Uby3
CjosLjqW9t2uzQrK7ld3WVaLg3HTs+qABIcNaDwxwjInmX51ttU9+sb01oInXsyn
zgAvGKKbWD8cdOGiDAoPB3RlqJdcreypx4OZ98hyQclP5OkBHnffBxSEC9DGFYB7
oJKC11zenonOM8nHv1e49KL/pJTWqxHjeNX5OsixvN/FLgxQJh2BUDZgj7Bt9fty
VaotPRjPhOuJ9b5HVGy5ZpTnvrJHvOOI/rNsftZAxEgD2u4iyLgS6E1ZKflCZT8M
X/LyGm1uUDYV21pAxkaa
=rKHn
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
