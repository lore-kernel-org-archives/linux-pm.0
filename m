From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 2/6] Thermal: dove_thermal: Remove redundant platform_set_drvdata()
Date: Fri, 3 May 2013 08:47:27 -0400
Message-ID: <5183B1DF.5060202@ti.com>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org> <1367575034-18432-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2JJRWNFXEJXMNKUPQTEEQ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60796 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab3ECMrl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 08:47:41 -0400
In-Reply-To: <1367575034-18432-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, Andrew Lunn <andrew@lunn.ch>

------enig2JJRWNFXEJXMNKUPQTEEQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03-05-2013 05:57, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata =3D NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Andrew Lunn <andrew@lunn.ch>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/dove_thermal.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_ther=
mal.c
> index 4b15a5f..900479e 100644
> --- a/drivers/thermal/dove_thermal.c
> +++ b/drivers/thermal/dove_thermal.c
> @@ -182,7 +182,6 @@ static int dove_thermal_exit(struct platform_device=
 *pdev)
>  		platform_get_drvdata(pdev);
> =20
>  	thermal_zone_device_unregister(dove_thermal);
> -	platform_set_drvdata(pdev, NULL);
> =20
>  	return 0;
>  }
>=20



------enig2JJRWNFXEJXMNKUPQTEEQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGDsd8ACgkQCXcVR3XQvP2uCgD+KmgvyCkAFnIrFjpBHLaI2nIF
FYL4c3IYPwPCLtWrXi0A/2kNvTq5AuuHDEuoX2axBGR+nkET6p9zNjkHzo7sfCBL
=pmac
-----END PGP SIGNATURE-----

------enig2JJRWNFXEJXMNKUPQTEEQ--
