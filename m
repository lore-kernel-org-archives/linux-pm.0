From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v2 3/3] ARM: bcm281xx: Add thermal driver to device tree.
Date: Sun, 13 Oct 2013 18:19:35 -0400
Message-ID: <525B1C77.1070809@ti.com>
References: <1380321454-16216-1-git-send-email-wendy.ng@broadcom.com> <1380321454-16216-4-git-send-email-wendy.ng@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xEUHJ2IDlxa5BlK3tEPOXJqtg6TBP73N8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44475 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755268Ab3JMWTo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 13 Oct 2013 18:19:44 -0400
In-Reply-To: <1380321454-16216-4-git-send-email-wendy.ng@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wendy Ng <wendy.ng@broadcom.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Stephen Warren <swarren@wwwdotorg.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Christian Daudt <bcm@fixthebug.org>, Markus Mayer <mmayer@broadcom.com>, eduardo.valentin@ti.com

--xEUHJ2IDlxa5BlK3tEPOXJqtg6TBP73N8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 27-09-2013 18:37, Wendy Ng wrote:
> This patch adds the device tree node for Broadcom bcm281xx SoCs thermal=

> driver.
>=20
> Signed-off-by: Wendy Ng <wendy.ng@broadcom.com>
> Reviewed-by: Markus Mayer <mmayer@broadcom.com>
> Reviewed-by: Christian Daudt <csd@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm11351-brt.dts |    4 +++-
>  arch/arm/boot/dts/bcm11351.dtsi    |    6 ++++++
>  arch/arm/boot/dts/bcm28155-ap.dts  |    4 ++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm=
11351-brt.dts
> index 9d36eb4..0771b6b 100644
> --- a/arch/arm/boot/dts/bcm11351-brt.dts
> +++ b/arch/arm/boot/dts/bcm11351-brt.dts
> @@ -43,5 +43,7 @@
>  		status =3D "okay";
>  	};
> =20
> -
> +	thermal@34008000 {
> +		status =3D "okay";
> +	};
>  };
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm113=
51.dtsi
> index 05a5aab..aa13353 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -96,4 +96,10 @@
>  		status =3D "disabled";
>  	};
> =20
> +	thermal@34008000 {
> +		compatible =3D "brcm,bcm11351-thermal", "brcm,kona-thermal";
> +		reg =3D <0x34008000 0x0024>;
> +		thermal-name =3D "bcm_kona_therm";

As I mentioned previously, my only concern is this thermal binding,
which is specific to your driver (BTW, you would need to do
bcm,thermal-name)

> +		status =3D "disabled";
> +	};
>  };
> diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm2=
8155-ap.dts
> index 96ae67a..a39aa47 100644
> --- a/arch/arm/boot/dts/bcm28155-ap.dts
> +++ b/arch/arm/boot/dts/bcm28155-ap.dts
> @@ -42,4 +42,8 @@
>  		max-frequency =3D <48000000>;
>  		status =3D "okay";
>  	};
> +
> +	thermal@34008000 {
> +		status =3D "okay";
> +	};
>  };
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--xEUHJ2IDlxa5BlK3tEPOXJqtg6TBP73N8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlJbHHcACgkQCXcVR3XQvP2tlwD/YKbW5AA0RTW/ANgE0vWpj5is
l9bDYE5es0fsjRMGusABAK7H1P0Hu5YABHeZz6C9h+hQO7nq/DuJ95xBvLr3vUPJ
=zSTa
-----END PGP SIGNATURE-----

--xEUHJ2IDlxa5BlK3tEPOXJqtg6TBP73N8--
