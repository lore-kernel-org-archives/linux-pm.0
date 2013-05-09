From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH V3 04/21] thermal: exynos: Move exynos_thermal.h from
 include/* to driver/* folder
Date: Thu, 9 May 2013 09:28:24 -0400
Message-ID: <518BA478.5050706@ti.com>
References: <1367931671-3906-1-git-send-email-amit.daniel@samsung.com> <1367931671-3906-5-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2VHNWWHPDDWAUCCWJUDFM"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1367931671-3906-5-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

------enig2VHNWWHPDDWAUCCWJUDFM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Amit,

On 07-05-2013 09:00, Amit Daniel Kachhap wrote:
> This patch renames and moves  include/linux/platform_data/exynos_therma=
l.h to
> drivers/thermal/samsung/exynos_tmu.h. This file movement is needed as e=
xynos
> SOC's are not supporting non-DT based platforms. Also the rename is nee=
ded as this
> file now just contains exynos tmu driver related definations.
>=20
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_thermal_common.c    |    1 -
>  drivers/thermal/samsung/exynos_thermal_common.h    |   15 ++++++++++++=
+++
>  drivers/thermal/samsung/exynos_tmu.c               |    2 +-
>  .../thermal/samsung/exynos_tmu.h                   |   15 ------------=
---
>  4 files changed, 16 insertions(+), 17 deletions(-)
>  rename include/linux/platform_data/exynos_thermal.h =3D> drivers/therm=
al/samsung/exynos_tmu.h (88%)
>=20
> diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/=
thermal/samsung/exynos_thermal_common.c
> index 9a57606..dae5476 100644
> --- a/drivers/thermal/samsung/exynos_thermal_common.c
> +++ b/drivers/thermal/samsung/exynos_thermal_common.c
> @@ -27,7 +27,6 @@
>  #include <linux/kernel.h>
>  #include <linux/kobject.h>
>  #include <linux/mutex.h>
> -#include <linux/platform_data/exynos_thermal.h>
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
>  #include "exynos_thermal_common.h"
> diff --git a/drivers/thermal/samsung/exynos_thermal_common.h b/drivers/=
thermal/samsung/exynos_thermal_common.h
> index da2add0..1c3f8b7 100644
> --- a/drivers/thermal/samsung/exynos_thermal_common.h
> +++ b/drivers/thermal/samsung/exynos_thermal_common.h
> @@ -44,6 +44,21 @@
> =20
>  #define EXYNOS_ZONE_COUNT	3
> =20
> +/**
> + * struct freq_clip_table
> + * @freq_clip_max: maximum frequency allowed for this cooling state.
> + * @temp_level: Temperature level at which the temperature clipping wi=
ll
> + *	happen.
> + * @mask_val: cpumask of the allowed cpu's where the clipping will tak=
e place.
> + *
> + * This structure is required to be filled and passed to the
> + * cpufreq_cooling_unregister function.
> + */
> +struct freq_clip_table {
> +	unsigned int freq_clip_max;
> +	unsigned int temp_level;
> +	const struct cpumask *mask_val;
> +};
>  struct	thermal_trip_point_conf {
>  	int trip_val[MAX_TRIP_COUNT];
>  	int trip_count;
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/sam=
sung/exynos_tmu.c
> index 3de3e61..a02f2c9 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -30,10 +30,10 @@
>  #include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/platform_data/exynos_thermal.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
>  #include "exynos_thermal_common.h"
> +#include "exynos_tmu.h"
> =20
>  /* Exynos generic registers */
>  #define EXYNOS_TMU_REG_TRIMINFO		0x0
> diff --git a/include/linux/platform_data/exynos_thermal.h b/drivers/the=
rmal/samsung/exynos_tmu.h
> similarity index 88%
> rename from include/linux/platform_data/exynos_thermal.h
> rename to drivers/thermal/samsung/exynos_tmu.h
> index da7e627..342fb1f 100644
> --- a/include/linux/platform_data/exynos_thermal.h
> +++ b/drivers/thermal/samsung/exynos_tmu.h
> @@ -33,21 +33,6 @@ enum soc_type {
>  	SOC_ARCH_EXYNOS4210 =3D 1,
>  	SOC_ARCH_EXYNOS,
>  };
> -/**
> - * struct freq_clip_table
> - * @freq_clip_max: maximum frequency allowed for this cooling state.
> - * @temp_level: Temperature level at which the temperature clipping wi=
ll
> - *	happen.
> - * @mask_val: cpumask of the allowed cpu's where the clipping will tak=
e place.
> - *
> - * This structure is required to be filled and passed to the
> - * cpufreq_cooling_unregister function.
> - */
> -struct freq_clip_table {
> -	unsigned int freq_clip_max;
> -	unsigned int temp_level;
> -	const struct cpumask *mask_val;
> -};
>

You explain why you need to rename the header, and thats what you do in
this patch. On the other hand, you also move the freq_clip_table
structure definition. This change is present in this patch, I dont see
the connection with the file rename, and you also do not explain why it
is needed. Can you please consider, either split this change to other
(new) patch or explain it also in this patch?


>  /**
>   * struct exynos_tmu_platform_data
>=20



------enig2VHNWWHPDDWAUCCWJUDFM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGLpHgACgkQCXcVR3XQvP1JwAEA5BsQzeLMssZzvGiM8yGLMLLd
leYI8ohzpx+q4YbmHNYBAJqhaaf+LSP8/9itzB3cismVkHFZ+SRkqPDIm3zZoskG
=fKJ7
-----END PGP SIGNATURE-----

------enig2VHNWWHPDDWAUCCWJUDFM--
