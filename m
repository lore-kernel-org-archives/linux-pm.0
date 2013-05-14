From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] thermal: rcar: Fix typo in probe information message
Date: Tue, 14 May 2013 19:42:15 -0400
Message-ID: <5192CBD7.50200@ti.com>
References: <1368572432-3943-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2TJVKGVBIDUSBVNOHCHIH"
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1368572432-3943-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, eduardo.valentin@ti.com
List-Id: linux-pm@vger.kernel.org

------enig2TJVKGVBIDUSBVNOHCHIH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rui,

On 14-05-2013 19:00, Laurent Pinchart wrote:
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.=
com>
> ---

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

>  drivers/thermal/rcar_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_ther=
mal.c
> index 28f0919..6138949 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -452,7 +452,7 @@ static int rcar_thermal_probe(struct platform_devic=
e *pdev)
> =20
>  	platform_set_drvdata(pdev, common);
> =20
> -	dev_info(dev, "%d sensor proved\n", i);
> +	dev_info(dev, "%d sensor probed\n", i);
> =20
>  	return 0;
> =20
>=20



------enig2TJVKGVBIDUSBVNOHCHIH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGSy9cACgkQCXcVR3XQvP2MUQD/S4Kv1OmSMHmWEilSVzpZX/kd
EITfX489U4p2OoYEoigBAKfNjbI/oQmNiZALzGqYhagMPZ1xEx4xjyOXBTE4jfZP
=ukWT
-----END PGP SIGNATURE-----

------enig2TJVKGVBIDUSBVNOHCHIH--
