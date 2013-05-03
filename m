From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 3/6] Thermal: exynos: Remove redundant platform_set_drvdata()
Date: Fri, 3 May 2013 08:49:58 -0400
Message-ID: <5183B276.2020605@ti.com>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org> <1367575034-18432-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2OBWKBICHXDHLRRCHFLLB"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35455 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426Ab3ECMuJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 May 2013 08:50:09 -0400
In-Reply-To: <1367575034-18432-3-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org

------enig2OBWKBICHXDHLRRCHFLLB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03-05-2013 05:57, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata =3D NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/exynos_thermal.c |    3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_=
thermal.c
> index d20ce9e..992ae6e 100644
> --- a/drivers/thermal/exynos_thermal.c
> +++ b/drivers/thermal/exynos_thermal.c
> @@ -1001,7 +1001,6 @@ static int exynos_tmu_probe(struct platform_devic=
e *pdev)
> =20
>  	return 0;
>  err_clk:
> -	platform_set_drvdata(pdev, NULL);
>  	clk_unprepare(data->clk);
>  	return ret;
>  }
> @@ -1016,8 +1015,6 @@ static int exynos_tmu_remove(struct platform_devi=
ce *pdev)
> =20
>  	clk_unprepare(data->clk);
> =20
> -	platform_set_drvdata(pdev, NULL);
> -
>  	return 0;
>  }
> =20
>=20



------enig2OBWKBICHXDHLRRCHFLLB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGDsnYACgkQCXcVR3XQvP3sXwD/bYQh5c+/DzpXuVh6VEw7AnrL
Fg/W3pLJKQzYCtz3mSoA/RNLZD7jR4sJ3nF3ugwlil4crgPXKTz2X+r4oZEkrfuH
=OSSP
-----END PGP SIGNATURE-----

------enig2OBWKBICHXDHLRRCHFLLB--
