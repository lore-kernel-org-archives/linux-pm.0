From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 2/2] power/reset: at91-reset: remove leftover
 platform_device_id
Date: Wed, 18 Jan 2017 05:48:56 +0100
Message-ID: <20170118044856.iszgtnwjuzdtl2i6@earth>
References: <20170117230738.28257-1-alexandre.belloni@free-electrons.com>
 <20170117230738.28257-2-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pdb2tm3a7y7ljc7r"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170117230738.28257-2-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--pdb2tm3a7y7ljc7r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Wed, Jan 18, 2017 at 12:07:38AM +0100, Alexandre Belloni wrote:
> commit eacd8d09db7f ("power/reset: at91-reset: remove useless
> at91_reset_platform_probe()") removed non DT probe support but forgot to
> remove the now useless id_table. Do that now.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/power/reset/at91-reset.c | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-=
reset.c
> index bb2588f0a4c7..b99769f8ab15 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -248,20 +248,12 @@ static int __exit at91_reset_remove(struct platform=
_device *pdev)
>  	return 0;
>  }
> =20
> -static const struct platform_device_id at91_reset_plat_match[] =3D {
> -	{ "at91-sam9260-reset", (unsigned long)at91sam9260_restart },
> -	{ "at91-sam9g45-reset", (unsigned long)at91sam9g45_restart },
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(platform, at91_reset_plat_match);
> -
>  static struct platform_driver at91_reset_driver =3D {
>  	.remove =3D __exit_p(at91_reset_remove),
>  	.driver =3D {
>  		.name =3D "at91-reset",
>  		.of_match_table =3D at91_reset_of_match,
>  	},
> -	.id_table =3D at91_reset_plat_match,
>  };
>  module_platform_driver_probe(at91_reset_driver, at91_reset_probe);

Thanks, also queued into power-supply's for-next branch.

-- Sebastian

--pdb2tm3a7y7ljc7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh+87gACgkQ2O7X88g7
+pqawA//dJR0AamuxWrtQk0w429V/cUQsceItcg0bhMdEiF6+io4fQDbheEKxJuz
NmJ4+J7Xf267b77Olzpoj4n3QdUZ2s/5ji2gwc6Opi34O/NjmUFxM/BzedyWlZML
hxeCLfjnffj2/BzS5W1iuJTHhczesWWr3Zkz2/NPPCQ1K7MAixUlu6ogHJXDfm1P
XlUbGogfeuLAy/+xLg22c/KKLluI7+XyYFyK8n4yTQltMk5LZK1BSJQsuueC7Xm5
zA8D2IEUu/3vdZh68h7nwpy7yK6VmDCOuvAYY5GqqVzoi2utxV3mKFok4Tl4fQO9
Ekn6ETEJ6CbhAD/g2yW0lN3VOWKK6F+sdeWSK5GCOsths0AKfNXFMVH4tJ5dppRk
NvZvjS0WUTHT2Fl3yxyKGCao7ziHFaKVJ1CVZjOfuRsxJOwOByaglFg3q85KVzHv
LP86xi8qMZQ/Jsa6C0o64KQaxVF3SUyPZDb4RPKrH/8LKZ5pEClIUuWFTIt7zWZa
WfpxGnDtTOD2sgPP0vsp1ig7hOe9iMI9NKErdKnKrnv34UCGQmMVXgXHjE7L2H58
aug4FvS3kqX7alekRIR6SvTqMeKi4bXPc+NPJcNCcFQORTItQzqwrOmprurt6P+0
DYPy2FDp3sOKOwjKYB52lorTXiw4roB1MxyuBz/vdCy0ecfHwIk=
=KOUz
-----END PGP SIGNATURE-----

--pdb2tm3a7y7ljc7r--
