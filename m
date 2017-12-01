From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 1/2] power: supply: ab8500_charger: Fix an error handling
 path
Date: Fri, 1 Dec 2017 16:29:43 +0100
Message-ID: <20171201152943.ckzvhph45kj76blr@earth>
References: <20171122202731.13414-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kh5olwkwxpob3tjf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171122202731.13414-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--kh5olwkwxpob3tjf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 22, 2017 at 09:27:31PM +0100, Christophe JAILLET wrote:
> 'ret' is know to be 0 at this point, because it has not been updated by t=
he
> the previous call to 'abx500_mask_and_set_register_interruptible()'.
>=20
> Fix it by updating 'ret' before checking if an error occurred.
>=20
> Fixes: 84edbeeab67c ("ab8500-charger: AB8500 charger driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index 4ebbcce45c48..1cdbe7a0738d 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -3218,7 +3218,7 @@ static int ab8500_charger_init_hw_registers(struct =
ab8500_charger *di)
>  	}
> =20
>  	/* Enable backup battery charging */
> -	abx500_mask_and_set_register_interruptible(di->dev,
> +	ret =3D abx500_mask_and_set_register_interruptible(di->dev,
>  		AB8500_RTC, AB8500_RTC_CTRL_REG,
>  		RTC_BUP_CH_ENA, RTC_BUP_CH_ENA);
>  	if (ret < 0)
> --=20
> 2.14.1
>=20

--kh5olwkwxpob3tjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlohdWcACgkQ2O7X88g7
+poRJQ/7BZsVvHPf31Cz1zVmE7Ckcj/5TJhk857OTDBx9t2rC42DXPbtDwYLj+oH
ia/RlPPHt10SpOzTZeR6hzUKoYNZlCmYHEEKg7qUhAz56Az+yxtB72vnBH2GZ0Eq
UvaZ2aLUODLLJzhJLmQ90N5iGxP9YBg/MoCXY6+QAukA/YJOgu2rK9fEtZAWVhkI
a3QAHOAOqNFJBcvur9zhJzv0RsjDyM33ATH3iziCRGkPiGmwOQZQTEGl4eAiWPYJ
vPCaw3SgDfY15tqxF4Vg3ZGAsc1IpiHJNrgKRYV9cZfchV9FTc72ufb9lye9PDJy
XMtXb2ZJukwxUQ3+OxfeTyGxV+fKbukUd5BiLlCIbmpzEgOrWY0EQFyij0KdxNk/
7adoPIX2LIuLqapxvHcwQl7OelwRry4pohUoVbryjeqB+ndEa25DSZ7pOjqKg3QZ
CfBSFZwC1xQRmZ0UyjAuslFzcJvjdHq2HjU3EElXq7ObQo5FKkQ5agohI/wLi3gy
XSPk8StfWEN4I8p4/nKpMXvP3rcAaAErYHwPiSPknZS6R6EoVlb0eqe2tIS0CID4
JedPEdBLbmfK0Pc4jx2KUMYS4kC0FMxcATlkizTHBrr4pEp4ICLKvQy2XlXj/qi6
VBOCgXWALxUZ62okmsl0DLxy6/S9kR17yGJqGt6th7C+hDv9mAQ=
=XTMz
-----END PGP SIGNATURE-----

--kh5olwkwxpob3tjf--
