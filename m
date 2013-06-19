From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V6 02/30] thermal: exynos: Use ARCH_HAS_BANDGAP config
 to know the supported soc's
Date: Wed, 19 Jun 2013 14:46:51 -0400
Message-ID: <51C1FC9B.70102@ti.com>
References: <1371451599-31035-1-git-send-email-amit.daniel@samsung.com> <1371451599-31035-3-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2BXHJRQBIOTCHHNAHHKSF"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371451599-31035-3-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, jonghwa3.lee@samsung.com
List-Id: linux-pm@vger.kernel.org

------enig2BXHJRQBIOTCHHNAHHKSF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17-06-2013 02:46, Amit Daniel Kachhap wrote:
> This patch uses the recently added config sybmol ARCH_HAS_BANDGAP to en=
able
> the TMU driver. This will allow adding support for new soc easily as no=
w it
> is the platform responsibility to enable this config symbol for a parti=
cular
> soc.
>=20
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>


Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/samsung/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/=
Kconfig
> index 2d3d9dc..883a8a8 100644
> --- a/drivers/thermal/samsung/Kconfig
> +++ b/drivers/thermal/samsung/Kconfig
> @@ -1,6 +1,6 @@
>  config EXYNOS_THERMAL
>  	tristate "Temperature sensor on Samsung EXYNOS"
> -	depends on (ARCH_EXYNOS4 || ARCH_EXYNOS5)
> +	depends on ARCH_HAS_BANDGAP
>  	depends on CPU_THERMAL
>  	help
>  	  If you say yes here you get support for TMU (Thermal Management
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2BXHJRQBIOTCHHNAHHKSF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHB/JsACgkQCXcVR3XQvP1zNgEA3LZ0yfkxN8dVgec3SGoVcljV
VdJB6HV+DHmyRgnVggUBAMBO+wSw3AfKem/5o+j9UnY029mMt/3n4HsGcimUUTGh
=mfLr
-----END PGP SIGNATURE-----

------enig2BXHJRQBIOTCHHNAHHKSF--
