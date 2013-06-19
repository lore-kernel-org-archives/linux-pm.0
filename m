From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V6 03/30] thermal: exynos: Remove un-necessary CPU_THERMAL
 dependency
Date: Wed, 19 Jun 2013 14:48:42 -0400
Message-ID: <51C1FD0A.8060107@ti.com>
References: <1371451599-31035-1-git-send-email-amit.daniel@samsung.com> <1371451599-31035-4-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2MFMROPSICTCREHDNVQBW"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371451599-31035-4-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, jonghwa3.lee@samsung.com
List-Id: linux-pm@vger.kernel.org

------enig2MFMROPSICTCREHDNVQBW
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17-06-2013 02:46, Amit Daniel Kachhap wrote:
> This patch removes the dependency on CPU_THERMAL for compiling TMU driv=
er.
> This is useful for cases when only TMU controller needs to be initialis=
ed
> without cpu cooling action.
>=20
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>


Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

Please have a look on my comment on your patch 04. You may want to have
this dependency still on your core part.

> ---
>  drivers/thermal/samsung/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/=
Kconfig
> index 883a8a8..2cf31ad 100644
> --- a/drivers/thermal/samsung/Kconfig
> +++ b/drivers/thermal/samsung/Kconfig
> @@ -1,7 +1,6 @@
>  config EXYNOS_THERMAL
>  	tristate "Temperature sensor on Samsung EXYNOS"
>  	depends on ARCH_HAS_BANDGAP
> -	depends on CPU_THERMAL
>  	help
>  	  If you say yes here you get support for TMU (Thermal Management
>  	  Unit) on SAMSUNG EXYNOS series of SoC. This helps in registering
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2MFMROPSICTCREHDNVQBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHB/QoACgkQCXcVR3XQvP0nKAD/QlFjCDU9UO/27tu0d6Fa+jSZ
uu4v7hsRmWw6WR/D5coA/ilOW0uZmAVybjREUs+pmE9ckosIIKBqamuHn6ervEAp
=/lER
-----END PGP SIGNATURE-----

------enig2MFMROPSICTCREHDNVQBW--
