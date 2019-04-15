From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: supply: Add
 charge-status-gpios property
Date: Mon, 15 Apr 2019 22:09:51 +0200
Message-ID: <20190415200951.jcp2ksfn7osucyxh@earth.universe>
References: <20190414124039.10040-1-contact@artur-rojek.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gcnw5pz23wsfch2f"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190414124039.10040-1-contact@artur-rojek.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Rob Herring <robh@kernel.org>
List-Id: linux-pm@vger.kernel.org


--gcnw5pz23wsfch2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 14, 2019 at 02:40:38PM +0200, Artur Rojek wrote:
> Add documentation for the "charge-status-gpios" property.
> Update the "gpios" property with a valid example.
>=20
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Thanks, both queued.

-- Sebastian

>=20
> Changes:
>=20
> v2: - add a better description for the "status-gpios" property,
>     - add valid examples for the "gpios" and "status-gpios" properties
>=20
> v3: rename the "status-gpios" property to "charge-status-gpios"
>=20
>  .../devicetree/bindings/power/supply/gpio-charger.txt       | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.=
txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> index adbb5dc5b6e9..30349332f051 100644
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> @@ -14,12 +14,16 @@ Required properties :
>       usb-cdp (USB charging downstream port)
>       usb-aca (USB accessory charger adapter)
> =20
> +Optional properties:
> + - charge-status-gpios: GPIO indicating whether a battery is charging.
> +
>  Example:
> =20
>  	usb_charger: charger {
>  		compatible =3D "gpio-charger";
>  		charger-type =3D "usb-sdp";
> -		gpios =3D <&gpf0 2 0 0 0>;
> +		gpios =3D <&gpd 28 GPIO_ACTIVE_LOW>;
> +		charge-status-gpios =3D <&gpc 27 GPIO_ACTIVE_LOW>;
>  	}
> =20
>  	battery {
> --=20
> 2.21.0
>=20

--gcnw5pz23wsfch2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly05QsACgkQ2O7X88g7
+pqdGA/+KsYQL0q2WUeGM35ujw9cogRo7OFQO4V0JOEYvGAB/ZoTEUqoVYOTi+aq
V/I4c+WDh2I5o74/QY+zCuyQJtxkO5/DWWQoiOteXX91UW6siSHu4oosm0GRYRKJ
H9fjYcNcpBN8UCtOMezNdKbhPdA2oPc4OZWQp0qsu5Jab7QNPEHgHuz5E8FQ4pLU
ZiihiBLkWAR5RnwB3LB6w9v+xk8+NAQc5Wve0uGo3cu0MreP+hQbnp5wGD1RjOj6
dTrtZYgfV4U0gofRrrZfS+Scg2QGNTKtzSmEVd5Qtbx6DxUCGSPGilglJX4hu2Qr
Ww7GHW0Nd3nHvhxr3y6ugY9tYOw+dPQhmLbV+DaIqTa97F8D2YJBDQ4bxGuYTaZu
K9w87Kcl8XmEyeXMj/T43dylLGA3NiCAxK4PUAN69SRpbJqjpUkaw6l5kxRSYYtg
Mio17MIwwz01Q0+By6AHwmEbuVJ0OJYh47ezF4zDWDAMvf9WiuVfsUPmpujUleLY
R1elh5wEHTH4rgVlRIXwkH8Zy+oYL3v/LpJ/1q4CJsFlC46nCdq0sJbnfPlTA+bE
xHqsKc4knclLHaSqlVrGORnlPZch0TD66VSHcXHnrHdq2x5/9tHgTL+sT2gj1Ekl
48vRc0rCLWGAa0KCzFCG2LhLzZmVELZZ19T7+bXZcdqigHlZZ6A=
=1Nfv
-----END PGP SIGNATURE-----

--gcnw5pz23wsfch2f--
