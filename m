From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V6 30/30] arm: exynos: enable ARCH_HAS_BANDGAP
Date: Wed, 19 Jun 2013 14:47:27 -0400
Message-ID: <51C1FCBF.8050000@ti.com>
References: <1371451599-31035-1-git-send-email-amit.daniel@samsung.com> <1371451599-31035-31-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2PMRRTQFSLFDMUUKXFRKJ"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1371451599-31035-31-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, jonghwa3.lee@samsung.com
List-Id: linux-pm@vger.kernel.org

------enig2PMRRTQFSLFDMUUKXFRKJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17-06-2013 02:46, Amit Daniel Kachhap wrote:
> This patch enables ARCH_HAS_BANDGAP config for exynos4210, 4212, 4412, =
5250
> and 5440 SOC. This config symbol is recently added to allow the platfor=
ms
> to enable bandgap based temperature sensor.
>=20
> Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  arch/arm/mach-exynos/Kconfig |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfi=
g
> index d19edff..d3cb5c7 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -33,6 +33,7 @@ config CPU_EXYNOS4210
>  	bool "SAMSUNG EXYNOS4210"
>  	default y
>  	depends on ARCH_EXYNOS4
> +	select ARCH_HAS_BANDGAP
>  	select ARM_CPU_SUSPEND if PM
>  	select PM_GENERIC_DOMAINS
>  	select S5P_PM if PM
> @@ -45,6 +46,7 @@ config SOC_EXYNOS4212
>  	bool "SAMSUNG EXYNOS4212"
>  	default y
>  	depends on ARCH_EXYNOS4
> +	select ARCH_HAS_BANDGAP
>  	select S5P_PM if PM
>  	select S5P_SLEEP if PM
>  	select SAMSUNG_DMADEV
> @@ -55,6 +57,7 @@ config SOC_EXYNOS4412
>  	bool "SAMSUNG EXYNOS4412"
>  	default y
>  	depends on ARCH_EXYNOS4
> +	select ARCH_HAS_BANDGAP
>  	select SAMSUNG_DMADEV
>  	help
>  	  Enable EXYNOS4412 SoC support
> @@ -63,6 +66,7 @@ config SOC_EXYNOS5250
>  	bool "SAMSUNG EXYNOS5250"
>  	default y
>  	depends on ARCH_EXYNOS5
> +	select ARCH_HAS_BANDGAP
>  	select PM_GENERIC_DOMAINS if PM
>  	select S5P_PM if PM
>  	select S5P_SLEEP if PM
> @@ -76,6 +80,7 @@ config SOC_EXYNOS5440
>  	default y
>  	depends on ARCH_EXYNOS5
>  	select ARCH_HAS_OPP
> +	select ARCH_HAS_BANDGAP
>  	select ARM_ARCH_TIMER
>  	select AUTO_ZRELADDR
>  	select PINCTRL
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2PMRRTQFSLFDMUUKXFRKJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHB/L8ACgkQCXcVR3XQvP0o5gEAsYg2ao0k0rQE6G1KvG1gxLpi
XL05mBistpZ8mguypKoA/RuuDcPGsHcCU5yOAG/nv1cn4+5wUXFVBnszQ9hXapPg
=p9WT
-----END PGP SIGNATURE-----

------enig2PMRRTQFSLFDMUUKXFRKJ--
