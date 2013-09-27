From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v2] thermal: Kconfig: cosmetic fixes
Date: Fri, 27 Sep 2013 17:51:59 -0400
Message-ID: <5245FDFF.6070507@ti.com>
References: <1380306033-20325-1-git-send-email-luka@openwrt.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SLRa4w6pE1eLBQECdFCXxX2lewJOmO7j8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59009 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab3I0Vwy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 17:52:54 -0400
In-Reply-To: <1380306033-20325-1-git-send-email-luka@openwrt.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Luka Perkov <luka@openwrt.org>
Cc: linux-pm@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, eduardo.valentin@ti.com

--SLRa4w6pE1eLBQECdFCXxX2lewJOmO7j8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 27-09-2013 14:20, Luka Perkov wrote:
> Fix typo, finish sentence and add missing dots.
>=20
> Signed-off-by: Luka Perkov <luka@openwrt.org>
> CC: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> v1 -> v2:
> * address Randy's comment about unfinished sentence
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index dbfc390..3910b09 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -56,7 +56,7 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
>  	select THERMAL_GOV_USER_SPACE
>  	help
>  	  Select this if you want to let the user space manage the
> -	  lpatform thermals.
> +	  platform thermals.
> =20
>  endchoice
> =20
> @@ -69,6 +69,7 @@ config THERMAL_GOV_STEP_WISE
>  	bool "Step_wise thermal governor"
>  	help
>  	  Enable this to manage platform thermals using a simple linear
> +	  governor.
> =20
>  config THERMAL_GOV_USER_SPACE
>  	bool "User_space thermal governor"
> @@ -117,14 +118,14 @@ config SPEAR_THERMAL
>  	depends on OF
>  	help
>  	  Enable this to plug the SPEAr thermal sensor driver into the Linux
> -	  thermal framework
> +	  thermal framework.
> =20
>  config RCAR_THERMAL
>  	tristate "Renesas R-Car thermal driver"
>  	depends on ARCH_SHMOBILE
>  	help
>  	  Enable this to plug the R-Car thermal sensor driver into the Linux
> -	  thermal framework
> +	  thermal framework.
> =20
>  config KIRKWOOD_THERMAL
>  	tristate "Temperature sensor on Marvell Kirkwood SoCs"
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--SLRa4w6pE1eLBQECdFCXxX2lewJOmO7j8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlJF/ggACgkQCXcVR3XQvP3SawEAhW9H6xDae1GyJ9cNKDZsPg3s
CGMpGBFWBIvAN3n78aQA/0b901wTyH/hvRPoHwSZMX450SzKClXli+078+ktGyKE
=HGxq
-----END PGP SIGNATURE-----

--SLRa4w6pE1eLBQECdFCXxX2lewJOmO7j8--
