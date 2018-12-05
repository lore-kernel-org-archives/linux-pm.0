From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 3/7] power: supply: bq24190_charger: add of_match for
 usb-otg-vbus regulator
Date: Wed, 5 Dec 2018 22:56:24 +0100
Message-ID: <20181205215624.gyvfuj77givf7kp6@earth.universe>
References: <20181101001149.13453-1-masneyb@onstation.org>
 <20181101001149.13453-4-masneyb@onstation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qhn2t7rc6fbpxv2l"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181101001149.13453-4-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Masney <masneyb@onstation.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org, bjorn.andersson@linaro.org, linus.walleij@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org, jonathan@marek.ca
List-Id: linux-pm@vger.kernel.org


--qhn2t7rc6fbpxv2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2018 at 08:11:45PM -0400, Brian Masney wrote:
> From: Jonathan Marek <jonathan@marek.ca>
>=20
> This patch adds an of_match for the usb-otg-vbus regulator to
> bq24190_charger.
>=20
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 44d3aff32885..9e7f3e33458a 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -577,6 +577,7 @@ static const struct regulator_ops bq24190_vbus_ops =
=3D {
> =20
>  static const struct regulator_desc bq24190_vbus_desc =3D {
>  	.name =3D "usb_otg_vbus",
> +	.of_match =3D "usb-otg-vbus",
>  	.type =3D REGULATOR_VOLTAGE,
>  	.owner =3D THIS_MODULE,
>  	.ops =3D &bq24190_vbus_ops,
> --=20
> 2.17.2
>=20

--qhn2t7rc6fbpxv2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwISYgACgkQ2O7X88g7
+podGw//XYTuTWwcY1PVw5xHr+UgRZpye06oGqCwAneRo08uj+G+3Sh6qZ+8hTIu
Ee7Vs2Hf/x6LmdlOWWI5J+7BYzlfCCYeBUKtBIVDupk1m4BtT1Nf5pMTlWugA4fy
/JzDPd1FMkzDQdAheS/24/EuQKaU/c+9rYlGpF8aaFyDb77FLZ8t47Jm8FC8qMzW
srIA5ZM6Rd1wYC8AkqtvGG5MJN9cMwbBjhCff5qxC61duwWNx8b/WMZZ0F85OCT4
kt6lMuACLt9dz3U93eMZgJMugHAGzFdn7NQOpOEbJZ6EHWz6NnKOWuXhppyBb60j
2dgMKLQwqv2Or/QwMoqEJQR18tCrcSFPsk1YJF3UuQ8cy9EkKyHqbvF9apSxpZOC
89Cbv4rPxVdq0YY7WpwDYpWCQFxED2+vUEWLoXU5obScgogcqbvo5fJtKldJZCDy
rPJ1OKYQXP45lz/pn+5fUSb3bwkIu+DNg+RmsE0rcb72+6yLFYLyyUrHI4tXdQYk
1vRcx5D0IBytIrB8mbfqYcy/6fSiJBZDoEQFmFTGwmgNHaDmKP32NwsqfSRoxFgU
9afubfPNr/5fhDRUBmSQd0qzooWgt5G2sk6Pv6msuJWNTuR41xivQ/BSkzt//Fmq
PyIcLNRscDkO63r4mGsJfufRPP7/jw0gpdP9v0Oz5WnnkGsdSdk=
=tknY
-----END PGP SIGNATURE-----

--qhn2t7rc6fbpxv2l--
