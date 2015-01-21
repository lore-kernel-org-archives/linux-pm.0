From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 18/18] thermal: exynos: Remove not needed
 exynos_tmu_init_data declarations from exynos_tmu.h
Date: Tue, 20 Jan 2015 23:30:35 -0400
Message-ID: <20150121033034.GC22176@developer.hsd1.ca.comcast.net>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-19-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60610 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbbAUDpc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jan 2015 22:45:32 -0500
Content-Disposition: inline
In-Reply-To: <1421666462-7606-19-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 12:21:02PM +0100, Lukasz Majewski wrote:
> After switching to device tree based configuration those declarations are
> not needed anymore.
>=20
> Reported-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
> Changes for v5:
> - New patch
> ---
>  drivers/thermal/samsung/exynos_tmu.h | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsu=
ng/exynos_tmu.h
> index d876d4c..9f9b1b8 100644
> --- a/drivers/thermal/samsung/exynos_tmu.h
> +++ b/drivers/thermal/samsung/exynos_tmu.h
> @@ -71,12 +71,4 @@ struct exynos_tmu_platform_data {
>  	u32 cal_mode;
>  };
> =20
> -extern struct exynos_tmu_init_data const exynos3250_default_tmu_data;
> -extern struct exynos_tmu_init_data const exynos4210_default_tmu_data;
> -extern struct exynos_tmu_init_data const exynos4412_default_tmu_data;
> -extern struct exynos_tmu_init_data const exynos5250_default_tmu_data;
> -extern struct exynos_tmu_init_data const exynos5260_default_tmu_data;
> -extern struct exynos_tmu_init_data const exynos5420_default_tmu_data;
> -extern struct exynos_tmu_init_data const exynos5440_default_tmu_data;

Please merge this patch to the one that removes these symbols from
kernel.

> -
>  #endif /* _EXYNOS_TMU_H */
> --=20
> 2.0.0.rc2
>=20

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUvx1PAAoJEMLUO4d9pOJWDXkH/25HNkZrWIumb03VrkrI7JT3
w1rZBFzTdXoAKnV+BfMYTmHIzDJE8ItShJz2pknf1wSUdCsFCIEpkQH7wX7S0OaL
Ju4KYTilk6CfkjFGNoj8CWbBfyZAvan/X/crkRTI7+9j5JEwI8M3g2lMMV1QLkn/
2adtebWEJahB1SfR2HkooAgOL4FTbhf4dah4+J1x4ogP00CBqv92q99OQouGwW+f
URylgdzMtesaypjsZMMD3oDPAThXOprYhEYlZ+/FFBuklLS6G/lUx8TJ6cVrkN5O
IGpt0M8cYSH5QDDmi98aQe0pS9BOWl4Te1/wRaJ2UXxcWuOz9+OF0JPYasmezz4=
=qPXI
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
