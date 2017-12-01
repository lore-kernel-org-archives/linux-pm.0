From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 2/2] power: supply: ab8500_charger: Bail out in case of
 error in 'ab8500_charger_init_hw_registers()'
Date: Fri, 1 Dec 2017 16:30:08 +0100
Message-ID: <20171201153008.h7rqw3yvmdllgqgs@earth>
References: <20171122203120.13467-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g7usawffij4bmtvc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171122203120.13467-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--g7usawffij4bmtvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 22, 2017 at 09:31:20PM +0100, Christophe JAILLET wrote:
> If an error occurs when we enable the backup battery charging, we should
> go through the error handling path directly.
>=20
> Before commit db43e6c473b5 ("ab8500-bm: Add usb power path support") this
> was the case, but this commit has added some code between the last test a=
nd
> the 'out' label.
> So, in case of error, this added code is executed and the error may be
> silently ignored.
>=20
> Fix it by adding the missing 'goto out', as done in all other error
> handling paths.
>=20
> Fixes: db43e6c473b5 ("ab8500-bm: Add usb power path support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_charger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index 1cdbe7a0738d..5a76c6d343de 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -3221,8 +3221,10 @@ static int ab8500_charger_init_hw_registers(struct=
 ab8500_charger *di)
>  	ret =3D abx500_mask_and_set_register_interruptible(di->dev,
>  		AB8500_RTC, AB8500_RTC_CTRL_REG,
>  		RTC_BUP_CH_ENA, RTC_BUP_CH_ENA);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(di->dev, "%s mask and set failed\n", __func__);
> +		goto out;
> +	}
> =20
>  	if (is_ab8540(di->parent)) {
>  		ret =3D abx500_mask_and_set_register_interruptible(di->dev,
> --=20
> 2.14.1
>=20

--g7usawffij4bmtvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlohdYAACgkQ2O7X88g7
+povOQ//YoAApAYZV8Z+0g5fz4kUY01PvU42my4SOdkw5tsi7Kv6p3XVQ+sH61PA
zBZkp9kfPfYPd4tQWmmJfVSHJi6VY18wFl3lqjfgajbiBbhX27wI/kMUy547f6bs
IuFCX9A/baUFAaL7Ue8lowus55MtqQdfEpERn8ON7WNztQAQ/AG4oeNDtkw3cHEs
9la1l1t6bhDOnBst3yevbW1FgJ+Da8Se0DqurEVwOrl8MaEe4h1eG0SFBMYiCf8P
/OqEJ/pGe2ca/ZZZVhbW2lqpAo8F6K8hf1c589WRTBa7OM2aEoaO9fCnnHFHBeNy
04oPiSpOP3rI/RoAymFmwQ2dpZ+iBtprc2JZaW8b8sYV3vt8GVVsIidsFSc7Pwv0
D0WvClrnahV3tc1X8jyABEqHOeKn5SCRzbAE8F9vOtiCktChqFu6U7jjxhE6Z3dN
sAbs0wGdkB4qtbss5Pfv14Llk26GmoddanFawVQHJeGhVFuXhkQ7HtWzGB1l/Zu8
07ec2boJlcSjnZTYofKxP0k+RMWZnIKLb/KN1tcxwx0juHchBS3JqR0+4ygJUv0p
NrfL30aXK/ggfo5oZo4IahSmwdNCk7F6ell9mSOvP5e8uj6ajHZ5QiNDlPgmTkwY
/ExIKlAskVtCfjhnnWgr+4DI2jlrn+8xp00tJch8D0RXQM/aubo=
=Ooel
-----END PGP SIGNATURE-----

--g7usawffij4bmtvc--
