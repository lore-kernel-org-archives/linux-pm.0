From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/3] exynos: config: Remove CONFIG_EXYNOS_THERMAL_CORE
 define (exynos_defconfig)
Date: Wed, 28 Jan 2015 01:26:42 -0400
Message-ID: <20150128052640.GE29600@developer.hsd1.ca.comcast.net>
References: <1422458920-14555-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zs/RYxT/hKAHzkfQ"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422458920-14555-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--Zs/RYxT/hKAHzkfQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2015 at 04:28:38PM +0100, Lukasz Majewski wrote:
> After Exynos TMU rework to use device tree for configuration this flag
> can be removed. It is not used anymore.
>=20
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  arch/arm/configs/exynos_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_=
defconfig
> index 3d0c5d6..3691a68 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -88,7 +88,6 @@ CONFIG_HWMON=3Dy
>  CONFIG_SENSORS_LM90=3Dy
>  CONFIG_THERMAL=3Dy
>  CONFIG_EXYNOS_THERMAL=3Dy
> -CONFIG_EXYNOS_THERMAL_CORE=3Dy
>  CONFIG_WATCHDOG=3Dy
>  CONFIG_S3C2410_WATCHDOG=3Dy
>  CONFIG_MFD_CROS_EC=3Dy
> --=20
> 2.0.0.rc2
>=20

--Zs/RYxT/hKAHzkfQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUyHMHAAoJEMLUO4d9pOJWTzgIAIWWQiqNtORH9UnkUwgrxSgW
mo1XxWCyVF+1WA8kUGa9ShSasMzVGX3nHR030CfvDNYyKzJ8ltuaLmCbMuG6HRdP
sPQ9xn9n77Z1+c2mqI9GeaGby4ebIj3rXloliNl2QTfKYp7dW1hDwySzNivvFmq/
+nhgkjvuXtFc/XtGuO9ag7QF+ip0soEITjSb3FNVg7VTmieNR/oJkGKDCuBrzJvo
b0erZy4I+VD7tFaXBdyEZbWVdEqYuA/w8mXWgPopCO24mC34QCtZpV5drPznzD8q
PQcYb2fKEjCXbl/+e6tfICbn4p/hiDu+zrEAKU9q7LV738oXKw6ZpqrkK9ZN1gk=
=/n2q
-----END PGP SIGNATURE-----

--Zs/RYxT/hKAHzkfQ--
