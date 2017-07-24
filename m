From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: act8945a_charger: fix of_irq_get() error
 check
Date: Mon, 24 Jul 2017 20:54:10 +0200
Message-ID: <20170724185410.lrhizj4ydg5l5ivv@earth>
References: <20170716175244.300670810@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="utn5pgbhtiqq5h76"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754238AbdGXSyN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Jul 2017 14:54:13 -0400
Content-Disposition: inline
In-Reply-To: <20170716175244.300670810@cogentembedded.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>


--utn5pgbhtiqq5h76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 16, 2017 at 08:52:20PM +0300, Sergei Shtylyov wrote:
> of_irq_get() may return any negative error number as well as 0 on failure,
> while the driver only checks for -EPROBE_DEFER, blithely continuing with
> the call to devm_request_irq() -- that function expects *unsigned int*,
> so would probably fail anyway when a large IRQ number resulting from a
> conversion of a negative error number is passed to it... This, however,
> is incorrect behavior -- error number is not IRQ number.
>=20
> Check for 'irq <=3D 0' instead and return -ENXIO from probe if of_irq_get=
()
> returned 0.
>=20
> Fixes: a09209acd6a8 ("power: supply: act8945a_charger: Add status change =
update support")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, applied to power-supply's fixes branch.

-- Sebastian

> ---
>  drivers/power/supply/act8945a_charger.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Index: linux/drivers/power/supply/act8945a_charger.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/power/supply/act8945a_charger.c
> +++ linux/drivers/power/supply/act8945a_charger.c
> @@ -596,9 +596,9 @@ static int act8945a_charger_probe(struct
>  		return ret;
> =20
>  	irq =3D of_irq_get(pdev->dev.of_node, 0);
> -	if (irq =3D=3D -EPROBE_DEFER) {
> +	if (irq <=3D 0) {
>  		dev_err(&pdev->dev, "failed to find IRQ number\n");
> -		return -EPROBE_DEFER;
> +		return irq ?: -ENXIO;
>  	}
> =20
>  	ret =3D devm_request_irq(&pdev->dev, irq, act8945a_status_changed,
>=20

--utn5pgbhtiqq5h76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll2QlIACgkQ2O7X88g7
+po4qhAAlBwM5Qr09j1sZUKtsZFGDrYdBiWKa5Ogqh2lHEj3OWj8o/scmgMhJoku
TAjV++vyr285yGLeIg9uz+UU2Nu48vigfi+DLE683exVC32mzUVtc5ibYz145vjG
tER3MtRGREHwjBEATte71ulf0u4jXSmJZ23r64SQ4k6Xh2dA6AafU747CTw+irPL
2dwkyVsL/ol/2YFh2AFrNr2XMxP7IdZBOw2dDK+aAn5cIdcDH4FfIIHkfCV92Yjj
hu2RZVyPdqAVipxFKtjVZTDeOFcp8aUbWzUdq2kOPCuFiMEkNL7dYXSm3pKO/ICB
3nn18envsR+MGDCWEokxTCur942iNmdJcoBd3pVxJZDTDUyYVWaQMejNrL6feAU4
Pksz5KGMUzzOKoD6wIcKULsOLyUkh3AkwWjogLleEhIiT2ew7akVVZaVudpPjKUi
5MfwX2Ig9IEl2DlsBbUftiyvkMkM78TNtPc8GrvtUa5IBMw1Y5VYEXYnrsjcFkXw
pQcsZY7kgpgvi3+g3d3S/xBl6hyqqOW1dM9QkxYmaOVpPtAqZmzApsPiNKB1Ae7U
mJ6gWeOGBkKbeHeneMK5V/JcJyFLrf7BdyAVlDTkiou+Z3XiU3W2o9zqtS7dYiCL
mEuXcXsNtWnP80Ix6oIyae4JO56HC1Hu+d/3KrloBKxQ1Et3eAw=
=JJSp
-----END PGP SIGNATURE-----

--utn5pgbhtiqq5h76--
