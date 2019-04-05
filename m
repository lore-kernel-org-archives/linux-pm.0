From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: power: supply: add missing semi-colon
 in example
Date: Fri, 5 Apr 2019 16:54:15 +0200
Message-ID: <20190405145415.4dthzpqgvww7gv3a@earth.universe>
References: <20190328203518.12100-1-sebastien.bourdelin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wepqn5kyeknu4t3h"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190328203518.12100-1-sebastien.bourdelin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org
List-Id: linux-pm@vger.kernel.org


--wepqn5kyeknu4t3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 28, 2019 at 04:35:18PM -0400, Sebastien Bourdelin wrote:
> Fix the example documentation which is missing a semi-colon.
>=20
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
> ---
>  Documentation/devicetree/bindings/power/supply/gpio-charger.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.=
txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> index adbb5dc5b6e9..ddf7b7b971e1 100644
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
> @@ -20,7 +20,7 @@ Example:
>  		compatible =3D "gpio-charger";
>  		charger-type =3D "usb-sdp";
>  		gpios =3D <&gpf0 2 0 0 0>;
> -	}
> +	};
> =20
>  	battery {
>  		power-supplies =3D <&usb_charger>;
> --=20
> 2.20.1
>=20

Thanks, queued.

-- Sebastian

--wepqn5kyeknu4t3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynbBMACgkQ2O7X88g7
+pqViRAAo72q+SntauFv4VqYQR6nq1rukGbCNCYWqdn1DW8iSGQQNWJbtq+jJ7lC
eWcrAMYx64tGioMfW0WRhJLPjXC393h7XRG4LvCUJDXBxzl6Yx7gDA0DkyEZpJMH
OLxgTK7NNmS3fSdtPkwi90C+QOKV013Ci/HBpoEX35b1Jrx/Z58q3mHrxCstFW5j
qgHvnUslid4LTpHnbLF3UfdG2a9cmXLrpdooUxaJ3khIbo1KKcU56UR1raXuwQvZ
bJUZx3SkDUowr/FhaoyWNEFWYwWG0fHgXtoi5aUu4TMGu7xgZz23gsXOh+y3UD48
UIq1qwhMBe6X+f3JenzGwdZcL0qw/jlwtFZGST/qhb2aLTxbsyfw86JNm8ogUgBN
b3FrH81iMPTzHEVJP5oLSSYHqHoq+iOXB6vuu8FtpwUxR1Mw6ULESV2qyBKv5lDC
43cT+UAwAYGrMg7tMA5RqXMQH4CjTA4zWUNvY8jL7oADFrZkFtGNHWsCQwwm/RnU
dHuc6Frn5JL9DJxXxsVXtLlKfVgrUr6wjoNWkG19p8i9GhRimFN67IH/nYViJLpU
LMskOjETonKzy6+ubpEclSpJGtW1LyS+dAiNaCWlbwaRGa0+FDkW62Uwiyz0+Bgn
Px/ZR6dYskChIQAJEGx47BwJ2/OVGrdSx3N7bbnWWtF+z9igHsU=
=uV8j
-----END PGP SIGNATURE-----

--wepqn5kyeknu4t3h--
