From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH V4 10/30] thermal: exynos: Support thermal tripping
Date: Fri, 17 May 2013 20:56:57 +0900
Message-ID: <51961B09.6030201@samsung.com>
References: <1368525540-15034-1-git-send-email-amit.daniel@samsung.com>
 <1368525540-15034-11-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1368525540-15034-11-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com, Kukjin Kim <kgene.kim@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi, Amit
On 2013=EB=85=84 05=EC=9B=94 14=EC=9D=BC 18:58, Amit Daniel Kachhap wro=
te:

> TMU urgently sends active-high signal (thermal trip) to PMU, and ther=
mal
> tripping by hardware logic. Thermal tripping means that PMU cuts off =
the
> whole power of SoC by controlling external voltage regulator.
>=20
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c      |    8 +++++++-
>  drivers/thermal/samsung/exynos_tmu_data.c |    2 ++
>  2 files changed, 9 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/s=
amsung/exynos_tmu.c
> index 5f8f189..479d61e 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -84,6 +84,7 @@
>  #define EXYNOS_TMU_CLEAR_FALL_INT	(0x111 << 12)
>  #define EXYNOS_TMU_TRIP_MODE_SHIFT	13
>  #define EXYNOS_TMU_TRIP_MODE_MASK	0x7
> +#define EXYNOS_TMU_THERM_TRIP_EN_SHIFT	12
> =20
>  #define EXYNOS_TMU_INTEN_RISE0_SHIFT	0
>  #define EXYNOS_TMU_INTEN_RISE1_SHIFT	4
> @@ -186,7 +187,7 @@ static int exynos_tmu_initialize(struct platform_=
device *pdev)
>  {
>  	struct exynos_tmu_data *data =3D platform_get_drvdata(pdev);
>  	struct exynos_tmu_platform_data *pdata =3D data->pdata;
> -	unsigned int status, trim_info;
> +	unsigned int status, trim_info, con;
>  	unsigned int rising_threshold =3D 0, falling_threshold =3D 0;
>  	int ret =3D 0, threshold_code, i, trigger_levs =3D 0;
> =20
> @@ -251,6 +252,11 @@ static int exynos_tmu_initialize(struct platform=
_device *pdev)
>  					falling_threshold |=3D
>  						threshold_code << 8 * i;
>  			}
> +			if (pdata->trigger_type[i] !=3D HW_TRIP)
> +				continue;


As you know, HW trip can be used when only the most last level of thres=
hold
temperature is set. (exynos4412 : 4th, exynos 5440 : 5th threshold leve=
l). So it
wouldn't work properly, even if we enable HW trip according to pre-defi=
ned
trigger type not to HW trip threshold temperature. To enable HW trip, w=
e just
need to check whether if HW trip threshold temperature level is defined=
=2E

if (trigger_level[HW_TRIP_LEVEL])
	enable HW trip

Thanks,
Jonghwa

> +			con =3D readl(data->base + EXYNOS_TMU_REG_CONTROL);
> +			con |=3D (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
> +			writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
>  		}
> =20
>  		writel(rising_threshold,
> diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/ther=
mal/samsung/exynos_tmu_data.c
> index ee6a3c9..6b937f5 100644
> --- a/drivers/thermal/samsung/exynos_tmu_data.c
> +++ b/drivers/thermal/samsung/exynos_tmu_data.c
> @@ -64,6 +64,7 @@ struct exynos_tmu_platform_data const exynos5250_de=
fault_tmu_data =3D {
>  	.trigger_levels[0] =3D 85,
>  	.trigger_levels[1] =3D 103,
>  	.trigger_levels[2] =3D 110,
> +	.trigger_levels[3] =3D 120,
>  	.trigger_enable[0] =3D 1,
>  	.trigger_enable[1] =3D 1,
>  	.trigger_enable[2] =3D 1,
> @@ -71,6 +72,7 @@ struct exynos_tmu_platform_data const exynos5250_de=
fault_tmu_data =3D {
>  	.trigger_type[0] =3D 0,
>  	.trigger_type[1] =3D 0,
>  	.trigger_type[2] =3D 1,
> +	.trigger_type[3] =3D 2,
>  	.gain =3D 8,
>  	.reference_voltage =3D 16,
>  	.noise_cancel_mode =3D 4,
