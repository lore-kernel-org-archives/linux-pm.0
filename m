From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: Kconfig: Remove config for not used
 EXYNOS_THERMAL_CORE
Date: Tue, 27 Jan 2015 10:55:00 -0400
Message-ID: <20150127145458.GB29600@developer.hsd1.ca.comcast.net>
References: <1422357239-20316-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422357239-20316-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Paul Bolle <pebolle@tiscali.nl>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2015 at 12:13:59PM +0100, Lukasz Majewski wrote:
> After removing exynos_thermal_common.[c|h] files the CONFIG_EXYNOS_THERMA=
_CORE
> is not needed anymore.
> This patch removes this entry from Kconfig.
>=20
> Reported-by: Paul Bolle <pebolle@tiscali.nl>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>

This patch looks fine to me and I am about to queue it in my fixes tree.
However, you must carry along another patch to remove this entry:
arch/arm/configs/exynos_defconfig:CONFIG_EXYNOS_THERMAL_CORE=3Dy

Can you please post it and ask Kim to queue the above suggested removal
too?

> ---
>  drivers/thermal/samsung/Kconfig | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kc=
onfig
> index c43306e..c8e35c1 100644
> --- a/drivers/thermal/samsung/Kconfig
> +++ b/drivers/thermal/samsung/Kconfig
> @@ -7,12 +7,3 @@ config EXYNOS_THERMAL
>  	  the TMU, reports temperature and handles cooling action if defined.
>  	  This driver uses the Exynos core thermal APIs and TMU configuration
>  	  data from the supported SoCs.
> -
> -config EXYNOS_THERMAL_CORE
> -	bool "Core thermal framework support for EXYNOS SOCs"
> -	depends on EXYNOS_THERMAL
> -	help
> -	  If you say yes here you get support for EXYNOS TMU
> -	  (Thermal Management Unit) common registration/unregistration
> -	  functions to the core thermal layer and also to use the generic
> -	  CPU cooling APIs.
> --=20
> 2.0.0.rc2
>=20

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUx6a1AAoJEMLUO4d9pOJWdswH/2YU8QEjmvFyG0JEeeVk2Jp4
9KOmmGrv0WazbrGa2ogrQymJOViT5DDeHnm4AnATAuLQHR/9oGui1QUwKpqH28mx
gu6CJwcEdfOI3Rqup7E4xsDwGcp8eQKTk5VRTkC0RqAbuC8gjf5jDRJmJbWPbhtF
BG3ACCZm8FsqhUACtThYIm/e1TSKFonDjNBFaXV0NA9E3rg1ZhwTlWQ4rsk8dVK/
1okVGJo8svehKNX+3P5f9X37GH0IprP+gcqe+bCrx0mngE97i7H4yDmBpsoHa12O
xiB0htXwHyQxCr1dIJ8UGa1AAqghk8iocioz0EtgJ91ll5WZgnIhvkhqcawxZvs=
=fKi3
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
