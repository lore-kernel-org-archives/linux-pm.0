From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 12/12] power: reset: account for const type of
 of_device_id.data
Date: Tue, 9 Jan 2018 17:22:43 +0100
Message-ID: <20180109162243.g3g3daq76gr7n3xj@earth.universe>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514899688-27844-13-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vlr36ntjzssbcf74"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1514899688-27844-13-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, kernel-janitors@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--vlr36ntjzssbcf74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 02, 2018 at 02:28:08PM +0100, Julia Lawall wrote:
> This driver creates a const structure that it stores in the data
> field of an of_device_id array.
>=20
> Add const to the declaration of the location that receives a value
> from the data field to ensure that the compiler will continue to check
> that the value is not modified and remove the const-dropping cast on
> the access to the data field.
>=20
> Done using Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/at91-sama5d2_shdwc.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff -u -p a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/res=
et/at91-sama5d2_shdwc.c
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -68,7 +68,7 @@ struct shdwc_config {
>  };
> =20
>  struct shdwc {
> -	struct shdwc_config *cfg;
> +	const struct shdwc_config *cfg;
>  	void __iomem *at91_shdwc_base;
>  };
> =20
> @@ -260,7 +260,7 @@ static int __init at91_shdwc_probe(struc
>  	}
> =20
>  	match =3D of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
> -	at91_shdwc->cfg =3D (struct shdwc_config *)(match->data);
> +	at91_shdwc->cfg =3D match->data;
> =20
>  	sclk =3D devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(sclk))
>=20

--vlr36ntjzssbcf74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpU7FIACgkQ2O7X88g7
+poEVhAAowv47EwAubRJ6F5M2xKJGWdJ9vuAxQ2koXsbZCQ/80zRpmAO3WtJTVbV
Ffttf6h8/urI7c37Oy6tJ1YYQYWn5KODviikAri1xFUlEnWp9BbTw12hGSgPj/o5
m8fNmQjtB6iU9xSZ/EHvR/wN9s2jXDNwGT2srCWvdAkmkWbukztD7aPBMm4gmovS
JR6pBysqNImL6U6OdgxwZKlndYjvuWBToCmOwLaBTa3kKorPprve3R1PypPadqpm
k2w65XdzDW1vYKqsAIYPNqOztyfpkfy8VoQRCq3nue4jvAFUJ+ySMoz7shecyTOd
SFcN6DPHcfMLwS+ugAd3f9g3ZhvAo2ZsPwXRj2vw4Z1MyLAo6jotTgs5Cs0TluZ/
fCy+LHM7NmE0Iad56OlfmKL7RpyEnwzenxx44UYeQ9yhD5r7THricnGNAw8mtOH2
kY/tG+MCwpRJXGptxj0H1Ei1ogb48b9jcu6U3I/n8ncUuhwcQ6/pEQqmBe/8M5Nw
KeSRlpvr/k/AJf/PutZZDQF6g4nD8SoluKUeszB0QFPb3FkvS/4x8NHwv2QKJk/8
zzBkIevLlKB0S3ZBDbQBgvcG95nus4lKEx+ZuMJfhfreoq+5gmM0tZG23uJDifWi
PzcfCydufi8aPmVZ1/w2VQyHRHFx0LmDUiBboB4pHWrECPzXpo4=
=Q0j4
-----END PGP SIGNATURE-----

--vlr36ntjzssbcf74--
