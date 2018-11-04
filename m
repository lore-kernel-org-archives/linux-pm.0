From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 10/15] dt-bindings: olpc_battery: Add XO-1.5 battery
Date: Sun, 4 Nov 2018 13:32:36 +0100
Message-ID: <20181104123236.GC23864@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-11-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="exKAuxcSaZxx4B14"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010172300.317643-11-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--exKAuxcSaZxx4B14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:22:55, Lubomir Rintel wrote:
> The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> ambient temperature.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

Rob, can you apply?

Thanks,
								Pavel
> ---
>  Documentation/devicetree/bindings/power/supply/olpc_battery.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/olpc_battery.=
txt b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> index c8901b3992d9..8d87d6b35a98 100644
> --- a/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
> @@ -2,4 +2,4 @@ OLPC battery
>  ~~~~~~~~~~~~
> =20
>  Required properties:
> -  - compatible : "olpc,xo1-battery"
> +  - compatible : "olpc,xo1-battery" or "olpc,xo1.5-battery"

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--exKAuxcSaZxx4B14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve5uQACgkQMOfwapXb+vKOOgCgvORUsCnIW67FaO2Fa19FQF6m
GQYAnj3CcS/pyVP4+UBUMA4sAss8/1AK
=deGE
-----END PGP SIGNATURE-----

--exKAuxcSaZxx4B14--
