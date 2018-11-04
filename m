From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 03/15] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC
 bindings
Date: Sun, 4 Nov 2018 13:26:36 +0100
Message-ID: <20181104122636.GX23864@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-4-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3754414334320641034=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181010172300.317643-4-lkundrak@v3.sk>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============3754414334320641034==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b2s+RKoBicgQlNJs"
Content-Disposition: inline


--b2s+RKoBicgQlNJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:22:48, Lubomir Rintel wrote:
> The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> signals for handshaking. It needs to know when is the slave (Linux)
> side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> controller node) and when does it wish to respond with a command (the
> cmd-gpio property).
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>


> ---
>  .../bindings/misc/olpc,xo1.75-ec.txt          | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec=
=2Etxt
>=20
> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt b/=
Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> new file mode 100644
> index 000000000000..14385fee65d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> @@ -0,0 +1,24 @@
> +OLPC XO-1.75 Embedded Controller
> +
> +Required properties:
> +- compatible: Should be "olpc,xo1.75-ec".
> +- cmd-gpio: gpio specifier of the CMD pin
> +
> +The embedded controller requires the SPI controller driver to signal rea=
diness
> +to receive a transfer (that is, when TX FIFO contains the response data)=
 by
> +strobing the ACK pin with the ready signal. See the "ready-gpio" propert=
y of the
> +SSP binding as documented in:
> +<Documentation/devicetree/bindings/spi/spi-pxa2xx.txt>.
> +
> +Example:
> +	&ssp3 {
> +		spi-slave;
> +		status =3D "okay";
> +		ready-gpio =3D <&gpio 125 GPIO_ACTIVE_HIGH>;
> +
> +		slave {
> +			compatible =3D "olpc,xo1.75-ec";
> +			spi-cpha;
> +			cmd-gpio =3D <&gpio 155 GPIO_ACTIVE_HIGH>;
> +		};
> +	};

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--b2s+RKoBicgQlNJs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve5XwACgkQMOfwapXb+vJx6QCdGqqNgkjNqR4djwsotKU86vIg
OmMAnjS8aSbF0gsMNHfYnF5fM5wl4Sfv
=CwE1
-----END PGP SIGNATURE-----

--b2s+RKoBicgQlNJs--

--===============3754414334320641034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============3754414334320641034==--
