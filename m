From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 5/6] Thermal: rcar: Remove redundant platform_set_drvdata()
Date: Fri, 3 May 2013 08:51:08 -0400
Message-ID: <5183B2BC.3080808@ti.com>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org> <1367575034-18432-5-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2JNPDARGFPTRCVEXUNSGI"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45268 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426Ab3ECMvV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 May 2013 08:51:21 -0400
In-Reply-To: <1367575034-18432-5-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

------enig2JNPDARGFPTRCVEXUNSGI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03-05-2013 05:57, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata =3D NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>



Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/rcar_thermal.c |    2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_ther=
mal.c
> index 8d7edd4..63c7c13 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -487,8 +487,6 @@ static int rcar_thermal_remove(struct platform_devi=
ce *pdev)
>  			rcar_thermal_irq_disable(priv);
>  	}
> =20
> -	platform_set_drvdata(pdev, NULL);
> -
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
> =20
>=20



------enig2JNPDARGFPTRCVEXUNSGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGDsrwACgkQCXcVR3XQvP2HYgEA1ER2iyYw/xMoXQ9haWNLynk+
klpfLQ9guzbIrjsY6bIBAMt+ljefYlb5c4YAb8GL7dlVApvg7tgfzDYfl10Gn6jw
=Ehe7
-----END PGP SIGNATURE-----

------enig2JNPDARGFPTRCVEXUNSGI--
