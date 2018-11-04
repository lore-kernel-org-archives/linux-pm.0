From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 04/15] Platform: OLPC: Remove an unused include
Date: Sun, 4 Nov 2018 13:26:58 +0100
Message-ID: <20181104122657.GY23864@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-5-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nynJ8Zgemp8dhn89"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010172300.317643-5-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--nynJ8Zgemp8dhn89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:22:49, Lubomir Rintel wrote:
> Also, the header is x86 specific, while there are non-x86 OLPC machines.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  drivers/platform/olpc/olpc-ec.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
> index f99b183d5296..35a21c66cd0d 100644
> --- a/drivers/platform/olpc/olpc-ec.c
> +++ b/drivers/platform/olpc/olpc-ec.c
> @@ -15,7 +15,6 @@
>  #include <linux/module.h>
>  #include <linux/list.h>
>  #include <linux/olpc-ec.h>
> -#include <asm/olpc.h>
> =20
>  struct ec_cmd_desc {
>  	u8 cmd;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--nynJ8Zgemp8dhn89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve5ZEACgkQMOfwapXb+vLjLACeJwI9ebl2n/bkGs5TRGBn6hgz
jCgAoJMxkcGRfim7k6f6oax1MkWyZjWW
=sRS6
-----END PGP SIGNATURE-----

--nynJ8Zgemp8dhn89--
