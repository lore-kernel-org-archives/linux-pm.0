From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/2] thermal: exynos: Fix wrong control of power down
 detection mode for Exynos7
Date: Tue, 24 Feb 2015 14:53:34 -0400
Message-ID: <20150224185333.GF3448@developer.amazonguestwifi.org>
References: <1424753815-15113-1-git-send-email-cw00.choi@samsung.com>
 <1424753815-15113-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vKFfOv5t3oGVpiF+"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:46262 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbbBXSxk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Feb 2015 13:53:40 -0500
Content-Disposition: inline
In-Reply-To: <1424753815-15113-2-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: rui.zhang@intel.com, kgene@kernel.org, b.zolnierkie@samsung.com, amit.daniel@samsung.com, l.majewski@samsung.com, a.kesavan@samsung.com, inki.dae@samsung.com, kyungmin.park@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org


--vKFfOv5t3oGVpiF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2015 at 01:56:54PM +0900, Chanwoo Choi wrote:
> This patch fixes the wrong control of PD_DET_EN (power down detection mod=
e)
> for Exynos7 because exynos7_tmu_control() always enables the power down d=
etection
> mode regardless 'on' parameter.
>=20
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Lukasz,

Any objections to this code?

BR,

Eduardo Valentin

> ---
>  drivers/thermal/samsung/exynos_tmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsu=
ng/exynos_tmu.c
> index 933cd80..a60f527 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -682,6 +682,7 @@ static void exynos7_tmu_control(struct platform_devic=
e *pdev, bool on)
> =20
>  	if (on) {
>  		con |=3D (1 << EXYNOS_TMU_CORE_EN_SHIFT);
> +		con |=3D (1 << EXYNOS7_PD_DET_EN_SHIFT);
>  		interrupt_en =3D
>  			(of_thermal_is_trip_valid(tz, 7)
>  			<< EXYNOS7_TMU_INTEN_RISE7_SHIFT) |
> @@ -704,9 +705,9 @@ static void exynos7_tmu_control(struct platform_devic=
e *pdev, bool on)
>  			interrupt_en << EXYNOS_TMU_INTEN_FALL0_SHIFT;
>  	} else {
>  		con &=3D ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
> +		con &=3D ~(1 << EXYNOS7_PD_DET_EN_SHIFT);
>  		interrupt_en =3D 0; /* Disable all interrupts */
>  	}
> -	con |=3D 1 << EXYNOS7_PD_DET_EN_SHIFT;
> =20
>  	writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
>  	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
> --=20
> 1.8.5.5
>=20

--vKFfOv5t3oGVpiF+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7MikAAoJEMLUO4d9pOJWt9oH/iJ+HnnPQOIbdOvEqS8cGE4Y
x9JTozSP5rStoj0RcMHbZRE5ErvURbwKEestod5q/AS/qBz6nC9MDB7WniSB7wRp
I7H8u1PWNNuiuNYyiltNiX7T+8UZ1aJAo/HVYQ+k/GtBhIt0+mLCXuCdxf/CBC8M
gMJfGKrKAC0c/raY6YQX2GrygD8PU2JM22Oke/9iwmQ8tO5xiW3rvQ1u00LXuYkX
wPmezhVXMUClW/qV/FtDl29arD3Ns2RBKQaDcFcb807R10u1j9EE4dNzIZBqrE/o
SwxuwrKrcpTxT9U6F98be9p6Gw7fsKjrx2ivrm16LCDfupXKrNtPEhjbEetfYhk=
=Ickz
-----END PGP SIGNATURE-----

--vKFfOv5t3oGVpiF+--
