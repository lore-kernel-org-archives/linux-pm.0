From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] thermal: rcar: set up I/O base before requesting IRQ
Date: Tue, 4 Jun 2013 08:53:23 -0400
Message-ID: <51ADE343.1000505@ti.com>
References: <1370311753-6463-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2AVBFJCQXTPSJTFMPEKQG"
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1370311753-6463-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Ulrich Hecht <ulrich.hecht@gmail.com>, eduardo.valentin@ti.com
List-Id: linux-pm@vger.kernel.org

------enig2AVBFJCQXTPSJTFMPEKQG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Simon, Ulrich,

On 03-06-2013 22:09, Simon Horman wrote:
> From: Ulrich Hecht <ulrich.hecht@gmail.com>
>=20
> It is used by the interrupt handler. Fixes crash when booting via kexec=

> on APE6 board.
>=20
> This problem was introduced by e0a5172e9eec7f0d3c476e013c51dab62f3fc666=

> ("thermal: rcar: add interrupt support") which was introduced in v3.8-r=
c3.
>=20
> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> [horms+renesas@verge.net.au: enhanced changelog to include commit
>   that cuases the problem ]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/rcar_thermal.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> Hi Zhang,
>=20
> could you consider this fix for v3.10?
>=20
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_ther=
mal.c
> index 8d7edd4..7641dcc 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -395,13 +395,6 @@ static int rcar_thermal_probe(struct platform_devi=
ce *pdev)
>  			return -ENODEV;
>  		}
> =20
> -		ret =3D devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
> -				       dev_name(dev), common);
> -		if (ret) {
> -			dev_err(dev, "irq request failed\n ");
> -			return ret;
> -		}
> -


Should this IRQ be disabled while this driver gets initialized? Reset
state is enabled?

>  		/*
>  		 * rcar_has_irq_support() will be enabled
>  		 */
> @@ -409,6 +402,13 @@ static int rcar_thermal_probe(struct platform_devi=
ce *pdev)
>  		if (IS_ERR(common->base))
>  			return PTR_ERR(common->base);
> =20
> +		ret =3D devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
> +				       dev_name(dev), common);
> +		if (ret) {
> +			dev_err(dev, "irq request failed\n ");
> +			return ret;
> +		}
> +
>  		/* enable temperature comparation */
>  		rcar_thermal_common_write(common, ENR, 0x00030303);
> =20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2AVBFJCQXTPSJTFMPEKQG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGt40MACgkQCXcVR3XQvP3J4gD9Gn5apaNWiR5vigMyhQ+/+DWI
MahDH9GqmbmjSHys59IBAKef1zSiP44yQkCgE8xQga5Cias565eS3VmAm++0uNhV
=662b
-----END PGP SIGNATURE-----

------enig2AVBFJCQXTPSJTFMPEKQG--
