From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/3] thermal: exynos: Fix typos in Kconfig
Date: Thu, 29 Aug 2013 08:17:50 -0400
Message-ID: <521F3BEE.5020608@ti.com>
References: <1376893723-22138-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g3sprqBORocDV3kpQhqc4e6VMmfo4aKa4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52140 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab3H2MSB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Aug 2013 08:18:01 -0400
In-Reply-To: <1376893723-22138-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, jonghwa3.lee@samsung.com, eduardo.valentin@ti.com, rui.zhang@intel.com, amit.daniel@samsung.com, patches@linaro.org

--g3sprqBORocDV3kpQhqc4e6VMmfo4aKa4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19-08-2013 02:28, Sachin Kamat wrote:
> Fixes some trivial typos.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>


Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
> This series is based on next branch of below tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
>=20
> This is tested on Exynos4210 and 5250 based boards.
> ---
>  drivers/thermal/samsung/Kconfig |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/=
Kconfig
> index b653f15..92492e4 100644
> --- a/drivers/thermal/samsung/Kconfig
> +++ b/drivers/thermal/samsung/Kconfig
> @@ -3,16 +3,16 @@ config EXYNOS_THERMAL
>  	depends on ARCH_HAS_BANDGAP
>  	help
>  	  If you say yes here you get support for the TMU (Thermal Management=

> -	  Unit) driver for SAMSUNG EXYNOS series of soc. This driver initiali=
ses
> +	  Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initial=
ises
>  	  the TMU, reports temperature and handles cooling action if defined.=

> -	  This driver uses the exynos core thermal API's and TMU configuratio=
n
> -	  data from the supported soc's.
> +	  This driver uses the Exynos core thermal APIs and TMU configuration=

> +	  data from the supported SoCs.
> =20
>  config EXYNOS_THERMAL_CORE
> -	bool "Core thermal framework support for EXYNOS SOC's"
> +	bool "Core thermal framework support for EXYNOS SOCs"
>  	depends on EXYNOS_THERMAL
>  	help
>  	  If you say yes here you get support for EXYNOS TMU
>  	  (Thermal Management Unit) common registration/unregistration
>  	  functions to the core thermal layer and also to use the generic
> -	  cpu cooling API's.
> +	  CPU cooling APIs.
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--g3sprqBORocDV3kpQhqc4e6VMmfo4aKa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlIfO+4ACgkQCXcVR3XQvP0X7gEAzumTneMvZ8JpvA8Sw3g5hIuv
4sImOIYZQBR8RMactJMBAMnVclkJ7iH3wYSQZUAMCdn4vx1uKHFkO1Ee3emvL2NW
=S9tT
-----END PGP SIGNATURE-----

--g3sprqBORocDV3kpQhqc4e6VMmfo4aKa4--
