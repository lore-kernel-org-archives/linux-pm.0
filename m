From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 3/3] thermal: exynos: Clean up non-DT remnants
Date: Thu, 29 Aug 2013 08:17:00 -0400
Message-ID: <521F3BBC.5030504@ti.com>
References: <1376893723-22138-1-git-send-email-sachin.kamat@linaro.org> <1376893723-22138-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="B5jFIgrKV0bdCNF5A656ILbq7HegQ9Ndw"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43920 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412Ab3H2MRM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 29 Aug 2013 08:17:12 -0400
In-Reply-To: <1376893723-22138-3-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, jonghwa3.lee@samsung.com, eduardo.valentin@ti.com, rui.zhang@intel.com, amit.daniel@samsung.com, patches@linaro.org

--B5jFIgrKV0bdCNF5A656ILbq7HegQ9Ndw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19-08-2013 02:28, Sachin Kamat wrote:
> Commit 1cd1ecb6 ("thermal: exynos: Remove non DT based support")
> cleaned up some non-DT code. However, there were few more things
> needed for complete cleanup to make this driver DT only.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  drivers/thermal/samsung/Kconfig      |    2 +-
>  drivers/thermal/samsung/exynos_tmu.c |   30 ++++++++++++--------------=
----
>  2 files changed, 13 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/=
Kconfig
> index 92492e4..f760389 100644
> --- a/drivers/thermal/samsung/Kconfig
> +++ b/drivers/thermal/samsung/Kconfig
> @@ -1,6 +1,6 @@
>  config EXYNOS_THERMAL
>  	tristate "Exynos thermal management unit driver"
> -	depends on ARCH_HAS_BANDGAP
> +	depends on ARCH_HAS_BANDGAP && OF
>  	help
>  	  If you say yes here you get support for the TMU (Thermal Management=

>  	  Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initial=
ises
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/sam=
sung/exynos_tmu.c
> index a033dbb..b43afda 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -481,7 +481,6 @@ static irqreturn_t exynos_tmu_irq(int irq, void *id=
)
>  	return IRQ_HANDLED;
>  }
> =20
> -#ifdef CONFIG_OF
>  static const struct of_device_id exynos_tmu_match[] =3D {
>  	{
>  		.compatible =3D "samsung,exynos4210-tmu",
> @@ -502,27 +501,22 @@ static const struct of_device_id exynos_tmu_match=
[] =3D {
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, exynos_tmu_match);
> -#endif
> =20
>  static inline struct  exynos_tmu_platform_data *exynos_get_driver_data=
(
>  			struct platform_device *pdev, int id)
>  {
> -#ifdef CONFIG_OF
>  	struct  exynos_tmu_init_data *data_table;
>  	struct exynos_tmu_platform_data *tmu_data;
> -	if (pdev->dev.of_node) {
> -		const struct of_device_id *match;
> -		match =3D of_match_node(exynos_tmu_match, pdev->dev.of_node);
> -		if (!match)
> -			return NULL;
> -		data_table =3D (struct exynos_tmu_init_data *) match->data;
> -		if (!data_table || id >=3D data_table->tmu_count)
> -			return NULL;
> -		tmu_data =3D data_table->tmu_data;
> -		return (struct exynos_tmu_platform_data *) (tmu_data + id);
> -	}
> -#endif
> -	return NULL;
> +	const struct of_device_id *match;
> +
> +	match =3D of_match_node(exynos_tmu_match, pdev->dev.of_node);
> +	if (!match)
> +		return NULL;
> +	data_table =3D (struct exynos_tmu_init_data *) match->data;
> +	if (!data_table || id >=3D data_table->tmu_count)
> +		return NULL;
> +	tmu_data =3D data_table->tmu_data;
> +	return (struct exynos_tmu_platform_data *) (tmu_data + id);
>  }
> =20
>  static int exynos_map_dt_data(struct platform_device *pdev)
> @@ -532,7 +526,7 @@ static int exynos_map_dt_data(struct platform_devic=
e *pdev)
>  	struct resource res;
>  	int ret;
> =20
> -	if (!data)
> +	if (!data || !pdev->dev.of_node)
>  		return -ENODEV;
> =20
>  	/*
> @@ -754,7 +748,7 @@ static struct platform_driver exynos_tmu_driver =3D=
 {
>  		.name   =3D "exynos-tmu",
>  		.owner  =3D THIS_MODULE,
>  		.pm     =3D EXYNOS_TMU_PM,
> -		.of_match_table =3D of_match_ptr(exynos_tmu_match),
> +		.of_match_table =3D exynos_tmu_match,
>  	},
>  	.probe =3D exynos_tmu_probe,
>  	.remove	=3D exynos_tmu_remove,
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--B5jFIgrKV0bdCNF5A656ILbq7HegQ9Ndw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlIfO7wACgkQCXcVR3XQvP0HDAD/c2D8JUp1UMVX2xNNCZjdZgyW
cGhVTLFmxkJ1a+msDTQBAIejy4XZUfPP3Vkup/nco4eT1jjz3oUKiPnU06DmHImw
=WTSJ
-----END PGP SIGNATURE-----

--B5jFIgrKV0bdCNF5A656ILbq7HegQ9Ndw--
