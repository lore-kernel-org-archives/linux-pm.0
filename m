From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 4/6] Thermal: kirkwood: Remove redundant platform_set_drvdata()
Date: Fri, 3 May 2013 08:50:43 -0400
Message-ID: <5183B2A3.8060106@ti.com>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org> <1367575034-18432-4-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2ARUAKLLBABNNPPUAORCC"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45255 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663Ab3ECMu5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 May 2013 08:50:57 -0400
In-Reply-To: <1367575034-18432-4-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

------enig2ARUAKLLBABNNPPUAORCC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03-05-2013 05:57, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata =3D NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>


Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/kirkwood_thermal.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkw=
ood_thermal.c
> index dfeceaf..b57a45d 100644
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -108,7 +108,6 @@ static int kirkwood_thermal_exit(struct platform_de=
vice *pdev)
>  		platform_get_drvdata(pdev);
> =20
>  	thermal_zone_device_unregister(kirkwood_thermal);
> -	platform_set_drvdata(pdev, NULL);
> =20
>  	return 0;
>  }
>=20



------enig2ARUAKLLBABNNPPUAORCC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGDsqMACgkQCXcVR3XQvP1dYQEApk6GHdHOP3YVFBG5kIQAfm6/
Gc6ZSNc/8n8JLrtlkekBAK8hP7usWCeX0AziKqHMaAHpM9ITM4XoRkBX7b3WLGH7
=agOz
-----END PGP SIGNATURE-----

------enig2ARUAKLLBABNNPPUAORCC--
