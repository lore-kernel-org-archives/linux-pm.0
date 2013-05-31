From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V4 03/30] thermal: exynos: Remove CPU_THERMAL dependency
 for using TMU driver
Date: Fri, 31 May 2013 11:13:10 -0400
Message-ID: <51A8BE06.70009@ti.com>
References: <1368525540-15034-1-git-send-email-amit.daniel@samsung.com> <1368525540-15034-4-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2NXLPVKHLHSUDKEPTIENI"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1368525540-15034-4-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

------enig2NXLPVKHLHSUDKEPTIENI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14-05-2013 05:58, Amit Daniel Kachhap wrote:
> This patch removes the dependency on CPU_THERMAL for compiling TMU driv=
er.
> This is useful for cases when only TMU controller needs to be initialis=
ed
> without cpu cooling action.


Agreed with your intention. I just do not know if it makes sense to make
this change at this point. Maybe after you have split the code?

The above concern is simply from a non-functional perspective. If you do
this at this point of your series, your driver may have compilation
issues at this specific commit, in case your config does not have
CONFIG_CPU_THERMAL.

I recommend you moving this patch further in your series, to a place
where you have isolated the code that depends on CPU_THERMAL.

>=20
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/thermal/samsung/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/=
Kconfig
> index 145a55d..b5ab971 100644
> --- a/drivers/thermal/samsung/Kconfig
> +++ b/drivers/thermal/samsung/Kconfig
> @@ -4,7 +4,6 @@ config ARCH_HAS_TMU
>  config EXYNOS_THERMAL
>  	tristate "Temperature sensor on Samsung EXYNOS"
>  	depends on ARCH_HAS_TMU
> -	depends on CPU_THERMAL
>  	help
>  	  If you say yes here you get support for TMU (Thermal Management
>  	  Unit) on SAMSUNG EXYNOS series of SoC. This helps in registering
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2NXLPVKHLHSUDKEPTIENI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGovgYACgkQCXcVR3XQvP2y3AEApjG7CdQf1WO7FgGuqyKOIjT0
2PfZr6UuS5LMAxzo6uYBALx1GGC+eKxSTR2we62Fe3rPXKUtPnIYpVs6XUAB7TeL
=msjL
-----END PGP SIGNATURE-----

------enig2NXLPVKHLHSUDKEPTIENI--
