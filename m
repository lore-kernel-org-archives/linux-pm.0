From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V7 01/12] thermal: tegra: move tegra thermal files into
 tegra directory
Date: Mon, 14 Mar 2016 11:37:37 -0700
Message-ID: <20160314183736.GA5378@localhost.localdomain>
References: <1457665763-29781-1-git-send-email-wni@nvidia.com>
 <1457665763-29781-2-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1457665763-29781-2-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2016 at 11:09:12AM +0800, Wei Ni wrote:
> Move Tegra soctherm driver to tegra directory, it's easy to maintain
> and add more new function support for Tegra platforms.
> This will also help to split soctherm driver into common parts and
> chip specific data related parts.
>=20
> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/thermal/Kconfig                                     | 12 ++-----=
-----
>  drivers/thermal/Makefile                                    |  2 +-
>  drivers/thermal/tegra/Kconfig                               | 13 +++++++=
++++++
>  drivers/thermal/tegra/Makefile                              |  1 +
>  .../thermal/{tegra_soctherm.c =3D> tegra/tegra-soctherm.c}    |  0
>  5 files changed, 17 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/thermal/tegra/Kconfig
>  create mode 100644 drivers/thermal/tegra/Makefile
>  rename drivers/thermal/{tegra_soctherm.c =3D> tegra/tegra-soctherm.c} (1=
00%)
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 8cc4ac64a91c..1802629f5051 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -254,16 +254,6 @@ config ARMADA_THERMAL
>  	  Enable this option if you want to have support for thermal management
>  	  controller present in Armada 370 and Armada XP SoC.
> =20
> -config TEGRA_SOCTHERM
> -	tristate "Tegra SOCTHERM thermal management"
> -	depends on ARCH_TEGRA
> -	help
> -	  Enable this option for integrated thermal management support on NVIDIA
> -	  Tegra124 systems-on-chip. The driver supports four thermal zones
> -	  (CPU, GPU, MEM, PLLX). Cooling devices can be bound to the thermal
> -	  zones to manage temperatures. This option is also required for the
> -	  emergency thermal reset (thermtrip) feature to function.
> -
>  config DB8500_CPUFREQ_COOLING
>  	tristate "DB8500 cpufreq cooling"
>  	depends on ARCH_U8500
> @@ -380,6 +370,8 @@ depends on ARCH_STI && OF
>  source "drivers/thermal/st/Kconfig"
>  endmenu
> =20
> +source "drivers/thermal/tegra/Kconfig"
> +
>  config QCOM_SPMI_TEMP_ALARM
>  	tristate "Qualcomm SPMI PMIC Temperature Alarm"
>  	depends on OF && SPMI && IIO
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index cfae6a654793..119e25cdcc66 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -46,5 +46,5 @@ obj-$(CONFIG_TI_SOC_THERMAL)	+=3D ti-soc-thermal/
>  obj-$(CONFIG_INT340X_THERMAL)  +=3D int340x_thermal/
>  obj-$(CONFIG_INTEL_PCH_THERMAL)	+=3D intel_pch_thermal.o
>  obj-$(CONFIG_ST_THERMAL)	+=3D st/
> -obj-$(CONFIG_TEGRA_SOCTHERM)	+=3D tegra_soctherm.o
> +obj-$(CONFIG_TEGRA_SOCTHERM)	+=3D tegra/
>  obj-$(CONFIG_HISI_THERMAL)     +=3D hisi_thermal.o
> diff --git a/drivers/thermal/tegra/Kconfig b/drivers/thermal/tegra/Kconfig
> new file mode 100644
> index 000000000000..0b719d8b629b
> --- /dev/null
> +++ b/drivers/thermal/tegra/Kconfig
> @@ -0,0 +1,13 @@
> +menu "NVIDIA Tegra thermal drivers"
> +
> +config TEGRA_SOCTHERM
> +	tristate "Tegra SOCTHERM thermal management"
> +	depends on ARCH_TEGRA

You probably want to move the depends part to the menu section, so the
menu wont appear where it shouldnt.

> +	help
> +	  Enable this option for integrated thermal management support on NVIDIA
> +	  Tegra124 systems-on-chip. The driver supports four thermal zones
> +	  (CPU, GPU, MEM, PLLX). Cooling devices can be bound to the thermal
> +	  zones to manage temperatures. This option is also required for the
> +	  emergency thermal reset (thermtrip) feature to function.
> +
> +endmenu
> diff --git a/drivers/thermal/tegra/Makefile b/drivers/thermal/tegra/Makef=
ile
> new file mode 100644
> index 000000000000..d4dc4e7f279e
> --- /dev/null
> +++ b/drivers/thermal/tegra/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_TEGRA_SOCTHERM)	+=3D tegra-soctherm.o
> diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra/teg=
ra-soctherm.c
> similarity index 100%
> rename from drivers/thermal/tegra_soctherm.c
> rename to drivers/thermal/tegra/tegra-soctherm.c
> --=20
> 1.9.1
>=20

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW5wTtAAoJEMLUO4d9pOJWC1MH/0JiNN4360xMt8PjANWiQiN0
PaI2mrq2KZz9iRx+jlQa4WF36xp0sIbT1OUaDfSHQ9MIPDr2BepCfBUqWRJ16alh
SxQoiSOZMzj0u9uMpYnZg3eM642IB7RfZWUeCnshi9mn6WS7ia1aQCJVZCoMi26H
8xdD6QQqNCOVO6KBlSHqS6LldgoRb9fG086W7vWJ5nXILDhsZf7TbSXHlH+xZd8m
Xwps3Q60KHCd3NkKxLLetCVWfl8WOmtBJg1Il+xJ8jULpNZqezvNelXWybGZBk8G
HDlpdQtYMfdMlf9doCZ5ayzbKVyRicRE8IeGfKk+b+of72G+RxNbZ5OiEptbKQs=
=WCyj
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
