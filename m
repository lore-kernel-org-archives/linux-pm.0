From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 4/4] power: reset: at91-poweroff: remove
 at91_ramc_of_match
Date: Wed, 5 Dec 2018 23:37:30 +0100
Message-ID: <20181205223730.t6g7lssazxb3zn5y@earth.universe>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-5-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l2nol2svzs2s2rpq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1541416443-4321-5-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--l2nol2svzs2s2rpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 05, 2018 at 11:14:31AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> Remove at91_ramc_of_match[] since it is not used anywhere in this code.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/at91-poweroff.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at=
91-poweroff.c
> index e75d8f0f0526..43b4cccb7d0c 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -232,11 +232,6 @@ static int __exit at91_poweroff_remove(struct platfo=
rm_device *pdev)
>  	return 0;
>  }
> =20
> -static const struct of_device_id at91_ramc_of_match[] =3D {
> -	{ .compatible =3D "atmel,sama5d3-ddramc", },
> -	{ /* sentinel */ }
> -};
> -
>  static const struct of_device_id at91_poweroff_of_match[] =3D {
>  	{ .compatible =3D "atmel,at91sam9260-shdwc", },
>  	{ .compatible =3D "atmel,at91sam9rl-shdwc", },
> --=20
> 2.7.4
>=20

--l2nol2svzs2s2rpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIUyoACgkQ2O7X88g7
+pqHKQ/9Ge+YB+XoMROdq10+kL7QzL8MWhXFtfXS8PE6tOug4Zw+vr5RnxzjMe6c
8+DAoomnpn92ULenGXDR4S5rdn5tEvPro40D7XchP1I0V9yzLVIPPhtFMx3/VYi+
/v86epgT5ZiZzPDJQMsq080PXTDzU2evTdRdgSgY5tDNFyh+OuTNMTgkGWtFYy3x
mSDWPaOIz1DR5WXeh1Ct94kZ98HeS3+NbJNopi5iztiGK8i10T4JERuhjlDT/WQ4
H9qt8O6BN8dyMCcKTSSZPaAKeZfNL+LZGrECCDkvtwuCr/tuW3sTCag9wWLS+GOV
ipyOexz3Ev0qe346X87yUnJI/xlgRnIFltVuLujUy4otb594/K/TQa7XsvtPcEtm
HA8ObDoDUtbwqry2ABC1Z3IdulNtyAnU4IbJH0OxAn9auv/Fq6NaDGKUtq0bpbjS
LTU8aJStiT5hZkJLqZxp8nfkkdamMT7z6ltxowzNFytkjYsxHl32+xYggNL893Up
tsqiRHn1+s+KgjUjBFYuykkI7ryHkm6UTsZ/W7f4quxvQ1MtC4LwhNoe2Dg51f4O
vg+SQeE/S4GNwM6tIYpfN+5qRwxsVk0vjtufQsvkJkcXEj6bOwt/WaH/IpouMDt/
yU1pRKYM1GEJRP2Nw37pbLn8RF5LM6E0mAt3nc1NsbVLprUP3GM=
=goHB
-----END PGP SIGNATURE-----

--l2nol2svzs2s2rpq--
