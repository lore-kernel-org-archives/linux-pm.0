From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: power: supply: bq24190_charger: add
 bq24192 and usb-otg-vbus
Date: Wed, 5 Dec 2018 22:55:43 +0100
Message-ID: <20181205215543.voo7lvdngyhbcpwz@earth.universe>
References: <20181101001149.13453-1-masneyb@onstation.org>
 <20181101001149.13453-2-masneyb@onstation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="upvwbs3og7fcr6a7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181101001149.13453-2-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Masney <masneyb@onstation.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org, bjorn.andersson@linaro.org, linus.walleij@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org, jonathan@marek.ca
List-Id: linux-pm@vger.kernel.org


--upvwbs3og7fcr6a7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2018 at 08:11:43PM -0400, Brian Masney wrote:
> Add support for the ti,bq24192 variant and a child node for the
> usb-otg-vbus regulator.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---

Thanks, queued.

-- Sebastian

>  .../devicetree/bindings/power/supply/bq24190.txt         | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b=
/Documentation/devicetree/bindings/power/supply/bq24190.txt
> index 9e517d307070..c8ac028bd3c7 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq24190.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
> @@ -3,6 +3,7 @@ TI BQ24190 Li-Ion Battery Charger
>  Required properties:
>  - compatible: contains one of the following:
>      * "ti,bq24190"
> +    * "ti,bq24192"
>      * "ti,bq24192i"
>  - reg: integer, I2C address of the charger.
>  - interrupts[-extended]: configuration for charger INT pin.
> @@ -19,6 +20,12 @@ Optional properties:
>  - ti,system-minimum-microvolt: when power is connected and the battery i=
s below
>    minimum system voltage, the system will be regulated above this settin=
g.
> =20
> +child nodes:
> +- usb-otg-vbus:
> +  Usage: optional
> +  Description: Regulator that is used to control the VBUS voltage direct=
ion for
> +               either USB host mode or for charging on the OTG port.
> +
>  Notes:
>  - Some circuit boards wire the chip's "OTG" pin high (enabling 500mA def=
ault
>    charge current on USB SDP ports, among other features). To simulate th=
is on
> @@ -39,6 +46,8 @@ Example:
>  		interrupts-extended =3D <&gpiochip 10 IRQ_TYPE_EDGE_FALLING>;
>  		monitored-battery =3D <&bat>;
>  		ti,system-minimum-microvolt =3D <3200000>;
> +
> +		usb_otg_vbus: usb-otg-vbus { };
>  	};
> =20
>  	&twl_gpio {
> --=20
> 2.17.2
>=20

--upvwbs3og7fcr6a7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwISV8ACgkQ2O7X88g7
+poG9A/+NZpnXe0j0oS+VthaxBzcOEdztGXAO5n++Rmi6G7dYZU4v+K+ww0Hg1LD
Vr2FkEW3b3ujiMB6QsxY5iWIyjs96bm6P+ej8EA7Uf5eFW8LgGcWHd5GW7mEP6+J
uRV+n2YERnF07rNEBXd41agRC7f1uZDzR/xa4HfD/CJ523oFU32KaKLulaqPPjK7
+6lagKYBcN+a1ojgiPoJrA0QzO6mi8wAfbU3oo49X+YV9PYJA/fNEZYrnz8ql/6Q
8H+ZEsa90fUquq4DjNLqZ1DGqA1gr7E6Ktt5+n+pAhWx4I3sgd5JUQS3jpocwO9z
Ux0Q9UF/tfddpY3edIaGNzpDkAr93o7uTdCoeFx5h8LP0kyzFHK437lz1pwcId20
UuZ1Hk17wruvp9+SGf+2P0bm6mFbQbYXjCYhUbez6kW3xtLtO5yCd+BU3j/15Lxz
dEXZjrfhnc9tQyNtAzHHrEfLv3YyUSbTEcWkd1PvpSjiGbgOBhU/3cpOMKXAGdgW
TEeNDG9fNG5il8P10+ahcwF5zve9l4rfhHYYLHLMcVRSe0A+0ZVRduzWeRRY+klo
dhz/aJytsRZpdzF1BI17PcBDoTcygugLbkWgtgy8Q3YX1RgPX6XQBJ0TCbLAkp7p
s8ZIW2t1i7U5aLqtN5SK6Wk/noBbnOi+sSPXULpb5dS2z1BvDAg=
=f0o3
-----END PGP SIGNATURE-----

--upvwbs3og7fcr6a7--
